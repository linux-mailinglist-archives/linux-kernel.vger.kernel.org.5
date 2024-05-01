Return-Path: <linux-kernel+bounces-165375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2BC8B8BE9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99987284E6D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CED134DE;
	Wed,  1 May 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="Gj1zUbgo"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71021527AD;
	Wed,  1 May 2024 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573981; cv=none; b=B1aoMW592ZQnFDgw9BHto7HtuA92dKDwjWlBipzKznaz+eth0aCgwpDxZcHVCp15pPIa3DBMd5OCdhPTMTo2Hb6inb4iJ2W4Oo56Jt/JjvmElo1bIFEI3ACDiHAiy1WJ9quTXKXrOPqkUTZctT1GjAZloJ0Tw9FW4neWeK/S4ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573981; c=relaxed/simple;
	bh=GXoUH7B/P9A2dDs/RYb7yImJqNo6d6mfYWXhoD3vawU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxM9WvqnmLAL3oVpl1TF12QINQBYM1R5k2HMrXS0ee+x/vQAXzrKVNHtC+ncLl7Zap3IeysCWzxSHKwfC1tTWTcrCA7qfqpkDelLLiOV4KpDDcgKQ6xCak2WP/o9/klcNTNL7dBL84p76e3rF0nlIfGhm/qXgrHULJqjg+OxNsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=Gj1zUbgo; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355092.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4416165t029171;
	Wed, 1 May 2024 14:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=DKIM202306; bh=GXoUH7B/P9A2dDs/RYb7
	yImJqNo6d6mfYWXhoD3vawU=; b=Gj1zUbgoeBxnQ/SeJruTSI7gcU1R0joFV54A
	Tvtu2e50rBpgQPF7RbeRCszWezPzxHDhpELXU2N1waXEDiSzsLlTSfh0AMQbz0T6
	tDgw52C80jAwfDvXYsINtHu8Z2iIZWzFzMUQjhVMV8i0gPH1ixA0ZhPXJGdKKC1Z
	kJFwtCdko8HOwFzu2WM13MYEXM8WHnKRp7Y6VJujTeCDYwk9VSVXqFtIm96pX8Qp
	KG1AF1VXDY6VDXnd8mKvyAOL10nwfQmMsWulNZUVUJDAsxVbBrB1vYEYfju5saK7
	QupgLx8QGqY5bh73OFrGXOEtQ9+Zq6zANJ30WP5XJnAwScnNmA==
Received: from ilclpfpp01.lenovo.com ([144.188.128.67])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3xug3pgf8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 14:32:30 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ilclpfpp01.lenovo.com (Postfix) with ESMTPS id 4VTzzx6MS4zfBZq;
	Wed,  1 May 2024 14:32:29 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4VTzzx5pdsz3p6jp;
	Wed,  1 May 2024 14:32:29 +0000 (UTC)
Date: Wed, 1 May 2024 09:32:28 -0500
From: Maxwell Bland <mbland@motorola.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ptdump: add intermediate directory support
Message-ID: <xg6hbbnoytkju6trv2f5orj2sfexj7g2vrhjku3f6iwsicn7c3@bzrfpxpmhh7c>
References: <fik5ys53dbkpkl22o4s7sw7cxi6dqjcpm2f3kno5tyms73jm5y@buo4jsktsnrt>
 <ZjIwiFa3CMxxtAZ1@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjIwiFa3CMxxtAZ1@arm.com>
X-Proofpoint-GUID: fAXxpbWjub_vGxKwt14zl18QMB219Lvz
X-Proofpoint-ORIG-GUID: fAXxpbWjub_vGxKwt14zl18QMB219Lvz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_14,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=968 priorityscore=1501 mlxscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405010101

On Wed, May 01, 2024 at 01:07:36PM GMT, Catalin Marinas wrote:
> Is this v3 replacing v2 here:
> https://lore.kernel.org/r/20240423142307.495726312-1-mbland@motorola.com
> or it goes on top?

Replacing. Sorry for the confusion---my mailer broke the previous
versions' formatting.

I am new to linux kernel commits and our SMTP/IT was not set up for
patch submission, but this new workflow looks OK. (-:

Maxwell

