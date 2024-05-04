Return-Path: <linux-kernel+bounces-168445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626B08BB8B3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D67FB214C5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD0F139E;
	Sat,  4 May 2024 00:26:07 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB8A21;
	Sat,  4 May 2024 00:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714782366; cv=none; b=PZz5dAXAduhJrCPbD0h6Aq8z0v2LLg5cbIiCyL8YdKg9dUqlCyvLCyb/JwwHZpEp+xFujQ+v+/cD0ol+UgM4giIVELCr/6F7T0731eOQpUFAhvsB7Vu0B6d23pvxfgYc7JoamBFOvhwluRnyEwvchqc/WEheFh+Ig+b9IkoBL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714782366; c=relaxed/simple;
	bh=MafHGzBt7sHBW52cHcX1MvDfWRB49BMtHDwyiMLLT7o=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=FvnYOhSvO1kdtJ7suqjK6Rj80g7fGLK6VnIdBH1Yf09g41eMFY625QNMBH5nRZBu9DdEjCn8cWgvNGV0fj0ayivFblzREpGfjNagdz+wscBU7sfjJocMQUdkC1n32Zw+8oeXrbCWLU/0RhQHLwtrH0T8c5rC44Mqfjjw9o09lIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4440PveoE4012706, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4440PveoE4012706
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 May 2024 08:25:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 4 May 2024 08:25:58 +0800
Received: from [127.0.1.1] (172.16.16.175) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 4 May
 2024 08:25:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ping-Ke Shih
	<pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Gustavo
 A. R. Silva" <gustavoars@kernel.org>,
        <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH][next] wifi: rtlwifi: Remove unused structs and avoid multiple -Wfamnae warnings
In-Reply-To: <ZjLFIa31BGPVCGh1@neat>
References: <ZjLFIa31BGPVCGh1@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <9558c2de-8d43-44bd-a9f6-b557391fd1c7@RTEXMBS04.realtek.com.tw>
Date: Sat, 4 May 2024 08:25:57 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> So, remove unused structs and fix the following
> -Wflex-array-member-not-at-end warnings:
> 
> drivers/net/wireless/realtek/rtlwifi/btcoexist/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/realtek/rtlwifi/rtl8188ee/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/realtek/rtlwifi/rtl8192c/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/realtek/rtlwifi/rtl8192ce/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/realtek/rtlwifi/rtl8192cu/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/realtek/rtlwifi/rtl8192de/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/realtek/rtlwifi/rtl8192ee/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/realtek/rtlwifi/rtl8192se/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/realtek/rtlwifi/rtl8723ae/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/realtek/rtlwifi/rtl8723be/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/realtek/rtlwifi/rtl8723com/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/realtek/rtlwifi/rtl8821ae/../wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/realtek/rtlwifi/wifi.h:1063:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

b3e11ee3b97e wifi: rtlwifi: Remove unused structs and avoid multiple -Wfamnae warnings

---
https://github.com/pkshih/rtw.git


