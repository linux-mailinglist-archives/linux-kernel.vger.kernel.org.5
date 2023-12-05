Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C778060F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346260AbjLEVmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346087AbjLEVmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:42:08 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBD71AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:42:13 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77dd07e7d39so419503885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 13:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701812531; x=1702417331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6YS5yNlvl+FKFyGS3DIWxbNX8VWKvkEW8slTswnooc=;
        b=APSnabA4fbMPiUy+Z1Ba2nYOftClJzzqtuBcFXY1QJ2+KJFcg7NpyWXfOI3ZaZCsFh
         a+QxWfioKpgObJ95pJFLvzD7h5JLW3v2zulY+bLquyxSK879g5tqrY6qYdl7NKDjTxmC
         D8uikSoo1bW5mVwA9jgDJFX+IN/dajC7zlHoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701812531; x=1702417331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6YS5yNlvl+FKFyGS3DIWxbNX8VWKvkEW8slTswnooc=;
        b=qTRqYpv7G4kkLW3M8lXZh9UhdReLsuUE1GpIZz9GpBQExucTbXbk1kRJ53DMrU8cC9
         88hdDPM5XYTHvnG+kxLx4VmwFrmAZVq84DM2lpOikTtPgt1o9qi82QdqOsWit60hqLoi
         jIyLybMev2CDkL8rRW6l82QjCaOXMva5i4pUnFg1M/pxLl0sL6rM/EFcilIPdWx/C4dG
         b0/hm5Iwz6RND4A4z6/hBzSRZIp8g0cGzImWvuTy4ZP5uLKFyBn4aF74alehzv8MfwBU
         Ky3iuMXeZ2paz/UyB2CPPc/Zy0yf86NOBLXpOn9S+nFuh3KEsQ8zyB3Y8Fx6WnBllAHo
         vc7Q==
X-Gm-Message-State: AOJu0YzWqqxJz9iaevSwGYzbp6MBMnqO9AslVEDM9bVrJxUZR7TEsiLG
        nW427mJALyKIzNjKqo6CeCpBSFFT88HxWxW4ylIYMG+M
X-Google-Smtp-Source: AGHT+IERnP3ZCxfFBe1/0AyxNH1BfhPyn7n/9wWOgfweZBHYXfgW8qzz1u6UcKwAvCLnMYeymg7XPg==
X-Received: by 2002:a05:620a:218b:b0:77e:fba3:9d38 with SMTP id g11-20020a05620a218b00b0077efba39d38mr2039144qka.156.1701812531314;
        Tue, 05 Dec 2023 13:42:11 -0800 (PST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id b12-20020a05620a0ccc00b0077dd098d0b6sm5423691qkj.109.2023.12.05.13.42.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 13:42:10 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4255cc2bcdaso29991cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 13:42:10 -0800 (PST)
X-Received: by 2002:a05:622a:4ce:b0:425:4823:f9a3 with SMTP id
 q14-20020a05622a04ce00b004254823f9a3mr60587qtx.2.1701812530294; Tue, 05 Dec
 2023 13:42:10 -0800 (PST)
MIME-Version: 1.0
References: <GV1PR10MB65635561FB160078C3744B5FE8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <GV1PR10MB6563DC208657E86715361E94E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <GV1PR10MB6563DC208657E86715361E94E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Dec 2023 13:41:57 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XpK0T-oPi2Q6-9jELFseSsvgkFtRuXP1LXK6PbV_MwCg@mail.gmail.com>
Message-ID: <CAD=FV=XpK0T-oPi2Q6-9jELFseSsvgkFtRuXP1LXK6PbV_MwCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] trace: kdb: Replace simple_strtoul with kstrtoul in kdb_ftdump
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        linux-trace-kernel@vger.kernel.org, jason.wessel@windriver.com,
        daniel.thompson@linaro.org, rostedt@goodmis.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 19, 2023 at 4:10=E2=80=AFPM Yuran Pereira <yuran.pereira@hotmai=
l.com> wrote:
>
> The function simple_strtoul performs no error checking in scenarios
> where the input value overflows the intended output variable.
> This results in this function successfully returning, even when the
> output does not match the input string (aka the function returns
> successfully even when the result is wrong).
>
> Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> simple_strtoul(), and simple_strtoull() functions explicitly ignore
> overflows, which may lead to unexpected results in callers."
> Hence, the use of those functions is discouraged.
>
> This patch replaces all uses of the simple_strtoul with the safer
> alternatives kstrtoint and kstrtol.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple=
-strtol-simple-strtoll-simple-strtoul-simple-strtoull
>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>  kernel/trace/trace_kdb.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> index 59857a1ee44c..3891f885e4a6 100644
> --- a/kernel/trace/trace_kdb.c
> +++ b/kernel/trace/trace_kdb.c
> @@ -96,23 +96,21 @@ static int kdb_ftdump(int argc, const char **argv)
>  {
>         int skip_entries =3D 0;
>         long cpu_file;
> -       char *cp;
> +       int err;
>         int cnt;
>         int cpu;
>
>         if (argc > 2)
>                 return KDB_ARGCOUNT;
>
> -       if (argc) {
> -               skip_entries =3D simple_strtol(argv[1], &cp, 0);
> -               if (*cp)
> +       if (argc)
> +               if (kstrtoint(argv[1], 0, &skip_entries))
>                         skip_entries =3D 0;
> -       }

Similar nit about braces as in patch #1. tl;dr is change the above to:

if (argc && kstrtoint(argv[1], 0, &skip_entries))
  skip_entries =3D 0;


>
>         if (argc =3D=3D 2) {
> -               cpu_file =3D simple_strtol(argv[2], &cp, 0);
> -               if (*cp || cpu_file >=3D NR_CPUS || cpu_file < 0 ||
> -                   !cpu_online(cpu_file))
> +               err =3D kstrtol(argv[2], 0, &cpu_file);
> +               if (err || cpu_file >=3D NR_CPUS || cpu_file < 0 ||
> +                               !cpu_online(cpu_file))

nit: why did you change the indentation for "!cpu_online(cpu_file))"?
It seemed better before.

With nits fixed:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
