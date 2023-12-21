Return-Path: <linux-kernel+bounces-8827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E07B681BCC9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C557B257D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3259918;
	Thu, 21 Dec 2023 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XllADW8f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC92163509;
	Thu, 21 Dec 2023 17:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9BCC433C8;
	Thu, 21 Dec 2023 17:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703178963;
	bh=ddkCtqedJXUfrPiPFVW9vL0khrWJ0HeXZyzlFi+7ZN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XllADW8fzqgI6ZGH4zVju2IL8ZRfeJQIDo7nwhIGPXo5s7p7HBGyUtX9nYCc1qUdh
	 ETZuKyc9WwEEf5ZDax/GJ5iQrwJCLnHZpjkyDrsMDjTpcPf7aMtwwz+L8fe2kfKnnO
	 jiuPzMYidXNe6vU1pS00Khwr8ffSccCnlQgMjvTFZ0eZi438AcS+B2PzXPSx9birN0
	 FvwDAUI0cLzcfEXKuGFqLdTDkHEvtpcXmN5ZC77EKrK87clIVfvsjzwIX6wYbksbD6
	 9yuABNt3RX3FjRiVjSAVzKJ5ESnBhXF4daUM6bEfWQQH8nIgE3ikiGZx6f6bF//cGp
	 gyZHPHz2qln0Q==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20231211025624.28991-1-chunfeng.yun@mediatek.com>
References: <20231211025624.28991-1-chunfeng.yun@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: mediatek: tphy: add a
 property for force-mode switch
Message-Id: <170317895962.712473.102387666807925662.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:45:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 11 Dec 2023 10:56:23 +0800, Chunfeng Yun wrote:
> Due to some old SoCs with shared t-phy between usb3 and pcie only support
> force-mode switch, and shared and non-shared t-phy may exist at the same
> time on a SoC, can't use compatible to distinguish between shared and
> non-shared t-phy, add a property to supported it.
> Currently, only support switch from default pcie mode to usb3 mode.
> But now prefer to use "mediatek,syscon-type" on new SoC as far as possible.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: mediatek: tphy: add a property for force-mode switch
      commit: cc230a4cd8e91f64c90b5494dfd76848197418ed
[2/2] phy: mediatek: tphy: add support force phy mode switch
      commit: 9b27303003f5af0d378f29ccccea57c7d65cc642

Best regards,
-- 
~Vinod



