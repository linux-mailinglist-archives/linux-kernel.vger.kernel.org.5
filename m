Return-Path: <linux-kernel+bounces-159987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACA18B3740
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB3D1F24250
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26728145FED;
	Fri, 26 Apr 2024 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="q4EABXFn"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C74F14535C;
	Fri, 26 Apr 2024 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714134558; cv=none; b=KDede91p+vC/O5Wg5xWS6w21+wzInr5mQZUez3UZw6Tr0rQBLTH1yQDa9hu+2Y0IEDajJYGardPhXkMbOk2DcVNZjlZ3jUVx6inUz+YUdnnqkP9kDPf4CIxl6rus8WaumI0Tvej8VtzL5lapUOTE37eH8rNXIJdlJWTOiez7JN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714134558; c=relaxed/simple;
	bh=H4p73NShfY5YEqWp7dPCAHt3mIwIFXwsuZPdnZOnwYc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NQm42F/rtqU0y8x73aNIgW/YljeYp8kobLar3CArNxZigFCe6ydeMeugCH/3HhcoGIWq4cmhVlH1VRdVDm8ggkbWha7G1tlGGmXU2ynKmvHygtG9Ra57D0x0foganLqC8OxGAvEGxCRvr6mX9kudccdH8oxTtJaArjA29oifR/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=q4EABXFn; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714134525; x=1714739325; i=markus.elfring@web.de;
	bh=mST+U+wJ6B+mYy57rbG1uACdL69LsS+O3Z/CbYAv0JU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q4EABXFnG7Gexe7YQbV/SxHcb8p68+yWYEecI7nzT3pzxaTW9SYDoRKxFtA5t0Vb
	 D4fjPL6A1vffMLxFburoAjTnXKU2EjGRLbOjZdR8QsiKQbCXpW+puTAOQPs/LezXm
	 kLSQU685FeA4ZAzheYsMnbVnVnIHKogAu00V9BhPVC/ozhVwGRWFWCZ/l0sCkjSjj
	 XKjz7wMlqYPNImHE/zgAs18H7mYeba6yk3J2MeBc+rt/jUs/mCnHIVFpGScNuR8AG
	 aVabMd7mcmqTUXuq5WJRiA8HV+ZvQVA8dRgEZ0ftIJTQHvAPA8TVYLTQ4vCS05vw0
	 NTOqRnC+sip3q81BoQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4eGJ-1siZB40xrb-00vGRE; Fri, 26
 Apr 2024 14:28:45 +0200
Message-ID: <42c5d1f0-d16a-483b-8bb1-4c5768aa3a8c@web.de>
Date: Fri, 26 Apr 2024 14:28:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: lumingyindetect@126.com, linux-serial@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jiri Slaby <jirislaby@kernel.org>
References: <20240426114716.1275085-1-lumingyindetect@126.com>
Subject: Re: [PATCH] serial: 8250_lpss: Fix memory leak in lpss8250_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240426114716.1275085-1-lumingyindetect@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K0LIFsUWA2FDQcBUvUBsrmBxoRuc2xMc+8BbJxJCbdF3i89gYsF
 9JA6MRNdjpgs0PYw4y+BQOYyF4/HiU5YcFrUn7kr1I5OetyYxtAacJFehMEqerevYi7fNht
 ZiQ4/fIiDjZVYxf/o0CM36ZvVFF9soYFUw8l4x7/uAsVIcKl/YTi2zSmGe4bVM3TYvnxYA7
 cHV5ymDNWdnT9D6mnoRYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ciZyN5Jlt8Q=;C/Iie5z125EquYpm2Q+F+1hhRhp
 aGR3YA2W4MZY1uaMUVFv8JV6rfuEvho3081LHhC/lsxsrPqf3YIB98uKcCqoIjEYyK9WyBqDA
 aH0IXzswPU4b++xjmqJJdXmFmhV0Zb9IHoyFMEZT7ruP88B12Bmw4clemsR+WGDhbKiVaQIXl
 LgiJUC06k5aGDWFTqmjRBof1DqVNJkUR138NlaIYb3aPrPVOztN2MwylFYuarUT1ZZ+COjKz4
 AjkLJWuHBNzzZs6syH3uy2d8iOx/XE6/TjTOC6iyv3j3oo8ZRstx7gVC3GY4nCvrtY6PQ56WT
 30qcmFx81DMJxFZ3AybdBz5IxJKUravLMt6Ds0vesZCnhJ9aN+ojoJcA4BDM7V/LlxKWzxjas
 B+/AJMo+RvbnR8gl6UlbC6y2Ss/nx4AN8/e599niUqbXdqVz+twj2m3J1KttrP58uEoGaNBgd
 d49vgpgx5NgUfKSwhuVouRwf9hssrB7Xly82/7qz/QicrSQvlZlfts1q7vKJPh3ry4EC1pViA
 ScT9fSK2lqrMbpnJZ5IRWOES9Vm9iss69+KXmuBSslYo3KxC9CgT+lIAt2KuqpyNnb+U2uMOI
 NWLR0iLEcXoj9ESAjxN67+1mtF2gnjrC4zPU5sssk7kltZRyyQZffocVUywvZVHCCKvKgKGZw
 t5lza2RksqXK0nSejuudvvU4U0HATorWOIDgOCeSufkUpUjsQifqMhkTK0aEYvvCRBqWvtPJR
 37A70Niu5iuu4EE9b/QlSU76IlneLCnoeQKRD5Cd9AivrP2faHyMehWz2UDNI/jogcgGYNVyZ
 E2tztddjhlApeKqWtPRLI1oUumG0RQT5jnRCJoxQ0IsuU=

=E2=80=A6
> In the lpss8250_probe() function, I added a label named "free_irq_vector=
s" to release the dynamically allocated memory region pointed to by the va=
riable pdev, and replaced the two return statements mentioned above with g=
oto statements to this label.

* Please improve the word wrapping according to line length preferences
  for change descriptions.

* Please choose corresponding imperative wordings.


> Fixes: e88c4cfcb7b888ac374916806f86c17d8ecaeb67

Please add a commit subject for this tag.


> Signed-off-by: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>

I find the author email addresses suspicious according to the Developer's =
Certificate of Origin.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n398

Would other email addresses be more appropriate for desired patch communic=
ation?

Regards,
Markus

