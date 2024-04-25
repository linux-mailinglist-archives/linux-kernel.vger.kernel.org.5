Return-Path: <linux-kernel+bounces-158530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBE88B21B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE14287F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4EC1494A8;
	Thu, 25 Apr 2024 12:34:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9CF1494D3;
	Thu, 25 Apr 2024 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048452; cv=none; b=fRAcAVWINmZ8+sI+NYvkbuiy+E2ODSz3Qs8++pzCaohRJws9ITU2T/1XWSCp0L63x5Veha7lQ8IXL1t8tQgf7ClBA7beysidWXVXE7mR1OuQciTEj/nBzRaFR3AjDHbbevyzUvVLVmP9jf15NPzzbEbqbaIaIr/v7RtNsrCF4fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048452; c=relaxed/simple;
	bh=UUBCWLtZL/tvNfG7En381wGTVtzQdc6q+vDY0op+NZs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AXt84exZb/G5R4Im8UDo3nTeOiHoMYS/Fd5JldkxiCu7ynsnL9a2RBi3QM+3WUcMwgW5/SQWcSq7hxp4DNkJ2x11HraGUXn963qVKCkbUusEQ7f5eR1DkQ8LDZkSmECiVf8qKX9f6tNlNOp8gKpqhna8m6X2tT2WBY+Cp6WRMBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B1CB1063;
	Thu, 25 Apr 2024 05:34:38 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CF3D3F7BD;
	Thu, 25 Apr 2024 05:34:09 -0700 (PDT)
Message-ID: <26479a31-c7ae-4f7a-8911-fb0d8dd42694@arm.com>
Date: Thu, 25 Apr 2024 13:34:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings/perf: Add Arm NI-700 PMU
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 jialong.yang@shingroup.cn, devicetree@vger.kernel.org
References: <cover.1713972897.git.robin.murphy@arm.com>
 <4992eacd883cbc54519ffea5bd35f80463cf504a.1713972897.git.robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <4992eacd883cbc54519ffea5bd35f80463cf504a.1713972897.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Oh fiddle, I forgot the DT list, apologies!

On 25/04/2024 1:29 pm, Robin Murphy wrote:
> Add an initial binding for the Arm NI-700 interconnect PMU. As with the
> Arm CMN family, there are already future NI products on the roadmap, so
> the overall binding is named generically just in case any
> non-discoverable incompatibility between generations crops up.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   .../devicetree/bindings/perf/arm,ni.yaml      | 30 +++++++++++++++++++
>   1 file changed, 30 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/perf/arm,ni.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/arm,ni.yaml b/Documentation/devicetree/bindings/perf/arm,ni.yaml
> new file mode 100644
> index 000000000000..d66fffa256d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/arm,ni.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/arm,ni.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Arm NI (Network-on-Chip Interconnect) Performance Monitors
> +
> +maintainers:
> +  - Robin Murphy <robin.murphy@arm.com>
> +
> +properties:
> +  compatible:
> +    const: arm,ni-700
> +
> +  reg:
> +    items:
> +      - description: Complete configuration register space
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 32
> +    description: Overflow interrupts, one per clock domain, in order of domain ID
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false

