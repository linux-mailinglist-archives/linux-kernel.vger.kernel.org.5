Return-Path: <linux-kernel+bounces-22095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9C7829916
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D334B1C218F6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0557B4779D;
	Wed, 10 Jan 2024 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="d+vYhm+x"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6241747F52;
	Wed, 10 Jan 2024 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=jEqwjJoRoQCCeu+dixorWIss5lV/TiYmbhQI2BeIEXc=; b=d
	+vYhm+xUiZNDBRCtNeMpNdgJ7m/YFB8aHnjnHY6oDOlzhqykWh7PuBrO+eEYanSZ
	zYSv5rsGpzWjVMv4gVekX2e0rrLfQ1vAU/VWdsre6b8C83i2kSaApLt/SdTFe4HW
	8h824b/SSKiI35NwlohE+YAvTl9ABiD23XNrfmTEQw=
Received: from 00107082$163.com ( [111.35.187.31] ) by
 ajax-webmail-wmsvr-40-123 (Coremail) ; Wed, 10 Jan 2024 19:30:32 +0800
 (CST)
Date: Wed, 10 Jan 2024 19:30:32 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Jozsef Kadlecsik" <kadlec@netfilter.org>
Cc: ale.crismani@automattic.com, xiaolinkui@kylinos.cn, pablo@netfilter.org, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: Performance regression in ip_set_swap on 6.1.69
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <661cb613.7974.18cf30c4a42.Coremail.00107082@163.com>
References: <C0829B10-EAA6-4809-874E-E1E9C05A8D84@automattic.com>
 <20240110102342.4978-1-00107082@163.com>
 <a4dfc3d9-f028-7ab4-c3a7-11dcbb12e377@netfilter.org>
 <661cb613.7974.18cf30c4a42.Coremail.00107082@163.com>
X-NTES-SC: AL_Qu2bBvSTuUoo5CmdYOkZnEYQheY4XMKyuPkg1YJXOp80kSTmyAAyYmBOL2D/1e+BMj63rwevWzZqxOdYd7Z0QZDC0yMsda23NgC0PJBtoqjt
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2992e057.7d98.18cf3236780.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD33zDZf55lM5wiAA--.20534W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqAJhqmVOBjN97AAHsp
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI0LTAxLTEwIDE5OjA1OjE4LCAiRGF2aWQgV2FuZyIgPDAwMTA3MDgyQDE2My5jb20+
IHdyb3RlOgo+Cj4KPk15IHRlc3QgY29kZSBpcyBhcyBmb2xsb3dpbmcsIGl0IHdvdWxkIHN0cmVz
cyBzd2FwcGluZyBpcHNldCAnZm9vJyB3aXRoICdiYXInOyAoZm9vL2JhciBpcHNldCBuZWVkcyB0
byBiZSBjcmVhdGVkIGJlZm9yZSB0aGUgdGVzdC4pCj5XaXRoIGxhdGVzdCA2LjcsIHRoZSBzdHJl
c3Mgd291bGQgdGFrZSBhYm91dCAxODAgc2Vjb25kcyB0byBmaW5pc2gsIGJ1dCB3aXRoIGBzeW5j
aHJvbml6ZV9yY3VgIHJlbW92ZWQsIGl0IG9ubHkgdG9vayAzc2Vjb25kcy4KCkNvcnJlY3Rpb24s
ICB3aXRoICdzeW5jaHJvbml6ZV9yY3UnIHJlbW92ZWQsIGl0IG9ubHkgdG9vayBhYm91dCAwLjAz
IHNlY29uZHMKPgo+Cj5EYXZpZAo=

