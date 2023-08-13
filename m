Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE8777A51F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjHMGgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHMGgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:36:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1300170C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:36:12 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3176ff39a28so679873f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691908571; x=1692513371;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iAp8IH/ejNOzSqs7fVJ3DvtPd2O55r93cKi0HL+ps9o=;
        b=LBXul+/6h1uDHtU24UKkxdZOzdP7tNKYOlBG2lAGBDML7nKi/w79XvTBqoF0LleNr6
         kvddoaGcULzSdic29hryuFP6w8fC8FmlSreldHXE3I8nzcvvI58QqvGSMoGVvShfoCH6
         uKGRndRXtBZEICDLmF98wKkJty2o4qAkYEstcl1VxdtCuN4n8QYopx/zTH0xyIIZd2ii
         JfylbLx1WQLSBifJmBoAIX/6e396arwzVJGSYX8TV8QYNJO+yH1rXheAqO2nL8vWRFin
         sYCjVv+NsixJEkaH5BnouOmHtKj2Fzq84eau7CsbpCX9g0b8YJBttybK/7YiuzPP94sM
         c9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691908571; x=1692513371;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAp8IH/ejNOzSqs7fVJ3DvtPd2O55r93cKi0HL+ps9o=;
        b=GKfWEatO0yDLuUlonE3bChDMa4uYE4oQC8JrO3kJ0MtVmQfnEdL9h2qPZKAv/qvaqW
         ttf6XKc4+ONEd8V/l27HsdFkS0S8UmfcvzxFcSb42MWKaLMclKGL2ylCna7UhP2yJhSr
         gqsZLeVDhp60wQADf3xnSZm4Rn0pSfjpshlGhNSMu9Vy5XR0aNIEFBt+0gbhMYqilD5t
         y9wuY6FnWUKvrEKQU2Mj4+OP7r9POySEeV4JUupNDiYwdei2sM07g9ehBpo+cbsYqsYI
         BeuIm52HR4/KqI6RIQOlYbqHSzqvnrDow7YHey20Wy+rLPrNJJTl9BMkkoyjSgxsDMdX
         wawg==
X-Gm-Message-State: AOJu0YyU14JR3Z0tf5a7jK1XLMueCq4RdFQqWPc2ycn9aDScWOGj/MDx
        EEqHS/ZC+8cLjs4ydt/y/dksYWb7YYM=
X-Google-Smtp-Source: AGHT+IEKRkyFsND5DhjhmOR5+JiawzMz5YzCdog02G1y44akb+5STuKUAug+FuL4ydqF7f37Z9FpLA==
X-Received: by 2002:a05:600c:1c07:b0:3f7:fb5d:6e7a with SMTP id j7-20020a05600c1c0700b003f7fb5d6e7amr6300717wms.0.1691908571182;
        Sat, 12 Aug 2023 23:36:11 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c234b00b003fbca942499sm13229328wmq.14.2023.08.12.23.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 23:36:10 -0700 (PDT)
Date:   Sun, 13 Aug 2023 08:36:08 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Remove unsupported mode IW_MODE_MASTER
Message-ID: <cover.1691908402.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unsupported modes IW_MODE_MASTER, IW_MODE_REPEAT, IW_MODE_MESH.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (4):
  staging: rtl8192e: Remove unsupported mode IW_MODE_MASTER
  staging: rtl8192e: Remove unused function rtllib_start_master_bss()
  staging: rtl8192e: Remove unsupported mode IW_MODE_REPEAT
  staging: rtl8192e: Remove unsupported mode IW_MODE_MESH

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |   4 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |   6 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     |   3 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c     |  14 +-
 drivers/staging/rtl8192e/rtllib.h             |   4 -
 drivers/staging/rtl8192e/rtllib_rx.c          |  26 +--
 drivers/staging/rtl8192e/rtllib_softmac.c     | 189 ------------------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |   9 +-
 drivers/staging/rtl8192e/rtllib_tx.c          |   2 -
 9 files changed, 16 insertions(+), 241 deletions(-)

-- 
2.41.0

