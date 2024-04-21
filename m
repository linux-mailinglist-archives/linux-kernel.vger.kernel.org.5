Return-Path: <linux-kernel+bounces-152630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8247D8AC1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF11280DF4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CF44D9F6;
	Sun, 21 Apr 2024 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEb7CGex"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3CD4595D;
	Sun, 21 Apr 2024 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738580; cv=none; b=a/7wWdJ3MxV9Tf5Tadet9Ln2TQdym/qMVb+56h2t5D1o8zpaoT4lBf1aXbStsqworjP+J4pZpClU/M1+k0Qh5oeCpoCCMJUE6Pbz30E7WwaTHAsjD8zrC7swweb4cY7kXBZduahEweE1SAghqlp4QRYZDevR3eEoEUx0bC9aNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738580; c=relaxed/simple;
	bh=RqogyZpi7GC6sa8OQ+7M08Zm/rG5cDcCF1hfrjrpgSo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4PR3fhNA/P0Xy/UxgiqV/zMIM/x9URkpiMycxgBvx+0ruQuvhRoJdnYgZGVnK0tY7+YlLaOdkZlKXLt9Ml0iccGjrPSfHYHm8n39sSayGlJemiWjQPJgyikdPlyVNshSpYcPzqCt0MNnx5o5HTMBDXVUdpx0y58rgRRiJW3ktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEb7CGex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B845C4AF07;
	Sun, 21 Apr 2024 22:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738580;
	bh=RqogyZpi7GC6sa8OQ+7M08Zm/rG5cDcCF1hfrjrpgSo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jEb7CGexfNIn1vtrnnHFvxuV971Ai+QhMmNdOi3w1hS0P8N6kfrH1CDY7lxfcobBy
	 /Fa0SsibjNOAv32xTkDY5l/IvXxUrjZvk3fgJW1axITJR/ux0J6Qx3ssj3rXP7QZHC
	 A47kze7q78YOIcuDse79tlNcs8j/LiQhCBtXc7K1SANJ0lFs9wDLKhCldscct4q+Hk
	 dYgNXJLH/XgUlLEXrRNYZeYR84h2QuLRWc4bLE1QGRmySA+c1X1ilZOO+bpLOlTsyC
	 O0hEsutcD0VcoT32DzBx0YRhOkfRXBVwMOuVRx4AwNsez1jsO71Rk5VbM8X9797Eip
	 U3BaH7JDaS7iw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2] soc: qcom: mention intentionally broken module autoloading
Date: Sun, 21 Apr 2024 17:29:15 -0500
Message-ID: <171373856754.1196479.16545150503325714194.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410184522.271889-1-krzk@kernel.org>
References: <20240410184522.271889-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 10 Apr 2024 20:45:22 +0200, Krzysztof Kozlowski wrote:
> Qualcomm PMIC ChargerPD ULOG and RPM Master Statistics drivers are
> solely for debugging purposes and should not be autoloaded as modules.
> Add comments to annotate missing MODULE_DEVICE_TABLE.
> 
> 

Applied, thanks!

[1/1] soc: qcom: mention intentionally broken module autoloading
      commit: 77706838f837785189578bd8fd768e646e63f8c2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

