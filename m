Return-Path: <linux-kernel+bounces-9062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A87081BFC0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D6C28AA02
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A55E76916;
	Thu, 21 Dec 2023 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXYl5uNC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7454E6280F;
	Thu, 21 Dec 2023 20:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5DFC433C8;
	Thu, 21 Dec 2023 20:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703191710;
	bh=TlkTsPIMI1ft1vRpFi2DNH080tBp/+IR49hOttKsZMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hXYl5uNC0jKVk5cOAt0/NukPy+vElCg9OuTHtg3izC0HrWP+hFI/tXP2Al7tzXURM
	 KFftJKEa8EEQrOEI5W1AKjO3asbioma+/zdjETzpfZ6MEWQnd3CesdopjVIMDR8c7u
	 Q3AXJp42prmlkxW2FgKNhnlVnLxEJsDoaA4agcsQGF0MGw/Fd0xC7WUyMp0fCQmfvv
	 hV1qBEXzTep70PSWyGTD8cps4v8NMMg2LgkDFGNRrwVzJPMfo78TYPYyU592CokkDc
	 j68hFB4a/9KUWRY9RDfV6tGw/HenNGFoKZJ3yD7dHZFHzvGbKXldzxmfJHdHYrq8zC
	 lbzQnPkA8ScOg==
Received: (nullmailer pid 67223 invoked by uid 1000);
	Thu, 21 Dec 2023 20:48:28 -0000
Date: Thu, 21 Dec 2023 14:48:28 -0600
From: Rob Herring <robh@kernel.org>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, Frank Rowand <frowand.list@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Raul Rangel <rrangel@chromium.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh+dt@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v2 18/22] of: irq: Add default implementation for
 of_irq_to_resource()
Message-ID: <170319170746.67177.2978168318056998611.robh@kernel.org>
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.18.I31d4dd6a7e5a3e5eee05c87b358e63cd1aa0e467@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220165423.v2.18.I31d4dd6a7e5a3e5eee05c87b358e63cd1aa0e467@changeid>


On Wed, 20 Dec 2023 16:54:32 -0700, Mark Hasemeyer wrote:
> Similar to of_irq_to_resource_table(), add a default implementation of
> of_irq_to_resource() for systems that don't have CONFIG_OF_IRQ defined.
> 
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> ---
> 
> Changes in v2:
> -None
> 
>  include/linux/of_irq.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


