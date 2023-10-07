Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66817BC6E3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343842AbjJGKoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 06:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbjJGKon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:44:43 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A5693
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 03:44:39 -0700 (PDT)
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a02d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4S2hkW3pHpz49PsK;
        Sat,  7 Oct 2023 13:44:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1696675475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=nU/uYiTBYGsGFzZi+XpqncNjH4ICSyCuLZYYHVXYlRM=;
        b=eWvxSwJ113WzbrBC9kkN+FO0DAUGD3NwrsVuN+m2Yt1kfE+R3ZqQo1uZ5Bnf+wGYNfQvch
        YIg65sp32qhRsycHDYKBq9fXeI+x755jYh4sSqXd2QN3sD9G88hVapnZyydePu2rUVPRbr
        wKpUzHzZh83oluIs3PP3DeTY62c+PvbjqYo6PDF8MMHOu2h8QX9I8+OTDO/MMKypjDZBKl
        zog9058+kwzvgmbOjkXKqVN98+dQcTKldyJpNst8/qjY0eAxbooP2YrxzBj7HsCUcESb2P
        KjaF5WcAS+MjGDn/rFfVwidsZIwGCzCit1GHQkZYc6R0SJhaWhyBDZTwgBOljA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1696675475; a=rsa-sha256;
        cv=none;
        b=CcGyKkmUzIp1dfRHF+sVZjZly1/UZ/cDJfWm4AjSxUDvnsSt0NwJ6PNFOknJjmAIbLRyaM
        d2NVWEhwQ6aK3U1I4laRv/NLzpocwo49wrLuQRfqJ0ycXC/DFIbW4bFghSd4/JuodOf0yT
        Yc5nDsM3XdQ9MFMkHgIyPo2iSVqpxKVEhccXeyw9t3xRwe7WpE9yGh1rbRY4gIZu7acqUj
        D536l/K5VK5qfgWKvB0juGKKTCUYi9YmP6EPWAHpVvN/4CNckcI9EUwKOfA/+rTWZmtKwp
        tdfBfe6uVVpTpJxBaj47639O07t57ZnnXB7RK00/Nzvk/ZwXtW/qqUZn6Ly+Dw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1696675475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=nU/uYiTBYGsGFzZi+XpqncNjH4ICSyCuLZYYHVXYlRM=;
        b=o5N15sTmH9sQ+k50YrVvIz0edEN7DZStgjSzlyIYAkMFEtDAq03B9YPPpBNQEBh+E/C9HL
        Jo2gtaP4DqjME9sxxcYQnK8adBH5mbYdN1uJAiqNVV6E2cUSS6arLMiftRd0TqxUPde2no
        bryQhfpQ+VWyh2fNSDH2CvUYTizRK4mK1fz9ST/NduJSgudcPWc262pd1nMDR6dWHEazBF
        cCObdIGlRh1hUv0ibrCzwu0aZwF+RPw/Rq/bGiFnPQSOSrXCl0zb/T+SquNB+btSi9y/od
        0Vy7jxZwst9RsxpLE03Fps+0Ekuguf2vE4vRRxCXbLCeHtFNZ3LfwBKr1s+OQg==
Message-ID: <f1b9fe3939dff426528760eca39d4ad4ab2340a3.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: Fix UAF for hci_chan
From:   Pauli Virtanen <pav@iki.fi>
To:     Ziyang Xuan <william.xuanziyang@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 07 Oct 2023 13:44:30 +0300
In-Reply-To: <20231007093521.2404844-1-william.xuanziyang@huawei.com>
References: <20231007093521.2404844-1-william.xuanziyang@huawei.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 (3.50.0-1.fc39) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

la, 2023-10-07 kello 17:35 +0800, Ziyang Xuan kirjoitti:
> Syzbot reports a UAF problem as follows:
>=20
> BUG: KASAN: slab-use-after-free in hci_send_acl+0x48/0xe70 net/bluetooth/=
hci_core.c:3231
> ...
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:364 [inline]
>  print_report+0x163/0x540 mm/kasan/report.c:475
>  kasan_report+0x175/0x1b0 mm/kasan/report.c:588
>  hci_send_acl+0x48/0xe70 net/bluetooth/hci_core.c:3231
>  l2cap_send_conn_req net/bluetooth/l2cap_core.c:1286 [inline]
>  l2cap_start_connection+0x465/0x620 net/bluetooth/l2cap_core.c:1514
>  l2cap_conn_start+0xbf3/0x1130 net/bluetooth/l2cap_core.c:1661
>  process_one_work kernel/workqueue.c:2630 [inline]
>  process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
>  worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
>  kthread+0x2d3/0x370 kernel/kthread.c:388
>  ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>  </TASK>

Note this looks like the same issue as in the following thread, where
there's a suggestion from maintainer:

https://lore.kernel.org/linux-bluetooth/fd9c0f0eddb8a7d73e9797568dc3cf2bc9b=
8ad62.1696077070.git.pav@iki.fi/T/#u


Is it the same issue?

>=20
> Allocated by task 27110:
>  kasan_save_stack mm/kasan/common.c:45 [inline]
>  kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
>  ____kasan_kmalloc mm/kasan/common.c:374 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
>  kmalloc include/linux/slab.h:599 [inline]
>  kzalloc include/linux/slab.h:720 [inline]
>  hci_chan_create+0xc8/0x300 net/bluetooth/hci_conn.c:2714
>  l2cap_conn_add+0x69/0xc10 net/bluetooth/l2cap_core.c:7841
>  l2cap_chan_connect+0x61f/0xeb0 net/bluetooth/l2cap_core.c:8053
>  bt_6lowpan_connect net/bluetooth/6lowpan.c:894 [inline]
>  lowpan_control_write+0x55e/0x850 net/bluetooth/6lowpan.c:1129
>  full_proxy_write+0x113/0x1c0 fs/debugfs/file.c:236
>  vfs_write+0x286/0xaf0 fs/read_write.c:582
>  ksys_write+0x1a0/0x2c0 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> Freed by task 5067:
>  kasan_save_stack mm/kasan/common.c:45 [inline]
>  kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
>  kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
>  ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
>  kasan_slab_free include/linux/kasan.h:164 [inline]
>  slab_free_hook mm/slub.c:1800 [inline]
>  slab_free_freelist_hook mm/slub.c:1826 [inline]
>  slab_free mm/slub.c:3809 [inline]
>  __kmem_cache_free+0x25f/0x3b0 mm/slub.c:3822
>  hci_chan_list_flush net/bluetooth/hci_conn.c:2754 [inline]
>  hci_conn_cleanup net/bluetooth/hci_conn.c:152 [inline]
>  hci_conn_del+0x4f8/0xc40 net/bluetooth/hci_conn.c:1156
>  hci_abort_conn_sync+0xa45/0xfe0
>  hci_cmd_sync_work+0x228/0x400 net/bluetooth/hci_sync.c:306
>  process_one_work kernel/workqueue.c:2630 [inline]
>  process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
>  worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
>  kthread+0x2d3/0x370 kernel/kthread.c:388
>  ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>=20
> There are two main reasons for this:
> 1. In the case of hci_conn_add() concurrency, the handle of
> hci_conn allocated through hci_conn_hash_alloc_unset() is not unique.
> 2. The processes related to hci_abort_conn() and hci_connect_xxx()
> can be concurrent, but the two processes lack synchronization.
>=20
> To fix this, use ida to manage the allocation of conn->handle, and
> add the HCI_CONN_DISC flag to achieve synchronization between
> hci_abort_conn() and hci_connect_xxx() related processes.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> ---
>  include/net/bluetooth/hci_core.h | 17 ++++++++++----
>  net/bluetooth/hci_conn.c         | 39 ++++++++++++++++----------------
>  net/bluetooth/hci_core.c         |  3 +++
>  3 files changed, 35 insertions(+), 24 deletions(-)
>=20
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index e6359f7346f1..72818fc49ccd 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -350,6 +350,8 @@ struct hci_dev {
>  	struct list_head list;
>  	struct mutex	lock;
> =20
> +	struct ida	unset_handle_ida;
> +
>  	char		name[8];
>  	unsigned long	flags;
>  	__u16		id;
> @@ -969,6 +971,7 @@ enum {
>  	HCI_CONN_AUTH_INITIATOR,
>  	HCI_CONN_DROP,
>  	HCI_CONN_CANCEL,
> +	HCI_CONN_DISC,
>  	HCI_CONN_PARAM_REMOVAL_PEND,
>  	HCI_CONN_NEW_LINK_KEY,
>  	HCI_CONN_SCANNING,
> @@ -1174,7 +1177,8 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_ba(struct hci_dev *hdev,
>  	rcu_read_lock();
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {
> -		if (c->type =3D=3D type && !bacmp(&c->dst, ba)) {
> +		if (c->type =3D=3D type && !bacmp(&c->dst, ba) &&
> +		    !test_bit(HCI_CONN_DISC, &c->flags)) {
>  			rcu_read_unlock();
>  			return c;
>  		}
> @@ -1195,8 +1199,9 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_le(struct hci_dev *hdev,
>  	rcu_read_lock();
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {
> -		if (c->type !=3D LE_LINK)
> -		       continue;
> +		if (c->type !=3D LE_LINK ||
> +		    test_bit(HCI_CONN_DISC, &c->flags))
> +			continue;
> =20
>  		if (ba_type =3D=3D c->dst_type && !bacmp(&c->dst, ba)) {
>  			rcu_read_unlock();
> @@ -1386,7 +1391,8 @@ static inline struct hci_conn *hci_lookup_le_connec=
t(struct hci_dev *hdev)
> =20
>  	list_for_each_entry_rcu(c, &h->list, list) {
>  		if (c->type =3D=3D LE_LINK && c->state =3D=3D BT_CONNECT &&
> -		    !test_bit(HCI_CONN_SCANNING, &c->flags)) {
> +		    !test_bit(HCI_CONN_SCANNING, &c->flags) &&
> +		    !test_bit(HCI_CONN_DISC, &c->flags)) {
>  			rcu_read_unlock();
>  			return c;
>  		}
> @@ -1520,7 +1526,8 @@ static inline void hci_conn_drop(struct hci_conn *c=
onn)
>  {
>  	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
> =20
> -	if (atomic_dec_and_test(&conn->refcnt)) {
> +	if (atomic_dec_and_test(&conn->refcnt) &&
> +	    !test_bit(HCI_CONN_DISC, &conn->flags)) {
>  		unsigned long timeo;
> =20
>  		switch (conn->type) {
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 9d5057cef30a..6045d32e28d3 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -153,6 +153,9 @@ static void hci_conn_cleanup(struct hci_conn *conn)
> =20
>  	hci_conn_hash_del(hdev, conn);
> =20
> +	if (HCI_CONN_HANDLE_UNSET(conn->handle))
> +		ida_free(&hdev->unset_handle_ida, conn->handle);
> +
>  	if (conn->cleanup)
>  		conn->cleanup(conn);
> =20
> @@ -928,29 +931,17 @@ static void cis_cleanup(struct hci_conn *conn)
>  	hci_le_remove_cig(hdev, conn->iso_qos.ucast.cig);
>  }
> =20
> -static u16 hci_conn_hash_alloc_unset(struct hci_dev *hdev)
> +static int hci_conn_hash_alloc_unset(struct hci_dev *hdev)
>  {
> -	struct hci_conn_hash *h =3D &hdev->conn_hash;
> -	struct hci_conn  *c;
> -	u16 handle =3D HCI_CONN_HANDLE_MAX + 1;
> -
> -	rcu_read_lock();
> -
> -	list_for_each_entry_rcu(c, &h->list, list) {
> -		/* Find the first unused handle */
> -		if (handle =3D=3D 0xffff || c->handle !=3D handle)
> -			break;
> -		handle++;
> -	}
> -	rcu_read_unlock();
> -
> -	return handle;
> +	return ida_alloc_range(&hdev->unset_handle_ida, HCI_CONN_HANDLE_MAX + 1=
,
> +			       U16_MAX, GFP_ATOMIC);
>  }
> =20
>  struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *=
dst,
>  			      u8 role)
>  {
>  	struct hci_conn *conn;
> +	int handle;
> =20
>  	BT_DBG("%s dst %pMR", hdev->name, dst);
> =20
> @@ -960,7 +951,12 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, =
int type, bdaddr_t *dst,
> =20
>  	bacpy(&conn->dst, dst);
>  	bacpy(&conn->src, &hdev->bdaddr);
> -	conn->handle =3D hci_conn_hash_alloc_unset(hdev);
> +	handle =3D hci_conn_hash_alloc_unset(hdev);
> +	if (unlikely(handle < 0)) {
> +		kfree(conn);
> +		return NULL;
> +	}
> +	conn->handle =3D handle;
>  	conn->hdev  =3D hdev;
>  	conn->type  =3D type;
>  	conn->role  =3D role;
> @@ -2897,6 +2893,7 @@ static int abort_conn_sync(struct hci_dev *hdev, vo=
id *data)
>  int hci_abort_conn(struct hci_conn *conn, u8 reason)
>  {
>  	struct hci_dev *hdev =3D conn->hdev;
> +	int ret;
> =20
>  	/* If abort_reason has already been set it means the connection is
>  	 * already being aborted so don't attempt to overwrite it.
> @@ -2925,6 +2922,10 @@ int hci_abort_conn(struct hci_conn *conn, u8 reaso=
n)
>  		}
>  	}
> =20
> -	return hci_cmd_sync_queue(hdev, abort_conn_sync, UINT_PTR(conn->handle)=
,
> -				  NULL);
> +	ret =3D hci_cmd_sync_queue(hdev, abort_conn_sync,
> +				 UINT_PTR(conn->handle), NULL);
> +	if (!ret)
> +		set_bit(HCI_CONN_DISC, &conn->flags);
> +
> +	return ret;
>  }
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index a5992f1b3c9b..67b652c18a44 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2535,6 +2535,8 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
>  	mutex_init(&hdev->lock);
>  	mutex_init(&hdev->req_lock);
> =20
> +	ida_init(&hdev->unset_handle_ida);
> +
>  	INIT_LIST_HEAD(&hdev->mesh_pending);
>  	INIT_LIST_HEAD(&hdev->mgmt_pending);
>  	INIT_LIST_HEAD(&hdev->reject_list);
> @@ -2786,6 +2788,7 @@ void hci_release_dev(struct hci_dev *hdev)
>  	hci_blocked_keys_clear(hdev);
>  	hci_dev_unlock(hdev);
> =20
> +	ida_destroy(&hdev->unset_handle_ida);
>  	ida_simple_remove(&hci_index_ida, hdev->id);
>  	kfree_skb(hdev->sent_cmd);
>  	kfree_skb(hdev->recv_event);

--=20
Pauli Virtanen
