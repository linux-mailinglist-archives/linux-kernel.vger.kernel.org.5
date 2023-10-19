Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB017CF652
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbjJSLMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345037AbjJSLMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:12:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14924FA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:12:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6322C433C8;
        Thu, 19 Oct 2023 11:12:05 +0000 (UTC)
Date:   Thu, 19 Oct 2023 12:12:03 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        ankita@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZTEPA-o8VfziJRpu@arm.com>
References: <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
 <20231012123541.GB11824@willie-the-truck>
 <ZSf6Ue09IO6QMBs1@arm.com>
 <20231012144807.GA12374@willie-the-truck>
 <ZSgsKSCv-zWgtWkm@arm.com>
 <20231013092934.GA13524@willie-the-truck>
 <ZSlBOiebenPKXBY4@arm.com>
 <ZSliChc3poZNM4f9@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSliChc3poZNM4f9@lpieralisi>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 05:28:10PM +0200, Lorenzo Pieralisi wrote:
> On Fri, Oct 13, 2023 at 02:08:10PM +0100, Catalin Marinas wrote:
> 
> [...]
> 
> > Yes, we end up with mismatched aliases but they only matter if the VMM
> > also accesses the I/O range via its own mapping. So far I haven't seen
> > case that suggests this.
> > 
> > > > Things can go wrong but that's not because Device does anything better.
> > > > Given the RAS implementation, external aborts caused on Device memory
> > > > (e.g. wrong size access) is uncontainable. For Normal NC it can be
> > > > contained (I can dig out the reasoning behind this if you want, IIUC
> > > > something to do with not being able to cancel an already issued Device
> > > > access since such accesses don't allow speculation due to side-effects;
> > > > for Normal NC, it's just about the software not getting the data).
> > > 
> > > I really think these details belong in the commit message.
> > 
> > I guess another task for Lorenzo ;).
> 
> I will do, I start wondering though whether this documentation belongs
> in this commit log only or at Documentation/arch/arm64 level (or both),
> I am pretty sure this thread can turn out quite useful as a reference
> (it is for me) if we manage to summarize it that would benefit
> everyone.

I think it makes sense to add something in the Documentation for easier
future reference. We can also keep adding to it as we learn more. The
commit log can be shorter in this case.

-- 
Catalin
