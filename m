Return-Path: <linux-kernel+bounces-46191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A78843BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923772923D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739F669D2B;
	Wed, 31 Jan 2024 10:15:17 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C275769D04;
	Wed, 31 Jan 2024 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696117; cv=none; b=obCz5M8LCXJ0FtXhaRF7tLPR2A51gAHmRN/Fsa91q0bIGBgLWcsik2gqnyFdKAfuI0k1zdeKVWfEBOh2fLIaKVL/DR2aomkOcoiCFFFiPZCNKJk87qUvT6iEnt5PLlvYWoMWQYxr5myo1ilVhBpNnad/1XBkI8R4Xizk29enUAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696117; c=relaxed/simple;
	bh=zE7atyhsB0ICjwTR+4a5X+RwGnLd9/RTMpK45EX4/Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irukf6QYAI05OsMEhq+EMRoT7v6ah1h5n9Rrn9gvePIOyRTjECTEeGgmFFPnsBftsLLl3iirAoS229nQ1e+xMboPFymlotU3/I2oZsI2F8lv+Phnkc8rVn2+bzfxhhwWiH3g1mcpnu7aShZgQ+OkxTnKAxtdpAQbvlxwWiT/28I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp67t1706696090tpl50zk7
X-QQ-Originating-IP: 3hDmSx9p51noouzTbxu7X1MNULxVwlzajyDazx5QWYE=
Received: from [127.0.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 31 Jan 2024 18:14:01 +0800 (CST)
X-QQ-SSF: 00400000000000B0B000000A0000000
X-QQ-FEAT: rZJGTgY0+YPUJhLXtt3+osp2Psjk3ByoCl76BXgBr0QrdHFoKwX6kgAxfK7u8
	ho/jY25nBKHhHUuuIIEbEHuoRESE5IJQcrRePeJzddZ0+Lgro/JatUEphZpnhRoFr80MIsJ
	XSW2buqSC/BCRHHAzzpQEp30HlR2dnrC9D/HPvjArKg2EciNsmxO8Zidv+L9sg0scditkWL
	BQ4+CxXIsbMEGxyQwKR8LhbG/qo7/a7DuC14CvghMz7Ga0iwCZt2LJ+w0FYiZYag3hu6nR2
	Upm34/LoT4+8yqotb9C++oS62WmwVJlSzSglww6K+HzppHUWeJw4AvsMg4+0cUDyVr63gBe
	1QfuoelBm9J5Wqfy4fxGI9DlaD9Hkv398NOTKJSnieb5/LJwlJ4jyevDN8zmAc2Eb5jLgeQ
	BvjLQqPgIH57IX1xQr8vbg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6898810250905804753
Message-ID: <9B1126DC832EF7F2+2a6c2a9c-30ba-48d2-a808-3a25337441b7@shingroup.cn>
Date: Wed, 31 Jan 2024 18:14:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf/hx_arm_ni: Support uncore ARM NI-700 PMU
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: shenghui.qu@shingroup.cn, Rob Herring <robh+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 devicetree@vger.kernel.org, zhijie.ren@shingroup.cn,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 ke.zhao@shingroup.cn, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20240130081745.13750-1-jialong.yang@shingroup.cn>
 <170660659476.701701.9606670675803489364.robh@kernel.org>
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
In-Reply-To: <170660659476.701701.9606670675803489364.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1



在 2024/1/30 17:23, Rob Herring 写道:
> 
> On Tue, 30 Jan 2024 16:17:43 +0800, JiaLong.Yang wrote:
>> This code is based on uncore PMUs arm_smmuv3_pmu and arm-cmn.
>> One ni-700 can have many clock domains. Each of them has only one PMU.
>> Here one PMU corresponds to one 'struct ni_pmu' instance.
>> PMU name will be ni_pmu_N_M, which N means different NI-700s and M means
>> different PMU in one NI-700. If only one NI-700 found in NI-700, name will
>> be ni_pmu_N.
>> Node interface event name will be xxni_N_eventname, such as asni_0_rdreq_any.
>> There are many kinds of type of nodes in one clock domain. Also means that
>> there are many kinds of that in one PMU. So we distinguish them by xxni string.
>> Besides, maybe there are many nodes have same type. So we have number N in
>> event name.
>> By ni_pmu_0_0/asni_0_rdreq_any/, we can pinpoint accurate bus traffic.
>> Example1: perf stat -a -e ni_pmu_0_0/asni_0_rdreq_any/,ni_pmu_0_0/cycles/
>> EXample2: perf stat -a -e ni_pmu_0_0/asni,id=0,event=0x0/
>>
>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>> ---
>> If I should send Doc*/bindings/perf/*.yaml seperately?
>>
>>   .../bindings/perf/hx,c2000-arm-ni.yaml        |   58 +
>>   .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
>>   MAINTAINERS                                   |    6 +
>>   drivers/perf/Kconfig                          |   10 +
>>   drivers/perf/Makefile                         |    1 +
>>   drivers/perf/hx_arm_ni.c                      | 1308 +++++++++++++++++
>>   6 files changed, 1385 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
>>   create mode 100644 drivers/perf/hx_arm_ni.c
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml:54:1: [error] syntax error: found character '\t' that cannot start any token (syntax)
> 
> dtschema/dtc warnings/errors:
> make[2]: *** Deleting file 'Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.example.dts'
> Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml:54:1: found a tab character where an indentation space is expected
> make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.example.dts] Error 1
> make[2]: *** Waiting for unfinished jobs....
> ./Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml:54:1: found a tab character where an indentation space is expected
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml: ignoring, error parsing file
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240130081745.13750-1-jialong.yang@shingroup.cn
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

Done.

> 


