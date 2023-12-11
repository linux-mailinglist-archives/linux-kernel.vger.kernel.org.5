Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E465E80DE2B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345610AbjLKWL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345598AbjLKWLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:11:55 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE23E4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:12:01 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c701bd98f3so953044a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702332721; x=1702937521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBxEKBNamMvlGFbzwl1mFmti5qczGRc6ilz0oKWYU1E=;
        b=lJrOZ85HmMUw7bVFmAwdaiCubnbw+AxFUcMy2GU6Re419Nc0AkSEdN3fdxyKYyejMJ
         UltylsbKsDj1/hr9IOInLIiK/9PphdpPltbr14ghcEBbyxcYv69EloHj11sBHBFfbXbC
         uSQXe86ntETSvmsnXUgdX9fQXtAlcOFxmLJezJ3wBFqv7kQCu7uo8irfQ0l52RulGvi7
         J6jc60rnIc57rOUeA/R+Wb/bf3PcPC9Zh7cO7yAERr1qQuw8JM2GP809ZNaaVrrA1+2E
         BNZarUlpYKfofqdcYxDH/EA09rfXZd4wqxPmdvrMu+GMJjHzO839ERnEd21sHl7Q8zp4
         zmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702332721; x=1702937521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBxEKBNamMvlGFbzwl1mFmti5qczGRc6ilz0oKWYU1E=;
        b=Vh3ZlI1Wng2T16D2O3nzludQNC9UgVbDxojfW4WPJLQwP9fYzC7RstyNwrpZzKz3Ap
         X+Hie897IjSM2wq8rieHhS7QYZlpJKOW08lOFH0FKsuAT6c6U1qE+zb6mD5UHyj6OOxl
         DmfPsFc9yZjGniArNXXbAdUuW4qJ8jMfRIzAV6Jj0cUPOtz8X8lBrDthjTjcn3tdIpAl
         ClDj51fnBXh1zbL+mrJdyKh5MjaKoAZRY0eNXAuy3mszPWW6VBwT29K8ueLA/7WGMsu4
         3mShRE2G5wZI9kpt6CSVYKNlRhKYuMR5sYZ5BkrUpOkuvm4MaQYkcfgKT3RDEi05mvC4
         OLdw==
X-Gm-Message-State: AOJu0YzhN+wj5kVyuGDEpog3200EUV3HmspuX1nyNgDwN1xpaY7WudST
        XkT7BU+irD9fcBsQZaMoUih5SdhPE6YN3I8qQ0c=
X-Google-Smtp-Source: AGHT+IFUW4Y1wSl+tlZXpZOUw7PN1bGTF7r60A8/Qk9ggHCAr7HZp63IhUlul6PSahQAxJWebACXPvmodeXqe1j4W9Y=
X-Received: by 2002:a17:90b:2204:b0:286:6cc1:28a with SMTP id
 kw4-20020a17090b220400b002866cc1028amr2291102pjb.85.1702332721019; Mon, 11
 Dec 2023 14:12:01 -0800 (PST)
MIME-Version: 1.0
References: <20231204-slub-cleanup-hooks-v1-0-88b65f7cd9d5@suse.cz>
 <20231204-slub-cleanup-hooks-v1-4-88b65f7cd9d5@suse.cz> <44421a37-4343-46d0-9e5c-17c2cd038cf2@linux.dev>
 <79e29576-12a2-a423-92f3-d8a7bcd2f0ce@suse.cz> <fdd11528-b0f8-48af-8141-15c4b1b01c65@linux.dev>
 <CANpmjNO1_LxE9w4m_Wa5xxc1R87LhnJSZ3DV59ia3-SdQUmtpw@mail.gmail.com>
In-Reply-To: <CANpmjNO1_LxE9w4m_Wa5xxc1R87LhnJSZ3DV59ia3-SdQUmtpw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 11 Dec 2023 23:11:50 +0100
Message-ID: <CA+fCnZfhqQ+n0SsZU0RKEov3CkwTNJXM7JTMxtkrODmbJPskDQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/slub: free KFENCE objects in slab_free_hook()
To:     Marco Elver <elver@google.com>
Cc:     Chengming Zhou <chengming.zhou@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
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

On Wed, Dec 6, 2023 at 3:45=E2=80=AFPM Marco Elver <elver@google.com> wrote=
:
>
> The is_kfence_address() implementation tolerates tagged addresses,
> i.e. if it receives a tagged non-kfence address, it will never return
> true.
>
> The KASAN_HW_TAGS patches and KFENCE patches were in development
> concurrently, and at the time there was some conflict resolution that
> happened when both were merged. The
> is_kfence_address(kasan_reset_tag(..)) initially came from [1] but was
> squashed into 2b8305260fb.
>
> [1] https://lore.kernel.org/all/9dc196006921b191d25d10f6e611316db7da2efc.=
1611946152.git.andreyknvl@google.com/
>
> Andrey, do you recall what issue you encountered that needed kasan_reset_=
tag()?

I don't remember at this point, but this could have been just a safety meas=
ure.

If is_kfence_address tolerates tagged addresses, we should be able to
drop these kasan_reset_tag calls.
