Return-Path: <linux-kernel+bounces-113261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263268882DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79671F22477
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE68B188A9C;
	Sun, 24 Mar 2024 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVqDhpzF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0296C188A85;
	Sun, 24 Mar 2024 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320061; cv=none; b=s5155n1TyCWeAwkXKaLebTRS6bjiTvwgx5O9iGgMhPM4NRGzfazva0qz9sbzLnOdP8IUFKLSBUhHDMKbpjtcN2fCsgHpVi6H5d0iEozKJZNtql3TpaoZ97TQ6Xeca4cQ3Jsi6kN5dYOlirUfNBlAlP1wMg2g5kI5WqNLzrQ1ugM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320061; c=relaxed/simple;
	bh=LknbtscaZXZV/9bS1cB+uwJmCI5cJHZBNwpJ1B9+Mzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLJ5kYwHMRXgFbYhqqb8cKoAVnYYxrsaw0zGpJYHehXaxapehzs2mEEBrhUz/9fBohmwBTCYiCam2uiCzjDljUh6lUDw+KclO6msbygK8vZhnwSzxiWTMSVlHHjN6yGiIw6IPhh3T6im7S4ui0Sdl/cwdDF6NiSiyfEyFSsFaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVqDhpzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B13C43394;
	Sun, 24 Mar 2024 22:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320060;
	bh=LknbtscaZXZV/9bS1cB+uwJmCI5cJHZBNwpJ1B9+Mzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uVqDhpzFKVgm41YpM59QUcoTJZqTTuvOuBlcIYHOtgJWGBpfmRBzEpdLddo8QKgFd
	 F4jQQKVubHaLoEIytfIyX5EzX4D/DnXbLNzWenxdBYY98MaGni2wCb4AOmgBtpIptl
	 6E1QivQ+3NRraRJSFgLaNzyfVXbBcxvN1TRn5AXNrA/p+u9BBz9z2w3ZpXnkDb2vqv
	 Rn3trjb+GeHIDbHO0/f5KZTYTWI7RWfpBOQowMj3LXtlrasK/5a9DdKgaZb/WPRHdq
	 i63i/S4lGWbhIT23+PZ8et2zsQK1k758xLKv2oVs01B4ZE7Xq0Z5lgM4ZXHnuIyKN/
	 eErrPcHjOhpJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 370/715] soundwire: stream: add missing const to Documentation
Date: Sun, 24 Mar 2024 18:29:09 -0400
Message-ID: <20240324223455.1342824-371-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 0707496ff4e416ea08c90053fd5fde5811b11b22 ]

Commit 21f4c443731f ("soundwire: stream: constify sdw_port_config when
adding devices") added const to sdw_port_config argument, but forgot
documentation.

Fixes: 21f4c443731f ("soundwire: stream: constify sdw_port_config when adding devices")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240117160639.1327266-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/driver-api/soundwire/stream.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/soundwire/stream.rst b/Documentation/driver-api/soundwire/stream.rst
index b432a2de45d37..2a794484f62c9 100644
--- a/Documentation/driver-api/soundwire/stream.rst
+++ b/Documentation/driver-api/soundwire/stream.rst
@@ -324,12 +324,12 @@ framework, this stream state is linked to .hw_params() operation.
 
   int sdw_stream_add_master(struct sdw_bus * bus,
 		struct sdw_stream_config * stream_config,
-		struct sdw_ports_config * ports_config,
+		const struct sdw_ports_config * ports_config,
 		struct sdw_stream_runtime * stream);
 
   int sdw_stream_add_slave(struct sdw_slave * slave,
 		struct sdw_stream_config * stream_config,
-		struct sdw_ports_config * ports_config,
+		const struct sdw_ports_config * ports_config,
 		struct sdw_stream_runtime * stream);
 
 
-- 
2.43.0


