Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCB57F2891
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjKUJUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjKUJUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:20:08 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A56FA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:20:03 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-da41acaea52so4971874276.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700558402; x=1701163202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e0GnsYSjmMnnlfj2CWEXFz1CqUs2uGzKvSRcvkw5bjs=;
        b=JCKgJlqfNrr/Kd0IbU4DXNllY54+Wjs3TBNKIPViw27VRn7QzfehGURVE/BCq6khIH
         SRFGCXovd0ZCX5fdajIY4jn2R6KVA2Yx193y33q8+SX8Iw7mv5yK/Y47Iu4Ybdi1yG0R
         pL9ySpMhZLFXOtY8CaqreGe9URFLWEKvUmQlsB7/OXAR8nOQtyp5H96H4lg7XfnDlbEG
         h9LoMTmNnROteLbb/WjWYHDRpOjYq+nTt4yRyB+ljOP0SCfBvO29CC+nyAhX6hGNlDu0
         VOARcusWCH3R6sdUGQ2na0xqZOItV+Y9E3deHI94trQ3mYYOsvdXFAv31d0ORwlxGzRT
         7nFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700558402; x=1701163202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0GnsYSjmMnnlfj2CWEXFz1CqUs2uGzKvSRcvkw5bjs=;
        b=ijE2CZK5ggwj84OLoTTh7Jof7blnUtyS4DoHxnj6ttnP66fLomWVSkhEbwJNxaok3r
         PlfMHfpA3ApMtTqXQzwOpGQHVZ5sXhqd0/tiYEG2//4Q3G2CMnfVYL8j1lVrHnoKDrGX
         1/zqDN88Yty3l97CJ6JTE/35DuZOOtvoJPvScWjnBsIIgchuEsIq4BiBnGb/QvEnoDTk
         XYjsFQrApRI5/wRJBnRbEXsWUwSg/fUqWsjs+ECVFgzddY+nwRRCZieKSICEFsq+n4+1
         P7Nfkuj+dylZM2xZlbB0U8HDrcMveeebAgSJvqAqtRDc/uGFtDx6W2jLu46Q+QU2BpQr
         9lmw==
X-Gm-Message-State: AOJu0YwzalGBawiFVnwEQE/fLJiby/TiAzLhA4HEVoOpanHcBL2q4/Cm
        UulSQAxgi22fi5FsL8kzRYpBSYHPGqDKSwgk/wpbuQ==
X-Google-Smtp-Source: AGHT+IGGKp46rrXxTxtTOtiXmo2Li35FgNeYDd8e5HO6aCQZjqPditR2ptVz6cb2AzXxBDV7hw/hT+XOKdph+CuSf5Y=
X-Received: by 2002:a25:ae03:0:b0:db0:2161:5950 with SMTP id
 a3-20020a25ae03000000b00db021615950mr10361703ybj.63.1700558402174; Tue, 21
 Nov 2023 01:20:02 -0800 (PST)
MIME-Version: 1.0
References: <20231120224919.2293730-1-dmitry.baryshkov@linaro.org>
 <20231120224919.2293730-2-dmitry.baryshkov@linaro.org> <ac3f3304-6dcd-470a-907c-32a63d3c39cf@linaro.org>
In-Reply-To: <ac3f3304-6dcd-470a-907c-32a63d3c39cf@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Nov 2023 11:19:50 +0200
Message-ID: <CAA8EJppOGsc1+iw-YB9FBEm2UPpyAB_4cQg94Ob4swPzXheQ7A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: connector: usb: add altmodes description
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 at 10:31, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/11/2023 23:00, Dmitry Baryshkov wrote:
> > Add description of the USB-C AltModes supported on the particular USB-C
> > connector. This is required for devices like Qualcomm Robotics RB5,
> > which have no other way to express alternative modes supported by the
> > hardware platform.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  .../bindings/connector/usb-connector.yaml     | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > index 7c8a3e8430d3..c1aaac861d9d 100644
> > --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > @@ -171,6 +171,28 @@ properties:
> >        offer the power, Capability Mismatch is set. Required for power sink and
> >        power dual role.
> >
> > +  altmodes:
> > +    type: object
> > +    description: List of Alternative Modes supported by the schematics on the
> > +      particular device. This is only necessary if there are no other means to
> > +      discover supported alternative modes (e.g. through the UCSI firmware
> > +      interface).
> > +
> > +    patternProperties:
> > +      "^(displayport)$":
>
> This is just a property, so should be under "properties:".

Having it under properties would make adding new altmodes harder.

Inherently it should become something like
"^(displayport|virtuallink|thunderbolt)$".

>
> The rest looks good to me, but I don't know USB that much to judge.
>
> Best regards,
> Krzysztof
>


-- 
With best wishes
Dmitry
