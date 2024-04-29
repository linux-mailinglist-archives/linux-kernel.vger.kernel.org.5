Return-Path: <linux-kernel+bounces-161675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEB38B4F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3B51C2114D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AE51FC8;
	Mon, 29 Apr 2024 01:50:04 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22087F;
	Mon, 29 Apr 2024 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714355403; cv=none; b=n+a2Jeo1Zp3efjRRQjiI5FYvxiYFaKrJieT76xwYaL56lTIA7WAdzlaRPHGQsjvUKY6xVNM/XqR0KhN83WOJX8Pu04Rd90cKQZz88/R/9zJP0tBa4lccf1Dl8h0vvrYBFTXrcVU2llxvIC3CNLxwtmbKKdTmqSNfIaGy6onoBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714355403; c=relaxed/simple;
	bh=ZF3OHqE3LGxORDciO6t7lywG5M3bqqkfQNxmWq+mvvE=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=N23Fv1mqaY5Vh6+MEkJkjHwWDQuzkiLgwjhlGqs7RVC/cHuaBVUBUXzLoifAK7GffCdLwZ9gvg+ezOSLf4wAOWmm1w0oDDGL44iQdr16laqWeRKVsfZZofQehEHnnP4UW49zKCf8mO6Pq0a+YwrTgPJxdPwILvy78zyp3LyWp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43T1npkY72921824, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43T1npkY72921824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 09:49:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 09:49:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Apr
 2024 09:49:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Colin Ian King <colin.i.king@gmail.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        Su Hui
	<suhui@nfschina.com>, <linux-wireless@vger.kernel.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] wifi: rtlwifi: rtl8723be: Make read-only arrays static const
In-Reply-To: <20240425155733.114423-1-colin.i.king@gmail.com>
References: <20240425155733.114423-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <6931b0a7-901f-4a70-9c9b-0bc7871200f9@RTEXMBS04.realtek.com.tw>
Date: Mon, 29 Apr 2024 09:49:50 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Colin Ian King <colin.i.king@gmail.com> wrote:

> Don't populate the read-only arrays cck_rates, ofdm_rates, ht_rates_1t and
> channel_all on the stack at run time, instead make them static const and
> clean up the formatting.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

ed403e86c826 wifi: rtlwifi: rtl8723be: Make read-only arrays static const

---
https://github.com/pkshih/rtw.git


