Return-Path: <linux-kernel+bounces-123302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0381789064A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331B01C30905
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D3A137746;
	Thu, 28 Mar 2024 16:48:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C4043176;
	Thu, 28 Mar 2024 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644520; cv=none; b=ZjMk0rZAKhQqpJ1hhgwU8VJmTUOmMWtT0vJK58vgR/9fJxvLPzY7jKI7LS4f517LjxgFo+TOziAdAITLWea169aQh+O+Md5IG+Oq3vkO7+GB+mYLtUds+Qv90mobO8q3sunp3Os6xTAnrie3JDQClE4/Cmr1Azc1WgK8oJi+ot4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644520; c=relaxed/simple;
	bh=9ly5amQocjcFvC1CcJYDOrRIEtZCFDVfD91fYk933iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddTidiSol8bkeOW6KLksKvILtCZL4v8NqTUdiRucRku5GOqYvTJsZWLCUne0ahf/CcUzzJ2R0hL3Pt+lS03vUacyksucmFrPENmuqdm8DNJOo1pFAD6vLy2F3LnnlT6svN3TWHe2DZN9/vU67RHnG9llL4XB7AYpNTN54pp1X3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06CD71476;
	Thu, 28 Mar 2024 09:49:11 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDD793F694;
	Thu, 28 Mar 2024 09:48:35 -0700 (PDT)
Date: Thu, 28 Mar 2024 16:48:33 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v6 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZgWfYZNR9M9zFI1v@pluto>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>

On Sat, Mar 23, 2024 at 08:15:13PM +0800, Peng Fan (OSS) wrote:
> This patchset is a rework from Oleksii's RFC v5 patchset
> https://lore.kernel.org/all/cover.1698353854.git.oleksii_moisieiev@epam.com/
> 

Hi,

beside a few more remarks on the series, I tested this again on my setup
with the latest v3.2 changes and it works fine.

Thanks,
Cristian

