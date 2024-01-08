Return-Path: <linux-kernel+bounces-19105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819F1826819
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BE1281D59
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5B179DF;
	Mon,  8 Jan 2024 06:40:13 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cstnet.cn (smtp85.cstnet.cn [159.226.251.85])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208138F6D;
	Mon,  8 Jan 2024 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from mengjingzi$iie.ac.cn ( [159.226.94.107] ) by
 ajax-webmail-APP-13 (Coremail) ; Mon, 8 Jan 2024 14:32:12 +0800 (GMT+08:00)
Date: Mon, 8 Jan 2024 14:32:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: gregkh@linuxfoundation.org, gpiccoli@igalia.com, 
	john.ogness@linutronix.de, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org, 
	tony.luck@intel.com
Subject: Re: [PATCH] cap_syslog: remove CAP_SYS_ADMIN when dmesg_restrict
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230921(8ad33efc)
 Copyright (c) 2002-2024 www.mailtech.cn cnic.cn
In-Reply-To: <20240105144944.GA246367@mit.edu>
References: <2024010306-tweezers-skinhead-083e@gregkh>
 <20240105062007.26965-1-mengjingzi@iie.ac.cn>
 <20240105144944.GA246367@mit.edu>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4b5ac92c.1086b.18ce7c58a95.Coremail.mengjingzi@iie.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:twCowACHj8_slptlZdEEAA--.50409W
X-CM-SenderInfo: pphqwyxlqj6xo6llvhldfou0/1tbiCRAKE2WbUw7IpAABsO
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Ck9uIEZyaSAyMDI0LTAxLTA1IDA5OjQ5OjQ0LCBUaGVvZG9yZSBUcydvIHdyb3RlOgomZ3Q7IEl0
J3MgdW5jbGVhciB0byBtZSB3aGF0IGdvYWwgeW91IGhhdmUgaW4gdHJ5aW5nIHRvIG1lc3Mgd2l0
aCB0aGUKJmd0OyBjYXBhYmlsaXR5IGRlZmluaXRpb25zPyAgUGVyaGFwcyBpdCBtaWdodCBiZSB1
c2VmdWwgaWYgeW91IHdlcmUgdG8KJmd0OyBleHBsaWNpdGx5IHN0YXRlIHlvdXIgZ29hbHMgaW4g
dGhlc2UgcHJvcG9zYWxzPwoKUGV0ciBpcyByaWdodCwgd2UgYXJlIHRyeWluZyB0byByZXNvbHZl
IHRoZSBvdmVybGFwIHByb2JsZW0gb2YgY2FwYWJpbGl0eS4gCgpDYXBhYmlsaXR5IGlzIGFib3V0
IHRvIHNlcGFyYXRlIHN1cGVydXNlciBwcml2aWxlZ2VzIGludG8gZGlzdGluY3QgdW5pdHMgZm9y
IApmaW5lci1ncmFpbmVkIGFjY2VzcyBjb250cm9sLiBJdOKAmXMgZWZmZWN0aXZlIHdvcmsgcmVx
dWlyZXMgdGhlIGtlcm5lbCB0byB1c2UgCnByb3BlciBjYXBhYmlsaXR5IGZvciBzZW5zaXRpdmUg
cmVzb3VyY2VzIGFuZCB0aGUgdXNlciBwcm9ncmFtcyB0byBjaG9vc2UgdGhlIApyaWdodCBjYXBh
YmlsaXR5IGluc3RlYWQgb2YgUk9PVCB0byBleGVjdXRlLiBBbmQgd2Ugd2FudCB0byBwcm9tb3Rl
IHRoZSAKc3RhbmRhcmRpemVkIHVzZSBvZiBjYXBhYmlsaXR5LgoKCiZndDsgU28gdGhlcmUgaXNu
J3QgYWxsIHRoYXQgbXVjaCB1cHNpZGUgaW4gdHJ5aW5nIHRvIHJldGlyZSBDQVBfU1lTX0FETUlO
IAoKV2UgYXJlIG5vdCBnb2luZyB0byByZXRpcmUgQ0FQX1NZU19BRE1JTiwgYnV0IHNheWluZyB0
aGF0IENBUF9TWVNMT0cgaXMgdGhlCm1vcmUgYXBwcm9wcmlhdGUgY2FwYWJpbGl0eSB3aGVuIGl0
IGNvbWVzIHRvIHByb3RlY3Rpbmcgc3lzbG9nIGZ1bmN0aW9uYWxpdHkuIApDQVBfU1lTX0FETUlO
IGlzIGFscmVhZHkgb3ZlcmxvYWRlZCwgY2hlY2sgb3V0IHRoZSBsaW5rWzFdLCBuYXJyb3dpbmcg
ZG93biBpdHMgCmRlZmluaXRpb25zIHdpbGwgZmFjaWxpdGF0ZSB0aGUgaW1wbGVtZW50YXRpb24g
b2YgbGVhc3QgcHJpdmlsZWdlLiBUaGlzIGFkanVzdG1lbnQgCm1ha2VzIGl0IGNsZWFyZXIgZm9y
IGEgdXNlciBwcm9ncmFtIHJlcXVpcmluZyBzeXNsb2cgYWNjZXNzIHRvIHNwZWNpZnkgb25seSB0
aGUgCm5lY2Vzc2FyeSBjYXBhYmlsaXR5LCBDQVBfU1lTTE9HLCBpbnN0ZWFkIG9mIHJlbHlpbmcg
b24gdGhlIGJyb2FkZXIgQ0FQX1NZU19BRE1JTi4KCiZndDsgV2hhdCB0ZXN0aW5nIGhhdmUgeW91
IGRvbmUgdG8gbWFrZSBzdXJlIHRoYXQgdGhpcyBpcyBPSz8KCldlIGJvb3RlZCB0aGUgbW9kaWZp
ZWQga2VybmVsIGFuZCBjb25maXJtZWQgdGhhdCBDQVBfU1lTX0FETUlOIG5vIGxvbmdlciBoYXMg
YWNjZXNzIAp0byBzeXNsb2cgd2hlbiBkbWVzZyBpcyBzZXQuCgpXaGlsZSBjZXJ0YWluIHVzZXIg
cHJvZ3JhbXMgcmVseWluZyBvbiBDQVBfU1lTX0FETUlOIGZvciBzeXNsb2cgYWNjZXNzIG1pZ2h0
IGJlIGltcGFjdGVkLCAKdGhleSBjYW4gYWRqdXN0IHRoZWlyIGNhcGFiaWxpdHkgY29uZmlndXJh
dGlvbiB1c2luZyB0aGUg4oCYc2V0Y2Fw4oCZIGNvbW1hbmQuIERlY3JlYXNpbmcgdGhlIApyZWxp
YW5jZSBvbiBDQVBfU1lTX0FETUlOIGFjcm9zcyBhcHBsaWNhdGlvbnMgY29udHJpYnV0ZXMgdG8g
bWluaW1pemluZyBzZWN1cml0eSByaXNrcyBpbiAKdGhlIHN5c3RlbS4gQ3VycmVudGx5LCBpdCdz
IHVuY2VydGFpbiBpZiBhbnkgc3VjaCBwcm9ncmFtcyBleGlzdC4KCgpCZXN0IHJlZ3JhZHMsCkpp
bmd6aQoKWzFdOiBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvNDg2MzA2LwoKCg==

