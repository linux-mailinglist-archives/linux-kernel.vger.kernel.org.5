Return-Path: <linux-kernel+bounces-27644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA36F82F39D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488A01F246B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC9E1CD16;
	Tue, 16 Jan 2024 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0czVSY7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514941CAAE;
	Tue, 16 Jan 2024 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428042; cv=none; b=e89ZQ9pzg3fPH0zb6ZzPNSIHbSdqhLYms6H4LU9KzSssKM3M7FhjhRpLOWA2nKPTWnkoY5xALTIBc+ze3/Hb8VE1tZXtzV8j0xYSbyPh03/xbCVC0lRG7SYXGGZf/5li0idV/NXXvWO54m/gIVvthGkF1G+IcWIitd50MkiP4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428042; c=relaxed/simple;
	bh=NEmbov86oEbrydeXDDCXgpjjK2og0SPcFaeap06DhNI=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=JvGkd+dcz3nMl0qolSOx1+DsP7jNlsCI9ssgYCjfE7eZHXA6aaxJ9AoI9ttXFPu+fexW9t0uPo9DET8qVNKl2oOPyg9m98n8J4LWJc274CkSYSIzX/mKgF60IjEd4b+DKzZwpkXHKKvGyoOwaFBi18e7bWXPfhxXXEz3X+hXKPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0czVSY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F26CC433C7;
	Tue, 16 Jan 2024 18:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705428041;
	bh=NEmbov86oEbrydeXDDCXgpjjK2og0SPcFaeap06DhNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0czVSY7sYagwdSeFeVe0S+Yp2+5n0OKq+ZMhiSiuBdoX8nJLLpSnQcuiIS4wUh33
	 ct1nBqldsfrL+a9oMZJNZu0vQMewgGaYwtV+kuFuaFdCyUJYM9vcTzriSE/YsapZh5
	 XXgkV5mZZFrTum9xg7bgfHBk11CgSNUojd2KR3SICJqN06ooDLjFeFcgrvS7IAZOzl
	 94jbFkI1OIVT2diIXI3ZRejJvf1i0VRn+12NJyVyRLsw7Th1z8urjCJWtwjCk1KJT4
	 b283Gw2bT1B3BjB2jYRkY6eg7BGUhUoQI5zG/SNA2pBNQLTKEytXGW9sawLezP+cXO
	 Qdkr6PD28NyxA==
Date: Tue, 16 Jan 2024 12:00:39 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] dt-bindings: soc: xilinx: Add support for K26 rev2
 SOMs
Message-ID: <20240116180039.GA169201-robh@kernel.org>
References: <3e86244a840a45c970289ba6d2fa700a74f5b259.1705051222.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e86244a840a45c970289ba6d2fa700a74f5b259.1705051222.git.michal.simek@amd.com>

On Fri, Jan 12, 2024 at 10:20:29AM +0100, Michal Simek wrote:
> Revision 2 is SW compatible with revision 1 but it is necessary to reflect
> it in model and compatible properties which are parsed by user space.
> Rev 2 has improved a power on boot reset and MIO34 shutdown glich
> improvement done via an additional filter in the GreenPak chip.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
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
>  .../bindings/soc/xilinx/xilinx.yaml           | 32 +++++++++++++------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
> index d4c0fe1fe435..39242efeec47 100644
> --- a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
> +++ b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
> @@ -117,20 +117,32 @@ properties:
>            - const: xlnx,zynqmp
>  
>        - description: Xilinx Kria SOMs
> +        additionalItems: true
> +        maxItems: 6
> +        minItems: 3
>          items:
> -          - const: xlnx,zynqmp-sm-k26-rev1
> -          - const: xlnx,zynqmp-sm-k26-revB
> -          - const: xlnx,zynqmp-sm-k26-revA
> -          - const: xlnx,zynqmp-sm-k26
> -          - const: xlnx,zynqmp
> +          - enum:
> +              - xlnx,zynqmp-sm-k26-rev2
> +              - xlnx,zynqmp-sm-k26-rev1
> +              - xlnx,zynqmp-sm-k26-revB
> +              - xlnx,zynqmp-sm-k26-revA
> +              - xlnx,zynqmp-sm-k26
> +        contains:
> +          const: xlnx,zynqmp

This allows:

xlnx,zynqmp-sm-k26-rev2, foo, xlnx,zynqmp, bar

You need the schema form of 'items' (no '-'). For multiple contains, you 
need 'allOf'. Like this:

items:
  enum: [ all of them ]
allOf:
  - contains:
      const: xlnx,zynqmp
  - contains:
      const: xlnx,zynqmp-sm-k26


This of course has no enforcement of the order. Just no sane way to do 
that in json-schema.

Rob

