Return-Path: <linux-kernel+bounces-41432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C983F0DD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7001C20906
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC9831A7E;
	Sat, 27 Jan 2024 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hg/fdJtq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EB62E84D;
	Sat, 27 Jan 2024 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394895; cv=none; b=tA+HJcGNRyOxkzgSpKLW38JUepiuD9XWlbMfINJSskZON1q2zbYaM+xZ8GS+sIbA/bxbsas3UH8b6J+SAxWCQG4WYnrrkq7ClyVI7ynzmH3ys7FBck2tmFxwJbWMJszTKVcVMjF2xoO9PtzWZMzQVfvsI4SNTqwstKJsu5YN6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394895; c=relaxed/simple;
	bh=Va2pyw6+6WNloVAgpJk8uSDFDAUvFlJuLNNsaAhpssE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnMVU2o7/83TtPaxLcqnu4fcy/35Csx3D2HPERVZ8hOYHOsntmE82HwQ6IMFiLGcORKotOopOs0eEzERWRuXV9/XWqiu38V9OnhtuqR4v2KuRp9AWWZN11t3SF6fd8d1dTwl8GC5arXNJxKFCpesxKkKzKqy2adgM9Lzyw5DwLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hg/fdJtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24676C43394;
	Sat, 27 Jan 2024 22:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706394895;
	bh=Va2pyw6+6WNloVAgpJk8uSDFDAUvFlJuLNNsaAhpssE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hg/fdJtqFaHaVFhksuHUdQDpT7ag7F1mkvjHYq5acVh2Oc2s5jAgoE0pUX7+UWJK3
	 tjfAOSEAkbPMIZ3Vzls1X+Rf1cPvZ/BozzgOjljOffFyk7ItmP9Y0hrQa8OmNYuMlo
	 NhX3I942trFhDL9Dnuy1BM2iXUgO92UK1xruo+IAJAALeuBpYXOORLTYbg+TW3sctY
	 2HAqs/ReadDkT0ZeFa96R3Cptd7B42mU7UnKXxEectXX74Pl/Bn+gLL9FooWStI/8o
	 iwOS3bbKGwOAFTfKEOMFaHUNYwSleHa2eRYdgWQAo/eSxCKgJhRQgh7UNV4NElyqfv
	 Rgt8ggO2F4JWQ==
From: Bjorn Andersson <andersson@kernel.org>
To: linux-arm-msm@vger.kernel.org,
	=?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: apq8026-samsung-matissewifi: Configure touch keys
Date: Sat, 27 Jan 2024 16:34:46 -0600
Message-ID: <170639487716.21016.1561283701156536116.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204094649.10094-1-matti.lehtimaki@gmail.com>
References: <20231204094649.10094-1-matti.lehtimaki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 04 Dec 2023 11:46:49 +0200, Matti Lehtimäki wrote:
> Add touch keys which are handled in touchscreen driver.
> Use KEY_APPSELECT for the left button because other devices use that
> even though downstream kernel uses KEY_RECENT.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: apq8026-samsung-matissewifi: Configure touch keys
      commit: ffb05e91b68bc58484b94b5d3d1aa8e559278fd6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

