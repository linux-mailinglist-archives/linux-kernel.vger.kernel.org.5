Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F77F7EE24B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjKPOEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjKPOEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:04:13 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BF885
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:03:52 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc9eb5b944so23769695ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:03:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700143432; x=1700748232;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6J5RDtpq0GH3oUpx7KW+J+f3XrNsr+1TfwX+zR5SayA=;
        b=n9fbi7QVdmGdHUBnaYxsgq24HYvIYtbsKcBwDWAERPREkXxk6qTNleg3QMYPVKEE0g
         Agvb7uB66clM90LTzxp+iuXZSfjqepppr31O2eTAVcffYsrm2Q9O99ZQNhrL2i3MrmfK
         LzkRo+sDYGk93BR6Uo1tCDdkjRjuulFOgoo4PMLJ1YiJm2nm1MreG36fKmei5yWw37yI
         Nwu9sg5FCeq3BRUJEu/qVPpE4Xt0E0jMlfuCvSpBq5M2G8Y16fn43YxsTLOzNv6vjiKO
         YXIwY8shhc9r87uMmWu6VTJ3CwXUdJ+9EVZoAOEeupXyJSZI11M8VWJT3cdc//LK0XtH
         gKSQ==
X-Gm-Message-State: AOJu0YzaqmvXGIZYlnh9DN3e6rxUhhxn5VA6zgGzHuOs6CJ52hxURP8R
        4NRXMAyPXeoWlgw9bRZmqDlC7up6k/HaWzQaRHMsShrs1U4d4To=
X-Google-Smtp-Source: AGHT+IEgWhsP5BCnKb4d+YdGUkpyuNNZRZbwK0DPKn5VTDJMnuzV/ujwbKsnRHMyZstYyAENes/q8tEAgQG5pyVxkz006MpfSXf0
MIME-Version: 1.0
X-Received: by 2002:a17:903:330a:b0:1cc:2c44:58f4 with SMTP id
 jk10-20020a170903330a00b001cc2c4458f4mr452312plb.1.1700143417619; Thu, 16 Nov
 2023 06:03:37 -0800 (PST)
Date:   Thu, 16 Nov 2023 06:03:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000797bd1060a457c08@google.com>
Subject: [syzbot] Test on mainline
From:   syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Test on mainline
Author: yuran.pereira@hotmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
