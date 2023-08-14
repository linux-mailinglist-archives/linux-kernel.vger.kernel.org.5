Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55AA77BA82
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjHNNqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHNNpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:45:32 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11F3E77;
        Mon, 14 Aug 2023 06:45:30 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe8c3b5ca0so6942100e87.1;
        Mon, 14 Aug 2023 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692020729; x=1692625529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qErFfB42rtaUuCXNYJBEQWFuU9NEelaRlpg+qZAgOIE=;
        b=gs+o7hb05w/HMRZNhCfF8x7snB8m2nom87KLI8bGtKzRnu/WTuqIdv5bXvGA/idC4i
         fK4cGxYinn0sFu6+jNBxcDUpK1GxQ/jOGOxjFyYoejWzU1sAALgDjSXyUk2LIsivAySD
         4I/DI6y1A2j7dUD7qVPhdSM01qna8uR/s2B0kQ7/6j5Ha6J47dxFr9yqqXKxDlV+KS/B
         HIX8iDah14aUPU5O6AKSGpBW81cBt8iO0FIrvRr+Psolvc2f4g8wEORRRHfHeDUUK4ds
         1KR/NHTt2TJ+9QYzy+YSIY5eExgrKgyRx/i/vdv7SnmZgOoXx7nkrWQ4ML28Ch0G+Ahn
         phaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692020729; x=1692625529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qErFfB42rtaUuCXNYJBEQWFuU9NEelaRlpg+qZAgOIE=;
        b=JwxeXV/WKdFoJqWXLnI1y8Sjn6Hmf+EXCYFrMNKy4JWoJ5dAvUG5+MfuEbnG2e/bne
         xgRAIZ3rvwX+inJfGhmFqIWgUegdoH6uBnygpO6vu7SQoLvAFLX4ZkZ8DpEw3NDv7CBY
         ZPLT6QXO6cLbyK1pfYwAtbtWufH40AxaIUGvWHoHETUM0gjgw0+FCoNiiYIF1kNQfp1c
         d4+iD31iJ7KPVVfYcjdgtaSoHssfUTVeRxl+o2DZVO9R528O8lXCnuyOIO4CJJTDHuq+
         8YdfiDS2F5EmQaRmHX66dmQSvq3RCM1Epq1Y4JugloXVIJOx2G9M8J/Tx0kKIU0NrHbf
         S7sg==
X-Gm-Message-State: AOJu0YwrVV22rhSm9q3siW3gTf04Tefb7o34QkNeo7UkCJO2m9b/4hOL
        lkCaKrfb8NiMLfAGLnbOBM66+JNROuxVb8BnRJ8=
X-Google-Smtp-Source: AGHT+IHNxJsEuM8SusbM7WEfiTT1P6UcwVxvDVhyNY4ZVSBXKn4PhfBcRxHoCZjzYCH1LfL5u4KGa/Od96LVbhR90rY=
X-Received: by 2002:a05:6512:344e:b0:4f8:66e1:14e8 with SMTP id
 j14-20020a056512344e00b004f866e114e8mr5601636lfr.69.1692020728826; Mon, 14
 Aug 2023 06:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230809210740.18392-1-jorge.lopez2@hp.com> <10276e15-8528-41a9-4b90-7fdf6b890206@redhat.com>
In-Reply-To: <10276e15-8528-41a9-4b90-7fdf6b890206@redhat.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 14 Aug 2023 08:44:27 -0500
Message-ID: <CAOOmCE9PFi5Xwmyr4jMPZ7LgofPY1fwLW71itfXw1km50B-Ybg@mail.gmail.com>
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

Hi Hans,

On Mon, Aug 14, 2023 at 3:41=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi Jorge,
>
> On 8/9/23 23:07, Jorge Lopez wrote:
> > Update steps how order list elements data and elements size are
> > evaluated
> >
> > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> >
> > ---
> > Based on the latest platform-drivers-x86.git/for-next
> > ---
> >  .../x86/hp/hp-bioscfg/order-list-attributes.c    | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c=
 b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> > index b19644ed12e0..d2b61ab950d4 100644
> > --- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> > @@ -152,7 +152,7 @@ static int hp_populate_ordered_list_elements_from_p=
ackage(union acpi_object *ord
> >
> >               switch (order_obj[elem].type) {
> >               case ACPI_TYPE_STRING:
> > -                     if (elem !=3D PREREQUISITES && elem !=3D ORD_LIST=
_ELEMENTS) {
> > +                     if (elem !=3D PREREQUISITES) {
> >                               ret =3D hp_convert_hexstr_to_str(order_ob=
j[elem].string.pointer,
> >                                                              order_obj[=
elem].string.length,
> >                                                              &str_value=
, &value_len);
> > @@ -266,6 +266,15 @@ static int hp_populate_ordered_list_elements_from_=
package(union acpi_object *ord
> >                       if (ret)
> >                               goto exit_list;
> >
> > +                     /*
> > +                      * It is expected for the element size value
> > +                      * to be 1 and not to represent the actual
> > +                      * number of elements stored in comma
> > +                      * separated format. element size value is
> > +                      * recalculated to report the correct number
> > +                      * of data elements found.
> > +                      */
> > +
> >                       part_tmp =3D tmpstr;
> >                       part =3D strsep(&part_tmp, COMMA_SEP);
> >                       if (!part)
> > @@ -273,11 +282,14 @@ static int hp_populate_ordered_list_elements_from=
_package(union acpi_object *ord
> >                                       tmpstr,
> >                                       sizeof(ordered_list_data->element=
s[0]));
> >
> > -                     for (olist_elem =3D 1; olist_elem < MAX_ELEMENTS_=
SIZE && part; olist_elem++) {
> > +                     for (olist_elem =3D 0; olist_elem < MAX_ELEMENTS_=
SIZE && part; olist_elem++) {
> >                               strscpy(ordered_list_data->elements[olist=
_elem],
> >                                       part,
> >                                       sizeof(ordered_list_data->element=
s[olist_elem]));
> > +
> >                               part =3D strsep(&part_tmp, COMMA_SEP);
> > +                             if (part && ordered_list_data->elements_s=
ize < MAX_ELEMENTS_SIZE)
> > +                                     ordered_list_data->elements_size+=
+;
> >                       }
>
> I believe that you can replace the:
>
>                                 if (part && ordered_list_data->elements_s=
ize < MAX_ELEMENTS_SIZE)
>                                         ordered_list_data->elements_size+=
+;
>                         }
>
> Lines with simply (after the loop has finished) doing:
>
>                         }
>                         ordered_list_data->elements_size =3D olist_elem'
>
> Or am I missing something ?

The lines cannot be replaced with a single line for several reasons,
1. elements_size is initially set to 1 and it is only incremented when
a COMMA_SEP is found.  (See part variable)
2. Limit the number of element_size to  MAX_ELEMENTS_SIZE.  The user
requires entering all items in the new order when a change is needed.
For instance, updating boot order.
3. Limiting  elements_size and not just olist_elem to to
MAX_ELEMENTS_SIZE removes the possibility of  array overflow
(ordered_list_data->elements[..]).   olist_elem value is 0 (zero)
based while elements_size is 1 based
>
> Regards,
>
> Hans
>
>
>
