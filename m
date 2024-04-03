Return-Path: <linux-kernel+bounces-129487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C315896B82
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6C61C26BFC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C90137777;
	Wed,  3 Apr 2024 10:04:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5F913666C;
	Wed,  3 Apr 2024 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138651; cv=none; b=OZnY9JuqOBt3sgGa33GXH2dEmbID4yDonYe2w/XNtGpQUB/x/fXDcOvCGUWldjVM4/THea08rg0G6zbWAmedHmtGJUq8YdVlgVsLMLDzkEwbyYnXO2FSDCl+vtKkxd6bONN2TQFm4aDYGh5oyD6KE9lWpZwU08nn+OmB553mPgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138651; c=relaxed/simple;
	bh=H5HTor6NBb+Q2DHoN1j4n1SavVYFqkC3NLp3D0b0KVw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAWOOUE264ouHdOUN2mdYTnJ1e6o1YGxDELbiZo7sPhYlAYtbQ2E4aO6enfl4iTvjewCJtsR7OBiguZl7KQ5v1U4O0yI049FBXj/1r5XaccIiCRequz3CFHInRTm72f4fcnrbjQ8N9cFJFg+i+sAHUr+2XfcwxnietWfKOanDIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4C4C433C7;
	Wed,  3 Apr 2024 10:04:07 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/4] ARM: dts: aspeed: greatlakes: correct Mellanox multi-host property
Date: Wed,  3 Apr 2024 12:04:04 +0200
Message-Id: <171213860535.16780.4635499105199545058.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209104412.12916-1-krzysztof.kozlowski@linaro.org>
References: <20231209104412.12916-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 09 Dec 2023 11:44:09 +0100, Krzysztof Kozlowski wrote:
> "mlx,multi-host" is using incorrect vendor prefix and is not documented.
> 
> 

These wait for ~4 months and they were not picked up. Let me know if anyone
else wants to take these.

Applied, thanks!

[1/4] ARM: dts: aspeed: greatlakes: correct Mellanox multi-host property
      https://git.kernel.org/krzk/linux-dt/c/7da85354c4fa35b862294dbbb450baeb405b5a92
[2/4] ARM: dts: aspeed: minerva-cmc: correct Mellanox multi-host property
      https://git.kernel.org/krzk/linux-dt/c/e515719c17beb9625a90039f6c45fa36d58bdda2
[3/4] ARM: dts: aspeed: yosemite4: correct Mellanox multi-host property
      https://git.kernel.org/krzk/linux-dt/c/af3deaf9bcb4571feb89a4050c7ad75de9aa8e1e
[4/4] ARM: dts: aspeed: yosemitev2: correct Mellanox multi-host property
      https://git.kernel.org/krzk/linux-dt/c/cac1c1dda6130771e06ace030b1b0ed62096a912

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

