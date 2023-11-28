Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C747FC469
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjK1TrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjK1TrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:47:15 -0500
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D2610F0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:47:21 -0800 (PST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6c415e09b2cso6971834b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701200840; x=1701805640;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnwANXQUYE61osKcBVp2oQJ67yjuVG89cxxDi0cEgg0=;
        b=aneuERx7NQSbIJ+iZlLrTvccXC9026mEoJbzauCEmGxf4EDTsdDjqY/4Ub7fBeXvrA
         zGvbRqzaI3zojkGrGwl+ElgKj+6YmMMkF/EoVJojJevmsPIZ3LiCAGR2GRjBfdd1IUZI
         NkZxrHpxS03u52L9CMrJqLF0ymvIthOJY07O9r6vlzfpgBbagserI8jjiJv6g4EsgVM1
         WoabW448QocxxwuReK2+ujqY+xY5Y9CEPIWgec3TwetmF1K2+PQB+LEzdcFPWBNo6GNZ
         ZphREQ2KwDsiw4GocrJD83i8e1xNSFiQN5cD/V+mQ0gJGgDnLlhXdRbjfTygkTajN3Ej
         +jZQ==
X-Gm-Message-State: AOJu0Yx3K8Fu0kmRGWZNagCHB5HzVd0UrEtOCI/2o8lHWDRQPScW8L4g
        GmX7aUczVejtczkViyySiguYRR4FTLLcQ2yc8XfckimyyhT7D9g=
X-Google-Smtp-Source: AGHT+IGPcJ4pZ4ToZkKxg3vBTtjfjtFQzF+rzGoV1ck0qhbyI4qzULA2BcPypx6B2rD1pOcKuE0kEzk138ig5NNL3XnI/bfscue0
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:989:b0:6cb:d24b:894a with SMTP id
 u9-20020a056a00098900b006cbd24b894amr4471505pfg.3.1701200840656; Tue, 28 Nov
 2023 11:47:20 -0800 (PST)
Date:   Tue, 28 Nov 2023 11:47:20 -0800
In-Reply-To: <000000000000459c6205ea318e35@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc8fe9060b3bafa3@google.com>
Subject: Re: [syzbot] Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in xtSearch
From:   syzbot <syzbot+76a072c2f8a60280bd70@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in xtSearch
Author: dave.kleikamp@oracle.com

#syz fix: jfs: define xtree root and page independently

On 11/25/23 5:21PM, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit a779ed754e52d582b8c0e17959df063108bd0656
> Author: Dave Kleikamp <dave.kleikamp@oracle.com>
> Date:   Thu Oct 5 14:16:14 2023 +0000
> 
>      jfs: define xtree root and page independently
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16eb55af680000
> start commit:   72a85e2b0a1e Merge tag 'spi-fix-v6.2-rc1' of git://git.ker..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4e2d7bfa2d6d5a76
> dashboard link: https://syzkaller.appspot.com/bug?extid=76a072c2f8a60280bd70
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15802088480000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: jfs: define xtree root and page independently
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
