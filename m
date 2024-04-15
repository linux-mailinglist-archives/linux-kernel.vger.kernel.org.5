Return-Path: <linux-kernel+bounces-144861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7756C8A4BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4ED1F22E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B875812A;
	Mon, 15 Apr 2024 09:48:45 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCE75789E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174525; cv=none; b=YkoQuNXfyCbbeTCApifIicaUWs4Nwl7b2cuVsGToARslkdSK0Cr2qcHqyWeaqNeDsoQyUCgTP2AtRWtyqgzGr30p1iqs6hMLqusJwgxJnfzMhguNE3Z1JkYDKOUMlg8Itm0w8wBQJG5/ilJzBwWV0HeSVE1YUcq013FWt2mWTxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174525; c=relaxed/simple;
	bh=FUu/1U3bMfwe1Wxlff4HfG4iKHHsFJST5Zn6hkOB0qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QMqggtnQWd/1NiNowwkvCh51otDeIEVW0GwFGLvvwqS9R24VlDN62Y9vZp2kL4KAurF1O88jNcSbBTjPRiACRhKbya3rrNX0okNhI+FgI370EuCuaDNFwT84BE9Z9qo1IAu1F8S/0deoydybDIVLBBB9slV0QiiRx+esvtVSp9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VJ2Qf4G5czYdNB;
	Mon, 15 Apr 2024 17:47:38 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 026B318005D;
	Mon, 15 Apr 2024 17:48:39 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 15 Apr 2024 17:48:37 +0800
Message-ID: <e3e305c6-e8cc-6b10-fd52-fcb20ee6d3cf@huawei.com>
Date: Mon, 15 Apr 2024 17:48:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 4/9] arm64/cpufeature: Simplify detect PE support for
 FEAT_NMI
To: Mark Brown <broonie@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <james.morse@arm.com>, <suzuki.poulose@arm.com>,
	<yuzenghui@huawei.com>, <tglx@linutronix.de>, <mark.rutland@arm.com>,
	<ardb@kernel.org>, <anshuman.khandual@arm.com>, <miguel.luis@oracle.com>,
	<joey.gouly@arm.com>, <ryan.roberts@arm.com>, <jeremy.linton@arm.com>,
	<daniel.thompson@linaro.org>, <sumit.garg@linaro.org>, <liwei391@huawei.com>,
	<peterz@infradead.org>, <jpoimboe@kernel.org>, <ericchancf@google.com>,
	<kristina.martsenko@arm.com>, <robh@kernel.org>,
	<scott@os.amperecomputing.com>, <songshuaishuai@tinylab.org>,
	<shijie@os.amperecomputing.com>, <bhe@redhat.com>,
	<akpm@linux-foundation.org>, <horms@kernel.org>,
	<rmk+kernel@armlinux.org.uk>, <Jonathan.Cameron@huawei.com>,
	<takakura@valinux.co.jp>, <dianders@chromium.org>, <swboyd@chromium.org>,
	<frederic@kernel.org>, <reijiw@google.com>, <ruanjinjie@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kvmarm@lists.linux.dev>
References: <20240411064858.3232574-1-liaochang1@huawei.com>
 <20240411064858.3232574-5-liaochang1@huawei.com>
 <Zhx/FKeAtzResmtP@finisterre.sirena.org.uk>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <Zhx/FKeAtzResmtP@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200013.china.huawei.com (7.221.188.133)

Mark,

在 2024/4/15 9:12, Mark Brown 写道:
> On Thu, Apr 11, 2024 at 06:48:53AM +0000, Liao Chang wrote:
>> From: Jinjie Ruan <ruanjinjie@huawei.com>
>>
>> Simplify the Non-maskable Interrupts feature implementation with
>> ARM64_CPUID_FIELDS macro.
> 
> Just squash this into the patch you're updating (I already have that
> locally for my half rebased version of the series).

Acked, thanks for suggestion. I've squashed the 4th and 5th patches into
the 2nd patch of the series in v2. Please review the updated series v3 and
let me know if you have any futher comments.

Thanks.

-- 
BR
Liao, Chang

