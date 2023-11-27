Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06CA7F9D96
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjK0Kcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjK0Kcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:32:41 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D51519A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:32:47 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54b7ef7f4d5so574380a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701081165; x=1701685965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MXMQoO+59B4RfteS2TdLsbxfrqFnOoPJv0gB7OXCjEY=;
        b=eEgYRyM4UwxQukgakNEtvLsWwz0g3IkCQJF5CxdoULOSneX5H+/Phbkc1QwM+yqA1/
         R+Y/71H09ZafjVjKny5gOwiJRhT3Hf9hHTt1jsuUNdb4Z6SZz9fPBxEgei7YVDBpdzE1
         d9GRf3uPVPM/+c/qHqPIJWgqkYdH58HJ8wTLV0bbh8TkpO3G1sA3ehFXrfdPrPhS+dyD
         Gg5q+a4blTzZnbNp4pXX7yei1VMvdAZMMaeFzc8krJDJYsz11I4S+p+Gzrv9Ts51OjSh
         K1LENCZw+ufbYAaULngHNFxd/P/IcUCYeOhrXY1XtmLkFxxf/rTibTY9NQ9ce2iucME6
         1wZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701081165; x=1701685965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXMQoO+59B4RfteS2TdLsbxfrqFnOoPJv0gB7OXCjEY=;
        b=jvj240ZsAVoxWr41syxuqGT1+EErFgjujGiedXgIU5hwx1nfMdfx0ueGUKj8wlkt7G
         HKrP0O/MOfTX8FLQsP9P+3fOM/syLTWI8Op+gH5cuJoPPQGOFCAEh+ZdovdA/AzazWqP
         ZN36gHvavYAfvr5FlD2obiTv1xcOD++KczrGwp6IdRFBIPyJi4a62+1Ag3YWLPqAl+eu
         MQgz4y0Va7d8EWMlLF5Bz9psfSUV1ji3cBfwioYziJgpcm+kKOmiYYnTBTr2g+v6pp8e
         1roq10eOWA3NDdp4BpFZOP1JdcAhD0FSmSrS21AbuCA1yYAczkmXptTt/H+D5cnw8VbX
         1Jbw==
X-Gm-Message-State: AOJu0Ywv0VE6i6bPCqpRoRwAYl2mz0nX3056iqHK1ZUsAHP0XQekLul6
        +PqCPwa/+WbSb8w2hdJqKLY=
X-Google-Smtp-Source: AGHT+IE53nVgDe6am8VQnSmuEc2nVIGn53iFk+onJPjPjQxuGPRfSA1eJw0A78ujNNjk2qYF4ie48w==
X-Received: by 2002:a50:d7dd:0:b0:54b:2894:d18f with SMTP id m29-20020a50d7dd000000b0054b2894d18fmr5121148edj.13.1701081165346;
        Mon, 27 Nov 2023 02:32:45 -0800 (PST)
Received: from andrea.wind3.hub ([31.189.63.178])
        by smtp.gmail.com with ESMTPSA id p5-20020a056402044500b00540ea3a25e6sm5142057edw.72.2023.11.27.02.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 02:32:45 -0800 (PST)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     mmaas@google.com, hboehm@google.com, striker@us.ibm.com,
        charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 0/2] membarrier: riscv: Provide core serializing command
Date:   Mon, 27 Nov 2023 11:32:33 +0100
Message-Id: <20231127103235.28442-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the RFC discussion at [1].

  Andrea

Changes since RFC:
  - add prepare_sync_core_cmd()
  - add #ifdeffery for nosmp builds

[1] https://lkml.kernel.org/r/20230803040111.5101-1-parri.andrea@gmail.com

Andrea Parri (2):
  locking: Introduce prepare_sync_core_cmd()
  membarrier: riscv: Provide core serializing command

 .../membarrier-sync-core/arch-support.txt     |  2 +-
 arch/riscv/Kconfig                            |  3 ++
 arch/riscv/include/asm/sync_core.h            | 29 +++++++++++++++++++
 include/linux/sync_core.h                     | 16 +++++++++-
 init/Kconfig                                  |  3 ++
 kernel/sched/membarrier.c                     |  1 +
 6 files changed, 52 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/asm/sync_core.h

-- 
2.34.1

