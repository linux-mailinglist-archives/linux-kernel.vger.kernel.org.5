Return-Path: <linux-kernel+bounces-62237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D19851D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1C4285C28
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6B345014;
	Mon, 12 Feb 2024 18:58:04 +0000 (UTC)
Received: from 3.mo576.mail-out.ovh.net (3.mo576.mail-out.ovh.net [188.165.52.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B7341233
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.52.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764283; cv=none; b=U2ISnuru999kzobsZA56CA9TOQ10DlYMxuZrrOIcyDDUpP0ZGVHqK4UXR/hV+m8D8UI9mIyhYjINEXK547RiGuztiMXUADdurEOI77EJDguXVfwwY9BiWGHHN/OlfMlPmFD9o9Hr6h6seKbJKYwVq7aMokr5q7AHmScHQlG47qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764283; c=relaxed/simple;
	bh=jO/LDfn6aDcYiqRM9lNKahIwQkbLK8dKdTIoaO+VCXE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SklZADKJitNd9oFMBtbezIp0tcVPf/+GSyyF8aAO8Q+4ttMv1iyuLGyHUDYsm58jDYDVIkKDI2jO4nBMit+NDTvS4tnAcV0KcRj1xNv0fipgwMxn9dnPuNeeGl94LaFfnaEk7jyAIyJGQAH+HbJ2XVFJvbP32gTnorEMQ816+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=188.165.52.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director10.ghost.mail-out.ovh.net (unknown [10.108.2.160])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4TYVLY5xLbz1Tyb
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:30:29 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-r9552 (unknown [10.110.96.92])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5F6291FD3F;
	Mon, 12 Feb 2024 16:30:27 +0000 (UTC)
Received: from etezian.org ([37.59.142.95])
	by ghost-submission-6684bf9d7b-r9552 with ESMTPSA
	id 6FC5CKNHymUtFhgA7JOU9g
	(envelope-from <andi@etezian.org>); Mon, 12 Feb 2024 16:30:27 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-95G0010dc3974b-9b21-4c2d-b831-50956c5a016a,
                    DC9C46711153F1AB5CCD62E60A4660431976F56E) smtp.auth=andi@etezian.org
X-OVh-ClientIp:89.217.109.169
From: Andi Shyti <andi.shyti@kernel.org>
To: andersson@kernel.org, konrad.dybcio@linaro.org, 
 linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, vkoul@kernel.org, quic_bjorande@quicinc.com, 
 manivannan.sadhasivam@linaro.org, bryan.odonoghue@linaro.org, 
 dmitry.baryshkov@linaro.org, Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com
In-Reply-To: <20240212125239.7764-1-quic_vdadhani@quicinc.com>
References: <20240212125239.7764-1-quic_vdadhani@quicinc.com>
Subject: Re: [PATCH v4] i2c: i2c-qcom-geni: Correct I2C TRE sequence
Message-Id: <170775542582.4034843.13903178827406662061.b4-ty@kernel.org>
Date: Mon, 12 Feb 2024 17:30:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
X-Ovh-Tracer-Id: 5162532548027026139
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdekkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvegjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeffteehudffvdfhudfgffdugfejjeduheehgeefgeeuhfeiuefghffgueffvdfgfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdekledrvddujedruddtledrudeiledpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorghnughisegvthgviihirghnrdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejiedpmhhouggvpehsmhhtphhouhht

Hi

On Mon, 12 Feb 2024 18:22:39 +0530, Viken Dadhaniya wrote:
> For i2c read operation in GSI mode, we are getting timeout
> due to malformed TRE basically incorrect TRE sequence
> in gpi(drivers/dma/qcom/gpi.c) driver.
> 
> I2C driver has geni_i2c_gpi(I2C_WRITE) function which generates GO TRE and
> geni_i2c_gpi(I2C_READ)generates DMA TRE. Hence to generate GO TRE before
> DMA TRE, we should move geni_i2c_gpi(I2C_WRITE) before
> geni_i2c_gpi(I2C_READ) inside the I2C GSI mode transfer function
> i.e. geni_i2c_gpi_xfer().
> 
> [...]

Applied to i2c/i2c-host-fixes on

git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Thank you,
Andi

Patches applied
===============
[1/1] i2c: i2c-qcom-geni: Correct I2C TRE sequence
      commit: 32e9b680de4b46cfe835cbc7ee3dc721f7cc65fb


