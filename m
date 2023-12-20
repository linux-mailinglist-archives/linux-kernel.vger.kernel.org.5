Return-Path: <linux-kernel+bounces-6691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9E8819C23
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944801C25945
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6506536AFE;
	Wed, 20 Dec 2023 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYUD389D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A692D63B;
	Wed, 20 Dec 2023 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3e05abcaeso8934345ad.1;
        Wed, 20 Dec 2023 02:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703066654; x=1703671454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sW3eW9PuHv4Fe1koP1TqpWUtRi+VDbD5jjvTdO++WUw=;
        b=JYUD389DJ7ENWDkRUNH4V4edYKbfh/3LLWvvihiNNvgbSVVjB7S69XndJ588yt9AMb
         soVIl2oBW+e7F6k5F1kH1laZI95OnbOOvIPH8Oa1S4AU+tSFAI5CaRQaokqR/AOvh5gJ
         eO1ucSUWFtbaQF8OXKQCuTrVDDAguo5rthPT63oN+OPM6WIgqvTjiVGqsh+Hbaj/kBsv
         IiHQqbkWulGSKsvt/wrKQJ+0xYcl3t0m1s56CuYQg2/r4Zwxl/hYfwxq6b5SNArRKZPK
         +Xg2NVWGo3ovwPqHzS6erXkmayDkA7zUVbvnQZDOwKKuBzSXgZKuZyFRMGP8LOeVH0Za
         3tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703066654; x=1703671454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sW3eW9PuHv4Fe1koP1TqpWUtRi+VDbD5jjvTdO++WUw=;
        b=GiN6+eE5z/3kmNsRR9CwTslh0QF/PVKmCa8OI8JVGoCw4V63fuZPDiR0QDXvX4iZ6O
         Lh36yNUtHbep6+tSDUvyoDXDXzS3I8K7v9SgCZYq4H+pSCmHz3f/rEnI51Yqjx0K/zoP
         covPnuq7X0oEK6CHf8UkXnNCRQexhHAHIiJ/OjELBRRYe05SnQhVxJoDPU0BcUjX9oDl
         pKVOsHJNYK8xjgLUtiMk508jU2Dj0CJxWtwUo9Mer+SdGLdYlqc0n88uYsArBST9QtF5
         rpmiI95UKt+xPoWRxFjB2ms2//1lY4AWooAQWrNnK5OeakBXENeSgEBV12Iyy2eUUkxA
         dkVA==
X-Gm-Message-State: AOJu0YyYTdyjOxgejgDqkSofbK99hGEhivtYyawjeMXMLiX4IeWxWlR+
	fAWjxV3pOg+WC/tiQ0I49whL6zKCnzg=
X-Google-Smtp-Source: AGHT+IEABYPlMU3TR3IPjOsGIWXWOL2ujzrd03OfhVqkiAPH7mYY9i4qCbjDSxekpUopR0MPHdHHpg==
X-Received: by 2002:a17:902:d2cb:b0:1d0:8db6:17d0 with SMTP id n11-20020a170902d2cb00b001d08db617d0mr12006219plc.25.1703066653776;
        Wed, 20 Dec 2023 02:04:13 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902fe8300b001d3b7c5776asm5721619plm.160.2023.12.20.02.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 02:04:13 -0800 (PST)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	axboe@kernel.dk,
	ebiggers@kernel.org
Cc: zhiguo.niu@unisoc.com,
	ke.wang@unisoc.com,
	yibin.ding@unisoc.com,
	hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH v6 4/5] dm verity: Fix I/O priority lost when read FEC and hash
Date: Wed, 20 Dec 2023 18:03:32 +0800
Message-Id: <20231220100333.107049-5-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220100333.107049-1-hongyu.jin.cn@gmail.com>
References: <20231213104216.27845-6-hongyu.jin.cn@gmail.com>
 <20231220100333.107049-1-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Jin <hongyu.jin@unisoc.com>

After obtaining the data, verification or error correction process may
trigger a new I/O that loses the priority of the original I/O, that is,
the verification of the higher priority IO may be blocked by the lower
priority IO.

Make the I/O of verification and error correction follow the
priority of original I/O.

Co-developed-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 drivers/md/dm-verity-fec.c    | 20 +++++++++++++++-----
 drivers/md/dm-verity-target.c | 12 ++++++++----
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 49db19e537f9..a9e5402e3d43 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -18,6 +18,12 @@ bool verity_fec_is_enabled(struct dm_verity *v)
 	return v->fec && v->fec->dev;
 }
 
+static inline struct dm_verity_io *verity_io(struct dm_verity *v, struct dm_verity_fec_io *fio)
+{
+	return (struct dm_verity_io *)
+		((char *)fio + sizeof(struct dm_verity_fec_io) - v->ti->per_io_data_size);
+}
+
 /*
  * Return a pointer to dm_verity_fec_io after dm_verity_io and its variable
  * length fields.
@@ -60,7 +66,8 @@ static int fec_decode_rs8(struct dm_verity *v, struct dm_verity_fec_io *fio,
  * to the data block. Caller is responsible for releasing buf.
  */
 static u8 *fec_read_parity(struct dm_verity *v, u64 rsb, int index,
-			   unsigned int *offset, struct dm_buffer **buf)
+			   unsigned int *offset, struct dm_buffer **buf,
+			   unsigned short ioprio)
 {
 	u64 position, block, rem;
 	u8 *res;
@@ -69,7 +76,7 @@ static u8 *fec_read_parity(struct dm_verity *v, u64 rsb, int index,
 	block = div64_u64_rem(position, v->fec->io_size, &rem);
 	*offset = (unsigned int)rem;
 
-	res = dm_bufio_read(v->fec->bufio, block, buf, IOPRIO_DEFAULT);
+	res = dm_bufio_read(v->fec->bufio, block, buf, ioprio);
 	if (IS_ERR(res)) {
 		DMERR("%s: FEC %llu: parity read failed (block %llu): %ld",
 		      v->data_dev->name, (unsigned long long)rsb,
@@ -129,8 +136,10 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_fec_io *fio,
 	struct dm_buffer *buf;
 	unsigned int n, i, offset;
 	u8 *par, *block;
+	struct dm_verity_io *io = verity_io(v, fio);
+	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
-	par = fec_read_parity(v, rsb, block_offset, &offset, &buf);
+	par = fec_read_parity(v, rsb, block_offset, &offset, &buf, bio_prio(bio));
 	if (IS_ERR(par))
 		return PTR_ERR(par);
 
@@ -158,7 +167,7 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_fec_io *fio,
 		if (offset >= v->fec->io_size) {
 			dm_bufio_release(buf);
 
-			par = fec_read_parity(v, rsb, block_offset, &offset, &buf);
+			par = fec_read_parity(v, rsb, block_offset, &offset, &buf, bio_prio(bio));
 			if (IS_ERR(par))
 				return PTR_ERR(par);
 		}
@@ -210,6 +219,7 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
 	u8 *bbuf, *rs_block;
 	u8 want_digest[HASH_MAX_DIGESTSIZE];
 	unsigned int n, k;
+	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
 	if (neras)
 		*neras = 0;
@@ -248,7 +258,7 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
 			bufio = v->bufio;
 		}
 
-		bbuf = dm_bufio_read(bufio, block, &buf, IOPRIO_DEFAULT);
+		bbuf = dm_bufio_read(bufio, block, &buf, bio_prio(bio));
 		if (IS_ERR(bbuf)) {
 			DMWARN_LIMIT("%s: FEC %llu: read failed (%llu): %ld",
 				     v->data_dev->name,
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 4758bfe2c156..8cbf81fc0031 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -51,6 +51,7 @@ static DEFINE_STATIC_KEY_FALSE(use_tasklet_enabled);
 struct dm_verity_prefetch_work {
 	struct work_struct work;
 	struct dm_verity *v;
+	unsigned short ioprio;
 	sector_t block;
 	unsigned int n_blocks;
 };
@@ -294,6 +295,7 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
 	int r;
 	sector_t hash_block;
 	unsigned int offset;
+	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
 	verity_hash_at_level(v, block, level, &hash_block, &offset);
 
@@ -308,7 +310,7 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
 			return -EAGAIN;
 		}
 	} else
-		data = dm_bufio_read(v->bufio, hash_block, &buf, IOPRIO_DEFAULT);
+		data = dm_bufio_read(v->bufio, hash_block, &buf, bio_prio(bio));
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -720,13 +722,14 @@ static void verity_prefetch_io(struct work_struct *work)
 no_prefetch_cluster:
 		dm_bufio_prefetch(v->bufio, hash_block_start,
 				  hash_block_end - hash_block_start + 1,
-				  IOPRIO_DEFAULT);
+				  pw->ioprio);
 	}
 
 	kfree(pw);
 }
 
-static void verity_submit_prefetch(struct dm_verity *v, struct dm_verity_io *io)
+static void verity_submit_prefetch(struct dm_verity *v, struct dm_verity_io *io,
+				   unsigned short ioprio)
 {
 	sector_t block = io->block;
 	unsigned int n_blocks = io->n_blocks;
@@ -754,6 +757,7 @@ static void verity_submit_prefetch(struct dm_verity *v, struct dm_verity_io *io)
 	pw->v = v;
 	pw->block = block;
 	pw->n_blocks = n_blocks;
+	pw->ioprio = ioprio;
 	queue_work(v->verify_wq, &pw->work);
 }
 
@@ -796,7 +800,7 @@ static int verity_map(struct dm_target *ti, struct bio *bio)
 
 	verity_fec_init_io(io);
 
-	verity_submit_prefetch(v, io);
+	verity_submit_prefetch(v, io, bio_prio(bio));
 
 	submit_bio_noacct(bio);
 
-- 
2.34.1


