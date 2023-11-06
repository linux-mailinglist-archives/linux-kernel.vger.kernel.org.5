Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2CA7E1D19
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjKFJR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjKFJR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:17:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B771FA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 01:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699262228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5e6mOiJPde7i1hVZv69YfOb7z/h87xjiUMR0oLDOiv4=;
        b=At+YZv7tawrHRWgDNxgltVCQZyGfhLgrKW33IBCazhwdaLnIIwk2K+DCcRrjzhVPuKhyUN
        TO9NmzuajT18yRIt2aY94VpcJjS1OlVvYOhyQhpLRL4PNh+kBKH1hECVW7UkcrvQSSaTsU
        65pwQJQLXQ5Ez2WOhCdWfbhaZip6GHI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-P67FVGIvNBSN5uwcn3t72g-1; Mon, 06 Nov 2023 04:17:01 -0500
X-MC-Unique: P67FVGIvNBSN5uwcn3t72g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c167384046so58520766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 01:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699262220; x=1699867020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5e6mOiJPde7i1hVZv69YfOb7z/h87xjiUMR0oLDOiv4=;
        b=xJhBK2eKrqgNwTerNQuycOQlNtNcMJ2FtGm7cL/i9NXFEy5mUOCK1G0cLON7nArqoZ
         n6up/hOtmIFfu1yg3cKdBK/QkogFETKEeLVliCLBZKtTnZMoWSb6wpOsQ4nVnZjLr7gv
         n+SvU2V1wecNuskyb1gXBT5yg3bP34I8yvWJ+CdDiPQIFVixP5VEwfrihzHdIgJcDSth
         Qv+UEI+I6bjzgxFUiObblyKP9YTDap5XX555AEWCxcRZEqXVkNgWBY0ImTYMJ0rzHuyz
         gQLNuxBzltVG3rjYjT8zuom3Le3DObTfk/SUufWXb+E2Ysmi/0piVQAcr1mGzQPEMTrR
         sW8g==
X-Gm-Message-State: AOJu0YysB+SMyAWVjj2OR95JMkOxvXJhZ21jpnzlbjM7CNWCSc62/+UF
        U/KI/ihfGs1K2gd7ha/CyIgquHB9jRm2BYXc9f5TDDNpVGuxnrNcPaFQN0HlPluhuxjNMJWLZxl
        2xfN9A3tXBEjvwSBqHZXCvWye
X-Received: by 2002:a17:907:9811:b0:9dd:b624:dea9 with SMTP id ji17-20020a170907981100b009ddb624dea9mr5908954ejc.7.1699262220635;
        Mon, 06 Nov 2023 01:17:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg+Dca1Hqr/M7XD/LNddS3HhgudK6ckTsPr4vuaCXPSKcGEUtvPE7ntVOMTBjItD9G/Xyblw==
X-Received: by 2002:a17:907:9811:b0:9dd:b624:dea9 with SMTP id ji17-20020a170907981100b009ddb624dea9mr5908931ejc.7.1699262220297;
        Mon, 06 Nov 2023 01:17:00 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2a01:599:91a:4014:af36:ab77:ffe6:b2fd])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709067fd300b009930042510csm3902969ejs.222.2023.11.06.01.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 01:16:59 -0800 (PST)
From:   Philipp Stanner <pstanner@redhat.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH v2] drivers/net/ppp: use standard array-copy-function
Date:   Mon,  6 Nov 2023 10:16:00 +0100
Message-ID: <20231106091559.14419-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ppp_generic.c, memdup_user() is utilized to copy a userspace array.
This is done without an overflow-check, which is, however, not critical
because the multiplicands are an unsigned short and struct sock_filter,
which is currently of size 8.

Regardless, string.h now provides memdup_array_user(), a wrapper for
copying userspace arrays in a standardized manner, which has the
advantage of making it more obvious to the reader that an array is being
copied.
The wrapper additionally performs an obligatory overflow check, saving
the reader the effort of analyzing the potential for overflow, and
making the code a bit more robust in case of future changes to the
multiplicands len * size.

Replace memdup_user() with memdup_array_user().

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Changes in v2:
- Rename the commit and rephrase its message completely so that it
  becomes a) obvious that we're not fixing an actual overflow here and
  b) emphasize that the goal is increasing readability. (Al Viro)
---
 drivers/net/ppp/ppp_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index a9beacd552cf..0193af2d31c9 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -570,8 +570,8 @@ static struct bpf_prog *get_filter(struct sock_fprog *uprog)
 
 	/* uprog->len is unsigned short, so no overflow here */
 	fprog.len = uprog->len;
-	fprog.filter = memdup_user(uprog->filter,
-				   uprog->len * sizeof(struct sock_filter));
+	fprog.filter = memdup_array_user(uprog->filter,
+					 uprog->len, sizeof(struct sock_filter));
 	if (IS_ERR(fprog.filter))
 		return ERR_CAST(fprog.filter);
 
-- 
2.41.0

