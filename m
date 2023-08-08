Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7DA773EE7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjHHQjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjHHQiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:38:22 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BF914FF5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:53:53 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d13e0bfbbcfso8332696276.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510032; x=1692114832;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8lD/uFf0wow5CQnaoK2oNS4fXZVxBqZ6WPF6m6974ic=;
        b=ArDDN7pLuXPLHQ30g4xEDnUkE7Uw9izurs54AGGl7KC+KWM+bhUxBIXjpwDHjTPO4V
         +J4QNNN+0Yqph8LjEHVkRIgnCE9KlzUDBaky+Wifufa3wAzHGqoyD4EbEWEjxu24Bz3S
         ylitbuUv7Iond3fviQHfCXCFDTMg6q4CDMGLLCc39IBC9FTQgeTNLfCZb4Erm+ysE9pb
         BU/fWfBJ6P+y9pK4d0d3zfMNJvWRW3j/L7NAgbyDr0HfnIC9dpDEOz7xCMXczHyF+i0c
         9ftwOLbu0ivYBILAciu77SgRiyZN5x/8uLCdq5kY9Kt9MmRHePZGR3HIp/TnPCV4Jzes
         mCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510032; x=1692114832;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8lD/uFf0wow5CQnaoK2oNS4fXZVxBqZ6WPF6m6974ic=;
        b=HYPOJ1W++isNTB5tha1BgnG2suqRMGon9zvaEb9f8bSn+Vs7wKv00IupxLbQTO0sIA
         AOby6aYRl3v9savdTIpMdXSRZaQmBkKETJ/+ud7LjKn6HohcKFvJk2CcBXleMd+Tg6bj
         N3P6CCFX+LKpY+u9GRwwZ9DLGOIHq2O5K+Yvzj7747XlWGysWEEM5t+0LVkuzJ96dyb1
         8wg6AGNrQXM3FftQWpMD2K90BdRenfLdyfR4mCmQHEt1DMJHfCK3hfXixxdno7eIjMw9
         ykX/uLAlkUisfSsc9ShedSIBquywFJuTHuHM27H0xiq7544/L2DPdah+CJQDxkyozlHm
         r0qw==
X-Gm-Message-State: AOJu0YyfCTE7PMEtSQCy0G6KcqoXyQzfpxVadss1qeB1KOi5DmCV3ZMD
        NtKnXpFmXAaVs8MaXo9IoGePOa83Nm9IothBe3/60b80oxw=
X-Google-Smtp-Source: AGHT+IHIUVZJ/nIc/PQpNO8vLS/kFvAT1qhSoXUuIxgrtCAvvHN92UdSpESsLnSJlhh1n5DzvC73oCMwFPZeuLKkFE4=
X-Received: by 2002:a05:6871:5225:b0:1b0:4349:b825 with SMTP id
 ht37-20020a056871522500b001b04349b825mr9736850oac.21.1691508352081; Tue, 08
 Aug 2023 08:25:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5f85:0:b0:4e5:e74a:3a76 with HTTP; Tue, 8 Aug 2023
 08:25:51 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 8 Aug 2023 17:25:51 +0200
Message-ID: <CAGudoHGyo4WPjXLfhzCOn1gK6nvx2U1Z=Dh4xcBw6yXZ30p-AA@mail.gmail.com>
Subject: hardening and other opts in kernel config used for benchmarking?
To:     ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
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

Hello,

I have no idea who should be in To: or Cc:, I grabbed names from an
e-mail I got regarding one of previous changes.

Recently I benchmarked a change which added unconditional file
position locking and found a minor regression from it (with profiler
output to justify it):
https://lore.kernel.org/linux-fsdevel/CAHk-=whJtLkYwEFTS9LcRiMjSqq_xswDeXo7hYNWT0Em6nL4Sw@mail.gmail.com/T/#m7c0cd6e913c6295732daea3c88f502bd4724ffb3

However, according to Christian the change was benchmarked by your
machinery and no difference was found.

I briefly poked around and found that used configs have:
CONFIG_RANDOMIZE_KSTACK_OFFSET=y

This is an optional and very expensive hardening feature, my question
is if it was enabled on purpose. The cost comes from adding rdtsc to
every syscall.

Looking at the rest of the config you have a mixed bag (e.g., hardened
usercopy but *no* init_on_alloc) so I genuinely don't know.

Given the high cost of the opt I would suggest removing it, as it
avoidably muddles the waters for single-threaded changes (one way or
the other -- slowdowns can hide and speed ups go unnoticed).

I did not review the whole config.

Any comments? :)

Thanks,
-- 
Mateusz Guzik <mjguzik gmail.com>
