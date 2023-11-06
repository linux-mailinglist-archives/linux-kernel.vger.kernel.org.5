Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8847E2AA6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjKFRIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjKFRIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:08:36 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DBED47;
        Mon,  6 Nov 2023 09:08:32 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2892014a12.2;
        Mon, 06 Nov 2023 09:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699290511; x=1699895311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zfoDrt1e9fCUXEtYpas/Vn47svbwQXQsu/mnzQxCLU=;
        b=kZNoR4BWO8WtU3CTnC+sjWl+726Heq3HupxyJWrhPHFAXX93VtNIECUnVpjdnNxQSJ
         ax04fyMZe3j7J+FG2Fqtuy01AS3yQFw2sqzx3dLj5Hwq3N0zrdoZzTfwUJlkpTx8fbTB
         wcI0/frJWP7wC5Mgy+QSgEQeAx62NIvZ/oevlgXHOWHkDW4q+A/4aqtmS2I7ZbMqnCL3
         hWQJPpbET8oRoAsyF/ujTEGOXDdcmKu1yK3Up3Y9UHDrm7ATApOFXdzCMjnugpD8sdOx
         cQGVJ8Avu0SUK7DWhWkIlmMU/bm2SFMZ11OwTwPH8YSUPLPuwwzw2yEJ0jLJs8H36/0+
         85BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699290511; x=1699895311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zfoDrt1e9fCUXEtYpas/Vn47svbwQXQsu/mnzQxCLU=;
        b=mFr4/buuljYos3knxjAYaT+tbm0VhhbCGyHnD9zwCY14ADRaOgYryS3JP3LT/oDz+V
         wc0maThPKivAsFymkl13EArySZwvDsRd8K6X6SoI8xOpvjvztNN1hjuzGOBrzBoTkhzt
         uhXnBvHWlaRH4ZSA4BCR9Cn8b63poIkWHd7JJBm/qa5VPfjif3hmINZzsFAJcwYHEXmY
         HnM7s0duDV6xe+/Pgm4UuOgunY9/KsiI7rljjaa6a2ucjRWzTzekXrlMBq83/N3Sdwb6
         Q7xkRUa05l5gNg1bS8EMazSdogS9JFRJuOk9zARIiUbePZpF+s25m9xGzadjAqikav1K
         TF1A==
X-Gm-Message-State: AOJu0YwOakLLPOcCQm8xwKthyGuzxxY/0Y2h39ZmBqnRbrp0YHufQyP6
        PQB/+x3OuTf6ma2voOYAXf+rFODMAQpECzxwiww=
X-Google-Smtp-Source: AGHT+IGUg1ociNXol7xR6OAA0jZBUsIUoo8cClk/i/igaI4/ds2fB5KIC8oYFd7ZACVTHps5QDGjlL1HowmQgQhWo10=
X-Received: by 2002:a17:90a:1a17:b0:280:2c55:77c5 with SMTP id
 23-20020a17090a1a1700b002802c5577c5mr19651657pjk.46.1699290511444; Mon, 06
 Nov 2023 09:08:31 -0800 (PST)
MIME-Version: 1.0
References: <20231106130309.112650042@linuxfoundation.org> <2665d8bc-111c-45ca-a473-b1c892867e9c@oracle.com>
In-Reply-To: <2665d8bc-111c-45ca-a473-b1c892867e9c@oracle.com>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Mon, 6 Nov 2023 09:08:20 -0800
Message-ID: <CAJq+SaCqtQwk+eCgXT9jQU33Ufqr+aOaQq+VsXHCqdc1Qp8Vkg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/128] 5.15.138-rc1 review
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        mizhang@google.com, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
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

>
> On 06/11/23 6:32 pm, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.138 release.
> > There are 128 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> > Anything received after that time might be too late.
> >
>
> I am seeing a build failure with perf:
>
> tools/perf/util/evlist.c: In function evlist__add_aux_dummy:
> tools/perf/util/evlist.c:266:31: error: implicit declaration of function
> evlist__dummy_event; did you mean evlist__add_sb_event=C3=A2=E2=82=AC=E2=
=84=A2?
> [-Werror=3Dimplicit-function-declaration]
>    266 |         struct evsel *evsel =3D evlist__dummy_event(evlist);
>        |                               ^~~~~~~~~~~~~~~~~~~
>        |                               evlist__add_sb_event
>
>
> I think we should drop these three commits:
>
> 20a5799cae7dc perf evlist: Avoid frequency mode for the dummy event
> 7de783c81c7e7 perf tools: Get rid of evlist__add_on_all_cpus()
> 141ce9207068e perf evlist: Add evlist__add_dummy_on_all_cpus()
>
> Backport was requested here:
> https://lore.kernel.org/stable/CAL715WLTjMGQrhm6wWqFSeL_Oq-HzoQd5CqewvLRL=
v0Xbnibgw@mail.gmail.com/
>


 Just tested perf build, I see the same errors:

tools/perf/util/evlist.c: In function 'evlist__add_aux_dummy':
/linux/tools/perf/util/evlist.c:266:24: error: implicit declaration of
function 'evlist__dummy_event'; did you mean 'evlist__add_sb_event'?
[-Werror=3Dimplicit-function-declaration]
  struct evsel *evsel =3D evlist__dummy_event(evlist);
                        ^~~~~~~~~~~~~~~~~~~
                        evlist__add_sb_event
linux/tools/perf/util/evlist.c:266:24: error: initialization makes
pointer from integer without a cast [-Werror=3Dint-conversion]

Thanks,
Allen
