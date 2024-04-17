Return-Path: <linux-kernel+bounces-147831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD278A7A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF68B1F2207B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605DA7462;
	Wed, 17 Apr 2024 01:43:08 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345863A9;
	Wed, 17 Apr 2024 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713318188; cv=none; b=U6xQli4V3ulIsrWO7Hyk78P5fqXPlXAx1LuY4lXQXI8f2p19Tvfg/HlTJCLkzkmJ7HmB5pmp3YPdkbjEwfMymmMoIdSJfWgr/XbGSEZ8pjmFZfYYqrq4oiRrMMnC9edZ/B+qlE24KNRkAu4UgfSB/cAnCrJs6hxjgjJlyb9SvXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713318188; c=relaxed/simple;
	bh=E299Tf6plxJS+Bo+S9eKwsp6tZxR9yPGTVMOumjJlSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=deOlRw4WalJ+MRYORmgq9IquWxvntadQXVnOL/HnpvYO0VHPpuD+UlJq2PXUJcuDNhi1fSW0j8mIrvLBE6mzsHe4HiQ4xP/xxrDRs5tTbAA0zCC7e7CXkoWKAlH1bvH3XYW1x56V7feQ1D7AiL71sdwZwN8Rc6g34PX9ovGGDlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43H1gwUB32821260, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43H1gwUB32821260
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 09:42:58 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 09:42:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 09:42:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 17 Apr 2024 09:42:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Lewis Robbins <lewis.robbins2@gmail.com>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: reduce failed to flush queue severity
Thread-Topic: [PATCH] wifi: rtw88: reduce failed to flush queue severity
Thread-Index: AQHajfcTVqg9i2byzkGmq7L8YOsC/LFojyVQgAD1gD3///KZAIAAvNSwgAGAkvA=
Date: Wed, 17 Apr 2024 01:42:56 +0000
Message-ID: <3c6c78248b4144509d733d610991e921@realtek.com>
References: <87le5ey52e.fsf@kernel.org>
 <20240415232837.388945-2-lewis.robbins2@gmail.com>
 <d03e8c066a6e464aa61badb252c32b01@realtek.com>
In-Reply-To: <d03e8c066a6e464aa61badb252c32b01@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>=20
> The cause is because packets in hardware TX queue that can't be sent out =
in time,
> and flush ops with 'drop =3D false', so driver throws one warning. I don'=
t have
> good idea for now. Maybe, we can add a special debug mask to replace this=
 kind of
> verbose warning with uncertain solution.

I have made a patch [1] as mentioned before. Lewis, please give it a try.

[1] https://lore.kernel.org/linux-wireless/20240417014036.11234-1-pkshih@re=
altek.com/T/#u


