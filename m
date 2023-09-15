Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8705D7A21D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbjIOPEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbjIOPDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:03:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9533F2709
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:03:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAC4C433C8;
        Fri, 15 Sep 2023 15:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694790215;
        bh=UtY3Y7r9znKWxNJDaZ5ltW/b+hC2P2B8V/VhuUu8pkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ne/aH+FqERho8uP8TYtT4xl5rClVk1+AgqInqI+Ngw9OWuKsmalkSvAGsGsxXanSl
         PCQBMZwKUde2FomJm48t9Ez3yWTDkTmPiYFc+h5vAVraAPNj3OAUIraTovluJKwjkg
         HW3SP1ed4Mruwi1rL2mZbGJD0PnM+pQ08LJf2csDZ3SlHK/a7G15lvkO69a/4acByr
         t/w/S6eknf7CjRaD5I0aB9bnU0QLlfBjS7Oeu84QQ86ng9BawZKApuv2+R8ELgg1G8
         YIJ9AJdSuGgLJEXQj/tEpz7Z/dJbo2uwho5Ywf5VbCCywZU71eZi+qWR4RUTtYpXGK
         HPvytPLGspJOQ==
Received: (nullmailer pid 3729895 invoked by uid 1000);
        Fri, 15 Sep 2023 15:03:32 -0000
Date:   Fri, 15 Sep 2023 10:03:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Wang Chen <unicornxw@gmail.com>, linux-riscv@lists.infradead.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH 04/12] dt-bindings: riscv: Add T-HEAD C920 compatibles
Message-ID: <20230915150332.GA3719864-robh@kernel.org>
References: <20230915072333.117991-1-wangchen20@iscas.ac.cn>
 <20230915-muster-viability-93d7d4ec2b49@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915-muster-viability-93d7d4ec2b49@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 03:11:43PM +0100, Conor Dooley wrote:
> On Fri, Sep 15, 2023 at 03:23:33PM +0800, Wang Chen wrote:
> > The C920 is RISC-V CPU cores from T-HEAD Semiconductor.
> > Notably, the C920 core is used in the SOPHGO SG2042 SoC.
> > 
> > Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
> > Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> 
> I figure this is missing a From: or Co-developed-by line.

From: (author) as 2 authors for 1 line change is questionable.

The sender's email should be the last S-o-b. So like this:

From: Xiaoguang Xing <xiaoguang.xing@sophgo.com>

...

Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>


> 
> > ---
> >  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > index 38c0b5213736..185a0191bad6 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -47,6 +47,7 @@ properties:
> >                - sifive,u74-mc
> >                - thead,c906
> >                - thead,c910
> > +              - thead,c920
> >            - const: riscv
> >        - items:
> >            - enum:
> > -- 
> > 2.25.1
> > 


