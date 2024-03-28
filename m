Return-Path: <linux-kernel+bounces-122429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B1988F756
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140F41C259C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9382A47F69;
	Thu, 28 Mar 2024 05:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="RiYCCzYb"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DAD182A3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711604250; cv=none; b=rLjJpxdW6kjPAEwsbtwY1Cm8x+Y+hXxVwubJ0TBMx/sT90Ze8GBFh0q07Mux+cqAV6pGqakGPZnJ7L+drQDSfA83Z8zVboFgAtWJ+VwMXFxtBpBhElI90Oor/aaZkyVsr1RSNPeyVZ20DW32gTK5h4+EOzNo3oXkS89gpkRT78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711604250; c=relaxed/simple;
	bh=zA0sQ5lqjv7OoNTN8I18ArieYI10QoG2cgk6L4+07+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho8egn0cOTi7NKEdi4QHh+bCVmpPYaQVpYOVD245LaEWNB791gZ1tNo97B5hapYglp30khNf3LZOekqFcCVRDpYNwuFv6BjPCBZv7gsiUlNddrzwUTcbY1veWcsbljeNW1ljMqcQ6bE1t8eNfGfRbONV+47A2Zu4DrpTBAvupWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=RiYCCzYb; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1eea.dip0.t-ipconnect.de [79.254.30.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0C11E280F7D;
	Thu, 28 Mar 2024 06:37:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1711604242;
	bh=zA0sQ5lqjv7OoNTN8I18ArieYI10QoG2cgk6L4+07+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RiYCCzYbspGp7fe3esU7bz5KgcNmqh0aBu6sJ9P0wovHaJ3RLqtZ8N7TOTLcnhW4s
	 h2Dy3/ETTyVOjqd8Htc67YZC30DFUVA/ddEnECJlHw0YqLlaIcCFsRGt+74wT964sO
	 lcHzrq7WtIE97ubvmb7HdANHbjE995Cq5ecB2HZhR00E9DX8vWoqAbPM6zPYHGGko9
	 vBchvqAl96K4zR4JE1iVyy91HX1vESLZXy55F5CW5A1rkPf6uuiT7WxH1mWBSXJ+kk
	 k5wYLA1fSVn04ecR0J0noO2IWRq3Zt8nNgePYwF43sJBDnkI4gFom3PhPl7z3h/Rpn
	 pL7gmvp8eQwaQ==
Date: Thu, 28 Mar 2024 06:37:20 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Fixes for 6.9-rc
Message-ID: <ZgUCEIpXB_7rDoNz@8bytes.org>
References: <20240327181310.GA11801@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327181310.GA11801@willie-the-truck>

On Wed, Mar 27, 2024 at 06:13:11PM +0000, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-fixes

Pulled. Thanks Will.

