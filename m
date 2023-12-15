Return-Path: <linux-kernel+bounces-1271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F065814CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C1D1C23A29
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E843DBAB;
	Fri, 15 Dec 2023 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="E/v4ytAb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="E/v4ytAb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE2C3DB93
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1724D1F83F;
	Fri, 15 Dec 2023 16:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702656758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yDBCRDrZr4+5hIuUyIxI8EGqZkT8EFZctCoZ2lc3E5M=;
	b=E/v4ytAbqs0i+ubbNE6wWqKkQvNlS94y0hvgx2TEL0ZCNXcmU+746XyqVFdPeCamWCTaV3
	N4QgP//AnfgVJ3YKF19ihkEjm2PoGZxHyLou75zJSHWbj7TAuivMDtfgFy0aemTmT/TrgW
	FCkctzcr6fMnjCUjlUq63qU4zY6/Dbs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702656758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yDBCRDrZr4+5hIuUyIxI8EGqZkT8EFZctCoZ2lc3E5M=;
	b=E/v4ytAbqs0i+ubbNE6wWqKkQvNlS94y0hvgx2TEL0ZCNXcmU+746XyqVFdPeCamWCTaV3
	N4QgP//AnfgVJ3YKF19ihkEjm2PoGZxHyLou75zJSHWbj7TAuivMDtfgFy0aemTmT/TrgW
	FCkctzcr6fMnjCUjlUq63qU4zY6/Dbs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D423913726;
	Fri, 15 Dec 2023 16:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9gmVMfV6fGXuZwAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 15 Dec 2023 16:12:37 +0000
Message-ID: <b91dabec-8fde-4de1-abfe-1664f9607784@suse.com>
Date: Fri, 15 Dec 2023 17:12:37 +0100
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
In-Reply-To: <BL1PR12MB5144541AC4318F30D2F57F27F793A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------n5q47dhKenDHw0thuDhdOTXj"
X-Spam-Level: *
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="E/v4ytAb"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.40 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_UNKNOWN(0.10)[application/pgp-keys];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -5.40
X-Rspamd-Queue-Id: 1724D1F83F
X-Spam-Flag: NO

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------n5q47dhKenDHw0thuDhdOTXj
Content-Type: multipart/mixed; boundary="------------uvwBTBvdMRe7VA7G0i8YDlJY";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 lkml <linux-kernel@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Message-ID: <b91dabec-8fde-4de1-abfe-1664f9607784@suse.com>
Subject: Re: Crashes under Xen with Radeon graphics card
References: <29ceab65-4790-4015-b83c-241c35dfff08@suse.com>
 <BL1PR12MB5144541AC4318F30D2F57F27F793A@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144541AC4318F30D2F57F27F793A@BL1PR12MB5144.namprd12.prod.outlook.com>

--------------uvwBTBvdMRe7VA7G0i8YDlJY
Content-Type: multipart/mixed; boundary="------------kxPE0UWCVuBdTwBgE5WHt8yy"

--------------kxPE0UWCVuBdTwBgE5WHt8yy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTUuMTIuMjMgMTc6MDQsIERldWNoZXIsIEFsZXhhbmRlciB3cm90ZToNCj4gW1B1Ymxp
Y10NCj4gDQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gRnJvbTogSnVlcmdl
biBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciAx
NSwgMjAyMyA2OjU3IEFNDQo+PiBUbzogbGttbCA8bGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZz47IHhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZzsgYW1kLQ0KPj4gZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+PiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT4NCj4+
IFN1YmplY3Q6IENyYXNoZXMgdW5kZXIgWGVuIHdpdGggUmFkZW9uIGdyYXBoaWNzIGNhcmQN
Cj4+DQo+PiBIaSwNCj4+DQo+PiBJIHJlY2VudGx5IHN0dW1ibGVkIG92ZXIgYSB0ZXN0IHN5
c3RlbSB3aGljaCBzaG93ZWQgY3Jhc2hlcyBwcm9iYWJseQ0KPj4gcmVzdWx0aW5nIGZyb20g
bWVtb3J5IGJlaW5nIG92ZXJ3cml0dGVuIHJhbmRvbWx5Lg0KPj4NCj4+IFRoZSBwcm9ibGVt
IGlzIG9jY3VycmluZyBvbmx5IGluIERvbTAgd2hlbiBydW5uaW5nIHVuZGVyIFhlbi4gSXQg
c2VlbXMgdG8NCj4+IGJlIHByZXNlbnQgc2luY2UgYXQgbGVhc3Qga2VybmVsIDYuMyAoSSBk
aWRuJ3QgZ28gYmFjayBmdXJ0aGVyIHlldCksIGFuZCBpdCBzZWVtcw0KPj4gTk9UIHRvIGJl
IHByZXNlbnQgaW4ga2VybmVsIDUuMTQuDQo+Pg0KPj4gSSB0cmFja2VkIHRoZSBwcm9ibGVt
IGRvd24gdG8gdGhlIGluaXRpYWxpemF0aW9uIG9mIHRoZSBncmFwaGljcyBjYXJkICh0aGUN
Cj4+IHByb2JsZW0gbWlnaHQgc3VyZmFjZSBvbmx5IGxhdGVyLCBidXQgYXQgbGVhc3QgYW4g
ZWFybHkgaW5pdGlhbGl6YXRpb24gZmFpbHVyZSBtYWRlDQo+PiB0aGUgcHJvYmxlbSBnbyBh
d2F5KS4NCj4+DQo+PiAjIGxzcGNpDQo+PiAwMTowMC4wIFZHQSBjb21wYXRpYmxlIGNvbnRy
b2xsZXI6IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRC9BVEldDQo+PiBDYWlj
b3MgWFRYIFtSYWRlb24gSEQgODQ5MCAvIFI1IDIzNVggT0VNXQ0KPj4gMDE6MDAuMSBBdWRp
byBkZXZpY2U6IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRC9BVEldIENhaWNv
cyBIRE1JDQo+PiBBdWRpbyBbUmFkZW9uIEhEIDY0NTAgLyA3NDUwLzg0NTAvODQ5MCBPRU0g
LyBSNSAyMzAvMjM1LzIzNVggT0VNXQ0KPj4NCj4+IEkgaGFkIGEgd29ya2luZyAuY29uZmln
IGFuZCBvbmUgd2hpY2ggZGlkIHByb2R1Y2UgdGhlIGNyYXNoZXMsIHNvIEkgbmFycm93ZWQN
Cj4+IHRoZSBwcm9ibGVtIGRvd24gdG8gZGV0ZWN0IHRoYXQgdGhlIGltcG9ydGFudCBkaWZm
ZXJlbmNlIHdhcyBpbiB0aGUgYXJlYSBvZg0KPj4gZmlybXdhcmUgbG9hZGluZyAodGhlIHdv
cmtpbmcgLmNvbmZpZyBkaWRuJ3QgaGF2ZQ0KPj4gQ09ORklHX0ZXX0xPQURFUl9DT01QUkVT
U19YWiBzZXQsIGNhdXNpbmcgZmlybXdhcmUgbG9hZGluZyBmb3IgdGhlDQo+PiBjYXJkIHRv
IGZhaWwpLiBUaGlzIHdhcyBvZiBjb3Vyc2Ugbm90IHRoZSByZWFsIHByb2JsZW0sIGJ1dCBp
dCBjYXVzZWQgdGhlIGNhcmQNCj4+IGluaXRpYWxpemF0aW9uIHRvIGZhaWwuDQo+Pg0KPj4g
SSBtYW51YWxseSBkZWNvbXByZXNzZWQgdGhlIGZpcm13YXJlIGZpbGVzIG9uZSBieSBvbmUg
dG8gc2VlIHdoZXRoZXIgdGhlDQo+PiBwcm9ibGVtIHdvdWxkIGJlIGluIHRoZSBkZWNvbXBy
ZXNzb3Igb3IgcHJvYmFibHkgaW4gdGhlIGRyaXZlciBvZiB0aGUgY2FyZC4NCj4+DQo+PiBU
aGUgbGFzdCBzdGVwIHdpdGhvdXQgY3Jhc2ggd2FzOg0KPj4NCj4+ICMgZG1lc2cgfCBncmVw
IHJhZGVvbg0KPj4gWyAgIDEwLjEwNjQwNV0gW2RybV0gcmFkZW9uIGtlcm5lbCBtb2Rlc2V0
dGluZyBlbmFibGVkLg0KPj4gWyAgIDEwLjEwNjQ1NV0gcmFkZW9uIDAwMDA6MDE6MDAuMDog
dmdhYXJiOiBkZWFjdGl2YXRlIHZnYSBjb25zb2xlDQo+PiBbICAgMTAuMjIyOTQ0XSByYWRl
b24gMDAwMDowMTowMC4wOiBWUkFNOiAxMDI0TSAweDAwMDAwMDAwMDAwMDAwMDANCj4+IC0N
Cj4+IDB4MDAwMDAwMDAzRkZGRkZGRiAoMTAyNE0gdXNlZCkNCj4+IFsgICAxMC4yNTI5MjFd
IHJhZGVvbiAwMDAwOjAxOjAwLjA6IEdUVDogMTAyNE0gMHgwMDAwMDAwMDQwMDAwMDAwIC0N
Cj4+IDB4MDAwMDAwMDA3RkZGRkZGRg0KPj4gWyAgIDEwLjI3ODI1NV0gW2RybV0gcmFkZW9u
OiAxMDI0TSBvZiBWUkFNIG1lbW9yeSByZWFkeQ0KPj4gWyAgIDEwLjI5NTgyOF0gW2RybV0g
cmFkZW9uOiAxMDI0TSBvZiBHVFQgbWVtb3J5IHJlYWR5Lg0KPj4gWyAgIDEwLjI5NTg2N10g
cmFkZW9uIDAwMDA6MDE6MDAuMDogRGlyZWN0IGZpcm13YXJlIGxvYWQgZm9yDQo+PiByYWRl
b24vQ0FJQ09TX3BmcC5iaW4gc3VjY2VlZGVkDQo+PiBbICAgMTAuMzMwODQ2XSByYWRlb24g
MDAwMDowMTowMC4wOiBEaXJlY3QgZmlybXdhcmUgbG9hZCBmb3INCj4+IHJhZGVvbi9DQUlD
T1NfbWUuYmluIHN1Y2NlZWRlZA0KPj4gWyAgIDEwLjMzMDg1OF0gcmFkZW9uIDAwMDA6MDE6
MDAuMDogRGlyZWN0IGZpcm13YXJlIGxvYWQgZm9yDQo+PiByYWRlb24vQlRDX3JsYy5iaW4N
Cj4+IHN1Y2NlZWRlZA0KPj4gWyAgIDEwLjMzMDg3MF0gcmFkZW9uIDAwMDA6MDE6MDAuMDog
RGlyZWN0IGZpcm13YXJlIGxvYWQgZm9yDQo+PiByYWRlb24vQ0FJQ09TX21jLmJpbiBmYWls
ZWQgd2l0aCBlcnJvciAtMg0KPj4gWyAgIDEwLjM4MDk3OV0gbmlfY3A6IEZhaWxlZCB0byBs
b2FkIGZpcm13YXJlICJyYWRlb24vQ0FJQ09TX21jLmJpbiINCj4+IFsgICAxMC4zODEwMDZd
IFtkcm06ZXZlcmdyZWVuX2luaXQgW3JhZGVvbl1dICpFUlJPUiogRmFpbGVkIHRvIGxvYWQN
Cj4+IGZpcm13YXJlIQ0KPj4gWyAgIDEwLjQwNTc2NV0gcmFkZW9uIDAwMDA6MDE6MDAuMDog
RmF0YWwgZXJyb3IgZHVyaW5nIEdQVSBpbml0DQo+PiBbICAgMTAuNDMyMTA3XSBbZHJtXSBy
YWRlb246IGZpbmlzaGluZyBkZXZpY2UuDQo+PiBbICAgMTAuNDM5MTc5XSBbZHJtXSByYWRl
b246IHR0bSBmaW5hbGl6ZWQNCj4+IFsgICAxMC40NjMyMDNdIHJhZGVvbjogcHJvYmUgb2Yg
MDAwMDowMTowMC4wIGZhaWxlZCB3aXRoIGVycm9yIC0yDQo+Pg0KPj4gQW5kIHdpdGggZGVj
b21wcmVzc2luZyByYWRlb24vQ0FJQ09TX21jLmJpbiBJIGdvdDoNCj4+DQo+PiAjIGRtZXNn
IHwgZ3JlcCByYWRlb24NCj4+IFsgICAxMC4yNjY0OTFdIFtkcm1dIHJhZGVvbiBrZXJuZWwg
bW9kZXNldHRpbmcgZW5hYmxlZC4NCj4+IFsgICAxMC4yNjY1NTJdIHJhZGVvbiAwMDAwOjAx
OjAwLjA6IHZnYWFyYjogZGVhY3RpdmF0ZSB2Z2EgY29uc29sZQ0KPj4gWyAgIDEwLjQ1NjA0
N10gcmFkZW9uIDAwMDA6MDE6MDAuMDogVlJBTTogMTAyNE0gMHgwMDAwMDAwMDAwMDAwMDAw
DQo+PiAtDQo+PiAweDAwMDAwMDAwM0ZGRkZGRkYgKDEwMjRNIHVzZWQpDQo+PiBbICAgMTAu
NDcwMjcwXSByYWRlb24gMDAwMDowMTowMC4wOiBHVFQ6IDEwMjRNIDB4MDAwMDAwMDA0MDAw
MDAwMCAtDQo+PiAweDAwMDAwMDAwN0ZGRkZGRkYNCj4+IFsgICAxMC41NjY5NDZdIFtkcm1d
IHJhZGVvbjogMTAyNE0gb2YgVlJBTSBtZW1vcnkgcmVhZHkNCj4+IFsgICAxMC41NzY4OTFd
IFtkcm1dIHJhZGVvbjogMTAyNE0gb2YgR1RUIG1lbW9yeSByZWFkeS4NCj4+IFsgICAxMC41
ODY5NzFdIHJhZGVvbiAwMDAwOjAxOjAwLjA6IERpcmVjdCBmaXJtd2FyZSBsb2FkIGZvcg0K
Pj4gcmFkZW9uL0NBSUNPU19wZnAuYmluIHN1Y2NlZWRlZA0KPj4gWyAgIDEwLjYxMTg4Nl0g
cmFkZW9uIDAwMDA6MDE6MDAuMDogRGlyZWN0IGZpcm13YXJlIGxvYWQgZm9yDQo+PiByYWRl
b24vQ0FJQ09TX21lLmJpbiBzdWNjZWVkZWQNCj4+IFsgICAxMC42MTE5MDldIHJhZGVvbiAw
MDAwOjAxOjAwLjA6IERpcmVjdCBmaXJtd2FyZSBsb2FkIGZvcg0KPj4gcmFkZW9uL0JUQ19y
bGMuYmluDQo+PiBzdWNjZWVkZWQNCj4+IFsgICAxMC42MTE5MzhdIHJhZGVvbiAwMDAwOjAx
OjAwLjA6IERpcmVjdCBmaXJtd2FyZSBsb2FkIGZvcg0KPj4gcmFkZW9uL0NBSUNPU19tYy5i
aW4gc3VjY2VlZGVkDQo+PiBbICAgMTAuNjYwNTk5XSByYWRlb24gMDAwMDowMTowMC4wOiBE
aXJlY3QgZmlybXdhcmUgbG9hZCBmb3INCj4+IHJhZGVvbi9DQUlDT1Nfc21jLmJpbiBmYWls
ZWQgd2l0aCBlcnJvciAtMg0KPj4gWyAgIDEwLjY2MDYwMV0gc21jOiBlcnJvciBsb2FkaW5n
IGZpcm13YXJlICJyYWRlb24vQ0FJQ09TX3NtYy5iaW4iDQo+IA0KPiBZb3UgYWxzbyBuZWVk
IHRvIG1ha2Ugc3VyZSBDQUlDT1Nfc21jLmJpbiBpcyBhdmFpbGFibGUuDQoNCk9mIGNvdXJz
ZS4gQnV0IHdpdGggYWxsIGZpcm13YXJlIGZpbGVzIGxvYWRhYmxlIHRoZSBzeXN0ZW0gaXMg
Y3Jhc2hpbmcsIHRvby4NCg0KSSB0aG91Z2h0IGl0IG1pZ2h0IGhlbHAgdG8gc2VlIGFmdGVy
IHdoaWNoIGZpcm13YXJlIHRoZSBjcmFzaGVzIGFyZSBzdGFydGluZy4NCg0KPiANCj4+IFsg
ICAxMC42NjE2NzZdIFtkcm1dIHJhZGVvbjogcG93ZXIgbWFuYWdlbWVudCBpbml0aWFsaXpl
ZA0KPj4gWyAgIDEwLjcxMzY2Nl0gcmFkZW9uIDAwMDA6MDE6MDAuMDogRGlyZWN0IGZpcm13
YXJlIGxvYWQgZm9yDQo+PiByYWRlb24vU1VNT191dmQuYmluDQo+PiBmYWlsZWQgd2l0aCBl
cnJvciAtMg0KPj4gWyAgIDEwLjcxMzY2OF0gcmFkZW9uIDAwMDA6MDE6MDAuMDogcmFkZW9u
X3V2ZDogQ2FuJ3QgbG9hZCBmaXJtd2FyZQ0KPj4gInJhZGVvbi9TVU1PX3V2ZC5iaW4iDQo+
PiBbICAgMTAuNzEzNjY5XSByYWRlb24gMDAwMDowMTowMC4wOiBmYWlsZWQgVVZEICgtMikg
aW5pdC4NCj4gDQo+IEFuZCBTVU1PX3V2ZC5iaW4uDQoNClN1cmUuDQoNCj4gDQo+PiBbICAg
MTAuNzE0Nzg3XSBbZHJtXSBlbmFibGluZyBQQ0lFIGdlbiAyIGxpbmsgc3BlZWRzLCBkaXNh
YmxlIHdpdGgNCj4+IHJhZGVvbi5wY2llX2dlbjI9MA0KPj4gWyAgIDEwLjgwOTIxM10gcmFk
ZW9uIDAwMDA6MDE6MDAuMDogV0IgZW5hYmxlZA0KPj4gWyAgIDEwLjgxNzUyOF0gcmFkZW9u
IDAwMDA6MDE6MDAuMDogZmVuY2UgZHJpdmVyIG9uIHJpbmcgMCB1c2UgZ3B1IGFkZHINCj4+
IDB4MDAwMDAwMDA0MDAwMGMwMA0KPj4gWyAgIDEwLjgzMzc1NV0gcmFkZW9uIDAwMDA6MDE6
MDAuMDogZmVuY2UgZHJpdmVyIG9uIHJpbmcgMyB1c2UgZ3B1IGFkZHINCj4+IDB4MDAwMDAw
MDA0MDAwMGMwYw0KPj4gWyAgIDEwLjg1MDMzMF0gcmFkZW9uIDAwMDA6MDE6MDAuMDogcmFk
ZW9uOiBNU0kgbGltaXRlZCB0byAzMi1iaXQNCj4+IFsgICAxMC44NjIxNTRdIHJhZGVvbiAw
MDAwOjAxOjAwLjA6IHJhZGVvbjogdXNpbmcgTVNJLg0KPj4gWyAgIDEwLjg3MTkzMF0gW2Ry
bV0gcmFkZW9uOiBpcnEgaW5pdGlhbGl6ZWQuDQo+PiBbICAgMTEuMDYyMDI4XSBbZHJtXSBJ
bml0aWFsaXplZCByYWRlb24gMi41MC4wIDIwMDgwNTI4IGZvciAwMDAwOjAxOjAwLjAgb24N
Cj4+IG1pbm9yIDANCj4+IFsgICAxMS4xMTk3MjNdIFtkcm06cmFkZW9uX2R2aV9kZXRlY3Qg
W3JhZGVvbl1dICpFUlJPUiogRFZJLUktMTogcHJvYmVkIGENCj4+IG1vbml0b3IgYnV0IG5v
fGludmFsaWQgRURJRA0KPj4gWyAgIDExLjQxMTM3MF0gZmJjb246IHJhZGVvbmRybWZiIChm
YjApIGlzIHByaW1hcnkgZGV2aWNlDQo+PiBbICAgMTEuNTA3MjUyXSByYWRlb24gMDAwMDow
MTowMC4wOiBbZHJtXSBmYjA6IHJhZGVvbmRybWZiIGZyYW1lIGJ1ZmZlcg0KPj4gZGV2aWNl
DQo+PiBbICAgMTEuNjc0MDI4XSBbZHJtOnJhZGVvbl9kdmlfZGV0ZWN0IFtyYWRlb25dXSAq
RVJST1IqIERWSS1JLTE6IHByb2JlZCBhDQo+PiBtb25pdG9yIGJ1dCBub3xpbnZhbGlkIEVE
SUQNCj4+IFsgICAxMS44MzQzMTddIFtkcm06cmFkZW9uX2R2aV9kZXRlY3QgW3JhZGVvbl1d
ICpFUlJPUiogRFZJLUktMTogcHJvYmVkIGENCj4+IG1vbml0b3IgYnV0IG5vfGludmFsaWQg
RURJRA0KPj4gWyAgIDI4LjMxMzA0MV0gc25kX2hkYV9pbnRlbCAwMDAwOjAxOjAwLjE6IGJv
dW5kIDAwMDA6MDE6MDAuMCAob3BzDQo+PiByYWRlb25fYXVkaW9fY29tcG9uZW50X2JpbmRf
b3BzIFtyYWRlb25dKQ0KPj4gWyAgIDQ0LjM3MTk5MV0gW2RybTpyYWRlb25fZHZpX2RldGVj
dCBbcmFkZW9uXV0gKkVSUk9SKiBEVkktSS0xOiBwcm9iZWQgYQ0KPj4gbW9uaXRvciBidXQg
bm98aW52YWxpZCBFRElEDQo+PiBbICAgNDQuNDI4MDY4XSBbZHJtOnJhZGVvbl9kdmlfZGV0
ZWN0IFtyYWRlb25dXSAqRVJST1IqIERWSS1JLTE6IHByb2JlZCBhDQo+PiBtb25pdG9yIGJ1
dCBub3xpbnZhbGlkIEVESUQNCj4+DQo+PiBmb2xsb3dlZCBieSBhIGNyYXNoIHNvbWUgc2Vj
b25kcyBhZnRlciB0aGUgc3lzdGVtIHdhcyB1cC4NCj4+DQo+PiBUaGUgY3Jhc2hlcyB2YXJ5
LCBidXQgb2Z0ZW4gdGhlIGtlcm5lbCBhY2Nlc3NlcyBub24tY2Fub25pY2FsIGFkZHJlc3Nl
cyBvcg0KPj4gdHJpZXMgdG8gbWFwIGlsbGVnYWwgcGh5c2ljYWwgYWRkcmVzc2VzLiBTb21l
dGltZXMgdGhlIHN5c3RlbSBpcyBqdXN0IGhhbmdpbmcsDQo+PiBlaXRoZXIgd2l0aCBzb2Z0
bG9ja3VwcyBvciB3aXRob3V0IGFueSBmdXJ0aGVyIHNpZ25zIG9mIGJlaW5nIGFsaXZlLg0K
Pj4NCj4+IEkgY2FuIGVhc2lseSByZXByb2R1Y2UgdGhlIHByb2JsZW0sIHNvIGFueSBkZWJ1
ZyBwYXRjaGVzIHRvIG5hcnJvdyBkb3duIHRoZQ0KPj4gcHJvYmxlbSBhcmUgd2VsY29tZS4N
Cj4gDQo+IFRoZXJlIGFyZSBzdGlsbCBtaXNzaW5nIGZpcm13YXJlIHJlcXVpcmVkIGZvciBw
cm9wZXIgb3BlcmF0aW9uLiAgUGxlYXNlIGZpeCB0aGVtIHVwLg0KDQpUaGF0IHdhcyB0aGUg
c3RhcnRpbmcgcG9pbnQsIG9mIGNvdXJzZSENCg0KQlRXLCBtZWFud2hpbGUgSSBoYXZlIHRl
c3RlZCBrZXJuZWwgNS4xOSwgd2hpY2ggaXMgd29ya2luZy4gSSBzdXNwZWN0ZWQgdGhhdA0K
dGhlIHBhdGNoIHNlcmllcyBtZXJnaW5nIHN3aW90bGIgYW5kIHN3aW90bGIteGVuIGNvdWxk
IGJlIHRvIGJsYW1lLCBidXQgdGhhdA0Kd2VudCBpbnRvIHY1LjE5Lg0KDQoNCkp1ZXJnZW4N
Cg==
--------------kxPE0UWCVuBdTwBgE5WHt8yy
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------kxPE0UWCVuBdTwBgE5WHt8yy--

--------------uvwBTBvdMRe7VA7G0i8YDlJY--

--------------n5q47dhKenDHw0thuDhdOTXj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmV8evUFAwAAAAAACgkQsN6d1ii/Ey8E
2gf/VUYp5g3ZkxQF7r5l+iSuNyvgyRWtXAl46OHoyvTzgyLhSljPGoN8C9OWLg3TbBFcgy1v2mFX
Ufg8Bher3kPuvC8+CHQMg7mh8auqHPjpgf1DeHtr21gVJ8sc923IFvJGvMAgMOk0w2BXBnMrDXdr
T9GJvPs+c2mW3vXQtqSbmu3Lz9ZHmuQM5ZbW7a1YBmN/z1DUkfWlr9rOWw4siKmAH3uXrpP+JTwK
9VYCs9tr1o2KqZ5gPepClzWpbQfLtdUxCRqib/bQLW8xcTefnSCJqeRoPSLDd3FG+oQJVEVAbrrw
lesnI0ky3PEnHk09eiERnrjqxTCT5lg72Piuwezahg==
=ejFs
-----END PGP SIGNATURE-----

--------------n5q47dhKenDHw0thuDhdOTXj--

