Return-Path: <linux-kernel+bounces-128175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58065895737
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E67284FBA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6364E13443E;
	Tue,  2 Apr 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6rdKNN6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD812DDBE;
	Tue,  2 Apr 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068831; cv=none; b=hKCcGCq2hIYnfvhVldgGljnAuVxFSv2QE2kwZshRVX3GBj0+YFdcaQGu1vRSzzmfVKbiqNXyMOqTmiKIQoo0mtQ4PwlPj4V5HAfPwnVPSQcD+h/a0JzphYx0uYRjicruLFG25b+3vORHTaNDiZnXMdpOeYVtH9fc8qDDHKqemqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068831; c=relaxed/simple;
	bh=vCH3i6mpaPGNwndRqyWdjIKXgICEvYSzWBiAFVwd6zU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ja2NVetr7IUcB0XvdWamdia0kbPkNMqg4enyZpnaiBu3qxfL2N+re79ahhQw220ZZQJhln+cyQZiAgi/yemFF8371Q4nUtGhZe57Q2Mt1z3QZj8xqfZ8eZsf6odCylIyOS3XMyG/A9MBA673ULHIowE3v0l41YcyurNStyk7Vpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6rdKNN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22375C433F1;
	Tue,  2 Apr 2024 14:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712068830;
	bh=vCH3i6mpaPGNwndRqyWdjIKXgICEvYSzWBiAFVwd6zU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=h6rdKNN6Tc5buZum4JFj6Iq2RAGvfHrv5w8GkvVuCpPADghr3FCQwnBkSFeTZ7Mu+
	 V2F33GAKn8JIN4IeHEZM65xIQID96K1s2VB03llLVtgW0N1byK4HXdR8y2SSWw4daT
	 ufJbQ4r/zdVQPASRpWTpff4d1dRAdJz2SpEWeh61eXh/rdt+8LREHYCrLeuchqXjAo
	 X03miHt258ILApTVTU4hxyD5tpVq7A1svnNt1L0J1sdcD0wm2QLsmb5n0fRbxBiwOL
	 kqJq+VyuyZxCt7LjK+XOjUOFXrrKQDkfVvNzhxWk3/B+3HCQoQlNVF533QuqIpSZdF
	 eTapOfVJFh6/Q==
Date: Tue, 02 Apr 2024 09:40:29 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: amhetre@nvidia.com, conor+dt@kernel.org, maz@kernel.org, 
 mark.rutland@arm.com, treding@nvidia.com, devicetree@vger.kernel.org, 
 bbasu@nvidia.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, krzysztof.kozlowski@linaro.org
In-Reply-To: <20240402132626.24693-2-sumitg@nvidia.com>
References: <20240402132626.24693-1-sumitg@nvidia.com>
 <20240402132626.24693-2-sumitg@nvidia.com>
Message-Id: <171206882815.21282.13196636028288566805.robh@kernel.org>
Subject: Re: [Patch v2 1/2] dt-bindings: make sid and broadcast reg
 optional


On Tue, 02 Apr 2024 18:56:25 +0530, Sumit Gupta wrote:
> MC SID and Broadbast channel register access is restricted for Guest VM.
> Make both the regions as optional for SoC's from Tegra186 onwards.
> Tegra MC driver will skip access to the restricted registers from Guest
> if the respective regions are not present in the memory-controller node
> of Guest DT.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../memory-controllers/nvidia,tegra186-mc.yaml | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.example.dtb: memory-controller@2c00000: reg: [[0, 46137344, 0, 65536], [0, 46202880, 0, 65536], [0, 46268416, 0, 65536], [0, 46333952, 0, 65536], [0, 46399488, 0, 65536], [0, 46465024, 0, 65536]] is too long
	from schema $id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra186-mc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.example.dtb: memory-controller@2c00000: reg-names:0: 'ch0' was expected
	from schema $id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra186-mc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.example.dtb: memory-controller@2c00000: reg-names:1: 'ch1' was expected
	from schema $id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra186-mc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.example.dtb: memory-controller@2c00000: reg-names:2: 'ch2' was expected
	from schema $id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra186-mc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.example.dtb: memory-controller@2c00000: reg-names:3: 'ch3' was expected
	from schema $id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra186-mc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.example.dtb: memory-controller@2c00000: reg-names:4: 'sid' was expected
	from schema $id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra186-mc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.example.dtb: memory-controller@2c00000: reg-names:5: 'broadcast' was expected
	from schema $id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra186-mc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240402132626.24693-2-sumitg@nvidia.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


