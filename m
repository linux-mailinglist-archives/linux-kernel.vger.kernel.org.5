Return-Path: <linux-kernel+bounces-131227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9CB8984DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26A4283FF9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FBD7581F;
	Thu,  4 Apr 2024 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfDQu68w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B292757F3;
	Thu,  4 Apr 2024 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225590; cv=none; b=JlzspX1Mze5aaLXc4mopIjJ3FdvBWrKiQBmyOWd1XX2R8/5z0gxQgFTs1kFSU38Y+eEtZsCuSeWaTY6JtSFqlwWcA12oyQxK9zkS6uKyj29FO3r0PclM5GALThQWca7idvxWLXL0BHrQ5a+2Fr282Jx3nZeHgONmztsaQxL+RvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225590; c=relaxed/simple;
	bh=ov/eEmo4hI8DNy7UxuewIgS81uubOwPI939mMAuO5Sk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=CmsHOLG7MF4kVJ1tGuDwFJvQqePR5vBUfv6DtKT0GpdIgVEN1paqMQvsvOpB62I8R7kbyAEw+n14QGXxCEyGJBnMYm0XIEc1TI12yqlA5MCe4NlI/FXnLqB57nUPaog6HuNQks97N+FXRDf9nP3g8/4OwYOZBRXTdgEiN7vKc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfDQu68w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28935C433C7;
	Thu,  4 Apr 2024 10:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712225590;
	bh=ov/eEmo4hI8DNy7UxuewIgS81uubOwPI939mMAuO5Sk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=MfDQu68wdj0+Gt+hGh32IxxTl+2WxdimEZwggEOKt4TcerYqgIs/eEf1y6z++L3NR
	 Nodp/ttcxthuQywCuam2suW5SiThDG1zKQBP+68eojlP7PLA77Gy9zrjVHLGWHVxqQ
	 4W/vQbgCin/d6bjG2gkHD/bBnyRZ1HOcEpfb1xOhJGvciXiuUxqtfl7BlfqjR0Xihf
	 XQ75LqUJrRxN6K9kZ3nu9ud4+y/264FVfhgJY/Vmcn1RMBY1MxgT9ytWDn0k7ZzJn0
	 tiRhyaaaQSUFklVMUIQnjSpUC2a+wuFlgmROOtCEEwSq6uj5B03jX4lBYURxCoDzbp
	 5XDjn3h1DlZ9w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/6] wifi: ath6kl: sdio: simplify module initialization
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240329171019.63836-2-krzysztof.kozlowski@linaro.org>
References: <20240329171019.63836-2-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jeff Johnson <jjohnson@kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171222558545.1806092.4218541650720633810.kvalo@kernel.org>
Date: Thu,  4 Apr 2024 10:13:07 +0000 (UTC)

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
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

565759ce814a wifi: ath6kl: sdio: simplify module initialization

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240329171019.63836-2-krzysztof.kozlowski@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


