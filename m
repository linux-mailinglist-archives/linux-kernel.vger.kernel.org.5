Return-Path: <linux-kernel+bounces-13176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5077D8200BE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836F01C216EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DCE12B87;
	Fri, 29 Dec 2023 17:18:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BB412B6B;
	Fri, 29 Dec 2023 17:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF049C433C7;
	Fri, 29 Dec 2023 17:18:04 +0000 (UTC)
Date: Fri, 29 Dec 2023 22:47:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: David <david@ixit.cz>
Cc: krzysztof.kozlowski@linaro.org, agross@kernel.org, andersson@kernel.org,
	bhelgaas@google.com, conor+dt@kernel.org,
	conor.dooley@microchip.com, devicetree@vger.kernel.org,
	konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom: adjust iommu-map for
 different SoC
Message-ID: <20231229171754.GD9098@thinkpad>
References: <20231120070910.16697-1-krzysztof.kozlowski@linaro.org>
 <dfc4f26c-74fe-47b3-af96-e97765082f4e@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfc4f26c-74fe-47b3-af96-e97765082f4e@ixit.cz>

On Fri, Dec 29, 2023 at 04:36:31PM +0100, David wrote:
> > +    minItems: 1
> Hello Krzysztof,
> 
> the driver will accept 0 just fine, so I think this definition may be wrong.
> 

It's not entirely wrong but the actual SID mapping differs between SoCs.

> I sent just generic "dt-bindings: PCI: qcom: delimit number of iommu-map entries" which doesn't care about the numbers (in similar fashion as other bindings having iommu-map).
> 

No, we should not just ignore the MAX limit. If you add <N> number of entries
exceeding the max SID assigned to PCIe bus, it will fail.

- Mani

> Tell me what you think.
> 
> David
> 

-- 
மணிவண்ணன் சதாசிவம்

