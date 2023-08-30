Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1172778D218
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241716AbjH3C3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241712AbjH3C3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:29:24 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5946C83;
        Tue, 29 Aug 2023 19:29:22 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 5E74A3200985;
        Tue, 29 Aug 2023 22:29:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 29 Aug 2023 22:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1693362560; x=1693448960; bh=n+eYkmAdN1
        MV5ouSzZB5e6d6nE6x/n9nGF1JVwzQT88=; b=Nti7U0vbxoz+RWIaZPrpkAqC59
        SuBm+O9VjdS4qdq+wWzL/gl+rPX2JJ38D0FE2YzHEzxQ5XLDRgdtSQadY9RRlilx
        dCOf04cyZx96L4thyNAtYDwwikK1tbJJ+NkWKv6mvQnLQEjlUCkNgqV6h8xqcZTZ
        r4QcnQsbWmcVzFyB/hwxQPO2VwroBh9qUfs20iTzu/D4DxWCRWnQMBVUCgsg2/5q
        S2t86a4JaLjz7yOL5dLNrHWxHk6eRuqv7Mw2TQdW6nkmKZHI2n6yR7yyqydwgDbY
        d5hfFjGLNRQhCSu9x7UP2bTOEFBtARDlwDYmFWkCdd+Xu7bw6E2jwOkvuPqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693362560; x=1693448960; bh=n+eYkmAdN1MV5
        ouSzZB5e6d6nE6x/n9nGF1JVwzQT88=; b=k+9iWhmxhbJs+pVPMt1K9EnEcUw8h
        eOixJqPPQEop1oJV2pcmM2xi6XY/hMo3yjkFsLCD/ZhXsV8AMuvCbeYDIXvOprvp
        f47Mhx+seQMSRwgDTGlHECDdJvbDJqC26nFJ8C4LT5P3nh9UoyDGVz+Xfj3DHtay
        iQ2oCccq1F58oQtymq+/DsRiF8HE9ywkfKtmE0Y8Bx8vJvJ0FE8RUl3DNb0gBLi2
        +n2oxaWEbSURC5at2wJ8xC4VFwfkZKTKACyhldrieSkJeQ5FL5YhBnOPTqZ7/wBm
        lc2eOwssBZU8jXwx8VuItyoQCxwHpQfs9lcn6Wh4CScF0PKQFH+CTpuww==
X-ME-Sender: <xms:gKnuZOABS0Zh7WSweonoxwUye_mIaIIIClNH93bqiyEur2offtFecA>
    <xme:gKnuZIgoFZSWWJDAhBKLMXjzlsQTcOzgkIACCxo9zs2GlZ6qMS7u5zCQ2iRbu36JG
    aOILMKI_ZhxKe5XugQ>
X-ME-Received: <xmr:gKnuZBnKLFScNGcYBo__AMJRu9bIfJBwYUYn5IoSlKyTqOxkd2la5LoMH8Js>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefjedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:gKnuZMzuk1aVfI7EFnHx9RjHGxJIQmolMfVRXevlqt_ECtCUtvBytA>
    <xmx:gKnuZDS52w2tbNJgDam6lCUbKv0n_b7oN7MT5cF5C_1OOuQxOk-RCA>
    <xmx:gKnuZHYvyaMsCCqPKJy80oUZ3N7fuC75mQ0e4cDJLKPXHR3e_n5_Nw>
    <xmx:gKnuZNfNHx2Tpm7Obg8bhtxkZ717f4uIQ4kQANXllwSONI0PZcXhHA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Aug 2023 22:29:18 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/1] platform/x86: asus-wmi: corrections to egpu safety check
Date:   Wed, 30 Aug 2023 14:29:07 +1200
Message-ID: <20230830022908.36264-1-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
- v2
  - Apply on platform-drivers/for-next and reference correct commit
  - Fix an incorrectly name err/result

Luke D. Jones (1):
  platform/x86: asus-wmi: corrections to egpu safety check

 drivers/platform/x86/asus-wmi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

-- 
2.41.0

