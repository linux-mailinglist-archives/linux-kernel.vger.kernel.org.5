Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A3C7B5AF9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238511AbjJBTKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjJBTKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:10:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A72B0;
        Mon,  2 Oct 2023 12:10:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3248aa5cf4eso138805f8f.1;
        Mon, 02 Oct 2023 12:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696273840; x=1696878640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=44FhHyZPxS1vHToE3Ph6Ff+aUwnP7tsx1/bNDklylBk=;
        b=af4dQ5GPr0grGJ/4Da9/eTQyPcr6ruhWK+Y0KGjL4Dhvfe351J0qIwlgtX/fozfzFy
         wja0/chXNlCblrb3v4AYxBop1Jxy7HIH4mjOSmQb9FV8EFFdtZs4Pli95SXlPisy2CSU
         cHa8z55ywP70TEcz6+AuU4sc87L2ZUi8GaqYeGIBG3yCq/+n2mj28fh0BVr8nCZ/t+sk
         5IM8+K2EgPLB6s1qIcC60V8duIU9CfT8xq3V0IlqAybPMAQif6NmMTGN4HFKtxrT79wl
         al1soDmfC6lDAnMfV73kQXlcivjZcUpUWH+QjD3I6QSX3eDsVtBRBsL8smCAcIY4FOCq
         pZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696273840; x=1696878640;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44FhHyZPxS1vHToE3Ph6Ff+aUwnP7tsx1/bNDklylBk=;
        b=PRIRtzOM/vZk5GVrobRCpJBfr4LwKA0f9JgzOr6xb9OF7iTTvcuBS4vDOrVO5FR0BZ
         9qa3XZ82wdQaVbhNd8B4pJPGDnWPxCjbnLgwVG97qKkAQIlaobpu6jwXhFX2S95pzUDW
         HRxOt1UUpSNvkx7xWt/UvgNRTfnC4l7Zj2ubeyckmOYqisJCHb/GdSrdD2HOS+/Kv2Es
         MDPQniy4oqIaR9HM2alR+I2IV+iT7mZ1O+Y7EGlOQAFkBhAK4sdYQm8dfexY5uSUgBk2
         R/MRqQuRfUukn7TWE9QRIu/zYz1wpAHg0gFHE+T/x6PYlCfyVxtx1Nx+GO0YK2cRR0P7
         F/lQ==
X-Gm-Message-State: AOJu0YzYUnEHSnoD4H3ffuzn28jM5kr3sVwRw+wmyr2SNDCgC02ABs60
        GOVJ7wS8ZaDDlSXVeFz9DReG0cPdFd9/hg==
X-Google-Smtp-Source: AGHT+IH8shIsZ+MgbnvuEhD2JazMM/bWGtTS3eaqp9pEQaLr3Wa4NykjKWTMpppzMKosL9z6dcTmnA==
X-Received: by 2002:adf:e892:0:b0:319:731f:748c with SMTP id d18-20020adfe892000000b00319731f748cmr10571937wrm.34.1696273839520;
        Mon, 02 Oct 2023 12:10:39 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id i3-20020adfdec3000000b00327bf4f2f16sm4326118wrn.30.2023.10.02.12.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 12:10:38 -0700 (PDT)
Message-ID: <651b15ae.df0a0220.c5688.0c40@mx.google.com>
X-Google-Original-Message-ID: <ZRsVqwJVHgJj6u/s@Ansuel-xps.>
Date:   Mon, 2 Oct 2023 21:10:35 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt-bindings: opp: opp-v2-kryo-cpu: Document named
 opp-microvolt property
References: <20230930102218.229613-1-robimarko@gmail.com>
 <20230930102218.229613-2-robimarko@gmail.com>
 <CAA8EJpoTsHhAVT3b84BC7Brvh=AUOUYSB_Z+_R-9OQ-u9BpH8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoTsHhAVT3b84BC7Brvh=AUOUYSB_Z+_R-9OQ-u9BpH8A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 10:07:44PM +0300, Dmitry Baryshkov wrote:
> On Sat, 30 Sept 2023 at 13:22, Robert Marko <robimarko@gmail.com> wrote:
> >
> > From: Christian Marangi <ansuelsmth@gmail.com>
> >
> > Document named opp-microvolt property for opp-v2-kryo-cpu schema.
> > This property is used to declare multiple voltage ranges selected on the
> > different values read from efuses. The selection is done based on the
> > speed pvs values and the named opp-microvolt property is selected by the
> > qcom-cpufreq-nvmem driver.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> > Changes v5:
> > * Fix typo in opp items
> >
> > Changes v4:
> > * Address comments from Rob (meaning of pvs, drop of
> >   driver specific info, drop of legacy single voltage OPP,
> >   better specify max regulators supported)
> >
> >  .../bindings/opp/opp-v2-kryo-cpu.yaml         | 39 +++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > index 27ea7eca73e5..8d2a47e9a854 100644
> > --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > @@ -65,6 +65,12 @@ patternProperties:
> >            5:  MSM8996SG, speedbin 1
> >            6:  MSM8996SG, speedbin 2
> >            7-31:  unused
> > +
> > +          Bitmap for IPQ806X SoC:
> > +          0:  IPQ8062
> > +          1:  IPQ8064/IPQ8066/IPQ8068
> > +          2:  IPQ8065/IPQ8069
> > +          3-31:  unused
> >          enum: [0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
> >                 0x9, 0xd, 0xe, 0xf,
> >                 0x10, 0x20, 0x30, 0x70]
> > @@ -73,6 +79,23 @@ patternProperties:
> >
> >        required-opps: true
> >
> > +    patternProperties:
> > +      '^opp-microvolt-speed[0-9]+-pvs[0-9]+$':
> > +        description: |
> > +          Named opp-microvolt property following the same generic
> > +          binding for named opp-microvolt.
> > +
> > +          The correct voltage range is selected based on the values
> > +          in the efuse for the speed and the pvs (power variable
> > +          scaling).
> 
> I suppose that simple 'true' schema should be enough since this is
> already mostly described in opp/opp-v2-base.yaml
>

Mhhh an example of the following implementation?

> > +        minItems: 1
> > +        maxItems: 4 # Up to 4 regulators: Core, Mem, Dig and HFPLL
> > +        items:
> > +          items:
> > +            - description: nominal voltage
> > +            - description: minimum voltage
> > +            - description: maximum voltage
> > +
> >      required:
> >        - opp-hz
> >
> > @@ -258,6 +281,22 @@ examples:
> >              };
> >          };
> >
> > +        /* Dummy opp table to give example for named opp-microvolt */
> > +        opp-table-2 {
> > +            compatible = "operating-points-v2-kryo-cpu";
> > +            nvmem-cells = <&speedbin_efuse>;
> > +
> > +            opp-384000000 {
> > +                opp-hz = /bits/ 64 <384000000>;
> > +                opp-microvolt-speed0-pvs0 = <1000000 950000 1050000>;
> > +                opp-microvolt-speed0-pvs1 = <925000 878750 971250>;
> > +                opp-microvolt-speed0-pvs2 = <875000 831250 918750>;
> > +                opp-microvolt-speed0-pvs3 = <800000 760000 840000>;
> > +                opp-supported-hw = <0x7>;
> > +                clock-latency-ns = <100000>;
> > +            };
> > +        };
> > +
> >          smem {
> >              compatible = "qcom,smem";
> >              memory-region = <&smem_mem>;
> > --
> > 2.41.0
> >
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
