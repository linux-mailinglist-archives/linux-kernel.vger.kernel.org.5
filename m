Return-Path: <linux-kernel+bounces-57742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2BD84DCE4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4B01C26716
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAB26D1B0;
	Thu,  8 Feb 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BzADfJlO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EEB171B4;
	Thu,  8 Feb 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384284; cv=none; b=N59827rthbjJPIO2foBVWsmd0t5Uz4YvFU9A8fGVp0WeMtYNCg4UzdwOf5o4rJMjdNiKpnDjDaqTUBslBnYNR6FCAa63fOf08MDJ0t/uaxg2+RsouirkzPHTSyYuFPq837zuoQl02w/urknJJBCYNHSYrY1eb0+1Sx8ts3FzjH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384284; c=relaxed/simple;
	bh=UZdJqhCQtQwpF5a+Fo/W3a9Nlw0OF08YtvZFS5DdUUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvMCtbob6+bGl6qwDPv1S7+K2zkTrNlZqUfWPvNV0ZlKB3toQp6H11pr63edaNFM9cbDLXNahFjXfxwxrW68dwDbwOqF/qZl0kdihTJzyk9vtJoZ/SopWLE5+Wt53sePfVJaNiJpHMk/Smrun1mIgfiARXjtYtr0i0z/4ceu+j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BzADfJlO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707384281;
	bh=UZdJqhCQtQwpF5a+Fo/W3a9Nlw0OF08YtvZFS5DdUUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BzADfJlOlrjtaHuY5HCT+xn/qKjIgAbDRJ/yD24zKgILN9fPWJpRg2ICbble87MWy
	 C9Zp1ZV5Wm1TmqmzfK/Zta8XV6pfZnkNTT/hnh1Je/G96CPsycm3S1q/BjIymIsvvF
	 a/rSt8ixxPM/A8A1q0/UqdeZNHANXb9ygErkX63nTDjr4mZI4T7PCEBhH/kt67M3Ay
	 y2GVNyTLKprOBAWfbjFeUWsJQSuolcJnSw9+2v/SlP+kSC5CnhZLVBmJXKXQDqoYJF
	 VtG6NZ97dVUQA3WLrVpGNG6vwz3gRR1aRDXanR4Axpo6Ra9Z5e1g2oFa2ZZ4U8ennj
	 rz2gFPrDTLM2w==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ED1C33780624;
	Thu,  8 Feb 2024 09:24:39 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RESEND] arm64: dts: mediatek: mt8192-asurada: Remove CrosEC base detection node
Date: Thu,  8 Feb 2024 10:24:24 +0100
Message-ID: <170738399283.53206.14134622870926393347.b4-ty@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207-mt8192-asurada-cbas-remove-v1-1-04cb65951975@collabora.com>
References: <20240207-mt8192-asurada-cbas-remove-v1-1-04cb65951975@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 07 Feb 2024 15:08:42 -0500, Nícolas F. R. A. Prado wrote:
> The commit adding the ChromeOS EC to the Asurada Devicetree mistakenly
> added a base detection node. While tablet mode detection is supported by
> CrosEC and used by Hayato, it is done through the cros-ec-keyb driver.
> The base detection node, which is handled by the hid-google-hammer
> driver, also provides tablet mode detection but by checking base
> attachment status on the CrosEC, which is not supported for Asurada.
> 
> [...]

Applied to v6.8-fixes/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8192-asurada: Remove CrosEC base detection node
      https://git.kernel.org/mediatek/c/12356a73

Cheers,
Angelo


