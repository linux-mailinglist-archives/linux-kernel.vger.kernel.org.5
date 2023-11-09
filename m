Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A187E6AE4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjKINCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKINCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:02:06 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C992F1AA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:02:04 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6c334d2fd40so832499b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 05:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699534924; x=1700139724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tXJz+zhkT0Nsxel70+zGuKRJXZIrJ6mZyEyIwMbzNk=;
        b=pIPvgCzMYuNA4iNtBLozeFqyC+e0m4fcnB3AmzTH+BXmdZkiulX4k8SgQZf5XA2+In
         0QpDMW8lwbU9Aeop/iUD9TkQIT36Pxqyk7Y85b2bwKGsk9smpeZr3VzXTAcif4IM/qCv
         KCZrlahgaGWOOtWwD/MyPHM6rLHacI5D97cz6xwlbL/DGjp1ovtQ5qAYNgQzhmO6YZR7
         Nvq9ecSVA6nXUZ/XncK9FfLdl/9G5/ARQUnegDIkFv10d0Lq7BDlnjCjydLd6Uaphy7K
         sbb2gvH3y9P7VwDARnMq92O+azYE2p3h0QTzNFSgBHT+icHKGDpgNuhe/q3+W8pCMOtj
         7qfA==
X-Gm-Message-State: AOJu0YxjcqbNFagseiqsiZTLCu8dKUImoUB+QgbT5c5yba1s+twcZTe5
        vabnKEhQa1I3gx9bkFW4xJ71QDUtPWkf93tdnH/bDJG4T+5i
X-Google-Smtp-Source: AGHT+IF5rFUQ6XquCchCjPKwecVMQ/2VB72LknkKaIRMo7l8WfDPT/9+Bk0rBVjjyCbUnThzQ0kryeR+E//eLf5Rf3Stbcvb1iLW
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:d41:b0:6c3:9f0e:f0c8 with SMTP id
 n1-20020a056a000d4100b006c39f0ef0c8mr450145pfv.3.1699534924356; Thu, 09 Nov
 2023 05:02:04 -0800 (PST)
Date:   Thu, 09 Nov 2023 05:02:04 -0800
In-Reply-To: <tencent_226A496623B3645B9762576606DE537BE305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007323f20609b7cfbb@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/nfc/nci/core.c:1210:30: error: static assertion failed due to requirement '__builtin_types_compatible_p(struct nfc_dev, struct nfc_dev *) || __builtin_types_compatible_p(struct nfc_dev, void)': pointer type mismatch in container_of()


Tested on:

commit:         aea6bf90 Merge tag 'f2fs-for-6.7-rc1' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1750e11f680000

