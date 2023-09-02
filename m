Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87F079055A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 07:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351614AbjIBFwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 01:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351582AbjIBFwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 01:52:14 -0400
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC33198A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 22:51:43 -0700 (PDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26b752bc74fso2948995a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 22:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693633894; x=1694238694;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVATVoBrfzdV7ijJq9TyC6Ht5BBCJVhtlVkBprhYRqw=;
        b=eEUk4VNu+UCrS1UE6sIWy4DABhY0+2FF3egdaVJ1wnhB8Ls06fTaN3Vs9ElJ+ns2Hc
         M2IygPWAZ3dygW4KYGHY3qU1hV4BGp3ul5aMSuhLiaJBbHRtmoQ1qb+sPOTzc+0+Ofbs
         y+YTx9UEYVwk3LlhKrLaWTSy+6hmy7DCKGIdHQWcMMMAHu8uxRPNzfrkUjb9sf5gX1fX
         Wbo2Td78maCO3DMdE4Yfv8mPEmea0gpArNy4jNRMO0xE0K5bU1X1HrE0QV9uhErJQ+eT
         mVkiAG/V4GbMR3onLOM1cDqAnJnZH294Hv+rmbTOKZlTd3t8zJDuMCSPsYWzIUqTj5TY
         bgdg==
X-Gm-Message-State: AOJu0YxTiBhL+4cljEYmPTTHQQWUOxvcrLcr9OvWTFw8n+f0/+H2vPW5
        PedwPISmN5V0CWJ0nFR20yd/vHXuOnxYYN8sLVdnKmylPydq
X-Google-Smtp-Source: AGHT+IENaY8Bc1DczGIHHki5oiWTPbLY55ybIBjWXDUK2qeNrRw4LbjqLe6AFbzMumqm4Vd5WzRis9viga3Ra7wM6rlLZGGoFytl
MIME-Version: 1.0
X-Received: by 2002:a17:90a:9741:b0:26b:229d:6c8 with SMTP id
 i1-20020a17090a974100b0026b229d06c8mr1020905pjw.3.1693633894017; Fri, 01 Sep
 2023 22:51:34 -0700 (PDT)
Date:   Fri, 01 Sep 2023 22:51:33 -0700
In-Reply-To: <20230902051306.5076-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1ef37060459de79@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in tty_register_device_attr
From:   syzbot <syzbot+85792f3143e6271d2c97@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+85792f3143e6271d2c97@syzkaller.appspotmail.com

Tested on:

commit:         2ee82481 Add linux-next specific files for 20230828
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=159eb870680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e82a7781f9208c0d
dashboard link: https://syzkaller.appspot.com/bug?extid=85792f3143e6271d2c97
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f39898680000

Note: testing is done by a robot and is best-effort only.
