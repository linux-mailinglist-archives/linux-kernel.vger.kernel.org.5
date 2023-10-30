Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28447DB46B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjJ3Hf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjJ3Hfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:35:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B5FB7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:35:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7cc433782so35125577b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698651349; x=1699256149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ox/1zbaST3BD5MYMQYBwlJcwEmAcclBF5I6+IkAoPUg=;
        b=PmqBHZR3+cjnMFLhkZjwIygVdj7eGAco/cm6eSNtqoZe7F6qLolLvD3B/TYhp7RRZW
         ysSgnHW6nClmepBIU1bViBHKdS+BREdtovUGeLNoeYL+jc43QfsAll+xRdva8DpC4RKX
         GMhuJDFtNwnDxUANhiY6uNCz/NumyvWXVlW7TZlW8pxk0dDvgg1tbPRuE41nE9DL3I4m
         1JVW0niEgNenT6RhE8caX+jPc7wcIICH/su/dQiv57G/sfNQhMdOTsAli/vVhBceW7H+
         doJk1Rtg0Ot98cK2XMvMJlpxV26bc70MoVAJsoSK7VPjuly3o9Uaezn1LLxrA/kQLSAn
         kMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698651349; x=1699256149;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ox/1zbaST3BD5MYMQYBwlJcwEmAcclBF5I6+IkAoPUg=;
        b=K3zZwSbWyRYiDF2XT+2Oe88E2pc70XSUcqxUQj+1hPvZmhYEDBJiZDkrWC0IqqXsy+
         2QLjELgv3m2fsN8UTuVUPQkB4kO4uNte59PECr0KSYzXeVPH/e9h55gJ8xegoyxbxQ0x
         pUs/YJIrfJOF/fcZlKrfcULVJbxAWgz0OvKxA3tBvgRABsZGPaQaHyCMFOB2ErVDO/q9
         kVzWgqpAATTDoK2JJWPZHADnbLSdmtIPT3FDzvqIGXM+ATWsEjbojPnA38hIpu+1CkTx
         NA5xe6V3C25fzEO1b+7ZOLFfsq0Aml9c6SFMRvhCGbRlF5CP78KqULdLGsvkuFBRBM8E
         QdLQ==
X-Gm-Message-State: AOJu0YyP0qOHkm8hI2Y+k2F2D2ybNumTVeqbm9ymt6SjwPS10kaqeeLc
        ewjtY27qXwZDXteLL8H//9j1qz/lhf5ECKtFeBXJ
X-Google-Smtp-Source: AGHT+IGZvGiXRtnyMqYvh9R6Clqt7qLFE6PqQ3QVn+IDJJlecNyVHfV8DD+Bk7Ysi3aTRoK5XTCgTOL+xRlZgrJsyyS+
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a81:6c49:0:b0:5a7:ba09:44b6 with
 SMTP id h70-20020a816c49000000b005a7ba0944b6mr181888ywc.0.1698651348792; Mon,
 30 Oct 2023 00:35:48 -0700 (PDT)
Date:   Mon, 30 Oct 2023 13:05:40 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231030073542.251281-1-vamshigajjela@google.com>
Subject: [PATCH v5 0/2] serial core type consistency and clean up
From:   Vamshi Gajjela <vamshigajjela@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>,
        Vamshi Gajjela <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series primarily focus on improving type consistency and
ensuring proper handling of timeout values. The changes aim to enhance
the redability and maintainability of the serial core.

Greg, sorry for the confusion.

I started the patch series with 3 patches. I submitted improvised
patches based on review comments for each patch in the series instead
of submitting all the patches at once. This may have caused confusion,
as each patch is now at a different version, with one patch at
v2 (NACKED) the second one ready for v2, and the third at v4.

From now on, I will increment the version for the whole series instead
of for individual patches.

I have now submitted the series as v5 to avoid duplicate version numbers.
In v5 it has two patches [v4 3/3] and [v2 2/3] while [v2 1/3] discarded.

Vamshi Gajjela (2):
  serial: core: Update uart_poll_timeout() function to return unsigned
    long
  serial: core: Clean up uart_update_timeout() function

 drivers/tty/serial/serial_core.c | 7 +++----
 include/linux/serial_core.h      | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.42.0.820.g83a721a137-goog

