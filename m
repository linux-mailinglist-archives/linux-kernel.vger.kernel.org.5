Return-Path: <linux-kernel+bounces-1201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059BF814B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68630B2388E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A3836AE9;
	Fri, 15 Dec 2023 15:18:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C4336B10;
	Fri, 15 Dec 2023 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59052ab970eso805190eaf.1;
        Fri, 15 Dec 2023 07:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702653523; x=1703258323;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wx6tE9pQ+EepUECdpeIr7K3ALwmL7SjqzWxTPqRLfZI=;
        b=VuhtT1m/FkmCKwUiVgZXeznSppjTKnqUbLYmYYCTv4ELhqWD7EXORvbxeRppO31e8d
         vKEr2f6/BOryRAh0yrv7g/K46ENBxgBkbCFX5TP/u965lY61ygQDFTRudzI4YBzZhU95
         iLEenH7wzzXPsHA+QhNcqguUjhPvLjfrqfL9rVcUvlKc07Dps6xn2R6GvblQsMeGwdV+
         Tkhew3x5HqxdSo3kmgzxdrOlDCTTtMJBWOamMISZzPvovfRCLnOO83Px1M8fpoUC4GQT
         f0UmJdxWM7ZhRRcKSaCP0Lwu7F3GgFkstXPc9ZDtZS+oYTgI/BW5iyEPiZ269YAitU+q
         v+aw==
X-Gm-Message-State: AOJu0YxA8loqqga0xFwQyGvg0iOcMD8GJW5IOUEJ/Peqg9N4x50x9JIO
	4qif7m6c1BVnjVzHfckZ5g==
X-Google-Smtp-Source: AGHT+IHjFeotZx/0jN0abAYahbn+a/d+puSMjYHpsS0vGkhglRT7juzY/+tJNJarXEhiwoEGbj3qJw==
X-Received: by 2002:a05:6870:ec8b:b0:203:5ba2:895c with SMTP id eo11-20020a056870ec8b00b002035ba2895cmr891540oab.35.1702653522944;
        Fri, 15 Dec 2023 07:18:42 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id lt14-20020a05687142ce00b00203297a24d7sm1393415oab.47.2023.12.15.07.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:18:42 -0800 (PST)
Received: (nullmailer pid 3935630 invoked by uid 1000);
	Fri, 15 Dec 2023 15:18:40 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, ChiaEn Wu <chiaen_wu@richtek.com>, andy@kernel.org, linus.walleij@linaro.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Walle <michael@walle.cc>, Andy Shevchenko <andy.shevchenko@gmail.com>, devicetree@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>, brgl@bgdev.pl, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Arnd Bergmann <arnd@arndb.de>, =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, Haibo Chen <haibo.chen@nxp.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>
In-Reply-To: <20231215133512.28735-1-mitrutzceclan@gmail.com>
References: <20231215133512.28735-1-mitrutzceclan@gmail.com>
Message-Id: <170265352089.3935533.15346706462448721074.robh@kernel.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: adc: add AD7173
Date: Fri, 15 Dec 2023 09:18:40 -0600


On Fri, 15 Dec 2023 15:34:57 +0200, Dumitru Ceclan wrote:
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel applications
> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
> primarily for measurement of signals close to DC but also delivers
> outstanding performance with input bandwidths out to ~10kHz.
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---
> V8->v9
>  - Add gpio-controller and "#gpio-cells" properties
>  - Add missing avdd2 and iovdd supplies
>  - Add string type to reference-select
> V7->V8
>  - include missing fix from V6
> V6->V7 <no changes>
> V5->V6
>  - Moved global required property to proper placement
> V4 -> V5
>  - Use string enum instead of integers for "adi,reference-select"
>  - Fix conditional checking in regards to compatible
> V3 -> V4
>  - include supply attributes
>  - add channel attribute for selecting conversion reference
> V2 -> V3
>  - remove redundant descriptions
>  - use referenced 'bipolar' property
>  - remove newlines from example
> V1 -> V2 <no changes>
> 
>  .../bindings/iio/adc/adi,ad7173.yaml          | 184 ++++++++++++++++++
>  1 file changed, 184 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml: patternProperties:^channel@[0-9a-f]$:properties:adi,reference-select:type: 'string' is not one of ['boolean', 'object']
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml: patternProperties:^channel@[0-9a-f]$:properties:adi,reference-select:type: 'boolean' was expected
	hint: A vendor boolean property can use "type: boolean"
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7173.example.dtb: adc@0: '#gpio-cells' is a dependency of 'gpio-controller'
	from schema $id: http://devicetree.org/schemas/gpio/gpio.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231215133512.28735-1-mitrutzceclan@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


