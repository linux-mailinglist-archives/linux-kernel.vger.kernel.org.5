Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664AF80698C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377165AbjLFIXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377150AbjLFIW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:22:59 -0500
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B374AC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:23:05 -0800 (PST)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b8b66d49easo5752892b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 00:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701850984; x=1702455784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1n4zJWsr6xecrNt/UGflcqyznjelA6F6fM/FL9Tta8=;
        b=IAXSoRcRm5wD2+usqmlUFoQKjI2GsHAW/D2sDqrevma9bdpi33in7rHSerTA1C0W/h
         1LoDSPjbDHrK3SZSi432XxmbiuDKQyuqKlTGSZbHqzebAHZ4IQC6q8062p7M5+86YGnA
         euyO01dAyZp06TQNAcvm/IScX7ewRiK8ootXMDKHA0Ych6Yx+SPI+03Mq+6DqktRkGMX
         ZI7UHD5BNuHfEmmyZO5lBshd1AAuqLD2AREvgDnPm9v4sEOP0ufEPI2y185UQB+OFzim
         QNMTPztfg9AHm8UdvgD0/wEVviOMFfj3dLYTIRFizbqkDqBaEO9Dxtx26u5DoLdrtU0I
         69Kw==
X-Gm-Message-State: AOJu0Yx82RHbXeRmJQNIAhR8U7iSkypcucNV+rgWeUU5JixwyFSCJrro
        t5es/sMXuS8cx/vHUcIHSLgTM6UjghgMTrWVhYq0sg95l6/2
X-Google-Smtp-Source: AGHT+IGHtteSeGdR0j7UhNyo/c+BsN/SR85V+9xAQkSMj34MVEIvJo46ZnfCb7VmIIxoKPArfGR71ub/IfXz1qbHedZWuBKd5JuB
MIME-Version: 1.0
X-Received: by 2002:a05:6808:287:b0:3b8:9a3a:61de with SMTP id
 z7-20020a056808028700b003b89a3a61demr494982oic.10.1701850984616; Wed, 06 Dec
 2023 00:23:04 -0800 (PST)
Date:   Wed, 06 Dec 2023 00:23:04 -0800
In-Reply-To: <tencent_F966ECFECCAC7AC26D7C2C3D6F049664E80A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000661b5c060bd30feb@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __llc_lookup_established
From:   syzbot <syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
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

failed to apply patch:
checking file include/net/llc_pdu.h
checking file net/llc/llc_input.c
Hunk #1 FAILED at 126.
1 out of 1 hunk FAILED



Tested on:

commit:         1c410411 Merge tag 'i3c/for-6.7' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=956549bd1d1e9efd
dashboard link: https://syzkaller.appspot.com/bug?extid=b5ad66046b913bc04c6f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10855d1ce80000

