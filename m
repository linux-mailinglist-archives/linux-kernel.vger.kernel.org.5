Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113937F0FFC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjKTKNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjKTKNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:13:08 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939DB9F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:13:04 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c1b986082eso4552015a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700475184; x=1701079984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+CEsx8h1YWhzLlneZ3uHmq8J6fuGvN9695Xd7yq2zY=;
        b=ipG/N0CRPSZmcUp2gutTLPyThg42QC62+tdEszwK4r9imvh18y7hiGLyYhEIdAoQRU
         mvZEiBPFqYA0/jeA0MSH8pEyWgvqeeSXeCNtsK7JQptdBeZaafQUzG+rMwHhK7CrBcH7
         88DzYKvNXp4uK58hIfZrA/Mi8izHZTEuDZxwlFxQJPn98GlqBuBpG2wkQ4gOyPWh+yOh
         tAAZdAplfyef1GAmC2lvUlkuSe6cZ224UrrOu8zza20KhesIpnaoqkoBOE6CIm2CVLhR
         h+OCziDYVH57q4jAnRlEe35yyovJjJ7jBWVkNiKj15UtyLcoxNktEVPvokG0VODPwovK
         FnwQ==
X-Gm-Message-State: AOJu0Yw+aZNI6xkv3hc82sN8s8mW36Gl2dTJNvxGOX+lCC1FUqCcDuoF
        L/5lz11kuKzmj4PNBmMIYJ9jAsLurEKzTlRbFM9LgiJrcTmIRDo=
X-Google-Smtp-Source: AGHT+IGGW7paAjEEPwVBlrwO3XRO889XSgcrLNthPgLhfZp7jkFQHMOmGBaFQJ/uuws1PgSg69H7LP5VjAPSBvRqBfqNs/gacVKO
MIME-Version: 1.0
X-Received: by 2002:a63:1b5f:0:b0:5c2:3f57:8f38 with SMTP id
 b31-20020a631b5f000000b005c23f578f38mr596098pgm.12.1700475184083; Mon, 20 Nov
 2023 02:13:04 -0800 (PST)
Date:   Mon, 20 Nov 2023 02:13:03 -0800
In-Reply-To: <476cfe2b-4270-12ef-736e-11c2099d6cad@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004bf830060a92bb19@google.com>
Subject: Re: [syzbot] [net?] [nfc?] memory leak in skb_copy (2)
From:   syzbot <syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, phind.uet@gmail.com,
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

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/nfc/virtual_ncidev.c
patch: **** unexpected end of file in patch



Tested on:

commit:         5a82d69d Add linux-next specific files for 20231120
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecfdf78a410c834
dashboard link: https://syzkaller.appspot.com/bug?extid=6eb09d75211863f15e3e
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=104f58bf680000

