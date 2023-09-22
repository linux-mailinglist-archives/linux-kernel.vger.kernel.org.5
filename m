Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D167AA929
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjIVGhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjIVGg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:36:58 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF696102
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 23:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=HhO8TKiNJtk1/3
        a+rETzjE3Fb4drMDY1ljoHwVsb8Ow=; b=gmyjBT+GeJslS7nibaysT2IR7G7rLJ
        CMk7ztcylHfoQpQK0gdq2sB4rHQF+y54sU5NIYaJc7KkpBC4lhfayWajqzg7w6T3
        7cQH1zMvAntTubviaEOUzfImjx7VFmaw3ZvLjmBwlGIXOxDJK81SpQwrVD53LYMP
        LacH/dPI7PGyHLLr5/ZhtR4mIXRx9n3lpkkuQT0Z8gRxOnnKzy+Pexrfb22b9846
        wtKdwxxYPKQby2OofNan6yiFUaD5LdN2MxKZap1GyNaoQVQZNqJW2JB8LS7mFAEX
        zdEEBnaTwH909CqXxfieANSF6RmoE76Z1A1BisvAzP9hQZagEDOeVDBg==
Received: (qmail 1276355 invoked from network); 22 Sep 2023 08:36:49 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Sep 2023 08:36:49 +0200
X-UD-Smtp-Session: l3s3148p1@XXJN1ewFYLoujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 0/2] serial: core: updates to uapi header
Date:   Fri, 22 Sep 2023 08:36:40 +0200
Message-Id: <20230922063642.4120-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to remove port 18 but that was rightfully a no-go. Add a comment
explaining the case. And remove boilerplate in the header while we are
here.


Wolfram Sang (2):
  serial: core: remove cruft from uapi header
  serial: core: add comment about definitely used port types

 include/uapi/linux/serial_core.h | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

-- 
2.35.1

