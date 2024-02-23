Return-Path: <linux-kernel+bounces-78425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79778861350
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3170B282F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ACF7FBC8;
	Fri, 23 Feb 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBbq6jL2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FAA7F460;
	Fri, 23 Feb 2024 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696287; cv=none; b=LX07KT4yN5h4CqGzI4JwFqE1v8w71QJyT4MCda3qMQQ0Ey9w1Jcxv9u2z62X1IvVEoHBYMyDi5TJNe+HwcHYnv3RLRBcMYlUa4Vw9EEaNtlm2Bz9AspSfE2phZyZuoSCVIdtRnJuMQlf0Itn/AHr0Fcrrzi2Brab8q1hBwFEiKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696287; c=relaxed/simple;
	bh=mhwjRRk4xV74kVMVwbQeUgkmSwWD2N6U/AIZ0aFPLoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9gafRCyCsxrxod4DxtLKIpftcWzgPdKAnl9h263NNd45J2pvdtOlL8QEVEPRhdGFCdVIVz3Msxd1rzFaMofWwo3XfcUkuczksbrNYTwjY+/wCKtE9KDiUsjnQ8+VbvswSpRRVCE01XvltOFuVdXTL9h9g7k4X7Yv2xxQadPEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBbq6jL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936E7C433F1;
	Fri, 23 Feb 2024 13:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708696286;
	bh=mhwjRRk4xV74kVMVwbQeUgkmSwWD2N6U/AIZ0aFPLoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBbq6jL2OsqWVIKa7CksYk2uhXPZGdHxBn/0ltvJIlaVANWeQ2zCwKbKhDY+seSri
	 18pkaS/Qor++1WTn4g8FD3gO6Hn+QwWZtpIK34Yvi5cxrBdSdF45A/ga6KY3KfjI+P
	 EiZY93ZbjnStqdyyWjZ60UDQweHJaptMMzFjNPsaGV/NipHSJwnh1xrrFRNqbA1QYk
	 oW/jyTVht1JyFIjC4Iqua6wS80DVXepnZ0b/ABzfSn6oEmSOjxt5MrSbhPHwV900+9
	 Rlxau8L98D/kxv/Hk+D/JvpxKWS46zSgBkTiFqzr/unwNk6nvjnfQ5TfWa1OBg53V7
	 5VGxlrPbIlg1g==
Date: Fri, 23 Feb 2024 06:51:24 -0700
From: Rob Herring <robh@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux-kernel@vger.kernel.org, naresh.solanki@9elements.com,
	BMC-SW@aspeedtech.com, jdelvare@suse.com, conor+dt@kernel.org,
	linux-doc@vger.kernel.org, joel@jms.id.au,
	linux-aspeed@lists.ozlabs.org, patrick@stwcx.xyz,
	andrew@codeconstruct.com.au, u.kleine-koenig@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net,
	robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
	linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v14 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
Message-ID: <170869628286.1766501.17404664389550900332.robh@kernel.org>
References: <20240221104025.1306227-1-billy_tsai@aspeedtech.com>
 <20240221104025.1306227-3-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221104025.1306227-3-billy_tsai@aspeedtech.com>


On Wed, 21 Feb 2024 18:40:24 +0800, Billy Tsai wrote:
> Document the compatible for aspeed,ast2600-pwm-tach device, which can
> support up to 16 PWM outputs and 16 fan tach input.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


