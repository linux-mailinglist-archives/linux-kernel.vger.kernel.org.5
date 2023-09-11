Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D75479A176
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjIKCkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjIKCkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:40:16 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39DA99;
        Sun, 10 Sep 2023 19:40:09 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 38B2d6rT053136;
        Mon, 11 Sep 2023 10:39:06 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Mon, 11 Sep 2023 10:39:03 +0800
Date:   Mon, 11 Sep 2023 10:38:56 +0800
From:   Yu-Chien Peter Lin <peterlin@andestech.com>
To:     Samuel Holland <samuel.holland@sifive.com>
CC:     <ajones@ventanamicro.com>, <heiko@sntech.de>,
        <samuel@sholland.org>, <geert+renesas@glider.be>,
        <n.shubin@yadro.com>, <dminus@andestech.com>,
        <ycliang@andestech.com>, <tim609@andestech.com>,
        <locus84@andestech.com>, <dylan@andestech.com>,
        <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <conor.dooley@microchip.com>,
        <atishp@atishpatra.org>, <anup@brainfault.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 3/4] riscv: errata: Add Andes PMU errata
Message-ID: <ZP59wF5Knq3G7On_@APC323>
References: <20230907021635.1002738-1-peterlin@andestech.com>
 <20230907021635.1002738-4-peterlin@andestech.com>
 <82a82449-3af0-4756-881a-b31b6b187e6c@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <82a82449-3af0-4756-881a-b31b6b187e6c@sifive.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 38B2d6rT053136
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On Wed, Sep 06, 2023 at 09:48:35PM -0500, Samuel Holland wrote:
> If the code here needs to be different, then it must check that it is actually
> running on an Andes core, not just that the errata Kconfig option is enabled.

Thank you for catching this, will fix in PATCH v2.

> However, I suggest setting riscv_pmu_irq_num to the real IRQ number:
>   riscv_pmu_irq_num = ANDES_SLI_CAUSE_BASE + ANDES_RV_IRQ_PMU;
> and then adding a new variable for the mask:
>   riscv_pmu_irq_mask = BIT(riscv_pmu_irq_num % BITS_PER_LONG);
> which handles the large IRQ number somewhat more generically, and reduces the
> number of bit operations needed elsewhere in the driver.

I will make changes according to your suggestions. Thank you!

> Or we could use IRQ chip operations here instead of direct CSR acccess. But
> maybe the direct CSR access is needed for performance?
> 
> Regards,
> Samuel

Best regards,
Peter Lin
