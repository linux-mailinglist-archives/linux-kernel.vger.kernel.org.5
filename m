Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08417D4B78
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjJXJFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjJXJFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:05:05 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A013EC0;
        Tue, 24 Oct 2023 02:05:02 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id DB11492009C; Tue, 24 Oct 2023 11:05:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id D5D0392009B;
        Tue, 24 Oct 2023 10:05:00 +0100 (BST)
Date:   Tue, 24 Oct 2023 10:05:00 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 03/11] MIPS: support RAM beyond 32-bit
In-Reply-To: <b35d73e8-260e-4296-a710-f20676e17c27@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2310240303440.63803@angie.orcam.me.uk>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com> <20231004161038.2818327-4-gregory.clement@bootlin.com> <f98d0cf9-6339-4cb1-8019-56bc71bfb822@app.fastmail.com> <87edi3bxcl.fsf@BL-laptop> <e5b8c68e-8a1d-45e7-92bf-db0c2fa812ad@app.fastmail.com>
 <878r89b4jh.fsf@BL-laptop> <b35d73e8-260e-4296-a710-f20676e17c27@app.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023, Jiaxun Yang wrote:

> > There is a kind of mirror but its physical address start at 0x8000000
> > so beyond the first 512MBytes that are used for KSEG0.
> 
> Really, KSEG0 range is 0x00000000 to 0x20000000, and 0x08000000 to 0x10000000
> is definitely within that range.
> 
> But I'd agree that 0x08000000 to 0x10000000 (32MB) seems too small for kernel
> text and data. So yeah, it makes sense to load kernel into XKPHYS.

 Hmm, my calculation indicates the range shown spans 128MiB, which I think 
is usually suitably large to hold kernel static text and data even for the 
richest configurations.  Regardless, loading into XKPHYS isn't wrong, with 
some platforms we've been doing it for decades now.

  Maciej
