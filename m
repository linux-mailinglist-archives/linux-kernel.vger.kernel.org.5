Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD7B7ADAF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjIYPHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjIYPHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:07:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA451103;
        Mon, 25 Sep 2023 08:07:39 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RvR3z5Tb9zVlF5;
        Mon, 25 Sep 2023 23:04:31 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 23:07:36 +0800
Message-ID: <47bed3cb-f307-ec55-5c28-051687dab1ea@huawei.com>
Date:   Mon, 25 Sep 2023 23:07:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v2 00/18] scsi: scsi_error: Introduce new error handle
 mechanism
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
CC:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, Hannes Reinecke <hare@suse.de>,
        <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>,
        <lixiaokeng@huawei.com>
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
 <ZRGfc73BSW0yyUtI@infradead.org>
From:   Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <ZRGfc73BSW0yyUtI@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/25 22:55, Christoph Hellwig wrote:
> Before we add another new error handling mechanism we need to fix the
> old one first.  Hannes' work on not passing the scsi_cmnd to the various
> reset handlers hasn't made a lot of progress in the last five years and
> we'll need to urgently fix that first before adding even more
> complexity.
> 
I observed Hannes's patches posted about one year ago, it has not been
applied yet. I don't know if he is still working on it.

My patches do not depend much on that work, I think the conflict can be
solved fast between two changes.
