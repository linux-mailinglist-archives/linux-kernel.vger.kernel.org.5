Return-Path: <linux-kernel+bounces-32753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1980F835FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BFD11C259B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0291C3A28E;
	Mon, 22 Jan 2024 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbhOMe24"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF43A8C2;
	Mon, 22 Jan 2024 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919337; cv=none; b=Jfz8mw9Obuuzx+D0/xapo6HFQbYGiGM9jdEkspoDWCm13Rs5mrSunkp/aq/l0QhiKG9eM9J3ijkfnRnDfIWZiTWlKmNnWn+Bg1xoVlydYBUzKOv1HHz2YTuLFAJfyN7EyJ3IeaS8VsCBUhkWSWyPwxGE3uso+g6Clj3W/0XoPcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919337; c=relaxed/simple;
	bh=95rHbImR/xTdye5RZNlBGJeqFbCDoI6e9sN2Lxr2wcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGPKB0CzRBvrTZfX/LtpFtRnbSoqA4PO4ogPYee+1dGH9kxnv08BnbUYbvptxbgeK9MXFx+PY7MBHKOrSr3BWB0vPDkz99huRvS5eDxnFE9YSaTcGBc2yX8qcq2VpfMJ/DHBUx2Tu/7U78p9tFGNwgMShFm41WtopfdRpKAnCIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbhOMe24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C3FC433F1;
	Mon, 22 Jan 2024 10:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705919336;
	bh=95rHbImR/xTdye5RZNlBGJeqFbCDoI6e9sN2Lxr2wcc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kbhOMe24YOTG+vzVrgXLbepwRfyTu0U3/MOGSTxTMYXHWZaWBn9a5fhsZTFCIjLrM
	 xIG1m/A16kfEOsltZWQTYn5/FbdQ/kn84qLAfjQd45GPNAmIA34qH64DlokEFH11Qn
	 MxyTqsFySR0QPCCzeq1LTOmDydGoKJM6SfIy1bZw15rR8UY8M0gRwO3iE93Cw4Wn1x
	 DYHMNKoHbk4olo9SoBhXVpZtA8b1Q4zTB1/5pkHUXkhE5nxBnOeUMcZZ8nDLG0Mhqp
	 /HCngCcyX4lr8esCDzdPv5tG4D0LwP/Ae1n6uPS1m4VCzYRUGBTu6ujKjSVwxRdVaO
	 RL6cPDAqsAjwA==
Message-ID: <069e3e67-fd93-4af4-905e-d4087a5b3153@kernel.org>
Date: Mon, 22 Jan 2024 19:28:53 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: ahci_ceva: fix error handling for Xilinx GT PHY
 support
Content-Language: en-US
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, cassel@kernel.org,
 richardcochran@gmail.com, piyush.mehta@xilinx.com, axboe@kernel.dk,
 michal.simek@amd.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com,
 Piyush Mehta <piyush.mehta@amd.com>
References: <1705604904-471889-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1705604904-471889-2-git-send-email-radhey.shyam.pandey@amd.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <1705604904-471889-2-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 04:08, Radhey Shyam Pandey wrote:
> From: Piyush Mehta <piyush.mehta@amd.com>
> 
> Platform clock and phy error resources are not cleaned up in Xilinx GT PHY
> error path. To fix introduce error label for ahci_platform_disable_clks and
> phy_power_off/exit and call them in error path. No functional change.
> 
> Fixes: 9a9d3abe24bb ("ata: ahci: ceva: Update the driver to support xilinx GT phy")
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> ---

Your patch format is strange... There is one too many "---" line here.

Other than that, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research


