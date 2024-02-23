Return-Path: <linux-kernel+bounces-78403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AEE861303
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FD4BB23520
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D7E7EF06;
	Fri, 23 Feb 2024 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gmKWY4aC"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE237C6E5;
	Fri, 23 Feb 2024 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695660; cv=none; b=CtxcJ4NWf6HK4QeCbqqHBc8xUP/aOm4QKPlxNMGD9RyYIEcYtp1s12Cu7NT3qspaGK5aLCbRqu5miHqALVXq2lhlhr4GBPdJBY6muzPYfvkuf4EbEDtCISypFmuULhkg5PU7Dkapmqjf/TnVfKAsnPkudb5RJsQRIMeWMXpXTLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695660; c=relaxed/simple;
	bh=PUdaN+NOyiFko6ApVjfQUO99UPdl8r3ljDhSfM9je4I=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kkYzTjMPg6x/TK/zoRD6BIfgdV4NuqawAmidd6RmduLLbiYYbsNxuwkdkY4EC+EFCi2JPYDQDAvSwJ7pS0uJCT+mi0GsUi3Wmo12gXG2efOle4YwPI7gQ+fE0yFAFhfosNDgVKl8BCe51aoNLuJW/ZjZnwpNbkXVJC4GgCMLSu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gmKWY4aC; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NBw6P6025967;
	Fri, 23 Feb 2024 14:40:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=
	selector1; bh=PUdaN+NOyiFko6ApVjfQUO99UPdl8r3ljDhSfM9je4I=; b=gm
	KWY4aCZqrkRS2Qaq06UuV+RBt72dfljhqYIuva4PStKzOdrAyUhPAFIi62vE1MbS
	2QvWTc6PcHoh0LOjJtvqldsTwdA1WJ40G0dNLsf/Q9ynqzLQun+y9ZfAitMFFnck
	4flc3JmzFTAI33MC5OYzUsVHm8U31oMLp2+ISJgRK1tiNOR274sWDh9T/XJlCF3W
	FBuOFov8w40GUcVMQ0lD4vGr96a5EXeP2whCHq4iRzM8XE1pn5NqBosK9yOTRjnS
	GANfQy6gfNQSIOyNjJWJkiP+VAe9n24puIyyfgXpEfpkCy8tTzJPWGSk00SAa9rM
	y6B0VUCQu4nFZJPaXqrA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wd2024w03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:40:18 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E9FE040044;
	Fri, 23 Feb 2024 14:40:13 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DF21A29D7F4;
	Fri, 23 Feb 2024 14:39:26 +0100 (CET)
Received: from [192.168.8.15] (10.201.20.114) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 23 Feb
 2024 14:39:26 +0100
Message-ID: <2eb11bf9dc0c5f49de3fb72c44dd16d8ca136813.camel@foss.st.com>
Subject: Re: [PATCH 02/12] dt-bindings: interrupt-controller: stm32-exti:
 Add irq nexus child node
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Rob Herring <robh@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>
Date: Fri, 23 Feb 2024 14:39:25 +0100
In-Reply-To: <20240222234300.GA3809915-robh@kernel.org>
References: <20240216094758.916722-1-antonio.borneo@foss.st.com>
	 <20240216094758.916722-3-antonio.borneo@foss.st.com>
	 <20240222234300.GA3809915-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02

On Thu, 2024-02-22 at 16:43 -0700, Rob Herring wrote:
> On Fri, Feb 16, 2024 at 10:47:47AM +0100, Antonio Borneo wrote:
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
>=20
> Looks like an abuse of interrupt-map. You avoid adding yourself to the=
=20
> abuser list by putting it in a child node. Clever. (See list in=20
> drivers/of/irq.c if you don't know what I'm talking about)

Hi Rob,
thanks for the review.

Yes, I know already about the abuser list but, from the commit
message and the associated comment, I interpret it as an incorrect
use of the property interrupt-map with custom syntax thus relying=20
on custom parsing code.
The child nexus node in this series allows using the default parser
in kernel.

From your reply, looks like my interpretation is incorrect and I
missed the real concern about the abuser list.
Could you please explain why this use of interrupt-map is incorrect
and/or which are the correct use cases?

> I assume the EXTI has 0..N interrupts. Just define 'interrupts' with N=
=20
> entries with each entry mapping EXTI interrupt N to 'interrupts' entry=
=20
> N.

Yes, EXTI has 0..N interrupts that can be mapped to multiple
parent interrupt controllers and the mapping table has holes.
While the DT in this series only use one interrupt parent, a second
parent will follow.
So 'interrupts-extended' property would be a better matching than
'interrupts' to handle the multiple parents.

But how to code the missing entries in an 'interrupts-extended' list?
As in the example in Documentation/devicetree/bindings/dma/apple,admac.yaml=
 ?

The 'interrupt-map' contains the matching EXTI index, thus allowing
a 'sparse' map where holes are simply ignored.

Best Regards,
Antonio


