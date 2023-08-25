Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757D2788CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbjHYPxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjHYPxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:53:13 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECA72134;
        Fri, 25 Aug 2023 08:53:10 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-79dc53034a8so428133241.3;
        Fri, 25 Aug 2023 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692978789; x=1693583589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f5Kmux/HC46hJNKCbtSnITYQVTMalez+vl2RvQ09lR8=;
        b=i268qshuyAMtctFsbTLamd9inbE3Cavm6XmKx8iW0wb0qjJy5DCCzL5SUDi6G1fArC
         6QjoF3ad5CyLHNX2PdjVMh1o1TI0XxwiJyHp4UlBuDz21VaJwR+3hSq+BETQMHK+JsR3
         ur1S65NFMTApeJEVR6VIiwsI9O9Y5h61zlPJnGyGwHXBQD8iUy7ikTNNnVx/mk+i8oWg
         BAvl8XiS5xVHsStYYtmnTWVJJuE2yss6Ifyyg9yI7XkZAwMj+iu7TGpSZmNrm1hmMvhm
         p8iMihPvt+NcyTUgvRIAROR9XBRVh+e4Q51/vNtIwIN9r1ACmuQs6Z6pU1okEsVXzFZG
         NYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692978789; x=1693583589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5Kmux/HC46hJNKCbtSnITYQVTMalez+vl2RvQ09lR8=;
        b=HWk8Xw8PCHyQKhKMlraE0iES7kmMV7o+k7ew+Ih146KsfN7/ymoz82EgkByyWRt+TT
         JvrDz5k21gpxa22wKQTW5JlXbpAv4E2A1HM4QF+xEg2NDZAudTj0ROzQpiq2m6wQDunH
         vPr2Uo5LatL5F/Xwrn8G0kc7MsfV2WwayqQTzl9m2NfDRJo/jHKh/kYA1SGqxvSjToVs
         C6Fs822bER0+DU61n2Zsk3Vj3cHvJ43YsJtxH0kTEfHGSTAV1eb4yh+59qV137FP0u78
         y4VudfbjDgsr2nBIiH1ZXH82odKLltpHtnIfXhwGvsTvhK0z3rTB0j8QGijP35vvt8P+
         5Frg==
X-Gm-Message-State: AOJu0YyynfVp7djoKZK9E+60wma8uWOL1Og53Czbf+UObdkwQC8piEp0
        OsVAn/+LrpFloFgR7o/GLpiqp+gtelsWYhZd
X-Google-Smtp-Source: AGHT+IFs/hx76DVW8mFdXhcvl/g6lqzGBFfz0RrxRAHpl0R8N0lkyWUSVZ8I41gGhSA4mwPUx6UTTQ==
X-Received: by 2002:a67:ee59:0:b0:44e:8626:71f2 with SMTP id g25-20020a67ee59000000b0044e862671f2mr7019845vsp.13.1692978789573;
        Fri, 25 Aug 2023 08:53:09 -0700 (PDT)
Received: from shaak (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id j13-20020a0cf50d000000b0063d2a70dff5sm635778qvm.72.2023.08.25.08.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:53:09 -0700 (PDT)
Date:   Fri, 25 Aug 2023 11:53:07 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: iio: adc: add lltc,ltc2309 bindings
Message-ID: <20230825155307.GA3149625@shaak>
References: <20230824-ltc2309-v1-0-b87b4eb8030c@gmail.com>
 <20230824-ltc2309-v1-3-b87b4eb8030c@gmail.com>
 <e54273c7-4728-7577-f053-b15307d3a083@linaro.org>
 <20230824185054.GA3659959@shaak>
 <fecb8658-ed3a-1c5c-70bb-5238b09d4e76@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fecb8658-ed3a-1c5c-70bb-5238b09d4e76@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, Aug 25, 2023 at 08:15:57AM +0200, Krzysztof Kozlowski wrote:
> On 24/08/2023 20:50, Liam Beguin wrote:
> > On Thu, Aug 24, 2023 at 07:56:29PM +0200, Krzysztof Kozlowski wrote:
> >> On 24/08/2023 18:55, Liam Beguin wrote:
> >>> Add devicetree bindings for the Linear Technology LTC2309 ADC driver.
> >>>
> >>> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> >>
> >> Thank you for your patch. There is something to discuss/improve.
> >>
> >>> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2309.yaml
> >>> @@ -0,0 +1,52 @@
> >>> +# SPDX-License-Identifier: GPL-2.0
> >>
> >> Wrong license. Run checkpatch before sending patches.
> >>
> > 
> > Sorry about that, I ran it through checkpatch but it didn't flag
> > anything.
> 
> No, you didn't, because checkpatch flags it easily:
> 
> WARNING: DT binding documents should be licensed (GPL-2.0-only OR
> BSD-2-Clause)
> #21: FILE: Documentation/devicetree/bindings/iio/adc/lltc,ltc2309.yaml:1:
> +# SPDX-License-Identifier: GPL-2.0
> 
> total: 0 errors, 2 warnings, 52 lines checked

It seems like I wasn't running checkpatch in strict mode.
Thanks for pointing that out.

> 
> Best regards,
> Krzysztof

Cheers,
Liam
