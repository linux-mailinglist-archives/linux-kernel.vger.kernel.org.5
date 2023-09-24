Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4197ACBB3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjIXTuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjIXTuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:50:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEAAFB
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:50:47 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-404800222d2so12729845e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695585046; x=1696189846; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=STaVRB4lc8G7tgw1+DUtsUKKTjDKDxKdvDBHRRxCOFc=;
        b=Eou0wTehhLZ32KAExs3AyNOHLnF6eYBdnZy4Z/2bjb/fif0WrtZywS3Zs7aP8VA1To
         KcjsRFXcZkxjg9tgfpxV+gSwHXVfc/CuEPOogHP2Saoj6RzDBHx/eGC9Z9CiBpudYYb0
         Q0gCIauDAaHbRDUzPIqU+bESi0wCTilM3DAl8BQKcvGXvBI/4NHom2eiIiCYdHbKfFNn
         IuMmL+q1Z+wU9WI+HVnmhgR0UZ48091vgctGGX54IHCQIuDGi2NobEXTbkWJ1ZuKn/xb
         AT/fJY4aJ5kqyWzwUVlM/9KVHPyo2DL4edjHRFeaTU8HJBAnlkW4MPTxtPIy3v+Nyp6n
         UYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695585046; x=1696189846;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STaVRB4lc8G7tgw1+DUtsUKKTjDKDxKdvDBHRRxCOFc=;
        b=RNvG/hML4D529tl/56m3nnMM1yqOkTRfeQsZZFofwy+3eXDdUxlRgQGxfZuKJQVpnN
         UlC0RMGy+KACkH5xkHiEaVO0W09d+6hrdtXRyDMBlx6JLgU3z1igA8Ye2n/f1KjVv/hk
         OELTPFNefD9TkeSv3MEQSYiiQIJbmaoi2GLx9PzWsyK/Xo4Um72n5576v+/OXDH+/Xuu
         tafrb1SX233AE9VlJZOnoajyOzB0N47yP54g/fSmYSPGHmi6axe50mNvNMN7cp5fIJhN
         aISb+8CHo0yripcCiFVn8jPy6cBzwFyvV5mZITWdPBLIezDHCzl1q/cxOcrgx3Tsa48A
         kHvw==
X-Gm-Message-State: AOJu0Yw39f4SmMRmejZr65rkGjHgIahUG5/dtZjoMNeTNLBQVXaRdTDB
        RRHeOELTNdEIQWsDQIl32ZofZxROT2o=
X-Google-Smtp-Source: AGHT+IHRdmk85zhv60MYPeVIo9rWi4BpI30IilpE7ErS0jlbks2+ZQUTEAlWSagW+aW+xBtCseoZVQ==
X-Received: by 2002:a7b:c456:0:b0:3fe:d637:7b25 with SMTP id l22-20020a7bc456000000b003fed6377b25mr4755937wmi.0.1695585045408;
        Sun, 24 Sep 2023 12:50:45 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id hu23-20020a05600ca29700b003fef5e76f2csm2926177wmb.0.2023.09.24.12.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:50:45 -0700 (PDT)
Date:   Sun, 24 Sep 2023 21:50:43 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] staging: rtl8192e: Resolve circular locking with wx_mutex
Message-ID: <cover.1695582999.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve circular locking with wx_mutex, rx_pkt_pending_timer and
reorder_spinlock.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (4):
  staging: rtl8192e: Put kfree() to end of rtllib_softmac_free()
  staging: rtl8192e: Remove mutex from rtllib_softmac_free()
  staging: rtl8192e: Unlock mutex for one line in rtllib_stop_protocol()
  staging: rtl8192e: Resolve circular locking with rx_pkt_pending_timer

 drivers/staging/rtl8192e/rtllib_rx.c      | 4 ++++
 drivers/staging/rtl8192e/rtllib_softmac.c | 9 +++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.42.0

