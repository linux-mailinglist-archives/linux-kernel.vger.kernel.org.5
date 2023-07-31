Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17C3769CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjGaQhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjGaQhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:37:07 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848672696;
        Mon, 31 Jul 2023 09:36:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe11652b64so7824077e87.0;
        Mon, 31 Jul 2023 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690821392; x=1691426192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhfT1yEl0YlwSpMeZ+Q6Gzotam/qS/GL4FEPmGiv+3k=;
        b=OAbpDmTyW57PeNdSksMcnO+YFe7ZX4Ne9VdCjPul9HyNAA9faDGZxhIotneyYZkYC6
         MibB0Gzjo1qNuO6TVvovAjRewqXv9RG8H2Epsl52l7JjYwmEU2t/+I6TxLeuNvVaJE+f
         KAhOQmxAnBcC5jJHhHNN5ExE0rPV8CNydavxccURobvNcinHFnXtSAgwauGsCvlrbpa5
         gaue4EFjRbWI8y932cnbyzcKHMw0MWVEB4kIsSByjPMwv5miVkiog80w0bXOgue2j/l+
         zP9nL6Ff+/yjnqi2gNqeza0RPY1sPpd15GJ8q2z7c7j69+dZYKlKfqyzg73IaMLhZcFV
         nZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690821392; x=1691426192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhfT1yEl0YlwSpMeZ+Q6Gzotam/qS/GL4FEPmGiv+3k=;
        b=fNQiT+sqdkZFcCw7AvQeAB/Ved9wIanNkVjk4a6femKdDxx3KlkPy2AXr8cqaudLX4
         /bauAic9eQVC0HxwCV13HL9ACrSu4QjFcP/UPKFDpJ1B/ICCOll1QF0rPVNBHgBwCfZ4
         daRoeVNxcc6w47He+fG72QftPD8irvKfkiUe4C8fB8LsydMYeagwdnHq6JeMsMWgctzi
         YoI7HxBvKocB+i0/tcdl5+fKMU6/5bbCQiu1eWxgPrxZVwdhC5YM08+0G30kFBU2X6F4
         DJAzejDZwTaf4XRM8j92rrMQaUcJulPSFTPOdb7FssCYiVAF4SyJFIz6pHMv3fRuec5l
         UPcw==
X-Gm-Message-State: ABy/qLaGHDbijY5bmt8PYOffbnqsVC2UT/n5R8mZcBYR8VTyCpIVU3bu
        ekNuGO6OdZtG7ML+12hIG6vTGwbLMkwGg45ZGLg=
X-Google-Smtp-Source: APBJJlGZzqiqtAC+2b2S6DIw+UBXpwa+s70YRdad4k5S4j8TUpLfA53ThBB//OYvDy9VUZQ0DPN/K1B1Mpaw7SvzH/g=
X-Received: by 2002:a19:2d59:0:b0:4fe:2efa:b847 with SMTP id
 t25-20020a192d59000000b004fe2efab847mr244618lft.23.1690821392320; Mon, 31 Jul
 2023 09:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230725220056.25560-1-jorge.lopez2@hp.com> <20230725220056.25560-3-jorge.lopez2@hp.com>
 <77867e93-7785-457c-9e37-4b41503bb509@moroto.mountain> <CAOOmCE_uRxqjTYueZkStbXeU5GKRUnvFOSGNhiBbtWDfkvxveg@mail.gmail.com>
 <2978ca9d-fbab-45b1-8d90-321fb9453965@kadam.mountain>
In-Reply-To: <2978ca9d-fbab-45b1-8d90-321fb9453965@kadam.mountain>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 31 Jul 2023 11:35:35 -0500
Message-ID: <CAOOmCE_p_QgV0QJZKtYZD+t7Y9MzNOQ9sEkfSM88VoHDUCwdCw@mail.gmail.com>
Subject: Re: [PATCH 2/5] hp-bioscfg: Fix memory leaks in ordered_list_elements_from_package
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

On Mon, Jul 31, 2023 at 11:16=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> On Mon, Jul 31, 2023 at 11:03:42AM -0500, Jorge Lopez wrote:
> > On Thu, Jul 27, 2023 at 1:21=E2=80=AFAM Dan Carpenter <dan.carpenter@li=
naro.org> wrote:
> > >    134          int value_len =3D 0;
> > >    135          int ret;
> > >    136          u32 size;
> > >    137          u32 int_value =3D 0;
> > >
> > > It confused me that it's called int_value when it's not an int.  Just
> > > call it "u32 value =3D 0;".
> >
> > The variable is named int_value when it is not an int because it
> > stores the value reported by ACPI_TYPE_INTEGER package.
> > The variable will be renamed to  type_int_value;
>
> Eep!  That's even worse!  Just leave it as-is then.

Oops!  just send a new patch using type_int_value.  Should I change it back=
?
>
> > >    201                  case SEQUENCE:
> > >    202                          ordered_list_data->common.sequence =
=3D int_value;
> > >    203                          break;
> > >    204                  case PREREQUISITES_SIZE:
> > >    205                          ordered_list_data->common.prerequisit=
es_size =3D int_value;
> > >    206                          if (int_value > MAX_PREREQUISITES_SIZ=
E)
> > >    207                                  pr_warn("Prerequisites size v=
alue exceeded the maximum number of elements supported or data may be malfo=
rmed\n");
> > >
> > >         ret =3D -EINVAL;
> > >         break;
> > >
> > We encountered during our testing that one or more packages could be
> > assigned the wrong package type or invalid data..
> > For this reason, it was decided to ignore any invalid data and
> > incorrect type package and allow the read process to continue.
> >
>
> So you have BIOSes which are still printing this warning and you can't
> fix it?  Fine.  Are you sure it's not because you re-used the elem
> iterator and started looping again in the middle?

Yes.  I am sure.   The BIOS where this code is applicable to is for
2018 platforms and earlier.
This is the reason, a customer may encounter this problem in an old BIOS.

>
> Could you at least do the bounds check here instead of in the next step?
>
>
>                 if (int_value > MAX_PREREQUISITES_SIZE) {
>                         pr_warn("Prerequisites size value exceeded the ma=
ximum number of elements supported or data may be malformed\n");
>                         int_value =3D MAX_PREREQUISITES_SIZE;
>                 }
>                 ordered_list_data->common.prerequisites_size =3D int_valu=
e;
>
> > >    257                  case ORD_LIST_ELEMENTS:
> > >    258                          size =3D ordered_list_data->elements_=
size;
> > >
> > > We don't use size anywhere so this can be deleted.
> > >
> > >    259
> > >    260                          /*
> > >    261                           * Ordered list data is stored in hex=
 and comma separated format
> > >    262                           * Convert the data and split it to s=
how each element
> > >    263                           */
> > >    264                          ret =3D hp_convert_hexstr_to_str(str_=
value, value_len, &tmpstr, &tmp_len);
> > >
> > > The value_len here is wrong.  We don't read value_len for ORD_LIST_EL=
EMENTS
> > > or PREREQUISITES so this value_len comes from the PATH object.
> > The size
>
I meant to say,  I should have used 'size' instead of 'value_len' in line 2=
64.

ret =3D hp_convert_hexstr_to_str(str_value, size, &tmpstr, &tmp_len);

> ?
>
> regards,
> dan carpenter
