Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8007CB683
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbjJPWU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjJPWUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:20:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373CDAC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:20:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53e3e7e478bso5781606a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697494850; x=1698099650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG0si0hLhsORLT+IsP0hdNRtcz8tUgPMz+/Y6er4krs=;
        b=ReM0Fklyoby7RKX8SNc+ywuzEYacTXjBbKFODxikwOXLXLDM2Y3szv59lbajRHqmGc
         yxkPn59JlYEXQ+kKDAKIztQ7Q0Rd7sZnC6JjWcYobSmAdVSLS5X3nXP1EBzdFPFw3ve9
         3rtMxV3R2rNxd6vxEGYpIEZXulYZ1gZScme/xOLVVPLFALxxBDG3VF3oksaZOEtBHRG3
         Rhy4gQYUctmO5lEaTr8lXjyRvs3qRo6thhFutMBaOIm72sc/48t7Z5Y2laIq1fo3pXpx
         05Rq2LwXa94zBR2XSUn7UJ/zkChHJ8ouD8Oz2n2O87qpIOWtbEF4pz+QQLEI2T9SLs73
         D9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697494850; x=1698099650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sG0si0hLhsORLT+IsP0hdNRtcz8tUgPMz+/Y6er4krs=;
        b=DzbV64Up1lX8Zr41Yn9Z1B1fSvTBDkewQ1gAiwXRhTbZ8wEXmtoeWXRgu6qDmnb7UF
         VjPLMW6as2MW7YTegdOH2LQRexdCxlkbXVYFQ6oAkHs8Zr6NmG0XVl7Q+FDbpXO48oxY
         cg3dFQjL1o1zNooz8rJS4MmAuxd9jpimkSrVQSWOlzEZL0fnc5bWz0GvyNM8WviVcj9B
         6DE7i/h92fMECbO7M1cIIsQqHWpDfmaENrhmRS/51PBaSIwLOwXanGQq5ktDKPo4IugV
         S/Vo3vEeJr+OJ05/ovazqhCPTZvnxRj3MWLY27NqJ9TWNIW/30fgBhG9UzlY38xyEish
         ivTA==
X-Gm-Message-State: AOJu0YwtxkLMIwKY1qJwy7i91XAaaK7hOxx951EPl3NzTTUkPLWVyJOJ
        YatCi88ystg7AdGtCMcO8AC+XfqerWxphQq3+E2LWQ==
X-Google-Smtp-Source: AGHT+IH4sUBuDdJbXWdg1g+aEaQi0NhdA683YD/+UNeUj/wXLDa1ObuFKvxOI7RdNEsEqBV2uXeZNwpNqktfeAb7+0Q=
X-Received: by 2002:a50:c2c1:0:b0:53e:d0cf:453c with SMTP id
 u1-20020a50c2c1000000b0053ed0cf453cmr441341edf.9.1697494850639; Mon, 16 Oct
 2023 15:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231012-strncpy-drivers-net-hamradio-baycom_epp-c-v1-1-8f4097538ee4@google.com>
 <20231015150619.GC1386676@kernel.org> <ede96908-76ff-473c-a5e1-39e2ce130df9@kadam.mountain>
 <FA371CE1-F449-44D4-801A-11C842E84867@kernel.org> <123F9651-9469-4F2B-ADC1-12293C9EA7FE@kernel.org>
 <2b9fa498-e099-4987-89d3-dd1a5df24705@blemings.org>
In-Reply-To: <2b9fa498-e099-4987-89d3-dd1a5df24705@blemings.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Mon, 16 Oct 2023 15:20:39 -0700
Message-ID: <CAFhGd8r4rZ71WrYPVVSXXKwXF5c4Z_D+830cRQacm_oijQB4SA@mail.gmail.com>
Subject: Re: [PATCH] hamradio: replace deprecated strncpy with strscpy
To:     Hugh Blemings <hugh@blemings.org>
Cc:     Kees Cook <kees@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <horms@kernel.org>,
        Thomas Sailer <t.sailer@alumni.ethz.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-hams@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 3:18=E2=80=AFPM Hugh Blemings <hugh@blemings.org> w=
rote:
>
>
>
> On 17/10/23 04:03, Kees Cook wrote:
> >
> >
> > On October 16, 2023 10:01:20 AM PDT, Kees Cook <kees@kernel.org> wrote:
> >>
> >>
> >> On October 15, 2023 10:47:53 PM PDT, Dan Carpenter <dan.carpenter@lina=
ro.org> wrote:
> >>> On Sun, Oct 15, 2023 at 05:06:19PM +0200, Simon Horman wrote:
> >>>> On Thu, Oct 12, 2023 at 09:33:32PM +0000, Justin Stitt wrote:
> >>>>> strncpy() is deprecated for use on NUL-terminated destination strin=
gs
> >>>>> [1] and as such we should prefer more robust and less ambiguous str=
ing
> >>>>> interfaces.
> >>>>>
> >>>>> We expect both hi.data.modename and hi.data.drivername to be
> >>>>> NUL-terminated but not necessarily NUL-padded which is evident by i=
ts
> >>>>> usage with sprintf:
> >>>>> |       sprintf(hi.data.modename, "%sclk,%smodem,fclk=3D%d,bps=3D%d=
%s",
> >>>>> |               bc->cfg.intclk ? "int" : "ext",
> >>>>> |               bc->cfg.extmodem ? "ext" : "int", bc->cfg.fclk, bc-=
>cfg.bps,
> >>>>> |               bc->cfg.loopback ? ",loopback" : "");
> >>>>>
> >>>>> Note that this data is copied out to userspace with:
> >>>>> |       if (copy_to_user(data, &hi, sizeof(hi)))
> >>>>> ... however, the data was also copied FROM the user here:
> >>>>> |       if (copy_from_user(&hi, data, sizeof(hi)))
> >>>>
> >>>> Thanks Justin,
> >>>>
> >>>> I see that too.
> >>>>
> >>>> Perhaps I am off the mark here, and perhaps it's out of scope for th=
is
> >>>> patch, but I do think it would be nicer if the kernel only sent
> >>>> intended data to user-space, even if any unintended payload came
> >>>> from user-space.
> >>>>
> >>>
> >>> It's kind of normal to pass user space data back to itself.  We
> >>> generally only worry about info leaks.
> >>
> >> True but since this used to zero the rest of the buffet, let's just ke=
ep that behavior and use strscpy_pad().
> >
> > I'm calling all byte arrays a "buffet" from now on. ;)
> >
> A tasteful change to the sauce I think.  ;)

Just perfect that this is happening on a **ham**radio driver.
