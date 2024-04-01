Return-Path: <linux-kernel+bounces-126898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53352894424
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E720F1F23ED9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783504C602;
	Mon,  1 Apr 2024 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="M4z9E9VL"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F094AEC3;
	Mon,  1 Apr 2024 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991872; cv=none; b=UcLZbL4n1YMsZHa2LMrVd2MHVhFI+Mjda3kxPXFFZg180r1DvdThkM11PvKsuvaObK35BAA/33UuftGlQXQw4zx8gu0xTxSaUyvE92zSgvC5pngdHOiWFAjjldvPnmGIzPYScjGiV9bUjjJGRrLEu9yZzrt8OzTiNpZ//DObfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991872; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=m3ZFACCgklpCCe7EBesUa2un1+NWQps60GlObZFk4Q47X2nbL+sPqZMkpLMOLHBH4ZHyjWDRyEIYshMFSTK43krTkAy+3wN3MXFS1C/cCExTb9YS78Y0TKkV8+Rwk0RmONkMVsJh1skpg1uRS76y3G+fvvsCI02AxXT/VC7w7yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=M4z9E9VL; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711991868; x=1712596668; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=M4z9E9VLxvPdBzm6z28MHUwkS8dpe9so9VDXd5iFXIN10SYitVlyWB8DyCb57mUn
	 kMsjSymBzaufWDm8jaKOILVa2D2exiS6cAMM7JxGrPGIPUevxJ4kpiA4CrdHfCqwR
	 F0bdhjSISD8E4n8OQh2cQ63uJN5RvL+x08iDHJpyKpAutHVhvUn1edGEA2MYRFtQf
	 esbo1HUXxJ5BNv/9GewFiB2P9eJ6siAS+W+BX519HkI4jRyJ3YAZ9vobNGulnv0E1
	 DPilnaX4fMdkWweRR+kMgfQlrBUUweeEOuxLqQEMFZXTjwUTj6mH+Q3RFyiSZRvJK
	 7WpfcxCmdusUQKo8tQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.244]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ3n-1sNQUQ47hF-00WG7y; Mon, 01
 Apr 2024 19:17:48 +0200
Message-ID: <696f6729-553c-4174-9856-9ec74078ddce@gmx.de>
Date: Mon, 1 Apr 2024 19:17:47 +0200
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
Subject: Re: [PATCH 6.8 000/399] 6.8.3-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xkIAcyrO5PfImxFqqzJ7V5umtbsi7dWYYC7CR4tYwSK81FZV+7t
 aM6cLqtBOJOmCkSlWJW5QQdreeu65hrr6nGaazAhKA4BoA3Co6aNCLbdArv/txYLeGv3WAV
 WPyMhdlaD5zoHWm42zfKP8wmgbGLdHhMm5CWr9Cc+TrqUxsM02Y1So/ziYgFPB1OBFAE6xu
 kdMIVPjmyCZadO6aqRCnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LBs1RXI6p/w=;aMocLxlPVQBWzBzWluQOni3PH9e
 S2djmnDUKULVY2iGLrzbnkUEfCGWY3gxWoDwi4ccAtnt5RCDqgXhV0c2yvDNI+zCHm0v/mE0d
 IwPzitoqTbg7xKx/g3+017TDc9v7Cva5Jm5R6ZM/dyJAdqudyjINgSjdXUfRPzfywlfORVmqU
 2sG5cwENNSutNdIUUOJFMiAbe5lxL7ZKkZnHfdcjGjqC1XjqZQn+HcfW9vr++F06BNbbia5n/
 5j3f1AV6OK7fd2aLVLfEqz93Q2l1pwTcUDpiwuZwN+Sxd3DdFYm9DVbMbOw3uzYZZ6sWvfEfW
 F1pBURriLv09YY+aeU93ZbGMII18uTcAep3o9wywirkwCCf/tGamZRPvjLlm3VnVStJYoZZlZ
 +HJfulWmvP5bp8uqF/kLJUSeBPWgpuoRjXOIXvVIRKn3krQ/c6Oh5lhWSEIvgPMuWgT5JayRk
 xDpJDginE3FH+iA2AuhhXys5lXC2HuaeAgN+/StIdfQLkbT0VGSquJ7e2gRO9lGgOyu5L7CA6
 E9LaqOjBsXMtDYDqyLuwevkx7JBu1Z9CdzOQVkNOvg54DeAaqe7syOlBnAcOyt5/XgMTLZTri
 zYm7GncZGjzdes18IZ3Z77UplJfa47L04aql3/VeUmwYS9l+2/jmfCTkmdMWYAmuIqs9WTey0
 DzMiZnbdwZltwSrlenOVpccAQeZVYKekrrp+m1Bn7+onqFA5CVnXGiNTBCBiOo+Ee4sicDXr2
 cLpZUWBKtL6/HYT+7g93g7UaKuGttQvk3Pr1Md/I4rZX01P/nxTIAYw1nyxvSRG4Xa/XrQHw/
 LHw7T7XbM2XrjWYF5IVInVCuZ1isEXaFqRvdLTivyvXyc=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


