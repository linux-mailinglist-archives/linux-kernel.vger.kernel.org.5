Return-Path: <linux-kernel+bounces-81674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A1D8678F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392C81C28635
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC097135A48;
	Mon, 26 Feb 2024 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fhaELeMf"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162851350FD;
	Mon, 26 Feb 2024 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958172; cv=none; b=hKiXpQ7qUv7UM/2neA4lAIDNQmm6MxdQziDCZud++7C2E1HweZt2C01z2napn/bGj5JWLNaF8iaUdvokCBX7HEIIaeXpUleY+xCdcGIc0vxLQVoXxXMa+FOMyTUZH4ZbdTXURuEKJnThFawjRUVaBgBXkhgtvZSo7g3rkGSiErA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958172; c=relaxed/simple;
	bh=w1j4n5piV5lJO4TYJQ5tVQ4fRWX1z8QvmVmq7Ogv0YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUulWZjkjbl+SVp7lGNcunSe/hYtwKbWwajTtGmObZTN0SQCtR43sts4El81urqSprxsVs+3MsL+c+QqGSPd32DJ8IE8wFdgGWegHQoxMgyc1+rdGvwkTZcTMDaXao0Hwy6uuf2lXVrIUiRoBZvddVaSlmBuz+iRs+47QN3WrKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fhaELeMf; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708958144; x=1709562944; i=markus.elfring@web.de;
	bh=w1j4n5piV5lJO4TYJQ5tVQ4fRWX1z8QvmVmq7Ogv0YM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=fhaELeMf9XLkwiHf8oWLsYuqb2xArERZFnRXqvhj/S5LOixeEp02UBm3bF9UG3u/
	 hXebI2/dj1icLZTNCweURk0s0pgXyMR8NWFqOJbdweywmjRrIfCbq/zVo6y45OoJ5
	 KOMj9gEYcbWX6QbKfSXQnwpF27sdkmak+nJ47pndw0U9ePzVJnjfSSI93wfQCiWuo
	 GCECkOUUTHRleU1SME2vbGYO+gLGXQX1fG38moKzW9N9eW7yXCYAqD/GubHdkBr0Y
	 M1P9zn8P/JHl4PNNEGsYw+bIvi7y/BHx4TRi6ekcADmWY2p4iS9GZSBIVo/ivGaE4
	 9eEyZv19oZ6dtlD7EA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMEM-1r0Lqw18xq-00fP3l; Mon, 26
 Feb 2024 15:35:44 +0100
Message-ID: <1edb972e-7285-47d1-8ee6-606146b2f9e3@web.de>
Date: Mon, 26 Feb 2024 15:35:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: clk: imx: scu: Use common error handling code in
 __imx_clk_gpr_scu()
Content-Language: en-GB
To: Abel Vesa <abel.vesa@linaro.org>, kernel@pengutronix.de,
 linux-imx@nxp.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr
References: <20231210171907.3410922-1-visitorckw@gmail.com>
 <0e906ec6-fe73-4dbd-b555-a2c03b6e1030@web.de> <Zb04UUeE/cU9HtKZ@linaro.org>
 <1a3c05b8-45f8-4205-8cb5-3b8f2d791877@web.de> <ZdxVHLce6mk975Zp@linaro.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZdxVHLce6mk975Zp@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ik7pubzyywRLN+A8mM0fkXjKiGabN6eGEKg2njPktovMf7/kFaC
 iVS+JNE7lldbXx0Cihn0bS3x1IrbChjtnXXeppNQ/oFFxgAXBabAe8duD6XAqn+gNbOauia
 u4o0zlsfYQo9huyUbO0i8wqx7te3aOOyxeOP6/+4jmOEdU5ZWIIokDPKknVUlfGndZxE8qh
 5s2NokyeBzRJcqy9c1H5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:avMEIdZR8Iw=;MDxH7h9hE7musDOfhwLI8lHqKOs
 vSZxQcxO1BMq5OdWipMRggwmb6Phb8RPbGdrDx5EiGUyKP0GFoMHBIYB7GgID5CajqqzXtk+6
 r1Qoh65N5IBVhN9O/5didT7ai1T2HJKfwVQ//nE0xE9s05RETt7rKUB4/CYLg04ptaQGRHzlI
 +ksJ04n67GamCfPWbq7p5HiDCrdW9/MKL7KZ+EvGlrFH16uMlK5qoOf3zXLE+Pb3sck43OpTw
 T1p8guLssAsJUgY5J5TjNo64KsJrVdNVKgQQHsZ8MAQMJbc11CRSuXyo5IFdojagqwtcMGhg/
 QIyxG5QhGCH6sOwbw93WzSX+c4BpAwD0f3bfJupCnjPxaJqLc4g2O3qy204PablIsLKcXHIHH
 lwMhyBN/2eWidgiGI8xajsJIANfGhG0zFUA3HwmfjdfnqIBikPR2I1v2UuHVYRXSGjtXuHhT+
 Y/CqDQNA5ntSAc5MhNewLQ3FIVybhPREn4FD3vQazhV/JsnRdPeW9Ew4Z4L9mRmPVB0jIIB1Z
 TtPYEZijFEj+9IIFVcQ+EMjiDx6L7f1pfzlUONSm1vHrBXULdamd7jjB7ILRBGE223Dz655N5
 Vh1u77t/EkNlRzNmD+HpJAU20uHluduKHv9C/gpyDqAq3dAHHl3TNip0Q/HvExZcAxMCMrcyy
 NfmAWT/2Z33LJZuozoUCBIdbaFBjo/MhWPL2r1LzlYKotE3FtYVW6pl1K8SkRFuwu+8TesQJ8
 ny0Je+/DbcfMmw2AvDIsF3LjmhIcfB8GRZ/M+k0f9nc9+nJIPD69GwBoBXTVOLQ1BKbQOfDsL
 HYx2C4uxdA17KYLN0FaNZe8sv4ExJdYQ/pCo+Hoz0nrfo=

>>>> Use another label so that a bit of exception handling can be better r=
eused
>>>> at the end of this function.
>>>
>>> Please don't send patches as reply to other(s) patches.
>>
>> This is a general possibility to connect an information sources with
>> a corresponding change idea.
>> Will the acceptance grow for the presented source code transformation?
>>
>
> Nope, please don't do that.

Do you find the proposed source code transformation reasonable (in princip=
le)?


> The b4 tool will pick up the old patch if you do this.

Are you looking for further improvements for this development tool?

Regards,
Markus

