Return-Path: <linux-kernel+bounces-132691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1B78998B2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550E81C210B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B069115FA94;
	Fri,  5 Apr 2024 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6cUJsJ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4D611E;
	Fri,  5 Apr 2024 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307608; cv=none; b=fWB/3u39kmTWnbSgGzyMfna1lReMBI+waNohdtSpAfPNqGlwyCTLfEqAZ5dr3dVu+Wxop/eT8n2Gnfb7bDCBXgiEOsbsG37OuZxcvEUdqkSe6TZx5+hi7TQw9cS0rMr0ke2xOjLZsFn8crgpsqsdZ4c2r+bEWyvrP+rCpHia720=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307608; c=relaxed/simple;
	bh=+ALxXjaOWiaYOCohjxMrJ7edua6qjaGmpEgfgzxGPdE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=sjzY4WD2lBszrTNrcykLNtdW52sfzZ6MZssDy5+peSiiiuwsMU7sCv7GAnTZmbK08SE/FmXe5lsZ9Xevjdw2tPTDVQkTfTzSLUTUTxZWg7gwcI7Qv+tQN54iyTyB2SzkK3V8f1qVpa06AWhQaoWK4gDNRI+MGVH6atrEZxzMdNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6cUJsJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBCEC433C7;
	Fri,  5 Apr 2024 09:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712307607;
	bh=+ALxXjaOWiaYOCohjxMrJ7edua6qjaGmpEgfgzxGPdE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=D6cUJsJ6ptGjtgJGSycHeBM1LR2HUz+dnED6ytP9tYH1OrBpwha3jsN/vHTMXrJ88
	 dS0Nhp+nvabnbGdik387gQ9D6WbYMQ1xv94g2lJq6J1sLyLNdx+X+SpgOoRJmsPzES
	 9qCTxTkfWtqzlGA4WLYvNvFkFtu+P7np93x9pSu0FcZNMXVK6JTdS1zxTqvdLmTu8+
	 Ws3DXzbcba35hxIleKyvAtBuJbxTyBWbdh1seJBSOWsK/ktAbGtogLEh5YTuR2IEiL
	 RZfY8kUoNyqqvbvr8/1T7GLbEX4nnRTq0plzA7r0l+TAzhc7KGtX6/6W8wipNCizDp
	 lYPeKefs6bpJA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [3/6] wifi: rsi: sdio: simplify module initialization
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240329171019.63836-3-krzysztof.kozlowski@linaro.org>
References: <20240329171019.63836-3-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jeff Johnson <jjohnson@kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171230760246.2149729.1844900006480308481.kvalo@kernel.org>
Date: Fri,  5 Apr 2024 09:00:05 +0000 (UTC)

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> This driver's initialization functions do not perform any custom code,
> except printing messages.  Printing messages on modules
> loading/unloading is discouraged because it pollutes the dmesg
> regardless whether user actually has this device.  Core kernel code
> already gives tools to investigate whether module was loaded or not.
> 
> Drop the printing messages which allows to replace open-coded
> module_sdio_driver().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

4 patches applied to wireless-next.git, thanks.

73ec84df3469 wifi: rsi: sdio: simplify module initialization
718fcb7d7b3f wifi: wl1251: simplify module initialization
c33c93e9e96a wifi: wilc1000: replace open-coded module_sdio_driver()
170861bc0044 wifi: mwifiex: replace open-coded module_sdio_driver()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240329171019.63836-3-krzysztof.kozlowski@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


