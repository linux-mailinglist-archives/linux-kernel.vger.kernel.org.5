Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1703C7834C8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjHUVVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjHUVU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:20:59 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB52C7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:20:58 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bca38a6618so2984244a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692652857; x=1693257657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kXQLL/tQqoFblrCpS21gCxhSOHNRrMyl0EvcluCINWs=;
        b=adBtwsEygc8n+sFCZPCfYzUiaCLpHcu5M+MSJEvXt7Z3kfAE4oK8VkP5IPaquOv/EU
         FkiDiOF6JunX4jNCYVfGXHzGYRt66mhgG64QNZRrcyQL4crVZ32IaEVhxM0QqULG0jpp
         BPOpjrnoCUBOm+ZHWY6NyEnFWRKNIJhxqkn6NpeQ4oBWbpi+bseC6zhW7LyjIF0+87E2
         Ujvf3ucibhfd+nMd8HZRu5QiIjJ6IsEcnl5HiSXOYZfUj3KoUVs4NLE1voALRSFe+sTb
         pdxKSJQzkdwfz8DZivoEcy3FpIMil1z8isVWeeMg5TTKAKIo1BJNvF6AeMSj+eOgfaVO
         wQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692652857; x=1693257657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXQLL/tQqoFblrCpS21gCxhSOHNRrMyl0EvcluCINWs=;
        b=hBvnunu/QyBZVfMq559DNsXKiUyNemjsxW/938/vvw/yyOTC6BJ5u+52ZVhqt3mQSk
         72bnx4mGDrTEH3FiwuBk+4lxBMjfw1xvKqzIyEaMze0ICybde8UL5vRpykrnFrlZO7Yn
         UQlIINYCxGDqzowkrKcKyJzP+O0lPiCALOy7HHuc30ZPLUyvtXptCBLwmzrdKgu5ysqV
         8FzYCevnniroEE1qgL6Ra7BqEoHFtNVJ9oU6q0gXc6FK+K6SUi71eb+ZND9huWA3lK/+
         01/QTK1fPh004Wr7wgI8uFkLfpbGpSQSyeQlWUx9Oo3jGSqMWfMuUz1MvBwZ7myltee1
         LfLA==
X-Gm-Message-State: AOJu0YxI4MYX7WS7pQ+4Z7rqY3B42p0nsXZGg3vZ2dm+N7iAPO/ZDMRp
        UiM2UB/qCY1KxhbTrl2AdTuExLfC/0qTHA93jvMr
X-Google-Smtp-Source: AGHT+IF0JsWcEVdMlYbfQjVn6UDxH5Q06yGBJF74FyYf/4BoJA/N0KJG4X0r8FBPfUJOAbsOtcnK4WJaCK02MNj8hIM=
X-Received: by 2002:a05:6870:702a:b0:1bb:3f64:bb89 with SMTP id
 u42-20020a056870702a00b001bb3f64bb89mr9540871oae.24.1692652857675; Mon, 21
 Aug 2023 14:20:57 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 21 Aug 2023 17:20:47 -0400
Message-ID: <CAHC9VhTEeicj__ys3duEhmv4WuLgZupWanr_bXwObRCz_jxatw@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v6.5 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A small SELinux patch to fix a potential problem when cleaning up on a
failed SELinux policy load (list next pointer not being properly
initialized to NULL early enough).  Please merge for the v6.5 release.

Thanks,
-Paul
--
The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5=
:

 Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20230821

for you to fetch changes up to 70d91dc9b2ac91327d0eefd86163abc3548effa6:

 selinux: set next pointer before attaching to list
   (2023-08-18 16:13:03 -0400)

----------------------------------------------------------------
selinux/stable-6.5 PR 20230821

----------------------------------------------------------------
Christian G=C3=B6ttsche (1):
     selinux: set next pointer before attaching to list

security/selinux/ss/policydb.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

--=20
paul-moore.com
