Return-Path: <linux-kernel+bounces-52415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D418497CD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E9C1F22895
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C376617543;
	Mon,  5 Feb 2024 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qfPdkHZZ"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D0C171A2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707129106; cv=none; b=c8sONvQV1KVhfRtQehQZb7DwQIyuLGCIQvJhT7r/nF2VEm0awXuf07SZQsVgwN1xPtxQfj3+9dITDrq6RJi8fQzFP7QW3mclzdowG2UwDK+kkJ1zBFaEfWPf8vIkt0Z4hKG0Rfn+w79yA64i89y/H0C8FwbWTxhvSmTWL63d0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707129106; c=relaxed/simple;
	bh=MS0o4bB4CsYHBqFsqplsg3dmAMiwQPtwGQfxK1b7HeY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=lpYtPxyBWabqCOYEu6ENBBQLCHAZzdOV3m8yhfwoxFlxMPK/ByCRnstUk/zQPolSDFhX+nguyoJadab3kq3qqEsVrXOjBT7kJ4uzmSbwxlDNZHUsYOFbRCd0WAhd06AU48qMDvif3OUqizDb/dj0QTSNm9o+pDbtFo2m+1A+w6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qfPdkHZZ; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240205103142epoutp04e4e092ecbb8c326b55db8f4792ad744b~w8N_xJoY91893818938epoutp04E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:31:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240205103142epoutp04e4e092ecbb8c326b55db8f4792ad744b~w8N_xJoY91893818938epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707129102;
	bh=ThRoMmfiYoM24Fp+fJLEawYDXh7ivnt6G8khMvmeQkE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=qfPdkHZZAGaBlcXYXEaWyds4jR58anlODDrN1TWTmeWbLEJMPaCkSQeEaM6eEic1I
	 lNrEgkQo7jMqHNw9cO3mopzI5u91Y/xxywmKqDl7sX1R4X04Rxkyh+F+B+ZicrPBLO
	 ckisJeiNEX7P66sbkAj/X1ovhLEAugj3gykKcMj0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240205103141epcas5p2c3365024bcd0597248233122ead0a40a~w8N_RuH-R2557825578epcas5p2W;
	Mon,  5 Feb 2024 10:31:41 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TT2jm0NHpz4x9Pr; Mon,  5 Feb
	2024 10:31:40 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	86.08.19369.B09B0C56; Mon,  5 Feb 2024 19:31:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240205081157epcas5p21f5ba2b907d8b3875234886be6290bda~w6T95omHX0475404754epcas5p2_;
	Mon,  5 Feb 2024 08:11:57 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240205081157epsmtrp2628a371872ef3ef1c741990e70fbbcaf~w6T94xzex1746517465epsmtrp2w;
	Mon,  5 Feb 2024 08:11:57 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-d2-65c0b90b3b90
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DA.C4.08817.D4890C56; Mon,  5 Feb 2024 17:11:57 +0900 (KST)
Received: from FDSFTE048 (unknown [107.116.189.46]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240205081155epsmtip2260adc9144a0bf0f6939162c39d8c638~w6T8D59AY2177221772epsmtip2Q;
	Mon,  5 Feb 2024 08:11:55 +0000 (GMT)
From: "Tamseel Shams" <m.shams@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
	<alim.akhtar@samsung.com>, <linux-fsd@tesla.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
In-Reply-To: <bd253c6d-999c-4ba6-a80d-c7e077d1261a@linaro.org>
Subject: RE: [PATCH 1/2] serial: samsung: honor fifosize from dts at first
Date: Mon, 5 Feb 2024 13:41:54 +0530
Message-ID: <0b2201da580a$fcb94b10$f62be130$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQKjNt2jyU8K8pSm5ip8/e5tj0DOhQL1DmltAaJhYTSvROveMA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmhi73zgOpBps+W1s8mLeNzWLN3nNM
	FvOPnGO1aF68ns3i3VwZi74XD5kt9r7eym6x6fE1VouHr8ItLu+aw2Yx4/w+Joszi3vZLVr3
	HmF34PXYtKqTzePOtT1sHvvnrmH32Lyk3qNvyypGj39Nc9k9Pm+SC2CPyrbJSE1MSS1SSM1L
	zk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpVSaEsMacUKBSQWFyspG9n
	U5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdcfvuN7aCbsGKq5d6
	WBoYZ/F1MXJwSAiYSHzfwNHFyMUhJLCHUWLj5ZMsEM4nRom5c7ugnG+MEut7epm6GDnBOnbf
	X8QGkdjLKPFh8w1WCOcFo8Th/RfZQarYBLQl3u06ywSSEBH4wygxq+8jO4jDLLCRUeL44V42
	kCpOATuJ0z0HWUBsYQEviV0XtoJ1swioSJxd+oURxOYVsJToa7vIBGELSpyc+QSsnllAXmL7
	2znMEDcpSPx8uowVIi4ucfRnD1hcRMBJYuf0D2CLJQTOcEi8OfmDDaLBReLJpHaoZmGJV8e3
	sEPYUhKf3+2FqkmXmPsQ5ukCiWW7vkPV2EscuDKHBRR8zAKaEut36UOEZSWmnlrHBHEDn0Tv
	7ydQrbwSO+bB2IoS/3f3Q40Rl3i3YgrrBEalWUhem4XktVlI3pmFsG0BI8sqRqnUguLc9NRk
	0wJD3bzUcnicJ+fnbmIEp2atgB2Mqzf81TvEyMTBeIhRgoNZSYRXfN2BVCHelMTKqtSi/Pii
	0pzU4kOMpsAAn8gsJZqcD8wOeSXxhiaWBiZmZmYmlsZmhkrivK9b56YICaQnlqRmp6YWpBbB
	9DFxcEo1MK1cM8kv0nKH5pWQXI4pzFs2O3kntWd7eUwovhjBZcOzc9KO7Ik6Xy7+CNJt/sHU
	6x1U9+7oj3XPJ1VPrBDUlaxpYmqLkhXSPsX6/skSEybTHP3I7a5B348l1HN4NO4rnRI5o+aU
	2pVpRk7s11+9rrA2LeJWlv18xk5M+XHnpYVXhM+uKzrVuls3MKbuxkdTs0m7+KI4LeY7ZwpU
	PwrSy803elOnZ2J1dZf/okx2v1mzj35sMzddPtlKcet5TZ1vTv0Le9y1+Bbp8a3JbnhtMun7
	FFutA6qqnLnrZ06rDkt52bYm6d49lzrWe+J+KnxFDXEZE2M0tA0bHnuERBltNeaxWdCYM5Pj
	f6t1pbcSS3FGoqEWc1FxIgB397sGVgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSvK7vjAOpBksfyFk8mLeNzWLN3nNM
	FvOPnGO1aF68ns3i3VwZi74XD5kt9r7eym6x6fE1VouHr8ItLu+aw2Yx4/w+Joszi3vZLVr3
	HmF34PXYtKqTzePOtT1sHvvnrmH32Lyk3qNvyypGj39Nc9k9Pm+SC2CP4rJJSc3JLEst0rdL
	4Mq4ffcbW0G3YMXVSz0sDYyz+LoYOTkkBEwkdt9fxNbFyMUhJLCbUWLz828sEAlxiWm/9jNC
	2MISK/89Z4coesYose7PNVaQBJuAtsS7XWeZQBIiAi1MEk+PrQPrYBbYyihxc1sxRMceRonG
	jltMIAlOATuJ0z0HwVYIC3hJ7LqwlR3EZhFQkTi79AtYM6+ApURf20UmCFtQ4uTMJywQQ7Ul
	eh+2Qi2Ql9j+dg4zxHkKEj+fLmOFiItLHP3ZAxYXEXCS2Dn9A/sERuFZSEbNQjJqFpJRs5C0
	L2BkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERydWlo7GPes+qB3iJGJg/EQowQH
	s5II7wThvalCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb+97k0REkhPLEnNTk0tSC2CyTJxcEo1
	MFnxTng8xXlZ441w02ObEyScDz1/cW6eUDq345k7ry7FqnwL5S5hEzM5sue9a/vk5BNtPj0T
	p6Q/Ms35PG0DS6isb79nW7m6QITnuuS5PnuSvswy/mi3yqTO5O3Mrx+FfaJEfh1/nR5yfKfv
	AwGfxtMFb/+avX6c1X+Y7/uv42wOdx8/UTobJrnt2f8sgb1Ba9SvcTW1ZsbX1y8WPaPVNyPI
	VXfCpHzz/ukXA2WivvAWyPdf9dtldKD1g2h7Vcxt7bmXbh57czG34rRl0IZip18+v8oum+58
	/lSzSoFXS+Vbo5j1149p16X///ytEc100EasIbRnztxGxfMvYyQ3i3U+b3fYm6y6pUPI9k21
	iRJLcUaioRZzUXEiAL3av2E9AwAA
X-CMS-MailID: 20240205081157epcas5p21f5ba2b907d8b3875234886be6290bda
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240202212456epcas5p15589813cd79526e9d0c444082e2f0e51
References: <CGME20240202212456epcas5p15589813cd79526e9d0c444082e2f0e51@epcas5p1.samsung.com>
	<20240202212448.74840-1-m.shams@samsung.com>
	<bd253c6d-999c-4ba6-a80d-c7e077d1261a@linaro.org>



> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: 05 February 2024 13:10
> To: Tamseel Shams <m.shams@samsung.com>; alim.akhtar@samsung.com;
> linux-fsd@tesla.com; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> gregkh@linuxfoundation.org; jirislaby@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-samsung-
> soc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-serial@vger.kernel.org
> Subject: Re: [PATCH 1/2] serial: samsung: honor fifosize from dts at first
> 
> On 02/02/2024 22:24, Tamseel Shams wrote:
> > Currently for platforms which passes UART fifosize from DT gets
> > override by local driver structure "s3c24xx_serial_drv_data", which is
> > not indentded. Change the code to honor fifosize from device tree at
> > first.
> >
> > Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> > ---
> >  drivers/tty/serial/samsung_tty.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c
> > b/drivers/tty/serial/samsung_tty.c
> > index 71d17d804fda..e4c4c9f4f9b0 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > @@ -1990,8 +1990,7 @@ static int s3c24xx_serial_probe(struct
> platform_device *pdev)
> >  	}
> >
> >  	if (np) {
> > -		of_property_read_u32(np,
> > -			"samsung,uart-fifosize", &ourport->port.fifosize);
> > +		ret = of_property_read_u32(np, "samsung,uart-fifosize",
> > +&ourport->port.fifosize);
> >
> >  		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
> >  			switch (prop) {
> > @@ -2009,10 +2008,13 @@ static int s3c24xx_serial_probe(struct
> platform_device *pdev)
> >  		}
> >  	}
> >
> > -	if (ourport->drv_data->fifosize[index])
> > -		ourport->port.fifosize = ourport->drv_data->fifosize[index];
> > -	else if (ourport->info->fifosize)
> > -		ourport->port.fifosize = ourport->info->fifosize;
> 
> I think ret is not initialized here.
> 
> 
Thanks for review. Will fix it in the version.


Thanks & Regards
Tamseel Shams 




