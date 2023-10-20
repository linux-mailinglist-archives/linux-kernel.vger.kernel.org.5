Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0552A7D0A43
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbjJTIJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjJTIJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:09:00 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B69F19E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:08:58 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 39K88Sw2002009;
        Fri, 20 Oct 2023 16:08:28 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Fri, 20 Oct 2023 16:08:27 +0800
Date:   Fri, 20 Oct 2023 16:08:27 +0800
From:   Yu-Chien Peter Lin <peterlin@andestech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <conor@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <tim609@andestech.com>,
        <dylan@andestech.com>, <locus84@andestech.com>,
        <dminus@andestech.com>
Subject: Re: [PATCH v2 05/10] dt-bindings: riscv: Add andestech,cpu-intc to
 interrupt-controller
Message-ID: <ZTI1ex8xlif7w8tM@APC323>
References: <20231019135905.3658215-1-peterlin@andestech.com>
 <ba3ac1b2-d924-44cb-97dd-6af65a1db7a8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ba3ac1b2-d924-44cb-97dd-6af65a1db7a8@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39K88Sw2002009
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 09:00:03AM +0200, Krzysztof Kozlowski wrote:
> On 19/10/2023 15:59, Yu Chien Peter Lin wrote:
> > Add "andestech,cpu-intc" compatible string for Andes INTC which
> > provides Andes-specific IRQ chip functions.
> > 
> > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > ---
> > Changes v1 -> v2:
> >   - New patch
> > ---
> >  Documentation/devicetree/bindings/riscv/cpus.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > index 97e8441eda1c..5b216e11c69f 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -99,7 +99,9 @@ properties:
> >          const: 1
> >  
> >        compatible:
> > -        const: riscv,cpu-intc
> > +        enum:
> > +          - riscv,cpu-intc
> > +          - andestech,cpu-intc
> 
> Keep alphabetical order. Do not add stuff to the end of the lists. This
> is a generic rule. Everywhere.

Hi Krzysztof,

Thansk for pointing this out.
Will fix this in PATCH v3.

Best regards,
Peter Lin

> Best regards,
> Krzysztof
> 
