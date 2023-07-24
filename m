Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F567600E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjGXVMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjGXVMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:12:45 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D05C10D3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:12:44 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b9e5ee1565so9744445a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690233163; x=1690837963;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPnHeXIwNFVyZ0AE0V37vyCdAnCc/H92GAheB3cJ/4w=;
        b=azV9WWOFGVh5WG1SIw9A9t75YyZNWU9msN7Huy4Y7VK/Qubbah9FC1SCeYHLJqw73r
         pZmEtqaRul8Xx1/cDETY91qYPRk/VIXbOd2zEeODQ/INP60p6oki6HwuDw+Lu8anxYqm
         EWxS9TRqMKA6GjMsMOSmUGy/CZRINlvG3EIhc7fL5eUlITMdWbYLsAF12rbzFFOmpnyW
         nk2DOC3ljNmfiPx+HwoFZr1kUTVuLlogf1KaLkMlvpPCcj8izqpMQyn0/g8EkZo7/B+U
         fOQbrWX0Qg9OP9djpObHKAifSdI7xhm4qiYtNVMlKOyWd2xl6Q6x5EkCl8SzEfXdlXrK
         sF1Q==
X-Gm-Message-State: ABy/qLaceFXPu2GCCiGeGC8UQ/4PzJbnk05pKYsZ8i9dGRiilpXnE/Ld
        BALf4/JWmswgdeCn2AvHzuCr7kLZBW4tQOOZerS+lAwSgIx2
X-Google-Smtp-Source: APBJJlEZpLKV/q4LE1/Q6WrdC8aon0BK6TGJhCbOn7xtLIBXrY8K3tRXJk7fN+kSn3DROS/NbpXFthJZJvUNqcYGhZ07hm7fnWGG
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1519:b0:6bb:2244:cb72 with SMTP id
 k25-20020a056830151900b006bb2244cb72mr7592465otp.2.1690233163775; Mon, 24 Jul
 2023 14:12:43 -0700 (PDT)
Date:   Mon, 24 Jul 2023 14:12:43 -0700
In-Reply-To: <19655.1690233158@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050862c0601421343@google.com>
Subject: Re: [syzbot] [block?] KASAN: slab-out-of-bounds Read in bio_split_rw
From:   syzbot <syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com>
To:     dhowells@redhat.com
Cc:     akpm@linux-foundation.org, axboe@kernel.dk, dhowells@redhat.com,
        herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz dup: [syzbot] [ext4?] general protection fault in ext4_finish_bio

can't find the dup bug

>
