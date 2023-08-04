Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A372A76F759
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 03:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjHDB7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 21:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjHDB7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 21:59:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623914680
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 18:59:38 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RH8381LxpzJrJk;
        Fri,  4 Aug 2023 09:56:52 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 09:59:36 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 09:59:36 +0800
Subject: Re: [PATCH -next] workqueue: use LIST_HEAD to initialize cull_list
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20230803075135.499536-1-yangyingliang@huawei.com>
 <CAJhGHyDMoX6MfPiEBgJ_6CCCetCfFsas=TEQU8PfNuUjE9TH0w@mail.gmail.com>
 <ZMxCFq1RHHi2Hc2w@slm.duckdns.org>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <4604a942-2b19-0a26-a0fd-86f30a823024@huawei.com>
Date:   Fri, 4 Aug 2023 09:59:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ZMxCFq1RHHi2Hc2w@slm.duckdns.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/8/4 8:11, Tejun Heo wrote:
> On Thu, Aug 03, 2023 at 05:50:42PM +0800, Lai Jiangshan wrote:
>> On Thu, Aug 3, 2023 at 3:54 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>>> Use LIST_HEAD() to initialize cull_list instead of open-coding it.
>>>
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
> I don't have this patch in my inbox. Yang, can you pelase resend?
OK. I will resend it.
>
> Thanks.
>
