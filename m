Return-Path: <linux-kernel+bounces-33873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16939836FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9DA1C22007
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133074E1CC;
	Mon, 22 Jan 2024 17:53:49 +0000 (UTC)
Received: from abrecht.li (75-128-16-94.static.cable.fcom.ch [94.16.128.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6A44F201;
	Mon, 22 Jan 2024 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.16.128.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946028; cv=none; b=uMNEI42JE2H7Zu9gz2kYwigcQdEveLK0o8FqZ0sIhP1c0fR3fwwgRe/gsF4qSzWmaLDT8sHVcx/cPSfUoqf7uU2QIHPCFE+7m6BuMR1UBwKxoqCk6d22zQewD/j/MLe5NKOq0btDrkaC4nRlFyodcHB74MDzPEf49C/MKCZExjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946028; c=relaxed/simple;
	bh=MS+usYHqIFe+mQvkXUp3rrEmu5yhwLRfK6rfrQOCPpM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kwdatplhQ0FHYB/i3cOlMN9QVTK0FieYr0kscPVDwyZlVN8PhHy9n+WthLDoBzqmUHX7oRWON6ydMAuZrdC816SvxFQ5vwMbl9ruvj0wfffWK0DSQ2nfWhsunqRB8Yui2QH0wuhxEkLxwHa/xq/qTPyeMHMPhCX0C0iI4YS/kTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nodmarc.danielabrecht.ch; spf=pass smtp.mailfrom=nodmarc.danielabrecht.ch; arc=none smtp.client-ip=94.16.128.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nodmarc.danielabrecht.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nodmarc.danielabrecht.ch
DKIM-Filter: OpenDKIM Filter v2.11.0 abrecht.li 71223276322E
Received: from toucan.dmz.abrecht.li (unknown [IPv6:fc00:4::a3c:111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by abrecht.li (Postfix) with ESMTPSA id 71223276322E;
	Mon, 22 Jan 2024 17:53:42 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jan 2024 18:53:42 +0100
From: Daniel Abrecht <linux-sound@nodmarc.danielabrecht.ch>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: soc-core.c: Add "Unknown" and "Unknown Product"
 to dmi_blacklist
In-Reply-To: <e90440a5-587b-48b2-a61f-0800aa8200d5@sirena.org.uk>
References: <7d11d0711ad93f2208efb9ab13fe915b@abrecht.li>
 <e90440a5-587b-48b2-a61f-0800aa8200d5@sirena.org.uk>
Message-ID: <83d18087378efb6b6f1133573719ca57@nodmarc.danielabrecht.ch>
X-Sender: linux-sound@nodmarc.danielabrecht.ch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am 2024-01-22 16:30, schrieb Mark Brown:
> On Wed, Jan 17, 2024 at 02:44:43PM +0100, Daniel Abrecht wrote:
>> In U-Boot, the default for DMI vendor / product if not set is "Unknown" and
>> "Unknown Product".
>> See https://source.denx.de/u-boot/u-boot/-/blob/v2023.10/lib/smbios.c?ref_type=tags#L272
> 
> This is still corrupted according to git am unfortunately.  I can't
> immediately spot the issue.

The v3 I sent applies just fine with "git am" as far as I can tell. I just tested it again with the mail form the list.
I think the v3 patch is fine, but this time, the v3 message ended up with the same message ID as the v2 message.
Because of this, some mail clients may get confused, and the threading in mail clients is going to be broken.

