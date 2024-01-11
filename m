Return-Path: <linux-kernel+bounces-24126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 749EA82B7ED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFF51C24A11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B397C59B49;
	Thu, 11 Jan 2024 23:16:01 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F96A59B40;
	Thu, 11 Jan 2024 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Received: from meterpeter.fritz.box ([84.170.86.196]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MRCFw-1rl4nb1Rzg-00NCGL; Fri, 12 Jan 2024 00:15:43 +0100
From: Christian Heusel <christian@heusel.eu>
To: Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <dchinner@redhat.com>,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Christian Brauner <brauner@kernel.org>,
	Min Li <min15.li@samsung.com>,
	Christian Heusel <christian@heusel.eu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] block: print symbolic error name instead of error code
Date: Fri, 12 Jan 2024 00:15:18 +0100
Message-ID: <20240111231521.1596838-1-christian@heusel.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hRXS/pbCGGcWgW+YdsFtf7CISoZpfbLekLeh/9dCbsXEE+9Xmnt
 6y1MThGhnBIcgxOwTuF41kb4eXoDRY9XGjiBiz6RGFPYa/rB2ZDq4gczVKkFlweNG3FRwpZ
 HlvHqv0w3OiCRtBc5IXiWh1OVDl6pV8olZr4v4y6TciQinC8GiKWlHuOwxOK1e1dIIuaKKZ
 9h1IGa9JE7asMxdQYJBhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YOEeGaZNxuM=;yLWzStPVr+/wfRyPQxeTyK3BP1T
 ooVIDDk8C/vXNQviLslzRLDVLCO4fdbjW/F0pLyeqoO+5btQsRb7ZwGDAEbukrPC0sQ5cUe5/
 +Rh2Db1kc/lAELadQlfadrICs7dt8emJ/uV0/pKNb0Pl0g9RGtJO0FK80uar4BCPnfY5dnpia
 rlVcTvwvhhUsmS8pZZuXKPFjY0Nxpj7AkMkZSQz97F+h8rcUAwENSPGTIxk9qEbr/AkT3BieS
 0/jCE0ZP8QxzmurTOPdn8JEOP7wDbeg7QiAhzMg2j0NtlDWX+Qaf8Hr5mIjaC6W/E9px/2VJV
 QKx6/tXxlrdP5YdNotHSKGB3YJbveYDxxncBdm2QJxZdeNofcjZi/q4WOrOwvC82m3egGwlwQ
 hXkdmTFfoIXa1g20/skVHJEsr9+DE1WfcP6ui/EsXvD/7rOjiMtP809A0gb4h4VoVyo60VIRl
 xr2PL2bkoc5vVrFpr7eIUsoOv6oayaX5pbt5S7HWpaxlDzIdfu1xNWcvpDZDNe4e9zFAFfdHB
 YIhOHJXUoo44t45htTz318dagKOaemAHzy3a7uRV8pnFzP7UqDTpoGGp/EmrzyMv5IwUCzqba
 jbQe/cxvd8pFNjjhcx00PspBnsQr6u47pKQXLY2VEBN1/B3/fHMmJnrV2HQrjHZhP4UM7W2Qr
 oVfXvXrF+f+D/utrzSvKlIdm0SCYJg/EOx14NigDJkJ+spiE0qw9Vd651iyuzPGBAkwWnI8sx
 Vzj675/uGMA+gVsN66zI0/zTB6vKA5zU8xEextRg4Y7pnncFkqr0fU3X++o5TmadVp8urE9MO
 KyRWR1QPgOBa8tP6gLLZ5BLBBs0pCHjfxqZW9exW7IB0g7OYSMzZ/EJZoMuPIQsF5ye4SdN3c
 T6QLJ3yLFqJmUJg==

Utilize the %pe print specifier to get the symbolic error name as a
string (i.e "-ENOMEM") in the log message instead of the error code to
increase its readablility.

This change was suggested in
https://lore.kernel.org/all/92972476-0b1f-4d0a-9951-af3fc8bc6e65@suswa.mountain/

Signed-off-by: Christian Heusel <christian@heusel.eu>
---
 block/partitions/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index f47ffcfdfcec..932df4db76f1 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -570,8 +570,8 @@ static bool blk_add_partition(struct gendisk *disk,
 	part = add_partition(disk, p, from, size, state->parts[p].flags,
 			     &state->parts[p].info);
 	if (IS_ERR(part) && PTR_ERR(part) != -ENXIO) {
-		printk(KERN_ERR " %s: p%d could not be added: %ld\n",
-		       disk->disk_name, p, -PTR_ERR(part));
+		printk(KERN_ERR " %s: p%d could not be added: %pe\n",
+		       disk->disk_name, p, part);
 		return true;
 	}
 
-- 
2.43.0


