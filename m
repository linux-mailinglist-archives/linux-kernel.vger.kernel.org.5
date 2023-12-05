Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AE2804856
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjLED4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLED42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:56:28 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F76C6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 19:56:34 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Skmp70yRHz1Q65W;
        Tue,  5 Dec 2023 11:52:47 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 11:56:32 +0800
CC:     <yangyicong@hisilicon.com>, <linux-arm-kernel@lists.infradead.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH] drivers/perf: hisi: Fix some event id for HiSilicon UC
 pmu
To:     Junhao He <hejunhao3@huawei.com>, <will@kernel.org>,
        <jonathan.cameron@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20231204110425.20354-1-hejunhao3@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <ead56142-e0a5-d061-b8f9-02add7a3b211@huawei.com>
Date:   Tue, 5 Dec 2023 11:56:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20231204110425.20354-1-hejunhao3@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/4 19:04, Junhao He wrote:
> Some event id of HiSilicon uncore UC PMU driver is incorrect, fix them.
> 
> Fixes: 312eca95e28d ("drivers/perf: hisi: Add support for HiSilicon UC PMU driver")
> Signed-off-by: Junhao He <hejunhao3@huawei.com>

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

> ---
>  drivers/perf/hisilicon/hisi_uncore_uc_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
> index 63da05e5831c..636fb79647c8 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
> @@ -383,8 +383,8 @@ static struct attribute *hisi_uc_pmu_events_attr[] = {
>  	HISI_PMU_EVENT_ATTR(cpu_rd,		0x10),
>  	HISI_PMU_EVENT_ATTR(cpu_rd64,		0x17),
>  	HISI_PMU_EVENT_ATTR(cpu_rs64,		0x19),
> -	HISI_PMU_EVENT_ATTR(cpu_mru,		0x1a),
> -	HISI_PMU_EVENT_ATTR(cycles,		0x9c),
> +	HISI_PMU_EVENT_ATTR(cpu_mru,		0x1c),
> +	HISI_PMU_EVENT_ATTR(cycles,		0x95),
>  	HISI_PMU_EVENT_ATTR(spipe_hit,		0xb3),
>  	HISI_PMU_EVENT_ATTR(hpipe_hit,		0xdb),
>  	HISI_PMU_EVENT_ATTR(cring_rxdat_cnt,	0xfa),
> 
