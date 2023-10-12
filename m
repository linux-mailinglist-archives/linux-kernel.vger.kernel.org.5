Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AA87C6713
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377705AbjJLHYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377807AbjJLHYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:24:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CBED6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:23:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849A3C433CA;
        Thu, 12 Oct 2023 07:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697095436;
        bh=hkw3GPAiv3QqU91HXOgB/Ith+aGeVqJdKk6L8jddygI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UcQnC693fcCYJEIdqIGncIc2MkU8dRRhRl8UGYKg8UXWSmEtvl5Igbu8rz8HaKJKK
         SLpSqhJCWU+hynzbei9nk0NTLqDvGpeEK7Dcn3Wz5MG8iI3fFPHAsd9WWjN6tYfFJH
         24arMGPIsnrNZFTIqH+osU2fmL5YQkW8WhGDG+bJjRUgJQEO9MSK4CLo5eRrLnfIh7
         OpEwVtdwCBfxPYZXRy188se1JThva4MmUjqTQPQeAcLriymhKVeRjvraDdV6gO7Y/T
         k3+D6I2eT1dzLhbvQHCfOtYeC/W2/cYHg7MKjO1g+pUfAEGEYkQXDdqUlg9+jR6bw4
         /x7nIz+GmvVJw==
Received: (nullmailer pid 3961449 invoked by uid 1000);
        Thu, 12 Oct 2023 07:23:54 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
In-Reply-To: <20231012065822.1007930-6-javierm@redhat.com>
References: <20231012065822.1007930-1-javierm@redhat.com>
 <20231012065822.1007930-6-javierm@redhat.com>
Message-Id: <169709543435.3961410.18389221947480753316.robh@kernel.org>
Subject: Re: [PATCH v2 5/6] dt-bindings: display: Split common Solomon
 properties in their own schema
Date:   Thu, 12 Oct 2023 02:23:54 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Oct 2023 08:58:14 +0200, Javier Martinez Canillas wrote:
> There are DT properties that can be shared across different Solomon OLED
> Display Controller families. Split them into a separate common schema to
> avoid these properties to be duplicated in different DT bindings schemas.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
> (no changes since v1)
> 
>  .../bindings/display/solomon,ssd-common.yaml  | 42 +++++++++++++++++++
>  .../bindings/display/solomon,ssd1307fb.yaml   | 28 +------------
>  MAINTAINERS                                   |  1 +
>  3 files changed, 44 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd-common.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/solomon,ssd-common.yaml:42:27: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231012065822.1007930-6-javierm@redhat.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

