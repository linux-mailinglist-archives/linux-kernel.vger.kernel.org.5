Return-Path: <linux-kernel+bounces-46810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C948C844496
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84FE6290A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88DF12BE9D;
	Wed, 31 Jan 2024 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngSgmMxJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C5F12BF28;
	Wed, 31 Jan 2024 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718810; cv=none; b=JOb2Ce3vdYOAgwe6A/yXdSV4L7YxCS2lcxUK2jlQdYSEzKJ51Bg7lAJtvF45/fAjw+rR9G8J+VOpMaEFCbcYd58K6H6v1c0Xm1KBGSkRDLNtERyNxwse5aVw62f42Se4ZIoEw1D7wXY2LlemAqCdeFcUEab9uj6PwpbYr6AFH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718810; c=relaxed/simple;
	bh=dT+mfhflriLyZXo/Fge7zTtcbn+ruYw0y1jDB+v52hU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=gu2S52VFY7CRIdo0llK599m8VpaNOuJsPUWZKVpcXCQU4D64Oot1tUMs6Iaxu077ZFDL/e+aL4v/CimgHsflykmFX9b8R1/emqFPbv3VQFoDEQxEmWdqzp3ZpbqAyMA2KUMT51wO/H8TzpHl3cdFUYFaL7xpfkXJh0PxDmZB6Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngSgmMxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4899C433C7;
	Wed, 31 Jan 2024 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706718809;
	bh=dT+mfhflriLyZXo/Fge7zTtcbn+ruYw0y1jDB+v52hU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ngSgmMxJJn/FMt37UwcrRl0lCvk//DhDoy0iNvodvSaoyTqUi+fepm3L9d0/hHA21
	 CkbD0zLiteuEIrGqAYMmXaSXMSJRXg+L360aj+ZgzK5Si9EEEQDpg5ndcJedHFFrlY
	 B5Ld9jwOB/AAApJZCvbLMAhJ2fMAE9X2aU/KDLXI4IjbN8R71bzCPtnsEBEVLfzQp3
	 Yikq7thw/gZX+5nZa/QM000mBQARdjoT3cRdDBs19CU3sFS8c8ixxBnind8nPuwMrD
	 5dTz+yCEnJKAWUKBgicNnIOKwVF8Wu2p7uWoUgHEdVc8vA8iFaHEYApJ7oFMMzoT7T
	 zDHYJMuxSocrQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net 1/9] wifi: fill in MODULE_DESCRIPTION()s for wlcore
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240130104243.3025393-2-leitao@debian.org>
References: <20240130104243.3025393-2-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, weiwan@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 andrew@lunn.ch, leit@fb.com,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Kees Cook <keescook@chromium.org>, Johannes Berg <johannes.berg@intel.com>,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 Justin Stitt <justinstitt@google.com>, Li Zetao <lizetao1@huawei.com>,
 Francois Romieu <romieu@fr.zoreil.com>, Rob Herring <robh@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Ruan Jinjie <ruanjinjie@huawei.com>,
 linux-wireless@vger.kernel.org (open list:TI WILINK WIRELESS DRIVERS)
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170671880271.2431956.66127348872072392.kvalo@kernel.org>
Date: Wed, 31 Jan 2024 16:33:24 +0000 (UTC)

Breno Leitao <leitao@debian.org> wrote:

> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the TI WLAN wlcore drivers.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

9 patches applied to wireless.git, thanks.

5b778e1c2e97 wifi: fill in MODULE_DESCRIPTION()s for wlcore
2f2b503ea770 wifi: fill in MODULE_DESCRIPTION()s for wl1251 and wl12xx
257ca10c7317 wifi: fill in MODULE_DESCRIPTION()s for Broadcom WLAN
f8782ea450ad wifi: fill in MODULE_DESCRIPTION()s for ar5523
e063d2a05d71 wifi: fill in MODULE_DESCRIPTION()s for wcn36xx
714ea2f109d9 wifi: fill in MODULE_DESCRIPTION()s for p54spi
35337ac47260 wifi: fill in MODULE_DESCRIPTION()s for wl18xx
c9013880284d wifi: fill in MODULE_DESCRIPTION()s for wilc1000
f3f8f0503168 wifi: fill in MODULE_DESCRIPTION()s for mt76 drivers

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240130104243.3025393-2-leitao@debian.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


