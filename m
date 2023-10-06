Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83477BBCEB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjJFQk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjJFQkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:40:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9EAAD;
        Fri,  6 Oct 2023 09:40:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BF2C433C8;
        Fri,  6 Oct 2023 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696610421;
        bh=H2sx5NQhBAPqc06JxSGI5reERf87Iy6LrLxkuOsSTIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6UcyhKycR5lVRB15yhRRoIb9gnrAt2sZUtNDNV8pmp4g5JsoQqbBNi51nQ48M7pX
         n0rHiZpB8O1Eb//mKzBAX2ijP6lrBVK3PF4t1cpjjREh0SY7RU2tn/y/YntAY+21c/
         VqxTZNdA/0Kxd8NxfT2boAs9VIs0hn3IVpdfG6LPCRcosu3InlbMB79mblyzmlNOCw
         e00RqEPT2edPaeOXV2EaiWYNirXLe7jmH6uiECUSeSz5N44DFMfAuEM0A/jANLWwYg
         WHW1ro0OFRhxtXd2hSYlOLZ8NCJYEf6EnOl2mYdON9+o2navaRnZ0v3AV7870IcEi0
         SCKpbFBZVhlHw==
Received: (nullmailer pid 4048805 invoked by uid 1000);
        Fri, 06 Oct 2023 16:40:19 -0000
Date:   Fri, 6 Oct 2023 11:40:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 05/11] dt-bindings: mips: cpu: Add I-Class I6500
 Multiprocessor Core
Message-ID: <20231006164019.GA4040344-robh@kernel.org>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-6-gregory.clement@bootlin.com>
 <hu5ksk2gw7zbbeiwi4unfo242qm2wfn36bpgea5inlamn4kqrf@magwi4w7gp3x>
 <87sf6pcebd.fsf@BL-laptop>
 <53050bbd-6a46-470d-9764-c83b8588698e@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53050bbd-6a46-470d-9764-c83b8588698e@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 12:48:03PM +0200, Arnd Bergmann wrote:
> On Thu, Oct 5, 2023, at 16:51, Gregory CLEMENT wrote:
> >> On Wed, Oct 04, 2023 at 06:10:32PM +0200, Gregory CLEMENT wrote:
> >>> The MIPS Warrior I-class I6500 was announced by Imagination
> >>> Technologies in 2016 and is used in the Mobileye SoC EyeQ5.
> >>> 
> >>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/mips/cpus.yaml | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>> 
> >>> diff --git a/Documentation/devicetree/bindings/mips/cpus.yaml b/Documentation/devicetree/bindings/mips/cpus.yaml
> >>> index cf382dea3922..87fd2842ba68 100644
> >>> --- a/Documentation/devicetree/bindings/mips/cpus.yaml
> >>> +++ b/Documentation/devicetree/bindings/mips/cpus.yaml
> >>> @@ -39,6 +39,7 @@ properties:
> >>>        - mti,mips24KEc
> >>>        - mti,mips14KEc
> >>>        - mti,mips14Kc
> >>
> >>> +      - mti,i6500
> >>
> >> Since the CPU core vendor is Imagination Technologies thus it would
> >> be more appropriate to have the "img," prefix. Wouldn't it?
> >
> > According to Documentation/devicetree/bindings/vendor-prefixes.yaml
> >
> > "^mti,.*":
> >     description: Imagination Technologies Ltd. (formerly MIPS
> >     Technologies Inc.)
> >
> > So I think it's OK.
> 
> I don't see any good solution, they changed their name and
> ownership too many times. I would actually revert back the
> description here to "MIPS Technologies Inc" instead of trying
> to keep track of what they currently call themselves.
> 
> Since we already have both the 'mips,' and 'mti,' vendow
> names for the 14Kc, 14KEc and 24KEc parts, maybe we can
> just go back to 'mips,' for all cores past the mti era
> rather than trying to date and geolocate each of the
> classic cores as one of 'mti', 'img', 'wavecomp', 'tallwood',
> 'mips' 'cipunited' etc.

I would reserve 'mips' for anything common. Much like 'riscv' is only 
for things based on RiscV specs/standards.

I would use 'img' here if we know this was designed/implemented by 
Imagination.

Rob
