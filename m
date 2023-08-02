Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4995576D23A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjHBPiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbjHBPif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:38:35 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1853C17
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:37:38 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3492971f72fso3353905ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690990657; x=1691595457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ey4T8kFa+FDYqxdQyt4kTV5guA6O9qMRkUQvSfBdvnU=;
        b=scbJSQTezF0PLRQD32ApUMyETQzyN5oDfDn6wduJrC5MWwjFXFDdb8JxcjVAZ4285P
         nHGrRf0fNS848mu6uFsy7HNNJdM4SxcNe2QwmyjdM1NuIl2wRySJZaBuaICRlKYKaZ/Y
         vQPOI6EBFy5WHw9qI3QnY1tElJkr9VyBr+SSZ/3gR5K2RrYSlS6V17axVcfbRBGLxcrb
         eQOgy6fER3joLzV2OG5UsHbD3Rw9UzCIaG7qRUBoFBXULF/fZxrv1dNPmFNSDmvLc7LA
         Xa49bajqMKzyACssGja838hI+rafGvh3cSuzpNadMufzDfAI8zQCreUcTwf/qSvizBHp
         C0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690990657; x=1691595457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ey4T8kFa+FDYqxdQyt4kTV5guA6O9qMRkUQvSfBdvnU=;
        b=XPtzW4RkRRvnE0W6MnRMcuxN+PTd4NQ6vkKand+0UDkIZ+Ierxknl68+Hs5H/mC5EJ
         9hqZN1K60sydNvhT/sahsh9QqpQrBWSF+fdXBg0XPubzYoiUwbarXmap52oqjvuzqQek
         UUdEnrmvuOBmnNunmdI9RAhaZ7/lEGnIiNfAvWAlcPoeqZ/4ekg+S3I/yf8JPfd67xgQ
         Ii5hhaXYY7+GLq6DbzSDdTI7wPE7kk65lOVr3Zw34XxxZHEr0IsTcW85ImBwHhPAM+G4
         TeE7cVMv1M+jz4RpUq65TEZBRJdiGp1zIBGrJmzj+5Jbh2RmUeR55reANinRT6XEZCoj
         iOhA==
X-Gm-Message-State: ABy/qLbthSYkIRxB+NMvLxFhiu8Ydsytuh4jUi+/zyZ7m6iv8DZAWqCG
        kIDb9U1oeJVQlvAs8VCadGDzq+qP3ysxDg==
X-Google-Smtp-Source: APBJJlGybPiHzcToMRUp9pVlse7+nYD/HbFRhyaRl4ETV452m4UVD6ftwqOPoNs9HR3KOGIoa6bWdQ==
X-Received: by 2002:a05:6602:4012:b0:790:c991:8467 with SMTP id bk18-20020a056602401200b00790c9918467mr4902816iob.0.1690990656988;
        Wed, 02 Aug 2023 08:37:36 -0700 (PDT)
Received: from localhost.localdomain ([173.23.87.62])
        by smtp.gmail.com with ESMTPSA id g8-20020a6b7608000000b00786f50d6bf5sm4556830iom.19.2023.08.02.08.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:37:36 -0700 (PDT)
From:   Matthew Anderson <ruinairas1992@gmail.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Matthew Anderson <ruinairas1992@gmail.com>
Subject: [PATCH 0/2] ALSA: hda/realtek: Add headphone quirks for Aya devices
Date:   Wed,  2 Aug 2023 10:37:28 -0500
Message-ID: <20230802153730.39273-1-ruinairas1992@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series gets the headphones working properly on the
Aya Neo Geek/2 devices. You must apply the Geek patch before
the Aya 2.

Matthew Anderson (2):
  ALSA: hda/realtek: Add headphone quirk for Aya Neo Geek
  ALSA: hda/realtek: Add headphone quirk for Aya Neo 2

 sound/pci/hda/patch_realtek.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.41.0

