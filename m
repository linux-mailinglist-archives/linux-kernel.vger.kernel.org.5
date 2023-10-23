Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3910E7D2A91
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjJWGjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJWGjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:39:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85F9D5B
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:39:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53142351997so642728a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698043168; x=1698647968; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NLNqrKtJDrK51kIqp/XQ0Y2ua1a9pB6M3Ch5oQgDH+Q=;
        b=CxL6NiRfcx23xvcm8rXxR6DZELy7iCo5s98YVfkSeInBEpE2mjwOWA+2VnbLVZspN3
         e+w3we1vcw9tefLOfskB4I3gOJO5bJqy4kQ+DOKK5MbHZIo4mhFLKkW4jiyuqXovk96d
         Y76Rk/ada2rc+/nLyaz9Ab37ZPxrVcw9D4YLGlqcI4IzjUSGeQKc/DQnyS3HkcmfGE90
         a30zdx9oubOi0+zsg29IRrFKIVmknAF4ySDNwIN27tv+Z3N5PG8yyWlivQgomEOTkYpz
         z9UCiicVjf8yHMWIInXvc6GCzLKpW4xNG7+8QJ7oh4lGjuq0IhLsYioJNgYnQeVIQTzD
         aB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698043168; x=1698647968;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLNqrKtJDrK51kIqp/XQ0Y2ua1a9pB6M3Ch5oQgDH+Q=;
        b=wJ9ILoBlcT1wYuGy0hzCDn27Q9LrYmUe4OJgkMk92NuyCxiej3HqDksELMB/3RpU2p
         bJLL+9+FGNnsBGIJl1Ab90XrvEKHz4DvYJvuzsxGeKaPL0NTFHLz5v51FVGlFl2QkfdX
         u8E9J5qpS5/DXfXAdrkr2M+TN60yHvX8dbasqgJJrybMR79i5EiYGQvnvb7j3z1sjImY
         vZdCqYKBZIpEBHr0dv4MZNxzY7grg+DEZRfH16hUUH/XgH33yMRmk46HBtbq/bodVe94
         VjsX940FdWPAT7Sz5+8krEB06TStn21NQ1uywZGlqudzDrGpx5HNuZQ5M1JcS7k34jjM
         YQGw==
X-Gm-Message-State: AOJu0YyQhNJfYccl1T8rn8grg9ULwO03pdAyrkrKcj/sgvIscg77HW6t
        pdC3jRwiSuugOXaGTNoWb2E=
X-Google-Smtp-Source: AGHT+IEhSRMVcivh84QSeua9eaIxD4t3Gfc9MyrHlWyIZYTE2K/8jDV+okC86mlqmyn9e6Bp1xtxMA==
X-Received: by 2002:a17:906:8e:b0:9be:8de2:a56c with SMTP id 14-20020a170906008e00b009be8de2a56cmr5909448ejc.0.1698043168017;
        Sun, 22 Oct 2023 23:39:28 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id hv6-20020a17090760c600b00992f2befcbcsm6135452ejc.180.2023.10.22.23.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 23:39:27 -0700 (PDT)
Date:   Mon, 23 Oct 2023 08:39:25 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] staging: rtl8192e: Remove unused variable ucReserved
 and further
Message-ID: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
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

Replace custom macros with standard kernel macros.
Remove unused variables.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (11):
  staging: rtl8192e: Replace BIT0 to BIT9 with BIT(0) to BIT(9)
  staging: rtl8192e: Replace BIT10 to BIT31 with BIT(10) to BIT(31)
  staging: rtl8192e: Remove unused variables ucReserved and friends
  staging: rtl8192e: Remove written but unevaluated variable ucUP
  staging: rtl8192e: Remove unused variables from union tspec_body
  staging: rtl8192e: Replace union tspec_body including embedded struct
  staging: rtl8192e: Replace union qos_tsinfo with embedded struct
  staging: rtl8192e: Remove unused struct acm
  staging: rtl8192e: Remove last three parameters of MakeTSEntry()
  staging: rtl8192e: Remove unused union qos_tclas
  staging: rtl8192e: Remove unused variables TClasProc and TClasNum

 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h | 104 +++++++-------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |   4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c   |   8 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  22 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c   |   2 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c     |   2 +-
 drivers/staging/rtl8192e/rtl819x_Qos.h        | 129 +-----------------
 drivers/staging/rtl8192e/rtl819x_TS.h         |   5 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c     |  42 ++----
 drivers/staging/rtl8192e/rtllib.h             |  12 +-
 10 files changed, 92 insertions(+), 238 deletions(-)

-- 
2.42.0

