Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7382A773D41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjHHQPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjHHQN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:13:27 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD9D3C18;
        Tue,  8 Aug 2023 08:47:34 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-583a8596e2aso55689217b3.1;
        Tue, 08 Aug 2023 08:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691509653; x=1692114453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yCidqtySevxmRsxsAwJHxSo9IPHRQMXZPUtf3xL6bjA=;
        b=DYKB7ktSMxwhqg579FDm8Gjai7akSLbrNHw6WAZEUjWCl9MWq3t5+0tGYpHtZ1PV7e
         qqCTgMPb97ygCwBw0Uacfq3x9gDVLWGqRsdlQUq3n0XiY0ZfBxeMmj0OZFc9D9XokxYI
         D3EDzMegCwNPBgJ7FE5DfBzIacUBEZzcX1Evk8PCAxUcPlkx+qdG/8trIAgsm1ayLc7J
         o308iwLpih0VEQvmF72vGiWgdHqKhCfkkWts4j7NNYFAW+CZjAwWYdn+jJOyu9herAkH
         gChoVXoMdN5luXMMQIWa2xGM5S4JBhkOu8EqORjJR/y3+/XJc1o5/2p0vEYKTVi8h5VR
         gAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509653; x=1692114453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCidqtySevxmRsxsAwJHxSo9IPHRQMXZPUtf3xL6bjA=;
        b=bRc0du1jsRXpAZ2HmbFEgiV/8c9NIOn5c+vcM2ZsdJJikNybpddCtY5QsWsO8iYFF5
         dtuolV1rO4qYDm1pRXaD1KCKKpKdFWCPwvVZcpkxQMmbqDPKXj+rHNZ0EpmuuHj3E0/W
         HjQqLts65wZWQyNwDHy9hARF9IbDy8gJo9IYrA38pVzwDdwrUh9HrjM2xI11fdWuLcGc
         2Oijdngt6Bf8NNFSU9E6OhjLY7Mi7Nf2wPbzlqPt69zHH0DhqeCTGMlk8XeUs6563L01
         lWBfZy7v1YU0xbwpRiAiZjZV+giSHVtaw0oTzelTStlrcChzGSvUzientVTaSMfKRykQ
         WsHA==
X-Gm-Message-State: AOJu0YzMtiuhSt1AV3MlJFfx0J7z8w+rKCcZDv0JvXEZAU1GYptlXqyE
        Cjs08/URCQXhWTHCXLI4/cvtpGWpIjaUbKQBYOc=
X-Google-Smtp-Source: AGHT+IHAKIiPOtflnLvy4O6RaV4XTp94WQkpwRHIwm/xqXUcLvZw7Renn4clLc6U0V8mgGeK7kLtCg==
X-Received: by 2002:a05:6a20:9183:b0:140:ed6d:9251 with SMTP id v3-20020a056a20918300b00140ed6d9251mr5691546pzd.27.1691495948230;
        Tue, 08 Aug 2023 04:59:08 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.11])
        by smtp.gmail.com with ESMTPSA id j22-20020a63e756000000b00563b36264besm6484136pgk.85.2023.08.08.04.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:59:07 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     edumazet@google.com, ncardwell@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next v3 0/3] net: tcp: support probing OOM
Date:   Tue,  8 Aug 2023 19:58:32 +0800
Message-Id: <20230808115835.2862058-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
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

From: Menglong Dong <imagedong@tencent.com>

In this series, we make some small changes to make the tcp retransmission
become zero-window probes if the receiver drops the skb because of memory
pressure.

In the 1st patch, we reply a zero-window ACK if the skb is dropped
because out of memory, instead of dropping the skb silently.

In the 2nd patch, we allow a zero-window ACK to update the window.

In the 3rd patch, fix unexcepted socket die when snd_wnd is 0 in
tcp_retransmit_timer().

After these changes, the tcp can probe the OOM of the receiver forever.

Changes since v2:
- refactor the code to avoid code duplication in the 1st patch
- use after() instead of max() in tcp_rtx_probe0_timed_out()

Changes since v1:
- send 0 rwin ACK for the receive queue empty case when necessary in the
  1st patch
- send the ACK immediately by using the ICSK_ACK_NOW flag in the 1st
  patch
- consider the case of the connection restart from idle, as Neal comment,
  in the 3rd patch

Menglong Dong (3):
  net: tcp: send zero-window ACK when no memory
  net: tcp: allow zero-window ACK update the window
  net: tcp: fix unexcepted socket die when snd_wnd is 0

 include/net/inet_connection_sock.h |  3 ++-
 net/ipv4/tcp_input.c               | 20 +++++++++++++-------
 net/ipv4/tcp_output.c              | 14 +++++++++++---
 net/ipv4/tcp_timer.c               | 14 +++++++++++++-
 4 files changed, 39 insertions(+), 12 deletions(-)

-- 
2.40.1

