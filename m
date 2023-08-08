Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B04977370B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjHHCuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjHHCt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:49:59 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765EBE5A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:49:56 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-407db3e9669so102231cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 19:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691462995; x=1692067795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RSNnQZT08dQdFVE5RJv/G+IJCRbc3TJGyCsrhcpmdQ=;
        b=a272jKXZUQokY6L5C0Br3ocABCJ+A8NpiSSqAW2ukctHWiYUg0oPKJ+vgx0NyQAwv2
         UKQDyT/D5JaOlhyZlhwe/G7vvSnImf0tKcfkclJhEKEzV6GEr7q+JBN8MxUO7P9r913M
         uI+NpMpW3CMQ9TtTqVY509r87gnSnsvdAVwRDCljGI3WsvByZB2H6f4qwRj/RotvSktg
         n33C1JWAuTsjt7/yM1TrXoyLh3SF/AoKIUPQxtQ8dWgMYhIkOZpoQWzmZ72g46myu1b6
         MvfVM6rFEPbilLDFeGW1Gt9RNnEsYUZ/Q63C54Az3wdihv5Q6BKRqdaVa8N0hz7NDLwD
         inzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691462995; x=1692067795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RSNnQZT08dQdFVE5RJv/G+IJCRbc3TJGyCsrhcpmdQ=;
        b=NloRtV6WE2vi/U9HEQILUSjA9A4AMZn3JYuNhQPq1sqKBtfEj7yEfnxJ6nR6QKo11I
         r8mSQFmQSx0TwATaRMvDYyRVnT2wWBwfBEcAY2HOCgKyu+7K9N28vHHqrzWnH42ykvbE
         Ef0xe1XeMZzHwp2diKaZthH7Fn9HuxZ2gTvSL3KtmBG2wWSvIdZLTOJjcnK1uiRYkzOo
         qRp82mGiI4LtkrIkEvTb/O3+oq8shh0EYbRJOKASohyVRbtzCFI/gC+Yplu6PyUT0smI
         JQ1KVYgvnxSVilVRlmb8iDc40MDTAV9/j6eJECyxoB+9ZJVxhgSIzISSfziHNfQy56yw
         VXzg==
X-Gm-Message-State: AOJu0Yw9vW2i2qwXg1irUP4frV3WZ3RaB1cppfV+sD7HLoSf5pZgfFUt
        C0/KHzRXkfwoi4cbwDg1azfwUbI5EUwAfwVwE1pqzrQIKGWVhMLkZBOsSw==
X-Google-Smtp-Source: AGHT+IFvXwWNd1BMS+iG4q7Z3meYuXCiDq9AoY3zcgK3v7qramlFnSOemTPJKu+4UN/Xp/QO5nOMIVY1TX40Y3Ro7hQ=
X-Received: by 2002:ac8:5c53:0:b0:403:b1e5:bcae with SMTP id
 j19-20020ac85c53000000b00403b1e5bcaemr749780qtj.10.1691462995526; Mon, 07 Aug
 2023 19:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230808020917.2230692-1-fengwei.yin@intel.com> <20230808020917.2230692-3-fengwei.yin@intel.com>
In-Reply-To: <20230808020917.2230692-3-fengwei.yin@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 7 Aug 2023 20:49:19 -0600
Message-ID: <CAOUHufZnYk5BtTB9Cm0Jnf_KJPXdsLD4H7Fd4wdxP2Rm+QW+Ag@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] madvise:madvise_free_huge_pmd(): don't use
 mapcount() against large folio for sharing check
To:     Yin Fengwei <fengwei.yin@intel.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, willy@infradead.org,
        vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
        minchan@kernel.org, david@redhat.com, ryan.roberts@arm.com,
        shy828301@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 8:11=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com> =
wrote:
>
> Commit fc986a38b670 ("mm: huge_memory: convert madvise_free_huge_pmd to
> use a folio") replaced the page_mapcount() with folio_mapcount() to check
> whether the folio is shared by other mapping.
>
> It's not correct for large folios. folio_mapcount() returns the total
> mapcount of large folio which is not suitable to detect whether the folio
> is shared.
>
> Use folio_estimated_sharers() which returns a estimated number of shares.
> That means it's not 100% correct. It should be OK for madvise case here.
>
> User-visible effects is that the THP is skipped when user call madvise.
> But the correct behavior is THP should be split and processed then.
>
> NOTE: this change is a temporary fix to reduce the user-visible effects
> before the long term fix from David is ready.
>
> Fixes: fc986a38b670 ("mm: huge_memory: convert madvise_free_huge_pmd to u=
se a folio")
> Cc: stable@vger.kernel.org

Andrew, this one isn't really a bug fix but an optimization, so please
feel free to drop the Fixes and Cc tags above. (It seems to me it
doesn't hurt for stable to take it though.)

Thank you.


> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 154c210892a1..0b709d2c46c6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1612,7 +1612,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, =
struct vm_area_struct *vma,
>          * If other processes are mapping this folio, we couldn't discard
>          * the folio unless they all do MADV_FREE so let's skip the folio=
.
>          */
> -       if (folio_mapcount(folio) !=3D 1)
> +       if (folio_estimated_sharers(folio) !=3D 1)
>                 goto out;
>
>         if (!folio_trylock(folio))
> --
> 2.39.2
>
