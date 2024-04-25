Return-Path: <linux-kernel+bounces-158058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD838B1AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280711C20CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C273FB9D;
	Thu, 25 Apr 2024 06:15:52 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E115A0E1;
	Thu, 25 Apr 2024 06:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025752; cv=none; b=A4otfK4afTvwq+boelwMTElmsqCdSu19W5oB1czmn60ouKeEhbC2fpo6ButRaEd6pyCPZV5VrhUiDd2D+StYbBN16LdaLOcstgHgQEx7AGEPZX0eHtukU0QVfKcSu2Ydu56C2JH79OkSgydOVzrbTUsDL23GLMdBHMGvZ9SRKWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025752; c=relaxed/simple;
	bh=1B4NCTUfAOlDuTyaNE+7fwt1AaVHLnQEj8B6nEJD4ds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tmuzTfbmMzFXy8RYbbf36AaZqHSAmKglc3kSFxQHrSAmvzNWwWwBMlVjTBvRT3isREZhCj3cX2Cb3eyGeG37PomqDG55mPELSxtxu+LCMVXZbVnjolA7UQIgdLSlbKKiyMEFSlI9jTYw/3C7p+EeWcEoMoTeWNtymh8k+ylAALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43P6FLbjC3247949, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43P6FLbjC3247949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 14:15:21 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 14:15:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 14:15:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 25 Apr 2024 14:15:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>
CC: Breno Leitao <leitao@debian.org>, "leit@meta.com" <leit@meta.com>,
        "open
 list:REALTEK WIRELESS DRIVER (rtw89)" <linux-wireless@vger.kernel.org>,
        "open
 list" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH wireless] wifi: rtw89: Un-embed dummy device
Thread-Topic: [PATCH wireless] wifi: rtw89: Un-embed dummy device
Thread-Index: AQHalnSYD4Tb/iMnEk2tnRSMUSm6/rF4e3YAgAACc82AAAD0RYAAAhhA
Date: Thu, 25 Apr 2024 06:15:21 +0000
Message-ID: <acda4194c8d44690b05b83adccb3aa22@realtek.com>
References: <20240424182351.3936556-1-leitao@debian.org>
	<f46ae94488d1468e9a9a669320e4cfb9@realtek.com>	<87ttjqgf2r.fsf@kernel.org>
 <87mspigex0.fsf@kernel.org>
In-Reply-To: <87mspigex0.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Kalle Valo <kvalo@kernel.org> wrote:
> Kalle Valo <kvalo@kernel.org> writes:
>=20
> > Ping-Ke Shih <pkshih@realtek.com> writes:
> >
> >> Breno Leitao <leitao@debian.org> wrote:
> >>> Embedding net_device into structures prohibits the usage of flexible
> >>> arrays in the net_device structure. For more details, see the discuss=
ion
> >>> at [1].
> >>>
> >>> Un-embed the net_device from the private struct by converting it
> >>> into a pointer. Then use the leverage the new alloc_netdev_dummy()
> >>> helper to allocate and initialize dummy devices.
> >>>
> >>> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> >>>
> >>> Signed-off-by: Breno Leitao <leitao@debian.org>
> >>
> >> I think this patch should go via net-next tree, because wireless-next =
tree
> >> doesn't have patch of dummy devices yet.
> >>
> >> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> >
> > FWIW I sent the wireless-next pull request yesterday and once it pulled
> > we will fast forward wireless-next to latest net-next.
>=20
> Oh, I just realised that this is not CCed to netdev so their patchwork
> won't even see the patch. Ping, I recommend that you wait for the
> dependency commits to trickle down to your tree and then apply the
> patch. That's the simplest approach and no need to resend anything.

Okay. If we don't hurry to get this patch merged, I will apply this patch
to my tree.


