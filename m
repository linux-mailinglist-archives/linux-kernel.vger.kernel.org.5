Return-Path: <linux-kernel+bounces-2721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAC88160FC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9898DB239DA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24874F8B8;
	Sun, 17 Dec 2023 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7up0owW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173734F89A;
	Sun, 17 Dec 2023 17:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3E5C433C7;
	Sun, 17 Dec 2023 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833721;
	bh=DC90og2vLOqbpbihiwor5nMyWsmJKUB1BWcbrdGCjeE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B7up0owWYhJ8An+Q0/AKZ04o6G+YeMCRISg/OAs+05EY4F5WsQ9NStJUGF5y1CiF5
	 OEyvwnqFo6bNEL69oy8tC6QXHuLeWjvkMbEpWZU1c5bXBzNBvipnMA2vn8aIyAJ1yx
	 6FvktPUdxkeMcxWdb67rJ7ynHQOpHlWW+6WFhyi9aRselTyXZ6LDYmfJvMnpRxpTOE
	 64nzKY5vog8r5r9T7NfdsBiix8KY8mnfN8UPKdEoD7XPEAAKQa8Clb8mKuW1mCHpvi
	 VjiXE/hlTOpg7gXPRGNHR6h9NUdHumDXtnAahCu1WbMym2eMZAKwjnnLlu3Qqu09mw
	 /B08QAxObk52Q==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: drop unneeded assigned-clocks from WSA macro
Date: Sun, 17 Dec 2023 11:21:15 -0600
Message-ID: <170283349426.66089.1484668254069262307.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231212133143.100575-1-krzysztof.kozlowski@linaro.org>
References: <20231212133143.100575-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 12 Dec 2023 14:31:43 +0100, Krzysztof Kozlowski wrote:
> Review of v1 patch resulting in commit 58872a54e4a8 ("arm64: dts: qcom:
> sm8650: add ADSP audio codec macros") pointed to remove unneeded
> assigned-clock-rates from macro codecs.  One assignment was left in WSA
> macro codec, so drop it now as it is redundant: these clocks have fixed
> 19.2 MHz frequency.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8650: drop unneeded assigned-clocks from WSA macro
      commit: 55855d20208a5048ab44ccaf2d5aedd8f9f70e86

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

