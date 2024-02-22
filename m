Return-Path: <linux-kernel+bounces-77282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C19F860332
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D54F1C21E94
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988F96AF92;
	Thu, 22 Feb 2024 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFHj/9Pw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A014B821;
	Thu, 22 Feb 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631409; cv=none; b=NSfkPsGCXMDmd1joECPqB77z7Ij6PtZr0Wh7ht4QYmqQWl55xQeuFDIUP0Iu9gGVSzHYpy2HENQk/Z4XLld38dDA/wCdfoxPjg/1TezFJsYTz6YR016WmpqWiOCElbwdsncFm23ng5jL+VjZhJ/A2MX2xHNpKm7KGdL6QUbTM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631409; c=relaxed/simple;
	bh=emzV0qVfct2Tihsbzr8sSMNIKYJBeOe0/MAYYwzGLB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SafIXcJYFvbeljgeh8lav1d/onJwAeszb0PviPdLPgYEXnLO0Mwu7vnBJdz1zBHi7fmiqb9yEcCIRLdT6qE3N3npvgN8TIcYwQjp19AA6xkbJWs9E6fCcnYeXgbmp+wGfJogVa3UOutP+uX1oyCGDcl83dr3QGMaYjQhkmMcZu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFHj/9Pw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADFBC433F1;
	Thu, 22 Feb 2024 19:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708631408;
	bh=emzV0qVfct2Tihsbzr8sSMNIKYJBeOe0/MAYYwzGLB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KFHj/9PwujHXyTIJGvEYVMkActVvOquJ67QxtR19n4shFwShiPJZhLAEqaTjMVDrc
	 snpBMP/mpkpopUSkB5vFCUD2kRRwm/6edS+3jFHKP6EyFI9vBtukQcd7VzTRtQNw1m
	 V+z6m366H+5hs7SSClJ/3ylyETV6mDT0lctF89ux9PA9haVqSqJiEGMPc6BT3+Hsgg
	 DYGaef77BQtAlH2lK9ikXz0A04fclBaf10ZTqoIsYvNiWIbEkPm3zJx3xt9FTK6jkZ
	 6fqdhfj5tVpqwQy8w2DLP7QNBGSWwqxg97aXjwLnCLnH+VwDqTyWa0X2j3wMUCwzC8
	 qm5VgNRz7pq5w==
Date: Thu, 22 Feb 2024 13:50:05 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: add common properties with label
Message-ID: <20240222195005.GA3735196-robh@kernel.org>
References: <20240216-dt-bindings-hwmon-common-v1-0-3c2c24ff1260@linaro.org>
 <20240216-dt-bindings-hwmon-common-v1-1-3c2c24ff1260@linaro.org>
 <f0f523c3-7b1c-404a-89c3-0c7345001676@roeck-us.net>
 <b21d351f-68be-4bca-a327-c35591c55610@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b21d351f-68be-4bca-a327-c35591c55610@linaro.org>

On Sat, Feb 17, 2024 at 09:21:46AM +0100, Krzysztof Kozlowski wrote:
> On 16/02/2024 18:11, Guenter Roeck wrote:
> > On 2/15/24 23:55, Krzysztof Kozlowski wrote:
> >> Linux hwmon core code parses "label" property for each device, so add a
> >> common schema for that.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> >  From hwmon perspective:
> > 
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > 
> >> ---
> >>   .../devicetree/bindings/hwmon/hwmon-common.yaml          | 16 ++++++++++++++++
> >>   1 file changed, 16 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/hwmon/hwmon-common.yaml b/Documentation/devicetree/bindings/hwmon/hwmon-common.yaml
> >> new file mode 100644
> >> index 000000000000..d83f4180f622
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/hwmon/hwmon-common.yaml
> >> @@ -0,0 +1,16 @@
> >> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/hwmon/hwmon-common.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Hardware Monitoring Devices Common Properties
> >> +
> >> +maintainers:
> >> +  - Guenter Roeck <linux@roeck-us.net>
> >> +
> >> +properties:
> >> +  label:
> >> +    description: A descriptive name for this device.
> >> +
> > 
> > Would it make sense to also add shunt-resistor-micro-ohms ?
> 
> It's not present on many devices, I think, so it is also not parsed by
> hwmon core. I plan to add above $ref to hwmon-common to each hwmon
> binding, so this would mean all of them will get shunt-resistor. I would
> not add it, but I also don't mind if I am overruled.

I count 11 users. That's enough for me to add it here.

I care less if a device uses a defined property it doesn't need. I'm 
more worried about having any undefined property allowed.

Rob


