Return-Path: <linux-kernel+bounces-9856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F9781CC68
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14090286438
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9C6249F1;
	Fri, 22 Dec 2023 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ti9yMeeh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEF52420C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 15:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7749FC433C8;
	Fri, 22 Dec 2023 15:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703260242;
	bh=OwinfvSTjp4R9xDLdY3eLiCv4IR2pBcu0X/zy+8LZVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ti9yMeehezTmlpiOg5p4ri+s599iKaEUuyXxfFwIANqbjrqUJplF7VPXBl5ho73sp
	 eZ6lYzum7RRiRu5WbvR9gPYKsM1lPjvP+D3LuKC5HarNY2XYgUXLYFMk9w6o01AqPA
	 Q5CHPkMFZyBVTpPI/oxmRQbEJRj5LJef+Dzu5orHFQmR3THWayFnuE+22NixrmguiF
	 TACs2uTxPEHEvd7ix6a/v97L+qmGTp5xZzYBjFEGhngN+A7Bo1+zL2+QaqyGxxMynX
	 k48z+5nOX4cpwJp/uBJZhl929xLQFZ10Nu6Oqob5JTUZFc9G5aSH6JMro3yokXJcXX
	 bMUrkF2xKNHjw==
From: Vinod Koul <vkoul@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Sinthu Raja <sinthu.raja@ti.com>, Andrew Davis <afd@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chintan Vankar <c-vankar@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20231221102956.754617-1-c-vankar@ti.com>
References: <20231221102956.754617-1-c-vankar@ti.com>
Subject: Re: [RFC PATCH 1/2] phy: ti: gmii-sel: Enable SGMII mode for
 J784S4
Message-Id: <170326023900.743229.14820975046975055823.b4-ty@kernel.org>
Date: Fri, 22 Dec 2023 21:20:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 21 Dec 2023 15:59:55 +0530, Chintan Vankar wrote:
> TI's J784S4 SoC supports SGMII mode with the CPSW9G instance of the CPSW
> Ethernet Switch. Thus, enable it by adding SGMII mode to the list of the
> corresponding extra_modes member.
> 
> 

Applied, thanks!

[1/2] phy: ti: gmii-sel: Enable SGMII mode for J784S4
      commit: d719915ad9706a16adde231789a1d46fc12fb9c7
[2/2] phy: ti: j721e-wiz: Add SGMII support in WIZ driver for J784S4
      commit: 2029e71482fcd94dcc7df2c66c7fa635479748bf

Best regards,
-- 
~Vinod



