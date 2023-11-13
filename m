Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97677E9946
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjKMJoM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Nov 2023 04:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjKMJoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:44:11 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904D310D0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 01:44:08 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c16f262317so1563870a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 01:44:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699868648; x=1700473448;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqvVKmG1LwglvnJGHHWgyhafxrwxXTN4cPntGMk6U14=;
        b=YXpSv7ojjW08+RscTV/q/1lV035+eSG8dpIhLulNZN3YS0olJZhfxr9htRqIoJjLSu
         TuP4hwnCWOPDPhOh4yrMiaKSb1LkjluLz9KR4vGGf58ZNojjtrFhY05edrZpwkfAVoVJ
         Ycf607FKaQ+szB1vL1NDorzUsrpRoDxDF6as5qs3QWlnUcKes0iKVSiMECksOfDLEno3
         eIoiVHZuKNrek9tLNj14XXKRqz2sj/GoGkpzgdX9EDF9l92TZCutwm49FfyJ4UOcXnuQ
         lL7pHSVt4t0g4YDZz2qP1tS4D1Ofo1dlFqOZ1zyJEZxVBu53I2FaKPWXrWr1BKakzvh9
         0w9w==
X-Gm-Message-State: AOJu0YwczEZTUmuALCxf4L5XWseQaGm4gU00jcgK49bEzaLkgdJK+Lqq
        HyeKH/r+XgfOyy6D2HVp3IArWZUqHLu3TWRlJ/xpPS3MPmDSWrU=
X-Google-Smtp-Source: AGHT+IFBaVpax7ya8xfgqJXZZ5wt2yLst/OrSSf6xMJQr7FrgfTRWXDsS7XkAh9CDEyV0k7dfomsqVGx571EVxg1FqP3epLowEHl
MIME-Version: 1.0
X-Received: by 2002:a63:165d:0:b0:5b9:aea9:17c2 with SMTP id
 29-20020a63165d000000b005b9aea917c2mr2383039pgw.4.1699868648093; Mon, 13 Nov
 2023 01:44:08 -0800 (PST)
Date:   Mon, 13 Nov 2023 01:44:08 -0800
In-Reply-To: <000000000000f5ce160602f29dd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef3d43060a0582db@google.com>
Subject: Re: [syzbot] memory leak in btrfs_ref_tree_mod
From:   syzbot <syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: memory leak in btrfs_ref_tree_mod
Author: jose.pekkarinen@foxhound.fi


#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
5a6a09e97199d6600d31383055f9d43fbbcbe86f

     José Pekkarinen.
