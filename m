Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225177EC3E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343953AbjKONjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343717AbjKONjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:39:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F8FA1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:39:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EEAC433C8;
        Wed, 15 Nov 2023 13:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700055577;
        bh=+m5EkdsuFgk4M8NgYmYjSHFQr191uVxuI+jCtlMUOdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUTy4gSPEZVY1b1dUA7g3l2l1Pjx6h4pd44zta+k9/BLgrwu2g907HexbUKqb8p3L
         PXtWeBDSN5DsolmNPBeXwGGeNAv9DDOwap9o59WksBFGtsSsY3nq1iQaLKpeEC75zj
         deGYYaz8tRPiSJGmy2j+pj7JTfl4hGgic2/Hj2OVHP6wOiMgKxhHguNqGJi4NNNwXZ
         Wd2Yy1U8HX5jjhxvUMmXGRWEoHD5IHmjN/bHBoHpgZX6kwxRdGInAcXgS8bW8EeX59
         M/2hXSw958zAWSyd7sp6oQ2KN3oZ6QzJdmipMODs3uc3P9Fw/zZChlAMjWVsfVdJgj
         RSPPd1UMxfigg==
Date:   Wed, 15 Nov 2023 21:27:14 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: reset: Add binding for Sophgo CV1800B
 reset controller
Message-ID: <ZVTHMsXaPdHiuUOF@xhacker>
References: <20231113005503.2423-1-jszhang@kernel.org>
 <20231113005503.2423-2-jszhang@kernel.org>
 <44f21244-5bf1-4e0f-80a9-6ec76d65eea4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44f21244-5bf1-4e0f-80a9-6ec76d65eea4@linaro.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 10:12:35PM +0100, Krzysztof Kozlowski wrote:
> On 13/11/2023 01:55, Jisheng Zhang wrote:
> ...
> 
> > diff --git a/include/dt-bindings/reset/sophgo,cv1800b-reset.h b/include/dt-bindings/reset/sophgo,cv1800b-reset.h
> > new file mode 100644
> > index 000000000000..28dda71369b4
> > --- /dev/null
> > +++ b/include/dt-bindings/reset/sophgo,cv1800b-reset.h
> > @@ -0,0 +1,96 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> > +/*
> > + * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
> > + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> > + */
> > +
> > +#ifndef _DT_BINDINGS_CV1800B_RESET_H
> > +#define _DT_BINDINGS_CV1800B_RESET_H
> > +
> > +/*				0-1	*/
> > +#define RST_DDR			2
> > +#define RST_H264C		3
> > +#define RST_JPEG		4
> > +#define RST_H265C		5
> > +#define RST_VIPSYS		6
> > +#define RST_TDMA		7
> > +#define RST_TPU			8
> > +#define RST_TPUSYS		9
> > +/*				10	*/
> 
> Why do you have empty IDs? IDs start at 0 and are incremented by 1.

there's 1:1 mapping between the ID and bit. Some bits are reserved, I.E
no actions at all. Is "ID start at 0 and increment by 1" documented
in some docs? From another side, I also notice some SoCs especially
those which make use of reset-simple driver don't strictly follow
this rule, for example, amlogic,meson-a1-reset.h and so on. What
happened?

And I'd like to ask a question here before cooking 2nd version:
if the HW programming logic is the same as reset-simple, but some
or many bits are reserved, what's the can-be-accepted way to support
the reset controller? Use reset-simple? Obviously if we want the
"ID start at 0 and increment by 1" rule, then we have to write
a custom driver which almost use the reset-simple but with a
customized mapping.

Thanks
