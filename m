Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1543E7E872D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 02:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344851AbjKKBAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 20:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjKKBAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 20:00:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC3B4228
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699664386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=OZqX4L0C5rtW9Z94fro7EVGdbdgTVYlzFcMIjE/e3rI=;
        b=RxRiyu9z1rpfCl/pS8RN7TSYB9W9QnbFG6A7YizBZe0BaM+CSj+QImKWsK5OtOJX0WSxgu
        fTVzpB+e7f3YDBobKw5oHvln9vSw4HAyV2UEDGoT09dpa5FrTNkCfBppGGqneAVT8OT9ov
        Wj6W9ATjmJN3VNOzwQ9LcTiiqvK4dwo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-UJyp377lPqCAI_K--E2cUg-1; Fri,
 10 Nov 2023 19:59:45 -0500
X-MC-Unique: UJyp377lPqCAI_K--E2cUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D6F929ABA2C;
        Sat, 11 Nov 2023 00:59:44 +0000 (UTC)
Received: from localhost (unknown [10.22.9.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0B5E40C6EB9;
        Sat, 11 Nov 2023 00:59:43 +0000 (UTC)
Date:   Fri, 10 Nov 2023 21:59:42 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.199-rt97
Message-ID: <169966380957.83297.12867433063716152688@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.199-rt97 stable release.

This release is an update to the new stable 5.10.199 version and no
RT-specific changes were made, with the exception of a fix to a build
failure due to upstream changes affecting only the PREEMPT_RT code.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 7f300821d150a083008d6a73224acfc7e3283b04

Or to build 5.10.199-rt97 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.199.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.199-rt97.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

RT Changes since v5.10.197-rt96:
---

Luis Claudio R. Goncalves (3):
      net: replace raw_write_seqcount_t_begin by do_raw_write_seqcount_begin

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 72be68652bb84..eee11a1c93216 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -195,7 +195,7 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 		 * Variant of write_seqcount_t_begin() telling lockdep that a
 		 * trylock was attempted.
 		 */
-		raw_write_seqcount_t_begin(s);
+		do_raw_write_seqcount_begin(s);
 		seqcount_acquire(&s->dep_map, 0, 1, _RET_IP_);
 		return true;
 	}

