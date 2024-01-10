Return-Path: <linux-kernel+bounces-22265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2B8829B97
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB4D1C21A07
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C8B48CE4;
	Wed, 10 Jan 2024 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BWehdJKP"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F437495C6;
	Wed, 10 Jan 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704894387; x=1705499187; i=markus.elfring@web.de;
	bh=G1Hud5/Mz+1TxVChRVaFZEFD3aH8A+Wza/U6sVZxr1I=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=BWehdJKP2p3b62h4fUiVJaqmt7mpvE6lO0te5Cs2W8jEzNpvTlkqQYXiDuZo/VFV
	 RwNU4/Pe5zByN3k9BsIFguaL0+/AGcin+MZvjd9vVzhbJ7GZAAGWOvbbKlmb2fKcc
	 M7XiP0CfVmpvnuN3sVntLA77siseL5zMQRObfjhMsT6v1pQjVdKiNXen/nMyzIaV9
	 lvdDiLWgZBT9K50uAdFBKydpdVbNmXLukZjveTN1Fo25gb6G5cXvOqa6g5HtAdBSr
	 svqScTt6zuAoZ+cCo8fGeh8IvZBR+G1Xm5cNrygFair13q2n462zn6JadNH2Fuwg1
	 j40i5hBQTGVKDEq+Uw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKdLM-1rbuwB1dqW-00L0J1; Wed, 10
 Jan 2024 14:46:27 +0100
Message-ID: <79ef2b86-2215-4e8e-b08c-5519a4fa734f@web.de>
Date: Wed, 10 Jan 2024 14:46:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [0/2] ARM: Adjustments for init_atags_procfs()
Content-Language: en-GB
To: Christian Heusel <christian@heusel.eu>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
 <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
 <7dd19987-6590-4756-a929-1ff01503ad1c@web.de>
 <ZZ6MZl14bcIaCaQn@shell.armlinux.org.uk>
 <1c38e495-5c9c-4ff8-b453-93b882dd2c4c@web.de>
 <ZZ6R6KSQo9ph3ARZ@shell.armlinux.org.uk>
 <vltzbtbcuzrfgjoeg5oovdyoe34fnhte25uhb3gln56pzvmqzb@5u7u7cwgzzen>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <vltzbtbcuzrfgjoeg5oovdyoe34fnhte25uhb3gln56pzvmqzb@5u7u7cwgzzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Kl+pq7sDIhZJ0GFjYmlg09if7eT2zCf4sXATX0lyQRCyZdV3Wuo
 57ptJH5RJT7ZTASUXQNIDk+FSWnT6rK/L9OFE50KiqRkGnw2ZOWn0yL94blYtkbuDbFZOGC
 SBkm4P1qUvuIfizYmvkitcqo1JVkmOFV416cwdYil4nx8D+vjmaetUtM0WeSAAEfhq+DUXy
 v8NplAm64Z15atQTLZTUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6aOeVazPvdw=;qh54YjMHnV5fYUilF3X2k1g/ysR
 sC6ZbAA8C/MurU6RaeMmT8QkbiR7EW4kkJTFI0m8PyZ7L3Zd5l4e+kuG5IuM/3Z7lvDtNEDpP
 Caxdwt16FHfhakbYNbiAvf+fc61lK41jums6Y2J0bgmEJu06PfZ81HuqBNEFHENfl9O7YC2jm
 rNmPvhc7RLm4GmsMfb0EHBjW2iU7aJ4IOXDwkwLuuUnXqxMVzj71UQfP+onKuJP0w6Zff1dIL
 hQI42pwjd7Sq/UZOT037CqEZdrkT6/acPtHrnuSpChQBfFLwkuMV6h8hPLYadI8E4l+XIkjg2
 5ZGakaPHIfVuAfU2Wda6F9CTfCjTL4nHpQFZIWfPMKMIqV4QBhlXIIcYenBZPLK2OCJ3hPym3
 6OW6aHKFLbkamszKUlQcU8eNH02i3RJgNZEo7e7n3jhWJAog0jU1mqcWtcVGJLqnKBfgN3W3v
 XfGLE0nAAQCYf2dYzUR5kk1D7jAmryXnUVNaPoZkR8gFqcsHWG8azO8XLKaHdOaZaQRA0klJC
 uz0xk7UFI4AYWo9436GesNuJ8SJAHrH/JT/bBaMhDplJJgevBhyTy2kDS6tHGbZiU2ssY0skF
 mSpD48g+C5xhV8CuinmamUCNMhW1/egTOE49R9ihKNoKuG1nHHA99LIlXvVVOP9vT9SI0sTZK
 Q2Eeu/2zgMcruyRunNn+u/CcGXcFrg6YIZYRkfk6Wp8rObvnpz+LnPVDynxA5hl7OYr/Jef5w
 RQBmideScsv2CZ/f29qqnejdBNARda8ozsgVkhFc60tOn88dSxNmfrWM0ypUT3//Ddp7y1rp4
 SKzKHZDUdUpOXNkUgxAYws9f47plAb+6Ipk841oM16jx2ZAJaU9r6C1jBG8xLTwTA3oO3JRAB
 54IBCLZzxsff+Co0nWnrg0HOzVSLjLOrjbkkupsnt3PgZ1Hax+ZHnc0gMg+wmQTGDR73fqajO
 /LYURQDqM5hmnF13GaX7t73VTNE=

> I am just generally following along here, but to give some context it
> seems like Markus is banned from posting to various kernel mailing
> lists[0][1][2].

This was the case for a while.
Were such communication filters reconsidered anyhow recently?

Regards,
Markus

