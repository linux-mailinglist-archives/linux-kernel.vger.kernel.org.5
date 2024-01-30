Return-Path: <linux-kernel+bounces-44248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC40841F50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06D11C24A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366D860861;
	Tue, 30 Jan 2024 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfZbjuox"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD159169;
	Tue, 30 Jan 2024 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606597; cv=none; b=ui1zkAcull+E2MwxUYS0O+4xKPOFwz7SN5LMPsb3lC86mFbv5EHt9j7jmGp821Y4m/O28EEugPHmaSyriltEZGgTLnZNi1UcEsebqY6pYpBX7btiyBYK3+nuKzwExKGIA8w5Q3qdtrsVlUBlqE0m4NIDrAoGFe0fMmqi2OiK8l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606597; c=relaxed/simple;
	bh=mkLHMPeFE3AGTkisCBI6lOVpOPvYousP3utuW4xr0FI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=djNUbY/dX2MvYeJfS/UEvr16KZk8XWRHYMVSZkGhXe90dokKqYDipEr4Vnr8Onq/jS11nHbS/54Qe1fhnrOYEkaMXgOcAZlJp135PJwCkr9r8QuPs3/MsIykvZqQaeAqUK4EjeCWpQAuaqyc6ikcs6FPomvf2r/NcajdFZaXcvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfZbjuox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4277C43330;
	Tue, 30 Jan 2024 09:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706606597;
	bh=mkLHMPeFE3AGTkisCBI6lOVpOPvYousP3utuW4xr0FI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UfZbjuoxeEKQ1yDpEs6cT2KdYKS1MyHe855wmBUbH+Qv6QALO+1xe9OoJ6Rl40j71
	 KVkbqaxbxmUfq1+qZQAT446b0rLhoZ6JlVA3too9sRtj+uk9HNnktRF6qPnQh7MsLJ
	 hydR9yKCMHxikdiKcQ4QWNvyaU3nnfeIYn3umGLRcupX99y5tSkHXDwsER4+fMJ7H3
	 YkoaGgFGJyeZM7OVOxorvvwRDpMOakfLDsJ7QM+PIvdwMw86TfCeDGVGvwxQg1zTWw
	 Hyo+lv4lgbm930YUPUymkQr9VOv8pE/kI5jV2J+sAEjIj0EE+Xaz0oTQcg2HqhwPaf
	 pmtG0Yl6X87iw==
Date: Tue, 30 Jan 2024 03:23:15 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: "JiaLong.Yang" <jialong.yang@shingroup.cn>
Cc: shenghui.qu@shingroup.cn, Rob Herring <robh+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 devicetree@vger.kernel.org, zhijie.ren@shingroup.cn, 
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 ke.zhao@shingroup.cn, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20240130081745.13750-1-jialong.yang@shingroup.cn>
References: <20240130081745.13750-1-jialong.yang@shingroup.cn>
Message-Id: <170660659476.701701.9606670675803489364.robh@kernel.org>
Subject: Re: [PATCH v1] perf/hx_arm_ni: Support uncore ARM NI-700 PMU


On Tue, 30 Jan 2024 16:17:43 +0800, JiaLong.Yang wrote:
> This code is based on uncore PMUs arm_smmuv3_pmu and arm-cmn.
> One ni-700 can have many clock domains. Each of them has only one PMU.
> Here one PMU corresponds to one 'struct ni_pmu' instance.
> PMU name will be ni_pmu_N_M, which N means different NI-700s and M means
> different PMU in one NI-700. If only one NI-700 found in NI-700, name will
> be ni_pmu_N.
> Node interface event name will be xxni_N_eventname, such as asni_0_rdreq_any.
> There are many kinds of type of nodes in one clock domain. Also means that
> there are many kinds of that in one PMU. So we distinguish them by xxni string.
> Besides, maybe there are many nodes have same type. So we have number N in
> event name.
> By ni_pmu_0_0/asni_0_rdreq_any/, we can pinpoint accurate bus traffic.
> Example1: perf stat -a -e ni_pmu_0_0/asni_0_rdreq_any/,ni_pmu_0_0/cycles/
> EXample2: perf stat -a -e ni_pmu_0_0/asni,id=0,event=0x0/
> 
> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
> ---
> If I should send Doc*/bindings/perf/*.yaml seperately?
> 
>  .../bindings/perf/hx,c2000-arm-ni.yaml        |   58 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
>  MAINTAINERS                                   |    6 +
>  drivers/perf/Kconfig                          |   10 +
>  drivers/perf/Makefile                         |    1 +
>  drivers/perf/hx_arm_ni.c                      | 1308 +++++++++++++++++
>  6 files changed, 1385 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
>  create mode 100644 drivers/perf/hx_arm_ni.c
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml:54:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.example.dts'
Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml:54:1: found a tab character where an indentation space is expected
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml:54:1: found a tab character where an indentation space is expected
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240130081745.13750-1-jialong.yang@shingroup.cn

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


