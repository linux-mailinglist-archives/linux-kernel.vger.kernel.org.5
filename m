Return-Path: <linux-kernel+bounces-43204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F648410CD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CC13B2378E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0CA76C7B;
	Mon, 29 Jan 2024 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="bCWJs1Ra"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F43F9C2;
	Mon, 29 Jan 2024 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549665; cv=none; b=Y4RCaJWrm8v1O1IqhrZ7UJbmsdfrASnRLI5ZhnCE0Ra05jHYmfmFMOVMxNzfnxPHC3MazFoh4srkj6YfGWrUbwYbhNirS2e2Es4b/zRqdPry1ee381GP6UUnjmXtCndn8jh3MEo+pIH0ahYIR0KnGcnBgAfOXyK+u03kW3wZIJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549665; c=relaxed/simple;
	bh=MnmJHfR2tGRGo7Sd0LjypX7JikmqIpkBvfjkO7zi4kE=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=KecDyztJiyrp4giKEphCEN6TyFGTbRSSJJniF46F6IJFf/5QNp1FEbbjhqgt0hleRPTyJkjUPbVXHDij60km5EEpMS1Bu/2B8g5YUSsn9p8Z8cSFwZ0uytfOTA0RaLEnvMS4C/l1sg+WKlhIQv0tlAkkzj5sCxmxG9MykJyH4aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=bCWJs1Ra; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706549660; x=1707154460; i=rwarsow@gmx.de;
	bh=MnmJHfR2tGRGo7Sd0LjypX7JikmqIpkBvfjkO7zi4kE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=bCWJs1RaGhWb08HfWXHdAiYS5pqoJGdllGkEAoF5c5Tw/tQ1hDUqxdHMU1NkmYRb
	 lzHt8bDzN26sYqaq9NzBhHedgu3LBP+LA43F1bBnwPhYGMQU75oHMXkAwSSkxv0ZJ
	 ifNXenHLhH+759bBJbVDOniEg09qXwxVfT6SnZQWyX5clzYjayN2QEW4nSAuP5uTy
	 XfNVFih+U34t6Q5ySD5FgVjYwcScdtmuHWG17yVBsBLePrlmJbbYcEI43yjLA1sWF
	 G7Wu3NQ4cdwialFXD9C92SXVrCtVn/RAiNZav5ywrHylBexyJqHYiYKE90A2GVxmA
	 gDAg7tOF2+Sj5u5Fxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([92.116.253.92]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvLB-1rbpft0wpZ-00RrXc; Mon, 29
 Jan 2024 18:34:20 +0100
Message-ID: <d5957c84-adfb-4f59-b544-71340e5f2bb7@gmx.de>
Date: Mon, 29 Jan 2024 18:34:19 +0100
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
Subject: Re: [PATCH 6.7 000/346] 6.7.3-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Fpx+Ea4kbwXFRpjOHnGlj23OO7uNDIsME91EPzisudYA+cf/V94
 cVKgh6dcGZa+3WhzmBh6CDZyT3eFyLt3glPBMdFn6fie1sh2ic5zU98BupHZP+t5SNqz5c+
 F3RSEOjKS+DQJ4As2y17R8gyx5RC0aBUAKLEquxuyN9TJBTr+ha9CVbBqSsya+Ogvm2jsRW
 Tj21IGcQEwv2hi0GaC0EA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:noQ8Xp+E/1E=;OoFJ7wcc1Rq/TWLKhKSb18IVsVf
 N0E7pqcEfwofpzQCg7tnYaj5ye9mBfFGT6ePztQrDpUBqY7kFsV1aysxruONiEIeXxswoBFZM
 LFfEjxe6j04Ig89rQgZhz7Ooy3/KFblfAcQKtw9Jyc3z8dsySEH9O4DjDwmC+H3OZFvVi8sBE
 CHhcatIMDZX7mz5ZNxcs9qrYhecEGslOtOIaAJO0VGP6bt2bCL1emP33HnCMeZA85tEFjLHOe
 KC2kzmu/0AfD0bqBfD1Ajbj5AxPYu0paWxrLmpAu19/1QPJSLFfF0Ggw4zqfNNM29T+5G0dlg
 RxBlLQK8HACnybFwSH4FmFcGMcu4+fDZTE1HJysHgsAPmrL6tERUAQ/1ia0fqBDRoD+go01eA
 aRknlPJKhVulz9R9EFTzfxs74mfszbwPGUreieBRd2qxxICVyTVJPOTd65/1nC0XST+SFoWPb
 wB7jxKKrm9xGFdzm55JTtC3PKwq7cnp4UzQtXTdmSw7QxygA8rsYS3kGB+x0ONR+XQWN42OSM
 KVtT3qrwKBo/537YIJ3FNocxx2tzAJ+GrMjzMYsEdZRBdsyw4VYJuCI+w2+kvzaY96VqjxV+c
 c0+qc2/y6bKiZORBLFuq2V1j0bUpamq6t3LXftvzRoeQwHVAz8e6J/dx4Z7sm/kOQCePwZuFG
 5mbydXWBdYlzOArEMit240rVYeTtcmXAoGkU1JvLoH30zw9qrMASb/GinJCvwQygU7amn3kb4
 MyGqlhTL/7Fa16KvjGvBq4ZKWPhBg8iD3KxDWIBMAKXC1dbkc8tV3u2/6YzIjkl5oaKyvcMxA
 lWbJR3mOko6aeN4fz8jz8XeXRt5X61ZDDOowoH5LwaAaLuwul/s9P42GzKo8Wn/c/q8dxv9yk
 WN27Zd4QKZIvPGrycdrmzBnsdcdaCol/VCmMIyCTKGMago1w41DlVWeP9j+nWhSHz9jPH8yyO
 jKsDVQ==

Hi Greg

no regressions here on x86_64 (Intel Rocket Lake: i5-11400)

Thanks


Tested-by: Ronald Warsow <rwarsow@gmx.de>


