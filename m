Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833037F449A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbjKVLCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343840AbjKVLCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:02:41 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B95C1;
        Wed, 22 Nov 2023 03:02:37 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7b074e318b5so18762039f.0;
        Wed, 22 Nov 2023 03:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700650956; x=1701255756;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c+/qnfzDFPUj6iI5uqp92qqd4Zj2Z3933483ozJajHs=;
        b=fGvaDkwYrt+hwpE5HAAxypxh41VMAXRuJBYHmNTxZWgfJkCvprbTqhsxDPX9L9COKk
         g/VHCQd/3VOrjS2nNNPc1eEhqFZ/87Yn3RD2C/zS6ZkH3P4KrWGWOpbpnInP3KVJSCSd
         C8TCVQvgK8jKEcKRwJ7SUhLiCBLTZFk1zT8dLi7gIwV89zreLfcTduYd/z/73f5vbUuK
         nHvQCQQ2NIdEmfJj1MOb1/P7RW0mrGlzvO9nEryYAEe1rPyWhJWKFCgqarZLYN+ouiBd
         vI6H+0tjz15F9VxgPCgk7gYOAxykQQFD6xQUgV8U++SZvm/ZZlYEe+UzD9jWcbqbQU8m
         9+Dw==
X-Gm-Message-State: AOJu0Yx7lIi8GNKk8yHPk76Erv1A36D4rSkLo9JDUdonjAVGs1snJSlj
        fW+DOKUvvWEUMokBkF7MNw==
X-Google-Smtp-Source: AGHT+IFtY2cET50yT6zSy5JzZ/L7TrNO7ts4wvPPMbE8WDkspdiasUwij2+Q1+HdRjru9x7pvwRgyQ==
X-Received: by 2002:a05:6602:36c6:b0:79f:e800:ea95 with SMTP id bg6-20020a05660236c600b0079fe800ea95mr2005732iob.3.1700650956320;
        Wed, 22 Nov 2023 03:02:36 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id gh12-20020a056638698c00b004646280da51sm3148708jab.88.2023.11.22.03.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 03:02:35 -0800 (PST)
Received: (nullmailer pid 116326 invoked by uid 1000);
        Wed, 22 Nov 2023 11:02:29 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20231122-ep93xx-v5-24-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-24-d59a76d5df29@maquefel.me>
Message-Id: <170065094485.116162.12375225214962321921.robh@kernel.org>
Subject: Re: [PATCH v5 24/39] dt-bindings: wdt: Add ts72xx
Date:   Wed, 22 Nov 2023 04:02:29 -0700
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


On Wed, 22 Nov 2023 12:00:02 +0300, Nikita Shubin wrote:
> Add DT binding for Technologic Systems TS-72xx watchdog.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/watchdog/technologic,ts7200-wdt.yaml  | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231122-ep93xx-v5-24-d59a76d5df29@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

