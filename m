Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986C078CEB3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbjH2VS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239233AbjH2VSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:18:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CC1CE6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:18:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5232ce75e26so1322a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693343803; x=1693948603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JDg++JLK9SGJM0OSEHQEmui+Dw6sEaDtzFZmJYr70c=;
        b=HfKUna/fJ86MfYq+luOtgu4BAkbUqoM0NbuMnoik86BcuQpFyCF6FNlS4YsrNbqn9m
         80KzAVupBTKhF7ZqYFOKON87YQQKjaLOhzO4L9Ee2NI6IRcyTu4/MM80AT2NG/24aDAA
         78eKp8+pRVFWqjbjpuqYmbK9gqts2nU7v+pD00hw5EbtPrX2VsU7PCrh3hZ8vyuEh+xB
         V6mqQvSkmLn3yJRSJfQi2dWXqnTP+GRFFeNG2CmjI7K8ERSmqMK4WGM+zdkw38lzz7K5
         ddJmJebOvRbtHOCegSDcORUsPJbvkTbH6g8Wz3Js7I1PktMZIkuITP3Avy93KZuhd+Bc
         /qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693343803; x=1693948603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JDg++JLK9SGJM0OSEHQEmui+Dw6sEaDtzFZmJYr70c=;
        b=PoZuNKynUWQLXHB3AF0PgPbqPL91sTqXFJLp1jgDqXLKbwyed75ZDXmRHEgu8Vqdgq
         sVQdo09KP1hwyLIF+Byiuuap8tzV+Qy8EuTq9FrHr7MwSQDRVbO6L1NeMyRTva/ycOlU
         GHFlUdTgwFUvpRYHkchx+Ia+abW/O2++sDDyF34pLU/xufcsZ9CFbtj7WGPwDZ1mZtdd
         iu/afsjy2T6wA2Cc8xmlmLy9NJSGzAXpamLyd6b5BJU8jTqy8zbIT0qSWHDjWyReNFl+
         JpECPnYRHwVwaN1Sju+BG0PQjiVfSvNUms0GZR9oAdpbK+QZhLyVRzZzhNL7rbtd6Pjk
         XyrQ==
X-Gm-Message-State: AOJu0YwGwZ0MnXuljSNlqUsULvcPR5yLwufb6IsK2xOyQ9vIjNSF207T
        AKSbXQETRhEf+qLGuBJIoyGHzHOzVelje8PphSSP
X-Google-Smtp-Source: AGHT+IHaCuV9fTsA5zFnvErDgqfBk0IppZc+IkjfIanekx6e4CGWrGxIlpv2T/MYzhSyK3qS7kqwdZPEgm9Ipy2SJ0c=
X-Received: by 2002:a50:9f87:0:b0:519:7d2:e256 with SMTP id
 c7-20020a509f87000000b0051907d2e256mr273879edf.0.1693343802587; Tue, 29 Aug
 2023 14:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230825233930.1875819-1-yabinc@google.com> <382193a4-4f30-d804-47da-a9c705b6bee5@arm.com>
In-Reply-To: <382193a4-4f30-d804-47da-a9c705b6bee5@arm.com>
From:   Yabin Cui <yabinc@google.com>
Date:   Tue, 29 Aug 2023 14:16:31 -0700
Message-ID: <CALJ9ZPNQAWCLrK4u+j3vMZmu3TaLUN_Ne+yqetkquU2QS_XQFQ@mail.gmail.com>
Subject: Re: [PATCH] coresight: tmc-etr: Don't fail probe when non-secure
 access is disabled
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

> How can this be enabled ? Why not enable it before probing the ETR ?
How can a user know if this has been done or not ?

Pixel devices (like Pixel 6, 7) support enabling some debugging features
(including granting non-secure access to ETM/ETR) even on devices with
secure boot. It is only used internally and has strict requirements,
needing to connect to a server to verify identification after booting.
So it can't be established when probing ETR at device boot time.


On Sun, Aug 27, 2023 at 2:37=E2=80=AFPM Suzuki K Poulose <suzuki.poulose@ar=
m.com> wrote:
>
> On 26/08/2023 00:39, Yabin Cui wrote:
> > Because the non-secure access can be enabled later on some devices.
>
> How can this be enabled ? Why not enable it before probing the ETR ?
> How can a user know if this has been done or not ? It is asking for
> trouble to continue without this.
>
> Suzuki
>
> >
> > Signed-off-by: Yabin Cui <yabinc@google.com>
> > ---
> >   drivers/hwtracing/coresight/coresight-tmc-core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers=
/hwtracing/coresight/coresight-tmc-core.c
> > index c106d142e632..5ebfd12b627b 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> > @@ -370,7 +370,7 @@ static int tmc_etr_setup_caps(struct device *parent=
, u32 devid, void *dev_caps)
> >       struct tmc_drvdata *drvdata =3D dev_get_drvdata(parent);
> >
> >       if (!tmc_etr_has_non_secure_access(drvdata))
> > -             return -EACCES;
> > +             dev_warn(parent, "TMC ETR doesn't have non-secure access\=
n");
> >
> >       /* Set the unadvertised capabilities */
> >       tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
>
