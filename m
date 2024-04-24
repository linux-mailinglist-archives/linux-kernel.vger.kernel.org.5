Return-Path: <linux-kernel+bounces-157340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51338B100C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4231F26B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD8E16C848;
	Wed, 24 Apr 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="CUaIpiwE"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3027160862;
	Wed, 24 Apr 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976680; cv=none; b=h9IXiunDS4URvp64wCAfSDIJvGV6n+CbEndddPU5ru77A3nW3jIROw1ZqgZP0UGQAkeyoWVK/fjuNxRJashKNjjlGf+VhnJVQJab4csVllKpHibwhdAtr1Q0X3jitHKWnBXuMSQvP7bj8vBO3KNx8TVyJZqnW9dV2pZhH0o1BnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976680; c=relaxed/simple;
	bh=isR3wDPwTdPEdfnaK6WfkOVlzo0ri2uPT0+2HHXoo94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuNIqUC0VZlzs/Rl1GLnfVs7ehIMCOIDGY0PMORR/Vv+W2n/nCHgO6LtqGO/GRnkqvz5vHV9EZSl9r1Tb5kxB+Umo4ZXbrc9aXUjrBUSYnJB4RRk/JP3mjLBA0LR/adBqJ4qs/mARpXTVcsbR3DaXFmM6jWUrQO07+oabf6SKro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=CUaIpiwE; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1713976677; bh=isR3wDPwTdPEdfnaK6WfkOVlzo0ri2uPT0+2HHXoo94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CUaIpiwEhn44RnVgzuw9hqVJZjhHeclnb9TuWUfLEwmm+Xc16+forJIsepXsUXiGH
	 eDRkKbYRHU52/TPAUXLhJO7iQCmM6HaJaNqAe5ErUkxAxmThjOz+r04sp3+2+F4IeI
	 yDvYyzej/hjfG0Z/VV014MRVhHoO6BjMNqzX33Ro=
From: Luca Weiss <luca@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] Use mboxes instead of syscon for APCS (arm32 & arm64)
Date: Wed, 24 Apr 2024 18:37:54 +0200
Message-ID: <2900999.mvXUDI8C0e@g550jk>
In-Reply-To: <20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz>
References: <20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Mittwoch, 24. April 2024 18:23:53 MESZ Luca Weiss wrote:
> The first patch is for removing a bogus error warning I've noticed while
> developing this on msm8226 - there the patches are also coming later for
> this SoC since apcs is getting hooked up to cpufreq there also.
> 
> Apart from usages from the qcom,smsm driver (patches coming!) all other
> usages of the apcs mailbox now go via the mailbox driver - where one is
> used, so some arm32 boards will continue using "qcom,ipc*" properties in
> the short or long term.
> 
> Only compile-tested apart from msm8953 (tested on sdm632-fairphone-fp3)
> and msm8974 (tested on msm8974pro-fairphone-fp2), but I don't expect any
> complications with this.

I think I forgot to mention this, but the msm8974 patch depends on
this series:
https://lore.kernel.org/linux-arm-msm/20240408-msm8974-apcs-v1-0-90cb7368836e@z3ntu.xyz/

> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Luca Weiss (7):
>       rpmsg: qcom_smd: Don't print error during probe deferral
>       ARM: dts: qcom: msm8974: Use mboxes properties for APCS
>       arm64: dts: qcom: msm8916: Use mboxes properties for APCS
>       arm64: dts: qcom: msm8939: Use mboxes properties for APCS
>       arm64: dts: qcom: msm8953: Use mboxes properties for APCS
>       arm64: dts: qcom: msm8976: Use mboxes properties for APCS
>       arm64: dts: qcom: msm8994: Use mboxes properties for APCS
> 
>  arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 14 +++++++-------
>  arch/arm64/boot/dts/qcom/msm8916.dtsi    | 10 +++++-----
>  arch/arm64/boot/dts/qcom/msm8939.dtsi    |  4 ++--
>  arch/arm64/boot/dts/qcom/msm8953.dtsi    | 10 +++++-----
>  arch/arm64/boot/dts/qcom/msm8976.dtsi    |  8 ++++----
>  arch/arm64/boot/dts/qcom/msm8994.dtsi    |  6 +++---
>  drivers/rpmsg/qcom_smd.c                 |  3 ++-
>  7 files changed, 28 insertions(+), 27 deletions(-)
> ---
> base-commit: 43173e6dbaa227f3107310d4df4a3bacd5e0df33
> change-id: 20240423-apcs-mboxes-12ee6c01a5b3
> 
> Best regards,
> 





