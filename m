Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650DE7F4566
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344009AbjKVMIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343932AbjKVMIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:08:23 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F26B197
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:08:18 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc252cbde2so84278545ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700654898; x=1701259698;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3MCYUijz1PXmmrFbnYvUcWANdHMheRECQhPlEaS9Vo=;
        b=aK6JOs98IbfOiGTm+R5/5XR3/ZTK3BLh1KU/ZTFcF8T6XZE7FUiLWC7gStKhhXk+uF
         YAer3GUo8mRO806HoqbfEYnnHDxjY43P7H9TaTwdpQCcrIovymySb5WZy3o/NapxygNd
         S821EhgmjYwA/GfrqBK5+y3h6Jy3VnqB9DHlwQ4rNuzImyYIEiNhCnHuIbO7YXBEqj6x
         R45CoSrph/3GkEQEYv8AjPFq1g3BE1sS1RAUEjVid4O1noXWDlrinS+tX8mleeH/1tif
         v3G7HgBzkPYZOuWaADYvoNdee7WPxW+Rty8XcKeu1PRfpnMjDa3mPnKHHy+/bppgETTu
         5daQ==
X-Gm-Message-State: AOJu0YyG2aLKuBr+kzLMuS7gCmbmU8N/1zCG4Plw4wgJ4Ole1mCzILtp
        SYP4Ns7NpcH6KAY//V9CoccaDw19R63olrYJ8JZPYFj+WrFivKA=
X-Google-Smtp-Source: AGHT+IGTjO5vg0Ubw7G+5ED7UVRk9KbPgV9qb0cKbjYwiwrDgxI4CuDtS4T38lkOgTGIeVKohMVkwkEkqhOyEkCgITg2DZVrYRRq
MIME-Version: 1.0
X-Received: by 2002:a17:902:f809:b0:1cf:6a75:e891 with SMTP id
 ix9-20020a170902f80900b001cf6a75e891mr525337plb.3.1700654897970; Wed, 22 Nov
 2023 04:08:17 -0800 (PST)
Date:   Wed, 22 Nov 2023 04:08:17 -0800
In-Reply-To: <000000000000a654800596d61d1d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001456bf060abc932a@google.com>
Subject: Re: [syzbot] WARNING in bcm5974_start_traffic/usb_submit_urb
From:   syzbot <syzbot+348331f63b034f89b622@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
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
linux-kernel@vger.kernel.org.

***

Subject: WARNING in bcm5974_start_traffic/usb_submit_urb
Author: javier.carrasco.cruz@gmail.com

#syz test
