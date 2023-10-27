Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A647DA273
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjJ0V2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0V2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:28:48 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D52FB0;
        Fri, 27 Oct 2023 14:28:46 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ce2d4567caso1573013a34.2;
        Fri, 27 Oct 2023 14:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698442126; x=1699046926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdTt8PHQuQvOBpC1eoOsFL8Yp23vOfTSoEW4AkdQHjg=;
        b=ehx2le4X/3JVmjN9H5neSwywu3AzaLmIY9EgN/rLbdB0K7bk6l5QF9WZ/J9GkS00CX
         fReRfUWXdpJuZ5HHCLFbhjMGL4htWnbRGIx0macMNj1ZVn5oe+5hjNIxxDMPa1rjmtIz
         EOvU7l1LjTxNlA4Ni5v9+vuDfmaIzm9nANyP45Hv8bL+ywddIzxIBlbFK84gOPNcQ0/f
         ZjooSx0NgzqArSslNMDZNZ1TgoWpI6E42dv+58k2UPVU2CqqpUhMN+9eG2+ZbKkg3K3x
         xcUeLoR3DRReC5T7Na7Ynj6LYan+QWovB4Q5bZKTDOIc4AevYjeI2ZXcz+I3S9JtmyTJ
         pMGg==
X-Gm-Message-State: AOJu0YzetITye0Luv6oKcWRqlZDXjItiHQF6Ia0ZYwO4YA7pMhktDrFr
        2h0KmxiRigtpyX0tcObY4A==
X-Google-Smtp-Source: AGHT+IH3L+ldv23BqrbLR5j2Gob04xH3oLMKR+tpIoBoSpo4Bj82KhLgNfRTveofQx3CPQG3Kk+lXQ==
X-Received: by 2002:a05:6830:6b47:b0:6ce:2a70:c76c with SMTP id dc7-20020a0568306b4700b006ce2a70c76cmr3705297otb.23.1698442125686;
        Fri, 27 Oct 2023 14:28:45 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b2-20020a056830310200b006ce1f9c62a1sm422025ots.39.2023.10.27.14.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 14:28:44 -0700 (PDT)
Received: (nullmailer pid 3403056 invoked by uid 1000);
        Fri, 27 Oct 2023 21:28:43 -0000
Date:   Fri, 27 Oct 2023 16:28:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>
Subject: Re: [PATCH v4 4/7] dt-bindings: arm64: mediatek: Add
 mt8183-kukui-jacuzzi-makomo
Message-ID: <169844212339.3402995.3814643307780522383.robh@kernel.org>
References: <20231026191343.3345279-1-hsinyi@chromium.org>
 <20231026191343.3345279-5-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026191343.3345279-5-hsinyi@chromium.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Oct 2023 12:09:13 -0700, Hsin-Yi Wang wrote:
> Add makomo sku0 and sku1 which uses different audio codec.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v3->v4: remove error const.
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

