Return-Path: <linux-kernel+bounces-146137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 921D78A613B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD36281AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E074A14A82;
	Tue, 16 Apr 2024 02:58:15 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E0CAD55;
	Tue, 16 Apr 2024 02:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713236295; cv=none; b=YzCQPbyGCA99l5ZoQR9r9sJb2NrFd+eBs+0Ejwb5njnrQDH86pOTjqmr2HdMK0EwH7E7GEO51AhoTlz3Ai5XNDYy09QhAtm/Iuo66xU+PmJNVPDUyzbwYaXGaHFK/oW3Eia4l1mcX0qE/4uUIK3NZJEmVOGAsO6KUpB9inLob/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713236295; c=relaxed/simple;
	bh=kzzxL8PRi1kwcNbGM6+YW9/lhovKhqh+OMOd+UnQukc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sFleOUokJ0JCd0HKbczeqqSek+K8d4NZ3f547qWkXLJpLn9UKbIcFLgN1RE6JCc+9W60+fn8fEMFd3h0Ej9a5F7lOKS1oqzHuVG9qMi3LL0eim3IROTFc8Ev0ifYeq+dFKdUSQlv5PxhWMt4DViVTURihyXFjNdY3LP6x0IxuGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43G2vvlK71765271, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43G2vvlK71765271
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 10:57:57 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 10:57:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 10:57:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 16 Apr 2024 10:57:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Lewis Robbins <lewis.robbins2@gmail.com>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: reduce failed to flush queue severity
Thread-Topic: [PATCH] wifi: rtw88: reduce failed to flush queue severity
Thread-Index: AQHajfcTVqg9i2byzkGmq7L8YOsC/LFojyVQgAD1gD3///KZAIAAvNSw
Date: Tue, 16 Apr 2024 02:57:57 +0000
Message-ID: <d03e8c066a6e464aa61badb252c32b01@realtek.com>
References: <87le5ey52e.fsf@kernel.org>
 <20240415232837.388945-2-lewis.robbins2@gmail.com>
In-Reply-To: <20240415232837.388945-2-lewis.robbins2@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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
> Ping-Ke Shih <pkshih@realtek.com> writes:
>=20
> > Lewis Robbins <lewis.robbins2@gmail.com> wrote:
> >>
> >> Reduce the log message severity when we fail to flush device priority
> >> queue. If a system has a lot of traffic, we may fail to flush the queu=
e
> >> in time. This generates a lot of messages in the kernel ring buffer. A=
s
> >> this is a common occurrence, we should use dev_info instead of dev_war=
n.
> >>
> >> Signed-off-by: Lewis Robbins <lewis.robbins2@gmail.com>
> >
> > Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> >
> > I'd like to know situations of " If a system has a lot of traffic...".
> > Did you scan or do something during traffic?
>=20
> So, after digging a bit more, it seems you're right this only happens dur=
ing a
> scan. The log message itself is repeated about 5-10x.

That is the same as my test before.=20

>=20
> I'm not sure as to the cause. If the flush operation takes a long time do=
 we
> need to release any mutexes etc? And if this is just a hardware issue, th=
en we
> can do a debug print as you say.

The cause is because packets in hardware TX queue that can't be sent out in=
 time,
and flush ops with 'drop =3D false', so driver throws one warning. I don't =
have
good idea for now. Maybe, we can add a special debug mask to replace this k=
ind of
verbose warning with uncertain solution.=20



