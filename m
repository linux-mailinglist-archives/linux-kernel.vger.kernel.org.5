Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0641C782849
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjHULyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjHULye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:54:34 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A3490;
        Mon, 21 Aug 2023 04:54:33 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so30521935e9.3;
        Mon, 21 Aug 2023 04:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692618871; x=1693223671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nTmYoF1t+3plBMW1bgaBI03oKo/Iqm0jpBxTcEGCCOk=;
        b=UdxgDPxeHBBQysreFJpiraArCUkp8dfsfhjo4BNCUGh9kWXe8xjvv+97x/vBXzepZw
         zOLZZYFuqUyH1Lykmj6Gvqh3CQgJzkfe/BLYD8yUTYFJ114+45s4fWYliUjJvqsKTLOY
         D/kMj8S9UZE91mt5ZAcVzjhDx9QB0qZs8inVYxQxBThA4koD0zeOTUoOixHSsnNtSMMt
         +wHMJa5OoWPUBL6u+YpCATnATvFCRd2IEZvNChr03uaaA8jK+4ZblOr6g74emQ1wUgJK
         AC3kaTjHSqXb5c1/IOUYO0nHsZ/ny46zC7BVOL1fZJIODHe63QWlvtsngKSMyHWCBJON
         IlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692618871; x=1693223671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nTmYoF1t+3plBMW1bgaBI03oKo/Iqm0jpBxTcEGCCOk=;
        b=XpkIJCIvG+y7j/rroa+QUj/mUugMVSBFiSc6Z3o95ZoN+VDoxd9EoRvgROKJiBczRv
         ttCdcLqg9a5LIjhyzq9zr6zM8BFmsG/b9uPBpN3WeI26wfv1piseGvoT9cZYr1VLx9gL
         KeRXc6vEPupvmazXD5ybt5FSDn4r3mkYg/bABEfIRSiAGACwcZGkiFOo63VDMJ+QSpkp
         7IotCFina36O88aIpe8jUOctQEb+ESVp9e8OANUsjMBJ2V8IWqDJX2LbFbY9kxs8knS/
         yNmmIHV/V24Yhy/2b5f3LQMjsU+ScOFcns7EjM0P623qWI7R7yWHNmhGHL9o2R5htm4B
         gDOw==
X-Gm-Message-State: AOJu0Yw+LBcm5oWSEI8RVy1bsEPQn1mSQnEwlI4d8DkhYIJAhGfE/jza
        ZO1ltEP6MxLVetDu3euK6Qw=
X-Google-Smtp-Source: AGHT+IFcFho8CUTMR4MnxNFiaiFlDf5aR8cmXfhmlrv0pzjZFWQ+q8wJsYvXioWDcEt2SI8Xsc636g==
X-Received: by 2002:a05:600c:acd:b0:3fd:2dcc:bc19 with SMTP id c13-20020a05600c0acd00b003fd2dccbc19mr4862905wmr.15.1692618871386;
        Mon, 21 Aug 2023 04:54:31 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f1e5c0018f3132f38fbfb3b.dip0.t-ipconnect.de. [2003:cf:9f1e:5c00:18f3:132f:38fb:fb3b])
        by smtp.googlemail.com with ESMTPSA id w3-20020a05600c014300b003fe0a0e03fcsm15954649wmm.12.2023.08.21.04.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 04:54:30 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Carns <mike@carns.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] Fix race condition for X670E Hero
Date:   Mon, 21 Aug 2023 13:52:34 +0200
Message-ID: <20230821115418.25733-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - Add a link to a GitHub inssue to the commit message.

Eugene Shalygin (1):
  hwmon: (asus-ec-sensosrs) fix mutex path for X670E Hero

 drivers/hwmon/asus-ec-sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.41.0

