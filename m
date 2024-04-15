Return-Path: <linux-kernel+bounces-144456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0598A469D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544D8282E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19862EEBB;
	Mon, 15 Apr 2024 01:40:49 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1F04A24;
	Mon, 15 Apr 2024 01:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713145248; cv=none; b=oJxNK/CJKGrd/h76PjuBj4K8QE1qaDLLNCIe+gwwBBVRMdOxzaWZNhsI6pxQOatpW33OB7U/JCCso+phzjXUMWSAZvOhVwAWdRSj2c85ES1PmLCIMCsfz17hmm2ECYoW9AMe6SOa6VSzMYvwYENd2Xm/8jEyHlrUfdhYeJXkaf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713145248; c=relaxed/simple;
	bh=lXdfsGfgotLLO50LFk07pF+S4dOEgekodX79SNpZ+0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AAWz02PJxntd1gBeiWEtmaQDKL5cevU+HsrxRbJEpzZ7Ye9jQOJwtsZR5isJLvPIonqK48z5OH1MuTxCFSUUDKF1fsOm2FDyk1SWC5xRcv6Grhj0gRa6tun611bktFUr79pH2uuDCdylQdwG2KiggO4EkSbDfdWC/BVkygKGUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43F1eboiF375695, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43F1eboiF375695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 09:40:37 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 09:40:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 09:40:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 15 Apr 2024 09:40:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Lewis Robbins <lewis.robbins2@gmail.com>
CC: Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: reduce failed to flush queue severity
Thread-Topic: [PATCH] wifi: rtw88: reduce failed to flush queue severity
Thread-Index: AQHajfcTVqg9i2byzkGmq7L8YOsC/LFojyVQ
Date: Mon, 15 Apr 2024 01:40:36 +0000
Message-ID: <694ac10692114ed8838909df5010687a@realtek.com>
References: <20240413230030.390563-2-lewis.robbins2@gmail.com>
In-Reply-To: <20240413230030.390563-2-lewis.robbins2@gmail.com>
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

Lewis Robbins <lewis.robbins2@gmail.com> wrote:
>=20
> Reduce the log message severity when we fail to flush device priority
> queue. If a system has a lot of traffic, we may fail to flush the queue
> in time. This generates a lot of messages in the kernel ring buffer. As
> this is a common occurrence, we should use dev_info instead of dev_warn.
>=20
> Signed-off-by: Lewis Robbins <lewis.robbins2@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

I'd like to know situations of " If a system has a lot of traffic...".=20
Did you scan or do something during traffic?


