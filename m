Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07957F893E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjKYIbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:30:59 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DC0D7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:31:05 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cfa28b5895so16084355ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700901065; x=1701505865;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jffNxO6EQDJiqySxTcOOWi/xfWWMSTk7iz/1jl6F+R4=;
        b=HuU8qg9znMaje/yiS1QCHPJFaw6Hd/VRDUEyiP782sk21yeuCpd1MmpDnF7+XHr8bd
         nJuNHJL6hIDvpz4zRTYvrSJc+dMs4QLrmR/HMxQ/l+9sFLwBC3qmwL2AWcH1QHkCAwv0
         emi4nMWsFzzMxOI5XdG99WSkk79vobxBM0wHmDvrzMbEt170a9UV98Rs4ccED9usD62y
         YZfos8sHhmSyKVUZR0kMd0zoeTjCOdvzknBeBkxrRH4sm97kK6cwJFrje/Xh/VooipWF
         BR5sami/qUnp7Qa9yn+DXWsJ5K8HkNWs2ZinjK9dJVqLP/BBuryWGY7CX4Hq1l277BrW
         a24Q==
X-Gm-Message-State: AOJu0YwR+lLTDMhdabo9b/1NAbmPwzncLEqOi+oAw5XGfJqisYYJT9k9
        K+7azRi5EScWCLDTQAaRFkFnc2FlwsX/jie0YtVK0l28hq2b
X-Google-Smtp-Source: AGHT+IFJR3Y7OCxHp4Z7dDjTLKWDDogUFm1fHXfkH2mv5WMv3ngwwMk6wAqg7C8zFT3IAQVk1KZdpaQ3eP3lWYh6ekBV3HDZKv04
MIME-Version: 1.0
X-Received: by 2002:a17:902:ecc5:b0:1cf:9e9f:fe6b with SMTP id
 a5-20020a170902ecc500b001cf9e9ffe6bmr1191906plh.7.1700901065012; Sat, 25 Nov
 2023 00:31:05 -0800 (PST)
Date:   Sat, 25 Nov 2023 00:31:04 -0800
In-Reply-To: <tencent_0A75760B67463C59368097E436204B587409@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c73ca3060af5e375@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer
From:   syzbot <syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ntfs3/index.c:1912:35: error: incompatible types when assigning to type 'struct INDEX_HDR' from type 'void *'


Tested on:

commit:         037266a5 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=af04b7c4d36966d8
dashboard link: https://syzkaller.appspot.com/bug?extid=c5b339d16ffa61fd512d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a151a4e80000

