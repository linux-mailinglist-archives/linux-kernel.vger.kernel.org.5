Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8C27AEAB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjIZKrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjIZKrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:47:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7CFE5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:46:53 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c0c6d4d650so74646815ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695725213; x=1696330013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x7TAsjUHwem8Kp86Puq8NmvImkceCNDS6+Uq+a+QFMw=;
        b=pDXbG8Xm71Y2BsAvg1+lQWnpD/Ninx80RNMMq3WV7Vx+HxPX3hJ+iuz6LVW78Ze47u
         qBtJu33fxGKAAR2Q7Pu5W/6ZOCdZu91xH+n+shmkVVCa/2o3t5ump1xMR9bO1OH+KlO7
         wDjQIvFbuo5GDw9D9zox7jUv1lWBmWX77NlAh5OCBwCSjdX+/ltKAR17BTZ5tFASOee/
         Gm2IK/eNkTAeKXyqpufKsdWFBoZWie7cNQjVH5XgRV0ph6T0wlZE1krTQD4bXjPxmZ1K
         KWHoT62mH/KUlzOKFrJdcRBZxVOj5wrGzFDnfbpQaIxErrCBvAR9Y++ZlLsUevh60Rf9
         od1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725213; x=1696330013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7TAsjUHwem8Kp86Puq8NmvImkceCNDS6+Uq+a+QFMw=;
        b=a4Y2CfeBTU89qasDpoiOeIaBmTzyqg4w548mGfWt7NQnwoVRfXZ50k+q82aIA0fp0n
         QS1d7o6tcFbztdvGGIN0o+aFC8Qo67OE81VeyRX4WdsLd7l630keketaPl8rWIS4WiTm
         iaamXy9UsaVerJObcd0qXlUrSy0tDGEHRZogq9y/3tgsorzxU5s29slnZSvoigw6l7CV
         H9sdEZlTqAHCefSktmzxCRvNnPhF8+nfOHDjVT2o+NSBaiGc7wHqjC9/d69GyffFdwMR
         kcoXxBt6q8pXQQZFrzhczjZ1USmPf1efttyUk5JZgMCsUW3lxT/5Q6BsyfETi0Ul51dX
         NGmg==
X-Gm-Message-State: AOJu0YztL+6WDineuHUSWTSMA0+jQHivkokRNGg135E+W5og0K3tvuR/
        Au+2zHm0OvJmN35cGChJvAiUABdOkbZMoK5zGp06hA==
X-Google-Smtp-Source: AGHT+IE2rvdbnUFQ/+0OzMfhE1u2rLdf5Kj27JFCEBMZGP0PKvSZWXltI4Lakowyh92+G1HNfqGqfgwtGCwp6VLIkMU=
X-Received: by 2002:a17:902:b709:b0:1c5:e1b7:1c13 with SMTP id
 d9-20020a170902b70900b001c5e1b71c13mr8024462pls.3.1695725213126; Tue, 26 Sep
 2023 03:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230925220511.2026514-1-robh@kernel.org> <20230925220511.2026514-2-robh@kernel.org>
In-Reply-To: <20230925220511.2026514-2-robh@kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 26 Sep 2023 11:46:42 +0100
Message-ID: <CAJ9a7VgoeByBL2C+q1D6kxK2tNQj4QxjeE7q61CfRAQMvPM8XA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm,coresight-cti: Add missing
 additionalProperties on child nodes
To:     Rob Herring <robh@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sept 2023 at 23:05, Rob Herring <robh@kernel.org> wrote:
>
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
>
> Adding additionalProperties constraint on 'trig-conns' nodes results in
> warnings that 'cpu' and 'arm,cs-dev-assoc' are not allowed. These are
> already defined for the parent node, but need to be duplicated for the
> child node. Drop the free form description that the properties also apply
> to the child nodes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/arm/arm,coresight-cti.yaml       | 33 ++++++++++++++-----
>  1 file changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> index b9bdfc8969cd..2d5545a2b49c 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> @@ -93,9 +93,7 @@ properties:
>
>    cpu:
>      description:
> -      Handle to cpu this device is associated with. This must appear in the
> -      base cti node if compatible string arm,coresight-cti-v8-arch is used,
> -      or may appear in a trig-conns child node when appropriate.
> +      Handle to cpu this CTI is associated with.
>
>    power-domains:
>      maxItems: 1
> @@ -112,12 +110,12 @@ properties:
>      description:
>        defines a phandle reference to an associated CoreSight trace device.
>        When the associated trace device is enabled, then the respective CTI
> -      will be enabled. Use in a trig-conns node, or in CTI base node when
> -      compatible string arm,coresight-cti-v8-arch used. If the associated
> -      device has not been registered then the node name will be stored as
> -      the connection name for later resolution. If the associated device is
> -      not a CoreSight device or not registered then the node name will remain
> -      the connection name and automatic enabling will not occur.
> +      will be enabled. Use in CTI base node when compatible string
> +      arm,coresight-cti-v8-arch used. If the associated device has not been
> +      registered then the node name will be stored as the connection name for
> +      later resolution. If the associated device is not a CoreSight device or
> +      not registered then the node name will remain the connection name and
> +      automatic enabling will not occur.
>
>    # size cells and address cells required if trig-conns node present.
>    "#size-cells":
> @@ -129,6 +127,8 @@ properties:
>  patternProperties:
>    '^trig-conns@([0-9]+)$':
>      type: object
> +    additionalProperties: false
> +
>      description:
>        A trigger connections child node which describes the trigger signals
>        between this CTI and another hardware device. This device may be a CPU,
> @@ -140,6 +140,21 @@ patternProperties:
>        reg:
>          maxItems: 1
>
> +      cpu:
> +        description:
> +          Handle to cpu this trigger connection is associated with.
> +
> +      arm,cs-dev-assoc:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description:
> +          defines a phandle reference to an associated CoreSight trace device.
> +          When the associated trace device is enabled, then the respective CTI
> +          will be enabled. If the associated device has not been registered
> +          then the node name will be stored as the connection name for later
> +          resolution. If the associated device is not a CoreSight device or
> +          not registered then the node name will remain the connection name
> +          and automatic enabling will not occur.
> +
>        arm,trig-in-sigs:
>          $ref: /schemas/types.yaml#/definitions/uint32-array
>          minItems: 1
> --
> 2.40.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
