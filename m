Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD37179AD4C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjIKUtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbjIKJvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:51:35 -0400
Received: from out-224.mta1.migadu.com (out-224.mta1.migadu.com [95.215.58.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA00E40
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:51:29 -0700 (PDT)
Date:   Mon, 11 Sep 2023 19:49:11 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694425887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0AVtJvOvxL1Rv82m1/fmLK9vTdLbPmAMKzyqL7jm1Lw=;
        b=wD+Aq9cumadywoTlaZfJQPfztntYR2EA85Ee0fx4LuNSc1kO44IrfGls9Qb4pFGDhfpqio
        eePJailD5wS4SBW1Kmf9bZWc00Ah0ykZP/YkwLnI9xRIkdK2QbvS6CrNPgw0EMomWDTaFl
        aEXPWIgaYgcqRFaXAnr+cfUho6BauW1/+MIRsed3b2fONc6ZAyucKbU7Ex23pZ8RNU938E
        QS6OMptPwxUmqjvGwU7oMLfb0b2SCVUD7l48mLP4EWNmHBSraI6yNRmHZw5gcPU4Kdi4iP
        b/PFGvLBAgdCsK2/48hf652iBm8COsulQHjBhQ3lJ6UMurokaBJZBzfNHmNbKw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 8/8] dt-bindings: display: panel: add Fascontek
 FS035VG158 panel
Message-ID: <ZP7il27e9cExVWaL@titan>
References: <20230911090206.3121440-1-contact@jookia.org>
 <20230911090206.3121440-9-contact@jookia.org>
 <e22e61e7-02b1-8127-888d-e470838f4a18@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e22e61e7-02b1-8127-888d-e470838f4a18@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

On Mon, Sep 11, 2023 at 11:41:12AM +0200, Krzysztof Kozlowski wrote:
> > +maintainers:
> > +  - John Watts <contact@jookia.org>
> > +
> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: fascontek,fs035vg158
> > +
> > +  backlight: true
> > +  port: true
> > +  power-supply: true
> > +  reg: true
> > +  reset-gpios: true
> 
> Why do you need all these 5? They are allowed by panel-common.
> 
> > +
> > +  spi-3wire: true
> > +
> > +required:
> > +  - compatible
> 
> Missing reg. Probably also port.
> 
> 
> > +  - power-supply
> > +  - reset-gpios
> > +

I have just copy pasted the other panel's yaml, so these issues apply
there too. Should I fix that panel's yaml up first then re-copy?

> 
> 
> Best regards,
> Krzysztof
> 

John.
