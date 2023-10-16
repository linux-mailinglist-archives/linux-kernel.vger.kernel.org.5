Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A037CAB84
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjJPObI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjJPObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:31:01 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1D5128;
        Mon, 16 Oct 2023 07:30:55 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-57b635e3fd9so2280406eaf.3;
        Mon, 16 Oct 2023 07:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697466654; x=1698071454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pogla2ixenuu9Whu/Txm0dkQOdChFbDxggoz3QMNrmQ=;
        b=qD5OiGnn1iXsRDEpr5o0DLKdJXZERh9kaw6XIgUVk3YcEh/Nh+u5+rOBP2rvYQWUgg
         pbU1Pb4yWkmj0AaRkRiZNaqYtu8L5AMQWxq2DI5TRHrWmn6T49aiwKYjpcxvgQ9fqllu
         qvgkku4RYbMJF9RejfXsxmkYL7NIBeUWlK1tUXG8cSxq/B9VunUB/x1Q/PkskLwBQ5LA
         JYt2d9qsfAeSIkrh96OCAdMHjY5excLfX6iIdM14GI845EDA4JpU4kDepNe5jj+nspVX
         974YpyaNxys4Fif7lCm4cBDWDUygnJkURm7vOmV/0mCuUQ+6iPsJblM07eFQpJHapME3
         ctUA==
X-Gm-Message-State: AOJu0YxC6naBC9VQD5P+ggNTgY1L6tJp9wYooa77nI3I5M2AQsRc/YUo
        MwhNPNXGOAFKySB5yrkxfA==
X-Google-Smtp-Source: AGHT+IHx8iGwaQriKRdE3MbfGOtdCCNfmu6tH2ejuHsm2/UZEYPWAT5EG1IdyqRY9fD+m2NiQmDXHQ==
X-Received: by 2002:a4a:9b88:0:b0:57b:575f:4f8c with SMTP id x8-20020a4a9b88000000b0057b575f4f8cmr29144162ooj.9.1697466654636;
        Mon, 16 Oct 2023 07:30:54 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cj25-20020a056820221900b0057e54da7201sm1093968oob.35.2023.10.16.07.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 07:30:53 -0700 (PDT)
Received: (nullmailer pid 2775610 invoked by uid 1000);
        Mon, 16 Oct 2023 14:30:52 -0000
Date:   Mon, 16 Oct 2023 09:30:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@collabora.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v5] dt-bindings: arm: mediatek: convert audsys and
 mt2701-afe-pcm to yaml
Message-ID: <20231016143052.GA2770481-robh@kernel.org>
References: <20231013140505.483766-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013140505.483766-1-eugen.hristev@collabora.com>
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

On Fri, Oct 13, 2023 at 05:05:05PM +0300, Eugen Hristev wrote:
> Convert the mediatek,audsys binding to YAML, together with the associated
> binding bindings/sound/mt2701-afe-pcm.yaml .
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
> Changes in v5:
> - removed example for mt2701-audio
> - renamed mt2701-afe-pcm to mt2701-audio
> - added clock cells as required, removed reg from required, in audsys binding
> - removed reference comment in mt2701-audio
> - removed assigned clocks from mt2701-audio
> 
> Changes in v4:
> - fix error reported by Rob's bot : 
> ./Documentation/devicetree/bindings/sound/mt2701-afe-pcm.yaml:11:4: [error] missing starting space in comment (comments)
> 
> Changes in v3:
> - not added Rb Conor Dooley since the patch was changed in a big essence
> - As per review by Krzysztof, also convert the mt2701-afe-pcm and reference
> the correct schema in the audsys binding.
> 
> Changes in v2:
> - remove comment reference to inexistent binding
> 
> 
>  .../bindings/arm/mediatek/mediatek,audsys.txt |  39 -----
>  .../arm/mediatek/mediatek,audsys.yaml         | 153 ++++++++++++++++++
>  .../bindings/sound/mt2701-afe-pcm.txt         | 146 -----------------
>  .../bindings/sound/mt2701-audio.yaml          | 117 ++++++++++++++

mediatek,mt2701-audio.yaml

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
