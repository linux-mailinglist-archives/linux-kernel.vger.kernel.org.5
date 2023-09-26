Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C9A7AEE1A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbjIZNnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjIZNnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:43:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE933F3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:43:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32333fb6beeso1802381f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695735822; x=1696340622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptamfMpXoJ3CODle1KvFafVhoHAycVMWOruc5QELg+E=;
        b=gFiLzWvgNJVmF699Cqrqu4+R2LyjPqbMaVQK71IZzRhA9854OzKw8FWriPbCA9+3vO
         TarL1CLrD40m57jQTX6e/RfvM6lz9fmFOdcAF17Eny5ebKgRpXXkc70dBGroWQZLvFMI
         cl1mZrrM6pQ28VKoy6qf92BAmSUhUeBM5inzsfXi0NgqhNGutAqkC3qhTwy+yKp49Ows
         tPaIFQPEbBcpMRN7unIsY8pb4bjZwAwhM7IAQyaAbA65mBPf2C0hq7ij3nMpKlIP77fg
         a2LJTbE9DD0HgA7tcrb+6R2vnfzvjl+SQZLopnrItRI5hUvPRxFmVasvuoIKqqrloi37
         eDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695735822; x=1696340622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptamfMpXoJ3CODle1KvFafVhoHAycVMWOruc5QELg+E=;
        b=s5AFdI4WSRH7iwyDRLgXb7p1l5VEyGDRLpKqX5KecByew4X7mdmEyFr9J0r1EwUtd+
         OHRKBfnKh/zQlQQuJAj7O6jwyZRQY0EkmYTioHVblblnxJegK6+9JI0GndJF7LtFqCaS
         bvXFqhqwMxYVsKEnBH3qyogEkOcgk7Zc/a7XFbj11tT1Oiut/FZrMbceFjAtbNtvvuCh
         W8LFIqbRQgXmhhfgOkVnpBKvY1AuDp8YR/fGEEs3ggh6pr9vWd+1rtSAT1mDJg3DrThE
         asWlij31v8qp7EHRm6xEl5sMA9CnFaX4i5s5nW7G0wGEO8zKg85+5TTQtET7PPx16TXC
         5DSA==
X-Gm-Message-State: AOJu0YxEXteohTvPDXU+tJiyGIOGb2lXw+865rpPNDkUaUOhj2raUaXP
        GgzhTZV9WU5AHI1HloUqo6U5d2L62EcUXVILFpQ=
X-Google-Smtp-Source: AGHT+IGQUe3IdNmMk57bmfL8PJu8M+EYO3SZyr5D1RurisMB/DzXyNogPvyzvVGvHPFXaPY+8ZIKlA==
X-Received: by 2002:adf:ed0d:0:b0:315:9676:c360 with SMTP id a13-20020adfed0d000000b003159676c360mr8793528wro.25.1695735822316;
        Tue, 26 Sep 2023 06:43:42 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f49a600529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f49:a600:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d474d000000b003217cbab88bsm14644490wrs.16.2023.09.26.06.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 06:43:41 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     alx@kernel.org, linux-man@vger.kernel.org, brauner@kernel.org,
        axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org,
        Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2] man2/splice.2: document SPLICE_F_NOWAIT
Date:   Tue, 26 Sep 2023 15:43:39 +0200
Message-Id: <20230926134339.2919289-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <hq2223k3kdclg2i2ozwtw37yvtwnxwrw3ns4op4fkh76x3fz47@2frhfofkwzay>
References: <hq2223k3kdclg2i2ozwtw37yvtwnxwrw3ns4op4fkh76x3fz47@2frhfofkwzay>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch for SPLICE_F_NOWAIT submitted to LKML:
 https://lore.kernel.org/lkml/20230926063609.2451260-1-max.kellermann@ionos.com/

In the HISTORY section, I declared Linux 6.7 as the first version to
have this feature, but this is only speculation, because
SPLICE_F_NOWAIT is still under discussion and has not yet been merged.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 man2/splice.2 | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/man2/splice.2 b/man2/splice.2
index e9a18e668..a07c001ac 100644
--- a/man2/splice.2
+++ b/man2/splice.2
@@ -89,13 +89,26 @@ call);
 in the future, a correct implementation may be restored.
 .TP
 .B SPLICE_F_NONBLOCK
-Do not block on I/O.
+Do not block on I/O on pipes.
 This makes the splice pipe operations nonblocking, but
 .BR splice ()
 may nevertheless block because the file descriptors that
 are spliced to/from may block (unless they have the
 .B O_NONBLOCK
-flag set).
+flag set or
+.B SPLICE_F_NOWAIT
+is specified).
+.TP
+.B SPLICE_F_NOWAIT
+If no data is immediately available on
+.I fd_in
+and it is not a pipe, do not wait (e.g. for backing storage or locks),
+but return immediately with
+.B EAGAIN.
+This is analogous to the
+.B RWF_NOWAIT
+flag of
+.BR preadv2 ().
 .TP
 .B SPLICE_F_MORE
 More data will be coming in a subsequent splice.
@@ -138,6 +151,8 @@ is set to indicate the error.
 .TP
 .B EAGAIN
 .B SPLICE_F_NONBLOCK
+or
+.B SPLICE_F_NOWAIT
 was specified in
 .I flags
 or one of the file descriptors had been marked as nonblocking
@@ -192,6 +207,9 @@ was required to be a pipe.
 Since Linux 2.6.31,
 .\" commit 7c77f0b3f9208c339a4b40737bb2cb0f0319bb8d
 both arguments may refer to pipes.
+.PP
+.B SPLICE_F_NOWAIT
+was added in Linux 6.7.
 .SH NOTES
 The three system calls
 .BR splice (),
-- 
2.39.2

