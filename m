Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D4675324D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjGNGzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjGNGzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:55:44 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10911FC9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:55:42 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b75153caabso2533818a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689317742; x=1691909742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRxM1ic75/5PISaRQM3Zs6NAL5LM0bTj1rOpZijgN4Y=;
        b=EK/M7OW9iJ24qdcI9M8aIYmjKrBPzAtBZ0h5pdCDKi83uCdjvCcfT6qYqShPHDKEMx
         Q0htdi66Pu21qvf+xRMIcKx5JO1umO5n/PFMB4vZ7Jz6vYz91qBaKBHCXxCMpBPAQ4FW
         Jh0HhIZbE96z/BLWR3R28H6mhsSBoU+kwyyfRDctmoD/NfrQ8ucKBfPJkzCpLGn6YIvZ
         /DurV/jVLbexzeCx+quMIw0tv9oQ8n0GhRJ3nib8zMNvvqEJOlZJyThLZD3PXkCCO2J0
         tZ1nTca404qdyVgSq0NlamkVy4GtL+FY7gU59Dg6dl3bjVLH6+jEC/sIQbaLjTbFq7jA
         9L1Q==
X-Gm-Message-State: ABy/qLaUVnBu+9q8x9AmPDZWl6Y+HLrTrMqbQwlPKPDFWhOlCGtLVUBv
        EaahZgCi09RReJZeuC75AYkCt6Kpj5rtIAUns8rrx3tq7LOQ
X-Google-Smtp-Source: APBJJlGSZXo0hUPRjLJVOTelbgDqRovbf4jU5qkU76ZsEms/mBxYXaATIacI3TIKgtacnPBlsB3jRLOCNWk1+Mu5sZAkXl2NDoCz
MIME-Version: 1.0
X-Received: by 2002:a05:6870:8c1a:b0:1aa:22cd:8ad1 with SMTP id
 ec26-20020a0568708c1a00b001aa22cd8ad1mr3530441oab.11.1689317742266; Thu, 13
 Jul 2023 23:55:42 -0700 (PDT)
Date:   Thu, 13 Jul 2023 23:55:42 -0700
In-Reply-To: <CALm+0cWBh+4GMzfRKR6rE4H4JR5aRW_m1KVdTLZLJuQyE_smRg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0ce0206006cef79@google.com>
Subject: Re: [syzbot] [usb?] memory leak in raw_open
From:   syzbot <syzbot+feb045d335c1fdde5bf7@syzkaller.appspotmail.com>
To:     andreyknvl@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        qiang.zhang1211@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/usb/gadget/legacy/raw_gadget.c
patch: **** unexpected end of file in patch



Tested on:

commit:         7c2878be Add linux-next specific files for 20230714
git tree:       linux-next
dashboard link: https://syzkaller.appspot.com/bug?extid=feb045d335c1fdde5bf7
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14266bcca80000

