Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B657D7EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjJZIwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjJZIwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:52:21 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C425110E;
        Thu, 26 Oct 2023 01:52:17 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 39Q8oXK5074274;
        Thu, 26 Oct 2023 16:50:33 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Thu, 26 Oct 2023 16:50:32 +0800
Date:   Thu, 26 Oct 2023 16:50:27 +0800
From:   Yu-Chien Peter Lin <peterlin@andestech.com>
To:     Conor Dooley <conor@kernel.org>
CC:     <acme@kernel.org>, <adrian.hunter@intel.com>,
        <ajones@ventanamicro.com>, <alexander.shishkin@linux.intel.com>,
        <andre.przywara@arm.com>, <anup@brainfault.org>,
        <aou@eecs.berkeley.edu>, <atishp@atishpatra.org>,
        <conor+dt@kernel.org>, <conor.dooley@microchip.com>,
        <devicetree@vger.kernel.org>, <dminus@andestech.com>,
        <evan@rivosinc.com>, <geert+renesas@glider.be>,
        <guoren@kernel.org>, <heiko@sntech.de>, <irogers@google.com>,
        <jernej.skrabec@gmail.com>, <jolsa@kernel.org>,
        <jszhang@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
        <locus84@andestech.com>, <magnus.damm@gmail.com>,
        <mark.rutland@arm.com>, <mingo@redhat.com>, <n.shubin@yadro.com>,
        <namhyung@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <peterz@infradead.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <sunilvl@ventanamicro.com>, <tglx@linutronix.de>,
        <tim609@andestech.com>, <uwu@icenowy.me>, <wens@csie.org>,
        <will@kernel.org>, <ycliang@andestech.com>
Subject: Re: [PATCH v3 RESEND 04/13] dt-bindings: riscv: Add Andes interrupt
 controller compatible string
Message-ID: <ZTooUz-UyVuIMOsN@APC323>
References: <20231023004100.2663486-1-peterlin@andestech.com>
 <20231023004100.2663486-5-peterlin@andestech.com>
 <20231023-contented-passcode-2e8d082afed4@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231023-contented-passcode-2e8d082afed4@spud>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39Q8oXK5074274
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Mon, Oct 23, 2023 at 02:15:21PM +0100, Conor Dooley wrote:
> On Mon, Oct 23, 2023 at 08:40:51AM +0800, Yu Chien Peter Lin wrote:
> > Add "andestech,cpu-intc" compatible string which indicates that
> > Andes specific local interrupt is supported on the core,
> > e.g. AX45MP cores have 3 types of non-standard local interrupt
> > can be handled in supervisor mode:
> > 
> > - Slave port ECC error interrupt
> > - Bus write transaction error interrupt
> > - Performance monitor overflow interrupt
> > 
> > These interrupts are enabled/disabled via a custom register
> > SLIE instead of the standard interrupt enable register SIE.
> > 
> > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > ---
> > Changes v1 -> v2:
> >   - New patch
> > Changes v2 -> v3:
> >   - Updated commit message
> >   - Fixed possible compatibles for Andes INTC
> > ---
> >  Documentation/devicetree/bindings/riscv/cpus.yaml | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > index 97e8441eda1c..4c1bbcf07406 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -99,7 +99,12 @@ properties:
> >          const: 1
> >  
> >        compatible:
> > -        const: riscv,cpu-intc
> > +        oneOf:
> > +          - items:
> > +              - enum:
> > +                  - andestech,cpu-intc
> 
> Why is this an enum rather than const? What other entries are we going
> to add here in the near future?

I have no plan to add other entries here, will update in the next
version of patch. Thanks for the review.

> > +              - const: riscv,cpu-intc
> 
> My follow-up question, if my original question on the v2 series had been
> answered was going to be about how generic the "andestech,cpu-intc"
> compatible is.

This can be applied to any Linux-capable CPUs from Andes.

Best regards,
Peter Lin

> Having a cpu-specific compatible in addition to "andestech,cpu-intc"
> one makes sense to me, so that we can differentiate between
> implementations/integrations of this intc, especially if Andes have no
> plans to move to the standard implementation.
> 
> Cheers,
> Conor.
> 
> > +          - const: riscv,cpu-intc
> >  
> >        interrupt-controller: true
> >  
> > -- 
> > 2.34.1
> > 


