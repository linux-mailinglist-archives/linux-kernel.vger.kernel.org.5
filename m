Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092667F0F39
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjKTJkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTJkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:40:01 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97FEA7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:39:58 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ce5b6ec63cso35435625ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700473198; x=1701077998;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/A5ScQFrDKiACUkI4vMyJpYuKiUK2FaWjgu2WFDF3+Q=;
        b=a3V8tUFu5XdgpdDDA9BSM2Hx+tbnnMfrOvf/eSYWOsJVR8oUEv5TA+X9E0ElpLh8cO
         /sUMCYMb5IQTNtc7PHSoqBW8GUaFLwteKI2y2ob5Q37i8YQA3gt5xBJP6oHE75zdG15i
         urLlYo1GzNLC2MtEU2tJN4YupLSZ/N7jMJQiMy0vAMgygwRGXTz2pydJIllSfyc33fYl
         jO71jN0g65mZYS2rACMm+VMwwR41W5ifgwJ1prR4vhdx9Id5oVWtW4RVMu8hLy/eElZp
         xg8p3pEySZhl/HqpCzBfrNt788UL2ATv5UEcJeTl+dxMVo77dz6+UpdJ36oHLyZWmtYr
         OrRQ==
X-Gm-Message-State: AOJu0YwmGBlJgbcfMjAt0a+ymbrftSr8W2uWlwEpqKTc6N0YXG1tNvaV
        JmGf1S6baMy3PCnube2pIiDvDzIiBVy+uJFrzlouHplbmh/Xr1c=
X-Google-Smtp-Source: AGHT+IFFZJes0cYM44fR5eiqVI/bx6oy198ylSX/2kZRcqhxJ+kGnlAa8g5eWNvfZIDVOFBbgsGe24wXCsU2WHPDjMOXHuF8U0ei
MIME-Version: 1.0
X-Received: by 2002:a17:902:728d:b0:1ca:8e79:53b7 with SMTP id
 d13-20020a170902728d00b001ca8e7953b7mr1993396pll.9.1700473198553; Mon, 20 Nov
 2023 01:39:58 -0800 (PST)
Date:   Mon, 20 Nov 2023 01:39:58 -0800
In-Reply-To: <00000000000075472b06007df4fb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f33199060a9244fd@google.com>
Subject: Re: [syzbot] Re: [syzbot] [nfc?] memory leak in skb_copy (2)
From:   syzbot <syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [nfc?] memory leak in skb_copy (2)
Author: phind.uet@gmail.com

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
