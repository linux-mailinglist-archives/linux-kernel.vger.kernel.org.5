Return-Path: <linux-kernel+bounces-92506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E38872155
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CDA1F25EDE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D38486630;
	Tue,  5 Mar 2024 14:17:11 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2D86AE2;
	Tue,  5 Mar 2024 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648230; cv=none; b=JYFnPmCAH7wGmbWlexgdCdzMP7zIHAt0EjW6GaM9kkTaFSp7GmgYtOkCUr8mfsHULfkD8zKmHEPJTUZVpF0sFgDj0DSHQhWwmCWDIMSN0bdY5U+p2uBh7lLo61/flq8kHfOxpOp+YMz3ULXsWCdmzSQT5ONvgnmtwR5AnI3rCFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648230; c=relaxed/simple;
	bh=xdgJ9F0RgLJwUJcHzE4T9iGwZ+MjZxy0ntiV1D3KzPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpNFxTLMR+6fR9SqcYDJZtcHVGaM3GfJadzz6BYlnXaU0Ubr8I20E8EMbKTIgI75L1u1auszHlzGrlyZDg3c3E6kwPJ60qCrgpv1d0wiFz7g33b90cplJCu6+Emp5h1E/TRcPMKjVgOxZTdfi0nXmbrd40SrE/+z427XyEeUmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpipv601t1709648175tbrp
X-QQ-Originating-IP: IxHRVeKC2DXxxEzD41W84GxArjINfZ7NsUKKWFqZL8M=
Received: from [IPV6:2409:8a20:4c7e:d580:7d3e: ( [255.60.145.1])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 05 Mar 2024 22:16:14 +0800 (CST)
X-QQ-SSF: 00400000000000B0B000000A0000000
X-QQ-FEAT: 5q30pvLz2ieD1BXimzetlg/X9OUaHwAyX7KTsn77LnG4/z95p50VPgubGk+5F
	2tMN+NEyRVscQKADQvL7xK9CqtDBV/ooigKYQ1Ic880MI/rtoRlNFeN0iieYzSG/ocVad47
	xMJ8QJZGW1EDPMraDTHwKKuzVG4zt+syw1OtUKvOMBYv7vG/+Qofy422cKNn/NtyUnEqKS9
	GH5bik3IoVwEsWS7kltTZn2DbbAXJVTVzr9ADZ+O4leGf/Ns7BSyvH/93oxmiRkJcQq50n3
	UPbphRskeBRV5y/OkwOWGDhr8JIruXokjGb5oE/dr8Ap4XwI6azKpf7LC1h5BiehL+kkRUR
	Aml0I0aaoFFMgfLfu48rYzH8+ot4ZC7iUh5um//k3aOwbLXmLjway4QJZUuY0zBZVsl+tlu
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 18177786939764390676
Message-ID: <C179F8ADAF657FB4+0d190e88-02b6-49a4-96bd-844e470b4605@shingroup.cn>
Date: Tue, 5 Mar 2024 22:16:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/s390/perf: Register cpumf_pmu with type =
 PERF_TYPE_RAW
To: Mark Rutland <mark.rutland@arm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240304022701.7362-1-jialong.yang@shingroup.cn>
 <ZeWVi6pua5QVqz_y@FVFF77S0Q05N>
 <ACE696AA8DB8D91B+458ebdd8-6951-4f72-a188-b21dc9863b90@shingroup.cn>
 <ZecStMBA4YgQaBEZ@FVFF77S0Q05N>
From: Jialong Yang <jialong.yang@shingroup.cn>
In-Reply-To: <ZecStMBA4YgQaBEZ@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1


在 2024/3/5 20:40, Mark Rutland 写道:
> On Tue, Mar 05, 2024 at 09:43:16AM +0800, Yang Jialong 杨佳龙 wrote:
>> 在 2024/3/4 17:34, Mark Rutland 写道:
>>> On Mon, Mar 04, 2024 at 10:27:01AM +0800, JiaLong.Yang wrote:
>>>> The struct pmu cpumf_pmu has handled generic events. So it need some
>>>> flags to tell core this thing.
>>> It's not necessary to register as PERF_TYPE_RAW in order to handle raw events,
>>> and PERF_TYPE_RAW is not a flag.
>>>
>>> Have you encountered a functional problem, or was this found by inspection?
>> As you expected, I'm trying to confirm which one pmu has the capability to
>> handle generic events in registering pmus instead of test generic events in
>> each pmus when opening.
> If we want to do that, then we need a new flag on struct pmu to restrict which
> events we try to open on a PMU.
>
> If you want to do that, you need to Cc the perf maintainers and discuss that
> rather than point-hacking individual drivers.
>
>> We can confirm that before using. We have pay more in handling them when
>> opening.
>> So most driver developers use PERF_TYPE_RAW. x86 and arm use
>> PERF_PMU_CAP_EXTENDED_HW_TYPE. Others use struct pmu::task_ctx_nr =
>> perf_hw_context.
>> I think PERF_TYPE_RAW will be a easily accepted way. So ...
> No, this is a hack, and it doesn't solve the problem you describe above.
>
> If we want to remove the need for most PMUs to look at perf_event_attr::type,
> then we should have a new PERF_PMU_CAP_ flag on the PMU to say "this PMU
> supports generic events" (or separate flags for the generic RAW/HW/CACHE
> types), and update all relevant PMUs accordingly.
>
> Please do not try to overload pmu::type with additional semantics; it's messy
> enough as-is.

OK. Thanks for guiding.


>
> Mark.
>


