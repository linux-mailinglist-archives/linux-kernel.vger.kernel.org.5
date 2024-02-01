Return-Path: <linux-kernel+bounces-47953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D968845524
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D0B282B00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEB815B969;
	Thu,  1 Feb 2024 10:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lwq0jZUI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419A4DA06;
	Thu,  1 Feb 2024 10:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782876; cv=none; b=MNQ79MMmxh8WyHRpnBYRPdDIUPN2mQ03gGreHCl3a9tO7D45H/N4l3EcWs3B2CMMNSfCFrfRRWa46/VB8sV1KfNECQ7jawnfPluUtt9n8rCUaaTuNB4Fz6d+803HuRXOCARJA9wfCQzOMGdV8XHMBRztc1CLcWxbRCYbMP7MCbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782876; c=relaxed/simple;
	bh=p7kLDUFLd7rjovPMsYMtGm/nnUJKbjK4ZofGZ628x0I=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=MQbJNXTJtzCSPJ0ICGT6PfBzZV8sCf/FX4ydWvZ7C0zt3ZZ5QW6hnt1Q4UJ+SwU0UbEg2N5p97q7QyN+nWgnItV3+BwmdObrr3J+ExuNJYyMsyBmNP+b9iEhGcc4oZbeNHvqvIJxn6g6NN0o4okqK3dQB0m06Yuc+BjUq7uabW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lwq0jZUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706CAC433F1;
	Thu,  1 Feb 2024 10:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706782876;
	bh=p7kLDUFLd7rjovPMsYMtGm/nnUJKbjK4ZofGZ628x0I=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Lwq0jZUI+6qSM0K9t6B8VaFbzBEYKAf0CywnG68NDwn/9EZFB+Xa3pCdh54PhW3dd
	 rofkx03iV1nGm++sTu6iazQGTtQ7npoh15RYzhkEzEnx63FSA7pp0XoROeAef74ggx
	 nxRatuZgZWcy76gncBOF56OxJKTNd57vqiN6fsE7Bdb6dC67UX+hgMUNpOLZAs9K2i
	 0D/c0U2gszkQ4U3nYAl/+kJjPVA1XisknsRx7AdtVrk/PEKoZjQfb9bdLnyw6T8WfQ
	 fXxFrjEb68ZosiRNILjvnjKvN37oR6qz3LRdW1zE7zMmTFDY/PwHKOxE+4WDE67+XI
	 bf2EX0rXdtjQg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtl8xxxu: fix error messages
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <7b144531-a8da-4725-8911-9b614a525a35@moroto.mountain>
References: <7b144531-a8da-4725-8911-9b614a525a35@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Martin Kaistra <martin.kaistra@linutronix.de>,
 Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170678287278.2736043.14378506532887522258.kvalo@kernel.org>
Date: Thu,  1 Feb 2024 10:21:14 +0000 (UTC)

Dan Carpenter <dan.carpenter@linaro.org> wrote:

> The first parameter of WARN_ONCE() is a condition so this code will end
> up printing the function name instead of the proper message.
> 
> Fixes: 3ff7a05996f9 ("wifi: rtl8xxxu: support setting bssid register for multiple interfaces")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

17903a283593 wifi: rtl8xxxu: fix error messages

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/7b144531-a8da-4725-8911-9b614a525a35@moroto.mountain/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


