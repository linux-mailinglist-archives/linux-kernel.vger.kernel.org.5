Return-Path: <linux-kernel+bounces-32016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A58835556
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35C21C216A2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04CA364AD;
	Sun, 21 Jan 2024 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iDOOEdma"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A631D53A
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705834469; cv=none; b=ZzW4rAx7ZADl83x1VtfUTuuRWMHKEU38zeViFLHlOAmTzIATZ37gyeBoaBWMhLTAsZDcA+JGKooOmmbAmFc/Z1rIymgqTAyq7cnqSI7Z9QXnsPrgUiW8fAp/TVG7NlW6cFQbw6ARDLtejK0imknDe+OwJ5qG7xoo2TQ2xeOXiNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705834469; c=relaxed/simple;
	bh=w7b+a0Dnlw4BjB3AmtaNqEWe+09AYCF0MSwPgQLh0d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=bj3MgNNh2YgYHuS4DHjquezUzNrSUJNDaASyEtfPijLreLLZDOdmyG3XuqDCKAGioNQEC3TkaSeTMi3oz73TNimGxdM/DIK94olfB/jJ2OpXCsQawflZUXMHlSqkWi2oTsT9ZE5yd/OYNmpW8ex8NyQQI/oqXk4mkZPVBsx5Jqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iDOOEdma; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705834459; x=1706439259; i=markus.elfring@web.de;
	bh=w7b+a0Dnlw4BjB3AmtaNqEWe+09AYCF0MSwPgQLh0d0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
	 In-Reply-To;
	b=iDOOEdmaNbaIGfbjhgPQ6eXzAU954YaWHx1LaQMJdfySCmspVW9Kiq74jVzQF+0Q
	 OMeGIR4Mirk9B8XCXisBV1e9E13/ntjFPTVEmfN+WKBNPFRc363EW2LXSAL2E8VhJ
	 FDMfTqRN+La1Fx4gAXGXaSPXTyc1A7z6ML2n3DG+i17sDzTxG0pIzXYxdQCHCpLN5
	 fBAFscDXwHiut8BwL/CXxt4acesgbgnbMJBmsTPmgKS1bxCZHPriKj0OS/gjGt3IO
	 7fr+OyTpD6HNIk8dDO/ikamtWBtFCQ74YDaMoA1W2R4MzRaQhJyFj8uJNMlTTs3P7
	 pwK1R9TWaNi99JU2/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MEUW8-1rLPdh0vcY-00G62Z; Sun, 21
 Jan 2024 11:40:51 +0100
Message-ID: <f34231dc-186b-4cb9-889b-b3be9224c5a9@web.de>
Date: Sun, 21 Jan 2024 11:40:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [v2] coccinelle: device_attr_show: Adapt to the latest
 Documentation/filesystems/sysfs.rst
To: Li Zhijian <lizhijian@fujitsu.com>, Julia Lawall <julia.lawall@inria.fr>,
 cocci@inria.fr
References: <20240119062057.4026888-1-lizhijian@fujitsu.com>
 <alpine.DEB.2.22.394.2401202217550.3267@hadrien>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2401202217550.3267@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ry3PyjnlazkKSo/ejkzYISZWX/Ft/sTBSyzwE1f1GeXMS3evifg
 6BOVJUj8a78gxC4QTXsy1uYEESwTQGE46OSDkw3mjkIDkZw1I8aFPBhX8ux9iHg+DichN8T
 Ajf3/pXPaFYGgd0NKFpEsOX0x0uXBYA8xpK0a+9twLqrS0peRtZXp/nHHaV6BiOF2IFYNT+
 71JlLKQ3wIOjZW9Ljw+bQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bIHMH+ua4MY=;12qu7BIXtxVpuHRwEKETm1ucy6a
 Yh8lw4YJziq0RmgMqgkdiuGUrwZM8Qa9jUcu6f+nLcswllXaWQfXAInWn4sejAt9MQ/Rr2Ffh
 RnxP9+vyEqYoBkUDKvU8IxhtnGjkGAuZRExmHG6anIlxo3bl9mXRg0K3n+d2U7/e+i7jyLwy8
 2uHYRt4JhNG08MzvFacLOHqgilDop+3rnQTjuqecsro3hQPv7QnaLA58qEJkkI2kJzsXHbh/u
 CfkEfc7Wuf5MtzFfiUpHPIYCWxzYEbtqMyvPZvFUaE2O3CR54A5r13aQ6Q1J+nMos5Ml/Ief9
 PuJn+y52blxLHA1MuLUBWRv6TR/aTdSWy/cjg3A9Lhjwblxlo/+nwne008Sldff1zeJFNi/bg
 +eViDQU8FTh6o7JkjumeQWj20/de99YACGlOJFwCIiZQbZnNhXoyIqCYBvkW+30qgp7Gl/urS
 h+U7KFf3tvFaHMc+Qgp5rkot0IJO1Jvll7MmjqhmNGahYi55FwfH0IsOq2xgSpx9LkKyr/5ts
 kzDcOCAsYee56LjTtTYAAYedF7/54mVgxOQrKSqybPsXdTVRfLArvcwtar8Q+OPaN28SRaVaW
 WXfaImsv2xS6CQtGDkOu64ktUS/MalROqZMzHmHqjVW0El3E/Bx42APNpX7G683IE5P/ej4fo
 U1xMv+VzvboayqBCGpNyOclt6uVuHs+PD+M8qnjSyeapaRb6wuxLrMh2baUYa5aNBcTkSCvJb
 rqtNclAcPgg020UtvYZed+6y7gLikn/JMIK3HfNmAEw2Cv7TeGhq/W/UlWTISvN0fxgzD0icz
 KgnqGSVNx5WUAOaIxv9/5bmaHLiq0NOma1rrgD5K2q5kMTX/mTTL+10S8OodAloW27iENOgKe
 l4+CrxZdbd7FSYrEDTkIITbDfX+fmQOju7h6nVOd8K/ZHGxhlnElgtZ/0RtcNlpotLq4tmHFr
 XFDGK87SAuONQOMs+zkjG5llh1g=

> I subsequently simplified the patch case to contain the following:
>
> -              snprintf(BUF, SZ, FORMAT
> +              sysfs_emit(BUF, FORMAT
>                                ,...);
>
> This also works for the case where there are only three arguments.
> It has the benefit that the change is recognized as a line replacement, =
so
> no extra {} are added when the call is in an if branch.

Would you like to consider the application of the following SmPL code vari=
ant?

-snprintf
+sysfs_emit
         (BUF,
-         SZ,
          FORMAT,
          ...
         );

Regards,
Markus

