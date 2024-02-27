Return-Path: <linux-kernel+bounces-83287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F70186914E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B99286613
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0B313AA5A;
	Tue, 27 Feb 2024 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Cg4NfOZ0"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB013AA45;
	Tue, 27 Feb 2024 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039125; cv=none; b=LbZrF1KXn6qFfIHhGPhu39+8VAMH/9+12QNf9S/dsxF1n03m6vr17ZTpqdeN0IYkC+gLXIQD7hP0rIO4CUFAXx9RbO2+INRGTjealOMa8Eez1i16i4uKiM6BExn9k2798PR2yc3b+2tfJbzlKbvmZeT/JTTX5fDZlob4pSBA8a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039125; c=relaxed/simple;
	bh=eOPhigOJczbuwsV584EKmBiN7JFDGME1qn3xvfIPaXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDOmAUp0jqbA8WbjCgQ0r34i2PI4JSy0PHqECDF/8bae06CRGwCC5tp75Fvq705W756dS78uHx5nJ32ULDktWGMOwEm1cstNGh1GANjUrSNHO4iV9I1Ew42zcIG2vTAawtlmNzXXb/MLuF7YuQCHMRMvW6tgTBFy+dZd25D978U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Cg4NfOZ0; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=ZgGnPyp+t6CDuIJOxG2eFF8f52fwW7PChDnQXlWlBiU=;
	t=1709039123; x=1709471123; b=Cg4NfOZ07MPQPcntNyUtqqPnhm2nUjyCsrerychcHi96f0n
	xLxjMW5e+JM87f2dDIc1fBO7nRbGXeUroRebLkW/RpzaI7EWEMqpvRRICYjHTGgQXyuQzrmA7TI//
	qH+pvsHzxuTkJv9kh6Ft0QTNZXo4HOq0c5IvFZ/iQIQZlaRxK+H23RLfuuR/H4/bs9jxN1uHuFuNM
	FJwSO8cp0yAt+MEfHoG3iAhktnHaOyWJQlu/IumhGgPpxQESPSdfi4ZWTv+ao42qFtujly9e6V2cv
	iOXzZ7vGF49D731UC4BStppr5aqedYkml0CxsSVZJ1mb+0jyNcahMYegEc2+dP/A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rex96-0008H6-RV; Tue, 27 Feb 2024 14:05:20 +0100
Message-ID: <8c444bff-99ae-410a-9c8f-96ec6d3ae2e3@leemhuis.info>
Date: Tue, 27 Feb 2024 14:05:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/msm: VT console DisplayPort regression in 6.8-rc1
Content-Language: en-US, de-DE
To: Johan Hovold <johan@kernel.org>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <Zd3YPGmrprxv-N-O@hovoldconsulting.com>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Zd3YPGmrprxv-N-O@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709039123;f703608c;
X-HE-SMSGID: 1rex96-0008H6-RV

[send with a reduced set of recipients, we all get enough mail already]

On 27.02.24 13:40, Johan Hovold wrote:
> 
> Since 6.8-rc1 the VT console is no longer mirrored on an external
> display on coldplug or hotplug on the Lenovo ThinkPad X13s.
>

Thx for the report!

> I've previously reported this here:
> 
> 	https://gitlab.freedesktop.org/drm/msm/-/issues/50

Then let's tell regzbot about is as well, in case the ticket comes back
to life now:

#regzbot duplicate: https://gitlab.freedesktop.org/drm/msm/-/issues/50

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

