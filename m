Return-Path: <linux-kernel+bounces-123466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4205E890903
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7332A1C2A535
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE89138487;
	Thu, 28 Mar 2024 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skhEKXa/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937A51386D0;
	Thu, 28 Mar 2024 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653568; cv=none; b=nALyi+WK7yDyxI1G/vIsiiWic+5chrcwts6m7wUw/Hj0ASW10nRPtDM2oOMli4lHd6qDFRzVw2kQm3wd+CplZXd6ITbNJIJMUHTdrvkhnMMMOYGIGGKLa+c9y6bNiwISkztV+x2PeNZtEW+06lEe1GXlCJPzBYtdM6VkiUxO/dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653568; c=relaxed/simple;
	bh=CoCRyOvSmW7h8Khb06oFL1D4TfmylBpJvACGIQnAYHg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gDHkllvhJZ78HNixDjxalTXFsP4jT4hko7WRlGutcmBn4cmvCQ1m/qQhwlkiwKn0FL2ydZ2iwdbTg3YfE3sNERLhMwEP1wEdl0xCZiMc95FCH15+JE10pGu6by9jKC4aBWe5gotNXA9DEm48kEMJBcibCSd8avHuzYAbdZavlCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skhEKXa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE70C433F1;
	Thu, 28 Mar 2024 19:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711653568;
	bh=CoCRyOvSmW7h8Khb06oFL1D4TfmylBpJvACGIQnAYHg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=skhEKXa/1wRhRJgV2ysmfOciLaWN9GlB8kjVdG5yp1OtQK4wqVv0xP+iVtNLkSh2c
	 OL8Iehkayce/heiD4K0qjsshfxvAME/xO7qw3pvhG/8nzLrrpPwc0fYAJLHPeK7bvY
	 PcIxWE5Z4T/Kc4iXhh67l9ijrCgPFZ/QIfvJKU0waj1sLkt2BucTCc4aYDk1MJHGlz
	 8e9u0+whNzKFYqaoBD4M60z7ADKdmo2eK48SRSaMUmjdyPXC9I3WHUxiCdQOrwPxJX
	 9X+t0vg9C8DylwtIzLHE6zCr2gIgwoecCeAvcDa4862KSGUxJ/mqwlZNu9BjJHLGI+
	 DnccuKvvgl1NQ==
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240228-topic-sm8x50-upstream-phy-combo-fix-duplicate-return-v1-1-60027a37cab1@linaro.org>
References: <20240228-topic-sm8x50-upstream-phy-combo-fix-duplicate-return-v1-1-60027a37cab1@linaro.org>
Subject: Re: [PATCH] phy: qcom: qmp-combo: fix duplicate return in
 qmp_v4_configure_dp_phy
Message-Id: <171165356468.152390.9437072444869737899.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 00:49:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 28 Feb 2024 18:05:13 +0100, Neil Armstrong wrote:
> Remove duplicate "return 0" in qmp_v4_configure_dp_phy()
> 
> 

Applied, thanks!

[1/1] phy: qcom: qmp-combo: fix duplicate return in qmp_v4_configure_dp_phy
      commit: e298ae7caafcc429e0fc4b3779f1738c0acc5dac

Best regards,
-- 
~Vinod



