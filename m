Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6E07A9090
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 03:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjIUBlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 21:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjIUBlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 21:41:07 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBC8AF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 18:41:00 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 38L1euGt010650;
        Thu, 21 Sep 2023 09:40:56 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Thu, 21 Sep 2023 09:40:54 +0800
Date:   Thu, 21 Sep 2023 09:40:51 +0800
From:   Yu-Chien Peter Lin <peterlin@andestech.com>
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <david@redhat.com>,
        <akpm@linux-foundation.org>, <alexghiti@rivosinc.com>,
        <bjorn@rivosinc.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] riscv: Improve PTDUMP to show RSW with non-zero
 value
Message-ID: <ZQufI18opHe8iYgi@APC323>
References: <20230920035522.3180558-1-peterlin@andestech.com>
 <20230920-pureblood-unwilling-f17aff1eef6a@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230920-pureblood-unwilling-f17aff1eef6a@wendy>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 38L1euGt010650
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Wed, Sep 20, 2023 at 10:55:30AM +0100, Conor Dooley wrote:
> On Wed, Sep 20, 2023 at 11:55:20AM +0800, Yu Chien Peter Lin wrote:
> > RSW field can be used to encode 2 bits of software
> > defined information. Currently, PTDUMP only prints
> > "RSW" when its value is 1 or 3.
> > 
> > To fix this issue and improve the debugging experience
> > with PTDUMP, we redefine _PAGE_SPECIAL to its original
> > value and use _PAGE_SOFT as the RSW mask, allow it to
> > print the RSW with any non-zero value.
> > 
> > This patch also removes the val from the struct prot_bits
> > as it is no longer needed.
> > 
> 
> Could you please add cover letters to multi-patch patchsets?
> 
> Thanks,
> Conor.

Sure, will do.

Regards,
Peter Lin
