Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE3577D5D4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbjHOWQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjHOWQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:16:15 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19071FEE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:16:14 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7679ea01e16so457190085a.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692137774; x=1692742574;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qv6BJq2VuOIBKm2R5SQfyXniDVD4bBxdFB+ZKjbHdTY=;
        b=LVd86Uah0lEj1PtGQRA63Mar2+vnyaBCMLo95m7G2a80hYPIM6F8hCe/XBEQD5uP0A
         omkGtYBrLHda4rr7P3hWHsO/VkYlB+IPkAL3gmC216Q3KaTmkt0wKZBbBRgwNmyh7Qwd
         xUQjLaKsc+rDzFgpTh2z8NuKvZbxQcGknhTHJVMCwaLZlAy21NPQXE+r+1pPng/NnL4y
         XPmEUOyctuLQBSmjuZt3F6xBH/PQ72VZNBgf3YnOMqHGi75aZqBf+XkcVCptvq9N9qe9
         c8VM4W3GFWUkxZAVnRdizQS+7Hm62vT++HD/9C6mkVaratGy6cyESuSAyLgc+74cqaeb
         b1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692137774; x=1692742574;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qv6BJq2VuOIBKm2R5SQfyXniDVD4bBxdFB+ZKjbHdTY=;
        b=hHH4LSfqDuuhfA+igTrSwJ6reAVi0lgD8ADboQP320jZyAOxC6r7htPxfvcWtH3RXJ
         yv8VXV1IjQ0mqkfcC74QtQ8DLdRZJvv2ouWQxeyAZWFZvHTbWup5gI0lyBYPdH6lkhPk
         O8iMvPk8FPifc+Z9S+svWGvJ0Z/3wXYb5pYLe1f4Un/vOXUB1WD29XnoCkcLT4+Cv1Qt
         rfxD4SJa+NM5CCmjyGyByssthpNOt+bEXNOBb/mIghBD3A/gLrpCn1h/fToESD/yBZDq
         B2XF/jhU5Jq4nE2RLk9U3ciOTV+XmTryaNVzyXZVMFwDeo/VM/2f3lApFgbVdxZbL2/K
         blJg==
X-Gm-Message-State: AOJu0Yx2uUGZoB2iPeq1ajQJzDxh1PM6EE9MY8oqQgD/pL0DhcDNux9e
        JZ1BFjXGXo9A9F3xfs0PG1L6
X-Google-Smtp-Source: AGHT+IHwX9/8dy3LUKS5wQU3/+IHRSlM6nubbbJWfnEyOGWPp/bSlpdyUzvrF6Itvv41IIqXUk62hg==
X-Received: by 2002:a05:620a:4d9:b0:76c:c636:4772 with SMTP id 25-20020a05620a04d900b0076cc6364772mr179079qks.65.1692137774065;
        Tue, 15 Aug 2023 15:16:14 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id o13-20020ae9f50d000000b00767cd764ecfsm4060074qkg.33.2023.08.15.15.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:16:13 -0700 (PDT)
Date:   Tue, 15 Aug 2023 18:16:13 -0400
Message-ID: <2d9f6af1443608a4e5ccfffb0ae15e14.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>, eparis@redhat.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v1] kernel: Moves trailing statements to next line
References: <20230815204751.52481-1-atulpant.linux@gmail.com>
In-Reply-To: <20230815204751.52481-1-atulpant.linux@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 15, 2023 Atul Kumar Pant <atulpant.linux@gmail.com> wrote:
> 
> Fixes following checkpatch.pl issue:
> ERROR: trailing statements should be on next line
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>  kernel/audit.c       | 3 ++-
>  kernel/auditfilter.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Changed the subject line to "audit: move trailing statements to next
line", otherwise it looked fine.  Merged into audit/next.

--
paul-moore.com
