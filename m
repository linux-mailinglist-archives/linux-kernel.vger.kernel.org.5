Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2827A33DE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 07:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjIQFma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 01:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjIQFm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 01:42:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931DD12D;
        Sat, 16 Sep 2023 22:42:20 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50300141a64so1610308e87.0;
        Sat, 16 Sep 2023 22:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694929339; x=1695534139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m7X712RcBU0EimntyDGp+oEBEn/juMf/+pTBwumrZJc=;
        b=E9xGHi37wjQmYwyaQp+bIVarLKQCOjufxcNREQ2UViQchBlnh+RLsHpodPk7KQmX20
         S0QltsF0N4SsX2+LnfmjjwCcNIJ4rP5J9pb7ISFT+N6PyRDNT7Hf7EgvJN5mK6MlFA//
         vADbh+2W0VOLcneCYysIMz45J1SFT4QoV8C0RFO+ATaAc0CR3YK3lMdd2SpV4JgWuiS9
         Rr+ldtRthG8Zdn1cFu2JQj+pGmOUBock7GOHGnhQZ1mOtwoDLpXSTTttxWwqs7s99enC
         cop3XMGgsXt5sCFRhLMMeTrjbPpmILaTBjDbWVBcjJnQOgjNBwRbbFpd+fkZiqKLC/6D
         FUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694929339; x=1695534139;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m7X712RcBU0EimntyDGp+oEBEn/juMf/+pTBwumrZJc=;
        b=vDP0sHlababbTR/5zOUsQC9BvgIXpr9O4N1UT9vSQJmBjtrE0ohF9oTZsdB9oH0Xsd
         tD3rmToQLwmEH5r7RKO5J4GeOFAzUMCwuOZWkk8jnpYrfpDCpKkbQjP8rxHb9s+qisba
         jyCMc52zKW4IE8N8nAUOHl6506cewi5M6UXSwUMpQ/FcaGvp3/MOm6A8PFVc/C1BnUAe
         Q5QQMTqTP4mJnhxZSqVxzhQ15dn5aUcJeNNobWeLr/1vkvXAYOnKQMO5XHKBa/PHPFq/
         4kGTJMPcpd+Kapgymp8hYr9b3IXFXVzVYlfDKrr8XaLhkirMp9NwED0nBuhL8q1LagiY
         JFMg==
X-Gm-Message-State: AOJu0Yy+qmcQ6QhmdwZpS5zagsdbO1eF8mgNvuDPdsmGz9PNOLDxksEB
        H6QWMOMlq+DkyG2NktIyAu9KQqsOZZMB5rj9DvNjG1QTK2U=
X-Google-Smtp-Source: AGHT+IHhPISiucVKXq5WicjC8dVd6S4jyb2fDyi7SUvuQYkBwDQfa9mvJpDVukeVVnrIo+TwbPLj2eoC2VOboAanv30=
X-Received: by 2002:a05:6512:39ca:b0:4fe:3a57:7c98 with SMTP id
 k10-20020a05651239ca00b004fe3a577c98mr6127529lfu.32.1694929338412; Sat, 16
 Sep 2023 22:42:18 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 17 Sep 2023 00:42:07 -0500
Message-ID: <CAH2r5mvynNQOCJFdVOTf82H3y_GF1UuF=EvcAw4FL1RVu5ieTg@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc1-smb3-client-fixes

for you to fetch changes up to 2c75426c1fea591bb338ba072068f83d2f6be088:

  smb3: fix some minor typos and repeated words (2023-09-15 01:37:33 -0500)

----------------------------------------------------------------
Three small SMB3 client fixes: one for a null check when assembling SMB3 headers
and two minor cleanup.

----------------------------------------------------------------
Steve French (3):
      smb3: move server check earlier when setting channel sequence number
      smb3: correct places where ENOTSUPP is used instead of preferred
EOPNOTSUPP
      smb3: fix some minor typos and repeated words

 fs/smb/client/inode.c     |  2 +-
 fs/smb/client/smb2ops.c   |  6 +++---
 fs/smb/client/smb2pdu.c   | 31 +++++++++++++++++++------------
 fs/smb/client/transport.c |  2 +-
 4 files changed, 24 insertions(+), 17 deletions(-)


-- 
Thanks,

Steve
