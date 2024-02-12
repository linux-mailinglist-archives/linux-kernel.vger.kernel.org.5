Return-Path: <linux-kernel+bounces-61155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A7A850E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E239C282DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13D979C0;
	Mon, 12 Feb 2024 07:38:47 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4ADC150
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707723527; cv=none; b=SWz31n4AgM5zB2P/fwzvBtyspAcCi8OuzCNpHhdy9w6viBV6ijFdeRuHmZzvdinRa5ZNBOKYlUTiw/0UnAg0uSZPfv+zpDhzw84A503o22CTWwD4i3TvNYZ6/MpZ1p3B4JwacYStyK2c44iT64WFYJfr21foN1c3TyzrutIl3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707723527; c=relaxed/simple;
	bh=FigE62JX/OeXrjTZIh7MuQuZYdUvwgsQcRD4D5JtcTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RPIJbS9aZmfx5njTUbXtIW9SewGzQKt4gCGsI+720HE04c4AUjw7Qo6Vq57pYs74TVUa3IoUTLjKp9teSW2qwdl38BaWDk1ppZZCr20sUrAwPljzuaXOq4rJhKNV7WBMIdrnIAud6wOT9VyeuMM5BdVGNPDzxihD066H9tF7wtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <D.Dulov@aladdin.ru>
To: Jeffrey E Altman <jaltman@auristor.com>, "linux-afs@lists.infradead.org"
	<linux-afs@lists.infradead.org>
CC: Marc Dionne <marc.dionne@auristor.com>, David Howells
	<dhowells@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH] afs: Increase buffer size in afs_update_volume_status()
Thread-Topic: [PATCH] afs: Increase buffer size in afs_update_volume_status()
Thread-Index: AQHaXPuqoQZ0g67VpUCtyMu+H/b2+rEFMfyAgAEdl3A=
Date: Mon, 12 Feb 2024 07:38:36 +0000
Message-ID: <1411e4fb5b8c4f2084ac3f8f0509767c@aladdin.ru>
References: <20240211150442.3416-1-d.dulov@aladdin.ru>
 <735172b1-1267-43e7-a2af-8596d849760a@auristor.com>
In-Reply-To: <735172b1-1267-43e7-a2af-8596d849760a@auristor.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGVsbG8hDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4gWWVzLCBpZGJ1ZltdIHNob3VsZiBi
ZSAyMCBpbnN0ZWFkIG9mIDE5LiBJJ2xsIHNlbmQgdGhlIGNvcnJlY3QgcGF0Y2ggaW4gYSBtaW51
dGUuDQoNCkRhbmlpbCBEdWxvdg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBKZWZmcmV5IEUgQWx0bWFuIFttYWlsdG86amFsdG1hbkBhdXJpc3Rvci5jb21dIA0KU2VudDog
U3VuZGF5LCBGZWJydWFyeSAxMSwgMjAyNCA4OjI0IFBNDQpUbzogRGFuaWlsIER1bG92IDxELkR1
bG92QGFsYWRkaW4ucnU+OyBsaW51eC1hZnNAbGlzdHMuaW5mcmFkZWFkLm9yZw0KQ2M6IE1hcmMg
RGlvbm5lIDxtYXJjLmRpb25uZUBhdXJpc3Rvci5jb20+OyBEYXZpZCBIb3dlbGxzIDxkaG93ZWxs
c0ByZWRoYXQuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbHZjLXByb2plY3RA
bGludXh0ZXN0aW5nLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gYWZzOiBJbmNyZWFzZSBidWZm
ZXIgc2l6ZSBpbiBhZnNfdXBkYXRlX3ZvbHVtZV9zdGF0dXMoKQ0KDQpPbiAyLzExLzIwMjQgMTA6
MDQgQU0sIERhbmlpbCBEdWxvdiB3cm90ZToNCj4gVGhlIG1heCBsZW5ndGggb2Ygdm9sdW1lLT52
aWQgdmFsdWUgaXMgMjAgY2hhcmFjdGVycy4NCj4gU28gaW5jcmVhc2UgaWRidWZbXSBzaXplIHVw
IHRvIDIwIHRvIGF2b2lkIG92ZXJmbG93Lg0KPg0KPiBGb3VuZCBieSBMaW51eCBWZXJpZmljYXRp
b24gQ2VudGVyIChsaW51eHRlc3Rpbmcub3JnKSB3aXRoIFNWQUNFLg0KPg0KPiBGaXhlczogZDJk
ZGM3NzZhNDU4ICgiYWZzOiBPdmVyaGF1bCB2b2x1bWUgYW5kIHNlcnZlciByZWNvcmQgY2FjaGlu
ZyANCj4gYW5kIGZpbGVzZXJ2ZXIgcm90YXRpb24iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5paWwg
RHVsb3YgPGQuZHVsb3ZAYWxhZGRpbi5ydT4NCj4gLS0tDQo+ICAgZnMvYWZzL3ZvbHVtZS5jIHwg
MiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvZnMvYWZzL3ZvbHVtZS5jIGIvZnMvYWZzL3ZvbHVtZS5jIGluZGV4
IA0KPiBmODQxOTRiNzkxZDMuLjlkMGRhMzhiYmNmNiAxMDA2NDQNCj4gLS0tIGEvZnMvYWZzL3Zv
bHVtZS5jDQo+ICsrKyBiL2ZzL2Fmcy92b2x1bWUuYw0KPiBAQCAtMzAyLDcgKzMwMiw3IEBAIHN0
YXRpYyBpbnQgYWZzX3VwZGF0ZV92b2x1bWVfc3RhdHVzKHN0cnVjdCBhZnNfdm9sdW1lICp2b2x1
bWUsIHN0cnVjdCBrZXkgKmtleSkNCj4gICB7DQo+ICAgCXN0cnVjdCBhZnNfc2VydmVyX2xpc3Qg
Km5ldywgKm9sZCwgKmRpc2NhcmQ7DQo+ICAgCXN0cnVjdCBhZnNfdmxkYl9lbnRyeSAqdmxkYjsN
Cj4gLQljaGFyIGlkYnVmWzE2XTsNCj4gKwljaGFyIGlkYnVmWzE5XTsNCj4gICAJaW50IHJldCwg
aWRzejsNCj4gICANCj4gICAJX2VudGVyKCIiKTsNCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2guDQoN
ClRoZSBjb21taXQgbWVzc2FnZSBzYXlzIGlkYnVmW10gaXMgYmVpbmcgaW5jcmVhc2VkIHRvIDIw
IGNoYXJzIGJ1dCB0aGUgcGF0Y2ggb25seSBpbmNyZWFzZXMgaXQgdG8gMTkuDQoNClNob3VsZCBp
ZGJ1ZltdIGJlIDIwIG9yIHNob3VsZCB0aGUgY29tbWl0IG1lc3NhZ2UgYmUgYWx0ZXJlZD8NCg0K
SmVmZnJleSBBbHRtYW4NCg0KDQo=

