Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F17478F367
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347181AbjHaTgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHaTga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:36:30 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A3C1BF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:36:27 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b9a2416b1cso983248a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693510587; x=1694115387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCiPgoXQWEUQbwvtwHdYNndBee5s7p9DuINjKcE7kL8=;
        b=Wpme7mRRYRB8Eu9z0Ix1CQjvYIsWPZGDFBuxX2QyhD+a5v9I6tvBy6dSTCKusIdqOv
         9BHuMccLwBLgbNvoj7UUxfKZZoz982sKDvYDamyb4izRvVNAke5kRt+Y3th2W0pvZcrC
         FrEHm6AQHNWozBhcsoDGfY3KinFPr5E3GQVaLZyuELhnAIlN1TPop10WuAoCwv7ItlJu
         eq1MhqGJxfad1y7Bgvz42S/ifKCmUQhG64CwXGfAsq6QhLN6A6Y3Qrs17IvZrdOkTbpH
         ap0Jz+41q2gmrrKGaNKp7s8vfmSbiD80uMpfJNnaV574wYBrq8bP+LmRQSrGpRy/77yX
         4AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693510587; x=1694115387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCiPgoXQWEUQbwvtwHdYNndBee5s7p9DuINjKcE7kL8=;
        b=EJwU/HKhiG3p0BSsm8xNDe7JkHxmvtu9Yb76vSnVGepDqKAmKdcUP6Mjc1a7je2xic
         eBYk/qd+H2DVlUK4K1oQ2++8G2fhP53bbfe3Hqu4KuAL2Ll90CXROnGajv/oWjrWbr5+
         idgVZTLQkuQubDcwC03hxw7kWR65m2/u7pQb8lVqoQvwQUTkpVzzdXtDeRlDMwKpaDvS
         urOG3ZW6CXywSSpt7qkqcjtR18/Oyqv/7+YgkE+P8G2Opp2mcd5cpf0A9BK0cmTWXwWO
         VIAXfRDeFkNR5KqSnQrS6Hv9LhRfSPLgwLYmzYJkzfUS9t9ynI7duVxx8ckm/SPAvFUz
         GBcg==
X-Gm-Message-State: AOJu0YxuNtTfpJn/qP9jmgukHqzTa2wtGSUAq+MW3NnegG+9XfO0VnO7
        69eevokzSPRSy8Q8mRUMBaMZqZouATt28oNoixI=
X-Google-Smtp-Source: AGHT+IHwy/eGATABWvMti7NtZTgzOtSNMp1UCCaV2bdNv13/dXZgs47g5hDqQNvAQFDKIgI9B6TB+j7Lfty+7VJeYeg=
X-Received: by 2002:a05:6870:8288:b0:1bf:7e94:bbb5 with SMTP id
 q8-20020a056870828800b001bf7e94bbb5mr472364oae.7.1693510586972; Thu, 31 Aug
 2023 12:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140103.311752-1-dii@itb.spb.ru> <3ba3a7da-77d7-4a13-899c-e7a1f5b68a42@amd.com>
In-Reply-To: <3ba3a7da-77d7-4a13-899c-e7a1f5b68a42@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 31 Aug 2023 15:36:15 -0400
Message-ID: <CADnq5_NvD3CC=awhR4jqSb3GNYQfdFZDk3XX7pVyJfeU06kqiQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove useless check in should_enable_fbc()
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Dembskiy Igor <dii@itb.spb.ru>,
        Alex Deucher <alexander.deucher@amd.com>,
        lvc-project@linuxtesting.org, Leo Li <sunpeng.li@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hersen wu <hersenxs.wu@amd.com>, amd-gfx@lists.freedesktop.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Aug 31, 2023 at 2:48=E2=80=AFPM Harry Wentland <harry.wentland@amd.=
com> wrote:
>
> On 2023-08-30 10:01, Dembskiy Igor wrote:
> > It does not make sense to compare a pointer to array element with NULL.
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > Fixes: 65d38262b3e8 ("drm/amd/display: fbc state could not reach while =
enable fbc")
> > Signed-off-by: Dembskiy Igor <dii@itb.spb.ru>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.=
c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > index 6966420dfbac..e87cf54ec658 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > @@ -1992,9 +1992,6 @@ static bool should_enable_fbc(struct dc *dc,
> >
> >                       pipe_ctx =3D &res_ctx->pipe_ctx[i];
> >
> > -                     if (!pipe_ctx)
> > -                             continue;
> > -
> >                       /* fbc not applicable on underlay pipe */
> >                       if (pipe_ctx->pipe_idx !=3D underlay_idx) {
> >                               *pipe_idx =3D i;
>
