Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684177F6385
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjKWQEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjKWQEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:04:22 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCC7D67
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:04:29 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2855b566683so732344a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700755469; x=1701360269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nBMYi0DQuFagtnZx4pcIi3eC9Jxr33rON8i5DT6+5o=;
        b=JYXcVq7FvVQ7sY3wGSrEo3/CdoR7aZDJkAUNjfbBYRyhIsyc643i+sy7Az2jKND8XX
         V761kYg/4cB/zZOtltu1pquF48IaMSsekQSOTWx1nU7iygCpVYcW12tYb9i5wMXzZ0OR
         GWz6THBcwvqsYlxgDODyZc6S0vftzUjXv5SEKEsWVvcIdI2WQOPviRHdbyF7KnAS+jx5
         +i46wqh5+8mkcd2XjrpyhEJHxTCoOVc7Yl3vHHKGdAIzEAPdvq4zCzd84CBod9vUO2X8
         XAuXY98L1u1nuvk0K49iAEJI5TIw5Zrq9xJrRFCZ+HHHhCpcaAh70cFz4X3IIfQHrAng
         Tydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700755469; x=1701360269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nBMYi0DQuFagtnZx4pcIi3eC9Jxr33rON8i5DT6+5o=;
        b=D2IvYscogJdBVWh8P4I5JcexfeAHitlO2G7G4codq43vFdRjAShfyNYzodunK0bs+X
         ZBt6MYAxyC48UdQDe++UOwf6v9nPvmCCn4DCV+A4rEq2+bvHmq8AXerFJRuHsFjjrPL5
         mDCnONAs6E+w3tqJ+STpqth08itvu+NrPcRuTBt6OPY0srazLu89WOepvI6VBpTS6Y7k
         YW7QHGqKYLsxw3WUNvbPBwL7S4FNOoeLK24CvjpTch25mTlDROZxIsgA19cupDlPIzAu
         sMxVmCmFI+3XIjAuTMTyNzUkL3IBmiGK7x2TFh3F7tjO6i8m4BdAT09p9y56hPx4ue0W
         QmOg==
X-Gm-Message-State: AOJu0Yx7OJG/4gGjtEBcLsiVGgkS4iSOVYOAvBhVbIlwHj+0C4NHO4Zz
        UD+oUK0sATCb7zSqTVuSr1HzLERP0mNcNWLVxUw=
X-Google-Smtp-Source: AGHT+IELrLprCSfFy6ldKP5CNjX12ykqpJOPuv3JZvYvGdgFBhURFR37CmAyCcv5mXBQTvoPa2KWCe0M2Shro7gi0qs=
X-Received: by 2002:a17:90b:3b51:b0:280:a002:be85 with SMTP id
 ot17-20020a17090b3b5100b00280a002be85mr4198623pjb.20.1700755468832; Thu, 23
 Nov 2023 08:04:28 -0800 (PST)
MIME-Version: 1.0
References: <VI1P193MB0752675D6E0A2D16CE656F8299BAA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <VI1P193MB0752282E559B37F12EB7982599B9A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P193MB0752282E559B37F12EB7982599B9A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 23 Nov 2023 17:04:17 +0100
Message-ID: <CA+fCnZdTo0giqBjukHYpwjGL97NnVtmenHkg1YBi1Su+DoZf4g@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: Improve free meta storage in Generic KASAN
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
        vincenzo.frascino@arm.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 11:43=E2=80=AFAM Juntong Deng <juntong.deng@outlook=
.com> wrote:
>
> Can someone help to apply the new version of the patch to linux-next?
> to replace the buggy version of the patch.

It should appear there naturally once Andrew picks it up into the mm
tree. It's the holiday time right now, so I would expect this will
happen in a few days.
