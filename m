Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D818096B6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjLGXnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjLGXm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:42:59 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1791713
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 15:43:05 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b8b340f6ffso2167987b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 15:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701992585; x=1702597385;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DltAKS9wvxG6lWxx/z5S+aoDJzNRGhuClMTrwwb9GY=;
        b=w2Fy+Sc/SygEJvewW75L/SI0NABX/e0AHJZwSLYwK4Uyv898nxhG3q6hzc7RBTXPu6
         0UMewytN+0OEn/jJVvSBud/sftcGpAJ2N1llvlSLqU7hXUKqTa7X5yu/RLbtcG0/iJ7H
         FqDmOg9qNcMDY/NO5tuzappjqeqAicOEeJnlwauAwyAyzaOWdLiqgZ1SQfA5DkYs8uJ8
         Qdt491HAB0Es4N+WNWR4MpArXBAWUdz2ZMaMT17+cCXLWHwTyRMO8wW+DF+54knms5SO
         SJ0EJ2+rxRINtzIedN0CilewaEnohIY+n4/Z2A5HWDg4dZJ1m9jgFi6T0ymDE92QtrDk
         DmwA==
X-Gm-Message-State: AOJu0YzBBWNTzaJDnBqyqsXcKQUo/EIcTiBj3R1JczEIkAeMQ4DAIQAa
        xXpl3fbNFioIZmzGtsaZk2fK/wfLxPwyggii5hidtyZ5S51rH8Y=
X-Google-Smtp-Source: AGHT+IG0yb2MxbvA26AdgHXWz7xXEUi3RrApumbOy09tE6ZUqKcaNSNcSdGWLn0nhKf/q1S0RwgpvoZfrUkItfedZjWaQH2Clu8q
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2092:b0:3b9:dc53:7c2c with SMTP id
 s18-20020a056808209200b003b9dc537c2cmr2039071oiw.5.1701992585027; Thu, 07 Dec
 2023 15:43:05 -0800 (PST)
Date:   Thu, 07 Dec 2023 15:43:04 -0800
In-Reply-To: <41525f35-14b4-4179-8ec2-10a5c42cb9cd@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070e854060bf4076c@google.com>
Subject: Re: [syzbot] [net?] WARNING in ip6_route_info_create
From:   syzbot <syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, sinquersw@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git@github.com:ThinkerYzu/linux.git/fix-fib6_set_expires_locked: failed to run ["git" "fetch" "--force" "7f85d17015ba166311ead463ef566bfcdfcee3b7" "fix-fib6_set_expires_locked"]: exit status 128
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



Tested on:

commit:         [unknown 
git tree:       git@github.com:ThinkerYzu/linux.git fix-fib6_set_expires_locked
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=c15aa445274af8674f41
compiler:       

Note: no patches were applied.
