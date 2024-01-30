Return-Path: <linux-kernel+bounces-45053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FFE842B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8079A28CB42
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CC714E2C9;
	Tue, 30 Jan 2024 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pu9qtVtV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE34E1292DE;
	Tue, 30 Jan 2024 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636388; cv=none; b=OILJiB5b+zLiyeGx6TGzSvm0kq0ZxQ6yL1QTpC4RLqchR78WbI23nqePF15wcsKdXraK3Nbhs0fj3Hlb572n0oJD6LEh5h7sZhjre5jkybYVotGpaqOJrAKYKDcD0y3IalbKGxutftogc4fWy98gPWlrLdYfCQ5zjsG0zXcbe+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636388; c=relaxed/simple;
	bh=NcU+mdNlkKy//Z7WYZmwlRZRQjhVmvq+zS+39FzljlU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B5gkPyuuPpTo8ioMtt/4o4jU2iZ3Fndi2SXDuJ2O4bHgO+Z+DYcqeTJMif1m5ZRdYAnIXwfNWfIKGRuPQbPm7K7DVLxHQw+ddxD/MtaDwP4z6FRNdKW2Pror++I4e4H6Z+jSwb5tbJi/m4PYMVpn1b5Gkxh42lLPxU747N459BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pu9qtVtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE05C433F1;
	Tue, 30 Jan 2024 17:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706636388;
	bh=NcU+mdNlkKy//Z7WYZmwlRZRQjhVmvq+zS+39FzljlU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Pu9qtVtVW3O1OFkG/kEaAV5qNjcOo9zwqp9RmHe/fiiYNj3b+9EKdEne8qBWaIFi2
	 vz8dcyhxFebJvJHSa+FxQk85STMYSjJ/gKxZPnWYz3JWeeTAeUAk/eIB9NVRkybjR+
	 SqUGG9uJ1bCCpj2tBUTTaYcAOjHo/IDk+g13//6pQ9tQiv8H6GNxkUKHpoNgDV8X9U
	 7kAKa0F8GNfl6UcG3RJQ6enlnRzfPpxgGE/NLBzv7DtJf6/nPL7L028od8Gcd/wDuK
	 tSvXm4gzQ9eTpUxgXYw36l2r2Sl6+7IgZh5jxRgZ5YtJ0xSTKn9SnilSmNR9aj1wmC
	 LUleZShrPZj8A==
From: Vinod Koul <vkoul@kernel.org>
To: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
 kishon@kernel.org, Qiang Yu <quic_qianyu@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, quic_cang@quicinc.com, quic_mrana@quicinc.com
In-Reply-To: <1703742157-69840-1-git-send-email-quic_qianyu@quicinc.com>
References: <1703742157-69840-1-git-send-email-quic_qianyu@quicinc.com>
Subject: Re: [PATCH 0/2] phy: qcom: qmp-pcie: Update PCIe PHY settings for
 SM8550
Message-Id: <170663638451.685888.12123923812372214913.b4-ty@kernel.org>
Date: Tue, 30 Jan 2024 23:09:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 28 Dec 2023 13:42:35 +0800, Qiang Yu wrote:
> Align PCIe0/PCIe1 PHY settings with SM8550 latest PCIe PHY Hardware
> Programming Guide.
> 
> Can Guo (1):
>   phy: qcom: qmp-pcie: Update PCIe1 PHY settings for SM8550
> 
> Qiang Yu (1):
>   phy: qcom: qmp-pcie: Update PCIe0 PHY settings for SM8550
> 
> [...]

Applied, thanks!

[1/2] phy: qcom: qmp-pcie: Update PCIe1 PHY settings for SM8550
      commit: 06e34728827cb47026e80db22304d03ee83c73a8
[2/2] phy: qcom: qmp-pcie: Update PCIe0 PHY settings for SM8550
      commit: 80082fc89edde66fe61ab85d23ea27b245fe73cb

Best regards,
-- 
~Vinod



