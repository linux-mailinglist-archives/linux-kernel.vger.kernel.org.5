Return-Path: <linux-kernel+bounces-55452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5A684BCDD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7ED285072
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C4D134AA;
	Tue,  6 Feb 2024 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfFjdEgT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81F71118A;
	Tue,  6 Feb 2024 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707243822; cv=none; b=fryvwwGAtXWox5J3u6X5mn5gU5JSLvcgFe2SIXLGdbBmGFKrpJsjb8G9qWcpQpPt2/At4qKOAqgb8ND7agrxZMAkBd+0xF2zv5Fl82C4VLPc3TxCpkXUCK6AZXIRK9xyvywfAh9KcmuUwguyeffJZGsFkNIoxraa/9HwUZg7my8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707243822; c=relaxed/simple;
	bh=/8n9Kr9l4Sw1yum7U8xJubl081hOJbXFL+loiNN+f3Q=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=QXmUpQ+/dDXjTDJWuLhBbkkzZtiwFMmiURFB3wb5jvmXySmEMQvXeGqQVBqm4lziTW1BsGi3Jn14Yu0ndXfTz/j4czl8N/YJBNrzHf2fk2KewhA5VpRKzntnmMeHEjmGxrJZLqpGjQffuqgcu37tv1xeDbYhPctdBzxkd/gKJaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfFjdEgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA31C43390;
	Tue,  6 Feb 2024 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707243822;
	bh=/8n9Kr9l4Sw1yum7U8xJubl081hOJbXFL+loiNN+f3Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VfFjdEgT1J4LiAMho3HkP7m9Pl0ujNDEqh+XARqNwTjWgoFkGLzw9niS0kuxWT2aR
	 5t1qp7nA9TOKhz2pa70UxGbrM/Opyy3keYQ154lifEKkoXXVBBliZjHgSd5EBbCD6m
	 J/CTmiukWr8r30kUqrSIgsaarhtXS8tC/UElaHMoBiahKr8tronCYlQQXh5SRBy47V
	 36BwwYpcSk9e5bC1AHOCHFZW71VuTguU5+K/mqk5IOYqmg8NivgHErvf3qSLPPIFjc
	 ahxT3YBPQ74CF3fSP/eEYTw/ksbCN/ccfzG9kH2f7+80jViT8uczOoTqDZpFyyU+ON
	 wWF4aSp8taNig==
Date: Tue, 06 Feb 2024 18:23:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-kernel@vger.kernel.org, kernel@quicinc.com, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <53ba029fb1e3f66505b9f6487030e5d981e1621f.1707202761.git.quic_uchalich@quicinc.com>
References: <cover.1707202761.git.quic_uchalich@quicinc.com>
 <53ba029fb1e3f66505b9f6487030e5d981e1621f.1707202761.git.quic_uchalich@quicinc.com>
Message-Id: <170724381060.1723303.7103861511476056588.robh@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: msm: Add llcc Broadcast_AND
 register region


On Mon, 05 Feb 2024 23:15:52 -0800, Unnathi Chalicheemala wrote:
> The LLCC driver in SM8450, SM8550 and SM8650 have a new register
> space for Broadcast_AND region. This is used to check that all
> channels have bit set to "1", mainly in SCID activation/deactivation.
> 
> Previously we were mapping only the Broadcast_OR region assuming
> there was only one broadcast register region. Now we also map
> Broadcast_AND region.
> 
> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/cache/qcom,llcc.yaml  | 41 +++++++++++++++----
>  1 file changed, 33 insertions(+), 8 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cache/qcom,llcc.example.dtb: system-cache-controller@25000000: reg: [[0, 622854144, 0, 2097152], [0, 624951296, 0, 2097152], [0, 627048448, 0, 2097152], [0, 629145600, 0, 2097152], [0, 631242752, 0, 2097152]] is too short
	from schema $id: http://devicetree.org/schemas/cache/qcom,llcc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/53ba029fb1e3f66505b9f6487030e5d981e1621f.1707202761.git.quic_uchalich@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


