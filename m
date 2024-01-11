Return-Path: <linux-kernel+bounces-23456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDC382AD0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E695B26F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF9014F96;
	Thu, 11 Jan 2024 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="KeQP14Ez"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7D115482;
	Thu, 11 Jan 2024 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=TedLus6DeoKh8EHTaLRaHX786jSO4OLiu12N9jYORaY=; b=K
	eQP14EzGfAqm4n5NCaItNVdKG31Te45XVtL8aHKz5owsPqhxeunD+/gQp9aaPWza
	DGWOLFbby87oR5pu3nQ8fB+VPHGjBy4pwa+xaBJJAk+pCwBSciWc3cRmlV4F8z/C
	vkwjCJviCbX2ik7UJDwkbl9ocLImhg5FTFtpQyTx6s=
Received: from 00107082$163.com ( [111.35.187.31] ) by
 ajax-webmail-wmsvr-40-116 (Coremail) ; Thu, 11 Jan 2024 19:11:28 +0800
 (CST)
Date: Thu, 11 Jan 2024 19:11:28 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Jozsef Kadlecsik" <kadlec@blackhole.kfki.hu>
Cc: ale.crismani@automattic.com, xiaolinkui@kylinos.cn, 
	"Pablo Neira Ayuso" <pablo@netfilter.org>, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re:Re: Performance regression in ip_set_swap on 6.1.69
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <0d0b1526-6189-fd0f-747e-cb803936b20a@blackhole.kfki.hu>
References: <C0829B10-EAA6-4809-874E-E1E9C05A8D84@automattic.com>
 <20240110102342.4978-1-00107082@163.com>
 <a4dfc3d9-f028-7ab4-c3a7-11dcbb12e377@netfilter.org>
 <661cb613.7974.18cf30c4a42.Coremail.00107082@163.com>
 <956ec7cd-16ef-7f72-dad8-dfa2ec5f4d77@netfilter.org>
 <0d0b1526-6189-fd0f-747e-cb803936b20a@blackhole.kfki.hu>
X-NTES-SC: AL_Qu2bBvWcvkwj7iaaZ+kXn0oTju85XMCzuv8j3YJeN500pSTk+ys6fH5DDFHQ0v2JLgG3sRmYWSVK6epwVJZSQIBVjQI5bBlmm6SRu1ejlEZ0
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7c8d2978.8451.18cf8384d73.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3P_HhzJ9lAuYiAA--.4743W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBEBdiqmVOBlC60wAEsf
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI0LTAxLTExIDE2OjI1OjQ2LCAiSm96c2VmIEthZGxlY3NpayIgPGthZGxlY0BibGFj
a2hvbGUua2ZraS5odT4gd3JvdGU6Cj5IaSwKPgo+Cj5Db3VsZCB5b3UgY2hlY2sgdGhhdCB0aGUg
cGF0Y2ggYmVsb3cgZml4ZXMgdGhlIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24/IAo+SW5zdGVhZCBv
ZiB3YWl0aW5nIGZvciB0aGUgUkNVIGdyYWNlIHBlcmlvZCBhdCBzd2FwcGluZywgY2FsbF9yY3Uo
KSBpcyAKPnVzZWQgYXQgZGVzdHJveWluZyB0aGUgc2V0LgoKR290IGEgY29tcGlsZXIgZXJyb3I6
Cm5ldC9uZXRmaWx0ZXIvaXBzZXQvaXBfc2V0X2NvcmUuYzogSW4gZnVuY3Rpb24goa5pcF9zZXRf
ZGVzdHJveV9zZXRfcmN1oa86Cm5ldC9uZXRmaWx0ZXIvaXBzZXQvaXBfc2V0X2NvcmUuYzoxMDE3
Ojk6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiChrmlwX3NldF9kZXN0
cm95X3NldKGvOyBkaWQgeW91IG1lYW4goa5pcF9zZXRfZGVzdHJveV9zZXRfcmN1oa8/IFstV2Vy
cm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogMTAxNyB8ICAgICAgICAgaXBfc2V0
X2Rlc3Ryb3lfc2V0KHNldCk7CiAgICAgIHwgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn4KICAg
ICAgfCAgICAgICAgIGlwX3NldF9kZXN0cm95X3NldF9yY3UKbmV0L25ldGZpbHRlci9pcHNldC9p
cF9zZXRfY29yZS5jOiBBdCB0b3AgbGV2ZWw6Cm5ldC9uZXRmaWx0ZXIvaXBzZXQvaXBfc2V0X2Nv
cmUuYzoxMTgzOjE6IHdhcm5pbmc6IGNvbmZsaWN0aW5nIHR5cGVzIGZvciChrmlwX3NldF9kZXN0
cm95X3NldKGvOyBoYXZlIKGudm9pZChzdHJ1Y3QgaXBfc2V0ICopoa8KIDExODMgfCBpcF9zZXRf
ZGVzdHJveV9zZXQoc3RydWN0IGlwX3NldCAqc2V0KQogICAgICB8IF5+fn5+fn5+fn5+fn5+fn5+
fgpuZXQvbmV0ZmlsdGVyL2lwc2V0L2lwX3NldF9jb3JlLmM6MTE4MzoxOiBlcnJvcjogc3RhdGlj
IGRlY2xhcmF0aW9uIG9mIKGuaXBfc2V0X2Rlc3Ryb3lfc2V0oa8gZm9sbG93cyBub24tc3RhdGlj
IGRlY2xhcmF0aW9uCgoKSSBtb3ZlIHRoZSBkZWNsYXJhdGlvbiBvZiBpcF9zZXRfZGVzdHJveV9z
ZXRfcmN1LCAgbWFrZSBzdXJlIGl0IGlzIGFmdGVyIHRoZSBkZWNsYXJhdGlvbiBvZiBpcF9zZXRf
ZGVzdHJveV9zZXQsIApXaXRoIHRoaXMgcGF0aCwgdGhlIHBlcmZvcm1hbmNlIGRlZ3JhZGF0aW9u
IG9mIGlwc2V0X3N3YXAgaXMgZ29uZSwgIGJ1dCBteSB0ZXN0IG9ubHkgc3RyZXNzIGlwc2V0X3N3
YXAsIG5vdCBhIHN3YXAvZGVzdHJveSBzZXF1ZW5jZS4KSSB3aWxsIGFkanVzdCBteSAgY29kZSB0
byBzdHJlc3MgYSBmdWxsIHN3YXAvZGVzdHJveS9jcmVhdGUvYWRkIHNlcXVlbmNlLCBhbmQgdXBk
YXRlIGxhdGVyLgoKClRoYW5rcwpEYXZpZAo=

