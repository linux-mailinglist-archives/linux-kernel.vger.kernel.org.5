Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA5F774B70
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjHHUrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbjHHUr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:47:27 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E706E8A6F;
        Tue,  8 Aug 2023 13:26:06 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so10087187e87.0;
        Tue, 08 Aug 2023 13:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691526365; x=1692131165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzQthcTYYC1HexdHWuevRI13uEmJKTZWWaC343YuPRA=;
        b=hf/mYwff/XYaIN0MlyrvC+XLWNtxbERCkoz+I0Lz7l+1rVci9fa4tVgrLmyiG/c2ng
         kEkVGKJev8QiiFkHp/07J3LY+EH5uv87cnJu7wC4hngd0T9i6U93qurJ+k5+7eXNRCH3
         3A6YeoU5ciwlxZzPTgBcDzKQVN1bLQCj/lZF7X1gLtGBZ1EUbWF2LLQhKZwFH8fLIbDP
         GdKe7GG13dU8Smrou4bGlZKxuk/QXgK8VfcAAUQteyN0WHvOPIrO/WU6boT90kIBLHEd
         gadFoWrvQtzqf4m4c3tiTb37j0wZxit6M4zMN7Yl8hh5IUC+eTgSXsmJs2Pm1Ex2r0oj
         Ld0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691526365; x=1692131165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzQthcTYYC1HexdHWuevRI13uEmJKTZWWaC343YuPRA=;
        b=KHVAavZHepwutZktfovI3JgpbX29lOmKpvloFdbWaivhcn3QToy+UGI5IZPihRNSQw
         a20UCeHQAe4AAmhlF0THPLZn6O+vMnaBrnmS5T9829MgZSBddFKRvgVGzaR5I6jefEM+
         Icv7hu3176UlpkJrGbf1lJZHfen7+NYMDoPOrjaTUnOL0asci2A/VECEzoHEeSQYctVQ
         bTS3kyYRZ3+23SsrcfhXCGZuQoifki++mVhjzWJkIluMgWsDBBKt1ceh96nIvRBQjmr5
         Y4OxdYCHFKyO5MGwguqdntd0KqZWQEy0OMrrGAH5zywJhoez/EKtBmhkfX8WPkR+grYZ
         uehQ==
X-Gm-Message-State: AOJu0YyAGVDilFUx+laLQn3C5EIntTM9E4ARjJYkCGH1+Kc+fXlUnMqx
        Kq8HqNqSS4NUzY0d4eyHfes2AVzqPTzhKTqz4Zo=
X-Google-Smtp-Source: AGHT+IGyOTmS47kqyS0agL6RbmqWZCvy5I956BNMw2QxRqanogavZ0IkZ+k04yOQL9p5FlVXRDWzTqsf7WEWzjk3lkE=
X-Received: by 2002:a05:6512:2037:b0:4fd:da65:d10 with SMTP id
 s23-20020a056512203700b004fdda650d10mr390968lfs.36.1691526364831; Tue, 08 Aug
 2023 13:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230801191629.45942-1-jorge.lopez2@hp.com> <4ab55129-d35c-fea5-0c59-5183928d55d1@redhat.com>
In-Reply-To: <4ab55129-d35c-fea5-0c59-5183928d55d1@redhat.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 8 Aug 2023 15:25:04 -0500
Message-ID: <CAOOmCE_DGqUh3+8LmrX2_7eTeDG_7p7-JKN7Q2syvDQu60UWmQ@mail.gmail.com>
Subject: Re: [PATCH] hp-bioscfg: Update string length calculation
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas@t-8ch.de, ilpo.jarvinen@linux.intel.com,
        dan.carpenter@linaro.org
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

Hi Hans,

On Mon, Aug 7, 2023 at 6:28=E2=80=AFAM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Hi Jorge,
>
> On 8/1/23 21:16, Jorge Lopez wrote:
> > Replace method how the string length is calculated.
> > Removed unused variable 'size'
> >
> > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
>
> While reviewing this I have noticed that the parsing of ORD_LIST_ELEMENTS
> in hp_populate_ordered_list_elements_from_package() seems to be quite bug=
gy:
>
> 1. Normally str_value and value_len get set for string type package eleme=
nts by:
>
>                 case ACPI_TYPE_STRING:
>                         if (elem !=3D PREREQUISITES && elem !=3D ORD_LIST=
_ELEMENTS) {
>                                 ret =3D hp_convert_hexstr_to_str(order_ob=
j[elem].string.pointer,
>                                                                order_obj[=
elem].string.length,
>                                                                &str_value=
, &value_len);
>                                 if (ret)
>                                         continue;
>                         }
>                         break;
>
> But notice how the  hp_convert_hexstr_to_str() call gets stepped when
> elem =3D=3D ORD_LIST_ELEMENTS .
>
> Yes when next dealing with ORD_LIST_ELEMENTS the never updated str_value =
and value_len
> get used:
>
>                 switch (eloc) {
>                 ...
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
> So that does not seem right.

I will investigate.

>
> 2. ordered_list_data->elements[0] never gets filled when there actually i=
s a comma in
>    the ordered-list, iow when there is more then 1 element:
>
>                         part_tmp =3D tmpstr;
>                         part =3D strsep(&part_tmp, COMMA_SEP);
>                         if (!part)
>                                 strscpy(ordered_list_data->elements[0],
>                                         tmpstr,
>                                         sizeof(ordered_list_data->element=
s[0]));
>
>                         for (elem =3D 1; elem < MAX_ELEMENTS_SIZE && part=
; elem++) {
>                                 strscpy(ordered_list_data->elements[elem]=
,
>                                         part,
>                                         sizeof(ordered_list_data->element=
s[elem]));
>                                 part =3D strsep(&part_tmp, SEMICOLON_SEP)=
;
>                         }
>
> Notice how the for starts at elem =3D 1, so if part is not NULL (and it i=
s never NULL for the first call strsep will always return tmpstr) then orde=
red_list_data->elements[0] never gets filled.
>

I will investigate and make the necessary corrections.

> 3. ordered_list_data->elements_size is set but never validated. You shoul=
d compare elem after the loop with ordered_list_data->elements_size and mak=
e sure they match. IOW verify that 0-(ordered_list_data->elements_size-1) e=
ntries of the ordered_list_data->elements[] array have been filled.

ordered_list_data->elements_size is checked against MAX_ELEMENTS_SIZE
and not against the number of elements in the array.  Initially, size
value was reported (sysfs) but after a couple reviews, size was
removed from being reported (sysfs).  size value will be determined by
the application when it enumerates the values reported in elements.

>
> 4. For specific values of eloc the code expects the current order_obj[ele=
m] to be either an integer or a string, but this is not validated. Please v=
alidate that order_obj[elem].type matches with what is expected (string or =
int) for the current value of eloc.

The purpose for 'eloc' is  to help skip reading values such
ORD_LIST_ELEMENTS and PREREQUISITES when ORD_LIST_ELEMENTS and/or
PREREQUISITES_SIZE values are zero.
Normally, 'eloc' and 'elem' are the same.

>
> This all makes me wonder if this specific code-path has been tested ?  Pl=
ease make sure to test this specific code-path.
>
This code path was tested previously.  I will make sure the path is
tested in deeper detail.



> Regards,
>
> Hans
>
>
>
>
>
> >
> > ---
> > Based on the latest platform-drivers-x86.git/for-next
> > ---
> >  drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c=
 b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> > index cffc1c9ba3e7..b19644ed12e0 100644
> > --- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> > @@ -258,13 +258,11 @@ static int hp_populate_ordered_list_elements_from=
_package(union acpi_object *ord
> >                               eloc++;
> >                       break;
> >               case ORD_LIST_ELEMENTS:
> > -                     size =3D ordered_list_data->elements_size;
> > -
> >                       /*
> >                        * Ordered list data is stored in hex and comma s=
eparated format
> >                        * Convert the data and split it to show each ele=
ment
> >                        */
> > -                     ret =3D hp_convert_hexstr_to_str(str_value, value=
_len, &tmpstr, &tmp_len);
> > +                     ret =3D hp_convert_hexstr_to_str(str_value, strle=
n(str_value), &tmpstr, &tmp_len);
> >                       if (ret)
> >                               goto exit_list;
> >
> > @@ -279,7 +277,7 @@ static int hp_populate_ordered_list_elements_from_p=
ackage(union acpi_object *ord
> >                               strscpy(ordered_list_data->elements[olist=
_elem],
> >                                       part,
> >                                       sizeof(ordered_list_data->element=
s[olist_elem]));
> > -                             part =3D strsep(&part_tmp, SEMICOLON_SEP)=
;
> > +                             part =3D strsep(&part_tmp, COMMA_SEP);
> >                       }
> >
> >                       kfree(str_value);
>
