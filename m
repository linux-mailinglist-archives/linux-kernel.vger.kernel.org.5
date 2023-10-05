Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EC17BA539
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbjJEQP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbjJEQNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:13:05 -0400
Received: from mail-ot1-x345.google.com (mail-ot1-x345.google.com [IPv6:2607:f8b0:4864:20::345])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4DD22CA0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 03:46:29 -0700 (PDT)
Received: by mail-ot1-x345.google.com with SMTP id 46e09a7af769-6c4f235ee22so993923a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 03:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696502789; x=1697107589;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGwGxlTuATRVWE5UT3ZKJoT5MpU675X68ZbpYCN+7kY=;
        b=vzEDpSlTElDTwiOpNJmqj9W7HnetW0sgPy3icAiFrxpUlQSvFP8jKr6nA72jNKOg1K
         O52+x5OF/P7ftKI5ghAJO7I+Bz5+hDstDPwbWr02AtZfYWPt04C9GzN34jxgIKnDkNLr
         LOdUL0cT8r/5leR4IUQqWLfXvQe4kWWqskPJvvDhtTir+xke6eQMhZq6Od4MQe51ZCaL
         hrf2jSnk5odb5365YwB4Zul7oqnGhwKHQnIo+FcUiCAC449m2G1qNNrancrdIJ9B85se
         p3N9kZ7Q1oW/QLlR4ek3LBgnU+pyMjo7k2pSRNO7LUPZGwkqaw9iol5BiP7ZtR+39evL
         HVsA==
X-Gm-Message-State: AOJu0Yw3jaoQxhkEulCzc60mGcv+qx55/n0fuSvNcKiyc8QQHkvMgbxD
        48vZnjqaHdElR0NXPSqO9gK/VnZ8hnAQqn9KH2I4gc96X+yj
X-Google-Smtp-Source: AGHT+IF6NXpW2zd+hCeIzElnwrg53MI5PnCCJL42D9bvk43rwJ1rmAHq/sIWi88y/rKUpfhhxrW+Yd6VgiNDyLe+SSuoEVFU4PnF
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1987:b0:1dc:768d:bf6b with SMTP id
 v7-20020a056870198700b001dc768dbf6bmr1900344oam.11.1696502788922; Thu, 05 Oct
 2023 03:46:28 -0700 (PDT)
Date:   Thu, 05 Oct 2023 03:46:28 -0700
In-Reply-To: <CAOQ4uxjw_XztGxrhR9LWtz_SszdURkM+Add2q8A9BAt0z901kA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001824660606f5d6ac@google.com>
Subject: Re: [syzbot] [integrity] [overlayfs] possible deadlock in
 mnt_want_write (2)
From:   syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, hdanton@sina.com,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        mszeredi@redhat.com, syzbot@syzkalhler.appspotmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, zohar@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com

Tested on:

commit:         42555f30 ima: annotate iint mutex to avoid lockdep fal..
git tree:       https://github.com/amir73il/linux ima-ovl-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=16889486680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57da1ac039c4c78a
dashboard link: https://syzkaller.appspot.com/bug?extid=b42fe626038981fb7bfa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
