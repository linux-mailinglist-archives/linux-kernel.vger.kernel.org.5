Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73DC80A562
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573949AbjLHOZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573915AbjLHOZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:25:52 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C5F1738
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:25:58 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-58d12b53293so1061280eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702045558; x=1702650358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMzKOjsadOdlzFzBDSAqUHFYwgT1E5TMaJuAbqx/ofA=;
        b=et9XLQ8ZqQT+MVCjxwENauz7zGRsz7y+sf/oinfJ9dSLA6+risywteuJ0+D458LWYO
         MwigzbeYVmMop8fjsJOtrzqEMEzsSR/M4PN1AK8vKb6u0TxVVPCAhqZJkgwxkVyMbMTq
         SObTOJyJ2hSepeJ+g7TfRlF13ita9TzNVJBv7QEOW3eFgyphBF4hWJRLP3RvmOc3eIdn
         T/N5cAHLbcch8sE5N9LZLgXKK7Lcwxen3VCPL4zjHtjUIEREoSySmPiwNYK1xMPE+JQ5
         W/gZZnIKJ40pOd8zBIQCdzpyY5+sHuRgcY4QSbZngUj5UvQNefCXC7ltDno2DSir7rOw
         p2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702045558; x=1702650358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMzKOjsadOdlzFzBDSAqUHFYwgT1E5TMaJuAbqx/ofA=;
        b=ulf13e+HsgYWUtMXc16caCCm00VhFSBela0iCHcEQpMxgrNGORRWRVv/csk8lr9Qvj
         qU1LTp35ZINdZIBom2rHrpAZow7ES444xjz/QDAYNik6lA+QMv1SDQDLkEexKgWrGmgs
         7AJiMUeFqiSteX4rN9s6Ie371j7CBfTIJ5tvZtOhr1xdq8Y/1ermni/ylL3ZrmXSNvOy
         6mn3/ySZer+ZgOdWzxmUh2W7/LYhJcgrCDyY/T5nZIv2dF4fFJaX3E4JB6VZfCYSqwBF
         7XT148pBZOxtD7388MR8t1FBtgaU896YCX9bdKxRpuIDPWhNYqngi2MTCZRHeBfzEjXl
         B3Rg==
X-Gm-Message-State: AOJu0YzsSRNHFzcwbB3r/wiK4ERRY/BI/g2p/oduOSqBVHPf7wtj3Dc2
        6TUCWq8eO9vzedudQIXnYaOnM0VFpY1pGZXkVDjhqA==
X-Google-Smtp-Source: AGHT+IE/E5Zk6lpM+Q8iq+g4LL35DztvA78a9rnsgBC2xnye70UOmh2YC4gbKyaDqDSFpsQYE13Fz8eacxBaFlVCob8=
X-Received: by 2002:a05:6358:10c:b0:170:4403:83a6 with SMTP id
 f12-20020a056358010c00b00170440383a6mr3947511rwa.52.1702045557641; Fri, 08
 Dec 2023 06:25:57 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-20-iii@linux.ibm.com>
 <CAG_fn=WiT7C2QMCwq_nBg9FXZrJ2-mSyJuM1uVz_3Mag8xBHJg@mail.gmail.com> <4f0eb4b4d4f6830f39555dc8a35f6ff88d6f8e63.camel@linux.ibm.com>
In-Reply-To: <4f0eb4b4d4f6830f39555dc8a35f6ff88d6f8e63.camel@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 8 Dec 2023 15:25:21 +0100
Message-ID: <CAG_fn=XUSfppyVMZO5K2kaii+OSLxV_UbHcn3cuH3zBt9J3g1g@mail.gmail.com>
Subject: Re: [PATCH v2 19/33] lib/zlib: Unpoison DFLTCC output buffers
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
        Sven Schnelle <svens@linux.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>
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

On Fri, Dec 8, 2023 at 3:14=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com>=
 wrote:
>
> On Fri, 2023-12-08 at 14:32 +0100, Alexander Potapenko wrote:
> > On Tue, Nov 21, 2023 at 11:07=E2=80=AFPM Ilya Leoshkevich <iii@linux.ib=
m.com>
> > wrote:
> > >
> > > The constraints of the DFLTCC inline assembly are not precise: they
> > > do not communicate the size of the output buffers to the compiler,
> > > so
> > > it cannot automatically instrument it.
> >
> > KMSAN usually does a poor job instrumenting inline assembly.
> > Wouldn't be it better to switch to pure C ZLIB implementation, making
> > ZLIB_DFLTCC depend on !KMSAN?
>
> Normally I would agree, but the kernel DFLTCC code base is synced with
> the zlib-ng code base to the extent that it uses the zlib-ng code style
> instead of the kernel code style, and MSAN annotations are already a
> part of the zlib-ng code base. So I would prefer to keep them for
> consistency.

Hm, I didn't realize this code is being taken from elsewhere.
If so, maybe we should come up with an annotation that can be
contributed to zlib-ng, so that it doesn't cause merge conflicts every
time Mikhail is doing an update?
(leaving this up to you to decide).

If you decide to go with the current solution, please consider adding
an #include for kmsan-checks.h, which introduces
kmsan_unpoison_memory().
