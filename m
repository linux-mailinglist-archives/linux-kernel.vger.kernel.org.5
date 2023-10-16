Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B447CA0DE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjJPHkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjJPHkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:40:12 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CB3102;
        Mon, 16 Oct 2023 00:40:08 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1e59894d105so2496546fac.1;
        Mon, 16 Oct 2023 00:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697442007; x=1698046807;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dGIab8fIcyevykBTB4mpYGLAzJrjPEg4bPMfLcokB60=;
        b=ZU7u5x5ITz2gpI+RFlBtE6YfZG636LXslU4d+sLECTa6m6CZhlr5IZZKhqoDONw693
         Oxe/k85UITyACiIHjMbaeeyZpuGewMuvgoVvafn/67g51XM2EHyoY0UUzjPz4HuTEyKz
         zYSAS2JPb67qDpfsNtf2cqXwf+SbPM53swqK/skC7h0myAefpNhQ0Sx69oclcJc7hUgu
         ORi0IPT7qKS0a0dYOCLteK9duwFhNO35GOanTV4LdfzelSteHM5QjkFVNBQEBfkI9yEc
         aVHBW18T7rUN/SeMHsrCkzdN+XYQzTl5Pc9c+aNiYDG4B17/djzgDJLYv5zwDEYiiIN7
         lrHw==
X-Gm-Message-State: AOJu0YyiKmkZGpBUIjmI8yD0H4aMDS/eWHOJY7yeujIIe/FSf2PLm2bc
        cCET+qfUIayvUPQpcPCxRw==
X-Google-Smtp-Source: AGHT+IHB4U15AtwXgr2q53vf2S1ML9wxd69t/SNeT1LuZvoF+Dhu/0yELrxhyRpTOhM2JqPRWD0blg==
X-Received: by 2002:a05:6871:5308:b0:1e9:e3be:434f with SMTP id hx8-20020a056871530800b001e9e3be434fmr9331659oac.55.1697442007209;
        Mon, 16 Oct 2023 00:40:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dt1-20020a0568705a8100b001e12bb81363sm1935742oab.35.2023.10.16.00.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:40:06 -0700 (PDT)
Received: (nullmailer pid 1750852 invoked by uid 1000);
        Mon, 16 Oct 2023 07:40:05 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     werneazc@gmail.com
Cc:     robh+dt@kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>,
        linux-kernel@vger.kernel.org, jic23@kernel.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de
In-Reply-To: <20231016070318.28355-1-andre.werner@systec-electronic.com>
References: <20231016070318.28355-1-andre.werner@systec-electronic.com>
Message-Id: <169744200549.1750835.3657501443373325472.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: ti,ads7038: Add
 description for ADS7038
Date:   Mon, 16 Oct 2023 02:40:05 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Oct 2023 09:02:04 +0200, werneazc@gmail.com wrote:
> From: Andre Werner <andre.werner@systec-electronic.com>
> 
> Add basic description for ADS7038 ADC devices.
> The devicetree adds the following device specific options:
> 
> - average-samples: Program device's programmable average filter.
> - crc-enabled: Enable the CRC check for SPI transfers. Sadly, this
>   option has currently no effect in the driver.
> - status-enabled: Enable the appending of the device's status on the
>   measure value transmission.
> - gpio-controller: Sadly function not implemented yet in the driver.
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> ---
> v3
> - Delete ADS7138 compatible and comments.
> - Add options for CRC, status and average samples as well as
>   gpio-controller.
> - Update example.
> - add regulator for digital IO voltage.
> ---
>  .../bindings/iio/adc/ti,ads7038.yaml          | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml: status-enabled: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml: crc-enabled: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231016070318.28355-1-andre.werner@systec-electronic.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

