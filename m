Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97387C71AE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379104AbjJLPiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346441AbjJLPiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:38:07 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 802BEC0;
        Thu, 12 Oct 2023 08:38:05 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qqxlA-0001sp-00; Thu, 12 Oct 2023 17:38:00 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 61D6EC0148; Thu, 12 Oct 2023 17:34:56 +0200 (CEST)
Date:   Thu, 12 Oct 2023 17:34:56 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 02/11] MIPS: use virtual addresses from xkphys for MIPS64
Message-ID: <ZSgSIPxrnx2FmHsk@alpha.franken.de>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-3-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004161038.2818327-3-gregory.clement@bootlin.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 06:10:29PM +0200, Gregory CLEMENT wrote:
> From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
> 
> Now 64-bit MIPS uses 32-bit compatible segments KSEG0 and KSEG1
> to trivially map first 1/2 GByte of physical memory. This memory
> used to run kernel. This mean, one should have memory installed
> in this area in order for Linux to work.
> 
> Kconfig CONFIG_USE_XKPHYS introduced; it adds support for kernel
> to use virtual addresses from the XKPHYS segment for both cached
> and uncached access. XKPHYS allows to access 2^48 bytes of
> memory, thus allowing kernel to work with any memory
> configuration.

IMHO it doesn't make sense to introduce an option for a generic
kernel, which then renders the generic kernel useless on all
platforms other then yours.

Please don't use generic, but setup a new platform for it. Hopefully
we can get rid all of the weirdness in this patch.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
