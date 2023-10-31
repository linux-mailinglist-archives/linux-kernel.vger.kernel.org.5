Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1487DCFB6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344521AbjJaOuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344509AbjJaOuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A45E4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698763757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9aEtKXQ2ieWW0wRcFfdhj4dIV7XtnWe7cnMjHfz2sxY=;
        b=G+mRY7WIwpS/BJ975bO7TyZnjjywT8u6iB3o5340m3/bGRWtslemhpisbsiFc8bADGR5jp
        gyQhGGYVn8C2dZBuigJJ2IMgBye/PTwqWYmBfVGUnob2LKpnExioqC6u8ExjV/OJY6w8sN
        i0yUqNQz+McBwnAa1GG4BUkOT0s8ByQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-aMrs5NGmPMaexpf5n0Fi8A-1; Tue, 31 Oct 2023 10:49:04 -0400
X-MC-Unique: aMrs5NGmPMaexpf5n0Fi8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E633830966;
        Tue, 31 Oct 2023 14:49:02 +0000 (UTC)
Received: from redhat.com (unknown [10.22.17.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D4EA510F4C;
        Tue, 31 Oct 2023 14:49:01 +0000 (UTC)
Date:   Tue, 31 Oct 2023 09:49:00 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL] dlm updates for 6.7
Message-ID: <ZUET3DN7wTih6rKm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.7

This set of patches has some minor fixes for message handling, some misc
cleanups, and updates the maintainers entry.

Thanks,
Dave


Alexander Aring (5):
      dlm: fix creating multiple node structures
      dlm: fix remove member after close call
      dlm: be sure we reset all nodes at forced shutdown
      dlm: fix no ack after final message
      dlm: slow down filling up processing queue

Christophe JAILLET (3):
      fs: dlm: Simplify buffer size computation in dlm_create_debug_file()
      fs: dlm: Fix the size of a buffer in dlm_create_debug_file()
      fs: dlm: Remove some useless memset()

David Teigland (1):
      MAINTAINERS: Update dlm maintainer and web page


 MAINTAINERS       |  4 ++--
 fs/dlm/debug_fs.c | 18 +++++++-----------
 fs/dlm/lowcomms.c | 12 ++++++++++++
 fs/dlm/midcomms.c | 39 ++++++++++++++++++++++++++++++++-------
 4 files changed, 53 insertions(+), 20 deletions(-)

