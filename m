Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74D17785B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjHKDBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHKDBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:01:41 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BC92D60;
        Thu, 10 Aug 2023 20:01:40 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 5614622812f47-3a43cbb432aso1273450b6e.3;
        Thu, 10 Aug 2023 20:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691722900; x=1692327700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+DnlrBg/2kZEFPjJJJbtUXL+fxABbd2M98TkdtFb0+g=;
        b=HN6VZN2dCED+zJj++6s5QY8U+Lc8YqJGdBQkKL7l+zjba2DlawIWk1msYVPK3MV/1G
         LOAwuDWsYILScSMFUZYGkn8HUwXGTWR7Rwq6rbF6kiBoFXnrmRU/Tdf0CX91mA7pyQvw
         q8e/1Xz4bEMW5/TiHzP+qaWvc4N2Ga5UK082b45c2K8nYmDBQwk4o9UhAq0KtqSdnPXt
         A1Hyr2UnKJsA1T8Gf4ohopJWHhnkBf19I1Mp3rt3J1Sso62cugiqD7AJajmwEWa1uKjt
         RQC54mZmFs9jtSZIPl3ebd4zmJ4cz8FCl24bY+vZb5C4voElo+pIL6VjcqKCtjUcaWTf
         qDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691722900; x=1692327700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DnlrBg/2kZEFPjJJJbtUXL+fxABbd2M98TkdtFb0+g=;
        b=M3Ypxud8NhR0uTPs0gx8UqVNBgm+/p/SHy6eKTXOv8+uk41bZcKHb90aqZTOhHX8f6
         3suKgXXzXzyliaxFmLn/eurKgREP2j01VaZ3pfnfgFZbLCO7M5yjtfxzufQCMARTcjdj
         Wy6TwM5lxYY5W9W1eP51S2TvnKmgZH9eb8xzeF/GG0p5C29wQ0w7p8Tri5Pqj1ixYAy3
         9MbsR5pG3Gx225ciDCZFQYkNcEWN/3Dlq0wRoOg2mbI14QPPtpDWydtmwNQ+DamP+CFz
         pAycj5qefiNyc4nOZWC4YRrVDYr4LSDM3JJ9lYkGnBdANtvyIlRtO/+2gDqBj6xWgrkV
         4Yug==
X-Gm-Message-State: AOJu0YyvfPJmh03/ZxUV/UA+m7Vf2wz8iSid90Xj+lU/jJjeGJitvujN
        SQTRw/mD0vaupFuVkJD0Kpbw50QDFz1lADiHx6w=
X-Google-Smtp-Source: AGHT+IEtDeSbIJpS8KeWdJO69hZR7jtZ8fcq0PqdWTd5ibTJOUmDDOaoKZ+k6trX/mPSuZ/mvjZd3g==
X-Received: by 2002:a05:6808:bd0:b0:3a7:25c6:7b83 with SMTP id o16-20020a0568080bd000b003a725c67b83mr935519oik.11.1691722900107;
        Thu, 10 Aug 2023 20:01:40 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.10])
        by smtp.gmail.com with ESMTPSA id l5-20020a639845000000b005646868da17sm2281197pgo.72.2023.08.10.20.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 20:01:39 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     edumazet@google.com, ncardwell@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next v4 0/4] net: tcp: support probing OOM
Date:   Fri, 11 Aug 2023 10:55:26 +0800
Message-Id: <20230811025530.3510703-1-imagedong@tencent.com>
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

From: Menglong Dong <imagedong@tencent.com>

In this series, we make some small changes to make the tcp retransmission
become zero-window probes if the receiver drops the skb because of memory
pressure.

In the 1st patch, we reply a zero-window ACK if the skb is dropped
because out of memory, instead of dropping the skb silently.

In the 2nd patch, we allow a zero-window ACK to update the window.

In the 3rd patch, fix unexcepted socket die when snd_wnd is 0 in
tcp_retransmit_timer().

In the 4th patch, we refactor the debug message in tcp_retransmit_timer()
to make it more correct.

After these changes, the tcp can probe the OOM of the receiver forever.

Changes since v3:
- make the timeout "2 * TCP_RTO_MAX" in the 3rd patch
- tp->retrans_stamp is not based on jiffies and can't be compared with
  icsk->icsk_timeout in the 3rd patch. Fix it.
- introduce the 4th patch

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

Menglong Dong (4):
  net: tcp: send zero-window ACK when no memory
  net: tcp: allow zero-window ACK update the window
  net: tcp: fix unexcepted socket die when snd_wnd is 0
  net: tcp: refactor the dbg message in tcp_retransmit_timer()

 include/net/inet_connection_sock.h |  3 ++-
 net/ipv4/tcp_input.c               | 20 ++++++++++-----
 net/ipv4/tcp_output.c              | 14 +++++++---
 net/ipv4/tcp_timer.c               | 41 ++++++++++++++++++++++--------
 4 files changed, 56 insertions(+), 22 deletions(-)

-- 
2.40.1

