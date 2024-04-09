Return-Path: <linux-kernel+bounces-137473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3088189E29D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CD41C2296D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59688156F3F;
	Tue,  9 Apr 2024 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="2qc9t3i7"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADABE156C59;
	Tue,  9 Apr 2024 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687557; cv=none; b=DL48WSAWHRkwuIGhI8ZqCXabM+6A01wU3G+Iz4xvyi9xkJnSK99awSkd6QhDGEyeou0j5PbSNmIexbYpV2yGT+0/xioizY8cQxCsABgv+1QOcqKVH+/AUXSI2rnxpLDzu9pUSfDdpy0K9w66C/PR6j0UWbORm7yvNGsH4LY/Nuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687557; c=relaxed/simple;
	bh=pHkJ+0C4c6a26Bb5wDFsH4ryFH7WrAuqh4ZAgrgWB+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSEMGSa9CxNXTfT0TzQpIO3+oUGo20Z4NdlRsjVvY+FG3FMqlyZ3hN7Yn2sFJ8wMCGavYyP4VW7UNBqOvfKPVH4XesKenrGcHWuKA1o3hVRu7NYeVbtI2z5zYZDG4k9BhmPVxwOqCCkk+tb3OnAl6qc4bfbFeBMQT1Ofz3BABxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=2qc9t3i7; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712687547; bh=pHkJ+0C4c6a26Bb5wDFsH4ryFH7WrAuqh4ZAgrgWB+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2qc9t3i7xCFfSB/OiHDIneSLqpOOBDt/X4sfKwNVz3oPA5Ikj7EMOpYSU/ncbwMC1
	 RG8MGX3rJW8vY3PhjKQVl2ULqxy8C2Xxv9QQwjlrk/vHp7qWfRH/T/PxABAGNypwH5
	 exUUk2PANrB/9NVouoM+Z00LPNqRYakTj7ztiUjM=
From: Luca Weiss <luca@z3ntu.xyz>
To: Rob Herring <robh@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix up qcom,halt-regs definition in various schemas
Date: Tue, 09 Apr 2024 20:32:26 +0200
Message-ID: <2724472.mvXUDI8C0e@g550jk>
In-Reply-To: <20240409151041.GA1141635-robh@kernel.org>
References:
 <20240407-qcom-halt-regs-fixup-v1-0-a0ea4e2c178e@z3ntu.xyz>
 <20240409151041.GA1141635-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Dienstag, 9. April 2024 17:10:41 CEST Rob Herring wrote:
> On Sun, Apr 07, 2024 at 11:58:29AM +0200, Luca Weiss wrote:
> > The original motivation is that a bunch of other schemas fail to
> > validate qcom,halt-regs, for example like in the following examples:
> > 
> > arch/arm64/boot/dts/qcom/apq8016-sbc.dtb: remoteproc@4080000: qcom,halt-regs:0: [20] is too short
> >         from schema $id: http://devicetree.org/schemas/remoteproc/qcom,msm8916-mss-pil.yaml#
> > arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb: remoteproc@2080000: qcom,halt-regs:0: [82] is too short
> >         from schema $id: http://devicetree.org/schemas/remoteproc/qcom,msm8996-mss-pil.yaml#
> > arch/arm64/boot/dts/qcom/apq8039-t2.dtb: remoteproc@4080000: qcom,halt-regs:0: [32] is too short
> >         from schema $id: http://devicetree.org/schemas/remoteproc/qcom,msm8916-mss-pil.yaml#
> > 
> > While I'm actually not quite sure why these patches fix this in
> > the other schemas - feels like a bug/limitation in dt-schema maybe? -
> 
> Was this with v2024.02? It should be a bit better there. Though it 
> may just have different errors. The limitation is that property 
> types and in the case of matrix's (which phandle-array actually is) 
> range for dimensions are global. So if there's not correct dimensions 
> for a property, the tools aren't going to decode it properly.

You're right, I doesn't look like I can reproduce this with the latest
dtschema installed.

Anyways these patches should be good to actually validate qcom,halt-regs for
the schemas I'm touching here.

Regards
Luca

> 
> Rob
> 





