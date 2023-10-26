Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A96F7D85B1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345421AbjJZPMk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 11:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345398AbjJZPMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:12:32 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11652D57;
        Thu, 26 Oct 2023 08:12:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SGTQQ05XyzB02gf;
        Thu, 26 Oct 2023 22:56:30 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDnPpDHgTplwlL2Ag--.10919S2;
        Thu, 26 Oct 2023 16:12:14 +0100 (CET)
Message-ID: <447298d65b497fb1a7f8d47c4f1a3137eba24511.camel@huaweicloud.com>
Subject: Re: [PATCH] security: Don't yet account for IMA in LSM_CONFIG_COUNT
  calculation
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 26 Oct 2023 17:12:03 +0200
In-Reply-To: <dd0f6611c7b46f3cecee2b84681c45b1.paul@paul-moore.com>
References: <20231026090259.362945-1-roberto.sassu@huaweicloud.com>
         <dd0f6611c7b46f3cecee2b84681c45b1.paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwDnPpDHgTplwlL2Ag--.10919S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr47Zr18JrWxtw45WF1kAFb_yoW3GwcEkr
        Wqkr17trZYy3ykZF43AF1F9rs29ayrJr15J3W3JrZIvw45J3WkXFWDArn5ZF1rX3Z7WrWD
        tF93uFW0v3s7tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbOAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIx
        AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1E1v3UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQACBF1jj5WPIQACsP
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-26 at 10:48 -0400, Paul Moore wrote:
> On Oct 26, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> > 
> > Since IMA is not yet an LSM, don't account for it in the LSM_CONFIG_COUNT
> > calculation, used to limit how many LSMs can invoke security_add_hooks().
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/security.c | 1 -
> >  1 file changed, 1 deletion(-)
> 
> Merged into lsm/dev-staging, thanks!

Welcome!

Could you please also rebase lsm/dev-staging, to move ab3888c7198d
("LSM: wireup Linux Security Module syscalls") after f7875966dc0c
("tools headers UAPI: Sync files changed by new fchmodat2 and
map_shadow_stack syscalls with the kernel sources")?

Thanks

Roberto

