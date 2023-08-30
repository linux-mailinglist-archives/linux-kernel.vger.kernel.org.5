Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1B378DF33
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244730AbjH3TPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343981AbjH3RtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:49:23 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A05193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:49:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so931a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693417759; x=1694022559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKewVGIDV6TqlL+FLu3qopIAxvaZvQ3E/KnipLyePBk=;
        b=v5meOtT4VdRv8bEzBSRTIeIdZpbyzS+f51/wX02MytvnYbzLieWuf/hLj8xlwdQ53x
         4+GLyOq7DbNcINGT1+p0Ir8WuvyajeLgtF4Ufwh9iQ8FZXM/SNvtwWANdj/V3OoAexu+
         mi99SPmz8Tr0gaebNLjFY4dTlpjlOyMsgK7rVvan6PLsyup+Wq+UBS7Gjqn62ocGhZVf
         2OBWH1VjTaJKjf3bS+VI17znhUOsgdhpcxelfDLgG+Wbu/SNjdORD5IL5wnhMLsabzjb
         K5Qkuk9N0bq/qE7qGJuoryiItLe9aQiB5iUcl1Bdod5xbijMUNEJ81EoKnuKFr+Nm2Ug
         NC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693417759; x=1694022559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKewVGIDV6TqlL+FLu3qopIAxvaZvQ3E/KnipLyePBk=;
        b=E8FY6/CWoMjjna9LDt01KWGJqljfLLPvjiCn444O9mC5pVUDyNdYU+5/JNyOXYw5EW
         YphdXwFg8LX/VP1snEhRmrzPKmtQY/pEa56u2W+5eYQJ1gL4YhiWvEID0Lia12CRfb3A
         jfCd7Ha9+dWtI7sIjyDHNNZkWLpY/w8VXsEAgKZIQXveLzE+IWpeDpS40RWMy1Adi3zM
         8ReWv0Zkqho8HBnJMMAL7kqoT83nX3jeaLndiSuSWuRegFZkvBbbgpQ2kFk0gW45PUuH
         +YoDeQ21ftZZiC7o/US9vWgy0pRImQJ+EubZQNgnqP9ALaxzbYVPfNnTR/9UqHzxpeoq
         qLmQ==
X-Gm-Message-State: AOJu0YwaxDGD4JIUpgvVTCTEvVUzehkgWKX3kSAjlbH6+Y3cLLLeGYIG
        brKsBI+UF2+gnZzMWw4LOO7dsdJzH5kPmxXll5Pv
X-Google-Smtp-Source: AGHT+IFqdam2Q5xYhAqVNhAoYWgRMfS9zEXBwDdbu3yUSkQW7fcAYyrg8OSKDPxQtJ8m6W3+4U9US4Up8lm5jDMPbPU=
X-Received: by 2002:a50:9f85:0:b0:51e:16c5:2004 with SMTP id
 c5-20020a509f85000000b0051e16c52004mr8964edf.6.1693417758483; Wed, 30 Aug
 2023 10:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230825233930.1875819-1-yabinc@google.com> <382193a4-4f30-d804-47da-a9c705b6bee5@arm.com>
 <CALJ9ZPNQAWCLrK4u+j3vMZmu3TaLUN_Ne+yqetkquU2QS_XQFQ@mail.gmail.com> <034c226d-7d0f-849c-45ae-a909839a4d2e@arm.com>
In-Reply-To: <034c226d-7d0f-849c-45ae-a909839a4d2e@arm.com>
From:   Yabin Cui <yabinc@google.com>
Date:   Wed, 30 Aug 2023 10:49:05 -0700
Message-ID: <CALJ9ZPODSc0R=B4yJb2QO3f+gmEaBHO7ZZQy3bNRp+jz3rnr9Q@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

> Are you not able to build the coresight drivers as modules and load
> them after the device has been authenticated and NS access enabled ?
> Running a trace session without NS access enabled on a normal device
> would be asking for trouble in the "normal world".

Theoretically we can load coresight drivers after getting NS access.
But in practice,
it makes the userspace work more complex. The process will be as below:
1. Use device specific checks to know if we have NS access authorized.
    Because we can't use the general coresight sysfs interface to read
authstatus.
2. Load coresight driver modules.
3. Use ETM/ETR.

It needs to add device specific checks in Android AOSP code (which we
don't prefer),
and add an extra step to load driver modules. It's more complex no matter w=
e do
it in a daemon or want to use ETM/ETR manually.

If we can load the coresight drivers at boot time. The process is
simplified as below:
1. Use the coresight sysfs interface to read authstatus. It works on
all devices.
2. If authorized, use ETM/ETR.

The authorization used on Pixel devices can be granted/revoked while runnin=
g.
So not allowing loading coresight drivers doesn't help us. We always need t=
o
check authstatus each time before using ETM/ETR. And the check can be
easily added in tools using ETM/ETR.

Thanks,
Yabin

On Wed, Aug 30, 2023 at 1:52=E2=80=AFAM Suzuki K Poulose <suzuki.poulose@ar=
m.com> wrote:
>
> Hi Yabin
>
> On 29/08/2023 22:16, Yabin Cui wrote:
> >> How can this be enabled ? Why not enable it before probing the ETR ?
> > How can a user know if this has been done or not ?
> >
> > Pixel devices (like Pixel 6, 7) support enabling some debugging feature=
s
> > (including granting non-secure access to ETM/ETR) even on devices with
> > secure boot. It is only used internally and has strict requirements,
> > needing to connect to a server to verify identification after booting.
> > So it can't be established when probing ETR at device boot time.
>
> Are you not able to build the coresight drivers as modules and load
> them after the device has been authenticated and NS access enabled ?
> Running a trace session without NS access enabled on a normal device
> would be asking for trouble in the "normal world".
>
> Suzuki
>
> >
> >
> > On Sun, Aug 27, 2023 at 2:37=E2=80=AFPM Suzuki K Poulose <suzuki.poulos=
e@arm.com> wrote:
> >>
> >> On 26/08/2023 00:39, Yabin Cui wrote:
> >>> Because the non-secure access can be enabled later on some devices.
> >>
> >> How can this be enabled ? Why not enable it before probing the ETR ?
> >> How can a user know if this has been done or not ? It is asking for
> >> trouble to continue without this.
> >>
> >> Suzuki
> >>
> >>>
> >>> Signed-off-by: Yabin Cui <yabinc@google.com>
> >>> ---
> >>>    drivers/hwtracing/coresight/coresight-tmc-core.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drive=
rs/hwtracing/coresight/coresight-tmc-core.c
> >>> index c106d142e632..5ebfd12b627b 100644
> >>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> >>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> >>> @@ -370,7 +370,7 @@ static int tmc_etr_setup_caps(struct device *pare=
nt, u32 devid, void *dev_caps)
> >>>        struct tmc_drvdata *drvdata =3D dev_get_drvdata(parent);
> >>>
> >>>        if (!tmc_etr_has_non_secure_access(drvdata))
> >>> -             return -EACCES;
> >>> +             dev_warn(parent, "TMC ETR doesn't have non-secure acces=
s\n");
> >>>
> >>>        /* Set the unadvertised capabilities */
> >>>        tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
> >>
>
