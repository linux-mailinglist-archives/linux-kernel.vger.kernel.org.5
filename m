Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF5B7D19C9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjJUAED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJUAEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:04:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C543ED6B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 17:03:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507c5249d55so1924478e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 17:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697846632; x=1698451432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AR8e7uCgcxmCZgrEGCaXPBiQuDpmbbSbir6TORqZhQU=;
        b=JdBDNLtcVrO7zLKcgfJ4cNkNPYiufGU+wPLDUQDdSKhuBKH0/VubiylB1iV86s/wah
         Qqb9XS1mZpOr94se+AdwuJLmo3thM2hoT9o6N1LSYi9ZPpNgD0NDux5SDgmIZvpO5jXU
         USvxPm8mhFbka1FDfyrOL12QgVBmgWMPgu5E64sW6I9ww9uy4PGPtKOvHRdFkd5vlkKc
         RBd+alMPP5CnRkKoJDp+sJyrWq3GMi/zdO7bDvuRrXOOPLY71Yj0nVaXr7e+YTB4ZMqe
         u2QpWHZuPzjEQmF/4IlOzT5NgdPG7Wcm3ycn9H6JtABKGIOqTmgzcMjLGjU9Aub4lcRW
         wekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697846632; x=1698451432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AR8e7uCgcxmCZgrEGCaXPBiQuDpmbbSbir6TORqZhQU=;
        b=xDp6ryZeHvc4o29HzM1ATwvKG0gdA4usYgz1Imluwec01TpsHeaJWvEGpyPVgQAU0m
         gCioF0YKxbdlS0ibjHE4Q6oRXnot7F0GT7kzGtBbw/n8maJmDOUzpEB8LqGEcF/NUD5l
         pGG4sTaEcx+GQNumwnM/3YjCbx82bKRgcQNsaj9QCsDmgS+J9CnuYB/Bqc7lGSuyQFPc
         1DSKOtGf5nEs7D3pua/JlokY2WCV6aEzC1MXWwTWOvAhuVa7OlHrjEatYXGQiQfBLz9N
         rzy2JGzwIT0gDkcCZdFaUdsX4eeRl9oBsKESFfTzQwxiJjNYCba8BCVCnK7oToNbZjzK
         rNPQ==
X-Gm-Message-State: AOJu0YyK4PKWUMmDiXBCct5iqvQMl/fybc5RDqxKq2zg8PDl57bpsjxL
        fru4/txfr/bD9tIUb563PtQ=
X-Google-Smtp-Source: AGHT+IHfYKCIs9ScRFBFFZICOKXVdA1RaCumuqBlz+KCJUAO72clcSBdTgb4/jK/+xv5Ku3VIYWrEQ==
X-Received: by 2002:a05:6512:70b:b0:507:a1b3:2d47 with SMTP id b11-20020a056512070b00b00507a1b32d47mr2080809lfs.17.1697846631742;
        Fri, 20 Oct 2023 17:03:51 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id n13-20020ac242cd000000b00507ce48e283sm595463lfl.206.2023.10.20.17.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 17:03:51 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 0/2] Fix instances where new typedefs were introduced
Date:   Sat, 21 Oct 2023 02:03:38 +0200
Message-Id: <20231021000340.56889-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

These patches cover (first patch) the declarations where the new typedefs
were introduced (they are removed), and then the cleanup of the inline
functions in the same file, and then the second patch cleans up the
ethernet.c file where they were also used

Jonathan Bergh (2):
  staging: octeon: Fix warnings due to introduction of new typedefs
  staging: octeon: Fix remaining istances affected by the removal of
                   typedefs

 drivers/staging/octeon/ethernet.c     |  6 ++--
 drivers/staging/octeon/octeon-stubs.h | 48 +++++++++++++--------------
 2 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.40.1

