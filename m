Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3FF7511D5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjGLUah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjGLUaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:30:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD891FF5;
        Wed, 12 Jul 2023 13:30:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-307d20548adso60579f8f.0;
        Wed, 12 Jul 2023 13:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689193828; x=1691785828;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7uMes6uDF6XuF/NpG5MMnC6PxQAgXxLxueUoAbhH/NI=;
        b=LZFRlPPBc/guaxqCU/S9PgvkWJYMqqVDnXoSugrlxkAWwOO8LdS1MXT1a+CpDO9sG4
         K6SOELMi/oK5s102zZDqItwsWLKIX+SiDPqrJzOv5zHPjJlIkCwCa1/+ePrF6Hi/Pov1
         G0slFifu7sNallh+LfCz20Xutw1wdVf8J0G5upP8H6AYJof/SkYwXszfk8OrM0G1XXhj
         gd5/1FzcKWznY+Heq4nL0uWGr2VKYQRuCx9tT5/txd6yyQwmBd2ahD9pln/j6sQD96Zv
         G/uosjjqrMmGoDLApLOR9HnD8FIX6bfewRdPedWHG1T6TFem7/OoM8PKaE4sLBXD8liX
         bITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689193828; x=1691785828;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7uMes6uDF6XuF/NpG5MMnC6PxQAgXxLxueUoAbhH/NI=;
        b=EPkt6Oxg8J9jX+9u9JEQ6jhWo37pDUeNsY8Kz9jLzOZbobxHArWJnZbUqBW5pb3aP6
         WUKiPLbqrpLUNNiFRjAE61qbt+RhiHZq59iwaVKOf6l1Pufu90FC3jSPFMquHZhNToI0
         1vAJ3COsdi1AWpGaZ5+nFBYHANTE4qilX/yzqkxEzYcn/h0AAKJhfisEJyfKIGo0jShR
         LEPhXfeWUlPzliYOuANIB5n2qhAtiy7Gm8KrynFoTW0SOJ5haCH0TJ2iOG/Ca/KpXJH6
         rXJxBZfHtXocAathdjtcVBdqzMpwdvt/AntytOGMxMkzBpx3JyPiCXUvELU4Ni9ZTVQr
         JFjQ==
X-Gm-Message-State: ABy/qLYH+GnBWmejvwEAQJ8sKY870Uo0vZWwgO+/o/JG36fkCxdc6n4j
        H8F/lnC5u0dLWbcN1AtLYgRZ5dtnal4kKA==
X-Google-Smtp-Source: APBJJlHVliw/iyNYPUMYmjK4WDaJ/6IY+AIcV/d5ZHeZMbGmE6FXN4HIMFOHXZAfOSkfDh26Lx63Jw==
X-Received: by 2002:a5d:43ca:0:b0:2d1:3eb9:c3c2 with SMTP id v10-20020a5d43ca000000b002d13eb9c3c2mr16310115wrr.54.1689193828415;
        Wed, 12 Jul 2023 13:30:28 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id c17-20020a056000105100b0031433d8af0dsm5982383wrx.18.2023.07.12.13.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 13:30:27 -0700 (PDT)
Date:   Wed, 12 Jul 2023 21:30:27 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC fix for 6.5
Message-ID: <ZK8NY+xAAHRTSEPc@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please consider for pull,

The following changes since commit 45a3e24f65e90a047bef86f927ebdc4c710edaa1:

  Linux 6.4-rc7 (2023-06-18 14:06:27 -0700)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to dceaafd668812115037fc13a1893d068b7b880f5:

  openrisc: Union fpcsr and oldmask in sigcontext to unbreak userspace ABI (2023-07-10 22:03:26 +0100)

----------------------------------------------------------------
OpenRISC fix for 6.5

One fix:

 - During the 6.4 cycle my fpu support work broke ABI compatibility in
   the sigcontext struct. This was noticed by musl libc developers after
   the release. This fix restores the ABI.

----------------------------------------------------------------
Stafford Horne (1):
      openrisc: Union fpcsr and oldmask in sigcontext to unbreak userspace ABI

 arch/openrisc/include/uapi/asm/sigcontext.h | 6 ++++--
 arch/openrisc/kernel/signal.c               | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)
