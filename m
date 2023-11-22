Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B0E7F44D4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343669AbjKVLWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343587AbjKVLWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:22:40 -0500
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E582197;
        Wed, 22 Nov 2023 03:22:37 -0800 (PST)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7ad501cb1f9so257691639f.0;
        Wed, 22 Nov 2023 03:22:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700652156; x=1701256956;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zj0FMeXmZaLFHcDzJTQgipypunMiy6dY5lJGXKJ5iLE=;
        b=Y+QKB3kQq+LhlS6Q1Sj9wX3LnpP8sbc1EdSuVGCRB0llqbfYVGda8KgIdbSNFaek3W
         73c538E8gUDaTXKaoT4+4U4TsAhbDv8e0OMlhmYMpOGhrsRZn0fq7yBPOLdC5QorLtDR
         7tyvSA1Jp8UjHxKLGGhINsq5qma7NcuPoEUdEIo2E70Qw46CCTZJ0UY2m6kOO2hT+Q8D
         L4Q0wZYZNWYcIK7fw+EDleKq4gvMJwJws1SYmAl7hAFcN9yGcWjPNVx8k0TXEPCr5dOg
         sAhh5+6qLOVMbP6h0Q505TzOmyajd9qhXbRw5zmwm+rp1KPRjmmZnhXfi/jg3ObHJ5Fk
         LBtw==
X-Gm-Message-State: AOJu0YyBGqgD5gygGrs1A9aCDhvw2tT37iDA7W1QrItZYfzln5qrOoQk
        AEWoCAm31q742dF+emTSYBIKSRFtug==
X-Google-Smtp-Source: AGHT+IE5AaMO5ccVmjeQMs+c1NmBQLPKnBYj3HiPziCiqUqVINA24WPX6yT8oPrsPk1ympBeEzcPmg==
X-Received: by 2002:a05:6e02:1d8b:b0:359:3150:c696 with SMTP id h11-20020a056e021d8b00b003593150c696mr1942671ila.8.1700652156424;
        Wed, 22 Nov 2023 03:22:36 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n2-20020a92d9c2000000b0035b0b05189bsm1593415ilq.38.2023.11.22.03.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 03:22:35 -0800 (PST)
Received: (nullmailer pid 262788 invoked by uid 1000);
        Wed, 22 Nov 2023 11:22:34 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     conor@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, git@xilinx.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        monstr@monstr.eu,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <9f925b8e1580df2bd53ce37028d56775b51e1415.1700648588.git.michal.simek@amd.com>
References: <281ed28bccc14e7006caf17d6cfeb2a679b0e255.1700648588.git.michal.simek@amd.com>
 <9f925b8e1580df2bd53ce37028d56775b51e1415.1700648588.git.michal.simek@amd.com>
Message-Id: <170065215396.262656.16459426202425895063.robh@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: soc: Add new board description for
 MicroBlaze V
Date:   Wed, 22 Nov 2023 04:22:34 -0700
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


On Wed, 22 Nov 2023 11:23:13 +0100, Michal Simek wrote:
> MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
> It is hardware compatible with classic MicroBlaze processor. Processor can
> be used with standard AMD/Xilinx IPs including interrupt controller and
> timer.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Changes in v3:
> - Add Krzysztof's ACK
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/9f925b8e1580df2bd53ce37028d56775b51e1415.1700648588.git.michal.simek@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

