Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28E27A082B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbjINO5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240573AbjINO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:57:44 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ECF1FDC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:57:40 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1d63b88c1edso758517fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694703459; x=1695308259;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BH70nnxiwK5vo5sewBJs0bfoYU95nMYma9coiDLvPM=;
        b=SsRzLIskhsSdF0tO/HAStYhFvBhn9OUsHcnA80NN1aS3qmiZt/KTtAs7fWQ/7zT22e
         P3u3IiztFMvM4WS1BNo63a//alilaZfdiFBmmcvFPunjvih5acAGi5wxgrKZTHQUaUwO
         TF1xqvKftBhB6Q7lppBXG9mGvRVXhiVQI8jbF4Fosa9NC+QxyKKbEjw/fBnGZ2Z+W3WV
         /Ls8+dl4F/jVhwIlkPWiaZYveAhbKZrIEEtLPJDba40LIS45n2jMN3GTzL4Bk1em8MMl
         FLuIGiSNes4NT0ygydlPpvR/jmusYIcSHi9Wndv8FWPXgWmhpVDaS1scmlvsLwkpHwA0
         ef1g==
X-Gm-Message-State: AOJu0Yy3LLlByDpUhigsDh9iehwy5t7BGXKzhoDAp0DfspWZcxRwcxwo
        t78qOJuMyC2Ryskf4MC0c/HalhHt2Ikn8tkD7GBFEZD2Udpl
X-Google-Smtp-Source: AGHT+IHc/PtiM1JPXAN+9FbP+F9yw1S17e0H4EqpDFoAOAqj6be7FNhYkofWNIPXySut/XfYV4M/xguNm+iInFqsDT+oPHxE218O
MIME-Version: 1.0
X-Received: by 2002:a05:6870:e6ce:b0:1c8:e107:4193 with SMTP id
 s14-20020a056870e6ce00b001c8e1074193mr1952817oak.3.1694703459517; Thu, 14 Sep
 2023 07:57:39 -0700 (PDT)
Date:   Thu, 14 Sep 2023 07:57:39 -0700
In-Reply-To: <d27afdc7-7251-61b0-2311-ba2e27e73682@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b449cf060552e550@google.com>
Subject: Re: [syzbot] [io-uring?] UBSAN: array-index-out-of-bounds in io_setup_async_msg
From:   syzbot <syzbot+a4c6e5ef999b68b26ed1@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://github.com/isilence/linux.git/netmsg-init: failed to run ["git" "fetch" "--force" "2335d1373be159a02254ea7a962dfc5bc7a540d3" "netmsg-init"]: exit status 128
fatal: couldn't find remote ref netmsg-init



Tested on:

commit:         [unknown 
git tree:       https://github.com/isilence/linux.git netmsg-init
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4894cf58531f
dashboard link: https://syzkaller.appspot.com/bug?extid=a4c6e5ef999b68b26ed1
compiler:       

Note: no patches were applied.
