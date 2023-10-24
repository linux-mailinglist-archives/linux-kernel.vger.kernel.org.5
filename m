Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E0B7D5B22
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbjJXTJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbjJXTJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:09:51 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F6D93;
        Tue, 24 Oct 2023 12:09:49 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1e98e97c824so38995fac.1;
        Tue, 24 Oct 2023 12:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698174589; x=1698779389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jvsXPyYyeMVm041VffEFNntoLV0ZUl3p1HXdmdupPI=;
        b=tEuQ8ow0R5iLCCuWMCLNHOttTTuP5XsIOE+Eo/+kzX+1khd3l0G49n8gClj5vBtBeB
         6zPpnNv74RLiQe4cVf7peHvIRJIH52PDLvVSKCKGRjITTwN2QJH8jTidYvQu0tdI81p6
         iqKJyDtrEyJQzKXHamOFgVwKD6tgMQeNl2wqaGESL35XRO6TN4vD4EzijhrLu8n/D6yW
         I7sYusKQoo7cERsAh6I3zuqS2Omx4ZIUjTnPdl/7McYGCULVvYml9ZdIkpM8QLioLAqA
         b/uqYH8uHgq7n5Ur8ln6SY9T/wbJ12iHhJL85lQASK2l+A8B9SGJNh8NHftLaLvcrzXy
         fAwQ==
X-Gm-Message-State: AOJu0YzhMJUb3OL+u2VYOXIVTefufRjqCMzO6m508mfeX0SBwzkQb0zO
        eyQotm1rdWMnHGCYQz4YZg==
X-Google-Smtp-Source: AGHT+IGB0umxgLN8yJ5dntvW4mlolJq1yY5b6Ey4WB6BCRoJ27UsNEqz5sGBksHAUyCv67SEcH5+ZQ==
X-Received: by 2002:a05:6870:e38e:b0:1e9:e413:b9d with SMTP id x14-20020a056870e38e00b001e9e4130b9dmr8785833oad.2.1698174588665;
        Tue, 24 Oct 2023 12:09:48 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h36-20020a05687003e400b001b390c6e00bsm2253181oaf.56.2023.10.24.12.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 12:09:48 -0700 (PDT)
Received: (nullmailer pid 344849 invoked by uid 1000);
        Tue, 24 Oct 2023 19:09:47 -0000
Date:   Tue, 24 Oct 2023 14:09:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eliza Balas <eliza.balas@analog.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: misc: adi,axi-tdd: Add device-tree
 binding for TDD engine
Message-ID: <20231024190947.GA270524-robh@kernel.org>
References: <20231019125646.14236-1-eliza.balas@analog.com>
 <20231019125646.14236-2-eliza.balas@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019125646.14236-2-eliza.balas@analog.com>
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

On Thu, Oct 19, 2023 at 03:56:45PM +0300, Eliza Balas wrote:
> Add device tree documentation for the AXI TDD Core.
> The generic TDD controller is in essence a waveform generator
> capable of addressing RF applications which require Time Division
> Duplexing, as well as controlling other modules of general
> applications through its dedicated 32 channel outputs.
> 
> Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> ---
>  .../devicetree/bindings/misc/adi,axi-tdd.yaml | 65 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> new file mode 100644
> index 000000000000..4449d9abf46e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2023 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/adi,axi-tdd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AXI TDD Core
> +
> +maintainers:
> +  - Eliza Balas <eliza.balas@analog.com>
> +
> +description: |
> +  The TDD controller is a waveform generator capable of addressing RF
> +  applications which require Time Division Duplexing, as well as controlling
> +  other modules of general applications through its dedicated 32 channel
> +  outputs. It solves the synchronization issue when transmitting and receiving
> +  multiple frames of data through multiple buffers.
> +  The TDD IP core is part of the Analog Devices hdl reference designs and has
> +  the following features:
> +    * Up to 32 independent output channels
> +    * Start/stop time values per channel
> +    * Enable and polarity bit values per channel
> +    * 32 bit-max internal reference counter
> +    * Initial startup delay before waveform generation
> +    * Configurable frame length and number of frames per burst
> +    * 3 sources of synchronization: external, internal and software generated
> +  For more information see the wiki:
> +  https://wiki.analog.com/resources/fpga/docs/axi_tdd
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,axi-tdd

I don't understand where the version number went. Now my question is is 
there only one version of this (ever). It's not specific enough unless 
there's a version register that can be relied on.

This patch needs to answer any questions raised in previous versions. 
Assume the reviewers don't remember your patch and will ask the same 
questions again otherwise.

Rob
