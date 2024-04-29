Return-Path: <linux-kernel+bounces-161889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D118B52C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE241C20F49
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDCD168CC;
	Mon, 29 Apr 2024 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="L+UCv0iJ"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724B0134BF;
	Mon, 29 Apr 2024 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377642; cv=none; b=AtZxpKuevIS3FB8+m24yZy4RBIX9rQw+8jA8Sgqyzg5UPJNla7446S1Tquy6hXVUGLMk6sVGDrwFiB+QWdQAFl1le3Gu4kUeHAucL/azs1U49uI8ZfyTPIE0en33w/lUUKQRQN+Jv5fIehLk1chSr4ol5vyzu+tdyNYJagAJAzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377642; c=relaxed/simple;
	bh=ytNJzJus/OX0eTS5w3imJL1s23mJSeiZOAp1S/ZJ+5Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VKw//VVqMZolOC/+cWkdrKnViVCe+n7mQH36puHzmYOUIJVB5PMBqgLkTFvzv8oN/amJmfPDDieNT4cHP49No3Z0O7JaD3CtI5dKkv6b8zk5bcj3b+Ms9UTcBfJQtmRWdreyb6q/8+z0uJTk4LVob1D+ahGknJWZKb9VuzgSEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=L+UCv0iJ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714377621; x=1714982421; i=markus.elfring@web.de;
	bh=ytNJzJus/OX0eTS5w3imJL1s23mJSeiZOAp1S/ZJ+5Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L+UCv0iJTkk+lxEPI4XkvpcVBn4lsIYWxRTOx5d9lQsXI9CKDNPMK9E4O36kJEsb
	 T5nQAVpmGy+fEnD4Y1o0ZFdUyAxhsBEquPg7vRf03Lvu5L5awk6D4o1zD+ybYK3zP
	 XrYrdsy90gOOqtZC+If0yGEHY/5Kc4aYoBolFzuCJJrI8whib56zKCvwQADbnz0Gm
	 Y40fd3h89in8xbK6caS1iO66dlz1JaGcoJ6HDIrePj2u7GgfxePVp/FbNIQIBiUho
	 MmaRO5wU3Zi3RD5YYGsWP8LjP9BF5zFxwT1ImUj7SyaPgxTncBmxIxu9xbK8L2uOv
	 zsj+VPc6bgcnq0gjVw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPKB5-1sJhd222l3-00PPx0; Mon, 29
 Apr 2024 10:00:21 +0200
Message-ID: <bdfa663d-9a00-484c-80f7-75d7fa130cd3@web.de>
Date: Mon, 29 Apr 2024 10:00:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Zhijian <lizhijian@fujitsu.com>, linux-cxl@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240429013154.368118-2-lizhijian@fujitsu.com>
Subject: Re: [PATCH 2/2] cxl/region: Fix missing put_device(region_dev)
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240429013154.368118-2-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GXJxPJq9phTQRXcUyaeFAvuvRS+7JX8ekPpml2Yk7eZhmvv1bjt
 gXJN7ITMHKefGrdyq914ydscy60sNG/EqUJeWMwhy6LqUYXAyL435uUY1ZGllSTBYqR970s
 MkKxUpa4/ntK6adN+fF07JuN4EFeh5Q+ffzoj8IyUqQE5PMtjGYQ2POsroBERpCrcB1kTz7
 Q/GpLi9oOrBqY5F1Gw6Zg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lK0LdDbRUGE=;dkRCz2+qsnwLrte2eAF7p/XE+2c
 ma2Q10FgbvtxYyfWWtW0ZKtgSyP/2OPTxmRja9jHkMGyMaX7LDe43lwIZxumzffgHuCEUf5Yu
 N3iIciV1wIfBUqwFdsU5UWrBoBJYyPvBomeiu/OsATkq7Egt9LiQC4kxhpj6mxcrA5bH6Y6+o
 8Uyp1W/TqcyQB79U+jGNZaLS3OqRmPyCt3PcZGOMQxhO6HxC0KDdCDlfDRDqrb/U03irGnak6
 x5X0kr8eRiCl75pmm/AVPUrzZS8JVaSRGYOznZSyNJIB7/RjVh1UJ0gsNGemiPuVfMh3nqI7s
 xG3QwXXnZOq+WEaUd39O3gq85jm4XUUiZlmdiZB0JtI7QXNuCKF15OeUV6jxcge8vfVQiyMxd
 pbUg1RwtcBL12VtpF3F6Ad+U7+Mailel8YuRzctdr9bHu+TKuepTE4THmOK/gsZnnkJgkz1an
 AoV1XhHCcVxFVmVwYbBtb3shDVR9QGHhc6rDw2MOfw7xtQH3UjX27C132jEBgnFZxPkxwrZiH
 irV2xW/q/9brIKg7nKXP68aW/zgFIV6ZW7RAcLE4YN2AwsMyrQha8dFkyhboJPvAnHZFqtFYJ
 NMZwCODI8E3B48R7bo0YA9mednC2ZWA3GH7lQJjRCjLNMfTPumSiTptqebq0tT/ZjDpCWQtAx
 WAuZrKNaU0KH0Lm8g4jAjzcxbBpuiV8QsoseFEKqLCoYTvpEglkZ3ipRur9PNeKU4Klz6+eLZ
 5PFtkPSl/s7+hstFP/HR3a+CgGqxMLiDMtHOqCWPrEZiz/eZX5Apn5c8PkxfiUxxp5OIzuLbC
 kAHTVVqXlKT2Yk2wEtnD6s2Z6GliCN4g92kx/omm5xzXg=

=E2=80=A6
> Simply put_device(region_dev) if region_dev is valid in the error path.

Please improve the change description with a corresponding imperative word=
ing.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n94

Regards,
Markus

