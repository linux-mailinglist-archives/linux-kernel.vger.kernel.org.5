Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4517279ECCD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjIMP2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjIMP2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:28:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D673E54;
        Wed, 13 Sep 2023 08:27:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE31C433C8;
        Wed, 13 Sep 2023 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694618876;
        bh=2y+HoufOHHUVUfMzbkjqlYospySETxzf4s/h/0ToUik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mwhYSI/NopuKBkart4AAsJuHdwYJgbyn/73+4F5K8xdZle0iVLbgMRjqlMFlyqrhC
         h9Hrs8dGe2NFfPkiEvg08LeRLvjU6ea2l6Cu4KBjlIT+FpUPSwhcuKB11KVFxuqILl
         OOczz6ZeIWsx33bUT74kJVbk6TowG3CFVaAw3oeVm2f+9gWQnh3NVISAKJAFnjSu4Y
         D3pNU6PYDiqB8Arc87uaE5sznBFgjdvJE8svk/MU6UUTozDDdaqyGBWlh4mPZQmQMC
         BjUY0rXv6GcRQ7APLBvUArlBQ+Qs25AFdXnNWegiWC68ofqVAidFyh1MpOX8+6Wfve
         B2T/5GzAM4c6g==
Date:   Wed, 13 Sep 2023 23:15:57 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
Subject: Re: [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus
Message-ID: <ZQHSLdPufI6CXApg@xhacker>
References: <20230912072232.2455-1-jszhang@kernel.org>
 <20230912-trailing-pampered-52738ec6f009@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912-trailing-pampered-52738ec6f009@spud>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 05:27:31PM +0100, Conor Dooley wrote:
> On Tue, Sep 12, 2023 at 03:22:32PM +0800, Jisheng Zhang wrote:
> > riscv select ARCH_DMA_DEFAULT_COHERENT by default, and th1520 isn't
> > dma coherent, so set dma-noncoherent to reflect this fact.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Tested-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> > 
> > Since v1:
> >  - rebase on v6.6-rc1
> >  - collect Tested-by tag
> 
> Does this mean you're expecting me to take this?

Hi Conor,

I think I will take this and send PR to soc people. The reason
I send v2 is the rebasing on new rc1 and v1 wasn't in linux-riscv
mailist due to typo;

Thank you so much
> 
> > 
> >  arch/riscv/boot/dts/thead/th1520.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> > index ce708183b6f6..ff364709a6df 100644
> > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > @@ -139,6 +139,7 @@ soc {
> >  		interrupt-parent = <&plic>;
> >  		#address-cells = <2>;
> >  		#size-cells = <2>;
> > +		dma-noncoherent;
> >  		ranges;
> >  
> >  		plic: interrupt-controller@ffd8000000 {
> > -- 
> > 2.40.1
> > 


