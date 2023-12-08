Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE658098C0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572918AbjLHBr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHBr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:47:28 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F2E1719
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:47:34 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-db3a09e96daso1905389276.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 17:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702000053; x=1702604853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QasjkTvE12oeIkeDPIYBXwIAiruihNVVX4fkQH8L17I=;
        b=BvbnBT/jCw/UUnZgs0UH+5sifjP4Ni5A0uCwDWSA08tYT8kQE0Rke9gqi6DMjXSugm
         hIADFMw1HFyj6rbRK/EGrGdq9McVURKMPTVPpCBTH9C0b7bNKpyWvI819pvo8ywfiMgR
         pDL3r+43rIS20Q0og4yBM7i0mjzBM/mCH/kmsEsULve5DqpWbWFNoGFltr0be8Ln6HcG
         2vwP7GXJfZK6Ov4V1k6ts55liIt6EsxjzGidH6MG95edz3LKdQIJmzc/RAmulZ+Z4zMi
         I3JrAll0CHg1LSmnqLFFMAggHkvoAIJGv3aZmbd563cTKNirj7ZqUGiQBhOomg+JGhle
         ku7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702000053; x=1702604853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QasjkTvE12oeIkeDPIYBXwIAiruihNVVX4fkQH8L17I=;
        b=ODG1DoSmrfBmHvcuHf9p496qFOM0Ft3O96NfpqNELKjjBzsfU+iQwSNFaR57ASOh6C
         tDuxOUJuHLztEDPHXFqD/JIzVc77916E9dGKwuinzcl92jp2bfTOg+6ItCGbw3OFaCnZ
         B0n1il5DudfvtlgJ6itM4YWuT4RlBPnKgfucNPFLizSa4xKPzCU6mqZ0F7pfpZxjT4ql
         GHC8HZhr5FKBude0NV3Z6yJgqg3WTJ9KsDpXgJX7rNsuN0MjPuRbiAbpLHivSfTMNczZ
         MTDOatARfbHzZenY08cCeI66ct/3k18EPU9jZH8qvMlM+gjGangK0HuHo7YNW80Xe7Aa
         S5BA==
X-Gm-Message-State: AOJu0YzQniMH/3D9wLOhKGYuWKAS3nHijzVFNpmtmkLB3ihP3FnXzGGl
        9nV43a1cANgXOGYviBg30fTQjqgwO5xXNRQxq689Kg==
X-Google-Smtp-Source: AGHT+IGkcaN4vvcrb8T5smexqtqjrDfI96Nzc421af0VFhb8gbbvwzsJEs/NJAkNTu4GFPThK+R150NgDMf09+eZHpo=
X-Received: by 2002:a05:6902:18ca:b0:db7:dad0:60d7 with SMTP id
 ck10-20020a05690218ca00b00db7dad060d7mr4259393ybb.100.1702000052997; Thu, 07
 Dec 2023 17:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 7 Dec 2023 17:47:19 -0800
Message-ID: <CAHS8izPitBiASmmdZQ91HRmK33YBZJXOmmCybgeuGYTjP231ug@mail.gmail.com>
Subject: Re: [net-next v1 00/16] Device Memory TCP
To:     Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Wei <dw@davidwei.uk>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Harshitha Ramamurthy <hramamurthy@google.com>,
        Shakeel Butt <shakeelb@google.com>
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

On Thu, Dec 7, 2023 at 4:52=E2=80=AFPM Mina Almasry <almasrymina@google.com=
> wrote:
>
> Major changes in v1:
> --------------
>
> 1. Implemented MVP queue API ndos to remove the userspace-visible
>    driver reset.
>
> 2. Fixed issues in the napi_pp_put_page() devmem frag unref path.
>
> 3. Removed RFC tag.
>
> Many smaller addressed comments across all the patches (patches have
> individual change log).
>
> Full tree including the rest of the GVE driver changes:
> https://github.com/mina/linux/commits/tcpdevmem-v1
>
> Cc: Yunsheng Lin <linyunsheng@huawei.com>
> Cc: Shailend Chand <shailend@google.com>
> Cc: Harshitha Ramamurthy <hramamurthy@google.com>
>

Welp, I messed up the subject line. It should say [PATCH net-next...]
across all the patches. This may trip up bots and email filters. If
this is annoying, I'll resend with the fixed subject line after the
24hr cooldown period. Sorry about that.

--=20
Thanks,
Mina
