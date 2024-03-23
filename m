Return-Path: <linux-kernel+bounces-112423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FC788799E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A11DB212B7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E88750271;
	Sat, 23 Mar 2024 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="vISGMa9w"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F46645024;
	Sat, 23 Mar 2024 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711213811; cv=none; b=qHWPXftZGi7vvY2qOg7kGSybceuJ6qR9iOw+3HERS58hOk2TgUz4xjejU8Uzm3P4Plpwxfn4wpZBRuBfOxS9xZnsVXW9baRjXuZi1zpp/H2Z242o3ySRo+Co79eINQ0n9/VbEihcgXIkceLdIgf8+hXo37wIEsCXaLO9qbEln+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711213811; c=relaxed/simple;
	bh=7VEZb6OXfUhwb49Zlua11SbxKGPAb749J6P7Tp8Msoc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Zu9j5QdG8oxIRUd+IfBIdrToDFTGKAnzbCvchHHq40d2oBk53G8e0VsiQ/eBjeP9NmD+FFA84efw4S8GjhCad9TS0VOu+FeWaY5Et5ZiRyCmwXCPe8Moed5KD9eFJ0uOA3Z9Ho0DIo9wadRNfZcM78GdM5aPj0g9BnZtKkctgsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=vISGMa9w; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711213800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0eHI8gPfhhX3F5QO2ZA3NGpG2HvwIK1Qt0n+b4djt8=;
	b=vISGMa9wHSqhPT6RZl65/F9Alj5nX0JjQL2hq1lt2ZaUBmsvt7YrlxX/bBlBnXEPyiaK1Z
	D000E/z6hFhKib/0RjQXyo8CkWaaVuhBPNNRdjp17rAixV7iyTYDD89FcUQuXWZM2exFBb
	4/0lgjfayF3tucwMlYMhblWuphqxZMaM3KO7DiflIitOXgJqyDkJlbv81uotKZ9GY3shDN
	UnlnHN9A0bafj4NvDMgL6KkP1mRKhXaSdaRB48EKc6l1fkH3Nr/nCVhjri77Lvl1ZL7tle
	JlPT7R1G74sV+BJUdKTTgiUTd/uZhLJ+atX0Q5pkywtcixBiFyIVDNkqHceMsQ==
Date: Sat, 23 Mar 2024 18:09:59 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Pratham Patel <prathampatel@thefossguy.com>
Cc: sebastian.reichel@collabora.com, saravanak@google.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: Fixing the devicetree of Rock 5 Model B (and possibly others)
In-Reply-To: <tQ0L3-34g4t-mzfQIP6KDe5OYelGnEo6Udzq6Kb_nEcljppSQUXOktpE__nL-CdLOu9gW-4tIIbjtSbqrdCrjEkdhZLPiiHTqRcCB6WORuM=@thefossguy.com>
References: <tQ0L3-34g4t-mzfQIP6KDe5OYelGnEo6Udzq6Kb_nEcljppSQUXOktpE__nL-CdLOu9gW-4tIIbjtSbqrdCrjEkdhZLPiiHTqRcCB6WORuM=@thefossguy.com>
Message-ID: <ac4246bf3786230eb9ca85b329e7d0df@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Pratham,

On 2024-03-23 18:02, Pratham Patel wrote:
> Since the introduction of the `of: property: fw_devlink: Fix stupid
> bug in remote-endpoint parsing` patch, an issue with the device-tree
> of the Rock 5 Model B has been detected. All the stable kernels (6.7.y
> and 6.8.y) work on the Orange Pi 5, which has the Rockchip RK3588S SoC
> (same as the RK3588, but less I/O basically). So, being an owner of
> only two SBCs which use the RK3588* SoC, it appears that the Rock 5
> Model B's DT is incorrect.
> 
> I looked at the patch and tried several things, neither resulted in
> anything that would point me to the core issue. Then I tried this:

Could you, please, clarify a bit what's the actual issue you're
experiencing on your Rock 5B?

> ```
> $ grep -C 3 remote-endpoint 
> arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> 
>                 port {
>                         es8316_p0_0: endpoint {
>                                 remote-endpoint = <&i2s0_8ch_p0_0>;
>                         };
>                 };
>         };
> --
>                 i2s0_8ch_p0_0: endpoint {
>                         dai-format = "i2s";
>                         mclk-fs = <256>;
>                         remote-endpoint = <&es8316_p0_0>;
>                 };
>         };
> };
> ```
> 
> So, from a cursory look, the issue seems to be related to either the
> DT node for the audio codec or related to the es8316's binding itself.
> Though I doubt that the later is the issue because if that were the
> issue, _someone_ with a Pine64 Pinebook Pro would've raised alarms. So
> far, this seems to be related to the `rk3588-rock-5b.dts` and possibly
> with the `rk3588s-rock-5a.dts` too.
> 
> I would **love** to help but I'm afraid I device-trees are not
> something that I am at-all familiar with. That said, I am open to
> methods of debugging this issue to provide a fix myself.
> 
> I would have replied to the patch's link but unfortunately, I haven't
> yet setup neomutt and my email provider's web UI doesn't have a
> [straightforward] way to reply using the 'In-Reply-To' header, hence a
> new thread. Apologies for the inconvenience caused.
> 
>   -- Pratham Patel
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

