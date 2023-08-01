Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D163876B809
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjHAOxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjHAOxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:53:05 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F21D120;
        Tue,  1 Aug 2023 07:53:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe2503e3easo6170146e87.2;
        Tue, 01 Aug 2023 07:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690901583; x=1691506383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JUHJUWr1boOlcpWydhjYbG19OtXRs04OSVgwOAzZNw=;
        b=IaH/bxLwuy9szW+7Pp/7QwdczgNxmowoUi+L1ZaMKZd0MVMmF6To/DT4Psdcp1E4hW
         /3P0/OX9i3pQWi9jjviuuQ7vgGlXSiYDybh/AUXnVhimb+lfeqdYWGzWM21qX+FsZ4NN
         zLg4IHMbOExHeeW/IDt9tLkP82KgeKdi78K1gQF/mFUA8w87eSBS4LkV48nNmu5fzzGu
         OEzS0H911t5r5bLEdSodbLn9C2zTflpV7YKQSaRxzYfo6P79m8F7NhCq1pRgQJoM5/Nc
         tx+9gomq+9SaZNbPW4ZDgvP2Cn+QcdsfZiNY92FlE6gWcahre29nh+JA6WCXf1BiS+c2
         JBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690901583; x=1691506383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JUHJUWr1boOlcpWydhjYbG19OtXRs04OSVgwOAzZNw=;
        b=HQujTOYiCK4oXE4YEWifbfHYeQ9tJq2yWzdmLMqsLz1cH52JjbVO6DG+5OadjDXasR
         K1sUeNYIpmp+RyneahURMOaTBEnJCmnHyXUdTEto+52f+azMpfF+l5xujInLm+KpuW+6
         SitZzNGVPEmUX8Y33JTO6eLdyASbSbHkHygR3WQKAZi36Qu6mo/CYW7GUx72q3kD3Kp1
         VXbaEEBce/yFaThhVEGUfS6Ng/sB9oOm2FnNxGkVPSAaais1z8RZScJXmJtVqcdC4+Lx
         66YVKMiMiTiuVM1NbWP2UdF8uB1XCZOQO3fPbkmJMONH95w0+wB5nqP9tc/FVJBYsHpE
         fEAw==
X-Gm-Message-State: ABy/qLZgwD21q/YoU6JsdypOk5tPkJS/L2hsuCUVt/4HuxeKaUm0yicN
        QVgyjoXv8TVY3IZTx1CuL2FXR6xVfVm1VI3SFfE=
X-Google-Smtp-Source: APBJJlHJnVmYb4LFttrV7vuwtC9jR7HqAvXnSFgAYbO1kCldFfHBr+ZSTC/UO1cJnTkRXCbbrafxT57wWa844qLK1+0=
X-Received: by 2002:ac2:5b4e:0:b0:4fb:8eec:ce47 with SMTP id
 i14-20020ac25b4e000000b004fb8eecce47mr2439728lfp.58.1690901582466; Tue, 01
 Aug 2023 07:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230731203141.30044-1-jorge.lopez2@hp.com> <c891e1cb-3fb6-448a-850c-e94c48d32c66@kadam.mountain>
In-Reply-To: <c891e1cb-3fb6-448a-850c-e94c48d32c66@kadam.mountain>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 1 Aug 2023 09:52:05 -0500
Message-ID: <CAOOmCE8xLxE9fSZNhPeYumRyzg9S-C9++8LH5jDq5vVwgFMdCQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] hp-bioscfg: Overall fixes and code cleanup
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

I will submit a new patch replacing 'value_len' for 'size' in line 267
as indicated.
'value_len' is utilized earlier in the code so we cannot remove it
completely from the function.


On Tue, Aug 1, 2023 at 8:35=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> These are fine.  We still need to do something like this.  Also we could
> just get rid of value_len completely.  Nothing uses it.
>
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b=
/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> index cffc1c9ba3e77..6ba0e49e787ec 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> @@ -264,7 +264,7 @@ static int hp_populate_ordered_list_elements_from_pac=
kage(union acpi_object *ord
>                          * Ordered list data is stored in hex and comma s=
eparated format
>                          * Convert the data and split it to show each ele=
ment
>                          */
> -                       ret =3D hp_convert_hexstr_to_str(str_value, value=
_len, &tmpstr, &tmp_len);
> +                       ret =3D hp_convert_hexstr_to_str(str_value, size,=
 &tmpstr, &tmp_len);
>                         if (ret)
>                                 goto exit_list;
>
