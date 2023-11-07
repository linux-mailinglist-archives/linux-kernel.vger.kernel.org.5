Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDD47E3541
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjKGGfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjKGGfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:35:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBB911F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 22:34:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB22F206E5;
        Tue,  7 Nov 2023 06:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1699338893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WcQhuTNvhk6n4P8PBBtNtmdgRCUryDqiWrT6/OvGzQ4=;
        b=nu2Sxv+TTiTeTgTWKVX5ZmNif53TRFe12XQnrlSGWUPx5O6+Ujdz57aXPr/aT3wraCn9FW
        n5WAgDa2iOe+ktY2VOu0Fr4By3PwitSOCoufFfZV8peV48o9idk72Dqrdiy8nZ6zXQvT4P
        be3fKuNeKauSr2PqVWuGs7DUS9hqvWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1699338893;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WcQhuTNvhk6n4P8PBBtNtmdgRCUryDqiWrT6/OvGzQ4=;
        b=g+Wc2avwP5C4iRRjRbbEmwUSh28T44CnXELC97jeCfi7y1yzHziBk8S86tEedRWykbhbA+
        Z37hVlFM4wSlfgCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCAA2132FD;
        Tue,  7 Nov 2023 06:34:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QKoxIovaSWUIHgAAMHmgww
        (envelope-from <colyli@suse.de>); Tue, 07 Nov 2023 06:34:51 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: drivers/md/bcache/btree.c:1511 btree_gc_rewrite_node() error: 'n'
 dereferencing possible ERR_PTR()
From:   Coly Li <colyli@suse.de>
In-Reply-To: <a754f8a3-cbfb-42bb-b776-94ecac062daf@kadam.mountain>
Date:   Tue, 7 Nov 2023 14:34:38 +0800
Cc:     oe-kbuild@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6AAB7139-DE98-49BC-9DF9-F1819A39795E@suse.de>
References: <a754f8a3-cbfb-42bb-b776-94ecac062daf@kadam.mountain>
To:     Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B411=E6=9C=886=E6=97=A5 17:11=EF=BC=8CDan Carpenter =
<dan.carpenter@linaro.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi Zheng,
>=20
> FYI, the error/warning was bisected to this commit, please ignore it =
if it's irrelevant.
>=20
> tree:   =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
> head:   77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3
> commit: 028ddcac477b691dd9205c92f991cc15259d033e bcache: Remove =
unnecessary NULL point check in node allocations
> config: x86_64-randconfig-161-20231102 =
(https://download.01.org/0day-ci/archive/20231106/202311060857.2jHVe0uk-lk=
p@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce: =
(https://download.01.org/0day-ci/archive/20231106/202311060857.2jHVe0uk-lk=
p@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: =
https://lore.kernel.org/r/202311060857.2jHVe0uk-lkp@intel.com/
>=20
> New smatch warnings:
> drivers/md/bcache/btree.c:1511 btree_gc_rewrite_node() error: 'n' =
dereferencing possible ERR_PTR()
>=20
> Old smatch warnings:
> drivers/md/bcache/btree.c:1527 btree_gc_rewrite_node() error: 'n' =
dereferencing possible ERR_PTR()
>=20
> vim +/n +1511 drivers/md/bcache/btree.c
>=20
> 0a63b66db566cf Kent Overstreet 2014-03-17  1497  static int =
btree_gc_rewrite_node(struct btree *b, struct btree_op *op,
> 0a63b66db566cf Kent Overstreet 2014-03-17  1498   struct btree =
*replace)
> 0a63b66db566cf Kent Overstreet 2014-03-17  1499  {
> 0a63b66db566cf Kent Overstreet 2014-03-17  1500   struct keylist keys;
> 0a63b66db566cf Kent Overstreet 2014-03-17  1501   struct btree *n;
> 0a63b66db566cf Kent Overstreet 2014-03-17  1502 =20
> 0a63b66db566cf Kent Overstreet 2014-03-17  1503   if =
(btree_check_reserve(b, NULL))
> 0a63b66db566cf Kent Overstreet 2014-03-17  1504   return 0;
> 0a63b66db566cf Kent Overstreet 2014-03-17  1505 =20
> 0a63b66db566cf Kent Overstreet 2014-03-17  1506   n =3D =
btree_node_alloc_replacement(replace, NULL);
>=20
> Needs some error handling.  I don't know why the zero day bot is
> sending repeat warnings today but this one is still worth fixing.
> I guess the zero day bot sent the previous warning to the wrong people
> last time.

Yes this is a valid report. I feel checking n after =
btree_node_alloc_replacement() is necessary, and recent change from =
Zheng exported this potential issue to static code checking tool.

Since Zheng doesn=E2=80=99t respond yet, I will post a patch to fix the =
potential issue.

Thanks.


Coly Li


>=20
> =
https://lore.kernel.org/all/bab6966d-3f96-44a0-b666-ddf976179eab@kadam.mou=
ntain/
>=20
> 0a63b66db566cf Kent Overstreet 2014-03-17  1507 =20
> 0a63b66db566cf Kent Overstreet 2014-03-17  1508   /* recheck reserve =
after allocating replacement node */
> 0a63b66db566cf Kent Overstreet 2014-03-17  1509   if =
(btree_check_reserve(b, NULL)) {
> 0a63b66db566cf Kent Overstreet 2014-03-17  1510   btree_node_free(n);
> 0a63b66db566cf Kent Overstreet 2014-03-17 @1511   rw_unlock(true, n);
> 0a63b66db566cf Kent Overstreet 2014-03-17  1512   return 0;
> 0a63b66db566cf Kent Overstreet 2014-03-17  1513   }
> 0a63b66db566cf Kent Overstreet 2014-03-17  1514 =20
> 0a63b66db566cf Kent Overstreet 2014-03-17  1515   =
bch_btree_node_write_sync(n);
> 0a63b66db566cf Kent Overstreet 2014-03-17  1516 =20
> 0a63b66db566cf Kent Overstreet 2014-03-17  1517   =
bch_keylist_init(&keys);
> 0a63b66db566cf Kent Overstreet 2014-03-17  1518   =
bch_keylist_add(&keys, &n->key);
> 0a63b66db566cf Kent Overstreet 2014-03-17  1519 =20
> 0a63b66db566cf Kent Overstreet 2014-03-17  1520   =
make_btree_freeing_key(replace, keys.top);
> 0a63b66db566cf Kent Overstreet 2014-03-17  1521   =
bch_keylist_push(&keys);
> 0a63b66db566cf Kent Overstreet 2014-03-17  1522 =20
> 0a63b66db566cf Kent Overstreet 2014-03-17  1523   =
bch_btree_insert_node(b, op, &keys, NULL, NULL);
> 0a63b66db566cf Kent Overstreet 2014-03-17  1524   =
BUG_ON(!bch_keylist_empty(&keys));
> 0a63b66db566cf Kent Overstreet 2014-03-17  1525 =20
> 0a63b66db566cf Kent Overstreet 2014-03-17  1526   =
btree_node_free(replace);
> 0a63b66db566cf Kent Overstreet 2014-03-17  1527   rw_unlock(true, n);
> 0a63b66db566cf Kent Overstreet 2014-03-17  1528 =20
> 0a63b66db566cf Kent Overstreet 2014-03-17  1529   /* Invalidated our =
iterator */
> 0a63b66db566cf Kent Overstreet 2014-03-17  1530   return -EINTR;
> 0a63b66db566cf Kent Overstreet 2014-03-17  1531  }
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>=20

