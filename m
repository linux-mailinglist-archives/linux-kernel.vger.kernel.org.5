Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20307A4510
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbjIRIol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241175AbjIRIoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:44:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BB44E49;
        Mon, 18 Sep 2023 01:43:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32EC81FB;
        Mon, 18 Sep 2023 01:44:36 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C00B03F5A1;
        Mon, 18 Sep 2023 01:43:57 -0700 (PDT)
Date:   Mon, 18 Sep 2023 09:43:55 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "lihuisong (C)" <lihuisong@huawei.com>
Cc:     rafael@kernel.org, rafael.j.wysocki@intel.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuyonglong@huawei.com
Subject: Re: [PATCH] mailbox: pcc: export the PCC subspace type
Message-ID: <20230918084355.rzh7k6y7uuaitanj@bogus>
References: <20230914115753.9064-1-lihuisong@huawei.com>
 <20230914161335.rz6fn4w2pqzz4wdp@bogus>
 <5ec151a4-5e2c-7745-c8ef-1edc5e7ef157@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ec151a4-5e2c-7745-c8ef-1edc5e7ef157@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 03:04:57PM +0800, lihuisong (C) wrote:
> 
> 在 2023/9/15 0:13, Sudeep Holla 写道:
> > On Thu, Sep 14, 2023 at 07:57:53PM +0800, Huisong Li wrote:
> > > As stated in APCI spec, the size of the subspace shared memory region may
> > > be different for different types. So it is useful for driver to fill PCC
> > > communication space. But the driver used this PCC channel doesn't know what
> > > is the subspace type of the channel.
> > > 
> > > So export the PCC subspace type by requesting PCC channel.
> > > 
> > I would prefer to avoid this, but please post it with user to get better
> > understanding of it.
> Hi Sudeep,
> 
> Thanks for your fast review.
> Sorry, I cannot fully understand what you mean. What should I do for it?
> Currently, it seems that the subspace type in all drivers used PCC is fixed
> and not obtained from their platform.
> IMO, PCCT is a best natural way to export it.
> 

OK, but please post the changes in the *driver* you ought to use this channel
type. Your change just allows the drivers to use it but it doesn't contain
any driver making use of it. So please post that change as well to understand
the issue better. It helps in the review.


-- 
Regards,
Sudeep
