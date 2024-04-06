Return-Path: <linux-kernel+bounces-133867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C5989AA18
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772872834A6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ED945946;
	Sat,  6 Apr 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag1LVMaD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32970446AD;
	Sat,  6 Apr 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395144; cv=none; b=YN3LjRL/EMCQYSSLJfZn35f3tGb64p8OXHW9WQOQfU8ITLQrfMdnQoMvhQmk01/KhlVKNiefsd3ZFmzK7nqhKW/nvCEcxYcJ0KjC2QXcNLB2l+u04l/mmNCJHTdzHBbWd+iuD/bwiGvnOY82RfSJ55oZHIAkHHUfzP4PIzZjT5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395144; c=relaxed/simple;
	bh=1iz5fj0staSEBeBD4iubGSRLqhDhiBIKfBjemrptmJE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eHA702xU/J3OCj9p9JEsfxLy4Z0DFbKjWZ4Zgm4bUVY7k41jOV7YKIBEpSYapYlL9o6gkIVl+/n9bv88qBSQEX9z5TJ5bfs1X3kPjkJVphHiUWPRG3Jjj4TECvjQ5/4Ij4cZuut/Xc1mJbdA1ifkDruxLIU/VmfTAayAsHotSqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag1LVMaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E35DC43394;
	Sat,  6 Apr 2024 09:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712395144;
	bh=1iz5fj0staSEBeBD4iubGSRLqhDhiBIKfBjemrptmJE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ag1LVMaDwFBCTCC8hW1EdfxpTKqKuWopYK1dHwSVtSR/m3ufyCM+/Z3lJh7EEqYUf
	 e7jhCey2MXWcUUfwrdL4uynOmNDwHTY3ZxHFtLPIiRYjWeV5n5V5+Y6+QTlQHMfKsm
	 O7YjYL0RGSRrtD9eWDMy/R0Sr7NP2EH/hkZrwqtzXCIMzU1CQcQMcPjqiijTs8vZp5
	 sxp4txYdi7whwSjcTgg/J9iZJEabVirHvAshc3/Lim7i7YSeZnPqxLpr62nsY7RvE/
	 DcEm+q1gHrMVa48qfo0WQHhdqpR8E3kYXzSZ5lJS6Isp40I4Tqzo5+fBXivY8uilDi
	 jnwJxow/JBuIw==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Stephen Boyd <swboyd@chromium.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 linux-phy@lists.infradead.org, freedreno@lists.freedesktop.org, 
 Douglas Anderson <dianders@chromium.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Steev Klimaszewski <steev@kali.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
In-Reply-To: <20240405000111.1450598-1-swboyd@chromium.org>
References: <20240405000111.1450598-1-swboyd@chromium.org>
Subject: Re: [PATCH] phy: qcom: qmp-combo: Fix register base for
 QSERDES_DP_PHY_MODE
Message-Id: <171239513898.352254.11562819537572881543.b4-ty@kernel.org>
Date: Sat, 06 Apr 2024 14:48:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 04 Apr 2024 17:01:03 -0700, Stephen Boyd wrote:
> The register base that was used to write to the QSERDES_DP_PHY_MODE
> register was 'dp_dp_phy' before commit 815891eee668 ("phy:
> qcom-qmp-combo: Introduce orientation variable"). There isn't any
> explanation in the commit why this is changed, so I suspect it was an
> oversight or happened while being extracted from some other series.
> Oddly the value being 0x4c or 0x5c doesn't seem to matter for me, so I
> suspect this is dead code, but that can be fixed in another patch. It's
> not good to write to the wrong register space, and maybe some other
> version of this phy relies on this.
> 
> [...]

Applied, thanks!

[1/1] phy: qcom: qmp-combo: Fix register base for QSERDES_DP_PHY_MODE
      commit: ee13e1f3c72b9464a4d73017c060ab503eed653a

Best regards,
-- 
~Vinod



