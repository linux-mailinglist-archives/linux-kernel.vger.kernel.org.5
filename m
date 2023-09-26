Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AEB7AE662
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjIZHET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjIZHEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:04:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51903FF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:04:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so969670966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695711846; x=1696316646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=09Dbusezuzmtem8SHw0UyQKQ5oAulzPz0jwJbZlkunI=;
        b=YFUvFE/mH3/+vBDA0Ft/PlefIUy7eWIGkUHkrxa5TdonuHq5xJG5raPHiPKLmVtm7O
         GWDvvTYgqte28Sz16dteKtvoqKU4DiUzTLIN1RGu5FD2iXYMkm2c6b1g0b8d/bLTdt7A
         XhdYyS8+E8XrJw4P+1ELSx23JsWemQPb7zym10/oVl/54UUhDZzxaF0YcU3Rf0pJyRA7
         hfsRGvGAkw5zq4LZrdYPYuInOeCoBlwIoMn1H1kOiMZ9AmnTluHzzEGM4MiTx6UAEip3
         7qNsSgqplpJFo3uPwSs6+NLI8JAcEGOFIqgqeTgx2oS5S19/A3bUt56K3VJ57i1VRIw9
         Y4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695711847; x=1696316647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09Dbusezuzmtem8SHw0UyQKQ5oAulzPz0jwJbZlkunI=;
        b=Xvua08d+aW8VqFPLX354otjozBAImoRm/tunrwA1CUxDjCOWyaEXA2eUFpYAL8WnLU
         X6NRqGPAoA2lChUlgMIKD5E3hdpksDQuFfVgMoO9v6pK2k1QzA/8aIaFd78lZlC4oZhJ
         b5tTTKxq03FDwYhwyh30tFxIQweNHUiaKqNLbUaffpSih8kdH/H+zhTRrn4h7PLxyN5h
         3sHw7iY2qM93kJKOK8ciDwzzojI+ouECR7Nr97A9tFrP2VDdaci2I45KF2wmauUzBBYV
         sIEdZujPw8IH5VJ1ujhH5k7EuOMhNovR9XQd/Gn8FS9iWHsVIBluFsYOm6oHZPMGBvql
         dLAg==
X-Gm-Message-State: AOJu0YxgOvBzagggtVVPFGX+B0Lp/MEtJKM+Km1T6658iNCH8rgOkStc
        9UePrcs4WZDM4Mxbar3qcOo2kA==
X-Google-Smtp-Source: AGHT+IFkDpIma3t+/zuXOt8GN+pMsASgXkfBA+WDQYHttvUk1ozw24xulRvXJIA0TTUhcKtepHK5vQ==
X-Received: by 2002:a17:907:1dd7:b0:9a1:f5b1:c864 with SMTP id og23-20020a1709071dd700b009a1f5b1c864mr7364977ejc.10.1695711846644;
        Tue, 26 Sep 2023 00:04:06 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f49a600529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f49:a600:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id q9-20020a170906540900b009930042510csm7387982ejo.222.2023.09.26.00.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 00:04:06 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     alx@kernel.org, linux-man@vger.kernel.org, brauner@kernel.org,
        axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org,
        Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] man2/splice.2: document SPLICE_F_NOWAIT
Date:   Tue, 26 Sep 2023 09:04:02 +0200
Message-Id: <20230926070402.2452760-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
 man2/splice.2 | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/man2/splice.2 b/man2/splice.2
index e9a18e668..1e686b858 100644
--- a/man2/splice.2
+++ b/man2/splice.2
@@ -89,13 +89,27 @@ call);
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
+.BR preadv2()
+.
 .TP
 .B SPLICE_F_MORE
 More data will be coming in a subsequent splice.
@@ -138,6 +152,8 @@ is set to indicate the error.
 .TP
 .B EAGAIN
 .B SPLICE_F_NONBLOCK
+or
+.B SPLICE_F_NOWAIT
 was specified in
 .I flags
 or one of the file descriptors had been marked as nonblocking
@@ -192,6 +208,9 @@ was required to be a pipe.
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

