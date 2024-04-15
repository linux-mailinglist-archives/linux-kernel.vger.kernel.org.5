Return-Path: <linux-kernel+bounces-145278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C11798A51E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29311C226B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34B77868B;
	Mon, 15 Apr 2024 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="yOhZGQQc"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DD876057;
	Mon, 15 Apr 2024 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188323; cv=none; b=diIMphybTXk419Mmx78+uqK7SpJSsh91lJGmwL1paKPE4GBrssPYqt4urKdq43p/muqj8aFiSBDe+u12YaZVZvlMSp6asIb2m/lN3Hfr1OixtRxavO6756FIXI4m7Ms1VGofrOWr8HngcQ/qmRqj6AlrcbS2RV6dzovqW8po3kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188323; c=relaxed/simple;
	bh=GOpywjy/f47DDDysRmWIO2J0xCC64iHGAOQIV8Qj7F8=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u5hSBDYNXOKp5vyBLbfgwx196YxR3+OobPNQuJG14aO+WAuXcAhWqY8oUHUFpz/bEiLBGPmPbBgCU9JaOuKgec2wkO5HfjJ7Lj7JlgiJSjv1S5jcTLTqrupFIs8msQpXtB9hrx0KxzqTVoa8PSwCZffxGAPRHO1h36JFLqZNJl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=yOhZGQQc; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FAvxKD019795;
	Mon, 15 Apr 2024 15:38:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=
	selector1; bh=GOpywjy/f47DDDysRmWIO2J0xCC64iHGAOQIV8Qj7F8=; b=yO
	hZGQQcs0JCrB9Vu3qov1OfOnIOmxqQBmKC4yfedzFpzTpelm8breBeJ15EEr2iWH
	Bs0zBsY4RQTaUK8wIqdj3c9lQl4fPC5lhYUS552qxILUlYBsWQ8Znt1KocWqXxsd
	xqLYXvCuKruecAE03mqVqE1JhdBz9W1WjqkVb8urC4Nb7rzcq7StJ1nUn35dWMe1
	pl284g1xay3GC1J5aZw60MabS7mnvI5sMaqTudfHaY24GmdXDMQ3XlfupgQzTYEs
	SxiExgcgJsxMsibv97iBKwPN29G2u11tB1wAlCYvAGZYYeMEHg24QvAcARvd7a1P
	5X8+qL8NoOxGwk9Ifytg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xfhcwfup2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:38:04 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2AA584002D;
	Mon, 15 Apr 2024 15:37:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 94C75211F1E;
	Mon, 15 Apr 2024 15:37:13 +0200 (CEST)
Received: from [192.168.8.15] (10.48.86.102) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Apr
 2024 15:37:12 +0200
Message-ID: <d92eaa433cd2403c4f3c3b7e49aa8dbf0b3e256e.camel@foss.st.com>
Subject: Re: [PATCH 02/12] dt-bindings: interrupt-controller: stm32-exti:
 Add irq nexus child node
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>
Date: Mon, 15 Apr 2024 15:37:10 +0200
In-Reply-To: <87cyssa64a.ffs@tglx>
References: <20240216094758.916722-1-antonio.borneo@foss.st.com>
	 <20240216094758.916722-3-antonio.borneo@foss.st.com> <87cyssa64a.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_11,2024-04-15_01,2023-05-22_02

On Mon, 2024-02-19 at 15:19 +0100, Thomas Gleixner wrote:
> On Fri, Feb 16 2024 at 10:47, Antonio Borneo wrote:
> > The mapping of EXTI interrupts to its parent interrupt controller
> > is both SoC and instance dependent.
> > The current implementation requires adding a new table to the
> > driver's code and a new compatible for each new EXTI instance.
> >=20
> > Add to the binding an interrupt nexus child node that will be
> > used on the new EXTI instances and can be optionally used on the
> > existing instances.
> > The property 'interrupt-map' in the nexus node maps each EXTI
> > interrupt to the parent interrupt.
> > Align #address-cells and #interrupt-cells between the EXTI node
> > and its nexus node.
> >=20
> > Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>=20
> This S-O-B chain is broken as it suggests that you wrote the patch and
> Fabrice relayed it.
>=20
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#si=
gn-your-work-the-developer-s-certificate-of-origin
>=20
> But that's not the case. If you co-developed this with Fabrice then
> please use Co-developed-by. See:
>=20
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#wh=
en-to-use-acked-by-cc-and-co-developed-by
>=20
> Thanks,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tglx
>=20

Thanks for the review.
I'm sending a V2 addressing all the remarks.

Regards,
Antonio

