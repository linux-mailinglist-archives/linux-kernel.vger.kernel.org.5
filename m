Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D4B80CA71
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343572AbjLKNE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343502AbjLKNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:04:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2599083
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702299873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VzAC67twAFkoZWVKcw3UCDQq4Io2ZB3JxaBjcTMtrtA=;
        b=bWzVx34CFtVbopOpL5KFY8/9PtNKBXZuBv/9CrB21chxGqXf+rEQg1CRVzNSY4hDo3Dd5e
        UDb+Ee/KC84F0m34Bkg6EgPKXsiCHqrS5CCgZk5eBQOEJvuHvrbs2GWyX+SFO7gghgUA0B
        5N6+Sza8KAN6ZGufDuMZk7yEM3tjWLw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-N5kNjH8EO7eFxpFD1v3Bcw-1; Mon,
 11 Dec 2023 08:04:30 -0500
X-MC-Unique: N5kNjH8EO7eFxpFD1v3Bcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BF243811F2E;
        Mon, 11 Dec 2023 13:04:30 +0000 (UTC)
Received: from metal.redhat.com (unknown [10.45.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E612C1C060B1;
        Mon, 11 Dec 2023 13:04:28 +0000 (UTC)
From:   Daniel Vacek <neelx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Vacek <neelx@redhat.com>
Subject: [PATCH 0/2] IB/ipoib fixes
Date:   Mon, 11 Dec 2023 14:04:23 +0100
Message-ID: <20231211130426.1500427-1-neelx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch (hopefully) fixes a real issue while the second is an
unrelated cleanup. But it shares a context so sending as a series.

Daniel Vacek (2):
  IB/ipoib: Fix mcast list locking
  IB/ipoib: Clean up redundant netif_addr_lock

 drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.43.0

