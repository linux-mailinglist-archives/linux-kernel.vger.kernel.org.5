Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEE0773C7A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjHHQGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjHHQF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:05:27 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CDE2D71
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:45:28 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe48a2801bso9602769e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691509527; x=1692114327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oj2ai9zvS+9QZOskCM8RXfhgWWD2kjSbmwS4f6JevAw=;
        b=NvlUqdxNvIetH93wvK+sVx+G2EsRHuY8anUrshSQZtUqZxcDQ8A9D+ML55pMPRa5+5
         cVRAY/RRvU9ZlCaU7iOe1zeC9lG0gDTNrknBnvuiiEnN0GKdKTkS57/7/xdytt7/ny3d
         c2aRtmxok6N2UjCVTCsNPMpBGPHudeglvQYffLmCN9NJgkPXyvlzoDG2Wb6wKnde7dJv
         yiQEt/IlfYO1Rsko+FJPDrv5oA5YirE0W9zxzVZUidncsqY8Hc48OVfDjzO2Uhq9k2dK
         rTjgfI/8eQxTbDBnKk188bOIYcRIUjLbpmETd0phDXBJa9DtOjMNOkvc9bOZcScd3nEG
         4wlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509527; x=1692114327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oj2ai9zvS+9QZOskCM8RXfhgWWD2kjSbmwS4f6JevAw=;
        b=NVeMsCytmkr/EqPOmt37AhwZwOTH51S+csR0TPb90GB+kNbErRsO0C3713PlntfNLn
         EQrMyEGtobbOZUFqvq6p74hhX/3VjT+PdaBZ9DtdAlmU9yg0c945qQA0z9NSdkmSRVC/
         NvAfxgaxG+oZJw6CwDRkNvA3oNNfGF7sDNQSZfZYE4uet8rOoXzYFGpJnNJwAREaTZg4
         iYk01HqvGxDHin4Iy8sAvzEgy7VEJ9KIHWkg1uIM3vaR7lJukfX5ZzzGwCF8Bzm9Sfsm
         U3QNh2NiK2IOrMGAtsgiNZkpLZfanUEaAr1AJ+kjQIesi7CtyNOocNHWwSYM80TwZ+pH
         93qQ==
X-Gm-Message-State: AOJu0YzNXrmcjxCDuMZzHnp4N2CO4dZzsBwEM9PyyfmyQ8VXiYgM7kRq
        TSwy7FGUbsx4KPd11JdLODbUJ0iptEd93f30lC03ufi5xKo=
X-Google-Smtp-Source: AGHT+IFfju5o1lWIv3wyfHE+qyETz1vJSnBk2q+GZQ6BY2VK2b4Baqqt+9vLWQ3xkBaRGglOIQJ0QqulvLM+5Af0FWA=
X-Received: by 2002:a17:906:109b:b0:99b:d977:c00c with SMTP id
 u27-20020a170906109b00b0099bd977c00cmr10395304eju.45.1691488763617; Tue, 08
 Aug 2023 02:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <1691401475-3796-1-git-send-email-hyeongtak.ji@gmail.com> <20230807181409.97310-1-sj@kernel.org>
In-Reply-To: <20230807181409.97310-1-sj@kernel.org>
From:   =?UTF-8?B?7KeA7ZiV7YOB?= <hyeongtak.ji@gmail.com>
Date:   Tue, 8 Aug 2023 18:59:13 +0900
Message-ID: <CAFY0u4Q32yX+O57D+Eh_x6yVwQv2EcqvuxtQxG1msd8RqQy0zQ@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: Prevent unnecessary age reset for regions
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hyeongtak Ji <hyeongtak.ji@sk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thank you for your review. I really appreciate it.

On Tue, Aug 8, 2023 at 3:14=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Hyeongtak,
>
>
> Thank you for this patch!
>
> On Mon, 7 Aug 2023 18:44:35 +0900 Hyeongtak Ji <hyeongtak.ji@gmail.com> w=
rote:
>
> > DAMON resets the age of each region after applying each scheme,
> > regardless of whether the scheme has been successfully applied.
> >
> > This patch adds a simple condition to prevent the age of regions from
> > being reset when schemes have not been actually applied.
>
> We consider applying the action as making a change to the region, and hen=
ce
> reset the age to zero.  Even if the action was not completely applied,
> that might be enough to make some change to the region.  The behavior is =
also
> to limit a scheme too repeatedly and frequently applied to a region.

This is what I have totally overlooked.

>
> So, this is not a bug but an intended behavior, and I think this change m=
ight
> not what really necessary.

Now I understand that this patch is not necessary.

>
> Is there a specific use case that this change is needed?  If so, I think =
we can
> think about extending the interface to support the case.

Not for now, but if I find any use cases for this situation, I will
let you know.

>
>
> Thanks,
> SJ
>
