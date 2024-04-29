Return-Path: <linux-kernel+bounces-161673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF19B8B4F45
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9C5281FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF75E1113;
	Mon, 29 Apr 2024 01:47:26 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F7A7F;
	Mon, 29 Apr 2024 01:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714355246; cv=none; b=GEDmcz0f40m8T+yR88p9NWRqLGLsbOmwDF+GYFZYkNuVSR4wCGO2zN8hpPFyW2IvukogBM/HfYqD9DE5oYsBwtinCOYJMZnCXgl89GPYd8EgxwqmKnrxWuaHnRIWfENyOdzM/oYI25VeMkQ0UNBcJtROYdJTPTVM1J1rSiOy6Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714355246; c=relaxed/simple;
	bh=E5k7bXL7/yf1k2FhJXf1ufxhKSYWoAOa3vmuvqsCafk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=LVAcdulbSxKYklZj3wjgpn1UfyNehb259kFyOoRKQv/yhR6C9zSuUZ+/3wz01u7mNAs7unVQ6oMFuQYfyRO0aKEgori6pje+RCVSqXE+su2QcoORtIk7iY5owrrzOHOgsIJWpSberEFNZsHkCdrIhHsn1UxzDvly7PtqiQ8+nc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43T1l5Z312920517, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43T1l5Z312920517
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 09:47:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 09:47:05 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Apr
 2024 09:47:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, <pkshih@realtek.com>
CC: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jiapeng Chong
	<jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] wifi: rtw89: Remove the redundant else branch in the function rtw89_phy_get_kpath
In-Reply-To: <20240422072922.50940-1-jiapeng.chong@linux.alibaba.com>
References: <20240422072922.50940-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <6c24f3d4-0817-4ad1-8ecb-236bf6af847a@RTEXMBS04.realtek.com.tw>
Date: Mon, 29 Apr 2024 09:47:05 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> The assignment of the else and if branches is the same in the "case:
> MLO_2_PLUS_0_1RF" branch of the function rtw89_phy_get_kpath, so we
> remove it and add comments here to make the code easier to understand.
> 
> ./drivers/net/wireless/realtek/rtw89/phy.c:6406:2-4: WARNING: possible condition with no effect (if == else).
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8812
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

5eb027019fa3 wifi: rtw89: Remove the redundant else branch in the function rtw89_phy_get_kpath

---
https://github.com/pkshih/rtw.git


