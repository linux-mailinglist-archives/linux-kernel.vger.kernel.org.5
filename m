Return-Path: <linux-kernel+bounces-73481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23D785C331
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F615B253F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE67A7993C;
	Tue, 20 Feb 2024 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAPQ0PY9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366D379923;
	Tue, 20 Feb 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451874; cv=none; b=QvJTSoyS5kx2skj6v6rIlQw/dkQE1UkEgpMyHJvAF9bBJXpK9XVvr48OrsEGjOPKzk8KBp0JSwkGrEBlfuMl7qKZ1SDamWKLggiDFsFzQd8i0gnCWB/RADUG0Zr7cd4v/vujw93MN+gnmfqcFN3dNtJ92UIRWaxHWqXzwT3LkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451874; c=relaxed/simple;
	bh=dxtGVyElvGY2gA1mYksr0Or3fDzpahnGKTLSiwPv4qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVn7BsrOUb9l4fNtANItJ+R7YkdzU4lWtoIyOJOehuS3aj2Fael+iZeNQd0Dqw3FgqG2y+UBQgzYpgOIPG43Bct1akY5FDJQdtDpO8O89innz13XfUyfPlOkbdCpeTnUyj7SA4lwsHlx26o3Xwk8jUbNtmO8DLzIlXVdy/AJMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAPQ0PY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2280C43601;
	Tue, 20 Feb 2024 17:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708451873;
	bh=dxtGVyElvGY2gA1mYksr0Or3fDzpahnGKTLSiwPv4qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DAPQ0PY9+DCt5RkEeNTFDeCTTZRPLqZgskigK9UY/g+ax260XFZ9iUhgiI5lfEfgS
	 lbaWE1dNkF1XKI5gA9ErUet6yoBhmqjXErSq/P2VaHGknAJZCVyR9Yz6QC3sRXLyiq
	 nQbzxKKSPikf2PnzlNlTNeOmbSBnipHw3Tc+D+igK+8hyrklpB3Pyof8r3i7zU2gfS
	 v0fE7jQ9uOzPO7kHVs/ZjCdML5uPhLw07SDbkHF17omhamt2P5xtauX9LsqYuQjePW
	 B9wyyeS0sZqcNnSbRGZikRIrCQ26g/kP6qX+WnSufKiY4nzwJdh01UbNXjIxjOuyiy
	 ZczACd/1w9xBw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: sm8650: Add msi-map-mask for PCIe nodes
Date: Tue, 20 Feb 2024 11:57:42 -0600
Message-ID: <170845186087.159943.1548702516093514872.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216-sm8550-msi-map-fix-v1-1-b66d83ce48b7@linaro.org>
References: <20240216-sm8550-msi-map-fix-v1-1-b66d83ce48b7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 16 Feb 2024 22:35:21 +0530, Manivannan Sadhasivam wrote:
> "msi-map-mask" is a required property for all Qcom PCIe controllers as it
> would allow all PCIe devices under a bus to share the same MSI identifier.
> 
> Without this property, each device has to use a separate MSI identifier
> which is not possible due to platform limitations.
> 
> Currently, this is not an issue since only one device is connected to the
> bus on boards making use of this SoC.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: sm8650: Add msi-map-mask for PCIe nodes
      commit: dfc554d5217163f9d1c9d75d1380af1156df6eb3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

