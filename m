Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B38A80A4B6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573838AbjLHNt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573812AbjLHNt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:49:26 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CAE173B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:49:32 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67a959e3afaso11650266d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 05:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702043371; x=1702648171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyp/ZFyiUOjenQgn6G8kYMLVmsBPMd5m8mXyGEY1Mx8=;
        b=HzGZGL40VCq48hRUv4ni/hFjp8bYozGF/tTJeOdjnidmwhiHA7c/5xRV5VmDuzdIAO
         nKXClPDibILMmg7YfybvldwgIRps0nw/vntbReb+zPihNUhm/90sSGnZbeN1oOvh9Lqb
         8baKHliajyRWOu4i0/v4vnqkMUnaJdBHugn45qz7kDw6C4UKboMz5+yDNagxa1xhbSYA
         LVGbFg4LUi6yekPeRD5NFta3HXo4G+ZI3XSb4bCekE9ocyFl/2cHtpYbsUBGmgv1QvUa
         A8r5ZEntXCy+T4mYu5sdOH+pa9DR7a/bGsj6QsNM++0u5wtlHfYxD8B33Ubto4HDCuIW
         PX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702043371; x=1702648171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyp/ZFyiUOjenQgn6G8kYMLVmsBPMd5m8mXyGEY1Mx8=;
        b=WVkPlVuk4nuYaMcInn9fj2Sq3El3pVVtVpCIBAcLQHgZ7BUB56ccc8bxaSaFdGNY+0
         DQky+vdp87BSPdQlSRdDhpy6alpSePmwVb7lX3p3SRKVqh11uUWUQqEr6+AJhwbxLuOG
         VpD9ZqPYZ+CiAeAIV1ftx+NB0PKdZ9WsUqdEsgI7TONjHX8uLQIxpXW1DiiEoMgIte1z
         oZMy0M97aPjQKK/dYMWg86P0tm4gbi2gXGyRNZ9VEkJHxjqxJ7cibo5n+ukmT/mh31q8
         WxmU+7Bw6oEeKLzxUCJ0CY7wWvHHNEadOlUX19nkSaUQ61sF7XnndI6KPw2w24p48qKe
         Losg==
X-Gm-Message-State: AOJu0YxOT9xmFDN8ecWTqkjUdySX3cVP1VaUpWO2wplPRrePZXNFG2Vo
        SgHK15JDRMs5HxAv/gXT7z30uA5it02BWbJjuXpWDA==
X-Google-Smtp-Source: AGHT+IEr68RmSA5aYBUgmYtuiSsf9rYsZogw9kLYvnY2zqG64Y2/8MrVDe8thwflyfC3jwZMQ9WgLXTtXopCNqK1OqA=
X-Received: by 2002:ad4:5de2:0:b0:67a:c8ff:1641 with SMTP id
 jn2-20020ad45de2000000b0067ac8ff1641mr5787725qvb.79.1702043371101; Fri, 08
 Dec 2023 05:49:31 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-14-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-14-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 8 Dec 2023 14:48:55 +0100
Message-ID: <CAG_fn=Vaj3hTRAMxUwofpSMPhFBOizDOWR_An-V9qLNQv-suYw@mail.gmail.com>
Subject: Re: [PATCH v2 13/33] kmsan: Introduce memset_no_sanitize_memory()
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:06=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> Add a wrapper for memset() that prevents unpoisoning.

We have __memset() already, won't it work for this case?
On the other hand, I am not sure you want to preserve the redzone in
its previous state (unless it's known to be poisoned).
You might consider explicitly unpoisoning the redzone instead.

...

> +__no_sanitize_memory
> +static inline void *memset_no_sanitize_memory(void *s, int c, size_t n)
> +{
> +       return memset(s, c, n);
> +}

I think depending on the compiler optimizations this might end up
being a call to normal memset, that would still change the shadow
bytes.
