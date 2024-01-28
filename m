Return-Path: <linux-kernel+bounces-41509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FDA83F2FA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0C81F228B5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F3424214;
	Sun, 28 Jan 2024 02:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afJDxpzV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52E023763;
	Sun, 28 Jan 2024 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706408260; cv=none; b=JVyxp9V8TBU4yt89IJnLh6N/j2sTQGmRL91hubtRYVdeD3W/GhApWEoohGTN6e/142bfO1Y6au+qsmK2LTu72GF4SDQ6fORJP5UWO0AuoWgGygBvNxexcuBvs2Y1RD+EedwiPiaEUqey+pqmIWiTGkDPeCsYVPGv5cyZrTZ5q5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706408260; c=relaxed/simple;
	bh=gB6yAMSdwmn4mu9x6huRMZYduR5+uZT5zxR3wje3MwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SgHzFmdAFFuilTyoOg+G2Dy5/qiTeMo8ZXwe4WgCRTNSkA2EEDTAN/eBOr+h6Li3Z4I3htqwEXCsOwihHSf/Zlk764wyBbpuMRvFRfl2koncLj/S1Tjm91BqhFJuity3FuY8bt+JMfUJKU+DWxvIX2rNAfK1gPpqCjMMqQJfjcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afJDxpzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93999C433F1;
	Sun, 28 Jan 2024 02:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706408260;
	bh=gB6yAMSdwmn4mu9x6huRMZYduR5+uZT5zxR3wje3MwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=afJDxpzVlnMJ1m2g0dk+GJlnHkLaOGN223dtlgSQ3kfiyoXaDoWOheG5mC+Zpp3cq
	 wZqfKBO3Vayje/SiIJk7qVxr/6cQDVaEC59/ybzBFRKxgWdiF9mzdy8RN9uwYOOQqM
	 Crqo2tySKl+69Yta1rE1RsOoYwYBDarv4Yo3Tm1UsEn9pzAZPFmNPbQS3iceGrCXsj
	 53Mw3IrbYzJTImId9BBN/9YflaygeexWYsGvH9/7pGfIADQcgifeV/8COQfvVFc5SH
	 YSVx06AmL4mOyq48bbSmJ03iZrkFH5dYPbAyJEytWTCH+w2/+h1CrMUYgMC5A6rL9j
	 Wjxg/zRPjaOSA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc/qcom: Add size constraints on "qcom,rpm-msg-ram"
Date: Sat, 27 Jan 2024 20:17:26 -0600
Message-ID: <170640822836.30820.11892950661950879625.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124190744.1554625-1-robh@kernel.org>
References: <20240124190744.1554625-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 24 Jan 2024 13:07:44 -0600, Rob Herring wrote:
> The 'phandle-array' type is a bit ambiguous. It can be either just an
> array of phandles or an array of phandles plus args. "qcom,rpm-msg-ram" is
> the former and needs to constrain each entry to a single phandle value.
> 
> 

Applied, thanks!

[1/1] dt-bindings: soc/qcom: Add size constraints on "qcom,rpm-msg-ram"
      commit: 8796fa0f9a08359bb87e859d6010350a9d7da38f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

