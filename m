Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995637B41B4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 17:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjI3Pdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 11:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbjI3Pdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:33:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00D7E1;
        Sat, 30 Sep 2023 08:33:47 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5043a01ee20so21140191e87.0;
        Sat, 30 Sep 2023 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696088026; x=1696692826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rz6qqauUwryTzT5iS+LhmUaiTkmOb6WCflVSmhCu3Fs=;
        b=Hk0FbNTiR7Ouk43OfUTcwezyIcoEIfs1HrqZ8BuqYnWccqOQxd62eHsoS3eGvDVOMB
         C3gM4aUDQOQG9D2FrgGnU3uhcoxQP5IwLZhabLDEp9Scpo9UPq9NZuEeEZ5M8tCNEazM
         22o3mkNQ0fjNrG7dw/oKraCXye9IgkVbFF8b/pkzaYE9jhr4Jo8z4Wz3kQWj+MW8Sqvh
         MrLBLlwo1ABMjXKesW7qK+1DLpAKu0QFsWZg1uSiJ6z+Q8vU0A2qKmo75H2a3mHzYZaj
         81nGp8uKA4MZ9ZqNHcpV5aO1+7DGQW/yGMDlK0hukHTfc6KP2cUHW3uAYeB+NEBlQiei
         u4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696088026; x=1696692826;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rz6qqauUwryTzT5iS+LhmUaiTkmOb6WCflVSmhCu3Fs=;
        b=VDqhiDK8SNe5Ysf9c2xPq4OVgtRQ3SnDeoo2BHDNO48ENPpYmWAnugWQu/7LGvQdPg
         LzbFOBESwNRWmeIt3G6iE0VaBcP1l6MBvQJqLrt6/1ckD7MdQunpl1IzpNzN1oAX3elI
         vYoxiz2dIIu2dvIzu+c+1BT1jv3itwdmrzpI9pVNETfU9CLPv2WSgeybx611wUgDNkUB
         omdoiLrqgn941ubXTJQYkfzv82Noypah900y0SFZmSuE+3DMkiMk+umfC7538IgBdox8
         U5OG8wmid8DcC6viw92npkSRAdYT/62zUn8XYKFXUDCxbPa8huOSpGxDmEHeS2S8NLOG
         kaEw==
X-Gm-Message-State: AOJu0Yw0C0lFuOUZloBvwMP/Gi58eHEhakfmfDinezn09oDHYTZnAbOM
        TnlxoCajCBfsPhT1PsfRxjqW0d465aeYoVdkm+5I7EMTcbM=
X-Google-Smtp-Source: AGHT+IFGtxrVq+ORNRlRk7ratzg+C3ejYyz/e/XjKHBazPHWqUu8d6LTu0OErQV3M8ExkaRQMnYIFG83pc/py9M6BGk=
X-Received: by 2002:a05:6512:2507:b0:500:aed0:cb1b with SMTP id
 be7-20020a056512250700b00500aed0cb1bmr5688190lfb.24.1696088025715; Sat, 30
 Sep 2023 08:33:45 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 30 Sep 2023 10:33:34 -0500
Message-ID: <CAH2r5mv+=bHF+Q1fge0yU21nBkrP+4T089nuS_PE+cJZAXoE9g@mail.gmail.com>
Subject: [GIT PULL] SMB3 client fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Please pull the following changes since commit
6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc3-smb3-client-fix

for you to fetch changes up to e6e43b8aa7cd3c3af686caf0c2e11819a886d705:

  fs/smb/client: Reset password pointer to NULL (2023-09-28 14:49:51 -0500)

----------------------------------------------------------------
small smb3 client fix for password freeing potential oops (also for stable)

----------------------------------------------------------------
Quang Le (1):
      fs/smb/client: Reset password pointer to NULL

 fs/smb/client/fs_context.c | 1 +
 1 file changed, 1 insertion(+)


--
Thanks,

Steve
