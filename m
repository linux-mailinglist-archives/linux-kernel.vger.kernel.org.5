Return-Path: <linux-kernel+bounces-24066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1692A82B656
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADC8DB244B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB235812E;
	Thu, 11 Jan 2024 21:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkxn0tUo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B394058200;
	Thu, 11 Jan 2024 21:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5169C433F1;
	Thu, 11 Jan 2024 21:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705006897;
	bh=TpTMUcGngsj0a++aLiUb+VrDJ8lG4VgGRR5tkzcIA7U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=tkxn0tUo7fvebx5LCPrlZvYAWlVP5wedD3yKqA5Gc4zJifhqAYU6lhNWOA0cspXgG
	 ISXDPoothAx9TAOkgVVUYIC75GdKcH8/BB06tknIuAK1QRQIB5rbc3JgTd68WK7pX6
	 d2c9dBg5tYBi53WnRy+AY+w51lKCKafgSO26bvONoRbmChjIIIJp50JYGziUz31ea4
	 dfPLjUnACK1twGXr7fu6oUGylX5Cy6UlYI4YFt3guPBOCEc6QfViDlxhmcHyOE8zMg
	 JIExEQtmgR3Tjy6NgDSyLKtqu01CrkFQous+xQsXS3cD7+ZWoHdpDPhfBlzY0uPYdw
	 ZnI+Kh1uXGNWA==
Date: Thu, 11 Jan 2024 15:01:35 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: davem@davemloft.net, kuba@kernel.org, devicetree@vger.kernel.org, 
 robh+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk, 
 krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch, edumazet@google.com, 
 pabeni@redhat.com, linux-kernel@vger.kernel.org, afd@ti.com, 
 netdev@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
References: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
Message-Id: <170500673265.1110563.4649305262591407339.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: net: dp83826: add ti,cfg-dac-minus
 binding


On Thu, 11 Jan 2024 17:19:25 +0100, Catalin Popescu wrote:
> Add property ti,cfg-dac-minus to allow for voltage tuning
> of logical level -1 of the MLT-3 encoded data.
> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
>  Documentation/devicetree/bindings/net/ti,dp83822.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/ti,dp83822.yaml: ti,cfg-dac-minus: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240111161927.3689084-1-catalin.popescu@leica-geosystems.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


