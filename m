Return-Path: <linux-kernel+bounces-90433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D3086FF19
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551F41F240E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA653613A;
	Mon,  4 Mar 2024 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i1yH4fpz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98BE20323;
	Mon,  4 Mar 2024 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548344; cv=none; b=b2nWzLqCOOgIxwQDilFeHFsDx9nMOa7CJW1x7z0n/nj9+qNxiizvpQPxaonBx4oEAciM9t7LVqjy2eMxnyziIk5MH/PfCZh+WHb2hz6Jsu3GBGa8gBgTrAyngjNhiXPtEP/FsSh/Y9txmZv1j9Hw8VAzQiDgFe6wSaPMf/++qaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548344; c=relaxed/simple;
	bh=KIzJmkOsvRhcMZS0B9T7opj0yBL9GqIfatloVh3/Am4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OhTFh52lJ6mgBsNbESar+OKHzqbN9mFnVJyP3CnF5++rNfz9zoMQXd55r4GJotUpLy1Iyv71ELQSgdM6enH+/xi9KbmNs/4TyG8xw3U+BxH2XKtBXk73z8Zrdi7orn7YgfXP+ho1TI58psgNeEZVnlGCnjhjSQlepXZIPSD6FDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i1yH4fpz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709548341;
	bh=KIzJmkOsvRhcMZS0B9T7opj0yBL9GqIfatloVh3/Am4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i1yH4fpzGroY/z8eVXA2TS5zjJOZX8uHwkLqd4QP2aDIrfVAMk6u+ox/P8ACmkInH
	 p9+IVX5Wm0ndqsvmtCMLvkGSkcVaC2TqJqeSOKgVbHInYxJoMjkUVPHFFqze7Jh6kC
	 CCKpV4p5MZ850HI40/VXeiGA/wnFkuAYD+l3hMLFqFvCKZz3xz8uTK9yFL92H1vUsc
	 os61xfdUAHAb//65Ytdz4W5Q9uwPZnKgKtoH5doNvcY4yXW/Dph9xIgC3YQ4VQ0k/x
	 eLA59fSLbnxrlTp/nEF/o9+F2Gd6gmgrrrPb1vOa1mOR0ZMlHREbwv376+3DHHcN70
	 WbqldLG0XfaFA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4BD6537813CB;
	Mon,  4 Mar 2024 10:32:20 +0000 (UTC)
Message-ID: <d0ddbec4-2b08-4820-ba9e-eb1f976c7499@collabora.com>
Date: Mon, 4 Mar 2024 11:32:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: core: correct type of i
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: kernel@collabora.com, kernel-janitors@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240304090103.818092-1-usama.anjum@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240304090103.818092-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/03/24 10:01, Muhammad Usama Anjum ha scritto:
> The i should be signed to find out the end of the loop. Otherwise,
> i >= 0 is always true and loop becomes infinite. Make its type to be
> int.
> 
> Fixes: 6a9eda34418f ("mtd: spi-nor: core: set mtd->eraseregions for non-uniform erase map")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


