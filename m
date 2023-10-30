Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDCF7DBCDD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjJ3PqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjJ3PqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:46:22 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC1CDD;
        Mon, 30 Oct 2023 08:46:20 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3b2f5aed39cso2874368b6e.1;
        Mon, 30 Oct 2023 08:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698680780; x=1699285580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhgYLbg9CpuoRxcaeuro+Zs7vQs2cUHUGXONLu3huPI=;
        b=T7PRoXRDWqLLFhzKXevEq4gTTEKHEBoAa+Vq2ohewzuFbmF7RYUIy6SlE76OmZzwXT
         G2oXJPDwWllv28JJQTqx03HzjgF/QpT3EvIr2MdW1tpFe3nfG3yzWy1S1ltwiRTUg/Ov
         gYwfUCG4xWvbE7XxOzHFcydEXpAiBzIDZIQ6WC8ypsqTmsoqIj8bpncX0aeQneJVzRHe
         PixW+TjlmWvZVgvSf/pg0U35WPrqixZaSfFZ+H89n8rsMpNegbmx5vMzFhjHMoXW2PWk
         yLZnkqEokpj1vpMBxoCqLvDN3xspO8abwF8sU4QKwxv3gWoxnE1+LJf16vrxtpM/hZmn
         qnSA==
X-Gm-Message-State: AOJu0YxE7kUdtrVRbenU6KBgeJkXD9MJO1LfniyU3H6u8042+ffwz8bN
        8ji0SgBl/iqPseOpXKFm3w==
X-Google-Smtp-Source: AGHT+IFSruwbJkEig+B3Y64xgE9mhFyNxARc1HIyHctZR+Z00jxUt3Wrrm8hz4v/Q8eRTqSYiXD6+w==
X-Received: by 2002:a05:6808:8ea:b0:3b2:f3e6:f36f with SMTP id d10-20020a05680808ea00b003b2f3e6f36fmr11142849oic.54.1698680780125;
        Mon, 30 Oct 2023 08:46:20 -0700 (PDT)
Received: from herring.priv ([2607:fb91:e6c7:c3eb:a6fd:69b4:aba3:6929])
        by smtp.gmail.com with ESMTPSA id i13-20020a056808030d00b003afe5617691sm1404553oie.12.2023.10.30.08.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 08:46:19 -0700 (PDT)
Received: (nullmailer pid 1240978 invoked by uid 1000);
        Mon, 30 Oct 2023 15:46:16 -0000
Date:   Mon, 30 Oct 2023 10:46:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: arm64: mediatek: Add
 mt8183-kukui-katsu
Message-ID: <169868077528.1240604.14632740739675998202.robh@kernel.org>
References: <20231026191343.3345279-1-hsinyi@chromium.org>
 <20231026191343.3345279-3-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026191343.3345279-3-hsinyi@chromium.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Oct 2023 12:09:11 -0700, Hsin-Yi Wang wrote:
> Add katsu sku32 and sku38 which uses different audio codec.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

