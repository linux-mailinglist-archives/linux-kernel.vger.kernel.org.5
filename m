Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BA97A080D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbjINOzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjINOzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:55:48 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCB61FC9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:55:44 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a88fd9ef66so2525183b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694703344; x=1695308144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UniBWXhjoIRRH+Lbg5RT6divqoiHPEl+OKkmkBBM0Rk=;
        b=qPHZxbeN/SuJTAIw50h5gZJwxfVv3QmjXKWj2Tw+NTSg7xFPeWu0Hpj3p+gJK0Zgc2
         0Cfb1Jq2OclSovuBQNQpRzrbh6jlIr+VMjWowrd9Qolf9IZPpg0KxGJvpWw9VgyrWCzf
         YJPIcJraCAFg14AWFnPcqmwTxdmGVq2EjOicyUQU9e9h+QjumCD/djUa6Hgc9BGivxzZ
         vFHhWcgglSAU8bGja6kcpxI8ChgDmdXE5hTuQptTEs5PtXoiqxVu1ZjMzO8zmRmhxx8P
         82PhopRgpgFH79C3E9SEG1BeVf28as8nIqr9VpApHcg9uBmwKjuACMXXmbu/Hm9xGHyV
         vYQw==
X-Gm-Message-State: AOJu0YwRQYoYtsUcXqCooVs+MK0PFtU17AvoHO5ssHMhPNzuewXXMdO8
        xiZ7oaW6Dtva7H/saZM2jn4bU/koMKJPstKH8dWrU7ywJZ2v
X-Google-Smtp-Source: AGHT+IHhg/1FtlbZgxc9UKz3Z5Ng8JG/tDtDrVnWE1ITPoaHT8ro5bQO5sHUNjuGBe0wZmQ0oE4LU3chmPYC95RsXY9+KrPQYl+M
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1992:b0:3a1:c163:6022 with SMTP id
 bj18-20020a056808199200b003a1c1636022mr874984oib.4.1694703342442; Thu, 14 Sep
 2023 07:55:42 -0700 (PDT)
Date:   Thu, 14 Sep 2023 07:55:42 -0700
In-Reply-To: <864c84f9-5acc-132d-0cd8-826d041cff96@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9dd47060552decb@google.com>
Subject: Re: [syzbot] [io-uring?] UBSAN: array-index-out-of-bounds in io_setup_async_msg
From:   syzbot <syzbot+a4c6e5ef999b68b26ed1@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://github.com/isilence/linux.git/netmsg-init-base: failed to run ["git" "fetch" "--force" "2335d1373be159a02254ea7a962dfc5bc7a540d3" "netmsg-init-base"]: exit status 128
fatal: couldn't find remote ref netmsg-init-base



Tested on:

commit:         [unknown 
git tree:       https://github.com/isilence/linux.git netmsg-init-base
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4894cf58531f
dashboard link: https://syzkaller.appspot.com/bug?extid=a4c6e5ef999b68b26ed1
compiler:       

Note: no patches were applied.
