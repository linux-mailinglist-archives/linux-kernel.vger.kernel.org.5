Return-Path: <linux-kernel+bounces-22814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC94F82A33E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB251C266C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482B4F61E;
	Wed, 10 Jan 2024 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c82lIG0a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253274F5FA;
	Wed, 10 Jan 2024 21:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06175C433C7;
	Wed, 10 Jan 2024 21:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704921931;
	bh=3C5WR76W5kbSoAjJb2xbYfw3mBaMSnsnkbKc1nq/il0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=c82lIG0ast6+R/k3mcOb81ehqGD5ghGGAUET00ZwgfXIoKt5DIbDRUsiW9YNIQba3
	 e74LXV+mJZBFqtcp/syKfcMHoy7P2ZJXOtGjs6jQ4AGfCCYJkVwGdukJkqWu/q1yg4
	 54Tov4w87pe+sXdJYHBnV470VTwznFf+aI2xUmQcJiaTwTdE7RumUNqSANJBYcfiAw
	 90759UGovYTB9FsZMb3fjaTP72qCPEd4e6b0dOJl3YxpKPOXZHU6j9XaifSVjbBbrM
	 AaIfWHeCdv96ejdZcz8GOD33LI2tvG97XukxgJfCePRQYbEoHuBLvhVgVXnEcyadDG
	 vbBFYvkHpkVfQ==
Received: (nullmailer pid 2648565 invoked by uid 1000);
	Wed, 10 Jan 2024 21:25:28 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Hennerich <michael.hennerich@analog.com>, devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Thierry Reding <thierry.reding@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-11-e42c6a986580@baylibre.com>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-11-e42c6a986580@baylibre.com>
Message-Id: <170492192827.2648172.5496531414858882853.robh@kernel.org>
Subject: Re: [PATCH 11/13] dt-bindings: iio: offload: add binding for
 PWM/DMA triggered buffer
Date: Wed, 10 Jan 2024 15:25:28 -0600


On Wed, 10 Jan 2024 13:49:52 -0600, David Lechner wrote:
> This adds a new binding for a PWM trigger and DMA data output connected
> to an SPI controller offload instance.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  .../adi,spi-offload-pwm-trigger-dma-buffer.yaml    | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/offload/adi,spi-offload-pwm-trigger-dma-buffer.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/spi/adi,axi-spi-engine.yaml
Documentation/devicetree/bindings/iio/offload/adi,spi-offload-pwm-trigger-dma-buffer.example.dts:22.22-32.15: Warning (spi_bus_reg): /example-0/spi/offloads: missing or empty reg property
Traceback (most recent call last):
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 966, in resolve_fragment
    document = document[part]
               ~~~~~~~~^^^^^^
TypeError: 'bool' object is not subscriptable

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/bin/dt-validate", line 8, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.11/dist-packages/dtschema/dtb_validate.py", line 144, in main
    sg.check_dtb(filename)
  File "/usr/local/lib/python3.11/dist-packages/dtschema/dtb_validate.py", line 89, in check_dtb
    self.check_subtree(dt, subtree, False, "/", "/", filename)
  File "/usr/local/lib/python3.11/dist-packages/dtschema/dtb_validate.py", line 82, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
  File "/usr/local/lib/python3.11/dist-packages/dtschema/dtb_validate.py", line 82, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
  File "/usr/local/lib/python3.11/dist-packages/dtschema/dtb_validate.py", line 82, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
  [Previous line repeated 1 more time]
  File "/usr/local/lib/python3.11/dist-packages/dtschema/dtb_validate.py", line 77, in check_subtree
    self.check_node(tree, subtree, disabled, nodename, fullname, filename)
  File "/usr/local/lib/python3.11/dist-packages/dtschema/dtb_validate.py", line 33, in check_node
    for error in self.validator.iter_errors(node, filter=match_schema_file):
  File "/usr/local/lib/python3.11/dist-packages/dtschema/validator.py", line 405, in iter_errors
    for error in self.DtValidator(sch,
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 288, in iter_errors
    for error in errors:
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/_validators.py", line 414, in if_
    yield from validator.descend(instance, then, schema_path="then")
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 305, in descend
    for error in self.evolve(schema=schema).iter_errors(instance):
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 288, in iter_errors
    for error in errors:
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/_validators.py", line 294, in ref
    scope, resolved = validator.resolver.resolve(ref)
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 898, in resolve
    return url, self._remote_cache(url)
                ^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 916, in resolve_from_url
    return self.resolve_fragment(document, fragment)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 968, in resolve_fragment
    raise exceptions.RefResolutionError(
jsonschema.exceptions.RefResolutionError: Unresolvable JSON pointer: '$defs/offload'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240109-axi-spi-engine-series-3-v1-11-e42c6a986580@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


