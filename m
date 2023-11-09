Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2D57E6B85
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjKINvI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Nov 2023 08:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjKINvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:51:07 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075202D59
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:51:05 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-27ff8065e61so753266a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 05:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699537864; x=1700142664;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5ozZG8C3Zec8UMJdVdWb0YxQSgyY1QPIvw9Fyzz4f0=;
        b=iH5FbESxhaqpWBDW0HgxCyVM1IQVqeZYCvKQvYAZM9FP/gtStS5V/02k2z/PtKxpVt
         zOh02LRL7ktLbpj2kYtco+uT4P+xp6FgfS58Fy8yZYlUxXdDnhcgCS72npXS6JWTy5Xn
         BdIb98lRirVN7Q1IIgChGJGUlFafnN7pQne7CqLv2Ora1dhEb6jbaMkHIJty26mCf6tj
         TpyP5GWY000PVCZH4WbaneyJJB6tIF8JxB6kgG4eUtovUwav5gRiadrKIXXiHE1/JIBe
         nI0ESY3anvtv8Redc2y8yaGCIWDnMPUghFhRi81rOOpG1FOpfdd2djOWO9eCbdy3Kpo0
         blmw==
X-Gm-Message-State: AOJu0YxfKdKHZoYdp1W7i/gkY3wJ5GYwOxo/ChjcBXanZeceGG4cdXOk
        +IpVD2V0eJEwlpxQVRKyjXs0+xJxJISpYY1VG29Yk8Ujxw2I
X-Google-Smtp-Source: AGHT+IHheQXpXTC2mutTxI3+sh37d5qxgz7UiushsZQSXU4T5sAGNr7Ow1kbNcN/0RWaViM9HQTCGa3YcledOsMrleGz7elMuFvv
MIME-Version: 1.0
X-Received: by 2002:a17:90a:9513:b0:27d:e40a:96d3 with SMTP id
 t19-20020a17090a951300b0027de40a96d3mr398876pjo.2.1699537864609; Thu, 09 Nov
 2023 05:51:04 -0800 (PST)
Date:   Thu, 09 Nov 2023 05:51:04 -0800
In-Reply-To: <tencent_074AC2742F77F567E83C53362096E4365C09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3d7690609b87e12@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/nfc/llcp_core.c:1649:8: error: static assertion failed due to requirement '__builtin_types_compatible_p(struct nfc_llcp_local, struct nfc_llcp_local *) || __builtin_types_compatible_p(struct nfc_llcp_local, void)': pointer type mismatch in container_of()


Tested on:

commit:         aea6bf90 Merge tag 'f2fs-for-6.7-rc1' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1672b188e80000

