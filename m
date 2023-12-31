Return-Path: <linux-kernel+bounces-13657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91005820A6E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C445A1C214E2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 08:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9952020FB;
	Sun, 31 Dec 2023 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rbjjdll8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C517C7;
	Sun, 31 Dec 2023 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704011964; x=1704616764; i=markus.elfring@web.de;
	bh=Nx5AiU9kG4mlRgZKJZE6QHd/i2gpSelR/eMf8alkr2U=;
	h=X-UI-Sender-Class:Date:From:Subject:To:Cc;
	b=rbjjdll8c1mWMOyItNH49l1U5BtNemIprbvZkuuWWG4L3b/Qe8A3NrD82y1YP7on
	 E401AX9OYwdmQotSBCH88C+AmO3gu8+ZE/3RjnWs667osM5cTNgqEwQbo36TSDi1y
	 820SpwHd+Fv709lLf+RP9sQlwW6nJOpPCU9zHAXOZ4fSwDyecvak2zDJg0LbV3pm9
	 SywtldKrhlS+Wp/wnNqE9nLojhNpeWlOhdJYtTk2VDjv08YB0wc68bHVgS90dCziB
	 JWczzMbEHLFj2ykS5pm09q2Cs5dNKZYKnBgQG/SOj0mNw3MwfWcC9yYfnoSe3MyBx
	 JJwrISIWcJNM6u2V7w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWi9q-1ri6K42OHA-00XQUQ; Sun, 31
 Dec 2023 09:39:24 +0100
Message-ID: <ebffa8ea-8d0c-4b83-805b-754e25bd4603@web.de>
Date: Sun, 31 Dec 2023 09:39:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/3] gcov: Adjustments for two function implementations
To: Peter Oberparleiter <oberpar@linux.ibm.com>,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VYK5fVj/h+Jgh14fsFuXa5QWRNakQWSBEYW2sDP8UfsLeuTRie3
 h0QgkSzl2ZEwG+RBCfIBPk6ifpXNcVlRtKMNdnXtKW3bVz/8gcU3dZT0ztGgqrpa+bDuOO2
 LA/eu9CUf+91tMNLDYTq4GVDmw3Zmkes8dV6bK4r+EdyvdQTtwiFbeQSTrXMl0Tk5Av/Ncu
 TseRNwHg2hzPkieuzmiEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y/EHK/WHi0w=;hZo5ekWKvfOtJFvtF8VAI5zdG9s
 sZLMsrBhNYn0jd1p1G5cCPrCfH9nrhUnyXbx6n02pat2MWFoZJGKihtJjFJfbJnwP3ayA42Ms
 pHKekkgKqLbphCOXbtd3jYXZ1DmEpTNn3ayFtvkXszb4cE6VC5gmebJRPN9aaR3sDvs1FHR8a
 SEsuTOOgdDvlO7gb3jypFjT07M6lwR9H3IGFzQzrcvw5B38AJ9uyqRnNe2ff5qmOtKEcfHDh3
 /8l1ZWSaUDyabGtz3wWK7hPECmpL2ZOpahbG5DD98owkYLdJlgczlbZMkl+JZJhkRTmdUm7Sd
 A8tOZrPs/LIODKVQdB1KV9c1r/FgWAqdxAsrcq6LlvSqnmx1sZAHx+slGO7e2lc4sXmE7yvFV
 xwL90g77SXequFxGzign959dY8r459LF+14u4vCpWxftpHmTJUbjmgByr1671ctjMD2tSTxwo
 sXS6WTQmSZ8qcMOkdcUY2XHuLm3v6bvx7yfiAmKU1l3kjwTmFOof+6bNmfORJ1XrWR55AZSOH
 np+0l0BbNPh3VborXxs4Jz73UkcQVZlPMq4gyQcs83d21b6d4L6b6uWZku9zkpeuQHwSmL8u4
 UH4u+L48tkZKEUg16SPJcKcnpKPyoH1vkUdi6u2l0XvNm1naoTKMO5JgE5eejHk6FOt0ZHmAJ
 P+jq0k0KdYpu27+NREUMyjJr8exi2aAjv6m007yv96kO2FnTPqK8jfbj1avQneSAtdNs78YaV
 7ezWn0c3KnGYNzD6CY7dLkB/hfQVDED6Rf/Q7TvUrUFHL8Y5293pMfIyzeZJiwLX/0NuTYTK9
 kdreasCMegdvAkTmJ7nBFkQf2kBEkgUte4pFQNfxpxjzWGhk4xKBQO+jl6PYxjrH5Hd5GyG7I
 VGokDmrmM9XbDItxWicN2tvkcMaIZpuYHg0Fy4j55Ptritoa1WaaufH1XDW2MF7AP15smd6jF
 2aX29Q==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 09:34:56 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation in new_node()
  Return directly after a failed kzalloc() in new_node()
  Improve exception handling in add_links()

 kernel/gcov/fs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

=2D-
2.43.0


