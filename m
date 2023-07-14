Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954BD75441A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 23:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbjGNVKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 17:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGNVKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 17:10:20 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383ED2707;
        Fri, 14 Jul 2023 14:10:19 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7836164a08aso97454439f.1;
        Fri, 14 Jul 2023 14:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689369018; x=1691961018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkCjprVYBJpe7HRMk9SvWkrvsXF3xVXknPaBi2ASDrw=;
        b=ZqtTsJ2544sMCZoSDxd9mvdCL73475zp/SVS0r2n4dJSAxmVbOPW6BpmpvtO5grNSj
         Att2WEqdqun2gDo/CZTpm9Xnq4u0S9ho8T7f6qHsxeh8KxcFQVXnRqrrueS0Qoek80rL
         aAf7uHf5FWW9hf7BXjAKjzSIfruDwSY6oZKUM14u/3G8Bb1GeBz0XBrGzb1crQyZXK4g
         50LoXOFTJCsP6hllEoPf3QGYRKRPUZwtO7XWFxkMLUFXZ38fYzhaJkWEKV1WemGb9j0g
         4Q7t5tG8JVcBTSGV/oiBu6xluhOqD+p4Fll6JZw1guQ34xTGxu9MqvdH+NedKxSgiy0O
         wvvw==
X-Gm-Message-State: ABy/qLZ4BM2eoQltP/xXdzpdX0tbrqAgc0aQzCRTECoLNF1Eduuip5Nx
        TgU4ai4crt6Pv2AsALbUag==
X-Google-Smtp-Source: APBJJlHw2d99DUg4gS2VZfnGG0p4S0aamaC8pUtwgVWFXwCrzpNa4KyrdxyzMFAGOi1rds0VjPsDyQ==
X-Received: by 2002:a6b:a04:0:b0:776:fd07:3c96 with SMTP id z4-20020a6b0a04000000b00776fd073c96mr6153362ioi.7.1689369018459;
        Fri, 14 Jul 2023 14:10:18 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b9-20020a056602218900b007835686237asm2923748iob.27.2023.07.14.14.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 14:10:17 -0700 (PDT)
Received: (nullmailer pid 250792 invoked by uid 1000);
        Fri, 14 Jul 2023 21:10:02 -0000
Date:   Fri, 14 Jul 2023 15:10:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, Xiubo.Lee@gmail.com,
        nicoleotsuka@gmail.com, shengjiu.wang@gmail.com,
        festevam@gmail.com, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, conor+dt@kernel.org, perex@perex.cz,
        broonie@kernel.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: fsl_rpmsg: Add compatible string
 for i.MX93
Message-ID: <168936900247.250605.6973924196553077259.robh@kernel.org>
References: <20230714092913.1591195-1-chancel.liu@nxp.com>
 <20230714092913.1591195-2-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714092913.1591195-2-chancel.liu@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Jul 2023 17:29:12 +0800, Chancel Liu wrote:
> Add compatible string for i.MX93 platform which supports audio
> function through rpmsg channel between Cortex-A and Cortex-M core.
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

