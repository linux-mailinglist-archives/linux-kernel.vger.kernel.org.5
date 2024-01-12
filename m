Return-Path: <linux-kernel+bounces-24700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E3382C103
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474FB1F259CF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D34E6D1AD;
	Fri, 12 Jan 2024 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJXI4KVK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0E36D1A6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5246C433F1;
	Fri, 12 Jan 2024 13:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705066970;
	bh=YpwWW4OLBeabsBG1cbAaDtEvvq5ciHZvckmCjU3zB14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tJXI4KVKYOrkNDfXnOaLh5Mwp3nova0IyNHT/PjjrTQWr4RGfztkBaRB2h0Vyba+Q
	 p242rnEJe41bLyEkKynZLb4d50h47APlw9XmPh/LonxuyfZiPfP330OH4kWBfz5z11
	 UOCOiK5qiZLIDf+YfD+ps2n0TjH3JM+NZQRScWJedjp+USJ0Tcijo+pJTnSCGigeFW
	 qmi6ACbppAHxHJix1SsnHS/TjngHlhN9OCMJSOXVwwa7pxheVGo8OAzPethsr14KYm
	 E7op9+TgrW6z9Z3gdyEdQJyKz13+oqOf5eiZ+2WEUWa143cnrPFU5wcPpilw8ylHzX
	 HK9oeobYZbdTg==
From: Will Deacon <will@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: Cortex-A510 erratum 3117295 workaround
Date: Fri, 12 Jan 2024 13:42:40 +0000
Message-Id: <170506389420.1192006.10739525828268867776.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240110-arm-errata-a510-v1-0-d02bc51aeeee@kernel.org>
References: <20240110-arm-errata-a510-v1-0-d02bc51aeeee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 10 Jan 2024 11:29:19 -0600, Rob Herring wrote:
> This short series enables the existing speculative unprivileged load
> workaround from Cortex-A520 on Cortex-A510 cores which are also affected
> by the erratum. The erratum number is 3117295 and details are available
> in the SDEN[1].
> 
> Rob
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/2] arm64: Rename ARM64_WORKAROUND_2966298
      https://git.kernel.org/arm64/c/546b7cde9b1d
[2/2] arm64: errata: Add Cortex-A510 speculative unprivileged load workaround
      https://git.kernel.org/arm64/c/f827bcdafa2a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

