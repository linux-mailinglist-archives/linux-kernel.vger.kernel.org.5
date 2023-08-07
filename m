Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF5D772CA4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjHGRT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjHGRTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:19:38 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1506910C1;
        Mon,  7 Aug 2023 10:19:36 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40fcc91258fso31422911cf.1;
        Mon, 07 Aug 2023 10:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428775; x=1692033575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CzGcMtbdW5px13u7V86FR6wSOIpq5Rhi2EUJ/h5pT8=;
        b=RocDf+v3UtZKHTPJSxqnYPq/0dnC+MTTfUa8drQQ+uktU3n7oYg+gIgZtfp9HsqKEB
         4W/tYTR9iCKdxnUzfulLyp2m0K+Ja50FHbKdCIZSyt8q/CmpFK6PZcQ2AnHCvBl0T3AD
         9RyJRVHByL8ai8YYAgq/ZPf4xi2rKQL4aTJmlCemUjLFG9vFkd5rHQhdIB4eu5JLOCgk
         qtuwfH3Vc8lNiy9Ao4YmpF6iJBngD8vI0TLJPTqcfMkLf5VJNBo2rfDVVsnX+xLK4CVO
         YFrQHxyeb0pSitpbbgY3A1Vc2DDxuXoElajFK9YslM4+clQh/w+4YVJpg60aXRa36JdM
         46OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428775; x=1692033575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CzGcMtbdW5px13u7V86FR6wSOIpq5Rhi2EUJ/h5pT8=;
        b=A67qKsesvmtayK/2WgJPMLAj92IBcjL8B34Jx3E6MXlqGvI2ZM8n43CjjWV0o/5T+r
         YMcBAZep4wmt4/Rpv2JRbOvun32/mmbkYfxEj8bPuUF1zMKROG2Yet0hKveBnjIqKIyJ
         HN5vfgHiwA8yhc/0IMZ38Inligw8CQQIEHH+Tqc6BrkS44dMA3Ks9Df383qoLHjnmyQm
         soAkqffmKyDWQtFRVj+kM0rbtcHAqXoyBQnbjxhDOUaJLu3jUArTPryuXePkG+pBbZYM
         pUrDdkimdXwaGYWU+BQUkcqiKVzQDvAe6N63zUT1iuDFPbue3ejwm/7mqj9fyF80DT7c
         Ozyg==
X-Gm-Message-State: AOJu0YychoI5NFCDdcggarqHNyIO9f0Hum4cU9YnACqzzDSABwGiR+3e
        J3UaaEnWMrXFI6KvCEnUHrPsmb0LLK9LewkfXSPYHRJ/CGM=
X-Google-Smtp-Source: AGHT+IFRdTZogtimi+4EQ4pPu6n36JrjKkyWttVsagb3sapEXKCBVjMJI/E2P8v5u8iTm3Kn9u+DLPUHpfJqMWR90GI=
X-Received: by 2002:ac8:7f0a:0:b0:401:e1e7:a291 with SMTP id
 f10-20020ac87f0a000000b00401e1e7a291mr14496121qtk.22.1691428775181; Mon, 07
 Aug 2023 10:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230807-amd-pstate-cfi-v1-1-0263daa13bc3@weissschuh.net>
In-Reply-To: <20230807-amd-pstate-cfi-v1-1-0263daa13bc3@weissschuh.net>
From:   =?UTF-8?Q?Jannik_Gl=C3=BCckert?= <jannik.glueckert@gmail.com>
Date:   Mon, 7 Aug 2023 19:19:24 +0200
Message-ID: <CAFqe=z+d2pi05KkOVw_LD00KHD-aX5tKVej5F6hc2wmUC9f_Yg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: fix global sysfs attribute type
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux LLVM Build Support <llvm@lists.linux.dev>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
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

Hi Thomas,

thanks for the super quick response, your patch fixes the issue.

Best
Jannik

Am Mo., 7. Aug. 2023 um 08:37 Uhr schrieb Thomas Wei=C3=9Fschuh
<linux@weissschuh.net>:
>
> In commit 3666062b87ec ("cpufreq: amd-pstate: move to use bus_get_dev_roo=
t()")
> the "amd_pstate" attributes where moved from a dedicated kobject to the
> cpu root kobject.
> While the dedicated kobject expects to contain kobj_attributes the root
> kobject needs device_attributes.
>
> As the changed arguments are not used by the callbacks it works most of
> the time.
> However CFI will detect this issue:
>
> [ 4947.849350] CFI failure at dev_attr_show+0x24/0x60 (target: show_statu=
s+0x0/0x70; expected type: 0x8651b1de)
> ...
> [ 4947.849409] Call Trace:
> [ 4947.849410]  <TASK>
> [ 4947.849411]  ? __warn+0xcf/0x1c0
> [ 4947.849414]  ? dev_attr_show+0x24/0x60
> [ 4947.849415]  ? report_cfi_failure+0x4e/0x60
> [ 4947.849417]  ? handle_cfi_failure+0x14c/0x1d0
> [ 4947.849419]  ? __cfi_show_status+0x10/0x10
> [ 4947.849420]  ? handle_bug+0x4f/0x90
> [ 4947.849421]  ? exc_invalid_op+0x1a/0x60
> [ 4947.849422]  ? asm_exc_invalid_op+0x1a/0x20
> [ 4947.849424]  ? __cfi_show_status+0x10/0x10
> [ 4947.849425]  ? dev_attr_show+0x24/0x60
> [ 4947.849426]  sysfs_kf_seq_show+0xa6/0x110
> [ 4947.849433]  seq_read_iter+0x16c/0x4b0
> [ 4947.849436]  vfs_read+0x272/0x2d0
> [ 4947.849438]  ksys_read+0x72/0xe0
> [ 4947.849439]  do_syscall_64+0x76/0xb0
> [ 4947.849440]  ? do_user_addr_fault+0x252/0x650
> [ 4947.849442]  ? exc_page_fault+0x7a/0x1b0
> [ 4947.849443]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>
> Reported-by: Jannik Gl=C3=BCckert <jannik.glueckert@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217765
> Link: https://lore.kernel.org/lkml/c7f1bf9b-b183-bf6e-1cbb-d43f72494083@g=
mail.com/
> Fixes: 3666062b87ec ("cpufreq: amd-pstate: move to use bus_get_dev_root()=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Note:
>
> This was not tested with CFI as I don't have the toolchain available.
> Jannik, could you give it a spin?
> ---
>  drivers/cpufreq/amd-pstate.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 81fba0dcbee9..9a1e194d5cf8 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1012,8 +1012,8 @@ static int amd_pstate_update_status(const char *buf=
, size_t size)
>         return 0;
>  }
>
> -static ssize_t show_status(struct kobject *kobj,
> -                          struct kobj_attribute *attr, char *buf)
> +static ssize_t status_show(struct device *dev,
> +                          struct device_attribute *attr, char *buf)
>  {
>         ssize_t ret;
>
> @@ -1024,7 +1024,7 @@ static ssize_t show_status(struct kobject *kobj,
>         return ret;
>  }
>
> -static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
> +static ssize_t status_store(struct device *a, struct device_attribute *b=
,
>                             const char *buf, size_t count)
>  {
>         char *p =3D memchr(buf, '\n', count);
> @@ -1043,7 +1043,7 @@ cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_fr=
eq);
>  cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>  cpufreq_freq_attr_rw(energy_performance_preference);
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
> -define_one_global_rw(status);
> +static DEVICE_ATTR_RW(status);
>
>  static struct freq_attr *amd_pstate_attr[] =3D {
>         &amd_pstate_max_freq,
> @@ -1062,7 +1062,7 @@ static struct freq_attr *amd_pstate_epp_attr[] =3D =
{
>  };
>
>  static struct attribute *pstate_global_attributes[] =3D {
> -       &status.attr,
> +       &dev_attr_status.attr,
>         NULL
>  };
>
>
> ---
> base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
> change-id: 20230807-amd-pstate-cfi-8302498c54f5
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
