Return-Path: <linux-kernel+bounces-25169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFE182C8F9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A412845E2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4A118E03;
	Sat, 13 Jan 2024 01:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSHypRh9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9C018AF1;
	Sat, 13 Jan 2024 01:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE772C433C7;
	Sat, 13 Jan 2024 01:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705110906;
	bh=GkBYE0muoV9iImDlwTh/2HjyqMO1Yeic9Ipvx+EyJSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pSHypRh9cOxsCSMUXWjCHskAINRqbTXYy1sbUHtyNEhkc/J6uMauCh3wXd/nCjePr
	 yv+ESXPBn3phmwyqcNKfl3fHEG0s76V1EM4IPpG5uLdzwLiTCczbusQxdzLnQZtgR1
	 BWSSt3oKLa4DPl5mffsyyRWOAuLwm+2SfVgIfVG7mqOvIiJb1APxz9rfSMUkuP8KKH
	 N+CKoVQSti/vnaypgiEnu/GoN5oKyf2auhPunkL45R+FlV4kmKSwmMO+CjU5rRt39B
	 5XDsWkpSEkXmAMF4Pi/4uMoYl1BGxeOwjqG8wZTReAyEv7v1Pg1ASmYbkPfOJpEvsc
	 GfmUbaRhbRdww==
Date: Fri, 12 Jan 2024 19:55:03 -0600
From: Rob Herring <robh@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: naresh.solanki@9elements.com, joel@jms.id.au,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	robh+dt@kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-hwmon@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	BMC-SW@aspeedtech.com, jdelvare@suse.com, andrew@aj.id.au,
	linux@roeck-us.net, corbet@lwn.net, linux-pwm@vger.kernel.org,
	patrick@stwcx.xyz, devicetree@vger.kernel.org,
	p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v12 1/3] dt-bindings: hwmon: fan: Add fan binding to
 schema
Message-ID: <170511090309.3829370.10710486836364106581.robh@kernel.org>
References: <20240108074348.735014-1-billy_tsai@aspeedtech.com>
 <20240108074348.735014-2-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108074348.735014-2-billy_tsai@aspeedtech.com>


On Mon, 08 Jan 2024 15:43:46 +0800, Billy Tsai wrote:
> From: Naresh Solanki <naresh.solanki@9elements.com>
> 
> Add common fan properties bindings to a schema.
> 
> Bindings for fan controllers can reference the common schema for the
> fan
> 
> child nodes:
> 
>   patternProperties:
>     "^fan@[0-2]":
>       type: object
>       $ref: fan-common.yaml#
>       unevaluatedProperties: false
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../devicetree/bindings/hwmon/fan-common.yaml | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


