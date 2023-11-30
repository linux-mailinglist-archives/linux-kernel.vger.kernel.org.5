Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62C27FEB19
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbjK3IqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345001AbjK3IqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:46:20 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E29B2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:46:27 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso34265e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701333985; x=1701938785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wC3vGfw8buwXx/+n8qL73juvjuvtnig2ryfrV/uy7ZQ=;
        b=tXqL4m8TG+Kly8PJVjMO3y7O8GzDkyUrZQPcn7n/ylfmo6y3AG+XPg+yWmeFbIVyez
         yKrTNMaDPOP1ubolcm6Hfb5xqFtEzdEpTEfPutco13iLtHU1Jr9tclwtMo2i5FF/6Y7o
         xEs7w9Qkgk3QHVmwj33gbf/T0LWSwUDmO8U8MdeDvvMPPRkdy86Qv7L3nVO0yMU4nugB
         0udkVQEwE5c/ZbMev2Udh2L33+fNLVeXyMXo4r4bMgmev803n6IiAVF373lvESSpx4Tn
         MevpVPTrjWhtx7pzGybMQo2pkMcIyY3CckEa8iDH3hW/rrVOlb5lZ/S9mYp77sB9nDLt
         s3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701333985; x=1701938785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wC3vGfw8buwXx/+n8qL73juvjuvtnig2ryfrV/uy7ZQ=;
        b=dw8NF6ZNzD6PNxCc5hvj4D+Cj3mI+RoObakp81ZZWn7CU3YtSBaJ5rEy1I010jE2pj
         jGT4dzOs7JDq8gpfpWFGipZm+fluPeW262W/EbV/piU3xqPuDzAcFsTmP57dlnVwZLtt
         C9WX4yxzwnzb4HxwGLy6WB/CR0TzJ3QjDUQkUISWlsjLmKpqCd5o4U4axE/UwJlRtcJG
         X4PalPH0p9WgtejXVu0t7Gzboh7fHZHqo9dvcL4nxKhWrmEwuenuI/0i9QS9nj0VOWU8
         1oPL9Ah7N/LFkCSgw0HaBliqtnrrUqdzpkZsD+892w7l26svgDmDp8bYQaoomad2+tp8
         t2Lg==
X-Gm-Message-State: AOJu0YyxJhNq1H5RYX4agjEF6EKVVKcIYYLgdHfFtDngHQ5RysKOKTUF
        tk1uIo/MpYido1ic1r3CVAI8n7injfmSYYk+XmK8qQ==
X-Google-Smtp-Source: AGHT+IFCUSEg8dN6oCdqKrhoebdwpoM1SqTlSMDHfQfBP47TnasviGUbaB/JoKO5XvBtjrGpyWvK43c278oK7R6mLnw=
X-Received: by 2002:a05:600c:6006:b0:40b:443d:9b78 with SMTP id
 az6-20020a05600c600600b0040b443d9b78mr119836wmb.0.1701333985108; Thu, 30 Nov
 2023 00:46:25 -0800 (PST)
MIME-Version: 1.0
References: <CABOYnLy_ufLD=BWDJct2chXMDYdZK=dNb4cnPYD5xo3WW1YCrw@mail.gmail.com>
In-Reply-To: <CABOYnLy_ufLD=BWDJct2chXMDYdZK=dNb4cnPYD5xo3WW1YCrw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 30 Nov 2023 09:46:14 +0100
Message-ID: <CANn89iKpO35x-mFNgGA1axhn1hrq2HZBOFXo+wkTRPKxCQyQKA@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (3)
To:     xingwei lee <xrivendell7@gmail.com>
Cc:     syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com,
        davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 9:42=E2=80=AFAM xingwei lee <xrivendell7@gmail.com>=
 wrote:
>
> Hello
> I reproduced this bug with repro.txt and repro.c
>
>


Is your syzbot instance ready to accept patches for testing ?

Otherwise, a repro which happens to  work 'by luck' might not work for me.

The bug here is a race condition with rds subsystem being dismantled
at netns dismantle, the 'repro' could be anything really.
