Return-Path: <linux-kernel+bounces-42505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA935840248
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C650B21BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C875645B;
	Mon, 29 Jan 2024 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MulYlYir"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF6155E63;
	Mon, 29 Jan 2024 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706522008; cv=none; b=k2N2F5WLOgAjAwrpeABIEGY2ljYnpVsdCrZFmn2/sg4PR84Z5p3dSNIXvWhieHQEKKx+0S7rQjkEWoX85eSZBiruE50Dvsgp0Lq44CZ7yF1hhoL+uL5D4VgP9aE7zjV+qYV/BrXueGHHsgAWzKHkDHL+VD6vJ39w8dcA4rzVm7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706522008; c=relaxed/simple;
	bh=PXPCn+oYLrnbt+qWU2Af2frSRG+t1bYgfk7qBkMYuQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApJE3NWo96F1/oG9qGhpOk9rpXWFiuicpyBG/YOw87HgKOnGUg5oo5GE6ztDw69B20GExa66SGMOeXNZA5dkNunUPi6NpcaKeu+EYhh/5Hq285P5rd5lZgZbHXsAK8Mj9l9mH2blg+NpS+5ZBRL0WujvQwzangkTTXxH+UsQIS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MulYlYir; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706521984; x=1707126784; i=markus.elfring@web.de;
	bh=PXPCn+oYLrnbt+qWU2Af2frSRG+t1bYgfk7qBkMYuQc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=MulYlYirkI6QwlOPVvP0zj0zAR1P99IaFr92JeF9mRHJRdM8PbYjopBdLCYqJCeJ
	 GoE40I1TyJKICLLT3AJtKTRfP+x6YcSz3vpRoT7OFlrS9Lql3yModydf3oRQ/dMdz
	 MS7kYUWCKat8DnH8Rz55wqiUHDGKo5KWkiyW0MuMIJTK6H3jt+g2a4fC/0aSrN9MA
	 qIGJAKGJW35tyDxgF/JIRykIIj99Wo1yu0q/rltI23bE58+cgLPB6RIJV1PDH+25i
	 ghPXmGQP8A9A0m/yasE7xuGThZdm820nK6DzHD+qISoqHvG051zXxHe5gwJHOdG76
	 DuASI53yA7GG9E/wzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M59nK-1rTHrY3FWW-001IKu; Mon, 29
 Jan 2024 10:53:04 +0100
Message-ID: <3ca56d3f-5a2b-4321-adbb-4e2c0d72b573@web.de>
Date: Mon, 29 Jan 2024 10:52:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] platform/x86/amd/pmf: Fix memory leak in
 amd_pmf_get_pb_data()
Content-Language: en-GB
To: Hans de Goede <hdegoede@redhat.com>, Cong Liu <liucong2@kylinos.cn>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <901291c8-ca9c-47b2-8321-256b314690da@redhat.com>
 <2b3b4754-4c20-48ef-9844-f5db6a7f527e@web.de>
 <bbcf1b06-2a65-4f87-b15a-583a668dfc1e@redhat.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bbcf1b06-2a65-4f87-b15a-583a668dfc1e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4BvwCS8lGjsVcbwXquWcqTMlULuUVkV7zZs9jcpaGdX/8hT9jj1
 QbZZ0qctnLpc1msSNIhSobmAyN7AdkMqr3kpPFNTSAMfBN/N8j7KkRJuGRUgFqcws0LtGYx
 NPAFT1GMkmdf6IGvOF+sEs0HH5qkww7ajh+Q+a3/ebCXTI+Gdjn8tEMZ0Fx/ztoC63tsOZT
 RXCbeMDZmnEBLhzRlPhDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2RcZ5CezqYE=;72yBd+1QRh0XfBtOycVS5Uu75LT
 WVIziAJUe5Bd1HC4byJ1U8nvgFOxorN9sMx05Z+wYJOsw6MFv4kwjdaid6ICX/mjEjPk+GJsL
 38GZVYpMH1p/oYfM926pRBMPwa2wGo/1Brz9r/bfjoo++bag1ZiRqCxhkfiPXo8KQBdmCdhgM
 arCdsPvJrjUaiYJv/7NTZZ9V38uOIRaljZFRXIbqThWY5geCEK3MyK5Co6oaCdFQJ0O7MXVGb
 rbSZ8Jyk6D0s8J5ddb7LPKr+iINYtR2xwlqaRWewxigCuhFiI7wew6JAbwYiavx36CIH6tcRv
 HKZS2yJ8etBwzGGPhEXZAHn2bB+7cV5MrH9kX07YdMJNYa/Soe70GbVrumfO9ezz6Fnez3W8l
 VDnwYPRbLD98rvWJS1jPKJJSNqZmbkJ4Au7yLbXDnQJLqr+FqJWe67vaOlhLGTRvYXqEz/MlQ
 q2j0NFdeWqOOnYJ19zZ6fdMk0vheWIV/TzemQqgT0SZMUUi+9JAU6L8ZbZ068T7kYx+B2gncg
 C1wj4IjRuCBaZuK/4qIuLAWhrK8onxNE1h/jF87jUT7D3rsUbi5KQ3WOjY7PBQhg/84KTIE5t
 1X1vy1MmHwI3ida7nAOb6c1lGlt2pSWMW+Ff5Ko38vMa4HdGjyRHZjM7/nWYJIrcpIyddlalj
 Pb2SAqmhJiMMCqLyL2Nj8+9HHKH48SyP1tjBWCXv7scOuXE+3bP9E5OpB4F+OyWHWHIefkwbN
 9pv5AsJyrQo4hlgpmDrlIleAbJfaoU51MOH5JfXqg7zNiB0ow1fxCTxszw+ALG4E29SKZdv2O
 5/xpA5gu0prxR/zH0mwvWhH+BTpQBCDNNAJVUrnaN1/poTb+DmqUgHH+5JC6xUnZ9oKjicdBD
 7sQUYjPvfyFRGY7pcxdcRHfukIn571Zg4NARTznBTXr84vQ/47u8wuvAW+GE1UXAogUNzD81O
 /VUfTQ==

> If the question is: "Are patches generated by coccinelle welcome?"
> then the answer is "Yes patches generated by coccinelle are very
> much welcome".

How do you think about to fix a questionable memory leak
by using the function =E2=80=9Cmemdup_user=E2=80=9D instead?
https://elixir.bootlin.com/linux/v6.8-rc1/source/mm/util.c#L185

Would you like to try a corresponding command out once more on source file=
s
of a software like =E2=80=9CLinux next-20240125=E2=80=9D?
https://elixir.bootlin.com/linux/v6.8-rc1/source/scripts/coccinelle/api/me=
mdup_user.cocci#L2

make COCCI=3Dscripts/coccinelle/api/memdup_user.cocci M=3Ddrivers/platform=
/x86/amd/pmf/ MODE=3Dpatch coccicheck


Regards,
Markus

