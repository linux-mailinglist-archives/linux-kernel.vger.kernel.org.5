Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54F27DFB9C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345561AbjKBUhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKBUht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:37:49 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA67B181
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 13:37:46 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b2e7b41beaso2779081b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 13:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698957466; x=1699562266;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJCtXH4q4XPI5Ko6an0XHzHIudOoGgcTkkYbVXWT6vk=;
        b=aYuqorUu0gt3v781BnsqTpH6HEXOBLFt/u7//cRqSyhvsEOOcND+qv3QrVGdPzBKcR
         uNERgMikJk7Qzg9qPICUlq2Hi+atqvSPw1ZLC5CxL/MQjbsvmlMGDOH6B+1mI3qBWXQe
         ciP2Q1MtXhP8uol6s0X24cIlEG4Wmr8/ULkua4c59j/TEthhVgMjFVMaM2ZFYuKit7gy
         WotpGlrFYTCDEm5UUtF7Z9/l1ViIRch9OkMbGU0JUlwhOIg/tgjp7s/Ajyp/fwlIfZC8
         zZTSF5tLa1OxBNx9QLYw4eI/nWIlJobey+NOAlARxn3XElTsA0Msqoa34vyPr7eAssWv
         1Rww==
X-Gm-Message-State: AOJu0Yz7YcGjJd9WiOo/jOU0Ey8xAgjjj0XlK/GiDZ36d8F1RXQCaA3i
        aON6xoPCMNjcRzjda5AxgAktaFIRaxCf/tVXVFoVYbbhylwFHDc=
X-Google-Smtp-Source: AGHT+IEmuRKPYPHwqDewaTyH0C0saOJfcgyFCyl6PAssCZWc4hbocqydt9aQv2W3J7yW3Cj15wBQbHpPW0ipEVol0bYBQqkVapot
MIME-Version: 1.0
X-Received: by 2002:a05:6808:9b2:b0:3b2:e56d:da26 with SMTP id
 e18-20020a05680809b200b003b2e56dda26mr194052oig.4.1698957466242; Thu, 02 Nov
 2023 13:37:46 -0700 (PDT)
Date:   Thu, 02 Nov 2023 13:37:46 -0700
In-Reply-To: <00000000000043c9a105ef4cccf7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004394fd0609315c32@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in hfs_brec_find
From:   syzbot <syzbot+5ce571007a695806e949@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
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

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in hfs_brec_find
Author: jeremy@jcline.org

#syz test
