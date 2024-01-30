Return-Path: <linux-kernel+bounces-45300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 586C5842E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE151F28622
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1EB7AE51;
	Tue, 30 Jan 2024 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blU4rVWv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BEA433A7;
	Tue, 30 Jan 2024 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647835; cv=none; b=JJerRHQs0ypMUY/nf85FaIeRRnGdDV8gUbF+8RfFAy6LssaTjXl9jOcufZfQGfsUZSfyHK0zZRAblIJJEtwWp0mQNE693/A7gqPqq4Py08wSExjWk4IN8IdhcnKM8yWxnn5Hpmu73PDaYtpSmzA5/lb1sFPItFVpscodg5JzNlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647835; c=relaxed/simple;
	bh=w9NLzrTM/ZNQdeUtz6mFY9vTDHy+fyJKBU197/0Hf7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4l49lJGmjK6+1curW4qbw/JghRqSrRt16Sh4fTSi4XS3gX9iiCoGcAPJbtBniqpBQ7y5IDkajOonjSU+m+6P1ryuNGu2WbmuRwMj8zvAo0DAZ38guo12aonHMNvSwWp8AK6QqlZTtdC4zmFNBOBx7S95qp3q7NRu+5PyfEUBG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blU4rVWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BD8C433C7;
	Tue, 30 Jan 2024 20:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706647835;
	bh=w9NLzrTM/ZNQdeUtz6mFY9vTDHy+fyJKBU197/0Hf7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=blU4rVWv41GeBB7mP7toDLtLIDYa9yqHoqttAImt2T8BIKIR1KUUXXRpmCKDwnKTu
	 qL+pTlhREufV1oR0c5VWYx6g9hYaoR/JDt2KE/4wiUybO+vGPJO7Ia9NyK37urhTJ+
	 fWpYqSo/5f6NfOL1ufbwlHm1qlTNhap3CX7KDRGk2e10hSG8BQNbfDNY0PxprP1msv
	 iZlmiUQ+C9K1kQDbNClIf1duSVQJgoz2nCjXwP2zDcpfiA5NtwCsxVrnmZe4PZn/wP
	 6r8Wxt3TOa2bObPNjCOBHNkMpqxzhDTT4km49rJ16xDqj0NfYMaS9zSq3QLEqEXI86
	 nRhviCaA4OaOA==
Date: Tue, 30 Jan 2024 14:50:32 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: monstr@monstr.eu,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	Rob Herring <robh+dt@kernel.org>, git@xilinx.com,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	michal.simek@xilinx.com
Subject: Re: [PATCH v3] dt-bindings: soc: xilinx: Add support for K26 rev2
 SOMs
Message-ID: <170664783217.2318601.17333972700012679424.robh@kernel.org>
References: <90e1a393154c3d87e8ee7dc9eef07fc937c1eaf7.1706019397.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90e1a393154c3d87e8ee7dc9eef07fc937c1eaf7.1706019397.git.michal.simek@amd.com>


On Tue, 23 Jan 2024 15:16:44 +0100, Michal Simek wrote:
> Revision 2 is SW compatible with revision 1 but it is necessary to reflect
> it in model and compatible properties which are parsed by user space.
> Rev 2 has improved a power on boot reset and MIO34 shutdown glich
> improvement done via an additional filter in the GreenPak chip.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v3:
> - use allOf contains structure to avoid random chars caused by
>   additionalItems: true
> 
> Changes in v2:
> - Support older combinations
> 
> I want to support all versions we created:
> All of them:
> -rev2, -rev1, -revB, -revA, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
> 
> rev1:
> -rev1, -revB, -revA, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
> 
> revB:
> -revB, -revA, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
> 
> revA:
> -revA, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
> 
> And also single one are permitted:
> -revB, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
> -rev1, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
> -rev2, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
> 
> I didn't find a way to pretty much all the time force that there must be
> both "xlnx,zynqmp-smk-k26", "xlnx,zynqmp" that's why there is only
> requested to have xlnx,zynqmp. If you find a way how to encode it please
> let me know.
> 
> ---
>  .../bindings/soc/xilinx/xilinx.yaml           | 36 +++++++++++++------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


