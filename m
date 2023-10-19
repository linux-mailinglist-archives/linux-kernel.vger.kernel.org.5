Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70657CFF11
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346151AbjJSQIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbjJSQID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:08:03 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5263EB3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:08:02 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7dafb659cso100082957b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697731681; x=1698336481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmnPH3jDYtW1cB98XlzrlUIo9mVxEt9reMcjg2WxHC8=;
        b=cCRbVbNzlwGw84+vIDfFOxj5/QQROMhI34VNTd16rimtz/qvWIS8o0cG3yoaWdsdwm
         xQua4nIuFRZ97laGDqsZhYq/iqulYY6dQY1k5+zqUhEUbnbQOqIumkBzbzX2le+lJjRe
         knhYBW2zEevNoAAtnSwLsUuFjwI3+s2F4jsauy+i57DrSr6sJsnUu8QkwBGPfJJkRW53
         l3MMk/LO8NM7sFXXtPmx4cM8WWFjw+OlNsXTiHg9Xnq62l7B8mz1YJ9hUVhmc0Ljvce3
         1y4vC3aYkh1Mx1o8VJ8NOBBmvkuvz1YfatH4jzoxZRA/cy5KPnLz0ICilDiBzsxlkqXu
         GT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697731681; x=1698336481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmnPH3jDYtW1cB98XlzrlUIo9mVxEt9reMcjg2WxHC8=;
        b=Sy8u/+qMyCJwRx/m5PHkheycSdG7D/W1PKQ/aV5AQ0T+WLS1nnEPAieCTnIXorC+wq
         VuN1RYqCrmKOcqFvtsH2n9h2NiQjHJ4jj1cm0PfF63zoTvorAgRW7KIG4IRcRjLKyBvw
         pOkSX9zc893k5kwy38iIhU4RjerPbe9KQYF2HeF4MfiP9bp6dNAr6vaJ4agVphx5Gt/v
         X7IGojUpxspeG+dBc5laXs6XuGA8lBJ7dCJgbgWJ21sDJy2t4zw+FRuaVvvwNwUFesP6
         /M9vb3m84KsriK73lIr13gtiyouN4fox3YJBh9WPrE6yT9sNILri61mjdSaB8yUKMy6q
         BOcA==
X-Gm-Message-State: AOJu0YxZmhsf5W1IdqtwzdMyYIQd6EUST8H4ojqVCuThKhUnYONjLyUD
        5pL2cuRKIGWsE5oMBTvnQBnSmuD47VmpfULF7t4arTHGrtAvfjtSH1wWlA==
X-Google-Smtp-Source: AGHT+IHPuFi633mySCnbe0ZGBGyXz/IJghWhEsCcNBXTAdeFJmcdkN4S8Lai+E8TXcBbMAAf/tsksyjUOb9zmf2dMiw=
X-Received: by 2002:a0d:d9cf:0:b0:5a7:af46:d79d with SMTP id
 b198-20020a0dd9cf000000b005a7af46d79dmr2636378ywe.43.1697731681014; Thu, 19
 Oct 2023 09:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <ZST/WggW4hSVs9d4@gmail.com> <202310101642598576993@zte.com.cn>
In-Reply-To: <202310101642598576993@zte.com.cn>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 19 Oct 2023 09:07:50 -0700
Message-ID: <CAJuCfpHi=jN+8NF1n8-9U2b-Aw7hbt3NHgV=y55y=Wtd0FnRxQ@mail.gmail.com>
Subject: Re: [PATCH linux-next v3 3/4] sched/psi: update rtpoll_next_update
 after update triggers and rtpoll_total
To:     yang.yang29@zte.com.cn
Cc:     mingo@kernel.org, peterz@infradead.org, hannes@cmpxchg.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com
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

On Tue, Oct 10, 2023 at 1:43=E2=80=AFAM <yang.yang29@zte.com.cn> wrote:
>
> From: Yang Yang <yang.yang29@zte.com.cn>
>
> Update group->rtpoll_next_update after called update_triggers() and
> update rtpoll_total. This will prevent bugs if update_triggers() uses
> group->rtpoll_next_update in the future, and it makes more sense
> to set the next update time after we finished the current update.
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Suggested-by: Suren Baghdasaryan <surenb@google.com>

I believe Ingo's version at
https://lore.kernel.org/all/ZScQZLTssSfq19Jm@gmail.com/ already
includes this change.

> ---
>  kernel/sched/psi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 143f8eb34f9d..79f8db0c6150 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -704,12 +704,12 @@ static void psi_rtpoll_work(struct psi_group *group=
)
>         }
>
>         if (now >=3D group->rtpoll_next_update) {
> -               group->rtpoll_next_update =3D now + group->rtpoll_min_per=
iod;
>                 if (changed_states & group->rtpoll_states) {
>                         update_triggers(group, now, &update_total, PSI_PO=
LL);
>                         memcpy(group->rtpoll_total, group->total[PSI_POLL=
],
>                                    sizeof(group->rtpoll_total));
>                 }
> +               group->rtpoll_next_update =3D now + group->rtpoll_min_per=
iod;
>         }
>
>         psi_schedule_rtpoll_work(group,
> --
> 2.25.1
