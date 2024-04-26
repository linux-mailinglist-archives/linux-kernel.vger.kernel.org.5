Return-Path: <linux-kernel+bounces-159692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 985B68B3246
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5411C2829E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1198913CAB6;
	Fri, 26 Apr 2024 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BcsfrSPI"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB65A42A9B;
	Fri, 26 Apr 2024 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120013; cv=none; b=YMyUwiZbQTd4a2YvPsSpKlPtiJWqpMiiC0/CrBoIyU0O63jEkaksNtDRTE9V03GN/ykuEGHEsZrn8HWNgTabQMPM4LDOqHjx3e7ybbl+ok8CdHJdzALwsAIfn6r+jEX4tAQ13XZ768s6WQa/h4UHXoZH8ohHAVliZR+52qonbec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120013; c=relaxed/simple;
	bh=8pVQsFc9e2tQaYnUmWtJ7P8GYTSfTJM8Tba6mAmz3Ts=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=KL3SpAvkM3uAdrEM4gXtv1eDF1+HH3DBdDz9WJFPgO07j8baujjCmR8ykHBQ5LDbJ/OqDM3Oa6aRroNr4r0MQz91J4ZjBQHMnetDYK8WlLfRQHtIRi6VbhHv4OLMPPYRhHBOAFStMKujPT7FrCharBJCj9zJm9IHka7arM+pI/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BcsfrSPI; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714119984; x=1714724784; i=markus.elfring@web.de;
	bh=8pVQsFc9e2tQaYnUmWtJ7P8GYTSfTJM8Tba6mAmz3Ts=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BcsfrSPIXPT5U/digXkHgoLAM0HjR7MOpanXEte2nRUPxLnsZb93Fa9k8MfEmB8y
	 PVAulXIRAJqPYODCq43CxquZyHZs4dU7Ebq0tbNylJIRiUjOBvfvv7whb95pVxpq8
	 i0xvoW/aeeUAZDshkn7yCLZpNLzs3QsFwsLXz2NVl6ertZRFJRE9YwT5GAxEixvxw
	 M3xcc9i/3fQ+Lv75HksCXXDQhMHQEvBDnX+NS7JjC8QOKj3YMq3qtIVck6TrmVlGy
	 igLvQ//NMOH1MCoWZBGBzd+keJ7gtHC+lA9Bno+JH2TM5BfonbdateVQIh8Sak0PK
	 RPVk5LP2VFnNaveGxw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCogm-1rrRCq1A8G-006T8Z; Fri, 26
 Apr 2024 10:26:24 +0200
Message-ID: <964b0005-3a9d-499b-91d3-171a3c917b4a@web.de>
Date: Fri, 26 Apr 2024 10:25:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sungwoo Kim <iam@sung-woo.kim>, linux-bluetooth@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, "Dave (Jing) Tian"
 <daveti@purdue.edu>, Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
References: <20240426072006.358802-1-iam@sung-woo.kim>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix slab-use-after-free in
 l2cap_send_cmd
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240426072006.358802-1-iam@sung-woo.kim>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7I8MMJ3+llChUL62IO6Flhz1ePooA/kw1bKz/w0zXGcvAB0i5OQ
 VQF7QILJ/BMe7dfvL+Uv5jPuwteuEZCO0xDrBz5neXZrkIblnUTaDmSdFwTPVVUs6eKZxHg
 YhGCf1w7h7JrjJi/r4uPh7MEjxzwTU69AKOJSKRjlZPvrw3hl+IRRHRTbVE7sZ7QMUrwRrO
 W0KhKqOXDKIxDU4YVFCjA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eQvVI7Nbi6s=;LW1EogrDkhHEGEMsPOBCIVyHBlc
 nLTWINc5YBbFVzpsqft8ZBR4rj+teM85Li2sybkIxfGJQCJDcX6lA7UewpPbQ4bHNhQMd7mtn
 ABfGWKJEOJl77uuIwf+MTSesOPfKIkBpYo0WC0UvLscavIhkIDL5xLP471LMDJAB8MLcNGI66
 dO/uBQkF1Fe8mzfmVi9lpdGzalF345wtTkW7vXRk+WY1A9xPIJLLqCklemAkfOD3lrFCsPCku
 Ku6OEoQ0dYDvsQsRqsIqLL68nxkGpNosuQbNypBegbVVbJ75i9p5CubikViZhmDnjcAsAEO8D
 5c2yQcFKKeBQXPMBsEqK4IfZfumRnY3nVw1Qc8Td4K6YnpiigQ+VuHSEAOHxqxFVrRDo695lR
 YCZ9usbuLCJd9BQOJL6ytBjpDUwY/oUm1RJD2b+lzM2Q+/HacCMCT6xmjoGzgJxheMn8T4J2C
 4htBST39yRrlSlCTvDn56e9Nv4q6ZHuUhByMqk2e9pQ3/nc90sWdp6wVXsj4qvE2UryZZTm0x
 z1YA5T/6U4UHOECwXyARwbFTwN9U7o4GcsNcE3u+sLMUlmjyd01ZJTUBbaHWZQMe4x6WLXtLd
 Aa8vPsoiTpj41eTdwEvoKLLlkKYY/4ZeIVlvFqvxSl9DDpuvKFhszDkZl10dtPpf0AFWTt25X
 qXD4qQ3UuAVIf583IFuCLQOeZlt8Z7JaBctPWmCv8XWwehaAehY55UMb6HPrqmu0QfSIYI6T2
 +P2IBdY+cP7IgM2OvVdYAoEQy/Gjl9bNGtdQ6yxt8QO1re+WlAKsAbK/KLmz8rxNlQ7Hfm87l
 w7oQ/VI8ll7vyZCqXgkvI7/klqH/iheotDx/MfvjH9yk0=

I prefer that you would put recipient specifications also into the message=
 field =E2=80=9CTo=E2=80=9D
(besides =E2=80=9CCc=E2=80=9D).


> Hello, could you review a bug and its fix?

I suggest to omit such a question from better change descriptions.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n45


=E2=80=A6
> To fix this, this patch holds and locks the l2cap channel.

Please choose a corresponding imperative wording.


You would probably like to improve your patch approach further
so that provided data will be kept consistent.
https://lore.kernel.org/lkml/20240426073142.363876-1-iam@sung-woo.kim/

Regards,
Markus

