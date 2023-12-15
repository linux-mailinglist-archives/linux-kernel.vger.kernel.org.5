Return-Path: <linux-kernel+bounces-1007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D22814921
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53B31C23B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F992DF72;
	Fri, 15 Dec 2023 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vl97bwl3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD732DB65;
	Fri, 15 Dec 2023 13:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A08C433C7;
	Fri, 15 Dec 2023 13:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702646677;
	bh=acvOxlDC9drbnZ2QyFlBKQ9/KOMwSqKUcu1YLFfj+Tk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Vl97bwl3sYQO7/UZ84nMpSn0Mt049qfyel7mNWtD1LbblWQZnLNA2J1AMXGBW6OYn
	 Y8+jYE7uk0wMAplsVrJ1kWNBAAc07I0cONwjDceIePsEFpqpHIhVWa7UI3+nfAWq/J
	 i9/jBFD9mN4+dyNL6KOy/MgAKYtkZV5nVVXR2ZBDce2JpTSFZ+ruXFVb9M3VFEQy0L
	 NVsTIubK+e7KbxXQRnVI9SYgbassM3MmMuUxIKVNIHygi1F+2FEdJ//CzSuzTclT+x
	 u6pEGd8Wqxhhqvq42u53+terZtbhCBUOnveR50qQpEJqY3MQs5icmoNrrOTwwjtJLY
	 SwVUYz2LORDAw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3] wifi: mwifiex: add extra delay for firmware ready
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231208234029.2197-1-yu-hao.lin@nxp.com>
References: <20231208234029.2197-1-yu-hao.lin@nxp.com>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 briannorris@chromium.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
 David Lin <yu-hao.lin@nxp.com>, stable@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170264667352.1759617.2847802413188933835.kvalo@kernel.org>
Date: Fri, 15 Dec 2023 13:24:35 +0000 (UTC)

David Lin <yu-hao.lin@nxp.com> wrote:

> For SDIO IW416, due to a bug, FW may return ready before complete full
> initialization. Command timeout may occur at driver load after reboot.
> Workaround by adding 100ms delay at checking FW status.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com> # Verdin AM62 (IW416)

Patch applied to wireless-next.git, thanks.

1c5d463c0770 wifi: mwifiex: add extra delay for firmware ready

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231208234029.2197-1-yu-hao.lin@nxp.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


