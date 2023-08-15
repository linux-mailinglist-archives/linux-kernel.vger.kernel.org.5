Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460DA77D517
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbjHOVZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239630AbjHOVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:25:47 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F58B83;
        Tue, 15 Aug 2023 14:25:46 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bb94e3f39bso1932771fa.0;
        Tue, 15 Aug 2023 14:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692134744; x=1692739544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fsn1BYC28pKbTv/DGwjq5GDO0l4+lDtK9xLbNF1U0hc=;
        b=oFilqbmNYolS12BgmHX+rA9eYhaejNZGoVFBXpcqa7xXQesYJ9eCk2tvp7/AOzL3Mp
         9fT7cqORl3vNhJ+Hnb6pHRj93Is+2FJaKIR1GltWhxcBlNCEPgtL6z7uMRbgjsuhnmaN
         1R8vkMwLrdFpulORklxj5mjBbJa0gyO4stuS28h5X8uIP5iqiVmVYAJVnrB63PvuWi8L
         LE3k+CC4bGhlusscoYMZg1dYk69zfTGe8M0Hc7FFnzqeuxjJeuXp28jEH7dVmK0KTM0u
         3j2Z0VleKFx6JyJGtSWaB8ZPK7swEreS1sAX4KgtYJPXrMrRBtzXCKV5TWL8gz96JLWa
         ezXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692134744; x=1692739544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fsn1BYC28pKbTv/DGwjq5GDO0l4+lDtK9xLbNF1U0hc=;
        b=XjJ3VCmYhMmO5u2UaerhuZIuFyRMoSg+oCfmoeI3M9wOhg5O6ypwaHM1OurAeIqnTo
         H+/PDtJULC+EaGFVUxKisEk1C0Qced8/Di26gcskiG6RNF57FLoWXvQcGrFyeFmPp1Zt
         Wx8qteghKcHDHy6CMlC+QGttwefSm8/bPeD3SvIPA8sLfiCQxVAexwVyhBq0rDUMc+hK
         bJJvxA3gA8k+PX85kVcCdsoVhgqvs5cZ8fXyHGcvBzbwoI1t1BRPQffuAdJHgFWJwQUa
         F/bEaCvmFExi7JZZ17b23ZWqAeIFVwFt95xpZxEs3hKIg1u3ypRKuejARiE7r9uXTCjZ
         5NtQ==
X-Gm-Message-State: AOJu0YwtcMh05T3wUs5vTaUtA7qOenIMC6SLCxyP7VASpKe1htK4A2KU
        OgPHlUEASzIHBkC8nZ5zHcZL5+W6stIUtJlNii8=
X-Google-Smtp-Source: AGHT+IFtjDxOA0SNs7HByZJpVnAg9disIVdwlnm8TM8KyHidJFU6T8YXx7kOczPXBo5tB4m4xTyJHo9kOEohD35gx6g=
X-Received: by 2002:a2e:bc1a:0:b0:2b8:3c52:113 with SMTP id
 b26-20020a2ebc1a000000b002b83c520113mr13865468ljf.5.1692134744255; Tue, 15
 Aug 2023 14:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230711013140.54080-1-suhrid.subramaniam@mediatek.com> <ZNqlXsg82lSSi2fn@valkosipuli.retiisi.eu>
In-Reply-To: <ZNqlXsg82lSSi2fn@valkosipuli.retiisi.eu>
From:   Suhrid Subramaniam <suhridsubramaniam@gmail.com>
Date:   Tue, 15 Aug 2023 14:25:18 -0700
Message-ID: <CAHL1a13zGyRSD_w5RJbH6yFeXz-5aQ7Ds+XGM=310ERnZcZ4Dg@mail.gmail.com>
Subject: Re: [PATCH] media: v4l2: Fix documentation for 12-bit packed Bayer
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        suhrid.subramaniam@mediatek.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

I didn't know that the "From" field needs to match the "signed-off-by" fiel=
d.
If both need to match, please help me update both to
suhrid.subramaniam@mediatek.com
Thanks!

On Mon, Aug 14, 2023 at 3:06=E2=80=AFPM Sakari Ailus <sakari.ailus@iki.fi> =
wrote:
>
> Hi Suhrid,
>
> On Mon, Jul 10, 2023 at 06:31:40PM -0700, Suhrid Subramaniam wrote:
> > Fix documentation for R13 and R33 low bits.
> >
> > Signed-off-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
>
> This doesn't match with the From: field.
>
> I can fix it this time --- which one should it be? And please do fix this
> going forward.
>
> --
> Sakari Ailus
