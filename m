Return-Path: <linux-kernel+bounces-5493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B33818B50
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8359E286BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D4E1CA97;
	Tue, 19 Dec 2023 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="NdSHAllz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C48C1CA82;
	Tue, 19 Dec 2023 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703000172; x=1703604972; i=markus.elfring@web.de;
	bh=behxKfyGna2w4fIuLyZUlD9UgVji5Pzaqh7fdVWijjk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=NdSHAllz2ytmZIT0QQCD69MNm4qSxBOrxg96wlionm7kXZr/joZYDH7INPo3N3+g
	 KoXYVYaKuknbstv0fU3v+mfBgQIbyEDDW8swCkjMzoWeb48bJ7eAcDyYH8hujKMD/
	 4KHfJM37clRxBi0tVFEGCOe0B4R6aGOLKMVddak03dqlFH8yRJVZ2s6Yf6iI3Ragn
	 iff1isB3nGfvsMf8+j8e4xnPaaZC8Haeb0L84L/w6b6UJ9kRE8eSMoXacv/qcPlrK
	 ZUXxrZf3JaCyIpFJOrE3w5ux5K6GVOvFceRD53KmS4agGP/BMz+ZFWiWwLbAvS7hj
	 Zuwpyown8cwj76WQlw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGxQX-1rT2XA40kl-00EGMH; Tue, 19
 Dec 2023 16:36:12 +0100
Message-ID: <526df884-8d9f-4fe1-8a32-c98dfff261d7@web.de>
Date: Tue, 19 Dec 2023 16:36:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/3] kobject: Delete an unnecessary variable initialisation in
 kobject_uevent_env()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <e0543d9d-a02a-4c9c-b341-36771cfb5353@web.de>
In-Reply-To: <e0543d9d-a02a-4c9c-b341-36771cfb5353@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ty9JQzMTJdBwRgq27eu4X1MYwBgEoqbzGhLFiC0uyypy8ISyY/3
 04ttYsnYF4svdZvfzX2e0Q5LP9xnbZXCwWwLPotK0G3FSPKrDvSggC3MSn7WHsRqklFB8u8
 Y/zvYhANVJwd/l7F38NBblZ6qZZHqwg+tm+flOv8n6ggTQHf/+98Jhh3Uyg15wdIWKJAzUW
 rYw7t/s52WNc20JKw5meg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bn4Ds0KTrg4=;i9ZeJm85eydOOEPORA+V0LPdHbM
 5dd4Z4bvbJMQeTztCMzJ5ZOE074edtSA8hze0krNwEGRBPzr+n7FGg/Tsth9nxgoKU8MsGE14
 J5nDsA2n3dfOiqBE1I7KRw2+fwFlw/xcL9gIW/k++bHjNgZyOFA0RdXirtX997AEnkhAjFeYd
 SXwLcOEPBp6sNLWCpSQCIlFluLBFxOizeDNFCfFeWIKtZwtr4b6WjeQZHnusPsfMDN4J93C1T
 hPznwNJMqkBuXELcjpDLAnvWgd7tnnw3KMRKrkRxwKrjszWHVSokaUSiHqQJjCVUvgQcSOjmi
 bAjZV81AHAvg00HRxZQ3GsyV1FUd6xJVvaT947/UhMeW9lTEC+n2pi+0Fg1XCoesBWupmbv+c
 ufUM+YcVv/BaV33Vqd/4pHBwgIDzy+Sf6Vc7yap6TxhB6Lt1Pi28U1NSXDpyLtO+wWCfh5uko
 is+/2jLi3fD+V22WB7Cy+Dg1UARlflZSBrHjKBjJjmCTstjPKg2TcgH7Y+jtCNj1l4B6s/GKA
 LpJTVQC0ArOQjl1knDByBuFa6x1/Tw1ui5/gYQfPQXqCvIhYtbL34gHF8Bih8NasXSm3oRtph
 k23pSlBWO8lte3tTJsUXc0VM+EjjWeQf8BxSxuHqf+UDxEanFGJyHWOcVvExZv+yF450YHJL7
 B3b/BhVmj/UTqzC2S02Wh5zciuL96MDNyfgldgzZODcKKWugIZyBXjL3b3XIY9QvuXLh2zmWy
 2mHBlMLN9oXP33u0GK62z1SvHEpKOeI9naEUVZ2WDoQD0NS9VzCxEhAZKtrwQiz6sSqZl4Yhy
 g5hFxtKusafBRxL9/Vn50YH0AEhWBRHTpcCtzLzXHqly5+4Gx7XAu/A8vNpfsJeRBgqShlNm4
 r354EUyMvxkjZik6xZzKjBTJea6EEtimOVJYI3rNuCAiS3wIGYp7BA3ZSZObWDhOfHfd14MLI
 +aTfAw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 19 Dec 2023 16:03:39 +0100

The local variable =E2=80=9Cdevpath=E2=80=9D will eventually be set to an =
appropriate
pointer a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 lib/kobject_uevent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index a9b1bc02f65c..1b7b42dc160c 100644
=2D-- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -459,7 +459,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobj=
ect_action action,
 {
 	struct kobj_uevent_env *env;
 	const char *action_string =3D kobject_actions[action];
-	const char *devpath =3D NULL;
+	const char *devpath;
 	const char *subsystem;
 	struct kobject *top_kobj;
 	struct kset *kset;
=2D-
2.43.0


