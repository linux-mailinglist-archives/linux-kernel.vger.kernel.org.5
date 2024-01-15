Return-Path: <linux-kernel+bounces-26204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B374A82DCBF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D88C2832DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E3A1803D;
	Mon, 15 Jan 2024 15:56:14 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB817C70;
	Mon, 15 Jan 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Received: from meterpeter.INF524.stwhd ([141.70.80.5]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N5VLY-1r6Fsk23Kc-016uBC; Mon, 15 Jan 2024 16:55:48 +0100
From: Christian Heusel <christian@heusel.eu>
To: Anton Altaparmakov <anton@tuxera.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-ntfs-dev@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	Christian Heusel <christian@heusel.eu>
Subject: [PATCH] ntfs: print symbolic error name instead of error code
Date: Mon, 15 Jan 2024 16:55:38 +0100
Message-ID: <20240115155540.94127-1-christian@heusel.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8Cj9rg6OYmZJSHmw+KpGRyrT/3xXnK/X35tHaWFT4Z017Ota8AT
 +UpSs8EPfJNryBWCRdJ7rI9VvFTg5c6Vc5VpE3p4Hp4ckDB1SDYl+R2QmnAQs2sS1UR11L7
 hyQSXn72ht4wi6xeYDPjrlSgcqmCHltgg0OQ5L7f/BjZIKoYKMMQSif/AlihCZsZRY2gLH2
 vlSHgaRvde2FmeVPkE51w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HwgHyQdHjo0=;jxlGXhDLZbiOF1B/xDBM50aA2KY
 zWyHHrEqyatDBGIGDUEcFoGI21HDR9Q/nGqA4vb+ivICx/7fT5DRt+zDCouoOkITgv8XVUYlr
 iRFflzvbJdkky+YkhamV43XnrC80z9R/4/TtUqOXmnBVbA6cmcPpWndPF23Z7uBQSI3aBIrFP
 C/wiB/Gx4xerESBXA3xKVgU4vs71yIS60BkRINWc3kDI2g0V3o1gzkiD4cRKifNhm293sAtOB
 EphknbmvEtoctkIUfjYwr1SSpw6GTayFCrzcwfSgn/p+AV/L8PA3P86zFTfNgXeLvllAPF4Ai
 aBjFLKFKMylTvlUw1M+7dxZp41zxs38Bvk6oiV4WKv7M4W9EGYs8HYAq+eDbhhO0KB9YwFZZq
 AZGHe5ME4hQpWnWjNI5ulSXPKPFzEcbDYGqWLhzI43S15WP6lKmSgbOneJn0IabHhGO7W135W
 FKdZSViAEnR3yQLlkzgCJ9gG7TnREQXrl8G2U1CCld5ArdDVbKaXpZnaJhUHArvSqUiAXr+bR
 aUIPSjZ3xy5cvYb8k3R8bt0SYZTRFuAwnQlJjn2+j93xcJu/AEPhEpajh1oJg9Ghp1vP6MQnF
 s3L+KWUYtmAImr3EMsDD2wGu/QRKYEjJtlYZY2K2tgc0ySn6PPSXQVsvVjqIt83HRaWZwjgCX
 tmqESg26ir8zM6T4TXRLMeL7kFazP6v4IUytGBoOXBX/G2JjlAtsIpRkETr8nID66ZCi4c4Zq
 IqNYndy2WK5CldCQmd7TirQMG3fBaTU+q764y6ZF+uB8MGKxDPqoIYYkR+AZq6Z5K/DaMisOU
 OhvZEiOHwzJ324eryJrxL5fgqiz5CJx3p9B8IE+CFrXwcL+EfarX1QrQ3jlevJKAffcHToKwX
 kSk8CnZV3UnvRhA==

Utilize the %pe print specifier in multiple log messages to get the
symbolic error name as a string (i.e "-ENOMEM") instead of the error
code to increase the log messages readablility.

This change was suggested in
https://lore.kernel.org/all/92972476-0b1f-4d0a-9951-af3fc8bc6e65@suswa.mountain/

Signed-off-by: Christian Heusel <christian@heusel.eu>
---
 fs/ntfs/dir.c   | 12 ++++--------
 fs/ntfs/index.c |  6 ++----
 fs/ntfs/mft.c   |  6 +++---
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 629723a8d712..8df4f233969d 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -88,8 +88,7 @@ MFT_REF ntfs_lookup_inode_by_name(ntfs_inode *dir_ni, const ntfschar *uname,
 	/* Get hold of the mft record for the directory. */
 	m = map_mft_record(dir_ni);
 	if (IS_ERR(m)) {
-		ntfs_error(sb, "map_mft_record() failed with error code %ld.",
-				-PTR_ERR(m));
+		ntfs_error(sb, "map_mft_record() failed with error %pe.", m);
 		return ERR_MREF(PTR_ERR(m));
 	}
 	ctx = ntfs_attr_get_search_ctx(dir_ni, m);
@@ -308,8 +307,7 @@ MFT_REF ntfs_lookup_inode_by_name(ntfs_inode *dir_ni, const ntfschar *uname,
 	page = ntfs_map_page(ia_mapping, vcn <<
 			dir_ni->itype.index.vcn_size_bits >> PAGE_SHIFT);
 	if (IS_ERR(page)) {
-		ntfs_error(sb, "Failed to map directory index page, error %ld.",
-				-PTR_ERR(page));
+		ntfs_error(sb, "Failed to map directory index page, error %pe.", page);
 		err = PTR_ERR(page);
 		goto err_out;
 	}
@@ -639,8 +637,7 @@ u64 ntfs_lookup_inode_by_name(ntfs_inode *dir_ni, const ntfschar *uname,
 	/* Get hold of the mft record for the directory. */
 	m = map_mft_record(dir_ni);
 	if (IS_ERR(m)) {
-		ntfs_error(sb, "map_mft_record() failed with error code %ld.",
-				-PTR_ERR(m));
+		ntfs_error(sb, "map_mft_record() failed with error %pe.", m);
 		return ERR_MREF(PTR_ERR(m));
 	}
 	ctx = ntfs_attr_get_search_ctx(dir_ni, m);
@@ -786,8 +783,7 @@ u64 ntfs_lookup_inode_by_name(ntfs_inode *dir_ni, const ntfschar *uname,
 	page = ntfs_map_page(ia_mapping, vcn <<
 			dir_ni->itype.index.vcn_size_bits >> PAGE_SHIFT);
 	if (IS_ERR(page)) {
-		ntfs_error(sb, "Failed to map directory index page, error %ld.",
-				-PTR_ERR(page));
+		ntfs_error(sb, "Failed to map directory index page, error %pe.", page);
 		err = PTR_ERR(page);
 		goto err_out;
 	}
diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index d46c2c03a032..777bbd4548ad 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -137,8 +137,7 @@ int ntfs_index_lookup(const void *key, const int key_len,
 	/* Get hold of the mft record for the index inode. */
 	m = map_mft_record(base_ni);
 	if (IS_ERR(m)) {
-		ntfs_error(sb, "map_mft_record() failed with error code %ld.",
-				-PTR_ERR(m));
+		ntfs_error(sb, "map_mft_record() failed with code %pe.", m);
 		return PTR_ERR(m);
 	}
 	actx = ntfs_attr_get_search_ctx(base_ni, m);
@@ -264,8 +263,7 @@ int ntfs_index_lookup(const void *key, const int key_len,
 	page = ntfs_map_page(ia_mapping, vcn <<
 			idx_ni->itype.index.vcn_size_bits >> PAGE_SHIFT);
 	if (IS_ERR(page)) {
-		ntfs_error(sb, "Failed to map index page, error %ld.",
-				-PTR_ERR(page));
+		ntfs_error(sb, "Failed to map index page, error %pe.", page);
 		err = PTR_ERR(page);
 		goto err_out;
 	}
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 6fd1dc4b08c8..fed9abc3ff1f 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -159,7 +159,7 @@ MFT_RECORD *map_mft_record(ntfs_inode *ni)
 
 	mutex_unlock(&ni->mrec_lock);
 	atomic_dec(&ni->count);
-	ntfs_error(ni->vol->sb, "Failed with error code %lu.", -PTR_ERR(m));
+	ntfs_error(ni->vol->sb, "Failed with error %pe.", m);
 	return m;
 }
 
@@ -285,8 +285,8 @@ MFT_RECORD *map_extent_mft_record(ntfs_inode *base_ni, MFT_REF mref,
 			return ERR_PTR(-EIO);
 		}
 map_err_out:
-		ntfs_error(base_ni->vol->sb, "Failed to map extent "
-				"mft record, error code %ld.", -PTR_ERR(m));
+		ntfs_error(base_ni->vol->sb,
+			   "Failed to map extent mft record, error %pe.", m);
 		return m;
 	}
 	/* Record wasn't there. Get a new ntfs inode and initialize it. */
-- 
2.43.0


