Return-Path: <linux-kernel+bounces-91295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E70870C6F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83031C24304
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781AD7BB1B;
	Mon,  4 Mar 2024 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGZIAe0l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97087BAF8;
	Mon,  4 Mar 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587433; cv=none; b=soTS5o+YEfWz8JVi+9PcooPhsxSiyap6vjIRZ77abQivK1YgRV2je2fTEnVwoX3fH4yH0vOJ+9JuOAGk5FcI3MlnfqXz2Wocs5ASg2aNQe483fm/R8Al+hJ3MLzs0ff4lZ6vpp19wZYAg1/CxO97ga2/G+WaKf3h8n0/nm8P8Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587433; c=relaxed/simple;
	bh=nNyK/AI+ihYXJZ163yF8wmk0/127aLcoLbtQtBVrcME=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwlgnWu/CcWXbmmDejk3gknO/kwmkk5qTRKn3bStEZsK7RDLrldPT0AdyqXQvQBxtt84+VFRmJsGyIFC05yH4O2M9SDRbHCVwj4MXZyEKf1K5NOiZHm1coJp97kku57L0GyYCP7DpA7yZyC1FgGbtoNHQobhfzsOqmxZCM44yQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGZIAe0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E648EC43399;
	Mon,  4 Mar 2024 21:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709587433;
	bh=nNyK/AI+ihYXJZ163yF8wmk0/127aLcoLbtQtBVrcME=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TGZIAe0lXsi9vBE+KYtY8fpOoHx1vWK1tafZHlzm4LjygzpQQqvg0qq/qn1k05wFv
	 M1lic9wR9v+m/aJpWBfxonkPuFcnVZ4pfTQ20sGoNfg9l3jpreaftSbAxdn8mUuIVu
	 /T4nUQfdkNVKA4llhlVkipGrwOALYd+kc0j4XnWZkYcJ4HmtJ+QkXQiLBidwqy7MsN
	 aPjwhnu/C5okeme46itZf+7XOroSIk2TIDktJ+E8MecOdnYWrDkvNkfHg1j/Gh3vRH
	 lrFNlgilcCH74j0leK329BkotRkh00KTaRyaXjZukpBBYgvmZtStCCVwzK7Coa1vKd
	 zTCFvz8ibZlMw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Chris Lew <quic_clew@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/2] soc: qcom: geni-se: drop unused kerneldoc struct geni_wrapper param
Date: Mon,  4 Mar 2024 13:28:42 -0800
Message-ID: <170958768040.1828118.5286783845232608374.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225202545.59113-1-krzysztof.kozlowski@linaro.org>
References: <20240225202545.59113-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 25 Feb 2024 21:25:44 +0100, Krzysztof Kozlowski wrote:
> Drop description of non-existing 'struct geni_wrapper' member:
> 
>   qcom-geni-se.c:99: warning: Excess struct member 'to_core' description in 'geni_wrapper'
> 
> 

Applied, thanks!

[1/2] soc: qcom: geni-se: drop unused kerneldoc struct geni_wrapper param
      commit: 87edd944ff568fe923530b3b15fe96380d4442e3
[2/2] soc: qcom: aoss: add missing kerneldoc for qmp members
      commit: 9f378a62164cfe218b5a355696464d93b132edfb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

