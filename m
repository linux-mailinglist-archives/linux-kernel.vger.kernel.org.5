Return-Path: <linux-kernel+bounces-13685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7280820B11
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 11:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DAB81C20FCC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3529933EA;
	Sun, 31 Dec 2023 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jtKpTd1m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9736A8F48;
	Sun, 31 Dec 2023 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704018801; x=1704623601; i=markus.elfring@web.de;
	bh=I0Xu6K601Nm32B7uvcWfNE+QosXgVl3IjaU3K1o4CgM=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=jtKpTd1mVE8EfPH3AgRi3bsjnjZu0bbyDmAl1LXrxczjagkwrkM70hTSTBrYmLMr
	 evo6ZnUhBhJs+Pg7ugM5f06Vx/GgIRluk3HkhK4dYW7Avop9nGg1upOsNKKCEprY4
	 HR2/i0T7ndOsd0BSVzX8MXktTkYF5MBvDylQRieOI3PXW+BeNrk6UYUVLPV6KrMYW
	 fn5DNdN7f2hYnj8vZNLZo49YDt05nXKxEQzZPP6wJSDqtGYCtl4VkuZ5DHI1jC712
	 LbYgb1MJv1d4auXv/P87flrKrfOouewzAix/58REJaJAJkrA4gmnvCn6/pUM+NQMh
	 8+917lu1L/wZBimnFA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6sG3-1rAOUA1RyJ-017uVs; Sun, 31
 Dec 2023 11:33:21 +0100
Message-ID: <873097b9-5a0b-495b-83ae-f2247fbb512b@web.de>
Date: Sun, 31 Dec 2023 11:33:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>, Paolo Abeni <pabeni@redhat.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] wifi: cfg80211: Replace a label in
 cfg80211_parse_ml_sta_data()
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iM1BOGtdeD8AtCAAfFlwSOiytaVaoci3r6z1EsCpcglGg4EL/hA
 IXcu2yRVlCN53tgjzSijw6VgV7AsMO5XQQ8aTJLtR00XmbtkBSg9KF3fJdaoLbYfthPZd9m
 vzO0lXKJsuNYJlw6UBcP1P14+EAvlO9UDD5OvpwbEVbz1MMlz3u/3G4Um5kXIvKuBL30qrb
 qdONys6dZdda+oG21cszg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0+UXqzkwbU8=;mZ1uV5g6EcraQSB7q7DMh40Rgha
 mdyfTu67DW1VQCUIFbjKQs6MVWe8n1uG1O0VR74tK7mCcIEJ5x7Rh2ZQHecIoAY+UnfLEJtVf
 RpTix2ykctPyxxTDEQhbrRDdqxSv2O9DMJBU4RaS2i9tB+/VryJlOZmlhlrggSbm64OYxHzAv
 O2H36Eg+lX4ZdOl96OZG90eZ7Ksar9tK0UkxplhDuNqIr9ciMCWa6w4T7qHRYC/REawypR6ZM
 LUQ9SZ9KSk1BQfgGrIjMvF49YLiV+d2M6KyRg+lIg8t8x8CQgH7tTulKMfOvslkQ0sAVN7/dd
 ckNBF6Xj+KvyATOeLy6R/8+UgWnrA122VvkIfNmlTm7DSdo65jBWceO36GRUvFZZyfuD7BBvc
 3h9AEaYSIzkvf0rqJUrioBNnubES5gCVYeMOfGR3ANgIEXPdgnOuwwSLSaMZmq/V3B+qGAwn1
 09fS6gT6w+8ByfNq1h0FoDb2AK20mp0gU+zncpWY8F1DNdkp4x8HfvpSF28w+nLAY7RF2Nu+j
 l5WROVg44dhML8c6wjMJkAWFw3L1Gc/3cI/ARsGkUUL05CCjAVt2Ch3QAKrA4hLtFAb9/PrLF
 dqL5RLfVhApN5yXlJOJWL58q6QTQmWD9m9yVOwezXDao6jSgQwljx26lDqOM1qVv1Kwi+b+WZ
 38LeByva4HDq2AiLiyrk/UFIDEMuYZishuYy4T2TeibsgqFB+4SZNWy+0VVE7B0TOrY4JP96y
 6nVfAn7v8TB0WRK61etRq0Gnke+rug4uOUcEanAbpdM91YPCsH+tT+bpYYDaNfKhCl1jTo5l1
 +V/vK34eCgRt5/HSN5G9wQIIxtQisHKpLx7Fnu0LAdSm6CY88V2mpCyFyxPb9TsyEXbSgQLO0
 dgEoBR6WHAYXhnwZ2RownoeOufKaQB0TtHMxbAImFEUpokcjiNEt2ibBB5AgrZRKaNPBrq8YG
 tcL/Rg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 11:22:42 +0100

The kfree() function was called in one case by
the cfg80211_parse_ml_sta_data() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use an other label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/wireless/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index cf2131671eb6..492e30138418 100644
=2D-- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2693,7 +2693,7 @@ static void cfg80211_parse_ml_sta_data(struct wiphy =
*wiphy,

 	new_ie =3D kmalloc(IEEE80211_MAX_DATA_LEN, gfp);
 	if (!new_ie)
-		goto out;
+		goto free_mle;

 	for (i =3D 0; i < ARRAY_SIZE(mle->sta_prof) && mle->sta_prof[i]; i++) {
 		const struct ieee80211_neighbor_ap_info *ap_info;
@@ -2812,8 +2812,8 @@ static void cfg80211_parse_ml_sta_data(struct wiphy =
*wiphy,
 		cfg80211_put_bss(wiphy, bss);
 	}

-out:
 	kfree(new_ie);
+free_mle:
 	kfree(mle);
 }

=2D-
2.43.0


