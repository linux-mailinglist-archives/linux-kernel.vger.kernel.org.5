Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94CA7CB6CF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjJPXA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjJPXAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:00:54 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7963B4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:00:52 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-579de633419so62622287b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697497252; x=1698102052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f7PM/qoXzVs0Ox8v8Qh+A2b6z9ZGf3HGoTdxvDT9A8E=;
        b=c64lYtiu+BezLTUruAUQl7HeyiMZ5oGBhIelbdFqyAUWvVxhNNb4w0/jsYAJTh1tNm
         EcJCUH2OTczdkjP2zARGxDtH5qdFmeeNIw4CDXjWqM2RVeC8a8i5aO0wQkMzqEhxTB35
         jc0pWQK/3rdHOrju6l7U/bdyNx0z93f1e13o7dZmUx4QTfGgWjPv/KEleakxn+HNKseq
         B3fgYJz6d1ohCTIw8EPn+vyCUjnxw0KDtIipvLK2c+JAiJ+mkwSQ+95AAO5Llc9li47S
         WFeb5yaY3JFf492auHWkIic3q81Z6jLodcliIo7e8ineQQ0mere8jJNuzXWaN7oYf6bO
         c8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697497252; x=1698102052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7PM/qoXzVs0Ox8v8Qh+A2b6z9ZGf3HGoTdxvDT9A8E=;
        b=UBpSuYdZVwNWpQ6ai3FgxpRQpwEfwik/ZDJ/G8XruUXkC/X4gL0fGbZksnWh9hW1zE
         86cfOyBr/zkCRIVFZpq6+qby8mT/lk8EdPRa1XWR7t187Spkd/qJBxKcLc5D42RAZ+Lp
         DTR7wbnLmrQiwAiWiKmKn0jRrjegiw6OmtW07n7SQP+LTNSIyZcu+Xxx3JnfNVb5g9nH
         3Em/2F7JR5qVl/7UsWQyh6/jiAr4sabHJnv15fan4TWK3NGCrSRN2wswxga4QbmoL4WJ
         0L+RnI0pNn8e1qM/AWKDTuoD/9DRIuBh9gvlOaHoXVqLA87/sjmWlEgcYOUYavc/z1+6
         2NQg==
X-Gm-Message-State: AOJu0Ywv4RAqFbcrnfsDvdKkjiDnZyveTZ2581Ce1gvVr+aiB2ITFroL
        1r0IZeSscc3AWVcFrD/kheLEs4qgEwMNvpVCA7M=
X-Google-Smtp-Source: AGHT+IH+dQdqLPosZBc+wnM7MHs/JysF+hbCzToiOyXWRhMUnsAXYdSL3y5m2cOCqIcF35tG/BZ2CQ==
X-Received: by 2002:a0d:d40d:0:b0:5a7:bf2b:dc27 with SMTP id w13-20020a0dd40d000000b005a7bf2bdc27mr673624ywd.14.1697497251983;
        Mon, 16 Oct 2023 16:00:51 -0700 (PDT)
Received: from gilbert-PC ([105.112.31.148])
        by smtp.gmail.com with ESMTPSA id d77-20020a814f50000000b005a7ba08b2acsm103979ywb.0.2023.10.16.16.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 16:00:51 -0700 (PDT)
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Subject: [PATCH 0/4] Rename variable bUpdateBBVGA, byCurrentCh, byCurPwr and byBBPreEDRSSI
Date:   Mon, 16 Oct 2023 23:58:53 +0100
Message-Id: <cover.1697495597.git.gilbertadikankwu@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Make the variable names adhere to Linux kernel coding style and mute
checkpatch.pl errors.

Gilbert Adikankwu (4):
  staging: vt6655: Rename variable bUpdateBBVGA
  staging: vt6655: Rename variable byCurrentCh
  staging: vt6655: Rename variable byCurPwr
  staging: vt6655: Rename variable byBBPreEDRSSI

 drivers/staging/vt6655/baseband.c    |  2 +-
 drivers/staging/vt6655/channel.c     | 18 +++++++++---------
 drivers/staging/vt6655/device.h      |  8 ++++----
 drivers/staging/vt6655/device_main.c |  8 ++++----
 drivers/staging/vt6655/dpc.c         |  2 +-
 drivers/staging/vt6655/rf.c          |  4 ++--
 6 files changed, 21 insertions(+), 21 deletions(-)

-- 
2.34.1

