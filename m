Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08684782BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbjHUO1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjHUO1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:27:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23452DB;
        Mon, 21 Aug 2023 07:27:15 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ff9b389677so5074818e87.3;
        Mon, 21 Aug 2023 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692628033; x=1693232833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCBw8JHS56QmypmYynEc49hFuIg6hZes912H9EXOgeo=;
        b=O0WW+kVCNDlsQDrDUmQi0phhj/KUatuVu408I34merJum46eO4L1VpSm4fqHlDsq2O
         0LBpXjkDSmrEu3PSpzgEtXuO0JP2ATsVJzePS6OvMSd4MKYf9deMGY/oh5/d7Qs4kyNu
         OwVMDNUpCByWgulvK0AIFft9H6jC6U9lmrEY2LJSVmejCqOKX2d4lK7nxLXB/Nph1ESd
         SN7+451y8i89M5nhGCVc1GDuLjDBmjVJOBt4DVeO5Thg8BKS40LaIIJo2qg9wwy71MND
         tR8NBhkze5pfhZ/4NSlpy89AZDo+pNF/rhfko1RZZSP2QOgKSBl7kjSn2PJH8DQOC3mp
         piDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692628033; x=1693232833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCBw8JHS56QmypmYynEc49hFuIg6hZes912H9EXOgeo=;
        b=ZixntsKXz7FOpUP3ltYGrU5BdlylgkX/wHi6TWp8QQSsG7RwMwgh1aBCeFp+oSSAKF
         e85CBuSX+ZXptt5p1XtkdkaZaH+fjAwlb7iTIchW3LC+Q9IaRFfIU44e9i/3jREqsVlA
         abzfVgbvD7NvZzZgYOc1ox7/wKqPKJQSUwdxgFJlZc1WYnexGhQ+qYYRoi6OgdLazgVY
         zH60g0S+Gq65emUBAIYq9UGiAmvqzF3UYOe20saXpG16BWMFzGkywVlmwdYMBLlCXdPQ
         XJXf/tI3Mq9c6ozYOOqmlqD4wWDB0vHayFi1DnIngRdmTdUpJLDhBX+LLq2EOpxsdtwk
         vKqg==
X-Gm-Message-State: AOJu0YxAx6WSaij13GY3kgPicXRwRtdM6ZP5+y/bkULX+kQsWEckjKRy
        YvYJcGMV1syAFAhvm25/x70DnHnd4H+7rA1e0U0=
X-Google-Smtp-Source: AGHT+IFvT7bgLSZEodSEKnNjEWo87qbU6tBszMXEiKdUHhU+OCaoEQADFsSA6MBJDhak/REL2JsxGM3YQzThSJ6AsKM=
X-Received: by 2002:a05:6512:2522:b0:4f1:3d7d:409e with SMTP id
 be34-20020a056512252200b004f13d7d409emr5787494lfb.0.1692628033053; Mon, 21
 Aug 2023 07:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230809210740.18392-1-jorge.lopez2@hp.com> <10276e15-8528-41a9-4b90-7fdf6b890206@redhat.com>
 <CAOOmCE9PFi5Xwmyr4jMPZ7LgofPY1fwLW71itfXw1km50B-Ybg@mail.gmail.com> <767165e4-5eae-a35c-aead-1db7801050dd@redhat.com>
In-Reply-To: <767165e4-5eae-a35c-aead-1db7801050dd@redhat.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 21 Aug 2023 09:26:08 -0500
Message-ID: <CAOOmCE_m6t4a0V9WRdPL8=hBfpXA+t9S5_7szy4qXeG=u1SD8Q@mail.gmail.com>
Subject: Re: [PATCH] hp-bioscfg: Update steps how order list elements are evaluated
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas@t-8ch.de, ilpo.jarvinen@linux.intel.com,
        dan.carpenter@linaro.org
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

On Mon, Aug 21, 2023 at 6:55=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi Jorge,
>
> On 8/14/23 15:44, Jorge Lopez wrote:
> > Hi Hans,
> >
> > On Mon, Aug 14, 2023 at 3:41=E2=80=AFAM Hans de Goede <hdegoede@redhat.=
com> wrote:
> >>
> >> Hi Jorge,
> >>
> >> On 8/9/23 23:07, Jorge Lopez wrote:
> >>> Update steps how order list elements data and elements size are
> >>> evaluated
> >>>
> >>> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> >>>
> >>> ---
> >>> Based on the latest platform-drivers-x86.git/for-next
> >>> ---
> >>>  .../x86/hp/hp-bioscfg/order-list-attributes.c    | 16 ++++++++++++++=
--
> >>>  1 file changed, 14 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes=
.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> >>> index b19644ed12e0..d2b61ab950d4 100644
> >>> --- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> >>> +++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> >>> @@ -152,7 +152,7 @@ static int hp_populate_ordered_list_elements_from=
_package(union acpi_object *ord
> >>>
> >>>               switch (order_obj[elem].type) {
> >>>               case ACPI_TYPE_STRING:
> >>> -                     if (elem !=3D PREREQUISITES && elem !=3D ORD_LI=
ST_ELEMENTS) {
> >>> +                     if (elem !=3D PREREQUISITES) {
> >>>                               ret =3D hp_convert_hexstr_to_str(order_=
obj[elem].string.pointer,
> >>>                                                              order_ob=
j[elem].string.length,
> >>>                                                              &str_val=
ue, &value_len);
> >>> @@ -266,6 +266,15 @@ static int hp_populate_ordered_list_elements_fro=
m_package(union acpi_object *ord
> >>>                       if (ret)
> >>>                               goto exit_list;
> >>>
> >>> +                     /*
> >>> +                      * It is expected for the element size value
> >>> +                      * to be 1 and not to represent the actual
> >>> +                      * number of elements stored in comma
> >>> +                      * separated format. element size value is
> >>> +                      * recalculated to report the correct number
> >>> +                      * of data elements found.
> >>> +                      */
> >>> +
> >>>                       part_tmp =3D tmpstr;
> >>>                       part =3D strsep(&part_tmp, COMMA_SEP);
> >>>                       if (!part)
> >>> @@ -273,11 +282,14 @@ static int hp_populate_ordered_list_elements_fr=
om_package(union acpi_object *ord
> >>>                                       tmpstr,
> >>>                                       sizeof(ordered_list_data->eleme=
nts[0]));
> >>>
> >>> -                     for (olist_elem =3D 1; olist_elem < MAX_ELEMENT=
S_SIZE && part; olist_elem++) {
> >>> +                     for (olist_elem =3D 0; olist_elem < MAX_ELEMENT=
S_SIZE && part; olist_elem++) {
> >>>                               strscpy(ordered_list_data->elements[oli=
st_elem],
> >>>                                       part,
> >>>                                       sizeof(ordered_list_data->eleme=
nts[olist_elem]));
> >>> +
> >>>                               part =3D strsep(&part_tmp, COMMA_SEP);
> >>> +                             if (part && ordered_list_data->elements=
_size < MAX_ELEMENTS_SIZE)
> >>> +                                     ordered_list_data->elements_siz=
e++;
> >>>                       }
> >>
> >> I believe that you can replace the:
> >>
> >>                                 if (part && ordered_list_data->element=
s_size < MAX_ELEMENTS_SIZE)
> >>                                         ordered_list_data->elements_si=
ze++;
> >>                         }
> >>
> >> Lines with simply (after the loop has finished) doing:
> >>
> >>                         }
> >>                         ordered_list_data->elements_size =3D olist_ele=
m'
> >>
> >> Or am I missing something ?
> >
<snip>

 ###
>
> Also you seem to have based this patch on top of a weird base
> commit. This patch assumes both strsep() calls use COMMA_SEP
> as separator. But the latest code in:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x8=
6.git/log/?h=3Dreview-hans
>
> Still uses the wrong SEMICOLON_SEP for the second strsep() call.
>
> Please make sure to base your next version on top of the latest
> review-hans commit.
>

local work branch was reset and now it is in sync with review-hans branch

> ###
>
> TL;DR: for your next version the "case ORD_LIST_ELEMENTS"
> should end up looking like this:
>
>                 case ORD_LIST_ELEMENTS:
>                         /*
>                          * Ordered list data is stored in hex and comma s=
eparated format
>                          * Convert the data and split it to show each ele=
ment
>                          */
>                         ret =3D hp_convert_hexstr_to_str(str_value, value=
_len, &tmpstr, &tmp_len);
>                         if (ret)
>                                 goto exit_list;
>
>                         part_tmp =3D tmpstr;
>                         part =3D strsep(&part_tmp, COMMA_SEP);
>
>                         for (olist_elem =3D 0; olist_elem < MAX_ELEMENTS_=
SIZE && part; olist_elem++) {
>                                 strscpy(ordered_list_data->elements[olist=
_elem],
>                                         part,
>                                         sizeof(ordered_list_data->element=
s[olist_elem]));
>                                 part =3D strsep(&part_tmp, COMMA_SEP);
>                         }
>                         ordered_list_data->elements_size =3D olist_elem;
>
>                         kfree(str_value);
>                         str_value =3D NULL;
>                         break;
>
> Unless I'm missing something and you believe that this will not work.

Concur with the proposed solution.  It achieves the same objective
using fewer checks.
New patch will follow

Regards,

Jorge.
