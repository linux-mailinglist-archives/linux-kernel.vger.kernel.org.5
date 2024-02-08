Return-Path: <linux-kernel+bounces-58038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406E084E08A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08E1284214
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C90871B3D;
	Thu,  8 Feb 2024 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNzUK9Rv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB5171B30;
	Thu,  8 Feb 2024 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394683; cv=none; b=u4DP3tQLfc7lfwlqmSxTDGpmKflSP3ohPiYs0C5YI9L98RUQr/MsOK/OhIwauWwkzp7FhlbK7j88V4MnXb+yuaG9+IBmXDCAkRuf4OOkA1VicIKpI8aMTtTITFtEigXB6vN7jmPlF506fQnZ0Ar9AZ43Dc01+BEMXnNLMZX+8Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394683; c=relaxed/simple;
	bh=vlMeIXt8ifiopSXwgt29frglOiKdPC8TfKie08iAiqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7Vgn3zirufHME7p722Qp10Rk04xgenK11Guv/lf3AaI1i13AFN506dSnTTV5L8aEMQm3pl6n7cJOCJ0IiOv6FPr7KV+CwttfePKw5F59PO9OBVGLNKDhxhVo+XhCS563+eASf9V2ChAKJjDzbsl6tRKEJERp12ZLnxLYrMhOvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNzUK9Rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101F8C433F1;
	Thu,  8 Feb 2024 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707394682;
	bh=vlMeIXt8ifiopSXwgt29frglOiKdPC8TfKie08iAiqE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CNzUK9Rvo6u7WhIyz3ev1ouEu88GNkkm/9d+qW+tFOeEYCzEybDoZ5DY2dd6tV140
	 UxOfjdRHuz6mugw2o/rLMGUgCDzfOT1yVVvVzUKt8JU4pQyAk1IPcnwZzEyHTROXib
	 OzzaoH+3ohuMyk6ohmxVg7DrsHsZRIXI7yD943/MCMz+D5frXbCldRmhn39p21qeS/
	 SQve1rNBTrR8CBhQmXI0utqkNrpyVBrtlglupJlXPR8mQa7Zae1r1Nm1a5ZNyIdRb2
	 8b0jSuzvS90IwTYI7QAvW9gyRv5GSFZSSdqfTDVHathgViK/tPq1C9D/LzT41ln4Sc
	 bPajP1EKdZIkA==
Message-ID: <daec387f-987e-43c6-a9d4-caa4580d1113@kernel.org>
Date: Thu, 8 Feb 2024 14:17:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: ti: k3-am642-evm: add overlay for
 icssg1 2nd port
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Tero Kristo <kristo@kernel.org>, srk@ti.com, r-gunasekaran@ti.com
References: <20240205090546.4000446-1-danishanwar@ti.com>
 <20240205090546.4000446-4-danishanwar@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240205090546.4000446-4-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/02/2024 11:05, MD Danish Anwar wrote:
> The am642-evm doesn't allow to enable 2 x CPSW3g ports and 2 x ICSSG1 ports
> all together, so base k3-am642-evm.dts enables by default 2 x CPSW3g ports
> and 1 x ICSSG1 ports, but it is also possible to support 1 x CPSW3g ports
> and 2 x ICSSG1 ports configuration.
> 
> This patch adds overlay to support 1 x CPSW3g ports and 2 x ICSSG1 ports
> configuration:
> - Renames 'mdio-mux-1' node to 'mdio-mux@1'
> - Add label name 'mdio_mux_1' for 'mdio-mux@1' node so that the node
>   'mdio-mux@1' can be disabled in the overlay using the label name.
> - disable 2nd CPSW3g port
> - update CPSW3g pinmuxes to not use RGMII2
> - disable mdio-mux-1 and define mdio-mux-2 to route ICSSG1 MDIO to the
>   shared DP83869 PHY
> - add and enable ICSSG1 RGMII2 pinmuxes
> - enable ICSSG1 MII1 port

/icssg1/ICSSG1 in subject

> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

