Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B495F7DC191
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjJ3VGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjJ3VGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:06:02 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711D7FF;
        Mon, 30 Oct 2023 14:05:59 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-57f0f81b2aeso2743952eaf.3;
        Mon, 30 Oct 2023 14:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698699959; x=1699304759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9b8yRbcU2SsJIUn99dRsWUQrYEHNEkALeq7pmho+k4=;
        b=qgaOoszgqJkXZcZskYQbj12u1sLoqQ+vS8qAvOtT2yQUx3HU6gW80e1tyTf/E0oBWA
         N3rC/xs2unE7GdLgowoA+QyCZhWcEYRFScWRtbXUGlT1U7Y9+ynQvHzU1WHU7j0KJ2XQ
         HzMSpbsmh4V2CZaW37m4meNJaBn/qj85vDcY82obLhnuwzh8Pwr5la/776r+Hv5P1qgS
         KCaHfIm9nGYCv7DgygwIqy3cI2H3E5uQMNRKNV1TxlvewowrN4d32mEgE5VtFYvu0wz4
         7vJ7r167DC7ne9k26BA4SuC3B6KSZeBvZ49nOujhcN4rYBRhdQRXtP71TToQmG+KxAWZ
         /Qfg==
X-Gm-Message-State: AOJu0YxQihyB06okhacnU5Bo5x3cZemlCIjSLtcq7Vs9GuVbAVauKsR5
        4SMMzAblPW/rK/JsdelgoA==
X-Google-Smtp-Source: AGHT+IG4qTbD6SgqI7z9BeiHmnh22XwU6n1Av0H01o3QjlBhOkUqSdyDIU2X/Y9zYeLL/JnesSOw1w==
X-Received: by 2002:a4a:e7d5:0:b0:581:f6d8:5ca2 with SMTP id y21-20020a4ae7d5000000b00581f6d85ca2mr10506008oov.6.1698699958719;
        Mon, 30 Oct 2023 14:05:58 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u17-20020a4a9711000000b0057bcbc23738sm1972423ooi.17.2023.10.30.14.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 14:05:57 -0700 (PDT)
Received: (nullmailer pid 2462145 invoked by uid 1000);
        Mon, 30 Oct 2023 21:05:56 -0000
Date:   Mon, 30 Oct 2023 16:05:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        James Clark <james.clark@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm,coresight-cti: Drop type for 'cpu'
 property
Message-ID: <169869995373.2462048.15638522466589160711.robh@kernel.org>
References: <20230925220511.2026514-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925220511.2026514-1-robh@kernel.org>
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


On Mon, 25 Sep 2023 17:05:05 -0500, Rob Herring wrote:
> 'cpu' has been added as a single phandle type to dtschema, so drop the
> type here.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Applied, thanks!

