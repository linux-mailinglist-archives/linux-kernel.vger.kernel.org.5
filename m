Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DABF78FBC5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348902AbjIAK30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbjIAK3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:29:24 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A020E77
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 03:29:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5007f3d3235so3302972e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 03:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693564158; x=1694168958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+t8kfqP7SRFvrY+4t1ktFBHXc2PGv/4ttfq6M5urQM=;
        b=gKfXS7OyFsqHMQFCYvu+fU3g1pzeGsb/sPgEIojaINoJUn0X8t+W+4pRWAlfNkcTzL
         vAnLLoPBFfR6mN3miZpsyg5LcTjtme39g04LDJaigkh1/mSDOAeC2i+hzF68dYHSm0TL
         lk3APm5jzs8qNZINGSnaEjBrN8M6eDMi903tz/hCLZ26eHy1oUBl7nzKL7BIxfK2h5IZ
         U8OzzJiI9rqdQfsWeqN+HYZinQPeky4qyFaLn8J1+ChRSxXxVPYa33WgCz6ugg/E7qUj
         QI5t+BkzXi4eGI5kBkYDAl2JP+ri5ugSTXYAXtNjj4+FFX3WfINJmMt1WgHPV+q/iKkl
         ttkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693564158; x=1694168958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+t8kfqP7SRFvrY+4t1ktFBHXc2PGv/4ttfq6M5urQM=;
        b=LdPNCnY91sIHTzpG3XIVRwLWwzwez5DHAPmlYYfqBmOanHOk8gi0BFnC+7SyPlIOAN
         zyHHPeSsbHVpcvywv5Is81TzrXYTecZuGd5+D2Mn2h1oD3MSLCoQ5Oy6MpzZf3+DKD4K
         aIDE+jgUAyeI8gTDBF9xzo0YrtSqyv+AJq9VXYo5hanS+PjO1fVKgqslcIRi0+bImnVn
         EbIc2d3QSihjq9sSIkkj6qiP6BEmAq8fY0Sbx3xT0dpN5bvRPl/iww3z1oWILuC7TYSl
         kHDDCpk+MOCLQoJeBmTs4zMsq4yQD4hjG5vr9gwVDaop3D4IgjZOKdhiF75T8l1/9F6O
         67Hg==
X-Gm-Message-State: AOJu0YxEZebJ3+hkPBW4GCWg7Lq+QeA2x7dy6XjNYIfsx6r8exW7GaOa
        6y3+97s9qfMMxPIuDYy4vLd+r6OvOK0kOaNeiaY=
X-Google-Smtp-Source: AGHT+IG4LUJYZFTOVapIp0bbwJLeQHqiuXlYfgLzHiuLSHVI+oT1hQVbjIKDTadjAJbetwvvZI5/Phf0FUXP8W+py9Y=
X-Received: by 2002:a05:6512:3e1f:b0:4fa:21d4:b3ca with SMTP id
 i31-20020a0565123e1f00b004fa21d4b3camr1511436lfv.2.1693564158433; Fri, 01 Sep
 2023 03:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230831105252.1385911-1-zhaoyang.huang@unisoc.com> <ZPCEim0AZG5hTSYH@casper.infradead.org>
In-Reply-To: <ZPCEim0AZG5hTSYH@casper.infradead.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 1 Sep 2023 18:29:07 +0800
Message-ID: <CAGWkznGAJVZtn49zNHsMAjRSfTRR707QXYY0m8Q+yABTsiig2Q@mail.gmail.com>
Subject: Re: [PATCH] mm: make __GFP_SKIP_ZERO visible to skip zero operation
To:     Matthew Wilcox <willy@infradead.org>, glider@google.com
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loop alex

On Thu, Aug 31, 2023 at 8:16=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Aug 31, 2023 at 06:52:52PM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > There is no explicit gfp flags to let the allocation skip zero
> > operation when CONFIG_INIT_ON_ALLOC_DEFAULT_ON=3Dy. I would like to mak=
e
> > __GFP_SKIP_ZERO be visible even if kasan is not configured.
>
> This bypasses a security feature so you're going to have to do a little
> better than "I want it".
Thanks for pointing this out. What I want to do is to give the user a
way to exempt some types of pages from being zeroed, which could help
on performance issues.  Could we have the most safety concern admin
use INIT_ON_FREE while the less concerned use INIT_ON_ALLOC &
__GFP_SKIP_ZERO as a light version method?
>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  include/linux/gfp_types.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >  mode change 100644 =3D> 100755 include/linux/gfp_types.h
>
> What is this garbage?  Header files should not be executable.
sorry for that, will remove
