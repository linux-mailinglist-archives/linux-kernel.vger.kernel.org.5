Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9092680C67A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbjLKK1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbjLKK1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:27:02 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D870125
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:26:58 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77db736aae5so220667985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702290417; x=1702895217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=52MMj8qKTft0Rgk5cZkkhNA4qD9/n7KR5GYlCADI69M=;
        b=Zh3omQw20Krzch/mGIwcw5r1EUTqZja8pb9GLFIJHoztBnT0jDzAB6dhWYQ8Ym//J0
         /vZUky6Pn9gCvHJTP+3yp1/L9HcFwZmfVu5kcvyI1CvHvKZVZf7eQc8nkvMDrntkUtFS
         OX1Jo2Ni0CiEwZ2SGdg/K4JG6Vl1+fChTkZeU1e9JFW+aPFI/tqUZyGDWWDmmzkkWbXh
         /PfTyWl7IrA8LYyOoufVkHnZiF9OD1EZrvmRjlXJBp/SjezNVHxXRyYtGQGd33HoKdtb
         g0aW0BrXbL8Y4pa07uxWN6baZS5QoNpLL+1Zef3IFgvPjv/IcPSvj1RZzTV2I5AaW30B
         UayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702290417; x=1702895217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52MMj8qKTft0Rgk5cZkkhNA4qD9/n7KR5GYlCADI69M=;
        b=h8zxKTlPpZfVXk9StyMAlqMsymnocLObxmG0tOEuHFDGN5ZxMxwTrkJOy1ypwBjruz
         Z0+EXJew8AuH3W8vl5E/GID0gnKGONzBPOD4yQAgpkxt5RVUSoIGEqzkZPJyWBsS45Oy
         Jd4yqAeiLdyFjjC1ZYPZ69jyyvCPDVg7hy2QBwKlU9gZx4IzPCHT1f5nWU/9xmxSKNTw
         3KCTzcIbEvZ5LZb8tqd9Su6jJxhSTpqOse/kIIHmPZFfiCRTqCq5QrFFDM0ZaGmI8Lhp
         sqoi1RdecKi9mKSek65L44kMsGY/QwcOMNEYSHZlXHSjXb7kH3fnmRWRusgxBQInzEjs
         DSpw==
X-Gm-Message-State: AOJu0YzanEAnTIO8XgvYtEj5ViG14AVSXepNAHYHQCCRgEJle5j0RuZe
        AFH5iF/j396XWtGD/e8mcNGvZzmeCV2vE+AW9Wfe+A==
X-Google-Smtp-Source: AGHT+IFncEqnUG825QYYf2ZFoIyy2us7AlruhLwTzoqQgAllesCEy82DXX//svPjMiK/UR6l43FxrwiNWQPGsh4ypL4=
X-Received: by 2002:a05:6214:4c04:b0:67a:c4d9:dc10 with SMTP id
 qh4-20020a0562144c0400b0067ac4d9dc10mr3977857qvb.109.1702290417391; Mon, 11
 Dec 2023 02:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-33-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-33-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 11 Dec 2023 11:26:16 +0100
Message-ID: <CAG_fn=V5zMxGUQ=KmJh-ghTUHa-AZYn1CPTQNbf3x7Lu0w=HvA@mail.gmail.com>
Subject: Re: [PATCH v2 32/33] s390: Implement the architecture-specific kmsan functions
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

> +static inline void *arch_kmsan_get_meta_or_null(void *addr, bool is_origin)
> +{
> +       if (addr >= (void *)&S390_lowcore &&
> +           addr < (void *)(&S390_lowcore + 1)) {
> +               /*
> +                * Different lowcores accessed via S390_lowcore are described
> +                * by the same struct page. Resolve the prefix manually in
> +                * order to get a distinct struct page.
> +                */
> +               addr += (void *)lowcore_ptr[raw_smp_processor_id()] -
> +                       (void *)&S390_lowcore;
> +               return kmsan_get_metadata(addr, is_origin);
> +       }
> +       return NULL;
> +}

Is there a possibility for infinite recursion here? E.g. can
`lowcore_ptr[raw_smp_processor_id()]` point somewhere in between
`(void *)&S390_lowcore` and `(void *)(&S390_lowcore + 1))`?
