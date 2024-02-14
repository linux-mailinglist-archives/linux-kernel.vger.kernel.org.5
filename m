Return-Path: <linux-kernel+bounces-66091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F7C85568C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F37B26096
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079D712838B;
	Wed, 14 Feb 2024 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iISglxAa"
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5E21419B1;
	Wed, 14 Feb 2024 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951593; cv=none; b=bjj6MSPI8tQMYHXecL3F54QmII+uSXRpqlT+Fx7X+goPIuEiGtviOOPgLe588tYJuS2sqiv+JROW8z+XchgMTbbJ4cfii23vkzH34k+xYh+D9/3Hx/Er36sdrQPG5L946TOrW0w0JGUf2Rdl/DnCSEb3WkPt3aCThcl1bWS4TRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951593; c=relaxed/simple;
	bh=NWHjQPlaGIQ9OtliJHmGY1JMnvToGgMO8MA8ryL6e5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=pNeGITCqI5rJPkL/Zfv9SSGJ4rUtqEtjKU4Nv29BSmWP65fsGy3zSYfEIOk0BdEKcR4FQ2Ao3z8wTCIackDWa5J/UW4h9ws4Fn4dzxQpF45+U/TMXoOHoBSPi5qKN5sVsNu5PGDesz+DnFkzw/1eWiDbr2iQtT3cCHN2D0gEnlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iISglxAa; arc=none smtp.client-ip=211.189.100.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20240214225944usoutp029bb5161cc91390c85bc25f43697aa417~z3OrJ-v6e1082210822usoutp02V;
	Wed, 14 Feb 2024 22:59:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20240214225944usoutp029bb5161cc91390c85bc25f43697aa417~z3OrJ-v6e1082210822usoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707951584;
	bh=NWHjQPlaGIQ9OtliJHmGY1JMnvToGgMO8MA8ryL6e5g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iISglxAa5pWGqgz0yG661PwTZzPlrNEUvdZ31H5On9wxXgrN1X2iShK05O9Ks6NAx
	 4A4+a0CB9WUE8a0AFvmq4yiNI4BR0w08DXVbCm+5khhNoTb7+kt0mqtfnVKn83Ka8y
	 qQDfOeaA9qQhxMTnp0HZLmDaHq7KPgQHsd7UznT0=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240214225944uscas1p26fa9f885a7fd56b6dfe1c7f1b7945330~z3Oqvi9Qb1133111331uscas1p2K;
	Wed, 14 Feb 2024 22:59:44 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id 78.B6.09550.0E54DC56; Wed,
	14 Feb 2024 17:59:44 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240214225943uscas1p21ffa8b362bac11379168b83e42159160~z3OqcL0Yr3221832218uscas1p2B;
	Wed, 14 Feb 2024 22:59:43 +0000 (GMT)
X-AuditID: cbfec370-bbbfe7000000254e-32-65cd45e06f44
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 11.D5.45319.FD54DC56; Wed,
	14 Feb 2024 17:59:43 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Wed, 14 Feb 2024 14:59:42 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
	14 Feb 2024 14:59:42 -0800
From: Jim Harris <jim.harris@samsung.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
	"Jason Gunthorpe" <jgg@nvidia.com>, Alex Williamson
	<alex.williamson@redhat.com>, "pierre.cregut@orange.com"
	<pierre.cregut@orange.com>
Subject: [PATCH v3 1/2] PCI/IOV: Revert
 "PCI/IOV: Serialize sysfs sriov_numvfs reads vs writes"
Thread-Topic: [PATCH v3 1/2] PCI/IOV: Revert "PCI/IOV: Serialize sysfs
 sriov_numvfs reads vs writes"
Thread-Index: AQHaX5l/Y5bHR2DvZ0+eeI1J9u0GaA==
Date: Wed, 14 Feb 2024 22:59:42 +0000
Message-ID: <170795158249.2393.6069168125066679172.stgit@bgt-140510-bm01.eng.stellus.in>
In-Reply-To: <170795147587.2393.15577527626926144858.stgit@bgt-140510-bm01.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <84A3C9C8FC63C94C827BCF517FA70757@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7djX87oPXM+mGjz+yWnx7X8Pm8XdxxfY
	LKZPvcBoceJmI5vF6ptrGC1+XZzGarH/6XMWiyv/9jBarFp4jc3iTHeuxaYNT1gszs86xWIx
	b/1PRovLu+awWaz/+p7N4taEY0wOAh6zGy6yeLQcecvqsXjPSyaPTas62Tx6m9+xebQ8O8nm
	8X7fVTaPqbPrPT5vkgvgjOKySUnNySxLLdK3S+DKaJqxh6Vgm0DF7cUN7A2MDQJdjJwcEgIm
	Ev2nd7F0MXJxCAmsZJS4fPAxlNPKJDF/8mQ2mKrNKydAJdYwSix9e58NwvnEKNF67AZUZhmj
	xN+fbxhBWtgENCV+XVnDBJIQEfjIKtG3Ywo7SEJYIFHi0LdbrCC2iECaxPreHhYIW0/i1/2l
	YM0sAqoS35r6wGp4BSIkdp76BRbnFIiS+P35BZjNKCAm8f0UyAJODmYBcYlbT+YzQdwqKLFo
	9h5mCFtM4t+uh1A/KErc//4S6AYOoHpNifW79CFa7SQm3bnABmErSkzpfsgOsVZQ4uTMJywQ
	rZISB1fcgLJXc0p0H1aBsF0kLs1ayQhhS0v8vbsM6oRsiZXrO5hAVkkIFEg0HAmCCFtLLPyz
	HupiPom/vx4xTmBUnoXkgVkIx81CctwsJMfNQnLcAkbWVYzipcXFuempxcZ5qeV6xYm5xaV5
	6XrJ+bmbGIGp8fS/wwU7GG/d+qh3iJGJg/EQowQHs5II76TeM6lCvCmJlVWpRfnxRaU5qcWH
	GKU5WJTEeQ1tTyYLCaQnlqRmp6YWpBbBZJk4OKUamBp89hreC+ZIWH4y1NzuVtW3oyKBujOj
	VF69Xskq4vvtWTufmFR6wCrLEE736UeNHm68/Leg79uVv6+atS88FJ7NcU2467wuu+7yp+ud
	trl+yzmcP5/t+sWdRounzw7OnXfxU6oLT2JjTVfQ9s5fJ40Sru5QqO3MdjvDbRReszg+6Ero
	4gkBkQten76436/CyMwmsMezY85m76hYLfZ7n3XD/Xtk8+bmHtUXCrxwjeHbrhsrFySu7/9X
	FvCvNOn5Aq2/S4PeM17ZU9mz4/21iTNuRcyTnq3ufOJjqfSRWfcKsz7+nZb1M3itsN31ozKT
	xasMLv62PSZaHDHPaNqSxubKu6/UXO3C+t+GzLstsEuJpTgj0VCLuag4EQCTTbim/AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+XbOjsfR8mtafi2QGnQxSLtRH2QShXGC1G6kGVEjT9NypjtO
	K7rMC0aXxRTndJbLsqglaMssbRVTy0ulRpblNA1nTcIsLcsZmvMU+d/ve5/3ed7nj48mJKOk
	lI6NT2JV8fI4GSUiYzXE+iVdIS/Ypb8s/nh4/DyFO3taKGzQtwBc/y6VwrfelQDsepkrxI97
	P5G4dcwKsLnoDYWfn1NiS5mDxM3GRhIXlo4A/KrqIoVLfwxQuF33VLAOMgWalySTUdsvZK5a
	+wSMxXyGYrTpXygm42MDxQw8ek0x+oJTzJDFb4tnlCgomo2LTWZVgcH7RDFpeVYyoQIesV/V
	eGiABp4FnjSCK9GdmzryLBDREmgG6N5vi4B/DALkGO/+q1wHKNdm8HBbKOiPXK0lk1s+8JsQ
	DXXrJwVvKEdaQ63AzT7wACrVnid5DkCurmvAzSScj4bTLgjdLIaRqLLRNTGnJy7sQrq2JPfY
	E0ah0SHn5DqAs9DPxpLJSAL6onaHScDXhqjY2kzwPBP19YwJeZ6Hun72ebgjiYmepVWBvDUY
	ZXe0UDzPQznnPnjwDWaghnwHyVtnI9uNt6QO+BqnXDP+TzJOSTJOSTJOSboMhGbgq+Y4peII
	tzyeTQng5EpOHa8I2H9YaQET/+PZWM3u+8De/i2gGghoUA0QTch8xNna56xEHC0/eoxVHd6r
	UsexXDWYQ5MyX3Fn9yJWAhXyJPYQyyawqn+qgPaUagSrDaZcvwjTgAomZ9qcm6TNpuCycOvn
	K9kiadHn9qaYus2XfqH09LvRI6GSjsf5tbO5zDQdQSt2yZ7FnihuXiPcFvJBvGFRXOV0KUgp
	rG+ojbQ1zNp+Kef019bGrMvKCLF9Ey0ThTrrF/qZThlGVuC8GrV/mD61TWlpWrAjTIiZ+akV
	q7Tvd/annJ5W931r75or906aiwtW3tl4ZnC3s3AwMfFVLqpQv+6vr5AQYu+UtgVeMtLVUZ7A
	7omwN4mCJHnbHxRFMsezjFu8uqwvbJu33aZ7l3uVrw46mpisfNP5RD8t1DXXKcl6WLk02Xmx
	hwzvPvhW4dhnX4tD+tZXyUguRr5sMaHi5H8Ami8tP44DAAA=
X-CMS-MailID: 20240214225943uscas1p21ffa8b362bac11379168b83e42159160
CMS-TYPE: 301P
X-CMS-RootMailID: 20240214225943uscas1p21ffa8b362bac11379168b83e42159160
References: <170795147587.2393.15577527626926144858.stgit@bgt-140510-bm01.eng.stellus.in>
	<CGME20240214225943uscas1p21ffa8b362bac11379168b83e42159160@uscas1p2.samsung.com>

SWYgYW4gU1ItSU9WIGVuYWJsZWQgZGV2aWNlIGlzIGhlbGQgYnkgdmZpbywgYW5kIHRoZSBkZXZp
Y2UgaXMgcmVtb3ZlZCwKdmZpbyB3aWxsIGhvbGQgZGV2aWNlIGxvY2sgYW5kIG5vdGlmeSB1c2Vy
c3BhY2Ugb2YgdGhlIHJlbW92YWwuIElmCnVzZXJzcGFjZSByZWFkcyB0aGUgc3Jpb3ZfbnVtdmZz
IHN5c2ZzIGVudHJ5LCB0aGF0IHRocmVhZCB3aWxsIGJlIGJsb2NrZWQKc2luY2Ugc3Jpb3ZfbnVt
dmZzX3Nob3coKSBhbHNvIHRyaWVzIHRvIGFjcXVpcmUgdGhlIGRldmljZSBsb2NrLiBJZiB0aGF0
CnNhbWUgdGhyZWFkIGlzIHJlc3BvbnNpYmxlIGZvciByZWxlYXNpbmcgdGhlIGRldmljZSB0byB2
ZmlvLCBpdCByZXN1bHRzIGluCmEgZGVhZGxvY2suCgpUaGUgcHJvcGVyIHdheSB0byBkZXRlY3Qg
YSBjaGFuZ2UgdG8gdGhlIG51bV9WRnMgdmFsdWUgaXMgdG8gbGlzdGVuIGZvciBhCnN5c2ZzIGV2
ZW50LCBub3QgdG8gYWRkIGEgZGV2aWNlX2xvY2soKSBvbiB0aGUgYXR0cmlidXRlIF9zaG93KCkg
aW4gdGhlCmtlcm5lbC4KClRoaXMgcmV2ZXJ0cyBjb21taXQgMzVmZjg2N2I3NjU3NmUzMmYzNGM2
OThjY2QxMTM0M2Y3ZDYxNjIwNC4KUmV2ZXJ0IGhhZCBhIHNtYWxsIGNvbmZsaWN0LCB0aGUgc3By
aW50ZigpIGlzIG5vdyBjaGFuZ2VkIHRvIHN5c2ZzX2VtaXQoKS4KCkxpbms6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LXBjaS9aWEpJNStmOGJVZWxWWHF1QHVidW50dS8KU3VnZ2VzdGVk
LWJ5OiBMZW9uIFJvbWFub3Zza3kgPGxlb25yb0BudmlkaWEuY29tPgpSZXZpZXdlZC1ieTogTGVv
biBSb21hbm92c2t5IDxsZW9ucm9AbnZpZGlhLmNvbT4KU2lnbmVkLW9mZi1ieTogSmltIEhhcnJp
cyA8amltLmhhcnJpc0BzYW1zdW5nLmNvbT4KLS0tCiBkcml2ZXJzL3BjaS9pb3YuYyB8ICAgIDgg
Ky0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNyBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9pb3YuYyBiL2RyaXZlcnMvcGNpL2lvdi5jCmluZGV4
IGFhYTMzZThkYzRjOS4uMGNhMjBjZDUxOGQ1IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9pb3Yu
YworKysgYi9kcml2ZXJzL3BjaS9pb3YuYwpAQCAtMzk1LDE0ICszOTUsOCBAQCBzdGF0aWMgc3Np
emVfdCBzcmlvdl9udW12ZnNfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsCiAJCQkJIGNoYXIgKmJ1
ZikKIHsKIAlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoZGV2KTsKLQl1MTYgbnVt
X3ZmczsKLQotCS8qIFNlcmlhbGl6ZSB2cyBzcmlvdl9udW12ZnNfc3RvcmUoKSBzbyByZWFkZXJz
IHNlZSB2YWxpZCBudW1fVkZzICovCi0JZGV2aWNlX2xvY2soJnBkZXYtPmRldik7Ci0JbnVtX3Zm
cyA9IHBkZXYtPnNyaW92LT5udW1fVkZzOwotCWRldmljZV91bmxvY2soJnBkZXYtPmRldik7CiAK
LQlyZXR1cm4gc3lzZnNfZW1pdChidWYsICIldVxuIiwgbnVtX3Zmcyk7CisJcmV0dXJuIHN5c2Zz
X2VtaXQoYnVmLCAiJXVcbiIsIHBkZXYtPnNyaW92LT5udW1fVkZzKTsKIH0KIAogLyoKCg==

