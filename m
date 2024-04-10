Return-Path: <linux-kernel+bounces-137814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E09689E7FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467841C211AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28EF522E;
	Wed, 10 Apr 2024 02:06:30 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBD21C2E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712714790; cv=none; b=YS+dO75RK1uiWLSKRNEtbPnxabj+3mCuZAc+ri1PQQ+i6PqFdJK3Sj4jgkNXaRpd0F7CiTMqDheiefdkxoXo+AzyJqV1N6o9cYhHg4e46X0Q1z0dp8xoS7sFZwksNWTHVSvK7X426a/DgJYWB7XPUKdE+IJLx2O6Xn/3fPQQqJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712714790; c=relaxed/simple;
	bh=IJseWqJozQjmQNwa4w8msgsxtQ0jKAXnnc/pU58tpTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EMA83iKzw6IuqfFbqJVoPxQxsVA5sPLjUg1PxtEvN9YirUBX7TAbgk+AAZN6uI9FGjQPDsS015T5ASqBIqbq62R1kjUD9KXAiMW/G/5JvBxIB4AckPhD+jiEs2M1vcEdMsOX/CJXyXd3aqyREMGXQ9OOeraKFElwh1g001kZNgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VDmPg5hYnzFrKD;
	Wed, 10 Apr 2024 10:05:27 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id C02941403D3;
	Wed, 10 Apr 2024 10:06:25 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 10:06:23 +0800
Message-ID: <522e857e-ed62-fb77-7aa2-00a872c4deb1@huawei.com>
Date: Wed, 10 Apr 2024 10:06:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/9] arm64/sysreg: Add definitions for immediate versions
 of MSR ALLINT
To: Mark Brown <broonie@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <james.morse@arm.com>, <suzuki.poulose@arm.com>,
	<yuzenghui@huawei.com>, <tglx@linutronix.de>, <mark.rutland@arm.com>,
	<ardb@kernel.org>, <anshuman.khandual@arm.com>, <miguel.luis@oracle.com>,
	<joey.gouly@arm.com>, <ryan.roberts@arm.com>, <jeremy.linton@arm.com>,
	<liwei391@huawei.com>, <daniel.thompson@linaro.org>, <sumit.garg@linaro.org>,
	<kristina.martsenko@arm.com>, <jpoimboe@kernel.org>, <ericchancf@google.com>,
	<robh@kernel.org>, <scott@os.amperecomputing.com>,
	<songshuaishuai@tinylab.org>, <shijie@os.amperecomputing.com>,
	<bhe@redhat.com>, <akpm@linux-foundation.org>, <thunder.leizhen@huawei.com>,
	<horms@kernel.org>, <rmk+kernel@armlinux.org.uk>, <takakura@valinux.co.jp>,
	<dianders@chromium.org>, <swboyd@chromium.org>, <frederic@kernel.org>,
	<reijiw@google.com>, <akihiko.odaki@daynix.com>, <ruanjinjie@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kvmarm@lists.linux.dev>
References: <20240409012344.3194724-1-liaochang1@huawei.com>
 <20240409012344.3194724-2-liaochang1@huawei.com>
 <5d06c9d8-a903-4cd9-be08-d7681e7928be@sirena.org.uk>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <5d06c9d8-a903-4cd9-be08-d7681e7928be@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200013.china.huawei.com (7.221.188.133)

Mark,

在 2024/4/9 20:28, Mark Brown 写道:
> On Tue, Apr 09, 2024 at 01:23:36AM +0000, Liao Chang wrote:
>> From: Mark Brown <broonie@kernel.org>
>>
>> Encodings are provided for ALLINT which allow setting of ALLINT.ALLINT
>> using an immediate rather than requiring that a register be loaded with
>> the value to write. Since these don't currently fit within the scheme we
>> have for sysreg generation add manual encodings like we currently do for
>> other similar registers such as SVCR.
>>
>> Since it is required that these immediate versions be encoded with xzr
>> as the source register provide asm wrapper which ensure this is the
>> case.
>>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> ---
>>  arch/arm64/include/asm/nmi.h    | 27 +++++++++++++++++++++++++++
> 
> You've not provided a Signed-off-by for this so people can't do anything
> with it, please see Documentation/process/submitting-patches.rst for
> details on what this is and why it's important.

Acked, thanks for the heads-up. I'll add Signed-off-by tags to the relevant
patches in the next revision. This includes patches from your FEAT_NMI patchset
and Jinjie's contribution.

-- 
BR
Liao, Chang

