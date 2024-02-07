Return-Path: <linux-kernel+bounces-57302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF60284D6C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823A81F23E73
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB72535CF;
	Wed,  7 Feb 2024 23:49:16 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D3B535B4;
	Wed,  7 Feb 2024 23:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707349755; cv=none; b=eh7ZM8ShDHfvqfb9YEytwtETDjMeotHprNziOCWJTijDDQhGjmqkm2lHbNlahnz0imr9CGadBaSFmKQ6IHo5gcIoKRDhktY8o3kbADVP/e7aQrn7ZOB5xMeP8kmQWFPLAKx2IMwNY37m/SF4DJsAnkxRvVFLvikpJISqmB983XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707349755; c=relaxed/simple;
	bh=byES4n0K3so3aUygYY5m0e3z3k70nM326q/F378hiBQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gNbhfb0nBUwVvoqXtWVl7+mYxuSmZH3pKG8VSyh6TtDsXeg6xJOL1wTHBvORdn2gltbMdT9X40Suy/bHzE6/3d+zSCeIXWuwE4IL4fVXNKveIXHVtmnAW7QSt3JBhHRGwrvr2vJ0dYtxABwPDP5WBTcvbBiu9UyZIKp/BI73O9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b69e54.dsl.pool.telekom.hu [::ffff:81.182.158.84])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000074519.0000000065C416F7.001B05BA; Thu, 08 Feb 2024 00:49:11 +0100
Message-ID: <b762e167bb15c8dca954ba4bea4a27e06a019a9d.camel@irl.hu>
Subject: Re: [PATCH v3] ASoC: tas2781: remove unused acpi_subysystem_id
From: Gergo Koteles <soyer@irl.hu>
To: Mark Brown <broonie@kernel.org>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
  linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, stable@vger.kernel.org
Date: Thu, 08 Feb 2024 00:49:10 +0100
In-Reply-To: <ZcNWcqYEmUjtusfe@finisterre.sirena.org.uk>
References: 
	<df5c94396256e9573b772962182def52d20c50d4.1707250969.git.soyer@irl.hu>
	 <7f056a4148fec176812ff6cc490860bf565b161c.1707255917.git.soyer@irl.hu>
	 <ZcNWcqYEmUjtusfe@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Mark,

On Wed, 2024-02-07 at 10:07 +0000, Mark Brown wrote:
> On Tue, Feb 06, 2024 at 10:49:29PM +0100, Gergo Koteles wrote:
> > The acpi_subysystem_id is only written and freed, not read, so
> > unnecessary.
>=20
> Please don't send new patches in reply to old patches or serieses, this
> makes it harder for both people and tools to understand what is going
> on - it can bury things in mailboxes and make it difficult to keep track
> of what current patches are, both for the new patches and the old ones.

Alright. I read somewhere once.
Sorry for the noise.

thanks,
Gergo


