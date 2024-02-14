Return-Path: <linux-kernel+bounces-66090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEFE855689
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B23BB2634F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECD01420A8;
	Wed, 14 Feb 2024 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MlBIxBfa"
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEE51419AC;
	Wed, 14 Feb 2024 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951592; cv=none; b=Ya+HvEuEisG5v6M1h1f2PAF3pOCkfcP/qSXlY4JJ4iu2CWb4DEcgPbUKU8WbXsR2bds3dnB/OxGQ3IgybbT5KTtROK08Yzhqfh6lpXRiEPTNt6qE1z7ejMrpUGswP4ELogxOBd14BvqinyqvhOmPJcLmTYlVCjF+JksgqREukbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951592; c=relaxed/simple;
	bh=4dqGokGdhy1xJ0FLPp2+hNGb5PkT3Xrir0Am1s+UV3I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=UPgkJmkea5n+UKg+d48navn3tV/7ssfAM8aXzawZmiYchHbSEv0wDQ0Cm5BN/kp7F7sPaqKW1pSBuCTWqwK9QhBdpiRfZo72dPzUlrgdPQpAsk3hkz3PO8BkcjCjwRC1iiD7AT+xU6AYBqmvjbH2Qgx+RaftF6x9RFAOoqZnlS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MlBIxBfa; arc=none smtp.client-ip=211.189.100.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20240214225949usoutp01fcfef7c201676a007d1e4b6877c0a57a~z3OvmfP7g0141401414usoutp01K;
	Wed, 14 Feb 2024 22:59:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20240214225949usoutp01fcfef7c201676a007d1e4b6877c0a57a~z3OvmfP7g0141401414usoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707951589;
	bh=4dqGokGdhy1xJ0FLPp2+hNGb5PkT3Xrir0Am1s+UV3I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MlBIxBfahZgK8Vvj+fgWVrQgbowiV7gdsp9P5RLN5YkHryju3JRakvPbp673MLVbQ
	 hBS1FvTEZbf5Sol4CH74/+ZyoX5FXt9y0BRR73K24MNfh3Hj7sWlI/00MQNY9t315S
	 bYa1F6vv8HK50BDac6vflnK7RjE/NXEslDyqGL44=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240214225949uscas1p2c39aa3d52cbd2300706548d583e6a2a8~z3Ovanry53221832218uscas1p2I;
	Wed, 14 Feb 2024 22:59:49 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id FB.B6.09550.5E54DC56; Wed,
	14 Feb 2024 17:59:49 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240214225948uscas1p2178d37968dc620a7e317ce3b0d57ab04~z3Ou_2Y9N2193821938uscas1p2r;
	Wed, 14 Feb 2024 22:59:48 +0000 (GMT)
X-AuditID: cbfec370-933ff7000000254e-41-65cd45e5dcbd
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 44.F3.50167.4E54DC56; Wed,
	14 Feb 2024 17:59:48 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Wed, 14 Feb 2024 14:59:48 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
	14 Feb 2024 14:59:48 -0800
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
Subject: [PATCH v3 2/2] PCI/IOV: set iov->num_VFs before VFs are probed
Thread-Topic: [PATCH v3 2/2] PCI/IOV: set iov->num_VFs before VFs are probed
Thread-Index: AQHaX5mCLK4WlF8EHEe3pPHlJMI8cA==
Date: Wed, 14 Feb 2024 22:59:48 +0000
Message-ID: <170795158776.2393.11628830004240634947.stgit@bgt-140510-bm01.eng.stellus.in>
In-Reply-To: <170795147587.2393.15577527626926144858.stgit@bgt-140510-bm01.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <055EBCC164A1E949ACB3DD83D73DCBF2@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7djX87pPXc+mGmxZy27x7X8Pm8XdxxfY
	LKZPvcBoceJmI5vF6ptrGC1+XZzGarH/6XMWiyv/9jBarFp4jc3iTHeuxaYNT1gszs86xWIx
	b/1PRovLu+awWaz/+p7N4taEY0wOAh6zGy6yeLQcecvqsXjPSyaPTas62Tx6m9+xebQ8O8nm
	8X7fVTaPqbPrPT5vkgvgjOKySUnNySxLLdK3S+DKePS9gb1gC0fFg5e7WRoYZ3B0MXJySAiY
	SFzb/4O9i5GLQ0hgJaNE4+5ORginlUliw5HbzDBV9ze8ZoVIrGGUOPZgGxtIQkjgE6PEjwNm
	EIlljBIPF09nAkmwCWhK/LqyhgkkISLwkVWib8cUdpCEsIC7xLsJS1lBbBEBH4n/904yQdh6
	Ev0zN4NNZRFQlfh2AqKGVyBS4sPzhWBncApESfz+/IIRxGYUEJP4fmoNWC+zgLjErSfzmSBO
	FZRYNHsP1NliEv92PWSDsBUl7n9/CXQDB1C9psT6XfoQrXYSxw8dgBqjKDGl+yE7xFpBiZMz
	n7BAtEpKHFxxgwXkFwmB9ZwSpxdNgJrvIrH072OovdISV69PhYpnS6xc38EEsktCoECi4UgQ
	RNhaYuGf9VC7+CT+/nrEOIFReRaSD2YhXDcLyXWzkFw3C8l1CxhZVzGKlxYX56anFhvnpZbr
	FSfmFpfmpesl5+duYgSmxtP/DhfsYLx166PeIUYmDsZDjBIczEoivJN6z6QK8aYkVlalFuXH
	F5XmpBYfYpTmYFES5zW0PZksJJCeWJKanZpakFoEk2Xi4JRqYLJ99ezBstcOy1oXLY9Icc4W
	kv9irslXOaN0LheD/I7q3UZ1R0IYMyVde/u/dS75NWeZXMfDK+veuYX/vXYxOTJBLLCGY8d3
	r5+GDHmNblbyv38lnn7nfv2s6JN/q4r25zz9cODiz9X/b8Q8eZveZc0xb25HgrU416+35+qf
	H/2v0fX6jLmn4Ytmm9UXdt8R3ih3qcPut64PZ7XdxpWhdy7tElny49shzassv/czvWBrSzxS
	7a9zyOr/8RCB/e8FtnjsWrS5S8Noe+6rrad7NrL8fTWjJtytuqK9ZF7bdgOXU5f4lSZ+i0gS
	+BLaXSez/IfJiTNPrSQEqr+xckmeyXm24JBRWbP+xbKfGh36DRpKLMUZiYZazEXFiQDHa8Vz
	/AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsWS2cDsrPvE9WyqwcN3Ghbf/vewWdx9fIHN
	YvrUC4wWJ242slmsvrmG0eLXxWmsFvufPmexuPJvD6PFqoXX2CzOdOdabNrwhMXi/KxTLBbz
	1v9ktLi8aw6bxfqv79ksbk04xuQg4DG74SKLR8uRt6wei/e8ZPLYtKqTzaO3+R2bR8uzk2we
	7/ddZfOYOrve4/MmuQDOKC6blNSczLLUIn27BK6MR98b2Au2cFQ8eLmbpYFxBkcXIyeHhICJ
	xP0Nr1m7GLk4hARWMUp0LNvPCOF8YpRY/P8rG0iVkMAyRom1jW4gNpuApsSvK2uYQIpEBD6y
	Snx+MJUdJCEs4C7xbsJSVhBbRMBH4v+9k0wQtp5E/8zNYINYBFQlvp2AqOEViJT48Hwhcxcj
	B9CCSIkJ10tAwpwCURK/P79gBLEZBcQkvp9aAzaGWUBc4taT+UwQVwtILNlznhnCFpV4+fgf
	K4StKHH/+0t2kJHMQHeu36UP0WoncfzQAagxihJTuh+yQ1wgKHFy5hMWiFZJiYMrbrBMYBSf
	hWTbLIRJs5BMmoVk0iwkkxYwsq5iFC8tLs5Nryg2zEst1ytOzC0uzUvXS87P3cQITB6n/x2O
	3MF49NZHvUOMTByMhxglOJiVRHgn9Z5JFeJNSaysSi3Kjy8qzUktPsQozcGiJM5794FGqpBA
	emJJanZqakFqEUyWiYNTqoEp/5hHuALDXtYrHie3lKStF7J+r1VuqHQ2W+Hua6uWKzvjXCfK
	K/A3LCpP8Who+iJf4P7zTcXLthmm0pcFN7zZlNymf6qo5UFb4u6F66QmHt3S0640e3UT67L9
	L35tu5byo4b9mmJs+4Jmn0pzdtNyX1HvxFNmRxar/3m2c4Ln4ZMGM9/lF63ab9BwZLLC1Wdi
	2x9KsrAWvlofoet3Rq/8xIGk9oXKl04bFVdPvCskrLTcuOT925Azv6dP/+B4o8LxocR+scPV
	q7abvTrs9SrII5tL7v+bk9yhdoeipgWedrvY+jPTT2r60Ze/zJiz2Y78WV3Gufd84fJ3Lwx1
	fvLLzVI7xnHf/qnNUisN1khdJZbijERDLeai4kQApJE7vI0DAAA=
X-CMS-MailID: 20240214225948uscas1p2178d37968dc620a7e317ce3b0d57ab04
CMS-TYPE: 301P
X-CMS-RootMailID: 20240214225948uscas1p2178d37968dc620a7e317ce3b0d57ab04
References: <170795147587.2393.15577527626926144858.stgit@bgt-140510-bm01.eng.stellus.in>
	<CGME20240214225948uscas1p2178d37968dc620a7e317ce3b0d57ab04@uscas1p2.samsung.com>

RW5zdXJlIHVzZXJzcGFjZSBjYW4gc2VlIHRoZSB1cGRhdGVkIG51bWJlciBvZiBWRnMKdmlhIHN5
c2ZzIHNyaW92X251bXZmcyBiZWZvcmUgdGhvc2UgVkZzIGFyZSBwcm9iZWQuCgpTdWdnZXN0ZWQt
Ynk6IExlb24gUm9tYW5vdnNreSA8bGVvbnJvQG52aWRpYS5jb20+ClNpZ25lZC1vZmYtYnk6IEpp
bSBIYXJyaXMgPGppbS5oYXJyaXNAc2Ftc3VuZy5jb20+Ci0tLQogZHJpdmVycy9wY2kvaW92LmMg
fCAgICA2ICsrKystLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9pb3YuYyBiL2RyaXZlcnMvcGNpL2lvdi5j
CmluZGV4IDBjYTIwY2Q1MThkNS4uZWJiN2M2ODkyYWQ2IDEwMDY0NAotLS0gYS9kcml2ZXJzL3Bj
aS9pb3YuYworKysgYi9kcml2ZXJzL3BjaS9pb3YuYwpAQCAtNjczLDEyICs2NzMsMTQgQEAgc3Rh
dGljIGludCBzcmlvdl9lbmFibGUoc3RydWN0IHBjaV9kZXYgKmRldiwgaW50IG5yX3ZpcnRmbikK
IAltc2xlZXAoMTAwKTsKIAlwY2lfY2ZnX2FjY2Vzc191bmxvY2soZGV2KTsKIAorCWlvdi0+bnVt
X1ZGcyA9IG5yX3ZpcnRmbjsKIAlyYyA9IHNyaW92X2FkZF92ZnMoZGV2LCBpbml0aWFsKTsKLQlp
ZiAocmMpCisJaWYgKHJjKSB7CisJCWlvdi0+bnVtX1ZGcyA9IDA7CiAJCWdvdG8gZXJyX3BjaWJp
b3M7CisJfQogCiAJa29iamVjdF91ZXZlbnQoJmRldi0+ZGV2LmtvYmosIEtPQkpfQ0hBTkdFKTsK
LQlpb3YtPm51bV9WRnMgPSBucl92aXJ0Zm47CiAKIAlyZXR1cm4gMDsKIAoK

