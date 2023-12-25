Return-Path: <linux-kernel+bounces-10982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51C381DFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 11:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D04A1C21895
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72B73159C;
	Mon, 25 Dec 2023 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxIkb3Np"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FAF2E401;
	Mon, 25 Dec 2023 10:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A767C433C7;
	Mon, 25 Dec 2023 10:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703499238;
	bh=ULAMe7pR0t0GDel15i2o8dWuuuGE8dBVcHlEtjNwhl8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fxIkb3NprTvgufu9vQQ7qD69gecQ5ABn/FOEYJ4WwGNpnXHLlfAt3f7KhglNCpFvg
	 MVhd7kDd0Ya40wSObKj3Own8Vnihhl/MKn06rrC40Jb1CDC0ddjRpeGP0GSIIckIgl
	 /Q7v5CfjMVPggw7brfGf4ANLJAzqspYE8LvuLIISGfuL4V9EJiJEq4BrRdIjQkkwAb
	 08Kk+l8gA17aXM5tXlbSNOcCYePr7eqFOFJoeDlMPnuSF9t5pawQey2uJSjiQUmAGG
	 UkRJjSjAbx+ug5u59VSVAlId3/D7DLxW+XAqJ8BD1TKCXcNO4RuqnuFrxt7pghQjnT
	 vBQVJWmZZkgWg==
Received: (nullmailer pid 4090714 invoked by uid 1000);
	Mon, 25 Dec 2023 10:13:56 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Cc: robh+dt@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dianders@chromium.org, benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20231225092843.5993-2-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20231225092843.5993-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <20231225092843.5993-2-xiazhengqiao@huaqin.corp-partner.google.com>
Message-Id: <170349923649.4090676.6305436872535523606.robh@kernel.org>
Subject: Re: [v1 1/2] dt-bindings: HID: i2c-hid: elan: Introduce bindings
 for Ilitek ili2901
Date: Mon, 25 Dec 2023 04:13:56 -0600


On Mon, 25 Dec 2023 17:28:42 +0800, xiazhengqiao wrote:
> Because ilitek, ili2901 needs to use reset to pull down the time for 10ms,
> so we need to control the reset, use this drive control.
> 
> Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
> ---
>  Documentation/devicetree/bindings/input/elan,ekth6915.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/elan,ekth6915.example.dtb: touchscreen@10: compatible: ['elan,ekth6915'] is too short
	from schema $id: http://devicetree.org/schemas/input/elan,ekth6915.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231225092843.5993-2-xiazhengqiao@huaqin.corp-partner.google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


