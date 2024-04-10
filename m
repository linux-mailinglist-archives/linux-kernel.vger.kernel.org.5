Return-Path: <linux-kernel+bounces-138978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD12F89FCE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632EB1F2293A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB89817B504;
	Wed, 10 Apr 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAuwiylE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA2EC3;
	Wed, 10 Apr 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766719; cv=none; b=TZufZRdLbuSKlJsEFXj1VLmav5UrHw8kvn5TcqvavabMuayjbe/Wv1sG7NuGZ9jXf79fZ6ol3TN1xvLKdfNlWc52MMYxsS56G4TduaiDTLVvzQOwj9VVCu8XFp+o1/3pddohvDO5ciaoyC+NwvuiA6h77NULQ2ADgpZkzhSJ10M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766719; c=relaxed/simple;
	bh=tctjbX6kDAVDANXC45071N6v0dWLW3bFAt2fUph0R2I=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=okWYRA5jf7k23ExHRNM2R/ubNam/FY985F+48E16dUkpFkhnDarw9TCed6zWklRdtETQU+U45njsDifbmNWHgXvfpQCzOOuUGXDhcWWknQtl9KDFs1fbfanqjbF1DUe7RjJAvT+sd+SYAYb1n0cXuwybGzy7fxIg8BArpxUTxFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAuwiylE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B071C433F1;
	Wed, 10 Apr 2024 16:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712766718;
	bh=tctjbX6kDAVDANXC45071N6v0dWLW3bFAt2fUph0R2I=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=LAuwiylENjGRN6DkqlK08ty90/uvmlcWhQSHikh0zj45XmRR9Nm25Crr9uiIv9iPn
	 daSEHPa+iECFnfL1Jo2F99wyYzwUAdrAT9mTPi+gonvX5JOerygs1mzYVeRMFxHmfW
	 HD1uXTks42xyGP3Tmp72nHGGoDuIqR0XRuEsUKBE8viMbsvEI6H4ErqvF76ZxofhES
	 nutc4uFBScbDC41HFJBkoXpf4gPyu60Fn2jzGAA8JVukEKZYiuqmFti3foS4hCrQwe
	 mPyfyJODfcfiYmpCYERijAK2sXUDpg/4A5akPdVuUkUmfdK2oCTtWp5KSO4XKwakMy
	 sX3HXYFHlFuCQ==
Date: Wed, 10 Apr 2024 11:31:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Hugues Fruchet <hugues.fruchet@foss.st.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-media@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
In-Reply-To: <20240410144222.714172-1-hugues.fruchet@foss.st.com>
References: <20240410144222.714172-1-hugues.fruchet@foss.st.com>
Message-Id: <171276671618.403884.13818480350194550959.robh@kernel.org>
Subject: Re: [PATCH] media: dt-bindings: media: add access-controllers to
 STM32MP25 video codecs


On Wed, 10 Apr 2024 16:42:22 +0200, Hugues Fruchet wrote:
> access-controllers is an optional property that allows a peripheral to
> refer to one or more domain access controller(s).
> 
> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
> ---
>  .../devicetree/bindings/media/st,stm32mp25-video-codec.yaml   | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml: access-controllers: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240410144222.714172-1-hugues.fruchet@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


