Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322737F1BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjKTRzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjKTRzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:55:02 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A66694
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:54:59 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2851967b945so1119681a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700502899; x=1701107699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ic5/m1SwSzZGkQHYWWndzWVSLqtg6CVcSVqWXKyhh3Q=;
        b=L/qZAwth+SCD/kL/bPzTKKT0ubzJPI8x6Y9QQ/osa/V8iNWLVvJF56Y8Tl23hcs7oD
         5R8glZkgGv+zExdEuPA4sPkqc7iOswzbw046mSIYqh5/INE/NqsgtzkDvWuY+MbyDW7G
         qyLMKPsMxTdRH5ciI7kLRd+Lqfj9fIpTPE2PyZa62P8GpncOkYwvnuozz5DwvayUYrKK
         l/O5gV8hu86khBo5eDuYOsw1W1eafIcCAwc2jsjJ1qcAteYHMYXR0xBkGyFZusHBf40R
         UI+xZmzORj7mck9TAYppSQxPZ+2/FROedpvDWBTaCF1PWjMxDYIfHA+4GU5IUV2PKQkH
         h9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700502899; x=1701107699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ic5/m1SwSzZGkQHYWWndzWVSLqtg6CVcSVqWXKyhh3Q=;
        b=t6ZJmG7bFmcNyHFOO7YJJOx0CtCo8ANmBUHfamD5eNvuCK6Sh2kan1Ikkuz+r8Wm1+
         23smz3ps5T/NJ2TNKho+/HMcCfoViRb6MuaygWc4CnVONi8HzQ7w4Hl3w/qErKh8xT/o
         ywX4BzO4R93fmH1odcj/Q4d7d5ETr0Slk9Iptq7m2ndBRLs8+B6IYmWfGcj8NE7a3rh5
         4R+6K9i9PfP2TY7c/xdfuGlzMJA3SFr0d5s34C1OjmvPzggyvt/tTnoEV5sZ/9arO2CD
         RIuZUOxCy8JutTn0uOQAULKML+mKK5kuAP4OsvZKeA3/dcHn346NMC8aLEOmK7X5X4bC
         XPIQ==
X-Gm-Message-State: AOJu0YwsHWt/VJTXBK2Jwskas2SadKqs6whEc3CAu3zFBclrQD8UqG+S
        +ghNMW7lPWv/0v3D5akyMBvpQdgW+oD5rsjDqkjER6MSVcs=
X-Google-Smtp-Source: AGHT+IEJoL2QLhB/T1sZspkG2O1JG99nADjzMQxs2co49d+h5JqPd/oD4OyYei18fcpyWJynS7kBJx/lCw3fIsdN/9w=
X-Received: by 2002:a17:90b:3908:b0:281:3a5:d2ec with SMTP id
 ob8-20020a17090b390800b0028103a5d2ecmr298941pjb.8.1700502898959; Mon, 20 Nov
 2023 09:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20231120084300.4368-1-osalvador@suse.de> <40e26ded-a8c2-0e24-6fb0-d96053ae1c32@suse.cz>
In-Reply-To: <40e26ded-a8c2-0e24-6fb0-d96053ae1c32@suse.cz>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 20 Nov 2023 18:54:48 +0100
Message-ID: <CA+fCnZcj4=02L9qc9wvr36Tsc-a5Qcd9146qVOva9N6gK_a9HQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] page_owner: print stacks and their counter
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
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

On Mon, Nov 20, 2023 at 10:07=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 11/20/23 09:42, Oscar Salvador wrote:
> > Changes v5 -> v6:
> >      - Rebase on top of v6.7-rc1
>
> Hi,
>
> I think at this point it would be better to rebase on top of
> https://lore.kernel.org/all/cover.1698077459.git.andreyknvl@google.com/
> which already contains the refcount field in stack_record.
> (and maybe help with the review of that series as well? Hopefully it can =
get
> to mm/unstable and -next towards 6.8 soon :)

Yes, please; I just mailed a v4 that is based on v6.7-rc2:
https://lore.kernel.org/linux-mm/cover.1700502145.git.andreyknvl@google.com=
/T/#t

You should also be able to use the new
stack_depot_save_flags(STACK_DEPOT_FLAG_GET)/stack_depot_put API to
keep only the relevant stack traces.

Thank you!
