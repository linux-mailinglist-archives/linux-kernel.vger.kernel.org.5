Return-Path: <linux-kernel+bounces-36494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C1483A1AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486921F28D28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B341C101D0;
	Wed, 24 Jan 2024 05:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hobzoJx8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE77FBF2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706075970; cv=none; b=ZWYFOaBio6VJ4yQ14Ho4jQbncoTCsBHheg3pUSmE0f9VKGFarEYo4yjndLX1xUXPTmWGbZfWmniq17JHUHLICecgVkMiFGUR4EvzAJ4hfrAtV0BRdavMcg5NRp1JX4dKi+Kz25grLWDHFAqKdzkJxM68OeT10SrNevLnAm/1gZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706075970; c=relaxed/simple;
	bh=THNCpjJfkari3A89HCYqRjqY8HEsq7oCLnNzT/WpTBU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ID66RV7zL2qURRcl51tMK90N3wUq8/4mCX9IcKxNP0dEZsEQE/3ntlw+0eFerEXdKALxNJpgWmLTEXvLpVfCjxXdUW91XwZwLE2UNat/V60giz2m2aSpwgZrqxM7J/Q0zuQUHfGuA8s2dmGyqraC73ap9g7CM9EldXQaJEYmhLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hobzoJx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB2EC433F1;
	Wed, 24 Jan 2024 05:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706075969;
	bh=THNCpjJfkari3A89HCYqRjqY8HEsq7oCLnNzT/WpTBU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hobzoJx8QwgRzgBLHM1sj+uyJwG1UeYyxal8BEtN2Z4a0VNQy5CkJ7udw6QaWler2
	 SfpSL4bQRAKTSLXtn/8hgmPE8bD3eFXmk7fms7bbu9qU+nmZ0S+NHBkNYzKrlLZikX
	 jSxUCOtTLvRTi7xLib4SnS9TK3L0aMl8nRZVZy4JJmz0RO1yjBsFvb44sUZD0cVYgB
	 YYkKCwLmTs9j/NVwfmYFGE7xTCsyiUwfHBki0CNwbTxlj04lmIt706d6f5reIsyZOp
	 XOUprR0LMwINpOjE60q6eUVopJkJW69Zh9+w4w9LzAigQb3dOJ1U8qdItFCwilKwYo
	 QY/C7WAPc5lGg==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240108205140.1701770-1-horatiu.vultur@microchip.com>
References: <20240108205140.1701770-1-horatiu.vultur@microchip.com>
Subject: Re: [PATCH] phy: lan966x: Add missing serdes mux entry
Message-Id: <170607596825.395031.15945327841005877396.b4-ty@kernel.org>
Date: Wed, 24 Jan 2024 11:29:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 08 Jan 2024 21:51:40 +0100, Horatiu Vultur wrote:
> According to the datasheet(Table 3-2: Port configuration) the serdes 2
> (SD2) can be configured to run QSGMII or SGMII mode. Already the QSGMII
> mode is supported in the serdes_muxes list  but was missing the SGMII mode.
> In this mode the serdes is connected to the port 4.
> Therefore add this entry in the list.
> 
> 
> [...]

Applied, thanks!

[1/1] phy: lan966x: Add missing serdes mux entry
      commit: 4e4a1183f281d95fbb6caf28d670775d13264beb

Best regards,
-- 
~Vinod



