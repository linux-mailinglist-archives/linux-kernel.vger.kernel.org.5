Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9219A7F4419
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjKVKmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjKVKmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:42:10 -0500
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180A212A;
        Wed, 22 Nov 2023 02:42:07 -0800 (PST)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35c18e55633so116995ab.2;
        Wed, 22 Nov 2023 02:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700649726; x=1701254526;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6HuamMXzkG3dBFbscYenhwBD+Wn3yIENDIYF/6YUDIE=;
        b=d0BgLWdXy9nkiL2Aq6FoyerkUQmvODEJM57E0bqh9bxCeOUAlQ0UQjsmaZ6i9M36pi
         MjYhQGVxXJEEwBEbS+Y1SchSYUJngM6kYbUaFUpAXwii7JCNtJlpYZjK97+mymSWe5R1
         OoLsZxeorpKFuERjqGpF8pW1KiCEk8juKNz5iOAXA5DixnBT1jUCJm+i55xt3mLG93bg
         JS9ieOf5cg50fN2Hx49uFQ/S10tjmeWVhePVaAk+Ktf3jRf95SIV3nopY+9cld2wCvyI
         BUwHm3MH9UNobWZEiFHd/IGDWXLqBPrzQ670984QqpaZD5AyS79XdGDouQY8yIvia5GM
         C8xg==
X-Gm-Message-State: AOJu0YwgmRwJf15EAbHMA2DVr78AHIDhX6NauCcOR5bZk8e7ZQE30Qjw
        XhW8yTnc+GT70UUWF1O2+Q==
X-Google-Smtp-Source: AGHT+IHQ9FouN8UAMgPy7sryk0bXm9NzUT4rdOKn+H86a8Gao08y39jnZj5Pi/YGSftp/vt6Z2kxuw==
X-Received: by 2002:a05:6e02:12a6:b0:35b:ce4:cb81 with SMTP id f6-20020a056e0212a600b0035b0ce4cb81mr1474242ilr.29.1700649726138;
        Wed, 22 Nov 2023 02:42:06 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id bm3-20020a056e02330300b0035161817c37sm3830402ilb.1.2023.11.22.02.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:42:05 -0800 (PST)
Received: (nullmailer pid 87993 invoked by uid 1000);
        Wed, 22 Nov 2023 10:42:03 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     monstr@monstr.eu, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        conor@kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
        devicetree@vger.kernel.org, git@xilinx.com
In-Reply-To: <e7af81b1ef3f6b7a07f4f0691f5140156477e87e.1700644418.git.michal.simek@amd.com>
References: <ef58475a717c62bc86aeea5148d5b88cdc0cc106.1700644418.git.michal.simek@amd.com>
 <e7af81b1ef3f6b7a07f4f0691f5140156477e87e.1700644418.git.michal.simek@amd.com>
Message-Id: <170064972393.87962.206577065405754996.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: soc: Add new board description for
 MicroBlaze V
Date:   Wed, 22 Nov 2023 03:42:03 -0700
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


On Wed, 22 Nov 2023 10:13:51 +0100, Michal Simek wrote:
> MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
> It is hardware compatible with classic MicroBlaze processor. Processor can
> be used with standard AMD/Xilinx IPs including interrupt controller and
> timer.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Put MicroBlaze V description to xilinx.yaml
> - Add qemu target platform as platform used for testing.
> 
>  Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/xilinx.yaml:137:10: [warning] wrong indentation: expected 10 but found 9 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/e7af81b1ef3f6b7a07f4f0691f5140156477e87e.1700644418.git.michal.simek@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

