Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171537A4812
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241456AbjIRLL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbjIRLLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:11:13 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D843812E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:10:35 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3ab724f59deso7639264b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695035435; x=1695640235;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gG7RNbFAvJay0quXxW463SyUC+6Xd6Vr6g5CQxbRyKw=;
        b=u2Qw/QAbzEewd20yl4Gty/1qrUb0RawOn5VHwM7XAs0BiSF47bEN8G8E6VNGKeJAMs
         HdalvpQF6dMNjBuRdVqInBHVbKhqZ+xV15pRDtFURo/say/OyW6rrfWRN51TtSVUDna5
         /ez5a1sLY6ZzDKMzDM2B6AWRp5nOResw61dhB8Oc+tTVBUvDFOq08fOdx1v/Wh+/rwQ9
         jdE6TJcI/DkZ5RIof5AIs+Urp1c+qFTPQy7QwEfysM9GTPCA8Fj8ZG4oHeTWYiKcVBqv
         PiVAg+icNuzIyHW6JDVfo/pOtsUqXuURT29OOh2fDDwBS1ZyxU4Ej125qYwyNQm1ppPL
         kpkw==
X-Gm-Message-State: AOJu0YzygO18foDAMhSHCVvpCop7M346djkDzG+nfZtqY1a9fvqF2xTa
        ex6ScSUIWJmerGKhaT0IBCgVs9Zba7czd2S+fAC55wi4XGGF
X-Google-Smtp-Source: AGHT+IFMGEFDrk8h5J/P5zRFgXO+m2zzRmcowl4TZZZyXd+aLihSja0xcslK/DwDuxq5LiZ4k2MrePVWc5ZK+2eoqls0aIp/GYZ3
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1829:b0:3a7:7c00:49c2 with SMTP id
 bh41-20020a056808182900b003a77c0049c2mr4088966oib.6.1695035435172; Mon, 18
 Sep 2023 04:10:35 -0700 (PDT)
Date:   Mon, 18 Sep 2023 04:10:35 -0700
In-Reply-To: <20230918-dorfbewohner-neigung-ab3250854717@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000feca6e0605a0307d@google.com>
Subject: Re: [syzbot] [overlayfs] WARNING in setattr_copy
From:   syzbot <syzbot+450a6d7e0a2db0d8326a@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, brauner@kernel.org, jlayton@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+450a6d7e0a2db0d8326a@syzkaller.appspotmail.com

Tested on:

commit:         f8edd336 overlayfs: set ctime when setting mtime and a..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
console output: https://syzkaller.appspot.com/x/log.txt?x=124fa964680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4894cf58531f
dashboard link: https://syzkaller.appspot.com/bug?extid=450a6d7e0a2db0d8326a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
