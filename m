Return-Path: <linux-kernel+bounces-36406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A5983A034
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDA829555D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D0BBE56;
	Wed, 24 Jan 2024 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irHrrnqg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8005D5C85;
	Wed, 24 Jan 2024 03:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706067552; cv=none; b=cl5zwWDw01yCTcbb85kujqHOh1Ui9nIUyuUmKoQolhZuIXBLAH6Qi5tvCpclKIWCMx2t47c/YzCaeTXxfUb+4Qm4jQAXTyyLqgAef3KsV+hHWGFvZNUkTaBah+Ger3vuKntQMLXyZFDVEWc7ZTcYCmylVigjQdFdeImcIMPwSi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706067552; c=relaxed/simple;
	bh=EiNpBlsXQxLI71J8l/SQIe3/0Pl/TQODgCeJHXVBjxs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ePsucjOIVl3Wf5RkFEPdbFvEhj65uZoTHrKM4FtN0dp52AAqeB6LBDylcCyyzD90P3FDY+2R2qk2uwSxe7KIV1Dv3zU3y8W9SxJtblG9j8sbtEf5i/7CxDvpLzFHbbm7VqrSWzoENMH1JRKBg57+ouCUvphbRlKFZjMUT2903YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irHrrnqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4870C433C7;
	Wed, 24 Jan 2024 03:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706067552;
	bh=EiNpBlsXQxLI71J8l/SQIe3/0Pl/TQODgCeJHXVBjxs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=irHrrnqg3BQtXoLmgP8Km1BigOlNesjmyl6gOB7hni2GK6OydJB15M0cpcNwR5ZNK
	 eba8KgwTJ0JZS0DjShpE7FgHtwO3U0KxIod1gAmwoBIMkgMmgMUzEldM9WnvuDsOQ0
	 IW7+rXUbfoQzAhY1b6e1pjftAQqNKEl0arcpcz+1XxWFLaMDVtOaL7E1zYydrNqKjo
	 NX/0uvGKEwCOPzhBZ4iIOLsgJsMGbKqOVJyQ+0xjbmwzQWyhEJTJOtkfcxFbJT0tR4
	 F20g4AFqW3eqs9WqrqtqYWTDgXayVkI3JHIM8jpoHMceRl273+JGwS7YFO8weQqmSE
	 LFrTQefHjyRJA==
Date: Tue, 23 Jan 2024 21:39:10 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: devicetree@vger.kernel.org, andersson@kernel.org, 
 linus.walleij@linaro.org, linux-kernel@vger.kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org, 
 robh+dt@kernel.org, kernel@quicinc.com, conor+dt@kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org
In-Reply-To: <20240124023305.15755-3-quic_tengfan@quicinc.com>
References: <20240124023305.15755-1-quic_tengfan@quicinc.com>
 <20240124023305.15755-3-quic_tengfan@quicinc.com>
Message-Id: <170606754969.2856906.5067146308427582194.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: qcom: consolidate functions


On Wed, 24 Jan 2024 10:33:05 +0800, Tengfei Fan wrote:
> Functions are consolidated in SM4450 tlmm driver, also consolidate these
> functions in SM4450 tlmm binding file.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  .../bindings/pinctrl/qcom,sm4450-tlmm.yaml    | 51 +++++++------------
>  1 file changed, 17 insertions(+), 34 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml:83:60: [warning] too many spaces after comma (commas)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240124023305.15755-3-quic_tengfan@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


