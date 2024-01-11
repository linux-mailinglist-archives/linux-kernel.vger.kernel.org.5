Return-Path: <linux-kernel+bounces-23566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CC582AE7A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B4928272B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BF115ADC;
	Thu, 11 Jan 2024 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oTHMTNT0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC8B156F1;
	Thu, 11 Jan 2024 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704975069;
	bh=JoNVGy3prTtj6KB8xH3XbN107wiiB9Z+sGXeVeLEWtg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oTHMTNT0Xdpc9FO1L4NFQrlq5l+F8LDpvvgjPO1Yx930x1m0v52PbMHWT80m8yAI5
	 wNfnvRzOE5OeF47cH43rXVc3Vai32YTeJjbhEHdiMaAknl6Zd/ZDEO4D/IqDa5bzzN
	 89nx748fV8VIXMc0+Z2DOdLcTUVmPsGmccZ/CNLyqYlQXx/9X96R2NLfvJRQKfkFVf
	 7t2W4PSG63mKdLtn9HvmuggSnIG0OqIewhS4gXg06pVUnNX17g2ZCTYnxTDnBjMFGr
	 iDT2N1vN50tq9JGgy+Tsmsh9//keZyGD9X548nxJ1mwDIDdE86FBKwcNwBXJIkQysc
	 GPRsjxqHOAHGw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 790CA3781FCD;
	Thu, 11 Jan 2024 12:11:08 +0000 (UTC)
Message-ID: <c5491483-8d34-498e-a82e-8f77b5c69a37@collabora.com>
Date: Thu, 11 Jan 2024 13:11:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pstore/ram: Register to module device table
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Kees Cook <keescook@chromium.org>
Cc: kernel@collabora.com, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Tony Luck <tony.luck@intel.com>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240110210600.787703-1-nfraprado@collabora.com>
 <20240110210600.787703-2-nfraprado@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240110210600.787703-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 10/01/24 22:05, Nícolas F. R. A. Prado ha scritto:
> Register the compatible for this module on the module device table so
> it can be automatically loaded when a matching DT node is present,
> allowing logging of panics and oopses without any intervention.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



