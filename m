Return-Path: <linux-kernel+bounces-67639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E523D856E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCDA286E82
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBF913AA39;
	Thu, 15 Feb 2024 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluemarch.art header.i=@bluemarch.art header.b="NdWqEBAj"
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C464C41A81;
	Thu, 15 Feb 2024 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027979; cv=none; b=r7hmyBSLtn/d7rLGbV1x6Rf09kvLnz5mMWbDFX54mMcQouiJE9d3sbI4uR7un0+NFOoZhgjjao+dR9cTXZsgu2jtMJcAZLbQwltAQhkmtZTVoVwG65MZrQSW0jsQWPM+vT2DvmTIg2F0HbNqn7t90SIL3rSbrBW0Mq+g4yaYM4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027979; c=relaxed/simple;
	bh=LOfUt/+1WPS9cSbJx/uVyM81LWxCL1/3bgci8HbBfpY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqy9HyTg9jEpIAqVOL3pZni5ex/3UX1+pnzsAvFppewP2cPhi5i4UALoa47GKpBXePVsVZFebJ6DWNkEflA8vxckG4dCmLydd07Uox44FG0yBXVLg5sszKHT+QdG1CQeWO9O95PUywRGlugZ/q7V+Qi7YSK8OTEZJ0SRi3IVVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bluemarch.art; spf=pass smtp.mailfrom=bluemarch.art; dkim=pass (2048-bit key) header.d=bluemarch.art header.i=@bluemarch.art header.b=NdWqEBAj; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bluemarch.art
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bluemarch.art
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bluemarch.art;
	s=protonmail; t=1708027965; x=1708287165;
	bh=LOfUt/+1WPS9cSbJx/uVyM81LWxCL1/3bgci8HbBfpY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NdWqEBAjFoBshdmijvSqJK47SXSyGszhUAfDpDVYDUpGMJOe67Znp2D6ko1yodczi
	 Jal7fMjBY24uGUZm9Sr15t6PJA3bQ0UOKRfPmze+YyC4Qi+OKzk+GF/NCHw07rskUu
	 1soqBLgSJsPBkP0T23VvFNqCPXmKz3V7gkxP6P4oJRzkL0iqAEeTnc7c1xf7PjkRcF
	 53CM7zU7dlotWReRgg0OSxWWlrXCOQzlAWZo48FysjR5d7y61WkWC4gFo4J8tfdx2/
	 CLZRh4DBMcb+xCwS0r3QKl6LwlbZRNeualqNvRJzAtjcZBBBvaIrYPlglB+acz9g/j
	 LXv5OTxLwWx8Q==
Date: Thu, 15 Feb 2024 20:12:29 +0000
To: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: Szilard Fabian <szfabian@bluemarch.art>
Cc: W_Armin@gmx.de, hdegoede@redhat.com, jwoithe@just42.net, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [RFC PATCH v3] platform/x86/fujitsu-laptop: Add battery charge control support
Message-ID: <Zc5wIViz3d8sBLHP@bluemarch.art>
In-Reply-To: <43960922-d6bb-e5f6-2156-f1b35142244a@linux.intel.com>
References: <20240129163502.161409-2-szfabian@bluemarch.art> <20240129175714.164326-2-szfabian@bluemarch.art> <20240207023031.56805-2-szfabian@bluemarch.art> <43960922-d6bb-e5f6-2156-f1b35142244a@linux.intel.com>
Feedback-ID: 87830438:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 15, 2024 at 12:34:00PM +0100, Ilpo J=C3=A4rvinen wrote:
> Why is this posted as RFC?
It's my third patch into the Linux kernel (the first two being a i8042 quir=
k
table related patch) and I was not sure if everything is okay with v1/v2.
But it looks like the patch matured enough in v3 to reach it's near final
form and there was not too much to comment anymore. Sorry for any
inconvenience I've caused with that.

Thanks for your feedback. I'll post v4 in a moment.

Regards,
Szilard



