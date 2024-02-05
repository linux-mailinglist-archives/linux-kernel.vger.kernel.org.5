Return-Path: <linux-kernel+bounces-52742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C36F849C25
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF28F1C23F10
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA4A20DC8;
	Mon,  5 Feb 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4pNDrHt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E6220DCB;
	Mon,  5 Feb 2024 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140808; cv=none; b=oivV638KXHGTKkFfB0DtQ8gm0IzfTyrvouXAmxGZ3hZnOxnak1CKYoar2XT/Va5QTmli+DOueQ5oTiHUdOrEfTvisDwySsWl20wdnFKGhGNNbGOly54L7hpTTeU+9qj0dkbdzM00H06iIx6IzzsLzJ6tEKIY6RiT5+185xwp8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140808; c=relaxed/simple;
	bh=xZKAosXWiPWEA9EOczuud1mbvfI3IhqZUQtdG3FwbPY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=I4PKTl9Uw0O5Ruu9OScBiw/o+aEybAXxDxsh8qgGSIf82IRtpzc3h00Gy9+2YZMmhDNB7II4wZPZn3aI7yBeqah4J/7ctu8P8BpuVLRFSIZNbaK2NaOFxQh3NvOIlTyXgF86MiuqSiAPgLUaWai03FhMbZ4sSNhhPAGbHZsxK0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4pNDrHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6718CC433F1;
	Mon,  5 Feb 2024 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707140808;
	bh=xZKAosXWiPWEA9EOczuud1mbvfI3IhqZUQtdG3FwbPY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=U4pNDrHtO8FE/d65h3/afExT+LeMzX0lLiXPDwlRWsULdbWsEJMKuYC2CUjnDkzDa
	 2mIDy6I0Hahhaad8i1jv6qDcPyOJCI9rpGEFZbLHXzVktJvsKKjyRxiEY6A5B5ZMjP
	 PQGp4kgct03hXZw5iQR00daLjN278ggEOEINaRXg24BzewbAJifiq0cfeO08pgy9f3
	 o60Z8gHe/6mChhMeh+5sthTmCAAdSHrlsg40caGeEj6u7VSqoB8Df5r73nkRSxiEcm
	 74Qk8oQlQTmqB3lMvXdtjk+ggGwAiqeh56VzJvO4U6xadSH9820+tz0Hu5yynxl8zP
	 qVexeZv5WQjjg==
Date: Mon, 05 Feb 2024 13:46:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 phone-devel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, Stephen Boyd <sboyd@kernel.org>, 
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>
In-Reply-To: <20240205-pmi632-ppg-v1-1-e236c95a2099@fairphone.com>
References: <20240205-pmi632-ppg-v1-0-e236c95a2099@fairphone.com>
 <20240205-pmi632-ppg-v1-1-e236c95a2099@fairphone.com>
Message-Id: <170714066275.3239944.3114776132620071326.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: mfd: qcom,spmi-pmic: Add pbs to SPMI
 device types


On Mon, 05 Feb 2024 10:51:38 +0100, Luca Weiss wrote:
> Add the PBS (Programmable Boot Sequencer) to the list of devices.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/soc/qcom/qcom,pbs.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240205-pmi632-ppg-v1-1-e236c95a2099@fairphone.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


