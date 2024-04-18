Return-Path: <linux-kernel+bounces-150280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A2D8A9CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025781C24060
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6EA16F85C;
	Thu, 18 Apr 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fX15OLhh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6B816F841;
	Thu, 18 Apr 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449854; cv=none; b=TmYv4yguMm5wVIftwlWfiKGoo6yfJ7ENqIiVFQS7xgXIY1+LHfuEe3uS42OPaLyxhm9fia8sdMfVxZ6hE+c2csIH6K/uucePGQb2K1uWkZfov0HTRp0BtDplxRpFxd3wTnCul1mos6XRSdtX7NbFc9F2+ddSsqQk+EpXqRdNCe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449854; c=relaxed/simple;
	bh=g3bociu/TKxYjBLoEsR045a0G3zCwH9uH+OLKgq63aY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=qrISwqk8nM6wP9mTHFgDcRIbpR4tfh5RuA7+ffdk0aBV8l0Icin/GM05t5fIM/mT8/AfitbBP1/E28da3D+SmxISNm5xLoEXWYt2TfFFDNLo2ogLXjRPvQ1tAE0O+iXyg9V11AvpO1v/oOQT5vK4oTs6RqMNPbgpFstANMvubm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fX15OLhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EC4C4AF18;
	Thu, 18 Apr 2024 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713449853;
	bh=g3bociu/TKxYjBLoEsR045a0G3zCwH9uH+OLKgq63aY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fX15OLhhfVGSOCLKc7dIm4096I52YHgwNfdFqGAYQjhxNN63qVKdmqjw4nQI1OOeL
	 Q3tXx0IDqscekZYeRUmryyJpO5D2pm34mY24QVo8AhEjD1bcsBUlU3ZM0inq7YEwS6
	 uaZEtHve9eO4Hc/e2LEsE4K3utZC58IfdYU8j2MFTLLAh/hteP5qVKwP+cPt9xnsCp
	 gI1uOJo1IK3wUNRUW8k6h7c0/syPGFaGvg0KXH0wN8ieeiW/pt65tefskjbjRPABUC
	 Ss9Tw6mkZDrwLkZPvFYT5ug3jHqcwFSwZoz5PHdcvKqoiwsQtak3DAZZwx/N4I9/g5
	 f4zVVMFJYyLvQ==
Date: Thu, 18 Apr 2024 09:17:32 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, conor+dt@kernel.org, dianders@google.com, 
 hsinyi@google.com, krzysztof.kozlowski+dt@linaro.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 benjamin.tissoires@redhat.co, devicetree@vger.kernel.org, jikos@kernel.org
In-Reply-To: <20240418124815.31897-2-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240418124815.31897-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240418124815.31897-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Message-Id: <171344985111.1370788.4070620666918735217.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: input: i2c-hid: Introduce Ilitek
 ili2900


On Thu, 18 Apr 2024 20:48:14 +0800, lvzhaoxiong wrote:
> The ili2900 touch screen chip same as ilitek ili9882t controller
> has a reset gpio.
> 
> Signed-off-by: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
>  Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml:22:5: [error] duplication of key "const" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/input/ilitek,ili9882t.example.dts'
Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml:22:5: found duplicate key "const" with value "ilitek,ili2900" (original value: "ilitek,ili9882t")
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/input/ilitek,ili9882t.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml:22:5: found duplicate key "const" with value "ilitek,ili2900" (original value: "ilitek,ili9882t")
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240418124815.31897-2-lvzhaoxiong@huaqin.corp-partner.google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


