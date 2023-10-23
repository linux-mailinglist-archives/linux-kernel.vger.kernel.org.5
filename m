Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7E17D2913
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjJWD3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjJWD3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:29:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA148F;
        Sun, 22 Oct 2023 20:29:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27d153c7f00so1659472a91.3;
        Sun, 22 Oct 2023 20:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698031776; x=1698636576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qF7roFPOxx1o1j3QRDtTUJvVgKUHfl93L5KvFsQDK48=;
        b=AgtlDUiuZMxK1swmpTQ9BIhHa26AEg61S41CmbywjozmRs3CToSaoDpU0GtuwPtIbC
         OLSm6T+v0/0/jOla7JBFUs1xGjYqpA/QOf65qgfJOnBL2iBHOCf+QhLn5drc1K+O2UJ6
         sTRYzgB5M6dpz/MOrVaC1Z7L09VSDjbeyWP/sPtdox66TJJmfgzAHlNqhyq2IZ6yKHl2
         /7v+680D+rOisqXjROnjmqrsE4M6/awad17RJjgsw+wO6ubGgsgP9yn0SZJAPY9o2PrT
         v4wbw2CNhmddRc9/TL8dEnETRri3g8l7S8oxTB8scRWp/f27Ghx4YOiQMODhJlPb0ewx
         w2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698031776; x=1698636576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qF7roFPOxx1o1j3QRDtTUJvVgKUHfl93L5KvFsQDK48=;
        b=TXe8d7hX5ZYiGxvn5DsVqul8SD0KyKmC6ThC5XXXNOYc0AiRi1dnJiJPUBjja6aXDb
         77+gk9fu24hqRNrOkvjkJHWv4LrOKtjnGfubupmHGdx58HYtN+dURz4AAH0sOcv9dUlC
         +1la/uf99tSyVopqh0fAgSEHOY50KD86j8TEq9uWwx/ftY7IPi68OZZV/mq/f4ZyJ1jj
         ApNKxDVG0eNwbhcl1PjKv8YrPyZCCVyAbk5r1jQ29mUyn1F9mu2o7rPPEPI8eiH5d6Fy
         bXgYKSQWpwm9RfjuicpINrDsXwET0ttc3E48dTAvG1/oY9Gr1Y/ADF5l+x8wLy2OeSl1
         zZCw==
X-Gm-Message-State: AOJu0Yx69KjQ+VxbhPqc5k5j0mChLwiDw/dtIL2Cly/tPjGLqkRLXVMW
        GwwJk5OgXpc9naFz3YktSqM=
X-Google-Smtp-Source: AGHT+IFUJ24+wEjXeo0kSFrJTp/x/cXWg1YBiN1ByClF6TYR0fAlOToOSYy5+j/oU47xaHLe8SlyJQ==
X-Received: by 2002:a17:902:ec84:b0:1c7:443d:7419 with SMTP id x4-20020a170902ec8400b001c7443d7419mr6872551plg.29.1698031776208;
        Sun, 22 Oct 2023 20:29:36 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902d38d00b001bb9d6b1baasm5068591pld.198.2023.10.22.20.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 20:29:35 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id DA9C683A133F; Mon, 23 Oct 2023 10:29:32 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net v2 0/2] MAINTAINERS: WWAN subsystem changes
Date:   Mon, 23 Oct 2023 10:29:03 +0700
Message-ID: <20231023032905.22515-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=820; i=bagasdotme@gmail.com; h=from:subject; bh=WCwpSgcp3u6uzIpN+ngTJhNBmMfq5UpV9diesKnHaZ4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKmmL8R+fOSJ3tz0kaGz53TalS0+Gc2t0qn/dTlrH2hU5 Zrn6et0lLIwiHExyIopskxK5Gs6vctI5EL7WkeYOaxMIEMYuDgFYCLVOYwMXXl7r0613sUy9YRd 7/1X8dIbXqvc/M3sa3jwedNUxufmpQz/gwQFkk9Xvnilxpt38cGLRxdld+R/m3jGuviz9ZJlz9+ 94QUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have to make this little MAINTAINERS patch series when I was dealing
with a regression involving Intel WWAN IOSM driver [1]. The culprit
author was (AFAIK) MIA as well as its subsystem mailing list down.
So here is the series.

Changes since v1 [2]:
  * Alphabetically by surname sort CREDITS entry

[1]: https://lore.kernel.org/lkml/267abf02-4b60-4a2e-92cd-709e3da6f7d3@gmail.com/
[2]: https://lore.kernel.org/lkml/20231013014010.18338-1-bagasdotme@gmail.com/

Bagas Sanjaya (2):
  MAINTAINERS: Move M Chetan Kumar to CREDITS
  MAINTAINERS: Remove linuxwwan@intel.com mailing list

 CREDITS     | 5 +++++
 MAINTAINERS | 7 +------
 2 files changed, 6 insertions(+), 6 deletions(-)


base-commit: d2a0fc372aca561556e765d0a9ec365c7c12f0ad
-- 
An old man doll... just what I always wanted! - Clara

