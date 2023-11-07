Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719917E468B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbjKGRIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKGRIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:08:14 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1DCB4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:08:11 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-543923af573so10147974a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699376890; x=1699981690; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jn/WYP8Ihax6W09QbYQPddro7SKKCKI80Jm0LmD5tLU=;
        b=KGhlaOe6p90SHEGy/m8N7pz1eLRSAvfjCFzHuDWQFp477fap/9R8OEN061Pznp3vqw
         NxjYQx4Z2sf+0q3zxhsspsm/tZgWRnKgjmh6Lv4OjH9PUvqFVzr+3jvZTi/6kaLhKPcc
         9CRdPjB/ETukdT19xnJjrOp10zDErbO+JLtGEEbQojL/jLJ7tfkiFI9IAA+hbIKhuK8g
         1lc2tytPU/JwPaNhxthG8PVfc3JAR43avBpRqA9tKlfYvTuBk2pveMKF8pvTcKqe+RUX
         txMQaDXfKXMnt0rZMI9oCQi5If4aSnUyq+atc3ZGlewVJ2Gym0wC5VqMS1tV/nUlLvPY
         QkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699376890; x=1699981690;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jn/WYP8Ihax6W09QbYQPddro7SKKCKI80Jm0LmD5tLU=;
        b=gKrA6vPLINthi3O1upfmtvomWpdltXGHIAem8eq0DAythQKMFCLUS4p7skGRvKCZ+V
         p/N/xb37ne6TRNv/bqJpPm9EbpR2QhgnPP7g7XWaJ0uM0kcwBQlqClBg15MEd5yn3gUD
         fI5JHb6fcGD51e+3uMHQxCuCwKTGLhWLmiP4AgD9w+yZ9zNbHopSmN6SBGX8KJp7u1D2
         4NRvMKTOIUS2r7+p/YtmmEZE+M3DWeJRN9KRuXtSGyAWd11P88vV+Z8poPzQfmVR0pVg
         7uPPf041T5yoqGMLvHw1UuO2WrLVKR/ym2QoSyS6rxejOWyJkUjb0Rgwq7JvFzG1a9Gv
         DWCA==
X-Gm-Message-State: AOJu0YzaCI0NV04PnIrs/KaqLtOxQvmpy32oDuqbhGjCgXm0uCh3f/06
        aUpcj7llxbleTKFLHOTipmPchg==
X-Google-Smtp-Source: AGHT+IGQ9UTulfYlRN2xx3Xd+4otU+n8+LqQAWeLNFHwoPjDuvJs8E/4TDZWCht4bidpKQkCKKmzxw==
X-Received: by 2002:a17:906:c14b:b0:9ad:a59f:331a with SMTP id dp11-20020a170906c14b00b009ada59f331amr16476020ejc.57.1699376890280;
        Tue, 07 Nov 2023 09:08:10 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id jt10-20020a170906ca0a00b0099bcf9c2ec6sm1262055ejb.75.2023.11.07.09.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:08:09 -0800 (PST)
Date:   Tue, 7 Nov 2023 20:08:07 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Kent Overstreet <kmo@daterainc.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: fs/bcachefs/btree_update_interior.c:1582 btree_split() warn:
 variable dereferenced before check 'path1' (see line 1483)
Message-ID: <137a7e1f-3d8d-4317-bc9a-707b05818e95@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
commit: e4215d0fec777e6516306f5f1b69a45a4205dce0 bcachefs: All held locks must be in a btree path
config: x86_64-randconfig-161-20231107 (https://download.01.org/0day-ci/archive/20231107/202311072233.KsJQSI13-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231107/202311072233.KsJQSI13-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202311072233.KsJQSI13-lkp@intel.com/

smatch warnings:
fs/bcachefs/btree_update_interior.c:1582 btree_split() warn: variable dereferenced before check 'path1' (see line 1483)

vim +/path1 +1582 fs/bcachefs/btree_update_interior.c

67e0dd8f0d8b4bf Kent Overstreet 2021-08-30  1451  static void btree_split(struct btree_update *as, struct btree_trans *trans,
67e0dd8f0d8b4bf Kent Overstreet 2021-08-30  1452  			struct btree_path *path, struct btree *b,
67e0dd8f0d8b4bf Kent Overstreet 2021-08-30  1453  			struct keylist *keys, unsigned flags)
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1454  {
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1455  	struct bch_fs *c = as->c;
67e0dd8f0d8b4bf Kent Overstreet 2021-08-30  1456  	struct btree *parent = btree_node_parent(path, b);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1457  	struct btree *n1, *n2 = NULL, *n3 = NULL;
e4215d0fec777e6 Kent Overstreet 2022-09-16  1458  	struct btree_path *path1 = NULL, *path2 = NULL;
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1459  	u64 start_time = local_clock();
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1460  
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1461  	BUG_ON(!parent && (b != btree_node_root(c, b)));
67e0dd8f0d8b4bf Kent Overstreet 2021-08-30  1462  	BUG_ON(!btree_node_intent_locked(path, btree_node_root(c, b)->c.level));
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1463  
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1464  	bch2_btree_interior_update_will_free_node(as, b);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1465  
ca7d8fcabf29fae Kent Overstreet 2022-08-21  1466  	n1 = bch2_btree_node_alloc_replacement(as, trans, b);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1467  
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1468  	if (keys)
67e0dd8f0d8b4bf Kent Overstreet 2021-08-30  1469  		btree_split_insert_keys(as, trans, path, n1, keys);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1470  
5525f632dc123ed Kent Overstreet 2020-01-15  1471  	if (bset_u64s(&n1->set[0]) > BTREE_SPLIT_THRESHOLD(c)) {
674cfc26240b780 Kent Overstreet 2022-08-27  1472  		trace_and_count(c, btree_node_split, c, b);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1473  
ca7d8fcabf29fae Kent Overstreet 2022-08-21  1474  		n2 = __btree_split_node(as, trans, n1);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1475  
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1476  		bch2_btree_build_aux_trees(n2);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1477  		bch2_btree_build_aux_trees(n1);
c43a6ef9a0747ef Kent Overstreet 2020-06-06  1478  		six_unlock_write(&n2->c.lock);
c43a6ef9a0747ef Kent Overstreet 2020-06-06  1479  		six_unlock_write(&n1->c.lock);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1480  
e4215d0fec777e6 Kent Overstreet 2022-09-16  1481  		path1 = get_unlocked_mut_path(trans, path->btree_id, n1->c.level, n1->key.k.p);
e4215d0fec777e6 Kent Overstreet 2022-09-16  1482  		six_lock_increment(&n1->c.lock, SIX_LOCK_intent);
e4215d0fec777e6 Kent Overstreet 2022-09-16 @1483  		mark_btree_node_locked(trans, path1, n1->c.level, SIX_LOCK_intent);

path1 dereferenced without checking.

e4215d0fec777e6 Kent Overstreet 2022-09-16  1484  		bch2_btree_path_level_init(trans, path1, n1);
e4215d0fec777e6 Kent Overstreet 2022-09-16  1485  
e4215d0fec777e6 Kent Overstreet 2022-09-16  1486  		path2 = get_unlocked_mut_path(trans, path->btree_id, n2->c.level, n2->key.k.p);
e4215d0fec777e6 Kent Overstreet 2022-09-16  1487  		six_lock_increment(&n2->c.lock, SIX_LOCK_intent);
e4215d0fec777e6 Kent Overstreet 2022-09-16  1488  		mark_btree_node_locked(trans, path2, n2->c.level, SIX_LOCK_intent);
e4215d0fec777e6 Kent Overstreet 2022-09-16  1489  		bch2_btree_path_level_init(trans, path2, n2);
e4215d0fec777e6 Kent Overstreet 2022-09-16  1490  
7419646b254a599 Kent Overstreet 2022-04-14  1491  		bch2_btree_update_add_new_node(as, n1);
7419646b254a599 Kent Overstreet 2022-04-14  1492  
82732ef510b8455 Kent Overstreet 2022-02-26  1493  		bch2_btree_node_write(c, n1, SIX_LOCK_intent, 0);
82732ef510b8455 Kent Overstreet 2022-02-26  1494  		bch2_btree_node_write(c, n2, SIX_LOCK_intent, 0);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1495  
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1496  		/*
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1497  		 * Note that on recursive parent_keys == keys, so we
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1498  		 * can't start adding new keys to parent_keys before emptying it
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1499  		 * out (which we did with btree_split_insert_keys() above)
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1500  		 */
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1501  		bch2_keylist_add(&as->parent_keys, &n1->key);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1502  		bch2_keylist_add(&as->parent_keys, &n2->key);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1503  
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1504  		if (!parent) {
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1505  			/* Depth increases, make a new root */
ca7d8fcabf29fae Kent Overstreet 2022-08-21  1506  			n3 = __btree_root_alloc(as, trans, b->c.level + 1);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1507  
e4215d0fec777e6 Kent Overstreet 2022-09-16  1508  			path2->locks_want++;
e4215d0fec777e6 Kent Overstreet 2022-09-16  1509  			BUG_ON(btree_node_locked(path2, n3->c.level));
e4215d0fec777e6 Kent Overstreet 2022-09-16  1510  			six_lock_increment(&n3->c.lock, SIX_LOCK_intent);
e4215d0fec777e6 Kent Overstreet 2022-09-16  1511  			mark_btree_node_locked(trans, path2, n3->c.level, SIX_LOCK_intent);
e4215d0fec777e6 Kent Overstreet 2022-09-16  1512  			bch2_btree_path_level_init(trans, path2, n3);
e4215d0fec777e6 Kent Overstreet 2022-09-16  1513  
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1514  			n3->sib_u64s[0] = U16_MAX;
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1515  			n3->sib_u64s[1] = U16_MAX;
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1516  
67e0dd8f0d8b4bf Kent Overstreet 2021-08-30  1517  			btree_split_insert_keys(as, trans, path, n3, &as->parent_keys);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1518  
82732ef510b8455 Kent Overstreet 2022-02-26  1519  			bch2_btree_node_write(c, n3, SIX_LOCK_intent, 0);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1520  		}
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1521  	} else {
674cfc26240b780 Kent Overstreet 2022-08-27  1522  		trace_and_count(c, btree_node_compact, c, b);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1523  
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1524  		bch2_btree_build_aux_trees(n1);
c43a6ef9a0747ef Kent Overstreet 2020-06-06  1525  		six_unlock_write(&n1->c.lock);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1526  
e4215d0fec777e6 Kent Overstreet 2022-09-16  1527  		path1 = get_unlocked_mut_path(trans, path->btree_id, n1->c.level, n1->key.k.p);
e4215d0fec777e6 Kent Overstreet 2022-09-16  1528  		six_lock_increment(&n1->c.lock, SIX_LOCK_intent);
e4215d0fec777e6 Kent Overstreet 2022-09-16  1529  		mark_btree_node_locked(trans, path1, n1->c.level, SIX_LOCK_intent);

path1 dereferenced here.

e4215d0fec777e6 Kent Overstreet 2022-09-16  1530  		bch2_btree_path_level_init(trans, path1, n1);
e4215d0fec777e6 Kent Overstreet 2022-09-16  1531  
7419646b254a599 Kent Overstreet 2022-04-14  1532  		bch2_btree_update_add_new_node(as, n1);
7419646b254a599 Kent Overstreet 2022-04-14  1533  
82732ef510b8455 Kent Overstreet 2022-02-26  1534  		bch2_btree_node_write(c, n1, SIX_LOCK_intent, 0);
9f1833cadda7bb4 Kent Overstreet 2021-07-10  1535  
6357d6071fccb5c Kent Overstreet 2020-02-08  1536  		if (parent)
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1537  			bch2_keylist_add(&as->parent_keys, &n1->key);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1538  	}
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1539  
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1540  	/* New nodes all written, now make them visible: */
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1541  
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1542  	if (parent) {
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1543  		/* Split a non root node */
67e0dd8f0d8b4bf Kent Overstreet 2021-08-30  1544  		bch2_btree_insert_node(as, trans, path, parent, &as->parent_keys, flags);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1545  	} else if (n3) {
67e0dd8f0d8b4bf Kent Overstreet 2021-08-30  1546  		bch2_btree_set_root(as, trans, path, n3);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1547  	} else {
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1548  		/* Root filled up but didn't need to be split */
67e0dd8f0d8b4bf Kent Overstreet 2021-08-30  1549  		bch2_btree_set_root(as, trans, path, n1);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1550  	}
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1551  
00b8ccf7074fddb Kent Overstreet 2020-05-25  1552  	bch2_btree_update_get_open_buckets(as, n1);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1553  	if (n2)
00b8ccf7074fddb Kent Overstreet 2020-05-25  1554  		bch2_btree_update_get_open_buckets(as, n2);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1555  	if (n3)
00b8ccf7074fddb Kent Overstreet 2020-05-25  1556  		bch2_btree_update_get_open_buckets(as, n3);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1557  
ea3532cbf7fdbb9 Kent Overstreet 2019-10-11  1558  	/*
ea3532cbf7fdbb9 Kent Overstreet 2019-10-11  1559  	 * The old node must be freed (in memory) _before_ unlocking the new
ea3532cbf7fdbb9 Kent Overstreet 2019-10-11  1560  	 * nodes - else another thread could re-acquire a read lock on the old
ea3532cbf7fdbb9 Kent Overstreet 2019-10-11  1561  	 * node after another thread has locked and updated the new node, thus
ea3532cbf7fdbb9 Kent Overstreet 2019-10-11  1562  	 * seeing stale data:
ea3532cbf7fdbb9 Kent Overstreet 2019-10-11  1563  	 */
38474c264252475 Kent Overstreet 2022-09-02  1564  	bch2_btree_node_free_inmem(trans, path, b);
38474c264252475 Kent Overstreet 2022-09-02  1565  
38474c264252475 Kent Overstreet 2022-09-02  1566  	if (n3)
38474c264252475 Kent Overstreet 2022-09-02  1567  		bch2_trans_node_add(trans, n3);
38474c264252475 Kent Overstreet 2022-09-02  1568  	if (n2)
38474c264252475 Kent Overstreet 2022-09-02  1569  		bch2_trans_node_add(trans, n2);
38474c264252475 Kent Overstreet 2022-09-02  1570  	bch2_trans_node_add(trans, n1);
ad7ae8d63fa82e5 Kent Overstreet 2018-11-23  1571  
ea3532cbf7fdbb9 Kent Overstreet 2019-10-11  1572  	if (n3)
ea3532cbf7fdbb9 Kent Overstreet 2019-10-11  1573  		six_unlock_intent(&n3->c.lock);
ea3532cbf7fdbb9 Kent Overstreet 2019-10-11  1574  	if (n2)
ea3532cbf7fdbb9 Kent Overstreet 2019-10-11  1575  		six_unlock_intent(&n2->c.lock);
ea3532cbf7fdbb9 Kent Overstreet 2019-10-11  1576  	six_unlock_intent(&n1->c.lock);
ea3532cbf7fdbb9 Kent Overstreet 2019-10-11  1577  
e4215d0fec777e6 Kent Overstreet 2022-09-16  1578  	if (path2) {
e4215d0fec777e6 Kent Overstreet 2022-09-16  1579  		__bch2_btree_path_unlock(trans, path2);
e4215d0fec777e6 Kent Overstreet 2022-09-16  1580  		bch2_path_put(trans, path2, true);
e4215d0fec777e6 Kent Overstreet 2022-09-16  1581  	}
e4215d0fec777e6 Kent Overstreet 2022-09-16 @1582  	if (path1) {

path1 was already dereferenced.

e4215d0fec777e6 Kent Overstreet 2022-09-16  1583  		__bch2_btree_path_unlock(trans, path1);
e4215d0fec777e6 Kent Overstreet 2022-09-16  1584  		bch2_path_put(trans, path1, true);
e4215d0fec777e6 Kent Overstreet 2022-09-16  1585  	}
e4215d0fec777e6 Kent Overstreet 2022-09-16  1586  
a0a568794d09a20 Kent Overstreet 2021-08-30  1587  	bch2_trans_verify_locks(trans);
ad7ae8d63fa82e5 Kent Overstreet 2018-11-23  1588  
991ba0211290884 Kent Overstreet 2021-12-10  1589  	bch2_time_stats_update(&c->times[n2
991ba0211290884 Kent Overstreet 2021-12-10  1590  			       ? BCH_TIME_btree_node_split
991ba0211290884 Kent Overstreet 2021-12-10  1591  			       : BCH_TIME_btree_node_compact],
dc3b63dc33e1b65 Kent Overstreet 2019-03-21  1592  			       start_time);
1c6fdbd8f2465dd Kent Overstreet 2017-03-16  1593  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

