Return-Path: <linux-kernel+bounces-11443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C2181E671
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A64A1C21C61
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC134D11F;
	Tue, 26 Dec 2023 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RKGJQpAK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC64D581;
	Tue, 26 Dec 2023 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703583379; x=1704188179; i=markus.elfring@web.de;
	bh=7s7Czem3g9WjULia5nQz77gt2Cg/2yiGOV1liYLC2qQ=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=RKGJQpAKm5ThzCXd5Czxs97SHfHgJy6K1Fykn06cIGR/3Pg+EU1Wko9eBf8kX3Ac
	 hHHAvx7MUOmqxeXvI8PiLIQEGgpmHqXUdFH8iSYw1OkCvbJzTtsHe2EiTJcuW85Zt
	 Rkjt78lwpJPItp3tPq89lfUZBqc1crSuVKsxtuIHrHv4ppkd9EIg+npdyFUE4Bbj7
	 q7JtpSEgqWxw293DsBBjY+MDVfkfT3KSscm3nN60ZdyLX0M7NwMJrl1zFiWExf1CX
	 Ny1zjOTckSOmTXPsoJQ8YakpWQKR2MhIgcbHwYYdInPdkMi6DzHgXj50wfZmllFT0
	 F4WXAmaDTrMRKBNNxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmhnu-1qs6RZ3Cy6-00jyS5; Tue, 26
 Dec 2023 10:36:19 +0100
Message-ID: <ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5@web.de>
Date: Tue, 26 Dec 2023 10:36:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/3] drm: property: Adjustments for three function
 implementations
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DcL70u3CW7ium0TLeQa8v3pqMAuHd3U3ffavREKGtKtoIotqohU
 vVm/sRhXjJKwXOYQ9pFWJucZSe+994yhW2o0ijsxi6iHZ/Q0zgliCRzPJonYzGsCVBbzBz/
 0zNekbaZqRGP3FS8eocU6giczTt17vn0lz2CUyuIihbAwCRdssrlhFRRrdRUfkOPsL5/oRF
 eZxsilcj30qz1vpdWDsDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O70ZNeseb0w=;E0IpgcOt3k0QKhIiPQyi/vzDRWf
 mJZZOh16XhhSfBHeGgCmmmSiX18pqy5Y6qilWjUOu6W+eeB9zc0h1HrD/pj+eLl+ZJtzGZo8u
 X2N60+S+57ZGtHEAj8m7jwQ4fJhydvSb4UOkfcy+1phgWNSCvg8QD1zdOas7hKjEcn+/ak49D
 EFtFNq/8G/V5y/hLLfc6qlCOHcj+iin08EsToosg8uhKfbYZh4UqOy0pN+1ewI7cPHzN+Rq3i
 XU1ZYQnUJjR0Ht7/enF2mFPy0b3pZmlED3I0oqwPbX6Y3xjPH0qgP1MfcjipvcRMhrLIFQaAs
 9ry03jYhcLfmHUpWJ9Am6ihqpODTvlwL93ssMk8UNPj0SAOhE31mCi0MTHhbY1hfyilozzkKr
 tM7K0+oBzCKRoIRU/oajPIKE85DLpOOP1lpYnjYb+waX+WliBfIBDYe830X3Aico/KAZOWqHc
 KZt36PIdoXSLYqBH7QSabTDUTJPT4a/mzNNZ8kyssSEIJh14S3MSXuSRTa+SNQW1Lpqd8q+qv
 LtGEwnyhJXdDA5tLZytgBuiitLXw8CB7MDxP8xFkK+BeBniJy0XtV6ryxwpLtsgaoT6EY+DCw
 24OtmHsVgtC0U/iQGZW2hUVoLgHMi8lozuzrRQe9sOfp02PS3Y4TR+rs2ZTdS7bzvVdiurtAz
 P+WV4tjbtPXAtwS/iaSJjdxXy8ghymm25A8RlXDOjqN8PPOOx208Jexa+5cgrOXvU/y8JgCmb
 hvsoY8HvqmgIIFOaOwaSNVpYBWGrXguJUcCWy6H7NbAPqG2/GDkN0YywnnMeaVD0QLrG8RMaA
 GUWsH/0wFqaxoe0ml3fqEcLm4g1OQb+8kmrjTu+2eEWuUWe03rdNEHjCWxQABxmJb1NkZITbg
 AlWnI89SchtGPGkdwUnbbWeOXWlxUF+5DSGdz35lxgCvVmnZxQkFnkJL4Rn6x+n/PtGrovMtw
 n5Ur+A==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 10:26:36 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  One function call less in drm_property_create() after error detection
  Delete an unnecessary initialisation in drm_property_create()
  Improve four size determinations

 drivers/gpu/drm/drm_property.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

=2D-
2.43.0


