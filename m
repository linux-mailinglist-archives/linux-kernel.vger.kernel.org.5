Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459967D450A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjJXBdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjJXBdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:33:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF800139
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 18:33:42 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SDvcL0h62zNnv2;
        Tue, 24 Oct 2023 09:29:38 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 24 Oct 2023 09:33:39 +0800
Subject: Re: [PATCH -next] mm/kmemleak: move the initialisation of object to
 __link_object
To:     Andrew Morton <akpm@linux-foundation.org>
References: <20231023025125.90972-1-liushixin2@huawei.com>
 <20231023111624.15ea508ed8aba2dee69035c2@linux-foundation.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <0f977cdb-039d-789b-802f-02746f5ad8ea@huawei.com>
Date:   Tue, 24 Oct 2023 09:33:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20231023111624.15ea508ed8aba2dee69035c2@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/24 2:16, Andrew Morton wrote:
> On Mon, 23 Oct 2023 10:51:25 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
>
>> Leave __alloc_object() just do the actual allocation and __link_object()
>> do the full initialisation.
> Changelog doesn't describe why we're making this change?
> .
In patch (“mm: kmemleak: split __create_object into two functions”), the initialisation
of object has been splited in two places. Catalin said it feels a bit weird and error prone.
So leave __alloc_object() just do the actual allocation and __link_object() do the full
initialisation.

thanks,

>
