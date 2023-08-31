Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB4378E575
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 06:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbjHaEh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 00:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjHaEhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 00:37:55 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E194CC;
        Wed, 30 Aug 2023 21:37:52 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b962c226ceso7656661fa.3;
        Wed, 30 Aug 2023 21:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693456671; x=1694061471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kgm47R/hP2WPoxCYKzwQ8hYjC4H8YP95lf0UAZXLc5g=;
        b=bgCZpSO5O0zOQMwc3YGHtYwAIsAJZNe8VwHUYSIqq9jmgerszrcHfmXZsbbJl5uymw
         dN93Vf5PCayr1L6HpBF7X/Ilc/pTCIKkXUWXt2gAma2oSrwRugpPPkTRrB8iCvnpMBzE
         OuPPJZZBhqUWdIDHtbQJNgYaCWarn3d0mugWK1z95j6UEG5Lo7M3pbI7a6jaUM4D/25x
         9LTbPqvnt6zEhGITRxisnUAgmjwqSXUwvswWmDGN9bviuPwnXP9wM5JonvUwT7qsIKVE
         CncAbFX2dsPQOjuIiV4SrtNmkuO/jxbDiiTXoOIpuPemSjSr9iiE39VbnktmGAk0uCD+
         wvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693456671; x=1694061471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kgm47R/hP2WPoxCYKzwQ8hYjC4H8YP95lf0UAZXLc5g=;
        b=QaK8hjA8Uh9YYip2OPvH1IzwJsxcHvIj+/qNyv7Wc7lJaF5MM0zsNiraSUXuSb2zMy
         +A0L2329XMBpSwQheRXz6tFMBuuYWi/KCgwu8t8ad0/T1lTS5+0gTCp24YFFAQYpKqYN
         3yxuTT+7Q7anZODwrwX4zG9WLkXxg0y+J1R77HrKU/wqX/Op14Pg6ZYccAcrTVxwXBDj
         yjy5FMqDH3Gz5H+5SLsnEl1921EHOMmtRp6RC1Vsjgi5EBM2iumbZ3kPYGR9l0qGzY2Z
         ahOvx8i/dt2zuE92YQV1UV3Jx8LZHRpAEWntQz2lbJ9Xf3sV2RLltoSr+sFxSJ3SwZVL
         DZLg==
X-Gm-Message-State: AOJu0YxN/VipNk6IXMJw81/oAjgYS6JC/0KfYPFTEr1lD2K2C6nY3Pf8
        0KOTOV62FGWTBNu0ZufRKgKkFqQ//BiACiThhMnII/+/XFzS5A==
X-Google-Smtp-Source: AGHT+IHGlOk0zzJJY1c/ttKYGEZOK4A7JmvwG+6aWHAl+nIovY9ooay2caXGx5Zde4GZvQIvaAVPlIAVp4D1wZQqjrM=
X-Received: by 2002:a2e:9097:0:b0:2b4:5cad:f246 with SMTP id
 l23-20020a2e9097000000b002b45cadf246mr3114838ljg.7.1693456670464; Wed, 30 Aug
 2023 21:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mtpOtiP3Hk6FJPav8tYDhKJTQmELP31zYzVxf4DPNKbiQ@mail.gmail.com>
 <CAHk-=wiCPoGieS-hkV+ze6UqvzNyPNT7WoD_v54ZuVwi-d5Bmw@mail.gmail.com>
In-Reply-To: <CAHk-=wiCPoGieS-hkV+ze6UqvzNyPNT7WoD_v54ZuVwi-d5Bmw@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 30 Aug 2023 23:37:38 -0500
Message-ID: <CAH2r5mv+UBHjRAuGRfsGeUvPaZ=bo0=yVWSYMVkbrkzqDZ+SwA@mail.gmail.com>
Subject: Re: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Kleikamp <shaggy@kernel.org>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Aug 30, 2023 at 11:21=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> I've pulled this, but I think the new NLS_UCS2_UTILS config option
> shouldn't be something that is asked about. The filesystems that want
> it already select it, and users shouldn't be asked about a module with
> no use.
>
> The way to do that is to simply not have a user query string for it,
> ie instead of
>
>   config NLS_UCS2_UTILS
>           tristate "NLS UCS-2 UTILS"
>
> it could be (an dI think should be) just
>
>   config NLS_UCS2_UTILS
>           tristate
>
> which tells the config system not to ask users about it.
>
> Because users really shouldn't be asked questions that there is no point =
in.

Agree.  Will fix

> And then, on a purely visual commentary about your pull request -
> lines like these are just noise:
>
> >  fs/{smb/server/uniupr.h =3D> nls/nls_ucs2_utils.c} | 156
> > +++++-------------------------------------
> >  fs/nls/nls_ucs2_utils.h                          | 285
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>
> and the problem seems to be that you generate the diffstat in a very
> wide terminal (where git tries to be helpful and give you lots of
> detail), and then you cut-and-paste the result.
>
> If you pipe it to a tool instead (xsel, perhaps), git will limit the
> width of the diffstat to something sane.

Yes - today my terminal was set at about 180 character width.  Just
tried an experiment and piping to xsel did fix the output.  Will
update my scripts.


--=20
Thanks,

Steve
