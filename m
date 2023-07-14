Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E687536C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjGNJj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjGNJjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:39:25 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B320910EA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:39:22 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-39ecef7a101so2677586b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689327562; x=1691919562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rkH2baniJscfH3sCpFw43dt5egSNBgguTianiqLM64=;
        b=ML8akIEqtdU8zOMU61u2jDS5S04jqru+4/5p4PkLVcbu8Fe69lqhoHl/5+l6g+D7J6
         2dDPMvKu/4iX61sAL2uNATdKotfO9HV03YM/BsyOD1rvf9WuzKZ/lXZnWvACwdg6hUnr
         hWHuNj7PadlXFacw1rQtzgdkIUAgXUCQNmyLiCWFVv3W+NncZmkKeF63QOnHqzEjtXUi
         LPUsAzhEdLvm5De7Ng7BkKm+9uD7TEBQRpGyc+uR0UT2AugILRALb4BNuHwczV8zxthw
         k1rHnch7n5ezN+Mq6OT30SORillh92Kp2sd23ovI7Nm1HGi+PcmEqZmnCFhKcT6ZPyvl
         pA3w==
X-Gm-Message-State: ABy/qLYG/Daxja7CCOQnSGmQ/H7qxHGZXrWbzOtFXcrFMUPGFJW/MlDu
        ufnaskpJliC5KXGtQ1dzIMWVg56Qg1pl5Qu9aUa+pmzqY4uf
X-Google-Smtp-Source: APBJJlH2iq/qPy0eOiIw7q1AvFlFvCxYUc0DoRCBd7qefgsoqoVTBLX2fWpEmp2Fs/UcMV5N6GuaGyf56WTJViS26bxZkiHrq9Fg
MIME-Version: 1.0
X-Received: by 2002:a05:6808:10d1:b0:3a1:d419:9c64 with SMTP id
 s17-20020a05680810d100b003a1d4199c64mr6152357ois.5.1689327562033; Fri, 14 Jul
 2023 02:39:22 -0700 (PDT)
Date:   Fri, 14 Jul 2023 02:39:21 -0700
In-Reply-To: <CALm+0cVa0H3BOD1Q6x5jOtAzQqnpQR1ju+9HhBS893mHkdQnpw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e91db06006f39e8@google.com>
Subject: Re: [syzbot] [usb?] memory leak in raw_open
From:   syzbot <syzbot+feb045d335c1fdde5bf7@syzkaller.appspotmail.com>
To:     andreyknvl@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        qiang.zhang1211@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=118488f8a80000

