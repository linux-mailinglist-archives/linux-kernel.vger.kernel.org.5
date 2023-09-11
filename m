Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DED79BF85
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348612AbjIKV27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243995AbjIKSih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:38:37 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B551AE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:38:30 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C74C28012D3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:38:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 67E73801781
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:38:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694457509; a=rsa-sha256;
        cv=none;
        b=4TIIx1Ez29INsXqeciyF9Ejoyjavpd4SvHtGvkhY9PgYO17/4K4ytVxo+CFNRkq1XJfsFo
        7hXmXHpO/qebO5BPb/hR9JuWh+y7Rg5ztEAzyjaD6D3ybi0Wv//G6qqesoc+g3ybAZwJ/a
        /nDwp7n4H8Wz8FllxTFPNewEmQ4AdleakeVJfe+ua7Vq/Sudl0Nbrym/sAWzbL8KevmMwj
        xwJE+yDTjNaYyHOsnOI0hXZmBNK3m697oVyHHBrUQoIL3CJm9sk4WRtph2wswIP433wa4I
        8uDJMxs0O4KbxX47NGUuGsomJ7/Tf+pRhxsVJZYiz9e9Zp4jAflP7uasHfl6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694457509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=53P3Hk+EW6NocQPblV/gTXjphG8d+YKYu2WHxZdb0Js=;
        b=V4weqR9QXj8vh8oWuRDgNbembLIGi00/BZPZWKjD1rXRfZwyYVxBsy0j698d873GCbAlxq
        HACUH9MAvZCS4JE8zxOmg1ZO2J5H3euWzT9ULtoBKxADxYKLbfCb0bF0IdWubfFyABnjge
        RMqbCp8KaGSyoJh3yJwG+AeZ6q4lbiiulqoVWWnzujvYdszx76kCfUiYNTJv+awNsmbsqY
        DOJWdLNdNurzTKqX+NCY0FXpBvKWtuZie2e5rBk0kkMmVLd7Ddvx4TBKtAZ7o7e6pSiA8T
        UHVbnd7YtdIwrB9AgdnbJ7I1c6CnwSwbEU9LYOs0CZfbpbVB1/e7+oct8d/fvg==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-gwzkf;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Arithmetic-Hook: 78fd8e335512fa0a_1694457509629_903672411
X-MC-Loop-Signature: 1694457509629:2644104686
X-MC-Ingress-Time: 1694457509628
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.111.86.32 (trex/6.9.1);
        Mon, 11 Sep 2023 18:38:29 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4RkwTK1QRfzWK
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1694457509;
        bh=53P3Hk+EW6NocQPblV/gTXjphG8d+YKYu2WHxZdb0Js=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=cgHJ6kv+MXae9CB0IGRLSn1oc7T743WZ3+y0U6bt9o6XyaXhYS9O7B2ArJWdquKDO
         qTs45UMwn/4e7gMAPqsfW/P8ogq3A9/c7lAhmdFK/h1Zgngrwt5xoXgRrdFdoJ5GyT
         DThBdXluU++y6BIV6xAmTHoJ/PfNjrda38xmp632wALeeHaKZUhzKWeCHnl7ra+9rj
         gGr3awJmpbFuvK5EY/eDJiJjwtzHBWdTQLP2jaBigKu4sdUj2pc4TWQmXQmWqYN0E4
         q/gYxzMaPse384T2lvur7Pb+ZfWquUY/Tx179TdhNPsHq3T0LKj46quQgpwJ3hf28v
         XQ61+c0MPQq/Q==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00c8
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 11 Sep 2023 11:38:27 -0700
Date:   Mon, 11 Sep 2023 11:38:27 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
Subject: [PATCH 0/2] virtiofs submounts forgotten after client / guest memory
 pressure
Message-ID: <cover.1693440240.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I recently ran into a situation where a virtiofs client began
encountering EBADF after the client / guest system had an OOM.  After
reproducing the issue and debugging, it appears that the problem is
caused by a virtiofsd submount being forgotten once the dentry
referencing that submount is killed by the shrinker.  In this particular
case, the submount had been bind mounted into a container's mount
namespace.  The reference count on the original dentry was 0, making it
eligible for eviction.  However, because this dentry was also the last
reference the client knew it had, it sent a forget message to the
server.  This caused all future references to the FUSE node-id from
virtiofsd perspective to become invalid.  Subsequent attempts to used
the node-id received an EBADF from the server.

This pair of patches modifies the virtiofs submount code to perform a
lookup on the nodeid that forms the root of the submount.  The patch
before this pulls the revalidate lookup code into a helper function that
can be used both in revalidate and submount superblock fill.

Tested via:

- fstests for virtiofs
- fstests for fuse (against passthrough_ll)
- manual testing to watch how refcounts change between client and server
  in response to filesytem access, umount, and eviction by the shrinker.

Changes since RFC:

- Modified fuse_fill_super_submount to always fail if dentry cannot be
  revalidated.  (Feedback from Bernd Schubert)
- Fixed up an edge case where looked up but subsequently declared
  invalid dentries were not correctly tracking nlookup.  (Error was
  introduced in my RFC).

Thanks,

-K

Krister Johansen (2):
  fuse: revalidate: move lookup into a separate function
  fuse: ensure that submounts lookup their root

 fs/fuse/dir.c    | 87 +++++++++++++++++++++++++++++++++---------------
 fs/fuse/fuse_i.h |  6 ++++
 fs/fuse/inode.c  | 43 ++++++++++++++++++++----
 3 files changed, 103 insertions(+), 33 deletions(-)

-- 
2.25.1

