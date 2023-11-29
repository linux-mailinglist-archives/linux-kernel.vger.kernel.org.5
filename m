Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724CB7FD246
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjK2JUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjK2JUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:20:03 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7A6F4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:20:09 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-67a16594723so32411306d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701249608; x=1701854408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q6jgX+fdtw/9pVukVvzlC00W/od07a5izGjIu/hs4qE=;
        b=XToJ42kYKxo9SJQeysuJw7T93iaB5H7pjuRFx9qFaPChG//ulhnvlopmgkdORtWyk/
         diiXCKJ/nzMHh1ljQTTbGx1aSf1T9kJNNANOgNeHhpEpbqQAdTHWFskLMv/OtBKwfWb/
         IffMjHq4RLsr1rnkBk9p6reCiukLr/wZKWAfcIyZmjHPg2BJZhvEf7Jim58/w291dLaR
         jSFhOz82tdRL3h5Ne7W1xrM/MwBT5erbBKZwpK9aTHzmW1X1DWS7urZROV2gnWeqnnhq
         m3aPOG214rsMR3wknEqtO3/qPloB4WtPkJgD7AyqlnkK0HpeamFlE9GWqizF8oBjeUb4
         Jb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701249608; x=1701854408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6jgX+fdtw/9pVukVvzlC00W/od07a5izGjIu/hs4qE=;
        b=s8iGHbHwCZZxOFFQrhU4XkqHq8SzyPQl3cwuSmhxYClVt1EaXq7eTft6bAk6LnARQF
         zm7/wTj0g/IaTL2QI79ApzwLFVTjgk4joN18Fgai3SO+rNv6zXiplssucOOXt3jnKm2j
         uSWVuiP8hW4uolrlI1DJGAL1G5Xf7vK+sooeS7OoK1LWYzrKM1u1jy3lZRmmqW6WP+8d
         mbXi8CbEcePPgN02Fj0p4a7exFSQLcg88K130xGo9xUmQMlrGBn4gEukwGgTGRDshKBq
         KGvj99pxXyC4e4upEYjFLaM6CB3+KKShC07WDLJjKYMLwIEeTbIcQERwzfJ8fmyZREJQ
         j8ow==
X-Gm-Message-State: AOJu0Yx09AIoyDgzLk3Oj5Cewu2Y0fBXrjEy5zb98tX1mnljidWlD0yA
        WB8YoNtn28rOmIJZ73hiLs7XZ5mhO9rrYDDqcnw+BA==
X-Google-Smtp-Source: AGHT+IHqiXE0zJisfc2kGLRsSrhk09nD6kqfJtIYT5sewkmbb0V0LnYF/lh61UmHuguBtkr3GCLsTIMLQyCS24iqQho=
X-Received: by 2002:a0c:fccc:0:b0:67a:492b:6cbd with SMTP id
 i12-20020a0cfccc000000b0067a492b6cbdmr8165414qvq.6.1701249608288; Wed, 29 Nov
 2023 01:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-34-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-34-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 29 Nov 2023 10:19:29 +0100
Message-ID: <CAG_fn=XCeE7JF5hbpzXu2A0Cae3R16_hnDwF0==oJMX320wBHQ@mail.gmail.com>
Subject: Re: [PATCH v2 33/33] kmsan: Enable on s390
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilya,

Sorry for this taking so long, I'll probably take a closer look next week.
Overall, the s390 part looks good to me, but I wanted to check the x86
behavior once again (and perhaps figure out how to avoid introducing
another way to disable KMSAN).
Do you happen to have a Git repo with your patches somewhere?
