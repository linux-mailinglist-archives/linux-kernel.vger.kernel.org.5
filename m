Return-Path: <linux-kernel+bounces-106943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A08687F5CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8CC282194
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A0980034;
	Tue, 19 Mar 2024 02:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT3ColQI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36037BB1E;
	Tue, 19 Mar 2024 02:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816552; cv=none; b=VOluaikyH8y3Y5u18+6ROr4/GwVLLWN/XcdrYoFDFRGtb0CKfZK/tKbvquBpZmjZPU0iFhp1kfuQsdp9MmvyLzv4RaZUYbzfncNHdotQAH4GLnEHMRCUzc8+uGc0+I2APst9jqehOiMbuMBcblfNCLwaDcAh6BV4cak6tcznNVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816552; c=relaxed/simple;
	bh=2YvfeBS4cRD3JCds/SxiHJRXbHV9oCMn1wgNuVDXen4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPi8OpQBxXVKceczm2ok3JW2ufflA8zWk0RWkeDdSQgzHL/hqy65gE5iaDN3AxABe91gwJ0NDk1czLRYykBhvJ6RpK+Hn5oKYczWY6KOWTCbNGOLtMCHjJfFvlm4/B6rFJXNX2MzokfqAhszSoTzl5xRs9Chn0zMOvwGjDRiYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sT3ColQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BC7C433C7;
	Tue, 19 Mar 2024 02:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816552;
	bh=2YvfeBS4cRD3JCds/SxiHJRXbHV9oCMn1wgNuVDXen4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sT3ColQIqVSUAJKbPAIs97KvQbzBHXXcEaYkWFZy0bKNxqjmSkDiEnbQdK3mW7fAQ
	 S/sHtYJ5k/A7/YgoGOwJv0hSdO2LnSOcEqKN+CyLRygoj2/vTeCJiQztEGy7ijihXW
	 JbtZ9x11DxvrSgGMypdoy/5t8s+51xzBEnEG6D8PtZ3Xcl7Pvt2g/fNe4PjLJSu4FW
	 zOcoazDEOes+UoJPKm3fWl9ERashM4EatxmoitYIW9Tq0oMLh2M//7AJtzAS114GQe
	 BZQb6njv/o0Fqzc5HzdcN6nbmT+M07bazwEWOur8SurHCD+oIKBTIOtSNbGHylWa4g
	 L6DMxgIM8zK/A==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: qcom: sm8[456]50: add missing qcom,non-secure-domain property
Date: Mon, 18 Mar 2024 21:48:42 -0500
Message-ID: <171081652642.198276.15833859282515233329.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227-topic-sm8x50-upstream-fastrpc-non-secure-domain-v1-0-15c4c864310f@linaro.org>
References: <20240227-topic-sm8x50-upstream-fastrpc-non-secure-domain-v1-0-15c4c864310f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 27 Feb 2024 13:53:03 +0100, Neil Armstrong wrote:
> By default the DSP domains are non secure, add the missing
> qcom,non-secure-domain property to SM8450, SM8550 and SM8650
> in order to mark them as non-secure.
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: sm8450: add missing qcom,non-secure-domain property
      commit: 033fbfa0eb60e519f50e97ef93baec270cd28a88
[2/3] arm64: dts: qcom: sm8550: add missing qcom,non-secure-domain property
      commit: 49c50ad9e6cbaa6a3da59cdd85d4ffb354ef65f4
[3/3] arm64: dts: qcom: sm8650: add missing qcom,non-secure-domain property
      commit: 039d379490eabf798baded4de2d698a7324ab7e6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

