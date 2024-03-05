Return-Path: <linux-kernel+bounces-91955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D568718FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABD31F2405F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E94B5490B;
	Tue,  5 Mar 2024 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Esfl9NEy";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="yKdd4U6n"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDD050A60;
	Tue,  5 Mar 2024 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629542; cv=none; b=A4IKrjKvu6lm3teLHtoohqMeU7Blk4ZD51w2BhA5DCr5+vrNUk3QDF67/Vc3FuwqwZrI5xGG5TF1ozJFrdFMRSeDwu6BC8Qgu2KvCox8LTQPf/KI3gkRzpQnzoJuCszshmMbfHyO0are4/EPS3L8O3iQdI2GbrqkYT3g1Mj2a/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629542; c=relaxed/simple;
	bh=ohU9B1DK5+V+unoDo0qv6/ju2Tlc2qHsEeZXLDc3RqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxDnr0aUSntVX1oqqVcfyOkYV/Rc99+7DFz3DiSVEM9tOZbOIVMOPsRfRTD6hIGrlgITpQCYUg6b8ucbD5y9uxjbdB63MlDsmXZJ6LqLcXnjz4CNwBS2Uyzu8GEMwj5GydZx8M142DN1C0AMCFKM/NGH2cZhi4OJ7JIkN4zMQ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Esfl9NEy; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=yKdd4U6n; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 56C9EC023; Tue,  5 Mar 2024 10:05:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709629536; bh=TXA46+0MVcnuaVTMDKqrMYonAbd7/DorbREk8+b3k1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Esfl9NEy6PEPH2Ad76DT7XnDdCIW8lGP2AaydXuzWJZ//SgsgMwOdOYFpH4lA6hO7
	 ix8U2FtcmJWBFmGmaEGlPy5lXFsFsP+3Z/51FmMkSw7VVEDcY7MkPT6/rp7VuLuZpR
	 rS+5yhFIoot3J26HPqiqjr1g0VSjcg/j2v1MTC6lNH+mAAeRWA6ADnqsz4toJ9tFRt
	 qel9P4Bv53Zase0pBNC1sI4/XHBz9SjDpWRr/1Rphzcsk2N5j2S1ldtczjUD1it38r
	 kCoeAYKJVrML75nHmhO9+ZZ/Hog7uXwZvin4ttTEBew/30vj4/Bs39j4L+DIe8l2O+
	 RK8U9AcnURlGw==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id A6EA8C009;
	Tue,  5 Mar 2024 10:05:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709629534; bh=TXA46+0MVcnuaVTMDKqrMYonAbd7/DorbREk8+b3k1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yKdd4U6nWZRKpzI3kGIhpbCN3vRN8kFwDd5GS0xmzGeeSxyKuEkqtNAtUbOgh+1y+
	 ZNU2QEpX0dZK+jQEzU7dMDzXVb46D7nr+EywulbuISmdWA+oZe88h8VJ0rAnslx9WW
	 AdYUM2JynDrD9z7gaP7eoa+xKljVMuYVkm9CG2wDiJjAbIsYKWK+7EW1rwvSCHWVGE
	 TtjGRNpU3yFkNqqBrI49gAOr+xVLfJ4MKw+vRgXQKpL0ygy9IknuCcDbj/C5Cmgwcp
	 AJagY+FjqLrkBIVKper3ykf4N/WuHamh/MxmnRCv26JYJE8XRhg+xaZjD4uhCyOhQD
	 yi2FR/i9FvvTw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 7106c589;
	Tue, 5 Mar 2024 09:05:19 +0000 (UTC)
Date: Tue, 5 Mar 2024 18:05:04 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 00/42] 5.10.212-rc1 review
Message-ID: <ZebgQDAotbvxSg-l@codewreck.org>
References: <20240304211537.631764077@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240304211537.631764077@linuxfoundation.org>

Greg Kroah-Hartman wrote on Mon, Mar 04, 2024 at 09:23:27PM +0000:
> This is the start of the stable review cycle for the 5.10.212 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.212-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 4b0abedc88b0 ("Linux 5.10.212-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

For some reason the wlan interface didn't come up on the arm32 board
(brcmfmac brought up through usb, mainline driver), which is something I
hadn't observed before, but I've just rebooted a dozen of times and it's
always been up after that *and* I don't see anything in this stable
release that sounds like it could be related so I'll blame it on a
glitch to look further into, and not something related...
(I'll report back again if I find something more convincing, trying to
get a second occurence at least... if I can reproduce I'll confirm it
reproduce on 5.10.211 first then keep digging but it looks like that'll
take a while)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>


Thanks,
-- 
Dominique

