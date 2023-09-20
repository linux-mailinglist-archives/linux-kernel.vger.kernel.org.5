Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903937A70E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjITDSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITDSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:18:00 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042D4B0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 20:17:52 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 38K3HiGf052118;
        Wed, 20 Sep 2023 11:17:44 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Wed, 20 Sep 2023 11:17:39 +0800
Date:   Wed, 20 Sep 2023 11:17:36 +0800
From:   Yu-Chien Peter Lin <peterlin@andestech.com>
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <david@redhat.com>,
        <akpm@linux-foundation.org>, <alexghiti@rivosinc.com>,
        <bjorn@rivosinc.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] riscv: Improve PTDUMP to show RSW with non-zero
 value
Message-ID: <ZQpkUNNs6xEE_Ulw@APC323>
References: <20230914014027.273002-1-peterlin@andestech.com>
 <20230918-cassette-exclusion-b2ce53745a5c@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230918-cassette-exclusion-b2ce53745a5c@wendy>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 38K3HiGf052118
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:53:13PM +0100, Conor Dooley wrote:
> On Thu, Sep 14, 2023 at 09:40:25AM +0800, Yu Chien Peter Lin wrote:
> 
> > +		val = st->current_prot & pte_bits[i].mask;
> > +		if (val) {
> > +			if (pte_bits[i].mask == _PAGE_SOFT)
> > +				sprintf(s, pte_bits[i].set, val >> 8);
> > +			else
> > +				sprintf(s, "%s", pte_bits[i].set);
> > +		} else
> > +			sprintf(s, "%s", pte_bits[i].clear);
> > +
> 
> just a nit, but checkpatch in the automation is whinging that you have
> forgotten to add {} around both branches if this if statement.

Hi Conor,

Will fix the warning.

Thanks,
Peter Lin
