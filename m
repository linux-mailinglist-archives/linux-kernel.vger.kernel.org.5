Return-Path: <linux-kernel+bounces-111947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D6688731D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432EB2854EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D1C171A6;
	Fri, 22 Mar 2024 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqMVwH0X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324C3EA6F;
	Fri, 22 Mar 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132212; cv=none; b=HXrpnKA3PkHiNjY7cBF/wb52sb0JtOP+LtA+n8NAVme9lsMKFtPYOL4wIwysxZgud0Hi225CmuZwf8NlwVMI2FgnBRELxa5qLuoD9kNs3MH3MrKKnHwWBW86RxLMEnmTYegMk1jBxtTlzbZ+fEiojSVTW4R/D2BEWThBsA5OLXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132212; c=relaxed/simple;
	bh=8FL31bqszZm9IGAOvPx565fgUKDVGSLzANi1NhRoWec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCYzigbXm/TZZAlWNzX8Mhoa1yhvAzTivkyIK3ezXoqdzHIRsM0e8bRXwFoqfN1x3FPe0IeStsnsy7ObYMziGCUyQurC9QpJf3gUZzqGlCF7HZEzdD3nSB8NaB4T3lRlNIvLd0MCJrPnsoMB7/1LzhGf6MnK+8e7kP5b8bBZRkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqMVwH0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A14C433C7;
	Fri, 22 Mar 2024 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711132211;
	bh=8FL31bqszZm9IGAOvPx565fgUKDVGSLzANi1NhRoWec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IqMVwH0XViHF1WJUTiXQzFdYNBaiMDrDQgnShb0QIPQK21eZidBDmpwlcvGqHIASW
	 kQ5z0TFtFvqkJ5Kwa3gnO30jcHg3KbgKmi829VX4hIxN6/esgiEKcH+Poojk+kbWFD
	 s9MLPMpXo1avCNel56dQSo3JalV3RYDW2r9/uy6+LYxMg7r25oH1Q9wCRNKP60BJF7
	 u9iz++otSe3f5hVI5K9NRP6otpeSwDiLLbf8480u5LooXsuu1qCiUM6YfWZqK2+Bjz
	 2GLjaYKtd1tlPoR+Xcp5/bW1FMNmv1u6fo3+FCk38REVs6A7d61rPtrsMrtkfsMomy
	 v5C3s0O1FRqyw==
Date: Fri, 22 Mar 2024 13:30:09 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Allen_Lin <allencl_lin@hotmail.com>, dmitry.torokhov@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jikos@kernel.org, benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
Message-ID: <20240322183009.GA1227164-robh@kernel.org>
References: <20240322085606.993896-1-allencl_lin@hotmail.com>
 <TY0PR06MB56116F0902017225C78EDDDD9E312@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240322-mammary-boil-f9a4c347fba1@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322-mammary-boil-f9a4c347fba1@spud>

On Fri, Mar 22, 2024 at 05:54:08PM +0000, Conor Dooley wrote:
> On Fri, Mar 22, 2024 at 04:56:03PM +0800, Allen_Lin wrote:
> > Add the HX83102j touchscreen device tree bindings documents.
> > HX83102j is a Himax TDDI touchscreen controller.
> > It's power sequence should be bound with a lcm driver, thus it
> > needs to be a panel follower. Others are the same as normal SPI
> > touchscreen controller.
> > 
> > Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> 
> note to self/Krzysztof/Rob:
> There was a previous attempt at this kind of device. This version looks
> better but might be incomplete given there's a bunch more properties in
> that patchset:
> https://lore.kernel.org/all/20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com/

Those don't look like properties we want coming back.

Rob

