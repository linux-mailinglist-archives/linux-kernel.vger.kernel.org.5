Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF617D3136
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjJWLG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjJWLGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:06:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3454FD6E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:06:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99de884ad25so474412466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698059209; x=1698664009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7XaiYBuGHU5HwnYEvpCy/VRSZ0QwCNbvMLPO70q9o8=;
        b=Uz4kMYxsDfoEY25eyRlndeioeyrMz1B+yyajX553TIgwRKkGCLmr02L/ZETg72zhvy
         g2nxtPLFWYNfD9uOTh/t8s46O55ZPVJKAs2zW3k8Us3sIhS9zF4+LJ/OxhFWVVkQTfUk
         ytBrJya+AZChqw6d7+bAfMZoJqArxU+uF2s/53fB314bkPpSC/lXylKzVRlC3sA6PGFh
         CxwcTUP6nbA6CTppUux/klCztvvo2endr1kPbWU5Ldcs/WmpAjeibYPdqwqqhcFOxyBm
         fRS+XE6uQ54kAOLFld7Swcw60cnEEh8voViOEcUerbhKhOPLvTLuGyAgCtIAQ49ZS9NA
         wUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698059209; x=1698664009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7XaiYBuGHU5HwnYEvpCy/VRSZ0QwCNbvMLPO70q9o8=;
        b=YvGXmwYtv5OErJndON8nSVLwoOmrnL7vMxbS4Teg7dBhZ6FJBrMTLiwGTJuw6g6aej
         IwsbiBFc4qP9PPn0mJy8nKv/1yTGgIh4i4t19lEZRYHlAg+kngGzr2w+wfSMNJsPh14e
         htWSmqyrddpg1VNB5FQzsGtY/nN0PfsKMjTii0JwOnQ3XfMZy/a6d+GRFakrsrfdiHJu
         1fSZuHnileNAcE6oWFiCbqhYO+jvsQAxOPM+L7W8ZJRLQ7wiek/rpcOqKlxjfYOhRqZV
         7k++pCeuEFVEP8ocEPF3DRiEwKUlE4pzF7iudOWeVdUtuwhbjN8Gm6ubvU6AitodujO6
         UtjA==
X-Gm-Message-State: AOJu0Yz1SNjEbyMc0r3L9IeoTlKSd7xrVFEN4SOHHR+lMqL/cMAr49n0
        vksStSPKfiDGPN8exl7Jm/rVdn3SsI5Hj4P02LU=
X-Google-Smtp-Source: AGHT+IFRUvcRANI8KuPH3fmVLuR85VI3815YdYJmCj7Ourn94npyoVkv5FLTV2kSMMyCKZjm/04mH1iqCIyIDMy193U=
X-Received: by 2002:a17:907:3ea5:b0:9c3:8242:e665 with SMTP id
 hs37-20020a1709073ea500b009c38242e665mr7279825ejc.8.1698059209353; Mon, 23
 Oct 2023 04:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAOx-CDUwV0d0+2UdZW+vdUcjwAg2+Hanf1-iNSYFRWOW2yQugg@mail.gmail.com>
 <6675c47a-d258-41ae-b506-88d7ae74b551@infradead.org> <CAOx-CDVn7Ub31yiRpoZh4RhJBCvgZhb8Ca=cH9b0xWPjk5FNQA@mail.gmail.com>
 <89f666dc-e7b3-44ad-846c-b1f1ee278940@infradead.org>
In-Reply-To: <89f666dc-e7b3-44ad-846c-b1f1ee278940@infradead.org>
From:   gmssixty gmssixty <gmssixty@gmail.com>
Date:   Mon, 23 Oct 2023 17:06:38 +0600
Message-ID: <CAOx-CDWzJWqYGhoJ4HPhio5-5zE025jYrmVpocryyxMfwfwsxw@mail.gmail.com>
Subject: Re: How can I add "busybox sh" as init during boot of the custom kernel?
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 7:59=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
>
> > On Mon, Oct 23, 2023 at 6:15=E2=80=AFAM Randy Dunlap <rdunlap@infradead=
.org> wrote:
> >>
> >>
> >>
> >> On 10/22/23 16:56, gmssixty gmssixty wrote:
> >>> How can I add "busybox sh" as init during boot of the custom kernel? =
I
> >>> have compiled the kernel and put the bzImage in /dev/sda3 (/mnt/sda3)=
.
> >>> Booted that kernel. After booting, I got a message to set the init
> >>> process. I have put the busybox in /bin. Now I want to add this
> >>> "busybox sh" as an init process. How can I do this?
> >>>
> >>> Note that, I did not install any other software in that /dev/sda3
> >>> (/mnt/sda3). I have only bzImage and busybox.
> >>
> >> from Documentation/admin-guide/kernel-parameters.txt:
> >> (or https://docs.kernel.org/admin-guide/kernel-parameters.html)
> >>
> >>         init=3D           [KNL]
> >>                         Format: <full_path>
> >>                         Run specified binary instead of /sbin/init as =
init
> >>                         process.
> >>
>
> On 10/22/23 17:34, gmssixty gmssixty wrote:
> > I tried this: init=3D/bin/busybox sh, but it got Kernel panic and
> > failed. On the other hand, what should I write in /sbin/init?
> >
>
> Please don't top-post.
>
> You need a file name after init=3D.
> "/bin/busybox sh" is not a file name AFAIK.
>
> To use /sbin/init, enter
>         init=3D/sbin/init
>
> To use bash (e.g.), enter
>         init=3D/usr/bin/bash
>
> The kernel init code already tries to use /sbin/init if that file is
> present, along with /etc/init, /bin/init, and /bin/sh .
>
>
> --
> ~Randy

What would I write in /sbin/init? I mean, what will be the content of
/sbin/init? Should I write: "exec /bin/busybox sh" in /sbin/init? Or
should I write "/bin/busybox sh" in /sbin/init?

BTW, what is top-post?
