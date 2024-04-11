Return-Path: <linux-kernel+bounces-141323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984508A1D47
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6991BB2C363
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B9D17CBF1;
	Thu, 11 Apr 2024 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO5LNKIz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF13E462;
	Thu, 11 Apr 2024 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853072; cv=none; b=ZE1xP+RTlyJHxWzaM2Cen4CCZ0NtVrMHdJZ6fkAqm/gNo60w5t37c1Lzmn66cz/mkC71j8qEKCx+C74Gl+GgI8T5Zt88OcOgGBa6ea3XPTgMkG3k85D6iesht2/V9acELoY7ZLDivB4d72OKbPiLDODMMI+6wEXVOxDPrfTXI9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853072; c=relaxed/simple;
	bh=d0dfFBnNTYgGXuohXJQBT4zJhFADAPc7jBuCcAGNF1A=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WNqMgzgii0j21Y+mujFAYVeCogVYdsPhV4Kv4l+e5xFD1GqXX1DtnyjgtCHUQ3NyWkjrMYbYwlhuB302T0vTMgsiXod9mWWXqryeVNtuz7CEBo/YvNCosn6qLwVY28sSe2ySeUPFV9lPYrtgTJIPhhhEOoDBITMIFSub0tRH044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eO5LNKIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D971C072AA;
	Thu, 11 Apr 2024 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712853071;
	bh=d0dfFBnNTYgGXuohXJQBT4zJhFADAPc7jBuCcAGNF1A=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=eO5LNKIzDSjx1TeGFy4qsleB6DGACPeBYuVvC637DlD1bb1o6Yz4VM6lDJasbmNlg
	 RX0t0g/kFSqFFjh8RzojGHOX3GULzhAraoF6iKffXN5OzE8TJ+TpFXfrG4SszYRv/u
	 l5guwyVYW2rY1CeN4p6c8l6qhQNzpuv4WeY3AcRqLNgkqmGUXy8wxmPcF0DTsWgH+P
	 FNHMS/s/+5ZzFZxuA7UZUWZ+oICjiSGjs6S4vV9FvK6Ft0eqsjZcUOQANPWlPDiurh
	 MqR1j/X4f/yf88B6FHbho1d68+KLVMYuDzKQ2HsBfLrAGNwTcAz1grdwpTeAGWxK2K
	 Xzo4+d5asWakA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, mazziesaccount@gmail.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20240404195423.666446-2-andreas@kemnade.info>
References: <20240404195423.666446-1-andreas@kemnade.info>
 <20240404195423.666446-2-andreas@kemnade.info>
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: mfd: Add ROHM BD71879
Message-Id: <171285306996.2486859.2492109750495696356.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 17:31:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Thu, 04 Apr 2024 21:54:22 +0200, Andreas Kemnade wrote:
> As this chip was seen in several devices in the wild, add it.
> 
> 

Applied, thanks!

[1/2] dt-bindings: mfd: Add ROHM BD71879
      commit: 9814ee9b64c06aae57c8a8f003014b3d90e09a3d

--
Lee Jones [李琼斯]


