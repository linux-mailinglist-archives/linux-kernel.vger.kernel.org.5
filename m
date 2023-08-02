Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E3276C230
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjHBB0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjHBB0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:26:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C012D42
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:26:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so9520878a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 18:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690939569; x=1691544369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZp8gGX8VEAsqKDOOD7UUWfIiEopULNUuDVfReWbP/Q=;
        b=1q71HHUKiqR1FZENTwLvFqYeCIaQLsqKPtWBWBQlMtZsIPkCBvguA2x0lduxepKNNP
         jjXZzVyRjxa0g9xcACvqNxKbgOd6R9/gMHmR96AqsxCfNC+znhC2mgjByxbic7Js2y2h
         /q2vFIvQRpSolDisYtzmNCX9BSXsELfv6HQzRjYilUoM6XSQSstVf4k6/U79AgiDqodg
         o6moxHpljTVDVKduNk65zv/s7VDXwUoGJ7LxUDgBoa3OZohpsZxxnkoY8fLEBCKwuY/H
         nCiTedISjM2482iRM993JM5Z/vKnEgecyKTm7gmiU+5IL4bMt9POAF3pUCaFOHSMmM8y
         nShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690939569; x=1691544369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZp8gGX8VEAsqKDOOD7UUWfIiEopULNUuDVfReWbP/Q=;
        b=a4Xf+Av+7l/W/oAM2+HQ+oQHdOMQKj3GJPCw6CWwoQEN+M1DuV60IAFfy0u2yKFSKp
         UEdidhzgVGhjl0OswWzBzMGiwoMz4Doh10FaOWRpuaxrHvstg7CGp/4BchVDvIabGDBu
         4GwSysikjQWtSH9sfrRMTOAZdnc6ubiEp0fxeAhH+ZfgGECNAIVWQndc/Q12XEIJk2dA
         6xSitLo/RCL1Ui0+R3hzcfOdMCrsmHL3A0PMCNZpk/rvTsl2uCePMB6exsSo5RRGMkz8
         EJtj9DsFkgYXXco1rtHjYLchX8hMTxsS2kQ+YH9RQEVHKMf6lD+1STeuqQJynuYNnFJV
         Ipvw==
X-Gm-Message-State: ABy/qLa9ApP1DnxL25sL1otr1S6rErvxdj8wUWdigC703T+Iw5fRiW8m
        +nK90pVkP2w4N27x40DBCi3CDjhPl+KY1S0NvC0Ycg==
X-Google-Smtp-Source: APBJJlHX6nzDbP9qqsrLz+YF4yvOH4d01uCjaHAIWJqFbLcinXF4cXKQKuv0onS3aL19NSNStzx1SNQSLJ8QpYIQAYo=
X-Received: by 2002:a05:6402:8d5:b0:51d:d4c3:6858 with SMTP id
 d21-20020a05640208d500b0051dd4c36858mr3814153edz.12.1690939568796; Tue, 01
 Aug 2023 18:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230802-wifi-ipw2x00-refactor-v1-1-6047659410d4@google.com> <86B2408D-BB52-4B29-BE4A-A6A12A129121@kernel.org>
In-Reply-To: <86B2408D-BB52-4B29-BE4A-A6A12A129121@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 1 Aug 2023 18:25:55 -0700
Message-ID: <CAFhGd8p9UUXoeA85UsCvB3B3+gF=vUcz+Z_s=hn95XCU8btCNQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: ipw2x00: refactor to use kstrtoul
To:     Kees Cook <kees@kernel.org>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 6:16=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On August 1, 2023 5:51:59 PM PDT, Justin Stitt <justinstitt@google.com> w=
rote:
> >The current implementation seems to reinvent what `kstrtoul` already doe=
s
> >in terms of functionality and error handling. Remove uses of `simple_str=
toul()`
> >in favor of `kstrtoul()`.
> >
> >There is the following note at `lib/vsprintf.c:simple_strtoull()` which
> >further backs this change:
> >| * This function has caveats. Please use kstrtoull (or kstrtoul) instea=
d.
> >
> >And here, simple_str* are explicitly deprecated [3].
> >
> >This patch also removes an instance of the deprecated `strncpy` which he=
lps [2].
> >
> >Link: https://lore.kernel.org/all/202308011602.3CC1C0244C@keescook/ [1]
> >Link: https://github.com/KSPP/linux/issues/90 [2]
> >Link: https://docs.kernel.org/process/deprecated.html#simple-strtol-simp=
le-strtoll-simple-strtoul-simple-strtoull [3]
> >Cc: linux-hardening@vger.kernel.org
> >Suggested-by: Kees Cook <keescook@chromium.org>
> >Signed-off-by: Justin Stitt <justinstitt@google.com>
> >---
> >
> >
> >Link: https://lore.kernel.org/all/20230801-drivers-net-wireless-intel-ip=
w2x00-v1-1-ffd185c91292@google.com/
> >---
> > drivers/net/wireless/intel/ipw2x00/ipw2200.c | 43 +++++++++------------=
-------
> > 1 file changed, 14 insertions(+), 29 deletions(-)
> >
> >diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/=
wireless/intel/ipw2x00/ipw2200.c
> >index dfe0f74369e6..ac10633f593e 100644
> >--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> >+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> >@@ -1176,23 +1176,20 @@ static ssize_t debug_level_show(struct device_dr=
iver *d, char *buf)
> > static ssize_t debug_level_store(struct device_driver *d, const char *b=
uf,
> >                                size_t count)
> > {
> >-      char *p =3D (char *)buf;
> >-      u32 val;
> >+      unsigned long *val =3D NULL;
> >
> >-      if (p[1] =3D=3D 'x' || p[1] =3D=3D 'X' || p[0] =3D=3D 'x' || p[0]=
 =3D=3D 'X') {
> >-              p++;
> >-              if (p[0] =3D=3D 'x' || p[0] =3D=3D 'X')
> >-                      p++;
> >-              val =3D simple_strtoul(p, &p, 16);
> >-      } else
> >-              val =3D simple_strtoul(p, &p, 10);
> >-      if (p =3D=3D buf)
> >+      int result =3D kstrtoul(buf, 0, val);
>
> kstrtoul needs somewhere to write the value, so val need to be actually u=
nsigned long, and a pointer passed to that:
>
> unsigned long val;
> ...
> ... kstrtoul(but, 0, &val);
>
> But otherwise, yeah, this looks like the right direction to me.
>
> >+
> >+      if (result =3D=3D -EINVAL)
> >               printk(KERN_INFO DRV_NAME
> >                      ": %s is not in hex or decimal form.\n", buf);
> >+      else if (result =3D=3D -ERANGE)
> >+              printk(KERN_INFO DRV_NAME
> >+                       ": %s has overflowed.\n", buf);
> >       else
> >-              ipw_debug_level =3D val;
> >+              ipw_debug_level =3D *val;
> >
> >-      return strnlen(buf, count);
> >+      return count;.
>
> It might be worth mentioning this return value change, but I think it's c=
orrect: we're communicating how much was consumed (we consumed it all). Whe=
n the return value !=3D count, this function may be called again with the "=
rest" of the input. As this is a sysfs interface, that kind of behavior is =
very rare bordering on actively unwanted. :) So, I think these should eithe=
r return a negative error or count.
>
> -Kees
>
> > }
> > static DRIVER_ATTR_RW(debug_level);
> >
> >@@ -1461,33 +1458,21 @@ static ssize_t scan_age_store(struct device *d, =
struct device_attribute *attr,
> > {
> >       struct ipw_priv *priv =3D dev_get_drvdata(d);
> >       struct net_device *dev =3D priv->net_dev;
> >-      char buffer[] =3D "00000000";
> >-      unsigned long len =3D
> >-          (sizeof(buffer) - 1) > count ? count : sizeof(buffer) - 1;
> >-      unsigned long val;
> >-      char *p =3D buffer;
> >
> >       IPW_DEBUG_INFO("enter\n");
> >
> >-      strncpy(buffer, buf, len);
> >-      buffer[len] =3D 0;
> >+      unsigned long *val =3D NULL;
> >+      int result =3D kstrtoul(buf, 0, val);
> >
> >-      if (p[1] =3D=3D 'x' || p[1] =3D=3D 'X' || p[0] =3D=3D 'x' || p[0]=
 =3D=3D 'X') {
> >-              p++;
> >-              if (p[0] =3D=3D 'x' || p[0] =3D=3D 'X')
> >-                      p++;
> >-              val =3D simple_strtoul(p, &p, 16);
> >-      } else
> >-              val =3D simple_strtoul(p, &p, 10);
> >-      if (p =3D=3D buffer) {
> >+      if (result =3D=3D -EINVAL || result =3D=3D -ERANGE) {
> >               IPW_DEBUG_INFO("%s: user supplied invalid value.\n", dev-=
>name);
> >       } else {
> >-              priv->ieee->scan_age =3D val;
> >+              priv->ieee->scan_age =3D *val;
> >               IPW_DEBUG_INFO("set scan_age =3D %u\n", priv->ieee->scan_=
age);
> >       }
> >
> >       IPW_DEBUG_INFO("exit\n");
> >-      return len;
> >+      return count;
> > }
> >
> > static DEVICE_ATTR_RW(scan_age);
> >
> >---
> >base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
> >change-id: 20230801-wifi-ipw2x00-refactor-fa6deb6c67ea
> >
> >Best regards,
> >--
> >Justin Stitt <justinstitt@google.com>
> >
>
>
> --
> Kees Cook

Thanks for the feedback. v2 available here:
https://lore.kernel.org/all/20230802-wifi-ipw2x00-refactor-v2-1-d33f765e9cd=
5@google.com/
