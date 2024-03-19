Return-Path: <linux-kernel+bounces-106936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B145187F5B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6772E1F220FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7AC7E779;
	Tue, 19 Mar 2024 02:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/r1uwwQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B377BAF0;
	Tue, 19 Mar 2024 02:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816543; cv=none; b=cKY7suJxt/ZdwkAcdlQsinZ1n6ZQjZ5bb0iuYUER3ZB9feWWhPKu4onnuKf6ZmVCLmwz6PvBc8x582XPFRvVkuBHXSK3IcrvEzvdcpQzg8KCIiVj4VKuGEaKqYSBT75A2KQk9XZh03GJrpqtgRaUSryPvKBgd3VIH2AakvcxGIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816543; c=relaxed/simple;
	bh=HzlUhnnLmQm0ZZXswW9c61kZl9mt/Or/ep++Uk+xdMk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIdZ8cqhKYGFgdjYDWSKXPhgueNqmkEyH+pvPTqS/xVn+gPe1k7DTcRuWRRQsJ1dbIlm6qH/KqI4veQGP77ba9MLdvNV6uGi2a6nvJygPWzrGv3v+QarV311wWXHyB+VrGEO3oXxpuXw+MwgyN8UeIvhbbZKX/lg9qZsRywj+U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/r1uwwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2C8C433B2;
	Tue, 19 Mar 2024 02:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816543;
	bh=HzlUhnnLmQm0ZZXswW9c61kZl9mt/Or/ep++Uk+xdMk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Q/r1uwwQvvMrzlCQeRU2AlU9mSzCAnaeK0Oj/xkpbsxX2HhVQsMixyFgR8ZyzuptU
	 +rVcXTwXqqao1ucOlzJSBMwRFS+SvPxyyL3TtwqqJ1XviaClw7S8B1FM0jR/ExcoOW
	 rF3jdWmhgI824P8VjhsJJwyHLp4j2BRaibvoxaf4ECo4W3V1L2lA4+gXw8zDlcn46a
	 +FDofjAiYAC4n9pftu0FboKNgpdImXHqZN1Z9Pcm4hNlPHScDHJjtJN0cjYErR1OJv
	 cqztviIbxHMcgKSOp3Z5UNfPHpCw4xMnpzJ1XsW4Zf2ML18ZC7Rqo6vilEtolDpH3+
	 lKJ78EBxvJbKQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/3] arm64: dts: qcom: x1e80100: correct SWR1 pack mode
Date: Mon, 18 Mar 2024 21:48:34 -0500
Message-ID: <171081652641.198276.2261139023071151604.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227142725.625561-1-krzysztof.kozlowski@linaro.org>
References: <20240227142725.625561-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 27 Feb 2024 15:27:23 +0100, Krzysztof Kozlowski wrote:
> Correct the SWR1 Soundwire controller port block pack mode to match
> reference code.  Not sure if this has any impact.
> 
> 

Applied, thanks!

[3/3] arm64: defconfig: enable reset-gpio driver as module
      commit: cf30987a9ae9a8a430f957f8516b2092f6bab29d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

