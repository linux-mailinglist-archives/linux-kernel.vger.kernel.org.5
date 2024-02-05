Return-Path: <linux-kernel+bounces-53196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1E884A1F6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC241C223E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE64481AC;
	Mon,  5 Feb 2024 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGkncM94"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D391947F74;
	Mon,  5 Feb 2024 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157080; cv=none; b=oDyXx3W/+dyUDIIbxufhyCwmaZktwy4p6wY+850RX6/481ED8AbJapZfJZ8Ax/08iPyvA95L1/G7oH/n039f0T/+pMgvZYEXCjzLIr9/ZX/3qjJYDJ31dW+YXA+jBm8qHXn8viqhVJokxSJUPUifM3+PSLz+/NaUNQnurnuwWKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157080; c=relaxed/simple;
	bh=jBaSc/rZuPGxyWFE67ubtLD/M52bRorZOIf27k+rDxg=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=abmJTOAnz0v6eyDXjFALW9Z5ZW79iTlTPVfDNCaAaFTAXG9NUkqtQ8q1nYBXxNkjhgrk4xTOhzA+pDXWQE9OMwHKNwLwb+aaNY3k2gNsE3MiVVTSxZAJLq2sOHgzjyGaWRZrnCQVga+nwaWUmVYN5VJ3Rs4ITDgzaP/geSGzYJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGkncM94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C16C433F1;
	Mon,  5 Feb 2024 18:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707157080;
	bh=jBaSc/rZuPGxyWFE67ubtLD/M52bRorZOIf27k+rDxg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=UGkncM94uWbIHR/EExuF9CxPZXjvFUvxdScom08WpcdIyTvXe3oE6/7z4iB1LvRe3
	 jGioopNprzwaBn0pgKSOLfcT1Eczw145F1bljN5tq6qlVzsTphiOAe2HWCHytAUMzb
	 nOS8aO70J9NK/n9kbbKUDznJvOs7m+kxXkmxjvxWQnWpSRxA/BuSkXVe9IqR16aBY8
	 Ml0xRd9yShEBr2L9X2nNLjnF2WgaXln2F24xHOJdQH5lfGV5dg1/NDmxz2oyX2sHdF
	 IFIb/MJazZT0ZJwW+nHlKU6xTSikh6k3RXjDeGVs7Yy2HwCdDYChj7yCk9C1/UA+ZF
	 BO0/cWD/HxXTQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: wilc1000: remove setting msg.spi
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240201201248.2334798-2-dlechner@baylibre.com>
References: <20240201201248.2334798-2-dlechner@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170715707711.1586694.10461660476143389491.kvalo@kernel.org>
Date: Mon,  5 Feb 2024 18:17:58 +0000 (UTC)

David Lechner <dlechner@baylibre.com> wrote:

> Calling spi_sync() unconditionally sets the spi field of struct
> spi_message. Therefore setting msg.spi = spi before calling spi_sync()
> has no effect and can be removed.
> 
> (spi_message_add_tail() does not access this field.)
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Patch applied to wireless-next.git, thanks.

bed41a344426 wifi: wilc1000: remove setting msg.spi

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240201201248.2334798-2-dlechner@baylibre.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


