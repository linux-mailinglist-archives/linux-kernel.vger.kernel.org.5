Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E297AA182
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjIUVDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjIUVCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:02:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A399A8460F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7740CC4AF5D;
        Thu, 21 Sep 2023 09:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695289018;
        bh=dNEOlBkvsTEIQ7sDlpgOxIjaV/wTx53tOqsrSxNccPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KKe1e3A/+t7cy8i5x0gVpHox3H+UBnELoyDJ0jLD+FCQUOwlHa4OTsHka26jzP8dE
         lW1Uhty8xFED/Zq+Lx5dciCiEGi9oJIhS3VzkFzFf0G2Lr1WXJgLO65TLaiyHneA8z
         AcE+UIL0cMD0GyCqP3KJfEnWyYSnZsQs5YAJeebCuOB5yOXRGbppJJw2NA/9y8J7GX
         9+NxOyrr1l8tyFmDc6joN21Luf7Jp7ej6WUVRHeImywBg3I3HE/5aPmu31Yyz1XwnE
         te/EBz5euucputziqvfNo+WCHYjkqEb3cm+g0dAjaMRTUYuUdXTVybjhnp9LoY4ge+
         h4OpuRZFCVFrw==
Date:   Thu, 21 Sep 2023 17:24:57 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
Subject: Re: [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus
Message-ID: <ZQwL6fxi6IkUEIMc@xhacker>
References: <20230912072232.2455-1-jszhang@kernel.org>
 <20230912-trailing-pampered-52738ec6f009@spud>
 <ZQHSLdPufI6CXApg@xhacker>
 <20230913-faster-spotted-9df41a0d7787@spud>
 <20230920-pesky-stalemate-88f5036b8084@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920-pesky-stalemate-88f5036b8084@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 09:36:19AM +0100, Conor Dooley wrote:
> Hey Jisheng,
> 
> On Wed, Sep 13, 2023 at 04:44:18PM +0100, Conor Dooley wrote:
> > On Wed, Sep 13, 2023 at 11:15:57PM +0800, Jisheng Zhang wrote:
> > > On Tue, Sep 12, 2023 at 05:27:31PM +0100, Conor Dooley wrote:
> > > > On Tue, Sep 12, 2023 at 03:22:32PM +0800, Jisheng Zhang wrote:
> > > > > riscv select ARCH_DMA_DEFAULT_COHERENT by default, and th1520 isn't
> > > > > dma coherent, so set dma-noncoherent to reflect this fact.
> > > > > 
> > > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > > Tested-by: Drew Fustini <dfustini@baylibre.com>
> > > > > ---
> > > > > 
> > > > > Since v1:
> > > > >  - rebase on v6.6-rc1
> > > > >  - collect Tested-by tag
> > > > 
> > > > Does this mean you're expecting me to take this?
> > > 
> > > Hi Conor,
> > > 
> > > I think I will take this and send PR to soc people. The reason
> > > I send v2 is the rebasing on new rc1 and v1 wasn't in linux-riscv
> > > mailist due to typo;
> > 
> > Great, thanks. Please ask SFR to add your tree to linux-next.

Hi Conor,

I'm not sure how to do this. When MAINTAINERS patch is merged, send
an email to Stephen Rothwell, are these steps correct?

> 
> I lost my main x86 box over the weekend (looks like probably a dead
> motherboard), so I may have missed a response to this.
> 
> Did you see this email? Additionally, can you add that git tree to the
> maintainers entry for the thead devicetrees?

I just created a tree in
git://git.kernel.org/pub/scm/linux/kernel/git/jszhang/linux.git

But it needs time for cgit to take place. I will send a patch
once it appears.

Thanks
