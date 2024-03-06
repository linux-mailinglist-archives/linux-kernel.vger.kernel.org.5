Return-Path: <linux-kernel+bounces-93332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA6A872E1E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DB6285E95
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBB117741;
	Wed,  6 Mar 2024 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sai8k+7s"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C4C15E88
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 04:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709700583; cv=none; b=BwntH5cMakHjduJ2/vcLlEmuIsTeBD0ZMJ1h4ByWrGckDmGXUcj/BUozdFatWPaf0CbsSEnguiQZhW3mnYG8G+6JYWC0eGvC0jeqDAnqW1gHpNCWlb6mwFYTqKCh1eZ3Xxss8TiIk99ArMYfO4yxvQn+AoG/vlCBm/ESBWKGHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709700583; c=relaxed/simple;
	bh=dcCd7e0xe1/zUt4IjtCnVX9tWxflV+CbGxf+YsozPFg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Ap++i97YiflC1q6brozvInwViER3KRQpWhQauuqRJosNNsAOnzpHaxR8K7Nz9C5oFiaop0W6C76/VzKiH+MjjeDIOK2wF1VmkDIJLD8detOwW2P6kzatJ7GZk1v1jYIfxnNMUmlMkfnPNzjbHDe5PKusqFsfWSeYIivGSdwJNLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sai8k+7s; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240306044933epoutp01e5d5a8ca8e5acd76555f2a231992b6c9~6E50Fqe-x2109421094epoutp01I
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 04:49:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240306044933epoutp01e5d5a8ca8e5acd76555f2a231992b6c9~6E50Fqe-x2109421094epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709700573;
	bh=dcCd7e0xe1/zUt4IjtCnVX9tWxflV+CbGxf+YsozPFg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=sai8k+7s21QSwcMfnmRT3w2gQaV52ajiv6g2b2yqAXzt10IttwjkpoRW7czq/VcZt
	 XxDvdZ5n6YB6fzEUOjev94xaIWhcwRieTt0yVCoap7FLgf3mPKPCwVN6uy5mVrdP56
	 pRETu0UBuTlLv+55LaP+IPvLpgJdOVcGPkAUTeIE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240306044933epcas5p441c641ce1a58c982f14b46bcabbc1135~6E5zpyOhX0510405104epcas5p4C;
	Wed,  6 Mar 2024 04:49:33 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TqKj74yZVz4x9Px; Wed,  6 Mar
	2024 04:49:31 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	01.50.10009.BD5F7E56; Wed,  6 Mar 2024 13:49:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240306044930epcas5p3014ecdf54086346dc1086bab96cccdd6~6E5xjAJqx0157201572epcas5p3D;
	Wed,  6 Mar 2024 04:49:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240306044930epsmtrp21a3d5b90fc7426fedf185024ee92452f~6E5xh6Jki2822228222epsmtrp2i;
	Wed,  6 Mar 2024 04:49:30 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-02-65e7f5db954a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E1.0E.08755.AD5F7E56; Wed,  6 Mar 2024 13:49:30 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240306044928epsmtip1bbfde040c44185536aebc5aa7ec61b80~6E5vm6T0Y2041420414epsmtip1R;
	Wed,  6 Mar 2024 04:49:28 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Tudor Ambarus'" <tudor.ambarus@linaro.org>, "'Sylwester Nawrocki'"
	<s.nawrocki@samsung.com>, "'Chanwoo Choi'" <cw00.choi@samsung.com>
Cc: "'Sam Protsenko'" <semen.protsenko@linaro.org>, "'Krzysztof Kozlowski'"
	<krzysztof.kozlowski@linaro.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"'linux-arm-kernel'" <linux-arm-kernel@lists.infradead.org>, "'Peter
 Griffin'" <peter.griffin@linaro.org>, =?utf-8?Q?'Andr=C3=A9_Draszik'?=
	<andre.draszik@linaro.org>, "'William McVicker'" <willmcvicker@google.com>,
	<kernel-team@android.com>
In-Reply-To: <d508dfc1-bc28-4470-92aa-cf71915966f4@linaro.org>
Subject: RE: samsung: clk: re-parent MUX to OSCCLK at run-time
Date: Wed, 6 Mar 2024 10:19:27 +0530
Message-ID: <324701da6f81$ad1379d0$073a6d70$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKxjg6/pX91DIw7ou3pXLvWj7BlkgJSyW8Wr2lJ2sA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmuu7tr89TDTYeV7TY8mozi8X1L89Z
	LXZsF7HY+3oru8Wmx9dYLT723GO1uLxrDpvFjPP7mCw2zPjHYnH4TTurxfM+IPfTrTiLVZ/+
	MzrwemzbvY3VY8GmUo871/aweWxeUu/Rt2UVo8fnTXIBbFHZNhmpiSmpRQqpecn5KZl56bZK
	3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVyoplCXmlAKFAhKLi5X07WyK8ktLUhUy
	8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjOuN15iKfgXVNE5p7CBcUdAFyMn
	h4SAicTbK3+Yuxi5OIQEdjNKLFi8mx3C+cQocW3LXUYI5xujxP9FN5hgWmZOWwtVtZdR4vrR
	y1BVLxglVsw9zApSxSagK7FjcRsbiC0i0MsosXJXAEgRs8BZZomX7/rZQRKcAnYSXQ8vMYPY
	wkD2+sO/wJpZBFQkWpbOY+li5ODgFbCUmHjZHSTMKyAocXLmExYQm1lAW2LZwtfMEBcpSPx8
	uowVYpeVxNtlZ9ggasQlXh49wg5Rc4RDYudXfQjbRWL6t3aouLDEq+NboGwpic/v9rKBrJUQ
	8JBY9EcKIpwh8Xb5ekYI217iwJU5YJcxC2hKrN+lD7GJT6L39xMmiE5eiY42IYhqVYnmd1dZ
	IGxpiYnd3awQtofEryurmSYwKs5C8tcsJH/NQnL/LIRlCxhZVjFKphYU56anFpsWGOWllsNj
	Ozk/dxMjOAVree1gfPjgg94hRiYOxkOMEhzMSiK8Nb+epArxpiRWVqUW5ccXleakFh9iNAWG
	9URmKdHkfGAWyCuJNzSxNDAxMzMzsTQ2M1QS533dOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgSnv
	Rk0Dz3WpZ7zMxRtWWP02dVlYtnvXzsCr2yJ4/BaySHF+mtCl3ZUne8a2mmuB1FlBkws+PnP5
	j1j+yP3Lb2UxR3b6lm9zPpa8F78Z9oPbwP+A68VFxnGluftDigXrWpITN+/gW+A+q3XKSx7+
	82m3J621L1h4w0sqR/xIQlrtl3RhpYKctChf2eWyz9J1lzLd2xTmoHSrjjvqxqqbYdPbVaU/
	P/T9+2yle9harhW7w+rPRrxmla7wbC69kziL7fakuCUuR6d+CitozPrJKay6UCzd5dNZ8Uam
	Q9vmb779Lvli0/sVuUyCyv4TK0sebP/AIV2z/sjTvF1JUs8s39w50Pnae87TKZ3ZSokRnEos
	xRmJhlrMRcWJAJ/Jp+lKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSnO6tr89TDZ7d0rXY8mozi8X1L89Z
	LXZsF7HY+3oru8Wmx9dYLT723GO1uLxrDpvFjPP7mCw2zPjHYnH4TTurxfM+IPfTrTiLVZ/+
	MzrwemzbvY3VY8GmUo871/aweWxeUu/Rt2UVo8fnTXIBbFFcNimpOZllqUX6dglcGUf6d7MX
	9GpXvJr6kamB8aV4FyMnh4SAicTMaWvZuxi5OIQEdjNKtPy4xQyRkJa4vnECO4QtLLHy33Oo
	omeMEqf3PwZLsAnoSuxY3MYGkhAR6GeUeNE5lRHEYRa4zCzRemMdE0QLUGbfiguMIC2cAnYS
	XQ8vge0QBrLXH/7FCmKzCKhItCydx9LFyMHBK2ApMfGyO0iYV0BQ4uTMJywgNrOAtsTTm0/h
	7GULX0OdqiDx8+kysDEiAlYSb5edYYOoEZd4efQI+wRG4VlIRs1CMmoWklGzkLQsYGRZxSiZ
	WlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHJFamjsYt6/6oHeIkYmD8RCjBAezkghvza8n
	qUK8KYmVValF+fFFpTmpxYcYpTlYlMR5xV/0pggJpCeWpGanphakFsFkmTg4pRqYFKrfZHms
	mWFTV6rCE+eekfhvljXf24Vubdscfqzjm/vIs+duZo382jAB7bjm8NTS5y/ZzmnVyz7/K1E2
	ZWFFXP/PDx+c4sqSH0RtLrVJ5XxlcEZk6cPfbp5yUuvUNHN0/+W77K99uGLmvviYqebHVjKl
	VPMUVVUYMZsz7ZxXtrm97nmytqlV85o7eyTP/21V/t5hfmKiwm2vy+tEM6zEDvv/FHbyO269
	f/KDhnLXi+wPVnXui6r6k8W4OOF8O7uYdObsI3s+SYrOfDXTfcOPk14uTzgZRDrr9Gzf39FX
	WNWn4rzhcqP70oNcJ8pYvgidSZuW8q9v2vHSFZk7lkyzDNrE3OLxZPJB5Sn71SKVWIozEg21
	mIuKEwG+9SnwNwMAAA==
X-CMS-MailID: 20240306044930epcas5p3014ecdf54086346dc1086bab96cccdd6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240306032013epcas5p4932674432fbb49f586ed9d00f006a9e8
References: <CGME20240306032013epcas5p4932674432fbb49f586ed9d00f006a9e8@epcas5p4.samsung.com>
	<d508dfc1-bc28-4470-92aa-cf71915966f4@linaro.org>

Hi Tudor

> -----Original Message-----
> From: Tudor Ambarus <tudor.ambarus=40linaro.org>
> Sent: Wednesday, March 6, 2024 8:50 AM
> To: Sylwester Nawrocki <s.nawrocki=40samsung.com>; Chanwoo Choi
> <cw00.choi=40samsung.com>; Alim Akhtar <alim.akhtar=40samsung.com>
> Cc: Sam Protsenko <semen.protsenko=40linaro.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski=40linaro.org>; linux-samsung-soc=40vger.kernel.org;
> linux-clk=40vger.kernel.org; linux-kernel=40vger.kernel.org; linux-arm-ke=
rnel
> <linux-arm-kernel=40lists.infradead.org>; Peter Griffin
> <peter.griffin=40linaro.org>; Andr=C3=A9=20Draszik=20<andre.draszik=40lin=
aro.org>;=0D=0A>=20William=20McVicker=20<willmcvicker=40google.com>;=20kern=
el-team=40android.com=0D=0A>=20Subject:=20samsung:=20clk:=20re-parent=20MUX=
=20to=20OSCCLK=20at=20run-time=0D=0A>=20=0D=0A>=20Hi,=0D=0A>=20=0D=0A>=20Tr=
ying=20to=20get=20some=20feedback=20from=20the=20samsung=20experts.=20Pleas=
e=20consider=20the=0D=0A>=20following:=0D=0A>=20=0D=0A>=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20---------------=
------------------------------=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20CMU_PERIC0=
=20=20=20=7C=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=7C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=7C=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=7C=20=20MUX_USI=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=
=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=7C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=
=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=7C=20=20=7C=5C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=
=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20OSCCLK=20---=7C->=7C=20=
=5C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=20=7C=20=
=20=5C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=20=7C=20=
M=20=7C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=20=7C=20=
U=20=7C-->=20DIV_CLK_PERIC0_USI*_=20-->=20GATE_USI=20=7C=0D=0A>=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=20=7C=
=20X=20=7C=20=20=20=20=20=20=20=20(1=20=7E=2016)=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=20=7C=20=20/=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20DIV_CLKCMU_PERIC0_IP=20=
---=7C->=7C=20/=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20=
=20=20=20=20(1=20=7E=2016)=20=20=20=20=20=20=20=20=20=20=7C=20=7C=20=20=7C/=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=7C=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=7C=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=7C=20=20MUX_I3=
C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=7C=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=7C=20=20=7C=5C=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20--=7C->=7C=20=5C=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=20=7C=20=20=5C=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=20=7C=20M=20=7C=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=20=7C=20U=20=7C-->=20DIV_C=
LK_PERIC0_I3C=20-->=20GATE_I3C=20=20=20=7C=0D=0A>=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=20=7C=20X=20=7C=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=20=7C=20=20/=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20OSCCLK=20---=7C->=7C=20/=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=7C=20=20=7C/=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=7C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=7C=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20---------------------------------------------=
=0D=0A>=20=0D=0A>=20Is=20it=20fine=20to=20re-parent=20the=20MUX_USI=20from=
=20above=20to=20OSCCLK=20at=20run-time,=0D=0A=0D=0AI=20am=20not=20aware=20o=
f=20the=20exact=20SOC/HW=20you=20are=20working=20on.=20=0D=0AIt=20depends=
=20on=20the=20CMU=20design=20about=20how=20to=20achieve=20low=20power=20mod=
e=20and=20clock=20gating=20for=20an=20IP/Block.=20=0D=0A=0D=0AIn=20theory=
=20and=20looking=20at=20your=20clock=20diagram=20above,=20it=20is=20ok=20to=
=20switch=20to=20OSCCLK=20=20for=20MUX_USI.=0D=0A=0D=0AIf=20you=20can=20jus=
t=20use=20GATE_USI=20clock=20to=20clock=20gate=20USI=20IP,=20you=20will=20h=
ave=20a=20low=20power=20for=20USI=20(of=20course=20there=20will=20be=20a=20=
leakage=20current=20still=20drawn).=0D=0AIs=20that=20what=20you=20want=20to=
=20achieve=20(low=20power=20mode)?=20Or=20you=20are=20looking=20to=20get=20=
lowest=20possible=20operating=20clock=20for=20USI=20IP?=0D=0A=0D=0AYou=20ne=
ed=20to=20takecare=20about=20if=20that=20clock=20is=20being=20shared=20with=
=20any=20other=20IP,=0D=0Aso=20unless=20all=20the=20IPs=20which=20consume=
=20this=20clock,=20goes=20into=20idle=20state,=20you=20can=20avoid=20MUX_US=
I=20change=20to=20OSCCLK.=0D=0A=0D=0A=0D=0A>=20during=20normal=20operation=
=20mode?=20Experimentally=20I=20determined=20that=20it's=20fine,=0D=0A>=20b=
ut=20the=20datasheet=20that=20I'm=20reading=20mentions=20OSCCLK=20just=20in=
=20the=20low-power=0D=0A>=20mode=20context:=0D=0A>=20i/=20CMU=20...=20=22Co=
mmunicates=20with=20Power=20Management=20Unit=20(PMU)=20to=20stop=0D=0A>=20=
clocks=20or=20switch=20OSC=20clock=20before=20entering=20a=20Low-Power=20mo=
de=20to=20reduce=0D=0A>=20power=20consumption=20by=20minimizing=20clock=20t=
oggling=22.=0D=0A>=20ii/=20=22All=20CMUs=20have=20MUXs=20to=20change=20the=
=20OSCCLK=20during=20power-down=20mode=22.=0D=0A>=20=0D=0A>=20Re-parenting=
=20the=20MUX=20to=20OSCCLK=20allows=20lower=20clock=20rates=20for=20the=20U=
SI=20blocks=0D=0A>=20than=20the=20DIV_CLK_PERIC0_USI=20can=20offer.=20For=
=20a=20USI=20clock=20rate=20below=0D=0A>=206.25=20MHz=20I=20have=20to=20eit=
her=20reparent=20MUX_USI=20to=20OSCCLK,=20or=20to=20propagate=20the=0D=0A>=
=20clock=20rate=20to=20the=20common=20divider=20DIV_CLKCMU_PERIC0_IP.=20I=
=20find=20the=0D=0A>=20propagation=20to=20the=20common=20DIV=20less=20desir=
able=20as=20a=20low=20USI=20clock=20rate=20affects=0D=0A>=20I3C=20by=20lowe=
ring=20its=20clock=20rate=20too.=20Worse,=20if=20the=20common=20bus=20divid=
er=20is=20not=0D=0A>=20protected=20(using=20CLK_SET_RATE_GATE),=20USI=20can=
=20lower=20the=20I3C=20clock=20rate=0D=0A>=20without=20I3C=20noticing.=0D=
=0A>=20=0D=0A>=20Either=20re-parenting=20the=20MUX_USI=20to=20OSCCLK,=20or=
=20propagating=20the=20clock=20rate=20to=0D=0A>=20DIV_CLKCMU_PERIC0_IP=20al=
lows=20the=20same=20clock=20ranges.=20The=20first=20with=20the=0D=0A>=20ben=
efit=20of=20not=20affecting=20the=20clock=20rate=20of=20I3C=20for=20USI=20c=
lock=20rates=20below=0D=0A>=206.25=20MHz.=20Is=20it=20fine=20to=20re-parent=
=20MUX_USI=20to=20OSCCLK=20at=20run-time?=0D=0A>=20=0D=0A>=20If=20no=20feed=
back=20is=20received=20I=20lean=20towards=20propagating=20the=20USI=20clock=
=20rate=20to=20the=0D=0A>=20common=20divider,=20but=20by=20protecting=20it=
=20with=20CLK_SET_RATE_GATE.=0D=0A>=20=0D=0A>=20Feel=20free=20to=20add=20in=
=20To:=20or=20Cc:=20whoever=20might=20be=20interested.=20Thanks,=20ta=0D=0A=
=0D=0A

