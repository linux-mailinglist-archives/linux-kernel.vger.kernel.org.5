Return-Path: <linux-kernel+bounces-25841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113BE82D696
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2002B1C21676
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D385F50E;
	Mon, 15 Jan 2024 10:00:57 +0000 (UTC)
Received: from cstnet.cn (smtp20.cstnet.cn [159.226.251.20])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D98EAFB;
	Mon, 15 Jan 2024 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from mengjingzi$iie.ac.cn ( [121.195.114.118] ) by
 ajax-webmail-APP-10 (Coremail) ; Mon, 15 Jan 2024 17:55:22 +0800
 (GMT+08:00)
Date: Mon, 15 Jan 2024 17:55:22 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: change the privilege required for tty operarions
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230921(8ad33efc)
 Copyright (c) 2002-2024 www.mailtech.cn cnic.cn
In-Reply-To: <2024011523-lifter-narrow-fed3@gregkh>
References: <2024010247-polio-brittle-1b23@gregkh>
 <20240115082420.13372-1-mengjingzi@iie.ac.cn>
 <2024011523-lifter-narrow-fed3@gregkh>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2fed8f4.8c4.18d0c8c1269.Coremail.mengjingzi@iie.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:tACowADnPoALAaVlM2wFAA--.59155W
X-CM-SenderInfo: pphqwyxlqj6xo6llvhldfou0/1tbiDAgRE2Wk5CJVSAAAsc
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWkKw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Jmd0OyBUZXN0ZWQgaG93PyAgCgpGaXJzdCBvZiBhbGwsIHRoaXMgY2hhbmdlIGlzIG5vdCBhYm91
dCBmdW5jdGlvbmFsaXR5LCBvbmx5IGFib3V0IHBlcm1pc3Npb25zLiAKSSB3cm90ZSAzIHRlc3Rj
YXNlcyB3aGljaCBjYWxscyBpb2N0bCgpIHdpdGggVElPQ1NUSSwgVElPQ0NPTlMsIFRJT0NWSEFO
R1VQIApyZXNwZWN0aXZlbHkuIFRoZW4gZXhlY3V0ZSB0aGVtIG9uIHRoZSBvcmlnaW4ga2VybmVs
IGFuZCBwYXRjaGVkIGtlcm5lbC4gClJ1bm5pbmcgaXQgb24gYm90aCBzZXRzIG9mIGtlcm5lbHMg
Z2l2ZXMgdGhlIHNhbWUgcmVzdWx0LiBIb3dldmVyLCB0aHJvdWdoCnRoZSBzeXN0ZW0gZXJyb3Ig
bWVzc2FnZSwgYW5kIHRoZSBrZXJuZWwgbG9nIG91dHB1dCBJIGFkZGVkLCBJIGNvbmZpcm1lZCAK
dGhhdCB0aGUgcmVsZXZhbnQgZnVuY3Rpb25hbGl0eSB1bmRlciB0aGUgb3JpZ2luIGtlcm5lbCBy
ZXF1aXJlcyBzeXNfYWRtaW4sIAphbmQgdW5kZXIgdGhlIHBhdGNoZWQga2VybmVsIHJlcXVpcmVz
IHN5c190dHlfY29uZmlnLgoKSW5kZWVkLCBpdCBkb2Vzbid0IGhhdmUgbXVjaCB0byBkbyB3aXRo
IHRoZSBkaXN0cm8gZWl0aGVyLCBJIGp1c3QgdGVzdGVkIGl0IApvbiBEZWJpYW4sIGFuZCBzaW1p
bGFyIHRlc3RzIGNhbiBiZSBkb25lIG9uIG90aGVyIGRpc3Ryb3MuCgoKJmd0OyBXaHkgZGlkIHlv
dSBqdXN0IGNoYW5nZSB0aGVzZSAzIHVzYWdlcywgYW5kIG5vdCBhbGwgb2YgdGhlbT8gIFdoeSBh
cmUKJmd0OyB0aGVzZSAic2FmZSIgYnV0IHRoZSBvdGhlcnMgbm90PwoKVGhlcmUgYXJlIDUgY2Fw
YWJpbGl0eSBjaGVja3MgaW4gdGhpcyBmaWxlLCBhbGwgdXNpbmcgc3lzX2FkbWluLiBUaGUgZmly
c3QgCm9uZSBpcyBpbiB0aGUgdGlvY3N0aSBmdW5jdGlvbiwgaW4gY29tbWl0IDY5MGM4YjgwNGFk
MiAoIlRJT0NTVEk6IGFsd2F5cyAKZW5hYmxlIGZvciBDQVBfU1lTX0FETUlOIiksIHN5c19hZG1p
biB3YXMgaW50cm9kdWNlZCBmb3IgYSBzcGVjaWFsIAphcHBsaWNhdGlvbiBCUkxUVFksIHNvIEkg
aGVzaXRhdGVkIHRvIGNoYW5nZSBpdC4gSW4gZmFjdCwgQlJMVFRZIGhhcyBib3RoIApzeXNfYWRt
aW4gYW5kIHN5c190dHlfY29uZmlnLCBzbyBtb2RpZnkgdGhlIGtlcm5lbCdzIHBlcm1pc3Npb24g
Y2hlY2ssIHdpbGwgCm5vdCBhZmZlY3QgQlJMVFRZJ3MgZnVuY3Rpb24uIFRoZSBvdGhlciBwZXJt
aXNzaW9uIGNoZWNrIGlzIGxvY2F0ZWQgaW4gYSAKZGlmZmVyZW50IGZ1bmN0aW9uLCBub3QgdHJp
Z2dlcmVkIGJ5IGlvY3RsLCBzbyBpdCdzIG5vdCB3cml0dGVuIHRvZ2V0aGVyLgoKJmd0OyBBbmQg
bW9zdCBpbXBvcnRhbnRseSBvZiBhbGwsIHdoeSBtYWtlIHRoaXMgY2hhbmdlIGF0IGFsbD8gIFdo
byBpcyB1c2luZwomZ3Q7IGNhcGFiaWxpdGllcyB0aGVzZSBkYXlzIGluIGEgZmluZS1ncmFpbmVk
IHdheSB0byB3YXJyZW50IHRoaXMgdHlwZSBvZgomZ3Q7IG1vZGlmaWNhdGlvbj8KCkkgZ3Vlc3Mg
eW91IGFyZSByaWdodCwgdGhlcmUncyBub3QgYSBsb3Qgb2YgcGVvcGxlIHVzaW5nIGNhcGFiaWxp
dGllcy4gCkJ1dCB0aGUgaWRlYSBvZiBhIGxlYXN0IHByaXZpbGVnZSBkZXNpZ24gaXMgc3RpbGwg
dGVtcHRpbmcgZnJvbSBhIApzZWN1cml0eSBwb2ludCBvZiB2aWV3LiBUaGUgc2NhcmNlIHVzZSBv
ZiBjYXBhYmlsaXRpZXMgaXMgcmVsYXRlZCB0byAKaXRzIHByb2JsZW1hdGljIGltcGxlbWVudGF0
aW9uLCBhbmQgd2UgaG9wZSB0byBwcm9tb3RlIGl0cyB1c2UgYnkgCmltcHJvdmluZyBpdHMgaW1w
bGVtZW50YXRpb24uIHN5c19hZG1pbiBpcyBhIHJlbGF0aXZlbHkgbGFyZ2UgcHJpdmlsZWdlLCAK
d2hpY2ggbWF5IHBvc2UgYSByaXNrIHRvIHRoZSBzeXN0ZW0g77yIY2hlY2sgdGhlIGN2ZSBsaXN0
OgpodHRwczovL2N2ZS5taXRyZS5vcmcvY2dpLWJpbi9jdmVrZXkuY2dpP2tleXdvcmQ9Q0FQX1NZ
U19BRE1JTiApLCBhbmQgYnkgCnJlZHVjaW5nIHRoZSB1bm5lY2Vzc2FyeSB1c2Ugb2Ygc3lzX2Fk
bWluLCB3ZSBjYW4gYXZvaWQgc29tZSBvZiB0aGUgcmlza3MuIApJbiBwYXJ0aWN1bGFyLCB0aGUg
bGludXggY2FwYWJpbGl0eSBoYXMgYmVlbiBkZXNpZ25lZCB3aXRoIHN5c190dHlfY29uZmlnLCAK
c28gaXQgc2hvdWxkIHRha2Ugb3ZlciB0aGUgcHJpdmlsZWdlcyBvcmlnaW5hbGx5IG1hbmFnZWQg
Ynkgc3lzX2FkbWluIApyZWxhdGVkIHRvIFRUWS4KCkJlc3QgcmVnYXJkcywKSmluZ3ppCg==

