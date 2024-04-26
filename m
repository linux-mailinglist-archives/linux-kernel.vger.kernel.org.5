Return-Path: <linux-kernel+bounces-159878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EDA8B3562
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5845D1F2108D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A2B143C67;
	Fri, 26 Apr 2024 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Idlk+TTj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1DA78C7F;
	Fri, 26 Apr 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714127791; cv=none; b=ecoK+Cim7de/tj4cdlf+aCHw4Z+Ru0J80lcvCMKFOtgZBESrgmnciA3S0pe5FpF96rmOt186D93+ne65ye54sqzsjUI2STvr1x9S9eGSJjRP24fOBSTj6QhbSi+XFyseI7yokQD9mcB8awL7D9cERo4bipcdfXP34Et2J4l0vnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714127791; c=relaxed/simple;
	bh=9SRmazc0sydRrkTKpAFs+eEebaVgtgtqfbCU0W7qu/I=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=L2ee+GD9SQTIaLc9FIWJu4ViPXXLWrJ1OZC34WfFgDpuUXEhNnn+9FxkObQloNZOl1mNs7cDU6lOHWJTOIt5tGtIP9bwsu1aKKsQupcTxZg85yvjvraWaeuXPTPCqb5htFvTAG2AMh3dsXctwxfiQWZ1ZG1cnYHg+yEQHY9WxjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Idlk+TTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5064BC113CD;
	Fri, 26 Apr 2024 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714127790;
	bh=9SRmazc0sydRrkTKpAFs+eEebaVgtgtqfbCU0W7qu/I=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Idlk+TTjC4uYpUWB6BEnSgcrGygwsw4xsVymzKMIF8v5Q7msc9NfLbZOJfaRy6b06
	 guO219l9mpk/L2ZODQdmRuGJcIYKwwSin5y2NJ3q1Cptglw+SsqKZbZy5Bo4QOQ2YQ
	 8e4rOAQ1Poizixy0RI+wIShB6eqwMXDmUWMB26kJ+43rW1etM1atQs5IuTYMHROv85
	 dxLaUqsPML7INnrZ4t640AajUH87GMNfD2iCx38dmLCwEddDmCZ7tz6mjHIOmQWCn/
	 G5h1ij4gSZRHTgdRtLu8K4XgKabzqUkZi0ncQQ8ogIz11KxZpUq7L2Zcj9+n4hCu1/
	 jDv7bwqQ2vf2A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: remove unused brcmf_usb_image struct
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <23afd8c1733ad087ce2399a07a30d689aef861d5.1714039373.git.christophe.jaillet@wanadoo.fr>
References: 
 <23afd8c1733ad087ce2399a07a30d689aef861d5.1714039373.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171412778627.3463676.18140918755417297284.kvalo@kernel.org>
Date: Fri, 26 Apr 2024 10:36:28 +0000 (UTC)

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> struct brcmf_usb_image was added in the initial commit 71bb244ba2fd5
> ("brcm80211: fmac: add USB support for bcm43235/6/8 chipsets") and updated
> in commit 803599d40418 ("brcmfmac: store usb fw images in local linked
> list.")
> 
> Its only usage was removed in commit 52f98a57d8c1 ("brcmfmac: remove
> firmware list from USB driver").
> 
> Remove the structure definition now. This saves a few lines of code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

cc1380dd1882 wifi: brcmfmac: remove unused brcmf_usb_image struct

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/23afd8c1733ad087ce2399a07a30d689aef861d5.1714039373.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


