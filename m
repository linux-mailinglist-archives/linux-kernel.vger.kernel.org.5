Return-Path: <linux-kernel+bounces-104612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A70C87D0F3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DC628312F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3665745027;
	Fri, 15 Mar 2024 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGMcC+HY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768641773D;
	Fri, 15 Mar 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519036; cv=none; b=cmcTgb531PEfHk/BOLlkHQunZEuMj6Bnfz+HZ1nspX9+6i9miasbznSj6TA8nVcCgRoSwIOyoNYb/hArzSoPyciKoXQnw5H8Db+zT8I11sJNOizQ+wCuVCTsVSar1jdciW6vYnnNAZRfdsODZgsettd909hzI+qf5bH0FAPf7Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519036; c=relaxed/simple;
	bh=9U8TXTtoTxC0CWMvJj6mLCU2BEQ3lky4kTdkGEen2HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8mRLMgAWLjJq6PUId76ExHWdWsSNVY6em4gzL1tcjbyqgddJA+HvjCgxUlP7y7IjXD+Im/2CB9PxCCoqRetgGPCOZkqWPyUblw/TnqYKs/kABlnqrioiO6UobZ3EM+GPTaYTrLg9p7zNUmj9bv3/iPzvxw1e48eQVSkA8tWrVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGMcC+HY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29D7C433F1;
	Fri, 15 Mar 2024 16:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710519035;
	bh=9U8TXTtoTxC0CWMvJj6mLCU2BEQ3lky4kTdkGEen2HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGMcC+HYb1uOVKox+WEZ98pZdZHbHb83ps+LonLIDwZXPh/jwX1E9oX4soa408r9o
	 uJ7yPPveUk+blXkaawLyoc4F6hEATjWwYzbhKXWkphLAmIz1HCeDV8e8YWo1Ce/3PM
	 65srT/wPcY+0DW+8i4ayuEwDEMNjt+oycgNlr630ziw7qC4MFFWzUZGcVpLcHwDMFK
	 epQM6s/r10uRTDzPGhdBf/XeQ2kJa+Ex7Lf74vhdFz70ZLDeAQH4u+Umt1npA/WkWy
	 tUWx2ub2ypbjZCBol+vqh8e7v0Idqrbspj6aCBcHdqnxXaYuD+NmWveNmzFyA0AVVF
	 GX7iK9+uZYIEA==
Date: Fri, 15 Mar 2024 10:10:32 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: samsung,s3c6410-keypad: convert to
 DT Schema
Message-ID: <171051903211.1425696.5675675890339089631.robh@kernel.org>
References: <20240312183001.714626-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312183001.714626-1-krzysztof.kozlowski@linaro.org>


On Tue, 12 Mar 2024 19:30:01 +0100, Krzysztof Kozlowski wrote:
> Convert Samsung SoC Keypad bindings to DT schema with changes:
> 1. Rename "linux,keypad-no-autorepeat" property to
>    "linux,input-no-autorepeat", because the latter was implemented in
>    the Linux driver.
> 2. Add clocks and clock-names, already used by DTS and the Linux driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../input/samsung,s3c6410-keypad.yaml         | 121 ++++++++++++++++++
>  .../bindings/input/samsung-keypad.txt         |  77 -----------
>  .../bindings/power/wakeup-source.txt          |   2 +-
>  3 files changed, 122 insertions(+), 78 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/samsung,s3c6410-keypad.yaml
>  delete mode 100644 Documentation/devicetree/bindings/input/samsung-keypad.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>


