Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C872D7DB1F2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 03:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjJ3CFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 22:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjJ3CFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 22:05:32 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31158C0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 19:05:28 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,262,1694707200"; 
   d="scan'208";a="94760201"
Date:   Mon, 30 Oct 2023 10:05:08 +0800
From:   Fang Xiang <fangxiang3@xiaomi.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] irqchip/gic-v3-its: Flush ITS tables before writing
 GITS_BASER<n> registers in non-coherent GIC designs.
Message-ID: <ZT8PVJ+TQmqEe8fE@oa-fangxiang3.localdomain>
References: <20231027031007.2088-1-fangxiang3@xiaomi.com>
 <87v8as32fa.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87v8as32fa.ffs@tglx>
X-Originating-IP: [10.237.8.11]
X-ClientProxiedBy: BJ-MBX04.mioffice.cn (10.237.8.124) To BJ-MBX15.mioffice.cn
 (10.237.8.135)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 10:16:57AM +0200, Thomas Gleixner wrote:
> On Fri, Oct 27 2023 at 11:10, Fang Xiang wrote:
> > In non-coherent GIC design, ITS tables should be clean and flushed
> > to the PoV of the ITS before writing GITS_BASER<n> registers. And
> > hoist the quirked non-shareable attributes earlier to save effort
> > in tables setup.
> >
> > Signed-off-by: Fang Xiang <fangxiang3@xiaomi.com>
> 
> Seriously? You claim authorship for a patch which was written by Marc:
> 
>    https://lore.kernel.org/all/87sf5x6cdu.wl-maz@kernel.org
> 
> without even the courtesy of giving him credit via 'Originally-by' ?
> 
> That's not how it works.
> 
> Thanks,
> 
>         tglx

I am sorry. That's a terrible mistake. Just want to fix this issue as
soon as possible and I am learning how to contribute to the community 
in a right way.
