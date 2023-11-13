Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AA17EA462
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 21:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjKMUK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 15:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjKMUK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 15:10:26 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBA2D73
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 12:10:23 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41cdc669c5eso53531cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 12:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699906222; x=1700511022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6A1mokEzY/ElrGYFkRMtl6uz5gA/gkkYl9e8YMn+3JM=;
        b=C7vnxZ1ma+9buSpdRJkSdEURliyBKEsZJOVXaJxLfDiOJfZEt2BHqkyPvRR8cL/4mT
         3H53uoC7en11DNvb1uFAh/EFAv5Z6bm5TQjJbCo3HOJubsGgDkSC8cPd6m6I549IYBeh
         TgT5zBB3oyVPDdzfBzgu6QZNiCKTZdwBdCbtGVTYiCgYliPdzw0XXb4O1adLbsVx0Gl0
         eHCULSiEfBip8JU8Z1w8048JoSscc1wYN07Tu3URa54tolqUmoTMBAOxeCMEmmU7ZccW
         xLO12hjTSSZpIIJDTWKHGpH2fW/VyqnZ4O16JELsSYfDoCDrMuY8cQFeitSgwIVvBAGZ
         JYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906222; x=1700511022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6A1mokEzY/ElrGYFkRMtl6uz5gA/gkkYl9e8YMn+3JM=;
        b=uXSB0l6fDWOeS3S07yvF09lpqufsHlK4bSG8hh0+dyec5XxkNXa1kedK/dgBI+gYtx
         uZNU3tJHmNI8xezT9Zg3lj5jSVfLCCNZQbYp7HaKL6vjxFaqrSvAauB6hSVm04wG64HC
         vjmdnjs/ceGw3TPu0npiR68hsapL5xjsLZennKn1/GjznYu4o8TM61+qGlfOvms0rUci
         w6aDrkEdTfSykDD2RzGK10sLcFbRGBPZi47qWbObB/wteFkGSdFAF7I0KWZM9gHev2ic
         KbI1DrazZWLTQi6NPlK3LVthfeTalqmqDD65oJm5tBVoHWg87Efjz+hHou0IcUiIzWS3
         UdyA==
X-Gm-Message-State: AOJu0YwyDB8JbSuOY8kTbDWjs3VH6V9hqmz1utGg2ffFXAGUqTH9O4Xq
        fQH0lyirZ6/w83ADcT8XyLGo/8QvSNXd4JY9DscVxg==
X-Google-Smtp-Source: AGHT+IEEBDLKlQpbT5O2Rio4DF+E/b35xHjZ33DYvELnzkfwGVtkrZbS0gNSVBOpY4wrF9A3BK8+o9uf7kZ6IpSCDyY=
X-Received: by 2002:a05:622a:1cc4:b0:41c:bfd9:b990 with SMTP id
 bc4-20020a05622a1cc400b0041cbfd9b990mr48404qtb.17.1699906222182; Mon, 13 Nov
 2023 12:10:22 -0800 (PST)
MIME-Version: 1.0
References: <20231113133044.55257-1-herve.codina@bootlin.com>
In-Reply-To: <20231113133044.55257-1-herve.codina@bootlin.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 13 Nov 2023 12:09:43 -0800
Message-ID: <CAGETcx8-iXbWkRyVT3s4XkmQii2CSysSLedDLWn0oNLQLPM3ow@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] driver core: Keep the supplier fwnode consistent
 with the device
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 5:30=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> The commit 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child
> fwnode's consumer links") introduces the possibility to use the
> supplier's parent device instead of the supplier itself.
> In that case the supplier fwnode used is not updated and is no more
> consistent with the supplier device used.

Looks like you missed this comment from my previous reply.

Nack. It's easier to debug when you know what supplier you were
pointing to in DT that triggered the creation of the device link.

It can get confusing real quick otherwise.

-Saravana

>
> Update the fwnode used to be consistent with the supplier device used.
>
> Fixes: 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child fwnode's=
 consumer links")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> Changes v1 -> v2:
>   Remove sup_handle check and related pr_debug() call as sup_handle canno=
t be
>   invalid if sup_dev is valid.
>
>  drivers/base/core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4d8b315c48a1..2f6a21b908ec 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2076,6 +2076,13 @@ static int fw_devlink_create_devlink(struct device=
 *con,
>                 sup_dev =3D get_dev_from_fwnode(sup_handle);
>
>         if (sup_dev) {
> +               /*
> +                * The supplier device may have changed and so, the suppl=
ier
> +                * fwnode maybe inconsistent.
> +                * Update the supplier fwnode
> +                */
> +               sup_handle =3D sup_dev->fwnode;
> +
>                 /*
>                  * If it's one of those drivers that don't actually bind =
to
>                  * their device using driver core, then don't wait on thi=
s
> --
> 2.41.0
>
