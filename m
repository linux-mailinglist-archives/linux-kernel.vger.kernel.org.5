Return-Path: <linux-kernel+bounces-12813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4B781FA56
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA2A1C2158E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60BF101C2;
	Thu, 28 Dec 2023 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iN6+QnsI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCECF51F;
	Thu, 28 Dec 2023 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703784488; x=1704389288; i=markus.elfring@web.de;
	bh=bZIUiXqM0iUtPLxaSty3O0T6RhxO0I6eQJgl62PzlfM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=iN6+QnsIE6tetReld5k2uZNh3q6iuqTtJ0Xk4Ge5+1qaZzgkMa47VEgPFy8BIAwm
	 vJ1WttlhVpCGpVysvCA+SLydzJ/7UaM9wp2FGLSjIluiwLLz4XvOo66VzAY5kIF/o
	 kSTmgshI//10mM928uiCZslT79GyJB/JJlhee9dCcMo3mNE9Qi4nbUVpCeihuixOL
	 kxGvlQebmRoV6bKDTw4b8ImuorIFmqlpPYBTH/na9KHfe4F8JCrdEQiygrRBPQ8es
	 2DGErXjCXqEBy31OfTCgr4/J2W5wA/GbRrIL3PXVV9RQ9B2KGnQZvTc2W/UASXZi/
	 MKVHX15fAo4O/3DE6A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mm9Va-1qsKql3sG0-00i55t; Thu, 28
 Dec 2023 18:28:07 +0100
Message-ID: <98f99041-e089-4253-9195-6a26b986658e@web.de>
Date: Thu, 28 Dec 2023 18:28:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/4] scsi: lpfc: Delete an unnecessary variable initialisation
 in lpfc_sli_read_link_ste()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 James Smart <james.smart@broadcom.com>,
 "James E. J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <48a127e8-ca4f-4fc4-81b7-226080fba720@web.de>
In-Reply-To: <48a127e8-ca4f-4fc4-81b7-226080fba720@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:STSMzfYc67LKhAslNGaZdX4bp6OTa7800mET5EYlhf7vUhCK6Lm
 Ifqyt7MS+yD6MlIY/3dNgCFbV6/dDcnWYSmWrabZ7L8YoIB9RbqaRvL5ING8Ku9Xv26bGd3
 iif/S0BKAFaf/rIl0b7wbKgm01nrQMYWHBFuMm58B/2e6WK7mMoMa/len0eorM8rua5rosz
 CgtspMAQ5PSUUaJF16AVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gGJWmcBxQXs=;U1pG/0wNPXece0P+dqVanmQytTQ
 WLCrpq0mp/1yuggSzMAAQf4MCI6fPGsDYbTSoZ2Sx+HM7+52S5wOP6BGNW9/kOXaHs5K1aLhc
 c02hcybWUpDx4ejZ+BMsA7b6sWPD42BMQRQoS9cHp7vv3h8dZ5jOb3RXYGdsxjrYAX9aIJ46f
 NMD8UXU4KVdzSk01vCdv/odEJBlFB7mk75I2eljDK7vQlXyvG+j4C03aPGHKH9hi/DYgtoHED
 L0PRnODx9oSdo5XGfopg+/bNj095vs9phJGDBOvG8l1Nt3sc1dr6/1nAVArsmC/7DzRsfuSEi
 s6YQvjBwpqMfn+xF3VP0ffpPTZ+NXbKDrjzlsDjv4HmUVrSEcaFCXKXU7gHVze+m3oYR8DX+l
 cTZ/lT8OdxOv9fZY059MqdTL3IxFEOZJB2mZDQTwwcf5chnBBhFFMuUqPja7iuCBBBgt2F92m
 8uCX7w6qyH5KuAgdUuGKA3GKIEIHrQm3vlvOV3L1EsjMHeOpytVU0oX2FuekbfX578+N7RMux
 GWEPeaz3ZiO1ubPm8GFFLSMTW5coWY7jswgi2tu5NNvPgD/zCh9CF2S66FaMi/nmJZVDANhmX
 IV0pK4sEkSCqs63DyIs1HMzp5OzpXiBxlkEta112NzC5Jp+55ATQS3LJEI/tHmyoX/7dFZW4p
 HUYGoMahxVavBFUIN5J2Ft31Lop3PwmC3FUqfvKWPDTcm0atX/kqUsIVcSI8tXMCNZiqTTgQ5
 +WkaU9VRLSA7TV9ywZ7HnaIbtx9b3xRKDhbnipJIDQNv6Z5SAXR6kOPOCJmDjuhiyqOcNO1Z0
 /LhNO6TWX+rXPjrwwSXSRa6ZrS7PW/vvn/v2ZNIbYNtHMHSE6fS+1IDVJO+/J4vfOpBqljCZz
 ByKxcSQfX8qC/Wbol1kaTDNongA6tj+B8Y1SaXCho7qwX8xtpH8EYb5YkR0ixXj9zIbXIdeNM
 CVq95abh9gFa99myyIBDpPySwUI=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 28 Dec 2023 18:00:11 +0100

The variable =E2=80=9Crgn23_data=E2=80=9D will be reassigned by a followin=
g statement.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/scsi/lpfc/lpfc_sli.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 8de598c9e03b..1ce5671a7e07 100644
=2D-- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -20694,7 +20694,7 @@ lpfc_sli4_get_config_region23(struct lpfc_hba *phb=
a, char *rgn23_data)
 void
 lpfc_sli_read_link_ste(struct lpfc_hba *phba)
 {
-	uint8_t *rgn23_data =3D NULL;
+	uint8_t *rgn23_data;
 	uint32_t if_type, data_size, sub_tlv_len, tlv_offset;
 	uint32_t offset =3D 0;

=2D-
2.43.0


