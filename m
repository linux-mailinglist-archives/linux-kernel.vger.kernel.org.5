Return-Path: <linux-kernel+bounces-91680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F258714F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1216F280FCB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAAF40BE5;
	Tue,  5 Mar 2024 04:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="SrTp5ifs"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592129CE7;
	Tue,  5 Mar 2024 04:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614029; cv=none; b=rMe/S+ltoFXkuQeVwDd4bbsuN0o6rXLwMlivXS1VT3/b42PipNgaM8JbYzKDvVquNEPFPm0Yb5S0v8j/XVCOycA0FFfSP08aVK5vROZT/zBy8hhvg8dpJg1hToY5f+SK2EcvugV/ivtkzR0X2gJs55aPMcG7/tZ9phaHIyxcifM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614029; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=V9l4YG3MGJvu+PUW5pyXZJiym8qVyD9KlLLf7V1hDddu/EPB1OdTB7JiBoefOq2DnfNFlam23oRN5cPod0tMHM6EsdYW/S8ChNCYtsS/VVANU/grZNpqwWlt8esKwJjwvsxYqK4U7gRSOTWo7OHFCbAaA+9Gi9mIFFkfAwnV6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=SrTp5ifs; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709614024; x=1710218824; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=SrTp5ifs5/Qge3kxJXFIbXp5Al+boGi52kIF4BsAfdCEHAmdyHlav5ln/b0REPeI
	 rUtyWFZRegr/i9lCqYhYHqwwOIwDGUYr5K9mtr7THslfhTWucP0OXjRpizB3W/LnB
	 uesIEF1NnTKDpdRWkCZRQyuzl/VSbjdg78kRmHD1vPk0jX329RPj69SiMRGhYfgPL
	 49JWZiR2s06gnCCZwer/mopqQbaqLzIJulRIeBbAB9XpFlMuTEDUqlx/J8ewS4y/R
	 zrHm7Gx9xhfIxlgfFRgElANp1PCMIX4xodz9XA3XqTOp2hvkhdLjz7Y37j/4ksOcj
	 WSJeZHVOoNHmmeLZdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.27]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Jn-1rCiin1l3Z-00e1Md; Tue, 05
 Mar 2024 05:47:04 +0100
Message-ID: <29f2c4dd-d26f-4af1-a419-2c783f7b3ca1@gmx.de>
Date: Tue, 5 Mar 2024 05:47:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.7 000/162] 6.7.9-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Ep7IKWatdrhowZwIiXhSSs4v22wewz9akVFDY7/dbOPd+byHTFX
 rhvPsK0YxIS350kqsnIPWZIJSB7Yf3/Xu9V+7eWu7n3uBAHTkMuNzYjBbMu24Rq14TuDtl6
 /Q9LgBXat1KiWaRRgRd8zBI8tGrajK+aX+VYciuVkTGFEZ1birWU1KldFxcCeWHG3ZRaCwe
 xCpZdZDdgnpMFgHzk3fQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S72YLJ8hEN4=;s7M+6BfXVv5DKti6mAJunAJEi0D
 aQrm1CLf7HA5R8kqGI3bvB+2DTV9lr5hGEdOV9A99qNTLwcNdCIRO9h1h7JCZ6ihKdVFC9Pe+
 Uo/fklSz3MImXqbV17rr3BP7495mDaDpXTvxMpXZ3wEdBPzYsgdQWGrMfmoqV/Aa3nRMuwbt/
 SHD5zh2loFiqAhMEAjLiyDcyZ9u4YVxqdASeEFptf4l1jZRTJSRKivIac8MzjsR3M+ukZqwWH
 KOuw241TEDp7f3rGP03L3ln25euwYBh86HGj9Dped/GS5kzpi0xtax0e6HeGBiopcbKBogHuu
 XpVuVENh3iDEyk6cZOsBAyg7py/aUIVN89o5UkKVBCNUmqlg9EFxoOLemtj+GPwcFz3wxG+kQ
 NSxgqRpPzVQKWguC+wIeY2adL2xRqMljMFaOfcIcqhCwk7OdvH4ydJl1uFUBHFMiUy1PrUwB+
 I32pf5zL72NCYekazKHMDL6Gh7EshWYNYwPBylikZBaEGs40Pdd3Iy0CV3/k/JhxaTQsZ8Ab2
 fOZQcssEW0ICP2BVTH5RXd2IW3EdXOJebmUoVoMAC0R/vXXX9F2SFMJfQbQvo+ycxq1r5nC1V
 NOq3BbZWjX6VO9XGE+ZQeVT+kw3bTl9zGh2GItnLUfE/JjMMyKJ0/6Gxbd2liocfxzlxhl0Ce
 2rubjyu25ehi24U/y563uFWB6dMqrIFmbxzg/p0+NuOVYZK12jFam0O56MoqnqCryeizaN8o4
 3OGAliUTN6CL0bP76oHhfAM1AjZbNJ6BU7UW/3qMlcOCTqbB3OqqbxoJE25yyhL6lRD6Dnzcv
 KuvnuLbJ1UddqH/Qo7DUT3KxASOtZFsSFtJ9di9igxgaE=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


