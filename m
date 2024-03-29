Return-Path: <linux-kernel+bounces-125447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F871892611
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78A71C21799
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430A513BC09;
	Fri, 29 Mar 2024 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmBqFGxo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB4238FAD;
	Fri, 29 Mar 2024 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711747774; cv=none; b=TL2TA1LFaspp6qm1DQd60KP3HmmP28tkHqyeZhJ6lZq4Y9x7z09hig6fkcRUVq85T3xIq3PExlmHxPU4tdVDpCp7E3uh4kwpDBMAh28E0H1zW4lxgyH9GclU9P/T4+fJHwP/ViFwwkXQxFVUPdJrnF6RD3bylzfXfXTTtqd957Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711747774; c=relaxed/simple;
	bh=nkA0bLoaZ4E5ao9E36dgctPmJar90Bj8J1lLT86GnUk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=XfoJpKaEokhKsJkLnjAWJgSsw6OuKjgmzPvdkNrXKoyy+nD1p3fDsn3smNRQR8Pral67m43YAglZgEf5g8BTBxmvgxJJsJkFIsQLXulv36f8SUunS14y/19EXWkg5S96397lgapEpcIyabDSdgpE/FvLBbB8Cvv/Ct/X8GuC3/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmBqFGxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C343EC433C7;
	Fri, 29 Mar 2024 21:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711747774;
	bh=nkA0bLoaZ4E5ao9E36dgctPmJar90Bj8J1lLT86GnUk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nmBqFGxo/uATRrQLiFcOxJwi0WH3fltVjJ3HCzunCZcfCxkW0sHSovRhmWTIRkDpu
	 QQj3vFq+uUeBFZIuqnDWdC98goxw3sTcmvkpBKy8WxVAIqLN37StYM1zZdAEMjiyMR
	 gYm4Y0lH5UMHtJ1P/lkL2ItCspVPSmoBRodTJYAQLzRwH1ZAkM+waMKOrdkCfM7xIn
	 luevGLcu0PUVVtNd9n05vtNp5wiKl4CDPAbd2RyF8wHt+BBx3w9iWL0k5S45ztSbLO
	 jsvWq05ijYR74RabI39mYCrQJCvXGBSFrbU0PVQXWp0hgC9D1Ufok4XmkeF1K5xXDe
	 NSoTQs8HBO86w==
Date: Fri, 29 Mar 2024 16:29:32 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: wefu@redhat.com
Cc: nuno.sa@analog.com, okan.sahin@analog.com, palmer@dabbelt.com, 
 conor@kernel.org, mike.looijmans@topic.nl, devicetree@vger.kernel.org, 
 jic23@kernel.org, marcelo.schmitt@analog.com, marius.cristea@microchip.com, 
 guoren@kernel.org, andriy.shevchenko@linux.intel.com, jszhang@kernel.org, 
 bigunclemax@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org, 
 linux-iio@vger.kernel.org, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, 
 marcus.folkesson@gmail.com, lars@metafoo.de, fr0st61te@gmail.com, 
 schnelle@linux.ibm.com
In-Reply-To: <20240329200241.4122000-4-wefu@redhat.com>
References: <20240329200241.4122000-1-wefu@redhat.com>
 <20240329200241.4122000-4-wefu@redhat.com>
Message-Id: <171174777168.1262622.1612528543919451612.robh@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: adc: Document XuanTie TH1520 ADC


On Sat, 30 Mar 2024 04:01:26 +0800, wefu@redhat.com wrote:
> From: Wei Fu <wefu@redhat.com>
> 
> Document devicetree bindings for the XuanTie TH1520 AP sub-system ADC.
> 
> Signed-off-by: Wei Fu <wefu@redhat.com>
> ---
>  .../bindings/iio/adc/thead,th1520.yaml        | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml:45:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/iio/adc/thead,th1520.example.dts'
Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml:45:1: found a tab character where an indentation space is expected
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/iio/adc/thead,th1520.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
/Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml:45:1: found a tab character where an indentation space is expected
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240329200241.4122000-4-wefu@redhat.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


