Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8319B7877FC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243056AbjHXSeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243065AbjHXSdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8574D1BE3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692901979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MENyLQ2N3cu7YkwE8woYh2Uz3htsa5ND2UWg2HZ3684=;
        b=QDXGl6VPv7eBYfdwpI0fabcutcVI1/68GGUxOfThn0l4pwe0YRXiiwOLqCsgpUW6Q3H1Jq
        LospK8jSkiYOVo/Y4pNx/kXmbzsKGATFGWPU3QsGN2zmmOYYoqHyXn7pJn+di1NQJxCzpQ
        c1vbZ8JiDDs+9pSbdUZ5usmVhhENILs=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-kBRITvTbOFWYGPiRvbwFVA-1; Thu, 24 Aug 2023 14:32:58 -0400
X-MC-Unique: kBRITvTbOFWYGPiRvbwFVA-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-79a1499c25aso50994241.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901977; x=1693506777;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MENyLQ2N3cu7YkwE8woYh2Uz3htsa5ND2UWg2HZ3684=;
        b=PuO8YBmke1Y5F+9S2w/Z1VLZMQl3AyL0xTts4iYToIGhOmCK1+lJWAeYLpegPdAgC4
         7jJ+6ByMkz4hPgFuu8NEhMtXW7QjHB83YIa/RDBQl+23BGrmZ5I7Ffm15qjJuwjvz/J0
         FL3kNQLoMbVKkmUzV/BuRkgcdyRZzxF3RiaWy6abIsy5oS3IE0XIPOccTxHn1iG6evwN
         ipeKN3B6t403msbcvCbhbOYX+XGfVNYPkbych9MVhfwDcAKFtj4i+MTIV8m56TlRnspF
         6eewFAm7RcP9sQejNGXBbxb9NleLe7Hv0SH+OqYuN7f4bIz8z6GKotweAZBUI0e9C/Km
         rpgA==
X-Gm-Message-State: AOJu0YyKKw8GF0ixu0yDYtsujN6ichgJQk+plYqRnPJcl6NICeXMjwNI
        /zO582kNM7doxuGP+rDoL4IUNRzcb9wgmSi66hgxyu3sfKNtJnimbIocSfT4wo/nHCCyw+CyXU3
        RcFgRq2w1b4jsjLxltGPiNqcm
X-Received: by 2002:a67:e403:0:b0:44e:8874:585a with SMTP id d3-20020a67e403000000b0044e8874585amr4528615vsf.27.1692901977579;
        Thu, 24 Aug 2023 11:32:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgMO96NWiKDcYXf5IRr9AXBP8x7ijYPK4xRhHHkKJy0v9wR6V9lgxekYM8Ssryo0WjBBvQqQ==
X-Received: by 2002:a67:e403:0:b0:44e:8874:585a with SMTP id d3-20020a67e403000000b0044e8874585amr4528610vsf.27.1692901977351;
        Thu, 24 Aug 2023 11:32:57 -0700 (PDT)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id j17-20020a0ceb11000000b0064f77d37798sm4209qvp.5.2023.08.24.11.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:32:56 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next 0/7] net: stmmac: Improve default addend/subsecond
 increment readability
Date:   Thu, 24 Aug 2023 13:32:51 -0500
Message-Id: <20230824-stmmac-subsecond-inc-cleanup-v1-0-e0b9f7c18b37@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFOi52QC/x3MwQ6CMAwA0F8hPdtkbororxgPoyvaRApZByEh/
 LuLx3d5OxhnYYNHs0PmVUwmrTifGqBP1DejpGrwzgfX+QtaGcdIaEtvTJMmFCWkL0ddZgzuGu4
 3ail2CWoxZx5k+/dPUC6ovBV4HccPlXRkO3gAAAA=
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to improve the readability of the calculations
for the default addend and subsecond increment values.

I recently had to understand what the hardware did by reading this code,
and it took me longer than I care to admit. These patches aim to make it
more self explanatory.

Suggestions to further improve this are very welcomed.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
Andrew Halaney (7):
      net: stmmac: Use consistent variable name for subsecond increment
      net: stmmac: Use NSEC_PER_SEC for hwtstamp calculations
      net: stmmac: Precede entire addend calculation with its comment
      net: stmmac: Remove a pointless cast
      net: stmmac: Correct addend typo
      net: stmmac: Fix comment about default addend calculation
      net: stmmac: Make PTP reference clock references more clear

 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  5 +++--
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  | 14 +++++++-------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 22 ++++++++++++----------
 3 files changed, 22 insertions(+), 19 deletions(-)
---
base-commit: 9f6708a668186dc5b38532fc1d1ff2f5311722d6
change-id: 20230824-stmmac-subsecond-inc-cleanup-305397c6ca8d

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>

