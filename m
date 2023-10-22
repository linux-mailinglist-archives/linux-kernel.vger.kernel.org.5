Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC6B7D2761
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 02:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJVX4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 19:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVX4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 19:56:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB495E0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 16:56:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9becde9ea7bso804911866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 16:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698018976; x=1698623776; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PI2oECHJcjMzUpUxGetGCqTdGdKEr4rm8alchZsFbyM=;
        b=DaK/A4IMOeouulyFT4DyenvOgK5eRIfMOa+KmRxqquK1gGiANC8FA5Ac381EmYJ/TQ
         gYgrHKpMeApGpIuRvtr6Iz5YNlgGADNsp139wdz4TDgCHZN2RBPyxVrRiRPcLXe85WAf
         NB6CVcrt/BkE+FGv5cLxF67SWLJH8h6jLnTO07iAaJLYcsCqpb1iNexd5zMjiG8fG6sA
         qzornRT7nfbhHqmFblCVXdRccUeIPgFtHp779N/VbGA23fEdOt/CwqwOfxYVMUn991wy
         3B79GeMCiTtlGpiPdmKfYgnwWM4EilR3SEymBaop6NbIifW2Sbm60FNw7ha9PS4NgBEv
         LHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698018976; x=1698623776;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PI2oECHJcjMzUpUxGetGCqTdGdKEr4rm8alchZsFbyM=;
        b=ps+wTthr85C4StTcm5zmEqP/OTdbecKoFLP/bbtygANqC02+UYXasnIALFRtuQUnEy
         76gy98SxcJF7dVS6I7hjivkJrKuhXlHQEZelkpRuNFpqZQSBoUxtke64CtTq4cedVvyE
         ciGBz0do4ItBDic37oMWS7LmhStnc7KxTowBpnmO7yyBamkZDbXzqSmsIcyojXAPnjMm
         Op86Xkf3YivunTnCD6bT7RzHtXudm3x+n4kDMxq86tGTRYpoiUjpJZwxhxKJjx2VrXyL
         +ncscuRowN5QvhEYZtenSKxsW+RAGibb8tjsnenSuSuackpEP3Yc738BsS4HCDeiQgnr
         sAKA==
X-Gm-Message-State: AOJu0Yxo4z330tZFquuDIi638KU760HzH3Mf62JCwHhSx5p/gWUkpb0v
        y3o+t1lEnFfMgHdlZvaI7X8/X1IlfVUY33I1wbINpuLWD38=
X-Google-Smtp-Source: AGHT+IHRyoc+8AMNQs53ofRtyMVyBqmzsCZeAOpiaaATeYPoMOs77jAadTsw2gmiuul5WT5xn80gmkwQfKiAVnznyu0=
X-Received: by 2002:a17:907:1ca4:b0:9aa:206d:b052 with SMTP id
 nb36-20020a1709071ca400b009aa206db052mr7975889ejc.27.1698018976067; Sun, 22
 Oct 2023 16:56:16 -0700 (PDT)
MIME-Version: 1.0
From:   gmssixty gmssixty <gmssixty@gmail.com>
Date:   Mon, 23 Oct 2023 05:56:06 +0600
Message-ID: <CAOx-CDUwV0d0+2UdZW+vdUcjwAg2+Hanf1-iNSYFRWOW2yQugg@mail.gmail.com>
Subject: How can I add "busybox sh" as init during boot of the custom kernel?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How can I add "busybox sh" as init during boot of the custom kernel? I
have compiled the kernel and put the bzImage in /dev/sda3 (/mnt/sda3).
Booted that kernel. After booting, I got a message to set the init
process. I have put the busybox in /bin. Now I want to add this
"busybox sh" as an init process. How can I do this?

Note that, I did not install any other software in that /dev/sda3
(/mnt/sda3). I have only bzImage and busybox.
