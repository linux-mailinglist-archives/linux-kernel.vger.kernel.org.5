Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA837C8423
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjJMLMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjJMLMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:12:45 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09593CA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:12:39 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1e987fa0d87so2602338fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697195558; x=1697800358;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=by43HP5P2wCaYE3AXTk6u5hvUascQ0ivlvkmhO35+tQ=;
        b=fmAvshlSxkfu07bnq3DqVW3N5PMDMDlTcJZkwiT4SDu0A8QHd/GP03i12Ydt5N02kX
         /zbxTXVjj+CA4Ufa1CsR3grd46tdjaOENxvWZGz++kMvG3DIkz9IWhy8eeBA5M+qGVA+
         fOQpauRC47br41P7ene0j5UqrrzLm5Nn6EhB6E4guZ+kHp8qrkkQ/1M5NpHLQrMQNRB+
         WzsXvuyw/aIAn+y0GOtI2sglA+GpmmNSgAd+2O8VLN/pnzD9X7ub0TvA0TeohyZOjU/P
         2nPari7XcDDblDv3iUNXXs6iz1AmAf98+tDdblx6flJwIp+6MZcOqW7hH8aiPUDwIz6f
         nP5Q==
X-Gm-Message-State: AOJu0YwnMfzefgVN1XBr2W3SXKz8lUx2MkreOa/qGWE6mRG+SWkyrimP
        MuYbVs3XSXiIs8DbkZL7kHPBCdGtCu6c6bU+kRK0dKeyx02V
X-Google-Smtp-Source: AGHT+IGCzZxj4XP2AxDCBDfmXmKwgKGpaekW5mC0xmrgaIW7jCHJRwL8dDP2+4EGDMrZuT2UDhNy6IwuunhEZfEcajfHoYvbemzp
MIME-Version: 1.0
X-Received: by 2002:a05:6870:b782:b0:1dd:3076:9dfd with SMTP id
 ed2-20020a056870b78200b001dd30769dfdmr10505799oab.8.1697195556923; Fri, 13
 Oct 2023 04:12:36 -0700 (PDT)
Date:   Fri, 13 Oct 2023 04:12:36 -0700
In-Reply-To: <ZSklqKDnv9OAGMC3@Sun>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048edd60607972229@google.com>
Subject: Re: [syzbot] [usb?] linux-next boot error: KASAN: slab-out-of-bounds
 Write in vhci_setup
From:   syzbot <syzbot+6867a9777f4b8dc4e256@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, i@zenithal.me,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-usb@vger.kernel.org, sfr@canb.auug.org.au, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, valentina.manea.m@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git@github.com:ZenithalHourlyRate/linux.git/usbip-fix-wrong-platform-data: failed to run ["git" "fetch" "--force" "a8488ce2ff9e416d20038a4d32925ba1057cfba2" "usbip-fix-wrong-platform-data"]: exit status 128
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



Tested on:

commit:         [unknown 
git tree:       git@github.com:ZenithalHourlyRate/linux.git usbip-fix-wrong-platform-data
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e549f76cbaa1b13
dashboard link: https://syzkaller.appspot.com/bug?extid=6867a9777f4b8dc4e256
compiler:       

Note: no patches were applied.
