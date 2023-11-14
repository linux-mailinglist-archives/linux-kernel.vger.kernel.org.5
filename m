Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200C47EB3F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjKNPnQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Nov 2023 10:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbjKNPnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:43:14 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29B0181
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:43:11 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6bcefd3b248so7569650b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976591; x=1700581391;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIYWJN8lpILSyfiEcNiBTbqHzMRwjY0acvjNOZwjQY4=;
        b=rifT6X4kPGyibSYQ7sAdHpoX+xm/TLG3t9fohpcglMem3DzmUQE2tqQ5ZcrpoeX/xl
         qNPiok5SsZ9WDTXOdhFsgZkaGtrPGheQ0ZLmpy/uPDZuhGm8ceGA6YB6XTsPt0QaK4pi
         Y+fDI3v4IjxwpC0ufmRqqZ5pHr/IeYg9FUze1xxt8pLF1PbQIDPwyY0MjWM+OcboICHS
         mCa/oUv67JuaVFNSoIwXVP37YezmAVjBX8dTWIq/GngC8Ecwup6+GXou4LhTfGJ++r9H
         nUGXeEeGuOjCowHWyQXXOXDOi7+Pu88DZF6W0EMma4/FWP9wgv+PalwOw9r9MefA6hsJ
         Dscw==
X-Gm-Message-State: AOJu0Yyh27DPSMajWjABTkkucPheKr181oYXv545meQZDQd1IQwIutqb
        cz3UqcYKhwECAY4LL0/wUD4NF/deu6AyEPGbyzKaDWmB+kZy01A=
X-Google-Smtp-Source: AGHT+IGHCMsn3fLfPEjy3LxjO2yR11ePKGBi8RSKdaiZujGa29ayKjCWAIiesOH9JLX2Gm7BXSpqLU7HfwMAxDmJRI1Gxm8fwau3
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:6c82:b0:6c3:33c6:a4d3 with SMTP id
 jc2-20020a056a006c8200b006c333c6a4d3mr2980796pfb.1.1699976591346; Tue, 14 Nov
 2023 07:43:11 -0800 (PST)
Date:   Tue, 14 Nov 2023 07:43:11 -0800
In-Reply-To: <0000000000005e44550608a0806c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da9a0a060a1ea4f8@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in __pte_offset_map_lock
From:   syzbot <syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: BUG: unable to handle kernel paging request in __pte_offset_map_lock
Author: jose.pekkarinen@foxhound.fi


#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
03d1179639b1515dce087335c1fb5c962908683b

     José Pekkarinen.
