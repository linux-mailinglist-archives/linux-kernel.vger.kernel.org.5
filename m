Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626EE75A2B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjGSXR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGSXR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:17:27 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E0A1FF3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:17:26 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1b73ae7dedfso323501fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689808646; x=1692400646;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1T8DF+F7vOu3DoEylx/F408HNedc0v0qwNsF2STayI=;
        b=ffJaWFaIaMEUQ/X6FrCGX3XtSnlTzgn5sqsVK4l5lhLPR0riHtAG38E2G0jjEV+egh
         /Ykr1t39ePnF6YqBbsoVDRzHuRGa/uqZ/tFeTLsuQ/lCyJam653AJblodUxo30+OHy/+
         dBP/lNEQARBG5Y3TiSEG0HAjTvJsmdhEQgVr9c55ssLK8qwJMnPPREifPWij3OsCD2pb
         1jMxnmK0HFQg0BUaYFBST3oaf2cgDSEwXGpAV4XD9qnYBB8MLETKG3OZ3RET3yireaER
         SO899bl857KOzZ+jaxAasvcQPoFSq28KdPpaX22G5R6sTLB9Xglvx28F/gYF2Saw7ZeZ
         /00w==
X-Gm-Message-State: ABy/qLZSqlyCW15yCKXpb1FiWNgY/kvtd1AFjtWFDJ1Pr4IkZP0TaFgB
        qxJz2OubXTmKGbs8jYUnUddn4EPVa948a16SqL+r7QVN0sDu
X-Google-Smtp-Source: APBJJlHMdLIXEL5Z8pdzgF175WqoG6dc7Y9NRR89CqmCQgk0XwW4ggjoNBaRaxQUix9DhPrlC4MibSaHlLDSHIOP015wMq4PiWAd
MIME-Version: 1.0
X-Received: by 2002:a05:6870:8c32:b0:1b0:e98:1637 with SMTP id
 ec50-20020a0568708c3200b001b00e981637mr4261353oab.10.1689808645863; Wed, 19
 Jul 2023 16:17:25 -0700 (PDT)
Date:   Wed, 19 Jul 2023 16:17:25 -0700
In-Reply-To: <566ffabfcc5a7de71205ec4e97245ca2@disroot.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001341b80600df3c7a@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfsplus_show_options
From:   syzbot <syzbot+98d3ceb7e01269e7bf4f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sel4@disroot.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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
checking file include/linux/fortify-string.h
patch: **** unexpected end of file in patch



Tested on:

commit:         aeba4568 Add linux-next specific files for 20230718
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
dashboard link: https://syzkaller.appspot.com/bug?extid=98d3ceb7e01269e7bf4f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=123c341aa80000

