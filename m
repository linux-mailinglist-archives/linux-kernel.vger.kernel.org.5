Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C62D7BB1C5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 08:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjJFGwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 02:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJFGwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:52:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89830E4;
        Thu,  5 Oct 2023 23:52:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09996C15;
        Thu,  5 Oct 2023 23:52:39 -0700 (PDT)
Received: from bogus (unknown [10.57.93.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A4383F762;
        Thu,  5 Oct 2023 23:51:58 -0700 (PDT)
Date:   Fri, 6 Oct 2023 07:50:27 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the scmi tree
Message-ID: <20231006065027.oylmg76qyt5ni2wj@bogus>
References: <20231006103929.4c56edb3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006103929.4c56edb3@canb.auug.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 10:39:29AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the scmi tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> In file included from drivers/tee/optee/ffa_abi.c:8:
> include/linux/arm_ffa.h: In function 'ffa_mem_desc_offset':
> include/linux/arm_ffa.h:105:10: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
>   105 |         (FIELD_PREP(FFA_MAJOR_VERSION_MASK, (major)) |          \
>       |          ^~~~~~~~~~
> include/linux/arm_ffa.h:107:33: note: in expansion of macro 'FFA_PACK_VERSION_INFO'
>   107 | #define FFA_VERSION_1_0         FFA_PACK_VERSION_INFO(1, 0)
>       |                                 ^~~~~~~~~~~~~~~~~~~~~
> include/linux/arm_ffa.h:368:28: note: in expansion of macro 'FFA_VERSION_1_0'
>   368 |         if (ffa_version <= FFA_VERSION_1_0)
>       |                            ^~~~~~~~~~~~~~~
> 
> Exposed by commit
> 
>   0624de756f75 ("firmware: arm_ffa: Update memory descriptor to support v1.1 format")
> 
> This has been possible for a while, and arm_ffa.h needs to include
> linus/bitfoeld.h ...
>

Indeed.

> I have used the scmi tree from next-20231005 for today.
>

Thanks for the report, will fix it up.

> -- 
> Cheers,
> Stephen Rothwell



-- 
Regards,
Sudeep
