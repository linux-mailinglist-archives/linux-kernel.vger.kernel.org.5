Return-Path: <linux-kernel+bounces-165732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DB98B9057
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D5128493B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0361635DD;
	Wed,  1 May 2024 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEHp1xyc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4350A161933;
	Wed,  1 May 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593633; cv=none; b=Nv0j/zuOraKTEFEqG/oQG8bKaYmETLX/FqW1g1trlR0I2LEFANjuSEhvH7A7kCD4EjErNRHZ9wYQIpfab8gpAxt+JLQcUI8v1gtz/WZ6qCUFh5HH2Wtk597z9L7xbhXvrxm2hURhfOoBCyT7XsbNbFvEurqrEMwvEmsyXKGYQ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593633; c=relaxed/simple;
	bh=x+afZ/lBvkh7G/V9CHNvY+KNspnxVj0aXOOymsZmFKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B8Vs/a2Uy+jMgjotAuNo8dqXqs6NkuU8S0PTUoawGlFsAn4MGfupKo57VX2RwzZLuCwMHxgaaNORbl0tGJj2x+bNiEdFgqsN+F/UrCOTVTizahiM3WFKduAzltB6tDdxRMIwuqoHIBrUqG6DLN/j8hUAz/v+4xlAHerWqAMkNII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEHp1xyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E66D5C4AF1D;
	Wed,  1 May 2024 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714593632;
	bh=x+afZ/lBvkh7G/V9CHNvY+KNspnxVj0aXOOymsZmFKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TEHp1xyceYq23j/TFHAjRwhtY8OyvOvQZ4QUfhZ2nvQsAbMF8pP+prbAJDkcNgBJZ
	 COPklfwtfzEwfKOeG5uUyDRv9xE7aeH13IBHBllgE5cfYa6A9V499DyY9cVf9N415a
	 kcWfXwBb88BHSQSGgWALnR0qG+MHUXfmy95PEhgpjUUyb0/QdxX2tXKx/2EafjEqnW
	 Qeo/Hu3+RKDR+LKMj5ifOBaRDriQcd73jOJf2QOeLpCofyB+WEk7vRGiY8oj4Z7T20
	 JV+LOmrp9JeEAXo4Vhh5AnHspmvHJZub84RYf5aDGPLg6WThKIgBz55eOEgNwNE47x
	 up2056Ful3h5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB52FC433A2;
	Wed,  1 May 2024 20:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] Bluetooth: hci_conn: Use struct_size() in
 hci_le_big_create_sync()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171459363289.6729.5344742999194693596.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 20:00:32 +0000
References: <ZjKFWg0f9uU5jxaI@neat>
In-Reply-To: <ZjKFWg0f9uU5jxaI@neat>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 1 May 2024 12:09:30 -0600 you wrote:
> Use struct_size() instead of the open-coded version. Similarly to
> this other patch[1].
> 
> Link: https://lore.kernel.org/linux-hardening/ZiwwPmCvU25YzWek@neat/ [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  net/bluetooth/hci_conn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] Bluetooth: hci_conn: Use struct_size() in hci_le_big_create_sync()
    https://git.kernel.org/bluetooth/bluetooth-next/c/7bbc06151f36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



