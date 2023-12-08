Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F73B80A4DA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573868AbjLHN43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573852AbjLHN41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:56:27 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2411987
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:56:33 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-67a91a373edso11883906d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 05:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702043792; x=1702648592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlUqBCSJE7b+NOWHxQNrRwEhp2gTAvY03mAPrdADOdo=;
        b=H2O+yaqNA/Ire4cgW0btDC0qdoE8ugqwlXmk/CYzER8bM8kWjsS5c9gg+INrHUH5cn
         nB6V3BVZijge9perTdtiFse/qsI142jfCN3L/JG3PCG+0nEpM+pE5rBtbYMHRG/P/P3I
         m1RhsF8rEtVR2/k9WDDU+EYEpLNwZp6ejIqz/wpVoMTv8GfvlWGbWocbheokZP46/L3Z
         RSMuL8C4kNBxUInWgM1wnV1m+MfncrUKyrH7gQXYrMFNos+z7syaA17HyoHcqPXUk6eA
         Kxo46Cvmh6T2vr7s7D7CJu+IC+y+ow+nz8YZxTViB83+8eU+wpo04jKShu/JSufgeZ5g
         a/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702043792; x=1702648592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlUqBCSJE7b+NOWHxQNrRwEhp2gTAvY03mAPrdADOdo=;
        b=ksXzvn0XcY2ug57pnJ/OFILywvdWLrcmQEOTO4tVhZGcFGSXGb7wVbUE3Q5lFvz/ix
         XR+x5AV9LzEmoKQ00A6uLK2DqOYj5b/I1Mj8f/Q8rdgwuLUkEBl39uqSGP2l/3IQm26N
         2RG0qdwR3Bnkwf5MldnKt/WB5zp4xqnLLI/uVkCml8opctk6e68dthFp2A2jZiD7SNgq
         vP53FxTGVEzH6k4WEoxbbwHxTr8waR63rMGAalBpP1Si+DUb5PjtxWuhkh5diB9eKcrF
         P1DXe9PuJBz6xWaxR5mOwj41SnIN7Dhczspmqhso/9t9xAOybxVcXmVFD26PdEr2ooUw
         EhiA==
X-Gm-Message-State: AOJu0YxtJdEsQtSExVtSrXkuMV+lU/7XaCtLYCBV0LKHxy0MyO0OHXZl
        BqXgC9uOyU7zr5xKEoJ0PAamYa9SDhnYwmxCqfrRCA==
X-Google-Smtp-Source: AGHT+IH23iVUpBsOBONYMPHwppBBTzpfL3Q8/bvfC4kzRpEJUfOAA07YjvKi0Z4sAx0eXzRBOWPNA1eAjy4CZz3bJdM=
X-Received: by 2002:a05:6214:5802:b0:67a:a951:7fc2 with SMTP id
 mk2-20020a056214580200b0067aa9517fc2mr4258051qvb.119.1702043792410; Fri, 08
 Dec 2023 05:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-18-iii@linux.ibm.com>
 <CAG_fn=Ug6MFyoj=J_yabfd-V+3vGYNS3-CS+fhW9Tsc847xMtw@mail.gmail.com>
In-Reply-To: <CAG_fn=Ug6MFyoj=J_yabfd-V+3vGYNS3-CS+fhW9Tsc847xMtw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 8 Dec 2023 14:55:56 +0100
Message-ID: <CAG_fn=XbDFa_7BWMzR5cVEVp-GuHxK2fyFAZJgXqXb8qL1ZhAA@mail.gmail.com>
Subject: Re: [PATCH v2 17/33] mm: kfence: Disable KMSAN when checking the canary
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 1:53=E2=80=AFPM Alexander Potapenko <glider@google.c=
om> wrote:
>
> On Tue, Nov 21, 2023 at 11:02=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.=
com> wrote:
> >
> > KMSAN warns about check_canary() accessing the canary.
> >
> > The reason is that, even though set_canary() is properly instrumented
> > and sets shadow, slub explicitly poisons the canary's address range
> > afterwards.
> >
> > Unpoisoning the canary is not the right thing to do: only
> > check_canary() is supposed to ever touch it. Instead, disable KMSAN
> > checks around canary read accesses.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>

and even

Tested-by: Alexander Potapenko <glider@google.com>
