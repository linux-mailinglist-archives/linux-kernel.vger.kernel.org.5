Return-Path: <linux-kernel+bounces-52941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A643F849EA8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47B9AB27426
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1366A2E63B;
	Mon,  5 Feb 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lucaweiss.eu header.i=@lucaweiss.eu header.b="i52nyp2o"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92292D604;
	Mon,  5 Feb 2024 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147880; cv=none; b=uINoCPMXGwybeEe6lpjWH+lEOJ5qn7TmMx4OSZa8rdfiWRFeCHZSJ4BUL47RhJUr8Z+cDvXGJ3weozmmM5SvwVWSV0yBdh3nH5ErsG33QvztZ9ZwOFl3S4Rcr0cStP9GZu/M5ioRSYQBuJYjTg40aet2/S3VGvNvDlkIYOrq4Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147880; c=relaxed/simple;
	bh=GRlnTe6Fw96ydt22/PNfp8vrwOitENJTGLEASD5fWMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCQEDPSBdV2RtGvXnO2INjoIWw6a0YWwMqBTt36FTKQu7+y/ORoP6SnV4tkqDeC3PbyYyj+zyTsw9Na5VjJ+Ha+YLsh80v1Hodi5i5MQAEcssAB4J1O6na1Tx3WiYCgJm1GH6LfLyu1OTrMTHUJrnQtyvB5WFwy2hFmknLSoys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lucaweiss.eu; spf=pass smtp.mailfrom=lucaweiss.eu; dkim=pass (1024-bit key) header.d=lucaweiss.eu header.i=@lucaweiss.eu header.b=i52nyp2o; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lucaweiss.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lucaweiss.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lucaweiss.eu; s=s1;
	t=1707147869; bh=GRlnTe6Fw96ydt22/PNfp8vrwOitENJTGLEASD5fWMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i52nyp2oPqNPHVd7Sh8KAgr+lK0MfGtOi7XIReN3aGrRXSJL1k95E7v2s3qKUTM1K
	 OP0TqvgV9BR0Zm2nbq+M1xfuCOkNraeOViH9HUBygsPl1vwqH9fISB06ACTeYMuvo/
	 uqhklh+5kgS3HHIBtMBpjKaTSf99cTykd/37p7yU=
From: Luca Weiss <luca@lucaweiss.eu>
To: Luca Weiss <luca.weiss@fairphone.com>,
 ~postmarketos/upstreaming@lists.sr.ht
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 phone-devel@vger.kernel.org, Lee Jones <lee@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, Stephen Boyd <sboyd@kernel.org>,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Rob Herring <robh@kernel.org>
Subject:
 Re: [PATCH 1/3] dt-bindings: mfd: qcom,spmi-pmic: Add pbs to SPMI device
 types
Date: Mon, 05 Feb 2024 16:44:27 +0100
Message-ID: <5017384.GXAFRqVoOG@z3ntu.xyz>
In-Reply-To: <170714066275.3239944.3114776132620071326.robh@kernel.org>
References:
 <20240205-pmi632-ppg-v1-0-e236c95a2099@fairphone.com>
 <20240205-pmi632-ppg-v1-1-e236c95a2099@fairphone.com>
 <170714066275.3239944.3114776132620071326.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 5. Februar 2024 14:46:45 CET Rob Herring wrote:
> On Mon, 05 Feb 2024 10:51:38 +0100, Luca Weiss wrote:
> > Add the PBS (Programmable Boot Sequencer) to the list of devices.
> > 
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> > 
> >  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/
> qcom,spmi-pmic.yaml: Error in referenced schema matching $id:
> http://devicetree.org/schemas/soc/qcom/qcom,pbs.yaml

These patches have been merged into linux-next recently, so should get into 
the next release.

> 
> doc reference errors (make refcheckdocs):
> 
> See
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240205-pmi
> 632-ppg-v1-1-e236c95a2099@fairphone.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your
> schema.





