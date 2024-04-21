Return-Path: <linux-kernel+bounces-152642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E66E8AC1E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8978B20431
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026F355C22;
	Sun, 21 Apr 2024 22:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRtnaQDs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC1B54F87;
	Sun, 21 Apr 2024 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738594; cv=none; b=fPVJUg424au1cMN8C2DSpSw7KvXLbZ9zywQ6UTsMAITOCQamNHbEKEdtZ3oy9RGwgnhqirYy/wv27KVPQhDifbhswqXkPf7ZzIrvFhLXm2eLEntZHbDQe2qofUCjfxaMD/TDbQGosKkVSas8G2UBUPnRqylbfLE5XCaQnqnpClE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738594; c=relaxed/simple;
	bh=3vmMKDvCV2iQl97DV5Inx095IODyeS7q3G6u/bm+ZyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkOiQ2FJwawIp4v4TdWzCE1Iv1XfXcOIgm/gks34dsmhs9c5hHmaIeFxR7XX1FV7apLZyIieDYruey58bCLRQSyS/RpnlgVMmexzrUEbmr6r4PJAqG1mcqISQhzaemrDahhxbsNj+FyU9nXxtlQRVOzqtnCzct3akj/RGwruyS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRtnaQDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1ECDC113CE;
	Sun, 21 Apr 2024 22:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738594;
	bh=3vmMKDvCV2iQl97DV5Inx095IODyeS7q3G6u/bm+ZyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aRtnaQDsemW00z/9oRK4T5osCb1LznkuFltnFwg+UwBvDWqoBd5WtpMl9I6tfijGg
	 fW4ESJaFVPACQItAoPImjbofvKcsPTYvTcN5uUlzUEZaEoGAiPLIfyfGqjq6VaW4Ar
	 LjToe7urU9wLp/FO04Imgbup7wY5RbpH/YXPIAel+7fNuWQRN9dQI8NVjpU3grOyID
	 GdrxrJiehzrr9uDVgN0sV4VBuEUNKgXWiZh0bQEuc94eHFbnu6ofii1NGDgctmGOIB
	 13A7IeF1Dqq50MVM+qoLuuudAsFHCaZeK5kG2VL3UOtseGntGdGjst97gczsEvdWcz
	 nq0BHU2uk2rvw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: Re: [PATCH v2] clk: qcom: gcc-sm8150: De-register gcc_cpuss_ahb_clk_src
Date: Sun, 21 Apr 2024 17:29:28 -0500
Message-ID: <171373856762.1196479.482456722925873210.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213-gcc-ao-support-v2-1-fd2127e8d8f4@quicinc.com>
References: <20240213-gcc-ao-support-v2-1-fd2127e8d8f4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 13 Feb 2024 12:17:24 +0530, Satya Priya Kakitapalli wrote:
> De-register the gcc_cpuss_ahb_clk_src and its branch clocks
> as there is no rate setting happening on them.
> 
> 

Applied, thanks!

[1/1] clk: qcom: gcc-sm8150: De-register gcc_cpuss_ahb_clk_src
      commit: 7ca07a174f3b4021ae0a2d60fed1f5c993cf4b49

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

