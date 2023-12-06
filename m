Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ACA80761E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442745AbjLFRJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442647AbjLFRJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:09:37 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9121D3;
        Wed,  6 Dec 2023 09:09:41 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6d9d0d0e083so303299a34.2;
        Wed, 06 Dec 2023 09:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882581; x=1702487381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iI5hjWa77Sf/KBjh/jB8rfdIyFJDxe0sHwzujCbbVSg=;
        b=mEgOPiIs1HGTy6G+dr2KbEYH8J7OfjfrQ2R4aeWY2N/OArBnLln9/fVe30wHIcIW4g
         wUNslHkaGGSy5/NdLYgMGQUwqf3u8nCsWSYqkywDIz7xTFhM9guJDmfQJk9qlyB9dVqJ
         Yg8YPhjL3iRNR+QIZIJA2RoUM/QmjPFOYc7zIRDDagSKNY4tACF+9wifITvdYdGrXfZL
         wf2eX2qrbkfD4P+cBPPl5qvhr+dv+PK8y4aJro+uZfr+WNCPReZKUb5D9gzlLJJOWBqz
         0ib/9C5ZDRxIHxEGbjvG+yW5zNUygIyYI+KQLy1FYqaqB2kqUwo2CMzNiR+K4rujdhCj
         YSow==
X-Gm-Message-State: AOJu0YyO+OaAm7W4JFjEZcHiJ8YfLFb50eny6eSiWfAA07yj86cXd6Of
        P4ySc73HHc0oPNx7egNpyw==
X-Google-Smtp-Source: AGHT+IGYYrYPqxRD4wI2kY57RX78/Okb+2yHNgN5HP4in9wmkhehh7Gfbbh2RpqYhkuweieDZy0oEg==
X-Received: by 2002:a05:6871:72a:b0:1fa:dfd7:dc37 with SMTP id f42-20020a056871072a00b001fadfd7dc37mr1382817oap.37.1701882580993;
        Wed, 06 Dec 2023 09:09:40 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g4-20020a056870ea0400b001fb38204e42sm55710oap.20.2023.12.06.09.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 09:09:40 -0800 (PST)
Received: (nullmailer pid 2694820 invoked by uid 1000);
        Wed, 06 Dec 2023 17:09:39 -0000
Date:   Wed, 6 Dec 2023 11:09:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: cros-ec: Allow interrupts-extended
 property
Message-ID: <20231206170939.GA2195738-robh@kernel.org>
References: <20231130083333.932862-1-wenst@chromium.org>
 <2288442b-9002-4711-9b64-16b204f19985@linaro.org>
 <CAGXv+5HwzSX=x_0u-95i1+q+xbstrCmuMxRoKXJwEL5ErnRgOQ@mail.gmail.com>
 <7b9a2f1a-59d6-454c-95ed-6cb920751551@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b9a2f1a-59d6-454c-95ed-6cb920751551@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 09:03:09AM +0100, Krzysztof Kozlowski wrote:
> On 01/12/2023 05:37, Chen-Yu Tsai wrote:
> > On Thu, Nov 30, 2023 at 4:52 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 30/11/2023 09:33, Chen-Yu Tsai wrote:
> >>> "interrupts-extended" provides a more concise way of describing external
> >>> GPIO interrupts.
> >>>
> >>> Allow using this instead of "interrupts" plus "interrupt-parent" for
> >>> cros-ec.
> >>>
> >>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >>> ---
> >>>  .../devicetree/bindings/mfd/google,cros-ec.yaml          | 9 ++++++++-
> >>>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> >>> index e1ca4f297c6d..e514eac9f4fc 100644
> >>> --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> >>> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> >>> @@ -75,6 +75,9 @@ properties:
> >>>    interrupts:
> >>>      maxItems: 1
> >>>
> >>> +  interrupts-extended:
> >>> +    maxItems: 1
> >>> +
> >>
> >> I don't understand why you need it. You already have interrupts there,
> >> so this is redundant. I suggest to drop the patch or provide real
> >> rationale (which I doubt you can get :) ).
> > 
> > I'm sorry, I should've included this in the commit message.
> > 
> > The other half of the patch gets rid of a DT validation fail when
> > interrupts-extended is used instead of interrupts:
> > 
> > .../arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dtb: ec@0:
> > 'interrupts' is a required property
> >     from schema $id: http://devicetree.org/schemas/mfd/google,cros-ec.yaml#
> > 
> 
> That looks either like a bug in bindings or in dtschema or in your DTS.
> This patch should not be needed to solve that.

I'll be commiting a dtschema fix soon. There's quite a few places 
needing the fixup.

Rob
