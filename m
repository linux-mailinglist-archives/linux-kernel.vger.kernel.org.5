Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D121777002
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjHJGK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjHJGKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:10:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EEB1704
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:10:24 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLxJq2rLsztRvb;
        Thu, 10 Aug 2023 14:06:51 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 14:10:21 +0800
Subject: Re: [PATCH v12 4/4] Documentation: add debugfs description for vfio
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20230728072104.64834-1-liulongfang@huawei.com>
 <20230728072104.64834-5-liulongfang@huawei.com> <ZM0SAfIHnMHndm8h@nvidia.com>
 <3c557239-447f-116d-3687-cc6e419f2dcc@huawei.com>
 <20230807160352.0b7a57bf.alex.williamson@redhat.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <02d72031-6d09-19a4-6c6d-0e43141e66d0@huawei.com>
Date:   Thu, 10 Aug 2023 14:10:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230807160352.0b7a57bf.alex.williamson@redhat.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/8 6:03, Alex Williamson wrote:
> The vfio/<device>/migration/state file can provide useful monitoring of
> the device progress during a migration, but I think the point Jason is
> trying to make is that these hisi_acc seqfiles aren't really doing
> anything that couldn't be done by a simple userspace test driver.
>The state file was originally used to provide a migration state.
When the migration fails, it is used to locate the problem.
For it, we have no other functional demands.

> Based on my review of the previous patch, we're playing pretty loose
> with concurrency and data buffers.  Access to the migration data of
> the device outside of the process that owns the device is also a
> concern.
> 
> The value-add here needs to be that there's something useful about the
> kernel being able to dump this data rather than either a simple
> userspace program or instrumenting a userspace driver like QEMU, where
> we can avoid the complexity that's going to be required to resolve the
> issues in the previous patch and ensure that sensitive data from the
> device isn't available through debugfs.
The question of whether the migrated data is sensitive data.
It is up to the device driver to choose which data can be output.
Currently, the data that can be output through debugfs in this
HiSilicon device driver does not involve sensitive data.

Thanks,
Longfang.

