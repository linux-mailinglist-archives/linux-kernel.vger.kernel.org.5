Return-Path: <linux-kernel+bounces-167497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E218BAA71
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C47287398
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C50150993;
	Fri,  3 May 2024 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7CECoV2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9028E14F9FE;
	Fri,  3 May 2024 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730487; cv=none; b=QC9sXHmSiankQVuqNFhUhkm+r95oNgyy4D/Q2Nu6xVp473cCdJhinB+vb2tfuY502PrwVchPcnkbyUL+Z0zvIOsDEObZHEIT4gq3bmtsmi6eEXvnxvrBPf/0wUHaYMHu+OY8dCqzB/oxWiIu+guKVMGBx5LCTIp+R1xH9HPxdm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730487; c=relaxed/simple;
	bh=Z81kJ5Jzse+D1tt/hKahWdZHLWz3jrL1TFiptgq6cIE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uCEbKG0bd1VBtnDleW1izuccVjMDS2kKTSrBkpwwiPB4P65zotHI5DGfAXivoIwHNecIa0KfNngEhn+plYaIl2Nyjl4ARqqLNQZFLnVWiFOI7I6X1WW1q/NggIj4cwHxRhETnChsoV+4tadir8IAv1j77aRyebKwrVWEusRBzLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7CECoV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E19C4AF14;
	Fri,  3 May 2024 10:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714730487;
	bh=Z81kJ5Jzse+D1tt/hKahWdZHLWz3jrL1TFiptgq6cIE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=h7CECoV2zrBhycyFBBAhOXnFnpoEfarqglCNzR7GGa3PNe1gRF0kDuDQErO1Ajvy6
	 8TFeGl2KayFG6TTYWdlT5GMS19wpQgS+hXmHk5DUeEH6nHjsiLA2N7gU+297+e6FJ1
	 QrbvrMZVYv+4fi9KdUKHoB3W7WbiKdlAByb5lvgC935LJucFVRkUeqZpkYOMPiDO8D
	 EEUd3kRKLaF0WcZ7qqy3GKhBT9k52HxcEdwW004rPZW4BA6zUkYstpWtk6E9ADWCnc
	 BB30uzCGrgWrH6fne7nrKbvTnHd13e6TeDYEdUoPA7Y+MvWQ/bAN227MFV4RWHDV6z
	 oi7Jj925Tr9Eg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240503072116.12430-1-krzysztof.kozlowski@linaro.org>
References: <20240503072116.12430-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: Use full path to other
 schemas
Message-Id: <171473048435.1337417.17257640057136086841.b4-ty@kernel.org>
Date: Fri, 03 May 2024 11:01:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Fri, 03 May 2024 09:21:16 +0200, Krzysztof Kozlowski wrote:
> When referencing other schema, it is preferred to use an absolute path
> (/schemas/....), which allows also an seamless move of particular schema
> out of Linux kernel to dtschema.
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: Use full path to other schemas
      commit: 564277ef60b5f5ec1753489ad69f4583db57e6f0

--
Lee Jones [李琼斯]


