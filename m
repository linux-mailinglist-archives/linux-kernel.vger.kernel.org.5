Return-Path: <linux-kernel+bounces-8831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E3781BCD4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DB4286DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF4064AB9;
	Thu, 21 Dec 2023 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkhgHstu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6464AB0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB78C433CA;
	Thu, 21 Dec 2023 17:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703178979;
	bh=GPRM0+qr4tPE5bf4ipC9dmGTvUdkJMlb+ss4sMnL/bE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nkhgHstugS99qn/TPmBqYJlBhZiUq7tS1p/MzxG80atoqPUsHWY4bSmkbb/7tEgZ9
	 TtdnBUdclg+et7tVHkYPL4ifLRabWmIhypXg8vH7L7ryH88kvBnt6FVXko0yLgM//o
	 tkz7ygSMPQchQEABlhZMs5tJEg8CEKmY8Pn4VT7rWFcPDfhXR5GFRDAXKsTieHYyf/
	 bnBWZeIH3+W9BtPq6zo+cYXq08cho8QWrNZSOu0wuBQfCrUoyoNWnnul3UR7aLU24x
	 vWr6mKbq8kH21IBT2Lsqe5GHvyNVtBzsVnXLt2LOpVjQF7+NK0WZZ313/OgplOag35
	 p/dG8bBobzS8w==
From: Vinod Koul <vkoul@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, 
 linux-phy@lists.infradead.org
In-Reply-To: <20231204234917.23509-1-rdunlap@infradead.org>
References: <20231204234917.23509-1-rdunlap@infradead.org>
Subject: Re: [PATCH] phy: renesas: phy-rcar-gen2: use select for
 GENERIC_PHY
Message-Id: <170317897770.712473.10129741722453482459.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:46:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 04 Dec 2023 15:49:17 -0800, Randy Dunlap wrote:
> Change the last "depends on GENERIC_PHY" to use select, like the
> other 170+ Kconfig users do. This can help prevent circular
> dependency issues.
> 
> 

Applied, thanks!

[1/1] phy: renesas: phy-rcar-gen2: use select for GENERIC_PHY
      commit: 54c899f0d647e5724b02486243da40134dc91c45

Best regards,
-- 
~Vinod



