Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025937F44A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbjKVLC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343877AbjKVLCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:02:46 -0500
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BA3198;
        Wed, 22 Nov 2023 03:02:39 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-359d559766cso23728325ab.1;
        Wed, 22 Nov 2023 03:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700650959; x=1701255759;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hysRT5p62CMdMmCQloI5SV6AT3d/MMAHRidqQnYCAwU=;
        b=GXc+EMXGIh9rGz/+otSQnij1zQTbrUk8VO0MsQREG1UF9qjAIXnGZKAEEDG2H1FetB
         F8eGgc5Hzpo2LnnGi7tjDcvuS14yCTbglsq82Ivds0Q83HCMMs0azMJ+PzRJaWsbIzen
         z9mnwel431nbsh9qbvsZ088hHvJEHm623XDXsXQy27h2HXFqHhpZomW66Mm1PYvlLt1t
         2p1/X3C/KbtljgCc4U9bh6B5TaDwqQVfx425A4v50wP8VjNHpH1L3J4QbNca55ESP9i1
         5lI7N4y8Dxpmvveb3TNPAj65zVdTICsl+gFr7N2OTQxtRkpnobzARrHTYLqgT+b94Tl6
         x17g==
X-Gm-Message-State: AOJu0YyrVWmdwNl8KXaSqpSkmWEpqtYZo5ytZzc4YTdl/5XYakg2TcUv
        wStM01eKNkFCHqRqutvBSty/ZgajZw==
X-Google-Smtp-Source: AGHT+IGqcztZBkfnygd9n634B1WSm2HzbbRNzdj7N4qFsNXK5h5vKxiqUMmKY3wexuqXOCDWyvXczg==
X-Received: by 2002:a92:760a:0:b0:359:38ab:5a55 with SMTP id r10-20020a92760a000000b0035938ab5a55mr1771540ilc.22.1700650959108;
        Wed, 22 Nov 2023 03:02:39 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u17-20020a92da91000000b0035b0ad262e2sm1590867iln.47.2023.11.22.03.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 03:02:38 -0800 (PST)
Received: (nullmailer pid 116330 invoked by uid 1000);
        Wed, 22 Nov 2023 11:02:29 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-sound@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20231122-ep93xx-v5-28-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-28-d59a76d5df29@maquefel.me>
Message-Id: <170065094949.116273.16587209565152503484.robh@kernel.org>
Subject: Re: [PATCH v5 28/39] ASoC: dt-bindings: ep93xx: Document Audio
 Port support
Date:   Wed, 22 Nov 2023 04:02:29 -0700
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Nov 2023 12:00:06 +0300, Nikita Shubin wrote:
> Document Audio Graph Port support in binding document.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231122-ep93xx-v5-28-d59a76d5df29@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

