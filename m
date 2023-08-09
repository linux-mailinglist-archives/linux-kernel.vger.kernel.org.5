Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946FC77695C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjHIUAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjHIUAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:00:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EAAD2;
        Wed,  9 Aug 2023 13:00:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso186989e87.2;
        Wed, 09 Aug 2023 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691611208; x=1692216008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tNGF90ADPnxvT7i6nAuURSR6k+W+/qX2SMZO3m6gVw=;
        b=b2B57AXTTn8Ydu7IML+UeOBvnestGtnwXp9i9omjyraVct5AsEPB0bQJYJzXxpJxqm
         qXuvPGqrNBRvW+qtbEbrvi7SrYA22kxrZ17bkgmm5Zr4/L5MNP55OAAkMFCq3e56gaAQ
         NwoSoHWLDFgCJY+LhCTScQ1j6JIhj8cK1HEx70goi2lPG34hQ2VZ7W5d/ePWRXpq0lLI
         JdvgHbpbgprYomewyJWfs4SZp/x1K0Iknv4ca8j0xDO4sALx7cixxMLyY1akcj/6WkPP
         o7y6329aW6Nmlc71j3QrU7vqa+EG4pg9VtqccgF13Q5qClTxyOr6n1VKPJxRErndQozv
         x8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691611208; x=1692216008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tNGF90ADPnxvT7i6nAuURSR6k+W+/qX2SMZO3m6gVw=;
        b=jFi5TpxEJG/WlI7q03x23sJp4Pp7OSfvnYpC0NKUMbprVwKini1R3ebgmIK4MOdENI
         W/vdcAbt8VvN/FfyqyXVoCdpLL7aauCfG3wMw47qklttIpVojk1ozXTJElF5qjFvJEre
         RDw8WRPci2CqRyixyccB387TEM3BJMY2bkenL4zEFV1x+iUCB2JdRmV6uJuCpWMVT/bz
         Yqy/7vqHzfqxOrYN3ReYGDW3z95fBGTuzpCS/yhbKXoODkefYGrLR+1zw7dTaIWkt+43
         941VXIR8B9KcJTyxhRtnEpL/vncukqPYiYrzkSFSi72Xl5ZazfbGZLrpoAGdEOYi6CYW
         +OLg==
X-Gm-Message-State: AOJu0Ywnufz77tvw4d4MKgLpO0Spohzk+nFVaem9Pue3QDwBNaWBYvpd
        tYFdok77t/nOLRUoJchw/PaTTwrDf+pJkWnJmJU=
X-Google-Smtp-Source: AGHT+IFO6XV7HbAAXzENyNoxhf7AfOCnz7s0Vp60cNdk6wuASadePDEBnWV6OmvZtV6T327zKPO6zBzIAqRo9AgFgUs=
X-Received: by 2002:a19:500b:0:b0:4f8:7568:e948 with SMTP id
 e11-20020a19500b000000b004f87568e948mr92674lfb.51.1691611207700; Wed, 09 Aug
 2023 13:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230801191629.45942-1-jorge.lopez2@hp.com> <4ab55129-d35c-fea5-0c59-5183928d55d1@redhat.com>
 <CAOOmCE_DGqUh3+8LmrX2_7eTeDG_7p7-JKN7Q2syvDQu60UWmQ@mail.gmail.com> <1ea7e949-e05b-985c-bb0c-6d0b00bb8b5f@redhat.com>
In-Reply-To: <1ea7e949-e05b-985c-bb0c-6d0b00bb8b5f@redhat.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Wed, 9 Aug 2023 14:59:07 -0500
Message-ID: <CAOOmCE9ms1iztr7pXUaEqEqr922NeTgcopPuWyC8s47A0HXb3w@mail.gmail.com>
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

On Tue, Aug 8, 2023 at 4:52=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Hi,
>
> On 8/8/23 22:25, Jorge Lopez wrote:
> > Hi Hans,
> >
> > On Mon, Aug 7, 2023 at 6:28=E2=80=AFAM Hans de Goede <hdegoede@redhat.c=
om> wrote:
>
> <snip>
>
> >> 3. ordered_list_data->elements_size is set but never validated. You sh=
ould compare elem after the loop with ordered_list_data->elements_size and =
make sure they match. IOW verify that 0-(ordered_list_data->elements_size-1=
) entries of the ordered_list_data->elements[] array have been filled.
> >
> > ordered_list_data->elements_size is checked against MAX_ELEMENTS_SIZE
> > and not against the number of elements in the array.  Initially, size
> > value was reported (sysfs) but after a couple reviews, size was
> > removed from being reported (sysfs).  size value will be determined by
> > the application when it enumerates the values reported in elements.
>
> Right, but after splitting the string on commas there should be ordered_l=
ist_data->elements_size entries, right ? So we should verify that. Also wha=
t if the string after splitting has more entries then MAX_ELEMENTS_SIZE, th=
en currently the code will overflow the array, so the loop splitting the st=
ring on commas should ensure that MAX_ELEMENTS_SIZE is not exceeded.

That is correct.   It is expected for the element size value to be 1
and does not represent the actual number of elements stored in comma
separated format. Element size value will be recalculated to report
the correct number of data elements present.
The loop restricts the max number of elements to MAX_ELEMENTS_SIZE to
avoid overflow the array..

I will make the necessary correction.
>
> >>
> >> 4. For specific values of eloc the code expects the current order_obj[=
elem] to be either an integer or a string, but this is not validated. Pleas=
e validate that order_obj[elem].type matches with what is expected (string =
or int) for the current value of eloc.
> >
> > The purpose for 'eloc' is  to help skip reading values such
> > ORD_LIST_ELEMENTS and PREREQUISITES when ORD_LIST_ELEMENTS and/or
> > PREREQUISITES_SIZE values are zero.
> > Normally, 'eloc' and 'elem' are the same.
>
> Never mind what I meant to say is that you should to a check like this:
>
>                 /* Check that both expected and read object type match */
>                 if (expected_order_types[eloc] !=3D order_obj[elem].type)=
 {
>                         pr_err("Error expected type %d for elem %d, but g=
ot type %d instead\n"
>                                expected_order_types[eloc], elem, order_ob=
j[elem].type);
>                         return -EIO;
>                 }
>
> But I see now that that check is already there.
>
> Regards,
>
> Hans
>
>
