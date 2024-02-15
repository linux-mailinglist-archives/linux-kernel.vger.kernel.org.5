Return-Path: <linux-kernel+bounces-67144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3948566F9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81D91C209DE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329F3132C07;
	Thu, 15 Feb 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtvLved+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F2E1EEE7;
	Thu, 15 Feb 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010000; cv=none; b=XvaBSveT2cA8l3pWaCWp6FMTkMtPV/41Up4O+AmPX0Vfr+Q6PXNk9apz0v1O1hy4zivE+qhk6j6nAWyap5rk8sdAUfjk3Sr9B+c4usBRiuGzswMpN1Rq8EYOW/FaTVGF9voq8e6BT0VAg5gpEoDfa7Chxb2rTJjK67VIGzjogSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010000; c=relaxed/simple;
	bh=yPtGushKE1HruuEyLpEa6VC/zl5SpKlQQqg0Lb6Wd8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sqz6Ue1J8L3FzlfyybZU1qxChR2BZKFef/rFR0r9FHRJu7rplQySf8wqona7ue8HTyVmD9SSoIiKG/2aRtfJx+Ky8lCK+6SWMa9C8T396qTM42zoOoh1U0CEXja4I3ymOBsMfbSxT4LrDxi4jydEI3sNifak+svjZLu5qrFw9q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtvLved+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2E3C433F1;
	Thu, 15 Feb 2024 15:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708010000;
	bh=yPtGushKE1HruuEyLpEa6VC/zl5SpKlQQqg0Lb6Wd8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UtvLved+d01mkGf7xzEd9srUoOIy5JPOhruhV3dovutNXl52piRGfwR+Dj3olx5HI
	 PaPqIuXQr7CYX8nvZhAiG+kSU5oLJcnrKFeTgpIGqZvrSstJFRt/Zn1Pwq00NSdnZZ
	 MC/WL/7RHLEMsKW8odBbN0RFehhP8/6ckqjNL88MWBs9tF3BB1nf/hOiIMJBfASZX5
	 REmnJG1LXUyhB1ChaEbn/jVblNpcDpWKDcc25p85HDSbb2KaDmLz8kZ4NmIP+5IH7I
	 h4zAWbb8/xa1/+gxwfzYYWfVWrOSNoQ5u8Mz8QBZ0OkZvtNVW94T9AYmAT6VZXLiRe
	 PW3uy4Wq9m/Vg==
Date: Thu, 15 Feb 2024 09:13:16 -0600
From: Rob Herring <robh@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: sophgo: Add top misc
 controller of CV18XX/SG200X series SoC
Message-ID: <20240215151316.GA89268-robh@kernel.org>
References: <PH7PR20MB4962F822A64CB127911978AABB4E2@PH7PR20MB4962.namprd20.prod.outlook.com>
 <PH7PR20MB4962FFFB586489154B1403D6BB4E2@PH7PR20MB4962.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR20MB4962FFFB586489154B1403D6BB4E2@PH7PR20MB4962.namprd20.prod.outlook.com>

On Wed, Feb 14, 2024 at 02:33:14PM +0800, Inochi Amaoto wrote:
> CV18XX/SG200X series SoCs have a special top misc system controller,
> which provides register access for several devices. In addition to
> register access, this system controller also contains some subdevices
> (such as dmamux).
> 
> Add bindings for top misc controller of CV18XX/SG200X series SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
> new file mode 100644
> index 000000000000..619237532801
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,cv1800-top-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo CV1800/SG2000 SoC top system controller
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@outlook.com>
> +
> +description:
> +  The Sophgo CV1800/SG2000 SoC top misc system controller provides
> +  register access to configure related modules.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: sophgo,cv1800-top-syscon
> +      - const: syscon
> +      - const: simple-mfd

You have to define child nodes to be a simple-mfd.

You could drop it, but I now suspect your binding is incomplete.

Rob

