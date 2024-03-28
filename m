Return-Path: <linux-kernel+bounces-122523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A6C88F90D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04FF5B25023
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF2552F6D;
	Thu, 28 Mar 2024 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5XD/tZy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554A1E89C;
	Thu, 28 Mar 2024 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611906; cv=none; b=ZaRosgLSbPQFZMPk71qnHkJaejcBKJoJIyS4YONAh/rGthVsOfaSKSLs5qxTWx8ZFrn4o9oGG41Y+PP+RXg25KWskzz80UP1Uno/vR9zjB0/QdxZCNP1nAafeTN5bMLLKa/gd94cWBv1oIsBlwCrDogGfw+V1GaTdv2KHizRg54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611906; c=relaxed/simple;
	bh=ZnhEYw2AdYvi+WfQmQahcGAp9NAli8bS0MnlSGLMs48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QceruSQMMOhyKc3t4ZjOUDC3dqKlC8GvMoiOd06/knbuwukOCOwFjGS598NzfUAztISiOgJAQh9eh2NdqrKhs/S57ujGfWteADKPwn1szGKKbZ4vdG0oCBr6WSyAE2bU4A0a3GO30PREJ8a3hl1fSYyscTakYXBJNw9YTfisbj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5XD/tZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83784C433F1;
	Thu, 28 Mar 2024 07:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711611905;
	bh=ZnhEYw2AdYvi+WfQmQahcGAp9NAli8bS0MnlSGLMs48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5XD/tZymcUjrdTz1E/O4GBETtRsIwUSpbDdnrdDpJF/aCuE1FX9aR2VstvOJOd0+
	 FzcwhWVMNDO2iry0c7MI9KEqG61zTxlwIs3qB6wiND+PKR7u2M5CgzCNmsOJPZA6qx
	 8M77j1e/AUXZZZzlSbv4c60Q3RYNEP5HMM0287nJkdz5SvMxPbezLpiwUPpAWG/ReU
	 U46gb4jqjSJRTr5XWV57k55br5kXwcvhWP+wN/sSp8UeYrJeNu0gk9MgblWUQno9K6
	 Pi9/6dHEZBvxFFwoX3g3j1kgadFTV39y+BYuZZf16aUBdQ++jq3z5qQi+EEMZm5/5V
	 Yw+wEzCNyNKaw==
Date: Thu, 28 Mar 2024 13:15:00 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
	kishon@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] phy: qcom-qmp-ufs: Add SM8475 support
Message-ID: <ZgUf_I2KBMhenNEv@matsya>
References: <20240327180642.20146-1-danila@jiaxyga.com>
 <20240327180642.20146-3-danila@jiaxyga.com>
 <afcbb668-ab9e-4f97-9014-ecbd5170ab92@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afcbb668-ab9e-4f97-9014-ecbd5170ab92@linaro.org>

On 27-03-24, 22:38, Konrad Dybcio wrote:
> On 27.03.2024 7:06 PM, Danila Tikhonov wrote:
> > Add the tables and constants for init sequences for UFS QMP phy found in
> > SM8475 SoC.
> > 
> > Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> > ---
> 
> Worth mentioning that SM8475 is a respin of SM8450 on a different
> process node, which probably forced some electrical changes.

should the tables be resued from 8450 instead of 8550 as in this patch?

-- 
~Vinod

