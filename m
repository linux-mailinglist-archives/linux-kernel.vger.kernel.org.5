Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8D280C6FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbjLKKqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbjLKKqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:46:05 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7290134
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:46:03 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77f408d123bso126113085a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702291563; x=1702896363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oGkQuUWo91ye44C9IpsxZC6+sJmmo7+c+5R/ZoMYnk=;
        b=LswbF9ZKpTmZcrwlg+PykPudsQPWHEl9tXtc0PW4cE+POJn4SWIJI0n7WgNsQqiPj/
         TE2JI0zG91KQdpHgFRW+uNe50j1jMrWDf1vGKfwuQGoTgqUwYpzO2V7nmJZI0d9AT840
         aDBR1E9WFF/bk8ZWF5LEeNmJejGTI2WViwllDFXo93mo5inV+WrpgVE2pmQOYJ0CTBq2
         17dgA6Nx9egJa0xiihyG6YnvxOiaE/ne56XuOK4PhN3P8Go/hBNQ0/WRlxrC0hZSikOL
         iTKUzUtOinVi/MpF9rQKkGvkRxYUkTP8L78zeslrYPPRsYfh7PRuE/uInqTgI8Dt6nAF
         n7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291563; x=1702896363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oGkQuUWo91ye44C9IpsxZC6+sJmmo7+c+5R/ZoMYnk=;
        b=lBCJtlRV1Bs7simFyIvPZQs2fLQkqIgATpGUO2/tQAASI2N2ugiDFAxHxZmwMUCycm
         J+VsEmqAOSzLE4nmMqbhhG7YEARPbSmBTkrGTwCYflZcMRAcCAsYAsA6aHV0OiqRC65v
         MMbyox2/6mAUAbfHp0dG8aMjD+rZ0erP4T28Hdu1OF1PeXn7sg8CxrlF9hD0pTt8vcch
         YjKxumBZnwLYRyJaGA7ssUBQtWjrtuSjV/OGFBx37l0Qs0WHm8ttMdjlZczaE4H8U+ie
         A69isC7Dqbta3qmuX/cwxlS2g5nOWOKvfm+zFMJ86EZkpa8+1fvusKLXOLhqZOTQyF47
         q92w==
X-Gm-Message-State: AOJu0Yxy2Bjz6hJk1wqZi5pv2PsLGRqDng5UJt7C+EGZZR7mwvwlOzxi
        JAIfeiZZk6lTb1ghU+NEUg+Zm6x4EQSBT19/+e+PiA==
X-Google-Smtp-Source: AGHT+IH22X94i2ts8pfDTl+UHUOVSQbvWaHqW1ewv6yn/pgryYwSlV5ZdHdef/3tWsAKN8+sgj14JcXabg2oblYSeP4=
X-Received: by 2002:a0c:fc48:0:b0:67a:a721:ec3f with SMTP id
 w8-20020a0cfc48000000b0067aa721ec3fmr2421212qvp.131.1702291562839; Mon, 11
 Dec 2023 02:46:02 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-33-iii@linux.ibm.com>
 <CAG_fn=V5zMxGUQ=KmJh-ghTUHa-AZYn1CPTQNbf3x7Lu0w=HvA@mail.gmail.com> <13e3e073f6ed6aa48b39ec16add85baa677d17b4.camel@linux.ibm.com>
In-Reply-To: <13e3e073f6ed6aa48b39ec16add85baa677d17b4.camel@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 11 Dec 2023 11:45:22 +0100
Message-ID: <CAG_fn=UX=8HrFzCSxmPgMn=H4cVmZ4GHE0Z+qZbpysOZwuH=aw@mail.gmail.com>
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

> > Is there a possibility for infinite recursion here? E.g. can
> > `lowcore_ptr[raw_smp_processor_id()]` point somewhere in between
> > `(void *)&S390_lowcore` and `(void *)(&S390_lowcore + 1))`?
>
> No, it's allocated with __get_free_pages() or memblock_alloc_low().
> But since this question came up, I should probably add a check and
> a WARN_ON_ONCE() here.

Yes, please.


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
