Return-Path: <linux-kernel+bounces-1305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67876814D23
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C76B23264
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ED83FB14;
	Fri, 15 Dec 2023 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m35CfrNF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m35CfrNF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2473DBBE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C0821FDD0;
	Fri, 15 Dec 2023 16:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702657977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xpLu4k/OyPUz/RLNHNQNcy2kaSsAFMk/ZFX4UPOv7lo=;
	b=m35CfrNFau0XYvLPOuoM9tmPau5tT5+3ElfuomottQCbxqg5ChSUskn1TtUloOq9rbhuQn
	sk90VI5VO/VrWV6Xeg4W5XwhzubBPz2vKkf/rkk3BiC2WrpeI4wEanUu09dNiBp31tuYq7
	o7aWUzBH2yizSbA7KjSvUwkj+BmvZJM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702657977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xpLu4k/OyPUz/RLNHNQNcy2kaSsAFMk/ZFX4UPOv7lo=;
	b=m35CfrNFau0XYvLPOuoM9tmPau5tT5+3ElfuomottQCbxqg5ChSUskn1TtUloOq9rbhuQn
	sk90VI5VO/VrWV6Xeg4W5XwhzubBPz2vKkf/rkk3BiC2WrpeI4wEanUu09dNiBp31tuYq7
	o7aWUzBH2yizSbA7KjSvUwkj+BmvZJM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47B31137D4;
	Fri, 15 Dec 2023 16:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7/HOD7l/fGU3bQAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 15 Dec 2023 16:32:57 +0000
Message-ID: <20270f70-f2a6-4977-9e75-5474b0306cea@suse.com>
Date: Fri, 15 Dec 2023 17:32:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Crashes under Xen with Radeon graphics card
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 lkml <linux-kernel@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <29ceab65-4790-4015-b83c-241c35dfff08@suse.com>
 <BL1PR12MB5144541AC4318F30D2F57F27F793A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <b91dabec-8fde-4de1-abfe-1664f9607784@suse.com>
 <BL1PR12MB514451609D73B032E7FF8B3AF793A@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <BL1PR12MB514451609D73B032E7FF8B3AF793A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4ZOWJRl0YsisP82RrqFNdYTS"
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.20 / 50.00];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 HAS_ATTACHMENT(0.00)[];
	 MIME_BASE64_TEXT_BOGUS(1.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MIME_BASE64_TEXT(0.10)[];
	 MX_GOOD(-0.01)[];
	 SIGNED_PGP(-2.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_UNKNOWN(0.10)[application/pgp-keys];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,lists.freedesktop.org:email,xenproject.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=m35CfrNF
X-Spam-Score: -4.20
X-Rspamd-Queue-Id: 7C0821FDD0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------4ZOWJRl0YsisP82RrqFNdYTS
Content-Type: multipart/mixed; boundary="------------PeCYtwQpR9wAnvc09cLSGfT0";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 lkml <linux-kernel@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Message-ID: <20270f70-f2a6-4977-9e75-5474b0306cea@suse.com>
Subject: Re: Crashes under Xen with Radeon graphics card
References: <29ceab65-4790-4015-b83c-241c35dfff08@suse.com>
 <BL1PR12MB5144541AC4318F30D2F57F27F793A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <b91dabec-8fde-4de1-abfe-1664f9607784@suse.com>
 <BL1PR12MB514451609D73B032E7FF8B3AF793A@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB514451609D73B032E7FF8B3AF793A@BL1PR12MB5144.namprd12.prod.outlook.com>

--------------PeCYtwQpR9wAnvc09cLSGfT0
Content-Type: multipart/mixed; boundary="------------uccJtY91T04U06gThWB9tOK0"

--------------uccJtY91T04U06gThWB9tOK0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTUuMTIuMjMgMTc6MTksIERldWNoZXIsIEFsZXhhbmRlciB3cm90ZToNCj4gW0FNRCBP
ZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+IA0KPj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4+IEZyb206IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4+
IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMTUsIDIwMjMgMTE6MTMgQU0NCj4+IFRvOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBsa21sIDxsaW51
eC0NCj4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyB4ZW4tZGV2ZWxAbGlzdHMueGVucHJv
amVjdC5vcmc7IGFtZC0NCj4+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+IENjOiBL
b2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgUGFuLCBYaW5o
dWkNCj4+IDxYaW5odWkuUGFuQGFtZC5jb20+DQo+PiBTdWJqZWN0OiBSZTogQ3Jhc2hlcyB1
bmRlciBYZW4gd2l0aCBSYWRlb24gZ3JhcGhpY3MgY2FyZA0KPj4NCj4+IE9uIDE1LjEyLjIz
IDE3OjA0LCBEZXVjaGVyLCBBbGV4YW5kZXIgd3JvdGU6DQo+Pj4gW1B1YmxpY10NCj4+Pg0K
Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+PiBGcm9tOiBKdWVyZ2VuIEdy
b3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCi4uLg0KDQo+Pj4+IFRoZSBjcmFzaGVzIHZhcnks
IGJ1dCBvZnRlbiB0aGUga2VybmVsIGFjY2Vzc2VzIG5vbi1jYW5vbmljYWwNCj4+Pj4gYWRk
cmVzc2VzIG9yIHRyaWVzIHRvIG1hcCBpbGxlZ2FsIHBoeXNpY2FsIGFkZHJlc3Nlcy4gU29t
ZXRpbWVzIHRoZQ0KPj4+PiBzeXN0ZW0gaXMganVzdCBoYW5naW5nLCBlaXRoZXIgd2l0aCBz
b2Z0bG9ja3VwcyBvciB3aXRob3V0IGFueSBmdXJ0aGVyIHNpZ25zDQo+PiBvZiBiZWluZyBh
bGl2ZS4NCj4+Pj4NCj4+Pj4gSSBjYW4gZWFzaWx5IHJlcHJvZHVjZSB0aGUgcHJvYmxlbSwg
c28gYW55IGRlYnVnIHBhdGNoZXMgdG8gbmFycm93DQo+Pj4+IGRvd24gdGhlIHByb2JsZW0g
YXJlIHdlbGNvbWUuDQo+Pj4NCj4+PiBUaGVyZSBhcmUgc3RpbGwgbWlzc2luZyBmaXJtd2Fy
ZSByZXF1aXJlZCBmb3IgcHJvcGVyIG9wZXJhdGlvbi4gIFBsZWFzZSBmaXgNCj4+IHRoZW0g
dXAuDQo+Pg0KPj4gVGhhdCB3YXMgdGhlIHN0YXJ0aW5nIHBvaW50LCBvZiBjb3Vyc2UhDQo+
IA0KPiBBaCwgb2suICBUaGFua3MgZm9yIGNsYXJpZnlpbmcuICBXaGF0IGV4YWN0bHkgaGFw
cGVucyB3aGVuIHlvdSBnZXQgdGhpcyBjcmFzaD8gIFN5c3RlbSBoYW5nPyAgS2VybmVsIG9v
cHM/ICBJcyB0aGVyZSBhbnl0aGluZyBpbiB0aGUgZG1lc2cgd2hlbiBpdCBoYXBwZW5zPw0K
DQpBcyBJIHdyb3RlIGFib3ZlOiByYXRoZXIgZGlmZmVyZW50IGNhc2VzLiBUaGUgY3Jhc2gg
aGFwcGVucyBub3JtYWxseQ0Kd2l0aGluIDIwIHNlY29uZHMgYWZ0ZXIgdGhlIHN5c3RlbSBp
cyBjb21wbGV0ZWx5IHVwLiBJIGhhZCBvbmUgY2FzZQ0Kd2hlcmUgaXQgc3Vydml2ZWQgY2Eu
IDIgbWludXRlcy4NCg0KT25lIGV4YW1wbGU6DQoNClsgICA2NC41NDkxMTRdIEJVRzogdW5h
YmxlIHRvIGhhbmRsZSBwYWdlIGZhdWx0IGZvciBhZGRyZXNzOiBmZmZmODg4MTIxMjkxMDAw
DQpbICAgNjQuNTYyODUwXSAjUEY6IHN1cGVydmlzb3Igd3JpdGUgYWNjZXNzIGluIGtlcm5l
bCBtb2RlDQpbICAgNjQuNTczMzUyXSAjUEY6IGVycm9yX2NvZGUoMHgwMDAzKSAtIHBlcm1p
c3Npb25zIHZpb2xhdGlvbg0KWyAgIDY0LjU4NDU4OV0gUEdEIDI4MzYwNjcgUDREIDI4MzYw
NjcgUFVEIDNlNzNmNzA2NyBQTUQgM2U3MmVkMDY3IFBURSANCjgwMTAwMDAxMjEyOTEwMjUN
ClsgICA2NC42MDAyMTJdIE9vcHM6IDAwMDMgWyMxXSBQUkVFTVBUIFNNUCBOT1BUSQ0KWyAg
IDY0LjYwODk4NV0gQ1BVOiAzIFBJRDogMjA5MCBDb21tOiBraW9zbGF2ZTUgVGFpbnRlZDog
RyAgICAgICAgICAgIEUgDQo2LjcuMC1yYzUtZGVmYXVsdCAjOTc0DQpbICAgNjQuNjI2NzIx
XSBIYXJkd2FyZSBuYW1lOiBEZWxsIEluYy4gT3B0aVBsZXggOTAyMC8wUEM1RjcsIEJJT1Mg
QTI1IDA1LzMwLzIwMTkNClsgICA2NC42NDExOTNdIFJJUDogZTAzMDpjbGVhcl9wYWdlX2Vy
bXMrMHg3LzB4MTANClsgICA2NC42NTAxNjFdIENvZGU6IDQ4IDg5IDQ3IDM4IDQ4IDhkIDdm
IDQwIDc1IGQ5IDkwIGMzIGNjIGNjIGNjIGNjIDBmIDFmIDAwIDkwIA0KOTAgOTAgOTAgOTAg
OTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgYjkgMDAgMTAgMDAgMDAgMzEgYzAg
PGYzPiBhYSBjMyBjYyANCmNjIGNjIGNjIDY2IDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkw
IDkwIDkwIDkwIDkwIDkwDQpbICAgNjQuNjg3OTk2XSBSU1A6IGUwMmI6ZmZmZmM5MDA0MjA2
ZmI1MCBFRkxBR1M6IDAwMDEwMjQ2DQpbICAgNjQuNjk4Mzc4XSBSQVg6IDAwMDAwMDAwMDAw
MDAwMDAgUkJYOiBmZmZmZWEwMDA0ODRhNDAwIFJDWDogMDAwMDAwMDAwMDAwMTAwMA0KWyAg
IDY0LjcxMjc4MF0gUkRYOiAwMDAwMDAwMDAwMDUyZGMwIFJTSTogMDAwMDAwMDAwMDAwMDAw
MyBSREk6IGZmZmY4ODgxMjEyOTEwMDANClsgICA2NC43MjcxNTRdIFJCUDogMDAwMDAwMDAw
MDAwMDkwMSBSMDg6IGZmZmZlYTAwMDQ4NGE0NDAgUjA5OiBmZmZmZWEwMDA0ODRhNjAwDQpb
ICAgNjQuNzQxNDkxXSBSMTA6IDAwMDAwMDAwMDAwMDAwMDIgUjExOiAwMDAwMDAwMDAwMDAy
NDFlIFIxMjogZmZmZjg4ODNlN2QyMWQ4MA0KWyAgIDY0Ljc1NTg0M10gUjEzOiAwMDAwMDAw
MDAwMjhkODM0IFIxNDogMDAwMDAwMDAwMDAwMDkwMSBSMTU6IGZmZmZlYTAwMDQ4NGE0MDAN
ClsgICA2NC43NzAyMDddIEZTOiAgMDAwMDdmNGMyYjc5ZDI4MCgwMDAwKSBHUzpmZmZmODg4
NDA5MzgwMDAwKDAwMDApIA0Ka25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KWyAgIDY0Ljc4NjQ4
N10gQ1M6ICBlMDMwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0K
WyAgIDY0Ljc5ODAxOV0gQ1IyOiBmZmZmODg4MTIxMjkxMDAwIENSMzogMDAwMDAwMDE0ZmVm
NDAwMCBDUjQ6IDAwMDAwMDAwMDAwNTA2NjANClsgICA2NC44MTI0MTFdIENhbGwgVHJhY2U6
DQpbICAgNjQuODE3MzA4XSAgPFRBU0s+DQpbICAgNjQuODIxNjI1XSAgPyBfX2RpZV9ib2R5
KzB4MWEvMHg2MA0KWyAgIDY0LjgyODc0Nl0gID8gcGFnZV9mYXVsdF9vb3BzKzB4MTUxLzB4
NDcwDQpbICAgNjQuODM3MDY1XSAgPyBzZWFyY2hfYnBmX2V4dGFibGVzKzB4NjUvMHg3MA0K
WyAgIDY0Ljg0NTcxN10gID8gZml4dXBfZXhjZXB0aW9uKzB4MjIvMHgzMjANClsgICA2NC44
NTM4NDRdICA/IGV4Y19wYWdlX2ZhdWx0KzB4YjMvMHgxNTANClsgICA2NC44NjE3OTJdICA/
IGFzbV9leGNfcGFnZV9mYXVsdCsweDIyLzB4MzANClsgICA2NC44NzAyNzVdICA/IGNsZWFy
X3BhZ2VfZXJtcysweDcvMHgxMA0KWyAgIDY0Ljg3ODA1MF0gIHByZXBfbmV3X3BhZ2UrMHg5
Ny8weGIwDQpbICAgNjQuODg1MzA4XSAgZ2V0X3BhZ2VfZnJvbV9mcmVlbGlzdCsweDdhNC8w
eDFmNDANClsgICA2NC44OTQ2NzhdICBfX2FsbG9jX3BhZ2VzKzB4MThiLzB4MzUwDQpbICAg
NjQuOTAyMjcwXSAgPyBrdm1hbGxvY19ub2RlKzB4M2EvMHhkMA0KWyAgIDY0LjkwOTg5Ml0g
IF9fa21hbGxvY19sYXJnZV9ub2RlKzB4N2EvMHgxNDANClsgICA2NC45MTg1NDJdICBfX2tt
YWxsb2Nfbm9kZSsweGMxLzB4MTMwDQpbICAgNjQuOTI2MTQ5XSAga3ZtYWxsb2Nfbm9kZSsw
eDNhLzB4ZDANClsgICA2NC45MzMzOTldICBwcm9jX3N5c19jYWxsX2hhbmRsZXIrMHhmYS8w
eDIzMA0KWyAgIDY0Ljk0MjI1OV0gIHZmc19yZWFkKzB4MjJmLzB4MmUwDQpbICAgNjQuOTQ5
MDA3XSAga3N5c19yZWFkKzB4YTUvMHhlMA0KWyAgIDY0Ljk1NTUyN10gIGRvX3N5c2NhbGxf
NjQrMHg1ZC8weGUwDQpbICAgNjQuOTYyODA2XSAgPyBkb191c2VyX2FkZHJfZmF1bHQrMHg1
YjMvMHg4YTANClsgICA2NC45NzE2NDddICA/IGV4Y19wYWdlX2ZhdWx0KzB4NmYvMHgxNTAN
ClsgICA2NC45Nzk1ODddICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg2Zi8w
eDc3DQpbICAgNjQuOTg5ODIxXSBSSVA6IDAwMzM6MHg3ZjRjMjlmMDZhM2UNClsgICA2NC45
OTcwOThdIENvZGU6IDA4IGU4IGY0IDFlIDAyIDAwIDY2IDBmIDFmIDQ0IDAwIDAwIDkwIDkw
IDkwIDkwIDkwIDkwIDkwIDkwIA0KOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgNjQgOGIgMDQg
MjUgMTggMDAgMDAgMDAgODUgYzAgNzUgMTQgMGYgMDUgPDQ4PiAzZCAwMCBmMCANCmZmIGZm
IDc3IDVhIGYzIGMzIDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIDQxIDU0IDU1IDQ5DQpbICAg
NjUuMDM0OTYyXSBSU1A6IDAwMmI6MDAwMDdmZmQ1YTg2ZjJiOCBFRkxBR1M6IDAwMDAwMjQ2
IE9SSUdfUkFYOiANCjAwMDAwMDAwMDAwMDAwMDANClsgICA2NS4wNTAwNzFdIFJBWDogZmZm
ZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDAwMDAwMDAwMDAwMDAgUkNYOiAwMDAwN2Y0YzI5ZjA2
YTNlDQpbICAgNjUuMDY0NDE1XSBSRFg6IDAwMDAwMDAwMDAwMDQwMDAgUlNJOiAwMDAwMDAw
MDAyNTYyYzE4IFJESTogMDAwMDAwMDAwMDAwMDAwNA0KWyAgIDY1LjA3ODc3NV0gUkJQOiAw
MDAwMDAwMDAyNTYxZDYwIFIwODogMDAwMDdmNGMyYWJkMzQxOCBSMDk6IDAwMDAwMDAwMDAw
MDAwMjgNClsgICA2NS4wOTMxNTVdIFIxMDogMDAwMDAwMDAwMjUzYjAxMCBSMTE6IDAwMDAw
MDAwMDAwMDAyNDYgUjEyOiAwMDAwMDAwMDAwMDA0MDAwDQpbICAgNjUuMTA3NDkyXSBSMTM6
IDAwMDAwMDAwMDAwMDQwMDAgUjE0OiAwMDAwMDAwMDAwMDAwMDA0IFIxNTogMDAwMDAwMDAw
MjU2MmMxOA0KWyAgIDY1LjEyMTg1MF0gIDwvVEFTSz4NCg0KPiANCj4+DQo+PiBCVFcsIG1l
YW53aGlsZSBJIGhhdmUgdGVzdGVkIGtlcm5lbCA1LjE5LCB3aGljaCBpcyB3b3JraW5nLiBJ
IHN1c3BlY3RlZCB0aGF0DQo+PiB0aGUgcGF0Y2ggc2VyaWVzIG1lcmdpbmcgc3dpb3RsYiBh
bmQgc3dpb3RsYi14ZW4gY291bGQgYmUgdG8gYmxhbWUsIGJ1dCB0aGF0DQo+PiB3ZW50IGlu
dG8gdjUuMTkuDQo+IA0KPiBDYW4geW91IGJpc2VjdD8NCg0KSSBjYW4gdHJ5IHRvIGZpbmQg
dGhlIG9mZmVuZGluZyBjb21taXQsIHN1cmUuIEkganVzdCB3YW50ZWQgdG8gc2hhcmUgbXkg
Y3VycmVudA0KZmluZGluZ3MgaW4gdGhlIGhvcGUgdGhhdCBzb21lb25lIG1pZ2h0IGhhdmUg
YW4gaWRlYSAuLi4NCg0KDQpKdWVyZ2VuDQo=
--------------uccJtY91T04U06gThWB9tOK0
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------uccJtY91T04U06gThWB9tOK0--

--------------PeCYtwQpR9wAnvc09cLSGfT0--

--------------4ZOWJRl0YsisP82RrqFNdYTS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmV8f7gFAwAAAAAACgkQsN6d1ii/Ey+A
TAf9GdxH8CHk6EiuOyaumXp0epaxR5XTxuJp1Rb6UwAjibq46iHrSD5prjopAnEFbnohGEz4sEXk
9A/f1Wjip4gjQCJ+wR65hxhpAxDG3TeT/2CbhP6VubA/Av94BwtkA7cYcxlfXfPy9ycY6GhChXrj
PJoj2bqF5N07pZbCQ6oz001C+qvtgRYSkzuzU/N3CrkrDv5gKcH9e1hJ7Sr0ePNqLHhmg1iN7sN/
7MkaMdGybkVHdUHLVDZmz8XFTzLzEvZnUkhbzahYVkyjS6kXwJpjTW8+/+hQ0IkXnZVrxBAtpZQ0
A/s7aDbAR0OIlVCpysT9Dp8MX1gt1wizzDtt1WBBug==
=aREM
-----END PGP SIGNATURE-----

--------------4ZOWJRl0YsisP82RrqFNdYTS--

