Return-Path: <linux-kernel+bounces-163840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCC48B73A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CB81F2410D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F5812D758;
	Tue, 30 Apr 2024 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZwF0GtvR"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF2812C805;
	Tue, 30 Apr 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476109; cv=none; b=Dh+oE1zh33w8mvP6MafKQF85Y+weIizikdUEXySgGiHJ2d4as/o3UiHbju7NjKlYW0PkOXNAKZVGh+G4nQ4l0h95IhDP3mRFBV6lYSHIKqkuEQa+3u8ImTbtHZII/eaWRibb2OQul/RJZGhOLOtk6qTTDhihzxq3zITm+oKz3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476109; c=relaxed/simple;
	bh=WKaRtpsKz/ipOsB0Xwln6vB6uuqXH78fHDV+CUqdYms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Osu6aithA6svxiMzAJNB1UvhoUlUbSg+4fKSiM5NxIMyyHjlTV4spJj5M6xHtCTXhvG8QVrAznKNSuFeQr8GUbo8hm3znned4aHMGIUdXvpkhN15+gFHuo5pTGqgETpqksxahRuToRc0NQZ31dx+4DZmrpangfl2IouZEkn76ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZwF0GtvR; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714476084; x=1715080884; i=markus.elfring@web.de;
	bh=JIkis/xeQt6gvJhUTXbByv/eSUeCf7Rh6o+hieRhZ00=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZwF0GtvRyNQQovMhVo2cIHhnIG0LKMWYmb4lfoLWJhusx7aJ244eKgw7uQoahQff
	 gbGMdpdHaJOCtyWE2ne9vO8rN8lcRSv1mUy6WPX8AQur5uODH1Ryo6+CRyytPAmKk
	 +iG7fc2J+5VqEX1yyGMwTOBUFMnv0CpA4AK5HuBOZ0BDVYYaGtxHwbUdLdpB6eDmE
	 E4Uzs+7ZECmBiZcyjoBtSddmJ86eFqDWVZ9qD/dZIUbeu2hXShXKgPIhu3zjvt4Kf
	 X8dXGvfQCUjVPHDXnK2HxtsFFaIqlRbqK2pT+93oQSIxbHgUgxrkKvrCIX07R1dmv
	 9vPqv1rA7ABJaA3Yuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbTH3-1sdJML0DHt-00bYL5; Tue, 30
 Apr 2024 13:21:24 +0200
Message-ID: <230af978-c834-423b-8d42-78c164be40b9@web.de>
Date: Tue, 30 Apr 2024 13:21:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] scsi: qla2xxx: Optimisation of exception handling
 in qla24xx_els_dcmd_iocb
To: Yongzhi Liu <hyperlyzcs@gmail.com>,
 GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nilesh Javali <njavali@marvell.com>, Saurav Kashyap <skashyap@marvell.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Himanshu Madhani <himanshu.madhani@oracle.com>, huntazhang@tencent.com,
 jitxie@tencent.com
References: <9c711441-6e79-422f-9405-ee271929e77c@web.de>
 <20240430091144.10744-1-hyperlyzcs@gmail.com>
 <20240430091144.10744-2-hyperlyzcs@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240430091144.10744-2-hyperlyzcs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eFrJltQP/J/o/6l1mjhzJaOrub1Aobs7ibilxBJ8ULtKgFioC2A
 DhKeHunCjVQ2TRm+Pw041lqGUNa3hYuNL79Fw4aZgee9JI3gnwL4rvfoGN33qAwNkiWkb4f
 gkKhL1j3z00cjd/ys2Z3IgS43VveJWV8voaXMP02JeTErw8qcyOgKgGx8nspwi25X3z370c
 uTDMkUIdH18nCDmmlaB4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y+26sjO/L/k=;dT++AxsR1DZbq3ktwVRqtOtgeof
 xqPZWhC1M6yPpDgyxaD5ZmnALcaUDWvxnNhAMRtulnyNesFAcYxpYycKRiZ/iEDinVXUb6OY4
 cqmxsEACDv34EdjA76NulH4tzks/VjjNToH2wDk17xYgV4+kqIhZ9tt2h6D/yegnK0ok+gXxr
 98apGlE+faPp2fsdPKbk0sIsCxw0A6M0i2HBLyH3ETYSN48L0rrvTvfRccKfOgKUjXFSAXhZs
 Ux7Ct/7MlfdiZfMOWeY/UFCl9qeqeh55c0lbNCJbtLDZQfX8gSWBgy40u6KwVWV04IrNzm/I9
 CvGAyQTqvtudhfFjL4cppBlf8pxp7F97Jdq7dqNxBtQeSaXC171BqFqo34QLMWXjtQpXaZOOF
 QjlYDu1Sq0zz0xEZ6YUOnvgi/hwkk3jzHqt4eHvkfdOcBvDwc7h59pLWggjfuUbwa02cUWLh0
 dKLmmZvYeIKVom5oCZJFMRUaqLvLV2sK21Pw7AEI1R6J69oSkOoPA1yxVVNg/9c8xpPvFr8k4
 LootZYTc2MOvf1xvKFaNsbyAE5V8O9adR6hJeSPahJdpoMTxMKyG4LNXLkmdKbS2X/J8OPFuA
 FbcPKgIEgcwPmTzQQkIgHEUt2mxMbvWcxHP17EKo8qcnwt0CDcZkeLmySg9ZZ7ukHSMN/9aNK
 xrAFb9CyuX37fbiiitgrF6Fz+2hjhtKqFjFVTky6cB7ql7C1c6a7a0lGG15lt/alP9r0I339K
 qqQIYn84MLjjRE37GXFbEPkDVDOQC+dKpsmSpXcac3t2XSB9Wzj7SidZjG+JJ/kH4hLrd5OUX
 thHk3DDAG5jtARXAdI1Oho+AjqrbrFmaGKJS6neH8zSfY=

Would you like to use the summary phrase =E2=80=9CUse common error handlin=
g code in qla24xx_els_dcmd_iocb()=E2=80=9D?


> To avoid duplicate error handling code a bit more, use more common goto
> chain in qla24xx_els_dcmd_iocb.

How do you think about the following wording?

   Add a jump target so that a bit of exception handling can be better reu=
sed
   at the end of this function implementation.


Can the tag =E2=80=9CSuggested-by=E2=80=9D be helpful for an improved chan=
ge description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc6#n586

Regards,
Markus

