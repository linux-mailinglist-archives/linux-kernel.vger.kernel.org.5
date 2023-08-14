Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF8F77B6AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjHNK3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjHNK2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:28:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA5310F;
        Mon, 14 Aug 2023 03:28:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bcc0adab4so545664366b.2;
        Mon, 14 Aug 2023 03:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692008919; x=1692613719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD+dZC6ILC0zBFJ75+s8TCoV5USuF9fK+77Nw8Aje0w=;
        b=KWdqfZ62xxlrvlMKf2qpi7YAx2rbvFG/rCy6KhPTmVZphJsw4o2qpe1XzHr2ulW9ig
         dJocY4tSGDsDN8BwwO1YOQawk66HkEn80/HhW/9hlO6rOow7AfWW5ejsrLhaPH16P9kI
         wf7SMRXGkVgrdLwcNcHzBNB7TdGjz+ahTGskjF0PqMlDTx7kItkd0xOLzJyi1Kjn74TF
         IZ3bJUC1Dq/EpL3zzYFza3Qn5PV29G9w5keslAkAtcSJCAw/AkZGh8bevjk/lcV5+KDs
         IWxarqq5J8fQu8ZYSNrror9GhedNj152iiEaVa+GX1N6T82hz+c11S0hNGGo6iqScOVF
         mMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692008919; x=1692613719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FD+dZC6ILC0zBFJ75+s8TCoV5USuF9fK+77Nw8Aje0w=;
        b=b6Dd6eJE+kiIglqZ1FRAm8CJjQRA0DiUaFBuOiMKaZAAMusXsZ+7klBcJxEK1bRtjH
         +PEfGSpLLP2hlSV5IMgmQ3p/FQl+gfQr6chuhOhuBf7juqrsmEoY3sxCMtFRivaZohK6
         CWxNDi6q0U0c9mJ/0+g65tBlhCbZkQzxUopOz6y3L4vB+34dlyRbuCqxW0R701xtM09h
         FEzmXWeOb68gBs4x4iIMxoWDdqnTez7POngN8sZtmcDh3aID9KxOhdDXRo8SjQCY8DVq
         VV0bvlAFGXtHJ7AvUoW68G9XUn7Nmxh1UZAm3JHiIvz1+K95zHEY33cWgPjOF2vgAv/K
         PVTw==
X-Gm-Message-State: AOJu0Yyg2CH/rKvMY6b/Zl8N/Q4QumwTu+xqlBtQ+89mO4o6NU2Qegtn
        IxIk9z/9cCsToWAE5Kd7He2BPJmJgzOIng==
X-Google-Smtp-Source: AGHT+IGLLfnjCAgn+nWhTlM7HypGsXCTlLNpZzQ1NwgZFCaXqFMayOU8fjnnL5sKdfMF6InnHfyjDw==
X-Received: by 2002:a17:906:1da1:b0:99b:c2d4:ddd8 with SMTP id u1-20020a1709061da100b0099bc2d4ddd8mr6745353ejh.31.1692008919572;
        Mon, 14 Aug 2023 03:28:39 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709060a0e00b0099b5a71b0bfsm5490638ejf.94.2023.08.14.03.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 03:28:39 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Martin Botka <martin.botka@somainline.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: nvmem: SID: Add binding for H616 SID
 controller
Date:   Mon, 14 Aug 2023 12:28:36 +0200
Message-ID: <5856748.MhkbZ0Pkbq@jernej-laptop>
In-Reply-To: <DKGDZR.4G4SZ781MVSV2@somainline.org>
References: <20230814-sid-h616-v2-0-0267749b4471@somainline.org>
 <830e5e34-f6de-3233-4a12-06c8390169d1@linaro.org>
 <DKGDZR.4G4SZ781MVSV2@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 14. avgust 2023 ob 10:21:49 CEST je Martin Botka napisal(a):
> On Mon, Aug 14 2023 at 10:08:38 AM +02:00:00, Krzysztof Kozlowski
> 
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 14/08/2023 08:38, Martin Botka wrote:
> >>  Add binding for the SID controller found in H616 SoC
> >>  
> >>  Signed-off-by: Martin Botka <martin.botka@somainline.org>
> >>  ---
> >> 
> >> Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> >> 
> >> | 1 +
> >> | 
> >>   1 file changed, 1 insertion(+)
> >>  
> >>  diff --git
> >> 
> >> a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> >> b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> >> 
> >>  index 296001e7f498..2ec0a1b8f803 100644
> >>  ---
> >> 
> >> a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> >> 
> >>  +++
> >> 
> >> b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> >> 
> >>  @@ -27,6 +27,7 @@ properties:
> >>             - const: allwinner,sun50i-a64-sid
> >>         
> >>         - const: allwinner,sun50i-h5-sid
> >>         - const: allwinner,sun50i-h6-sid
> >>  
> >>  +      - const: allwinner,sun50i-h616-sid
> > 
> > It does not look like you tested the DTS against bindings. Please run
> > `make dtbs_check` (see
> > Documentation/devicetree/bindings/writing-schema.rst or
> > https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sour
> > ces-with-the-devicetree-schema/ for instructions).
> > 
> > Best regards,
> > Krzysztof
> 
> Yea completely forgot. Sorry for that.
> 
> Will send v3 tomorrow with proper binding patch using items with enums

Don't. You have cca. 1 month time now, since you missed at least window for DT 
changes for 6.6.

Best regards,
Jernej



