Return-Path: <linux-kernel+bounces-130997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256108981B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6421F27435
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EE554915;
	Thu,  4 Apr 2024 06:54:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC7C5C611;
	Thu,  4 Apr 2024 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712213699; cv=none; b=H2dPL+7/+4ySbUP8+i0QK0Uki8Y1n7lnxQ+OhhnkwWSgGYMSRyQiYLPsu3vF+ZJitT9YBxo6q1SZFUUgsMvDsHvM0F9LeGmvvO48qz6y7vQeWaqHjN6qGRSYFfafOYQMrUeeKT/5VIR/WD7urLo1x3v+RhGAVqhn+SJ+zUHYPjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712213699; c=relaxed/simple;
	bh=YQXYVqAT5mJv/W1preeYCB4l4vf/608lyft2mGHyJJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/za3KfEzooitg1cZ81HtyIfWjXoxykbavIF1S7Ke/d0S4mcItIvLlXoQFtPZxviTNqZs/zQAEzwTmdG3oFfJVwnuzM+Vl870OeG8Rdk2OiOBclxnYMt/aKEcdW61mEUNC2H3TUFvaJuF7bIuFS6GVQsdaIJtfua5q/NS7TptAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E9861007;
	Wed,  3 Apr 2024 23:55:28 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA9CC3F64C;
	Wed,  3 Apr 2024 23:54:55 -0700 (PDT)
Date: Thu, 4 Apr 2024 07:54:45 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, sudeep.holla@arm.com,
	jassisinghbrar@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: mailbox: arm,mhuv3: Add bindings
Message-ID: <Zg5OtV0TBw43Bb-N@pluto>
References: <20240404062347.3219795-1-cristian.marussi@arm.com>
 <20240404062347.3219795-2-cristian.marussi@arm.com>
 <da62846c-884f-4059-a4bd-2e5f5c879e8b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da62846c-884f-4059-a4bd-2e5f5c879e8b@linaro.org>

On Thu, Apr 04, 2024 at 08:30:27AM +0200, Krzysztof Kozlowski wrote:
> On 04/04/2024 08:23, Cristian Marussi wrote:
> > Add bindings for the ARM MHUv3 Mailbox controller.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v2 -> v3
> > - fixed spurious tabs in dt_binding_check
> 
> Did you test this patch before sending?
> 

Tested with:

make -j8 DT_SCHEMA_FILES=arm,mhuv3.yaml DT_CHECKER_FLAGS=-m dt_binding_check

(with dtschema upgraded)

..and indeed even v2 was supposedly already tested (since included a
bunch of changes as advised), then I made a small last-minute nitpick and
my editor splipped in a couple of tabs...apologies for that.

Thanks,
Cristian


