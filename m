Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BAC803523
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344343AbjLDNjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbjLDNia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:38:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A78F2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701697096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=5akfcmS88aMdBOZU2tgTkzn2BZ024jWxw0fAikE98gA=;
        b=NAhqF3rSQxViqG/sgn8Azj7TYmpomYxuDUci/2dJoUfpXZVkqad8Gn17EUpqcBLaaIZZIE
        XFoHw4qWWwpWBUx1wDC6VHQRPRlipYiPR0XnKYfP2254UEi7Eb9Hx31xrd7ADxi4invbP0
        /h9rtSYzGIjOgM7vir13HjwkwM48kxc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-nJJjqLBBP9WF90mppeZhTg-1; Mon, 04 Dec 2023 08:38:15 -0500
X-MC-Unique: nJJjqLBBP9WF90mppeZhTg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-423e480037cso63059411cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:38:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701697094; x=1702301894;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5akfcmS88aMdBOZU2tgTkzn2BZ024jWxw0fAikE98gA=;
        b=WOA+Po8xgplS4BHJ807G01lUZC97NkAfBDcBzVj8+6BpxoZWoXAkSxYaJdZbGCdOe3
         qGTRhaJa86a2cqE0vUVWiWOJqmv83lA0+L3xAOEtjG1mn0QF83tiDHZydnhtPoEBlWdl
         hpOkwUtrGbfm92gNbNDbqN493Wykmz/bortUey0I8L+gJ0XtCsq+vNfTqvyfTB9fr9FB
         9v0VXVgY+vqL/4FpgTH423QJGCUH8sJxGs2z2wTBbHuPqxa7nYtrr9SebFgko95fj72R
         Kv/m+sWkHtBw1yvIMHbRe4kqaiCZHMOF8dteB4HltYXu/ncgxlXGuXTesNrA2VLl9vZM
         dUew==
X-Gm-Message-State: AOJu0YxorqEuBGeZLi1Qa4rE9mS+qUDJUR9y5Wc6T4SmJbLMoAWUieg0
        PEVlGHBttw1ft/dUQ6TzKdL7Ak71NPRI8Usl6MycBooQoyjJlLvK4JejNx9z6MZVt12mOKnpv+A
        ZMl/z2hEHn/jqHRTeawEr4RhT
X-Received: by 2002:a05:622a:282:b0:425:4043:18d0 with SMTP id z2-20020a05622a028200b00425404318d0mr5350675qtw.131.1701697094709;
        Mon, 04 Dec 2023 05:38:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+uydVke1bj6K3+VpqcvkS7K82S/AfCUqWL9s3clAKf0dXgfm1gbib9FuloJn1VamCnIS2mQ==
X-Received: by 2002:a05:622a:282:b0:425:4043:18d0 with SMTP id z2-20020a05622a028200b00425404318d0mr5350660qtw.131.1701697094341;
        Mon, 04 Dec 2023 05:38:14 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8488e000000b004199c98f87dsm4284873qtq.74.2023.12.04.05.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:38:13 -0800 (PST)
Date:   Mon, 4 Dec 2023 08:38:08 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eperezma@redhat.com, jasowang@redhat.com, lkp@intel.com,
        mst@redhat.com, shannon.nelson@amd.com, steven.sistare@oracle.com
Subject: [GIT PULL] vdpa: bugfixes
Message-ID: <20231204083808-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's one other fix in my tree but it was only posted very
recently so I am giving it a week in linux next, just in case.

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to cefc9ba6aed48a3aa085888e3262ac2aa975714b:

  pds_vdpa: set features order (2023-12-01 09:55:01 -0500)

----------------------------------------------------------------
vdpa: bugfixes

fixes in mlx5 and pds drivers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Shannon Nelson (3):
      pds_vdpa: fix up format-truncation complaint
      pds_vdpa: clear config callback when status goes to 0
      pds_vdpa: set features order

Steve Sistare (1):
      vdpa/mlx5: preserve CVQ vringh index

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
 drivers/vdpa/pds/debugfs.c        | 2 +-
 drivers/vdpa/pds/vdpa_dev.c       | 7 ++++---
 3 files changed, 11 insertions(+), 5 deletions(-)

