Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1BE7BA7D3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjJERVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjJERVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:21:10 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C0B30E3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:15:22 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d81adf0d57fso1370404276.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 10:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696526121; x=1697130921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kZZ+LzTQhw7SnaWxRb1LSoI3AuNMSpArazM0mZwyHk=;
        b=jFAzAjhe//Btj9YfCdZ4387UR49Vd+7ggJwFZ13BjOPQeN9j1s9FpTpO7aM6nNp5id
         Aml1Yeu6QV4t0/jbppFGa7n+Tk4BjXgFOBrN/i7+u9WF+c5E+6aVZl4CB+vULu3W3e0d
         Xkrj8WwscBRlLoSsRLAaMU+fMV+qsyidhpe64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696526121; x=1697130921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kZZ+LzTQhw7SnaWxRb1LSoI3AuNMSpArazM0mZwyHk=;
        b=IIyMoDF+76zPERfxk0FvUA2+dEVp+q4bk9qjQibenxfnoY57qII/MNaXAFMREi7lCr
         AKwnb+vIY93FCKXN+N+ewXx+ozaQsiRmzXkvBScL/KSqgCdGkXjaGhWoinByjKTfiUf1
         7vSyASaaAVJi8e6ORCN0eomfqUC02ouKFnhr/X7xNwa3FuAJIlH1GSvdsfL7jZTccp5p
         GdcrUUE2cST7poTYxyPrTFr0+XMVwnq8TIHk5mUaOJHw5aZd7lmKBaoVliJV+Qf9W5av
         PJBJ55AZYXhyMmVWwdPN0+mN6J2bn9w5t3FHihP/hlkLrWaJp0knaXyiLK/ZMC2/yM0J
         EdoA==
X-Gm-Message-State: AOJu0YyQ7qcCq5XyoOiWiAOpujKhiAYC9/yZSFkXDVT0WkxNho/l6uQP
        QNE/yErk9+1fWjsCeVBh7Mu3wBWSEVerarjcuPE=
X-Google-Smtp-Source: AGHT+IG8a7HPQoajuAvbAXftW2p0Yxvt1vc+IAgNfQvkP6qwN0gVyJdneABxMnYG2Q+CIxWCl2LKbA==
X-Received: by 2002:a05:6902:251:b0:d86:5844:a897 with SMTP id k17-20020a056902025100b00d865844a897mr5288463ybs.5.1696526120961;
        Thu, 05 Oct 2023 10:15:20 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id v14-20020a0c9c0e000000b00655e2005350sm660053qve.9.2023.10.05.10.15.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 10:15:20 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-419768e69dfso22391cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 10:15:20 -0700 (PDT)
X-Received: by 2002:ac8:5786:0:b0:419:79c0:ef9a with SMTP id
 v6-20020ac85786000000b0041979c0ef9amr180288qta.6.1696526120141; Thu, 05 Oct
 2023 10:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com> <20231005170413.GB32420@redhat.com>
In-Reply-To: <20231005170413.GB32420@redhat.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Thu, 5 Oct 2023 10:15:06 -0700
X-Gmail-Original-Message-ID: <CACGdZYJm312U70ysC_vpv=Pat063R=mRRVQGBiLocKc+QCkjnQ@mail.gmail.com>
Message-ID: <CACGdZYJm312U70ysC_vpv=Pat063R=mRRVQGBiLocKc+QCkjnQ@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Li Nan <linan666@huaweicloud.com>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 10:05=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> sorry, didn't notice this part before.
>
> I am not a asm expert (to say at least;) but
>
> On 10/05, Li Nan wrote:
> >
> > When (a * mul) overflows, a divide 0 error occurs in
> > mul_u64_u64_div_u64().
>
> Just in case... No, iirc it is divq which triggers #DE when the
> result of division doesn't fit u64.
Yeah, sorry for my incorrect wording here - but we're probably seeing
exactly that the final result doesn't fit in u64. (I wasn't familiar
with the intermediary registers here, thanks for explaining)
>
> (a * mul) can't overflow, the result is 128-bit rax:rdx number.
>
> Oleg.
>
