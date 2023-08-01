Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CB876B5C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjHANZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbjHANZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:25:29 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD2F2737;
        Tue,  1 Aug 2023 06:25:15 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9b9f0387dso87350561fa.0;
        Tue, 01 Aug 2023 06:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690896313; x=1691501113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8OLUUybG7mywXTwGuAft0hB1qqA3p7z9IQpVXR4T64=;
        b=JqQeJgSHyLQSNQcOj7FmdWoTuJ9TUbYIwknCk4eQ0VYiypQQoQurFZ6XeBElynO9Jb
         POHxBxyRVIFYmQdfHcAat7OsVDTHHNy8NLsANdztx88j0UMNBv9MPV71zbV3M57TfwoF
         hZ8N3m2WbB6lmDPItpaEexfpbYFa0Q2OlgeZKmxCoIHPAJS5bpskA9w6/bbRLYaJleoz
         G5J0z0UWyNJ0eTep8B3M0GOS6Ko2eZWOcu/bkixRK+ZBPnQjGZghxlD67zTkscMQVMPA
         zlDw+wKw+KoT0PUM8gJbVIKlKjcx3qpT1ci3BST947WBRgnBWapGXr22ZdEqSjiL7LU/
         fjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690896313; x=1691501113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8OLUUybG7mywXTwGuAft0hB1qqA3p7z9IQpVXR4T64=;
        b=SBYLzX6mIt+LXIjlLsB5SMsTlOOQuRGCbuplQBU6d7a984M2mAYccMajCGFuN1bFrv
         WweajAr8fahvjItsStZ76P9hk5ztWKfF9fXamwGt/5DLPw3SKYmeQe2+Hjc7zU5+k5Q7
         a0YMGbnGQr1XjaJnbs7QI2fGSVCMT6IWiv9si7y77rXa1KKJagywGEzJs2J0uBSNw4ja
         bCNzqrwDAA4J8t5TRF1zYWpfB98szcl2eri9LQ483cGFOszZqiH/N7ICwLURbsWGqq+A
         wEi0dgAyVr1NLesjLvq61Uh3PaXEZhuYzun/5Z77UpBbDdPp5hTcarBOsn1YPxPQUXeZ
         NISw==
X-Gm-Message-State: ABy/qLZT82U2llRVtd5Dr564QGy3e+sUKrR7Cn8Ep7ennfYX2Yy8Bp7t
        5FYf2uyAUQ9QHfSNj7eRHBNpl7RRz1VXtIxpJX3F7WqU
X-Google-Smtp-Source: APBJJlF5jj2faYb4gUrVOiFGygQ7pjgK9lm26/bax2trfDz2tLI2QNlQor9YrRHvepN8raC/WeXMeMLjNTGPnVzUb2k=
X-Received: by 2002:a2e:3502:0:b0:2b9:e8a8:66ab with SMTP id
 z2-20020a2e3502000000b002b9e8a866abmr2373461ljz.28.1690896312994; Tue, 01 Aug
 2023 06:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230725220056.25560-1-jorge.lopez2@hp.com> <20230725220056.25560-3-jorge.lopez2@hp.com>
 <77867e93-7785-457c-9e37-4b41503bb509@moroto.mountain> <CAOOmCE_uRxqjTYueZkStbXeU5GKRUnvFOSGNhiBbtWDfkvxveg@mail.gmail.com>
 <2978ca9d-fbab-45b1-8d90-321fb9453965@kadam.mountain> <CAOOmCE_p_QgV0QJZKtYZD+t7Y9MzNOQ9sEkfSM88VoHDUCwdCw@mail.gmail.com>
 <0f8c1b87-e211-4ca7-bf92-8fde5bb77cd2@kadam.mountain>
In-Reply-To: <0f8c1b87-e211-4ca7-bf92-8fde5bb77cd2@kadam.mountain>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 1 Aug 2023 08:24:15 -0500
Message-ID: <CAOOmCE-z6S6LEvDq-nJPtK8c1FOapo+bH2cwTuGsA2JyMfx38g@mail.gmail.com>
Subject: Re: [PATCH 2/5] hp-bioscfg: Fix memory leaks in ordered_list_elements_from_package
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
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

I submitted a new set of patches as directed by Hans in which the
variable name 'int_value' was kept.
Thank you for replying back to me.

Regards,

Jorge Lopez

On Tue, Aug 1, 2023 at 12:54=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Mon, Jul 31, 2023 at 11:35:35AM -0500, Jorge Lopez wrote:
> > On Mon, Jul 31, 2023 at 11:16=E2=80=AFAM Dan Carpenter <dan.carpenter@l=
inaro.org> wrote:
> > >
> > > On Mon, Jul 31, 2023 at 11:03:42AM -0500, Jorge Lopez wrote:
> > > > On Thu, Jul 27, 2023 at 1:21=E2=80=AFAM Dan Carpenter <dan.carpente=
r@linaro.org> wrote:
> > > > >    134          int value_len =3D 0;
> > > > >    135          int ret;
> > > > >    136          u32 size;
> > > > >    137          u32 int_value =3D 0;
> > > > >
> > > > > It confused me that it's called int_value when it's not an int.  =
Just
> > > > > call it "u32 value =3D 0;".
> > > >
> > > > The variable is named int_value when it is not an int because it
> > > > stores the value reported by ACPI_TYPE_INTEGER package.
> > > > The variable will be renamed to  type_int_value;
> > >
> > > Eep!  That's even worse!  Just leave it as-is then.
> >
> > Oops!  just send a new patch using type_int_value.  Should I change it =
back?
>
> In order of preference for me, it's "value", "int_value", and
> "type_int_value".  But it doesn't really matter.  I feel there were a
> couple bugs like the size vs value_len and re-using the iterator.  You
> have addressed the real problems so lets not worry about variable names.
> Whatever you pick is fine.
>
> regards,
> dan carpenter
>
