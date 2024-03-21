Return-Path: <linux-kernel+bounces-109837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B2885650
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A58282B55
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AAF44C9B;
	Thu, 21 Mar 2024 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="oXA4lNj1"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F220326;
	Thu, 21 Mar 2024 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711012831; cv=none; b=pPag0es7u9nezeBZfdqJW7GBUhAUghFMKlDZz5HB1l35zlkytwtx0GJIxLAcT0lglLLa3eAYvOWN8yNkEr/CYQJGUqJgeNdsawnX2K4Ndq4Sg5m0HiaZzu2LGLl/avgusy1iNvJ+dpELTJPnRH9jEBXUuQ9vKK1SQDcAVqg2Ygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711012831; c=relaxed/simple;
	bh=tgiiZuGtuUlJKNeJLR3fyE1KgyZ0B2GEPWyE4RXlKF4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cZyNJmaA19pV3X9klV4dbUzHOMfDjooWWu+c/+EDun8oKtFA6WY4HmROHhObjl7pjcNzTo4jR/fXHRPsCpJ2I2ii2v8EODo7CeHAxFU2XNmmIxI0qFt7TubylryG/91pA+fvRcPPuyVDs58DGTsRCICn2w/VYH8DoYHWAEZa9ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=oXA4lNj1; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 0F92F1500A63;
	Thu, 21 Mar 2024 12:20:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 0F92F1500A63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1711012827; bh=tgiiZuGtuUlJKNeJLR3fyE1KgyZ0B2GEPWyE4RXlKF4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=oXA4lNj1d6mFFkvv9o7B3d/XAIHjpFU6/obACmhPfoUgCi+yKk81CuB6Quk+2PUN2
	 o3MLkd45mXUeHa3kjANK4hS6uFyxoiDCgoRqKVsssTDmDqaUEnCHofi48U7L5LFLHR
	 sReTOD87SkE+eKEiAxIEuVynTG9VGjKT/dr+Wz5c=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id 0C1C831906E0;
	Thu, 21 Mar 2024 12:20:27 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Guillaume Nault
	<gnault@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "Michal
 Ostrowski" <mostrows@earthlink.net>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [lvc-project] [PATCH 5.15/5.10/5.4/4.19 0/1] pppoe: Fix memory
 leak in pppoe_sendmsg()
Thread-Topic: [lvc-project] [PATCH 5.15/5.10/5.4/4.19 0/1] pppoe: Fix memory
 leak in pppoe_sendmsg()
Thread-Index: AQHae2/2z5M9RYxR80KDHqxv8N3w3bFBuNkA
Date: Thu, 21 Mar 2024 09:20:26 +0000
Message-ID: <abf90a29-33ec-40a0-a386-0f2a36b39bf4@infotecs.ru>
References: <20240321091256.467553-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20240321091256.467553-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <222D597251679049B45BD513401BC5A7@infotecs.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2024/03/21 07:23:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/03/21 04:23:00 #24331522
X-KLMS-AntiVirus-Status: Clean, skipped

T24gMy8yMS8yNCAxMjoxMiwgR2F2cmlsb3YgSWxpYSB3cm90ZToNCj4gc3l6Ym90IHJlcG9ydHMg
YSBtZW1vcnkgbGVhayBpbiBwcHBvZV9zZW5kbXNnIGluIDYuNiBhbmQgNi4xIHN0YWJsZQ0KPiBy
ZWxlYXNlcy4gVGhlIHByb2JsZW0gaGFzIGJlZW4gZml4ZWQgYnkgdGhlIGZvbGxvd2luZyBwYXRj
aCB3aGljaCBjYW4gYmUNCj4gY2xlYW5seSBhcHBsaWVkIHRvIHRoZSA2LjYgYW5kIDYuMSBicmFu
Y2hlcy4NCj4gDQo+IEZvdW5kIGJ5IEluZm9UZUNTIG9uIGJlaGFsZiBvZiBMaW51eCBWZXJpZmlj
YXRpb24gQ2VudGVyDQo+IChsaW51eHRlc3Rpbmcub3JnKSB3aXRoIFN5emthbGxlcg0KPiANCj4g
R2F2cmlsb3YgSWxpYSAoMSk6DQo+ICAgIHBwcG9lOiBGaXggbWVtb3J5IGxlYWsgaW4gcHBwb2Vf
c2VuZG1zZygpDQo+IA0KPiAgIGRyaXZlcnMvbmV0L3BwcC9wcHBvZS5jIHwgMjMgKysrKysrKysr
LS0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxNCBk
ZWxldGlvbnMoLSkNCj4gDQoNCkknbSBzbyBzb3JyeS4gSSBtZWFudCB0aGUgYnJhbmNoZXMgNS4x
NSwgNS4xMCwgNS40LCA0LjE5Lg0K

