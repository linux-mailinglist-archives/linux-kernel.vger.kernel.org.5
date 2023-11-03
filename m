Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30F47E013D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjKCH0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjKCH0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:26:09 -0400
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819BB184
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 00:26:03 -0700 (PDT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-58404a66c5aso2191239eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 00:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698996362; x=1699601162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQy/L3NJ43bPpuRWpTexzd1bHwKfYNaEMdrMMg5oP+A=;
        b=Ff3etQ2sO/fxBDEsz6BqcNN2exTGqz2h3dfYDIxggtTDgYPPhEhl0kyQ7FwMct9hiU
         tdjLYvnQkYWFIml654QedVSIZVlUsCcDh+/VCP/fNFJ5HH0pEL2goAcnOuE89JblAExJ
         +FtsW9rXl4CgU7XhSm34WCeYmMj6ZttozU1fewC+tg5SNgCBhzmbUBZBo8DT1d9+rv0G
         fsQW3gHZ7aNAHfDLXsDwy4WeEspI5d7FjOXbIYM75RgXYRNqwOUpEmtdB32GuKu7bWL2
         fuNv799cGXSthNAsyXP8c9oKFySDwSW/8isRmF+lnSWWlvhLraFVBU13CNtSlsey73TT
         W4+w==
X-Gm-Message-State: AOJu0YzxHsF8kkydw1LEVKmqwBaDaW1SkWAigURgbwr7Y9ecapf6uyuj
        kXpcxoeRRVztsROHo6CU5itkZKmhjfaequnNT/k8lMxFEtTB
X-Google-Smtp-Source: AGHT+IFUb5yBA3qkfD1TaH4DzRXvyF5Mq1kw6958qJ6Pyt5jquR0eY8IzcZ5BEoLWDQCVs6aSror8y1OXsH1JgogsIIfevVavzlH
MIME-Version: 1.0
X-Received: by 2002:a05:6871:b310:b0:1f0:60db:331b with SMTP id
 bd16-20020a056871b31000b001f060db331bmr1079929oac.5.1698996362504; Fri, 03
 Nov 2023 00:26:02 -0700 (PDT)
Date:   Fri, 03 Nov 2023 00:26:02 -0700
In-Reply-To: <12128c3a-3a38-ac09-577f-320e811f421f@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9721406093a6a24@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diWrite
From:   syzbot <syzbot+c1056fdfe414463fdb33@syzkaller.appspotmail.com>
To:     ghandatmanas@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/jfs/jfs_imap.c:752:16: error: expected ';' after return statement


Tested on:

commit:         8f6f76a6 Merge tag 'mm-nonmm-stable-2023-11-02-14-08' ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=c1056fdfe414463fdb33
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f5e627680000

