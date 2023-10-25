Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B147D6AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjJYMLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjJYMLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:11:52 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96458F;
        Wed, 25 Oct 2023 05:11:49 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1e9d3cc6e7aso3644502fac.2;
        Wed, 25 Oct 2023 05:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698235909; x=1698840709;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HCPxgs4NDh+ho3+ibefi5n2+RrXmyVlZVu+Q51te2v4=;
        b=lrbBz0e+73t37IWLz5n3LOcjiuZKr2MomYvzP3aQGWRKzy1YF5j72Rd4Hbr4MS+rss
         ySrorq1h9DOoS0NQmLK9wAAymOo2g3BGGOauGz+HxGwekjq0bl7rHapj6j3LAwObcih8
         NbVpREuQJ79nUqo9ulKpwChy6meEKkwFJo2qG+b5/sS6Joh69fOKXQ9l3e1YWAtlLBbG
         VWd7Ojo9dP3nIqEG2DgciAEyktntdK3dR1qZmwA1pQOXKWdQGSlbYu6O2KPZHaBWupFH
         rowqFL/csS79u57HYC1vMIItn0fHsNy8vmy3wASdb4tJmzVt+qiOAdaVTQt0o5MaDiLV
         OFHw==
X-Gm-Message-State: AOJu0Yx8BHPAbTXViZK5R3gAu3NdBKdGev1QGY46aO8oXgYcyVJg8uzc
        OEkCUNPr0hun4MTXnL+AIA==
X-Google-Smtp-Source: AGHT+IHK4CWlhFUcrr2tQOB6IBVUM5SaULgdBfzfqNt/82aSi0iQDTiGIhgrsbRNKvEcKAMBHVkAfA==
X-Received: by 2002:a05:6871:78a:b0:1e9:d25d:3cb0 with SMTP id o10-20020a056871078a00b001e9d25d3cb0mr18681753oap.21.1698235908781;
        Wed, 25 Oct 2023 05:11:48 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id nd25-20020a056871441900b001dcfaba6d22sm2620513oab.46.2023.10.25.05.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 05:11:48 -0700 (PDT)
Received: (nullmailer pid 3367369 invoked by uid 1000);
        Wed, 25 Oct 2023 12:11:47 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Simon Glass <sjg@chromium.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <mwalle@kernel.org>,
        linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>,
        Richard Weinberger <richard@nod.at>
In-Reply-To: <20231024213940.3590507-2-sjg@chromium.org>
References: <20231024213940.3590507-1-sjg@chromium.org>
 <20231024213940.3590507-2-sjg@chromium.org>
Message-Id: <169818808080.999988.12536383382799868342.robh@kernel.org>
Subject: Re: [PATCH v5 2/3] dt-bindings: mtd: binman-partition: Add binman
 compatibles
Date:   Wed, 25 Oct 2023 07:11:47 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Oct 2023 10:39:17 +1300, Simon Glass wrote:
> Add two compatible for binman entries, as a starting point for the
> schema.
> 
> Note that, after discussion on v2, we decided to keep the existing
> meaning of label so as not to require changes to existing userspace
> software when moving to use binman nodes to specify the firmware
> layout.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v5:
> - Add mention of why 'binman' is the vendor
> - Drop  'select: false'
> - Tidy up the compatible setings
> - Use 'tfa-bl31' instead of 'atf-bl31'
> 
> Changes in v4:
> - Correct selection of multiple compatible strings
> 
> Changes in v3:
> - Drop fixed-partitions from the example
> - Use compatible instead of label
> 
> Changes in v2:
> - Use plain partition@xxx for the node name
> 
>  .../mtd/partitions/binman-partition.yaml      | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml: properties:compatible: [{'enum': ['binman,entry', 'u-boot', 'tfa-bl31']}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml: properties:compatible: [{'enum': ['binman,entry', 'u-boot', 'tfa-bl31']}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
Documentation/devicetree/bindings/mtd/partitions/binman-partition.example.dtb: /example-0/partitions/partition@100000: failed to match any schema with compatible: ['u-boot']
Documentation/devicetree/bindings/mtd/partitions/binman-partition.example.dtb: /example-0/partitions/partition@200000: failed to match any schema with compatible: ['tfa-bl31']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231024213940.3590507-2-sjg@chromium.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

