Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C11175239F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbjGMNXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbjGMNXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:23:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45EA0270A;
        Thu, 13 Jul 2023 06:22:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 943C01570;
        Thu, 13 Jul 2023 06:22:26 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3EDF3F73F;
        Thu, 13 Jul 2023 06:21:42 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:21:40 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     stanley.chu@mediatek.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-scsi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] scsi: ufs: ufs-mediatek: Remove surplus dev_err()
Message-ID: <20230713132140.azamscgceh6yyy6j@bogus>
References: <20230712064832.44188-1-yang.lee@linux.alibaba.com>
 <20230713131123.uo5ofltbhvktkevd@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713131123.uo5ofltbhvktkevd@bogus>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 02:11:23PM +0100, Sudeep Holla wrote:
> On Wed, Jul 12, 2023 at 02:48:32PM +0800, Yang Li wrote:
> > There is no need to call the dev_err() function directly to print a
> > custom message when handling an error from either the platform_get_irq()
> > or platform_get_irq_byname() functions as both are going to display an
> > appropriate error message in case of a failure.
> > 
> > ./drivers/ufs/host/ufs-mediatek.c:864:3-10: line 864 is redundant because platform_get_irq() already prints an error
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5846
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> 

Sorry for this, I didn't mean to ack this patch, no idea how on earth I
managed to do that (must be some wrong key combination in my email client)
but I wanted and meant to ack only this [1]. Sorry for the noise.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/r/20230712062853.11007-9-frank.li@vivo.com
