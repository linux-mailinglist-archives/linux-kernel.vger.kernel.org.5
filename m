Return-Path: <linux-kernel+bounces-149646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778D18A93E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29259281B19
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F0D481A7;
	Thu, 18 Apr 2024 07:21:44 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1120.securemx.jp [210.130.202.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C910A0E;
	Thu, 18 Apr 2024 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424903; cv=none; b=dNIWynuJXFLXfvtxPamd6Kg6+i4LP4Ti3Yc24sIG/TOh0WmKRIx4+8M4Sj1UT821XNHRt7cQafIHoyRfjxL6mmNSQHYQGFMQXMpTKtcmrieEgrlrUYuXcfU6ZdG99XAxAuX1Q5Uv9RzZqjMzhORt+kpBAUfjAZs3VgQMiAOCFjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424903; c=relaxed/simple;
	bh=q8ht+jAF0alGe432i95E2EmmvgvQ5IhN3fsmHdLp8tg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k55zEP1TmrGrotNj6azVzHaIVVUdMndBF5tZ8/svqt7rdwriUW/OtjE+KsTEsVMAO5Fp81SqyxnP4pxcHnlKO2110b8BV2Erc6SbE8vsEd0aroDxnBWMyik1Vu4vdSxP9MNYJEpblrjKB3T7eIrUGzKjV1E+4iMBrDG1G+aX31E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1120) id 43I5iX8O2019030; Thu, 18 Apr 2024 14:44:33 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 43I5i3F52465041; Thu, 18 Apr 2024 14:44:03 +0900
X-Iguazu-Qid: 2rWhclmqQjRZuUaTAY
X-Iguazu-QSIG: v=2; s=0; t=1713419043; q=2rWhclmqQjRZuUaTAY; m=UGY3jf7+DzDW54BQLc4yg7NqHUSU0KnvPpq2myBHTvk=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1122) id 43I5i2vK2851714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Apr 2024 14:44:02 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id 640FE2FE0F;
	Thu, 18 Apr 2024 14:44:02 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 3A3A81947AEC50;
	Thu, 18 Apr 2024 14:22:04 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR03.kioxia.com with ESMTP id 0002QAAAAAA01FM1;
	 Thu, 18 Apr 2024 14:22:04 +0900
Received: from CNN1EXMB04.r1.kioxia.com (CNN1EXMB04.r1.kioxia.com [10.232.20.153])
	by Switcher-Pre_Send (Postfix) with ESMTP id 2E51EAA28483C;
	Thu, 18 Apr 2024 14:22:04 +0900 (JST)
Received: from CNN1EXMB04.r1.kioxia.com (10.232.20.153) by
 CNN1EXMB04.r1.kioxia.com (10.232.20.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 14:44:01 +0900
Received: from CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) by
 CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) with mapi id 15.01.2507.035; Thu,
 18 Apr 2024 14:44:01 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 02/11] md: add infra for nr_pending changes
Thread-Topic: [PATCH v2 02/11] md: add infra for nr_pending changes
Thread-Index: AdqLx9x1MkCN7uTlRyqnTzQSCFkVuA==
Date: Thu, 18 Apr 2024 05:44:01 +0000
Message-ID: <065afbfd34f44eada6575fd48114e782@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-as-result: No-10--13.824200-8.000000
x-tmase-matchedrid: 6VY+yZKIFUOmagT1k9kBppTQgFTHgkhZKQNhMboqZlrHhoBEyuHcbXkK
	0FnHivpUuH0SzH4JWPa12HagvbwDji/7QU2czuUNA9lly13c/gFr2qJoNIuCjRjNpP+VAaW2cwh
	qloOj04o3haSYSnhyTlXcW9CR1Vd5FIetOq2+pVDfSQNpZkETVE+crEA4+nhZWm66nNAKC7PQGF
	lKOB0iJLlW2fEUZEj7eIXhTXDYCVBppBeolGl6TAihQ5NZCXsSsBSA1tuZVSbo8w4N7te92p/p6
	742jA2BiFSRT7HBaXD/4j+p8jFGbrkRMDcY9eUDAD5jSg1rFtBNLPQl0QAltLs3Yh2IOCYzlmGO
	ZvTvMRc1+ahTbhS+5eZRkGfolSWMUaNA17Pg5uoOeRRGICV9PcnlJe2gk8vIOmcd2FDUExunXhF
	0LKDIJa4M7Qf5HIbfgt5d7sz8fUvsR/15S/KqDguw+MVcHJpKGYkyyELuGKTfc2Xd6VJ+yjQEU0
	gh8OM4V2J5gVT3U48qq3YUbX8N0L9ZdlL8eonaC24oEZ6SpSkj80Za3RRg8BzvtAQBnqcLVTxAd
	QZh2c/VdfCjDgTgIP41UIhe7WKxI5vZ8n+nN5M=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--13.824200-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-snts-smtp: DF7F84FAAD8D6F5870C1D61EB32E6334F3407B7CB44EE2E25AA9CC94FFFDC6DA2000:8
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB04.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB04.r1.kioxia.com

Prepare to smoothly change the type of nr_pending from atomic_t to percpu_r=
ef.

Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
---
 drivers/md/md-bitmap.c   |  2 +-
 drivers/md/md.c          |  6 +++---
 drivers/md/md.h          | 32 +++++++++++++++++++++++++++-
 drivers/md/raid1.c       | 20 ++++++++---------
 drivers/md/raid10.c      | 46 ++++++++++++++++++++--------------------
 drivers/md/raid5-cache.c |  4 ++--
 drivers/md/raid5.c       | 20 ++++++++---------
 7 files changed, 80 insertions(+), 50 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 059afc24c08b..6d49a6e4cd2f 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -190,7 +190,7 @@ static struct md_rdev *next_active_rdev(struct md_rdev =
*rdev, struct mddev *mdde
 		if (rdev->raid_disk >=3D 0 &&
 		    !test_bit(Faulty, &rdev->flags)) {
 			/* this is a usable devices */
-			atomic_inc(&rdev->nr_pending);
+			nr_pending_inc(rdev);
 			rcu_read_unlock();
 			return rdev;
 		}
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 00bbafcd27bb..d53ca23bacf7 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -575,7 +575,7 @@ static void submit_flushes(struct work_struct *ws)
 		    !test_bit(Faulty, &rdev->flags)) {
 			struct bio *bi;
=20
-			atomic_inc(&rdev->nr_pending);
+			nr_pending_inc(rdev);
 			rcu_read_unlock();
 			bi =3D bio_alloc_bioset(rdev->bdev, 0,
 					      REQ_OP_WRITE | REQ_PREFLUSH,
@@ -1054,7 +1054,7 @@ void md_super_write(struct mddev *mddev, struct md_rd=
ev *rdev,
 				  | REQ_PREFLUSH | REQ_FUA,
 			      GFP_NOIO, &mddev->sync_set);
=20
-	atomic_inc(&rdev->nr_pending);
+	nr_pending_inc(rdev);
=20
 	bio->bi_iter.bi_sector =3D sector;
 	__bio_add_page(bio, page, size, 0);
@@ -9269,7 +9269,7 @@ static bool rdev_removeable(struct md_rdev *rdev)
 		return false;
=20
 	/* There are still inflight io, don't remove this rdev. */
-	if (atomic_read(&rdev->nr_pending))
+	if (nr_pending_is_not_zero(rdev))
 		return false;
=20
 	/*
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 029dd0491a36..f57a894b924b 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -211,6 +211,36 @@ enum flag_bits {
 	Nonrot,			/* non-rotational device (SSD) */
 };
=20
+static inline void nr_pending_inc(struct md_rdev *rdev)
+{
+	atomic_inc(&rdev->nr_pending);
+}
+
+static inline void nr_pending_dec(struct md_rdev *rdev)
+{
+	atomic_dec(&rdev->nr_pending);
+}
+
+static inline bool nr_pending_is_zero(struct md_rdev *rdev)
+{
+	return atomic_read(&rdev->nr_pending) =3D=3D 0;
+}
+
+static inline bool nr_pending_is_not_zero(struct md_rdev *rdev)
+{
+	return atomic_read(&rdev->nr_pending) !=3D 0;
+}
+
+static inline unsigned int nr_pending_read(struct md_rdev *rdev)
+{
+	return atomic_read(&rdev->nr_pending);
+}
+
+static inline bool nr_pending_dec_and_test(struct md_rdev *rdev)
+{
+	return atomic_dec_and_test(&rdev->nr_pending);
+}
+
 static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sector=
s,
 			      sector_t *first_bad, int *bad_sectors)
 {
@@ -846,7 +876,7 @@ static inline bool is_rdev_broken(struct md_rdev *rdev)
 static inline void rdev_dec_pending(struct md_rdev *rdev, struct mddev *md=
dev)
 {
 	int faulty =3D test_bit(Faulty, &rdev->flags);
-	if (atomic_dec_and_test(&rdev->nr_pending) && faulty) {
+	if (nr_pending_dec_and_test(rdev) && faulty) {
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 		md_wakeup_thread(mddev->thread);
 	}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index be8ac24f50b6..962cebbba6cd 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -581,7 +581,7 @@ static void update_read_sectors(struct r1conf *conf, in=
t disk,
 {
 	struct raid1_info *info =3D &conf->mirrors[disk];
=20
-	atomic_inc(&info->rdev->nr_pending);
+	nr_pending_inc(info->rdev);
 	if (info->next_seq_sect !=3D this_sector)
 		info->seq_start =3D this_sector;
 	info->next_seq_sect =3D this_sector + len;
@@ -784,7 +784,7 @@ static int choose_best_rdev(struct r1conf *conf, struct=
 r1bio *r1_bio)
 		if (ctl.readable_disks++ =3D=3D 1)
 			set_bit(R1BIO_FailFast, &r1_bio->state);
=20
-		pending =3D atomic_read(&rdev->nr_pending);
+		pending =3D nr_pending_read(rdev);
 		dist =3D abs(r1_bio->sector - conf->mirrors[disk].head_position);
=20
 		/* Don't change to another disk for sequential reads */
@@ -1495,7 +1495,7 @@ static void raid1_write_request(struct mddev *mddev, =
struct bio *bio,
 			write_behind =3D true;
=20
 		if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
-			atomic_inc(&rdev->nr_pending);
+			nr_pending_inc(rdev);
 			blocked_rdev =3D rdev;
 			break;
 		}
@@ -1506,7 +1506,7 @@ static void raid1_write_request(struct mddev *mddev, =
struct bio *bio,
 			continue;
 		}
=20
-		atomic_inc(&rdev->nr_pending);
+		nr_pending_inc(rdev);
 		if (test_bit(WriteErrorSeen, &rdev->flags)) {
 			sector_t first_bad;
 			int bad_sectors;
@@ -1879,7 +1879,7 @@ static bool raid1_remove_conf(struct r1conf *conf, in=
t disk)
 	struct md_rdev *rdev =3D info->rdev;
=20
 	if (!rdev || test_bit(In_sync, &rdev->flags) ||
-	    atomic_read(&rdev->nr_pending))
+	    nr_pending_is_not_zero(rdev))
 		return false;
=20
 	/* Only remove non-faulty devices if recovery is not possible. */
@@ -1987,7 +1987,7 @@ static int raid1_remove_disk(struct mddev *mddev, str=
uct md_rdev *rdev)
 			struct md_rdev *repl =3D
 				conf->mirrors[conf->raid_disks + number].rdev;
 			freeze_array(conf, 0);
-			if (atomic_read(&repl->nr_pending)) {
+			if (nr_pending_is_not_zero(repl)) {
 				/* It means that some queued IO of retry_list
 				 * hold repl. Thus, we cannot set replacement
 				 * as NULL, avoiding rdev NULL pointer
@@ -2403,7 +2403,7 @@ static void fix_read_error(struct r1conf *conf, struc=
t r1bio *r1_bio)
 			     (!test_bit(Faulty, &rdev->flags) &&
 			      rdev->recovery_offset >=3D sect + s)) &&
 			    rdev_has_badblock(rdev, sect, s) =3D=3D 0) {
-				atomic_inc(&rdev->nr_pending);
+				nr_pending_inc(rdev);
 				if (sync_page_io(rdev, sect, s<<9,
 					 conf->tmppage, REQ_OP_READ, false))
 					success =3D 1;
@@ -2433,7 +2433,7 @@ static void fix_read_error(struct r1conf *conf, struc=
t r1bio *r1_bio)
 			rdev =3D conf->mirrors[d].rdev;
 			if (rdev &&
 			    !test_bit(Faulty, &rdev->flags)) {
-				atomic_inc(&rdev->nr_pending);
+				nr_pending_inc(rdev);
 				r1_sync_page_io(rdev, sect, s,
 						conf->tmppage, REQ_OP_WRITE);
 				rdev_dec_pending(rdev, mddev);
@@ -2447,7 +2447,7 @@ static void fix_read_error(struct r1conf *conf, struc=
t r1bio *r1_bio)
 			rdev =3D conf->mirrors[d].rdev;
 			if (rdev &&
 			    !test_bit(Faulty, &rdev->flags)) {
-				atomic_inc(&rdev->nr_pending);
+				nr_pending_inc(rdev);
 				if (r1_sync_page_io(rdev, sect, s,
 						conf->tmppage, REQ_OP_READ)) {
 					atomic_add(s, &rdev->corrected_errors);
@@ -2909,7 +2909,7 @@ static sector_t raid1_sync_request(struct mddev *mdde=
v, sector_t sector_nr,
 			}
 		}
 		if (rdev && bio->bi_end_io) {
-			atomic_inc(&rdev->nr_pending);
+			nr_pending_inc(rdev);
 			bio->bi_iter.bi_sector =3D sector_nr + rdev->data_offset;
 			bio_set_dev(bio, rdev->bdev);
 			if (test_bit(FailFast, &rdev->flags))
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index a4556d2e46bf..2b1238befd8a 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -808,7 +808,7 @@ static struct md_rdev *read_balance(struct r10conf *con=
f,
=20
 		nonrot =3D bdev_nonrot(rdev->bdev);
 		has_nonrot_disk |=3D nonrot;
-		pending =3D atomic_read(&rdev->nr_pending);
+		pending =3D nr_pending_read(rdev);
 		if (min_pending > pending && nonrot) {
 			min_pending =3D pending;
 			best_pending_slot =3D slot;
@@ -849,7 +849,7 @@ static struct md_rdev *read_balance(struct r10conf *con=
f,
 	}
=20
 	if (slot >=3D 0) {
-		atomic_inc(&rdev->nr_pending);
+		nr_pending_inc(rdev);
 		r10_bio->read_slot =3D slot;
 	} else
 		rdev =3D NULL;
@@ -1296,12 +1296,12 @@ static void wait_blocked_dev(struct mddev *mddev, s=
truct r10bio *r10_bio)
 		rdev =3D conf->mirrors[i].rdev;
 		rrdev =3D conf->mirrors[i].replacement;
 		if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
-			atomic_inc(&rdev->nr_pending);
+			nr_pending_inc(rdev);
 			blocked_rdev =3D rdev;
 			break;
 		}
 		if (rrdev && unlikely(test_bit(Blocked, &rrdev->flags))) {
-			atomic_inc(&rrdev->nr_pending);
+			nr_pending_inc(rrdev);
 			blocked_rdev =3D rrdev;
 			break;
 		}
@@ -1322,7 +1322,7 @@ static void wait_blocked_dev(struct mddev *mddev, str=
uct r10bio *r10_bio)
 				 * Mustn't write here until the bad block
 				 * is acknowledged
 				 */
-				atomic_inc(&rdev->nr_pending);
+				nr_pending_inc(rdev);
 				set_bit(BlockedBadBlocks, &rdev->flags);
 				blocked_rdev =3D rdev;
 				break;
@@ -1467,11 +1467,11 @@ static void raid10_write_request(struct mddev *mdde=
v, struct bio *bio,
 		}
 		if (rdev) {
 			r10_bio->devs[i].bio =3D bio;
-			atomic_inc(&rdev->nr_pending);
+			nr_pending_inc(rdev);
 		}
 		if (rrdev) {
 			r10_bio->devs[i].repl_bio =3D bio;
-			atomic_inc(&rrdev->nr_pending);
+			nr_pending_inc(rrdev);
 		}
 	}
=20
@@ -1731,11 +1731,11 @@ static int raid10_handle_discard(struct mddev *mdde=
v, struct bio *bio)
=20
 		if (rdev) {
 			r10_bio->devs[disk].bio =3D bio;
-			atomic_inc(&rdev->nr_pending);
+			nr_pending_inc(rdev);
 		}
 		if (rrdev) {
 			r10_bio->devs[disk].repl_bio =3D bio;
-			atomic_inc(&rrdev->nr_pending);
+			nr_pending_inc(rrdev);
 		}
 	}
=20
@@ -2155,7 +2155,7 @@ static int raid10_remove_disk(struct mddev *mddev, st=
ruct md_rdev *rdev)
 		return 0;
=20
 	if (test_bit(In_sync, &rdev->flags) ||
-	    atomic_read(&rdev->nr_pending)) {
+	    nr_pending_is_not_zero(rdev)) {
 		err =3D -EBUSY;
 		goto abort;
 	}
@@ -2394,7 +2394,7 @@ static void sync_request_write(struct mddev *mddev, s=
truct r10bio *r10_bio)
=20
 		bio_copy_data(tbio, fbio);
=20
-		atomic_inc(&conf->mirrors[d].rdev->nr_pending);
+		nr_pending_inc(conf->mirrors[d].rdev);
 		atomic_inc(&r10_bio->remaining);
 		md_sync_acct(conf->mirrors[d].rdev->bdev, bio_sectors(tbio));
=20
@@ -2552,12 +2552,12 @@ static void recovery_request_write(struct mddev *md=
dev, struct r10bio *r10_bio)
 	 */
 	d =3D r10_bio->devs[1].devnum;
 	if (wbio->bi_end_io) {
-		atomic_inc(&conf->mirrors[d].rdev->nr_pending);
+		nr_pending_inc(conf->mirrors[d].rdev);
 		md_sync_acct(conf->mirrors[d].rdev->bdev, bio_sectors(wbio));
 		submit_bio_noacct(wbio);
 	}
 	if (wbio2) {
-		atomic_inc(&conf->mirrors[d].replacement->nr_pending);
+		nr_pending_inc(conf->mirrors[d].replacement);
 		md_sync_acct(conf->mirrors[d].replacement->bdev,
 			     bio_sectors(wbio2));
 		submit_bio_noacct(wbio2);
@@ -2633,7 +2633,7 @@ static void fix_read_error(struct r10conf *conf, stru=
ct mddev *mddev, struct r10
 			    rdev_has_badblock(rdev,
 					      r10_bio->devs[sl].addr + sect,
 					      s) =3D=3D 0) {
-				atomic_inc(&rdev->nr_pending);
+				nr_pending_inc(rdev);
 				success =3D sync_page_io(rdev,
 						       r10_bio->devs[sl].addr +
 						       sect,
@@ -2682,7 +2682,7 @@ static void fix_read_error(struct r10conf *conf, stru=
ct mddev *mddev, struct r10
 			    !test_bit(In_sync, &rdev->flags))
 				continue;
=20
-			atomic_inc(&rdev->nr_pending);
+			nr_pending_inc(rdev);
 			if (r10_sync_page_io(rdev,
 					     r10_bio->devs[sl].addr +
 					     sect,
@@ -2714,7 +2714,7 @@ static void fix_read_error(struct r10conf *conf, stru=
ct mddev *mddev, struct r10
 			    !test_bit(In_sync, &rdev->flags))
 				continue;
=20
-			atomic_inc(&rdev->nr_pending);
+			nr_pending_inc(rdev);
 			switch (r10_sync_page_io(rdev,
 					     r10_bio->devs[sl].addr +
 					     sect,
@@ -3342,9 +3342,9 @@ static sector_t raid10_sync_request(struct mddev *mdd=
ev, sector_t sector_nr,
 				continue;
 			}
 			if (mrdev)
-				atomic_inc(&mrdev->nr_pending);
+				nr_pending_inc(mrdev);
 			if (mreplace)
-				atomic_inc(&mreplace->nr_pending);
+				nr_pending_inc(mreplace);
=20
 			r10_bio =3D raid10_alloc_init_r10buf(conf);
 			r10_bio->state =3D 0;
@@ -3413,7 +3413,7 @@ static sector_t raid10_sync_request(struct mddev *mdd=
ev, sector_t sector_nr,
 				bio->bi_iter.bi_sector =3D from_addr +
 					rdev->data_offset;
 				bio_set_dev(bio, rdev->bdev);
-				atomic_inc(&rdev->nr_pending);
+				nr_pending_inc(rdev);
 				/* and we write to 'i' (if not in_sync) */
=20
 				for (k=3D0; k<conf->copies; k++)
@@ -3601,7 +3601,7 @@ static sector_t raid10_sync_request(struct mddev *mdd=
ev, sector_t sector_nr,
 					continue;
 				}
 			}
-			atomic_inc(&rdev->nr_pending);
+			nr_pending_inc(rdev);
 			atomic_inc(&r10_bio->remaining);
 			bio->bi_next =3D biolist;
 			biolist =3D bio;
@@ -3617,7 +3617,7 @@ static sector_t raid10_sync_request(struct mddev *mdd=
ev, sector_t sector_nr,
 			if (rdev =3D=3D NULL || test_bit(Faulty, &rdev->flags))
 				continue;
=20
-			atomic_inc(&rdev->nr_pending);
+			nr_pending_inc(rdev);
=20
 			/* Need to set up for writing to the replacement */
 			bio =3D r10_bio->devs[i].repl_bio;
@@ -4906,7 +4906,7 @@ static void reshape_request_write(struct mddev *mddev=
, struct r10bio *r10_bio)
 		if (!rdev || test_bit(Faulty, &rdev->flags))
 			continue;
=20
-		atomic_inc(&rdev->nr_pending);
+		nr_pending_inc(rdev);
 		md_sync_acct_bio(b, r10_bio->sectors);
 		atomic_inc(&r10_bio->remaining);
 		b->bi_next =3D NULL;
@@ -4986,7 +4986,7 @@ static int handle_reshape_read_error(struct mddev *md=
dev,
 				goto failed;
=20
 			addr =3D r10b->devs[slot].addr + idx * PAGE_SIZE;
-			atomic_inc(&rdev->nr_pending);
+			nr_pending_inc(rdev);
 			success =3D sync_page_io(rdev,
 					       addr,
 					       s << 9,
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 874874fe4fa1..1253466666e4 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1892,7 +1892,7 @@ r5l_recovery_replay_one_stripe(struct r5conf *conf,
 		/* in case device is broken */
 		rdev =3D conf->disks[disk_index].rdev;
 		if (rdev) {
-			atomic_inc(&rdev->nr_pending);
+			nr_pending_inc(rdev);
 			sync_page_io(rdev, sh->sector, PAGE_SIZE,
 				     sh->dev[disk_index].page, REQ_OP_WRITE,
 				     false);
@@ -1900,7 +1900,7 @@ r5l_recovery_replay_one_stripe(struct r5conf *conf,
 		}
 		rrdev =3D conf->disks[disk_index].replacement;
 		if (rrdev) {
-			atomic_inc(&rrdev->nr_pending);
+			nr_pending_inc(rrdev);
 			sync_page_io(rrdev, sh->sector, PAGE_SIZE,
 				     sh->dev[disk_index].page, REQ_OP_WRITE,
 				     false);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 3b04d8b526b1..25da83eaa2ef 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1199,11 +1199,11 @@ static void ops_run_io(struct stripe_head *sh, stru=
ct stripe_head_state *s)
 		if (rdev && test_bit(Faulty, &rdev->flags))
 			rdev =3D NULL;
 		if (rdev)
-			atomic_inc(&rdev->nr_pending);
+			nr_pending_inc(rdev);
 		if (rrdev && test_bit(Faulty, &rrdev->flags))
 			rrdev =3D NULL;
 		if (rrdev)
-			atomic_inc(&rrdev->nr_pending);
+			nr_pending_inc(rrdev);
=20
 		/* We have already checked bad blocks for reads.  Now
 		 * need to check for writes.  We never accept write errors
@@ -1231,7 +1231,7 @@ static void ops_run_io(struct stripe_head *sh, struct=
 stripe_head_state *s)
 				 * will dec nr_pending, we must
 				 * increment it first.
 				 */
-				atomic_inc(&rdev->nr_pending);
+				nr_pending_inc(rdev);
 				md_wait_for_blocked_rdev(rdev, conf->mddev);
 			} else {
 				/* Acknowledged bad block - skip the write */
@@ -3628,7 +3628,7 @@ handle_failed_stripe(struct r5conf *conf, struct stri=
pe_head *sh,
=20
 			if (rdev && test_bit(In_sync, &rdev->flags) &&
 			    !test_bit(Faulty, &rdev->flags))
-				atomic_inc(&rdev->nr_pending);
+				nr_pending_inc(rdev);
 			else
 				rdev =3D NULL;
 			if (rdev) {
@@ -4729,7 +4729,7 @@ static void analyse_stripe(struct stripe_head *sh, st=
ruct stripe_head_state *s)
 					set_bit(BlockedBadBlocks,
 						&rdev->flags);
 				s->blocked_rdev =3D rdev;
-				atomic_inc(&rdev->nr_pending);
+				nr_pending_inc(rdev);
 			}
 		}
 		clear_bit(R5_Insync, &dev->flags);
@@ -4767,7 +4767,7 @@ static void analyse_stripe(struct stripe_head *sh, st=
ruct stripe_head_state *s)
 				clear_bit(R5_Insync, &dev->flags);
 			if (rdev2 && !test_bit(Faulty, &rdev2->flags)) {
 				s->handle_bad_blocks =3D 1;
-				atomic_inc(&rdev2->nr_pending);
+				nr_pending_inc(rdev2);
 			} else
 				clear_bit(R5_WriteError, &dev->flags);
 		}
@@ -4778,7 +4778,7 @@ static void analyse_stripe(struct stripe_head *sh, st=
ruct stripe_head_state *s)
=20
 			if (rdev2 && !test_bit(Faulty, &rdev2->flags)) {
 				s->handle_bad_blocks =3D 1;
-				atomic_inc(&rdev2->nr_pending);
+				nr_pending_inc(rdev2);
 			} else
 				clear_bit(R5_MadeGood, &dev->flags);
 		}
@@ -4787,7 +4787,7 @@ static void analyse_stripe(struct stripe_head *sh, st=
ruct stripe_head_state *s)
=20
 			if (rdev2 && !test_bit(Faulty, &rdev2->flags)) {
 				s->handle_bad_blocks =3D 1;
-				atomic_inc(&rdev2->nr_pending);
+				nr_pending_inc(rdev2);
 			} else
 				clear_bit(R5_MadeGoodRepl, &dev->flags);
 		}
@@ -5478,7 +5478,7 @@ static int raid5_read_one_chunk(struct mddev *mddev, =
struct bio *raid_bio)
 			return 0;
 	}
=20
-	atomic_inc(&rdev->nr_pending);
+	nr_pending_inc(rdev);
=20
 	if (rdev_has_badblock(rdev, sector, bio_sectors(raid_bio))) {
 		rdev_dec_pending(rdev, mddev);
@@ -8157,7 +8157,7 @@ static int raid5_remove_disk(struct mddev *mddev, str=
uct md_rdev *rdev)
 		clear_bit(In_sync, &rdev->flags);
=20
 	if (test_bit(In_sync, &rdev->flags) ||
-	    atomic_read(&rdev->nr_pending)) {
+	    nr_pending_is_not_zero(rdev)) {
 		err =3D -EBUSY;
 		goto abort;
 	}
--=20
2.34.1



