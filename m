Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341677C5711
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343919AbjJKOiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbjJKOiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:38:01 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD3392
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:37:59 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-4577c1ae94fso1481756137.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697035079; x=1697639879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+IB6Cv/SDZ64TC4w7G5T3n0RF/VD2rvTHF4Rn8cbn4=;
        b=bU0TXDrMJ/l5I+m7fRZ+f9YA+XxWBcxD/wgzJbaRbBAVZki6oVtxrkfs2TumHXnX5v
         C8Fda0QiNDpRb5ppg7+O8gl0OT6rxzjwHfY5k3wGADib73Zahq1hVXGh8UDUmHPCTN8V
         jrGzhtRmvUcnv8xnV6pq8dI0uMepD1kLz4IZL5ncp3x0qx/mp/SWkqnRZzdAZvj9wUBD
         AKNHzwpKfemq2ic6mNBJY2f9OVgSugEHfsqh0hpZTyD5IcPk4o+PRju0GGEj3G71ZRco
         qgFPora5O0sHUTFwvriR9kNSfPg40pxQm0b67iV6XwzVq0DYGTS6wkMcIuHyw7mnHK5o
         lqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697035079; x=1697639879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+IB6Cv/SDZ64TC4w7G5T3n0RF/VD2rvTHF4Rn8cbn4=;
        b=P3I6T5bV1WpS8QxI4tvCMMk+KcSb+rYLVNWd2CV2vTEzNh3Z85E4P4glVSZjmpJ4vL
         o6DYJAtiqTNKSKspyYStPItOYVr1JTq2lxTKo0xkvt24XaWqW+mTtkydiV3576N27Sy4
         8VWa8U7tHUcjUaqGZTWdANcY6LAw/GI4X5CTv5NpYSpyMSRvnDYXFer465XXSioUXm9x
         1N7ilVXWH/Y9d4HI+LH1XzPwY7UYtjTEDg2rUqg0q2/mTVA7TTg5Ln/8Ii7RmP2V+bnv
         DWTnTlpo2IRLiWmF2D8muJgne3hXi0suCYPGvqi/R293PPFGFqvhqcGdnp3cCKgbQbVC
         0RLg==
X-Gm-Message-State: AOJu0Yw3QfGDS5L+KyAU9ebYzET1GPZPRNp84TpP05aS/hpzqV/8gYdO
        1pjVlar5N7B1St5FlPrn6M51hodAS0dNpztheGIdFg==
X-Google-Smtp-Source: AGHT+IFLjLp8MkIsl9sgVKXROYanB6IQcdYh6XOgUF9CrY5EncbbMf1IZt0DnruisavDYZuPdK+5jM96AgQ6b0x/aHs=
X-Received: by 2002:a05:6102:3b11:b0:457:a8fa:cf2b with SMTP id
 x17-20020a0561023b1100b00457a8facf2bmr1011856vsu.14.1697035078927; Wed, 11
 Oct 2023 07:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153427.20951-1-brgl@bgdev.pl> <20231009153427.20951-12-brgl@bgdev.pl>
 <y5otsuzhc27xeay6js4nkqss2bo5bsmygwdjuhqpdzce4yffxk@gkkh522s5e3b>
 <CAMRc=MdfZzG-C7=OVhR7x_vEmCexS39GEJ3F-CHM7cfya+A-VA@mail.gmail.com> <ebihxhbl2hyhuke3l2nm56yhvmj4qcja6fbihrc4bhrf2czoix@wjnnyic7wvi7>
In-Reply-To: <ebihxhbl2hyhuke3l2nm56yhvmj4qcja6fbihrc4bhrf2czoix@wjnnyic7wvi7>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 11 Oct 2023 16:37:48 +0200
Message-ID: <CAMRc=McBUKZR+esuyXzPdpM=DVK3EQqQXa=eH8hn_RvhO-JZSA@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] firmware: qcom: qseecom: convert to using the TZ allocator
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 3:56=E2=80=AFPM Andrew Halaney <ahalaney@redhat.com=
> wrote:
>
> On Wed, Oct 11, 2023 at 09:44:54AM +0200, Bartosz Golaszewski wrote:
> > On Wed, Oct 11, 2023 at 12:49=E2=80=AFAM Andrew Halaney <ahalaney@redha=
t.com> wrote:
> > >
> > > On Mon, Oct 09, 2023 at 05:34:23PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Drop the DMA mapping operations from qcom_scm_qseecom_app_send() an=
d
> > > > convert all users of it in the qseecom module to using the TZ alloc=
ator
> > > > for creating SCM call buffers. Together with using the cleanup macr=
os,
> > > > it has the added benefit of a significant code shrink. As this is
> > > > largely a module separate from the SCM driver, let's use a separate
> > > > memory pool.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > <snip>
> > >
> > > > @@ -567,20 +529,14 @@ static efi_status_t qsee_uefi_get_next_variab=
le(struct qcuefi_client *qcuefi,
> > > >               return EFI_INVALID_PARAMETER;
> > > >
> > > >       status =3D qcom_qseecom_app_send(qcuefi->client, req_data, re=
q_size, rsp_data, rsp_size);
> > > > -     if (status) {
> > > > -             efi_status =3D EFI_DEVICE_ERROR;
> > > > -             goto out_free;
> > > > -     }
> > > > +     if (status)
> > > > +             return EFI_DEVICE_ERROR;
> > > >
> > > > -     if (rsp_data->command_id !=3D QSEE_CMD_UEFI_GET_NEXT_VARIABLE=
) {
> > > > -             efi_status =3D EFI_DEVICE_ERROR;
> > > > -             goto out_free;
> > > > -     }
> > > > +     if (rsp_data->command_id !=3D QSEE_CMD_UEFI_GET_NEXT_VARIABLE=
)
> > > > +             return EFI_DEVICE_ERROR;
> > > >
> > > > -     if (rsp_data->length < sizeof(*rsp_data)) {
> > > > -             efi_status =3D EFI_DEVICE_ERROR;
> > > > -             goto out_free;
> > > > -     }
> > > > +     if (rsp_data->length < sizeof(*rsp_data))
> > > > +             return EFI_DEVICE_ERROR;
> > > >
> > > >       if (rsp_data->status) {
> > > >               dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x=
%x\n",
> > > > @@ -595,77 +551,59 @@ static efi_status_t qsee_uefi_get_next_variab=
le(struct qcuefi_client *qcuefi,
> > > >               if (efi_status =3D=3D EFI_BUFFER_TOO_SMALL)
> > > >                       *name_size =3D rsp_data->name_size;
> > > >
> > > > -             goto out_free;
> > > > +             return efi_status;
> > > >       }
> > > >
> > > > -     if (rsp_data->length > rsp_size) {
> > > > -             efi_status =3D EFI_DEVICE_ERROR;
> > > > -             goto out_free;
> > > > -     }
> > > > +     if (rsp_data->length > rsp_size)
> > > > +             return EFI_DEVICE_ERROR;
> > > >
> > > > -     if (rsp_data->name_offset + rsp_data->name_size > rsp_data->l=
ength) {
> > > > -             efi_status =3D EFI_DEVICE_ERROR;
> > > > -             goto out_free;
> > > > -     }
> > > > +     if (rsp_data->name_offset + rsp_data->name_size > rsp_data->l=
ength)
> > > > +             return EFI_DEVICE_ERROR;
> > > >
> > > > -     if (rsp_data->guid_offset + rsp_data->guid_size > rsp_data->l=
ength) {
> > > > -             efi_status =3D EFI_DEVICE_ERROR;
> > > > -             goto out_free;
> > > > -     }
> > > > +     if (rsp_data->guid_offset + rsp_data->guid_size > rsp_data->l=
ength)
> > > > +             return EFI_DEVICE_ERROR;
> > > >
> > > >       if (rsp_data->name_size > *name_size) {
> > > >               *name_size =3D rsp_data->name_size;
> > > > -             efi_status =3D EFI_BUFFER_TOO_SMALL;
> > > > -             goto out_free;
> > > > +             return EFI_BUFFER_TOO_SMALL;
> > > >       }
> > > >
> > > > -     if (rsp_data->guid_size !=3D sizeof(*guid)) {
> > > > -             efi_status =3D EFI_DEVICE_ERROR;
> > > > -             goto out_free;
> > > > -     }
> > > > +     if (rsp_data->guid_size !=3D sizeof(*guid))
> > > > +             return EFI_DEVICE_ERROR;
> > > >
> > > >       memcpy(guid, ((void *)rsp_data) + rsp_data->guid_offset, rsp_=
data->guid_size);
> > > >       status =3D ucs2_strscpy(name, ((void *)rsp_data) + rsp_data->=
name_offset,
> > > >                             rsp_data->name_size / sizeof(*name));
> > > >       *name_size =3D rsp_data->name_size;
> > > >
> > > > -     if (status < 0) {
> > > > +     if (status < 0)
> > > >               /*
> > > >                * Return EFI_DEVICE_ERROR here because the buffer si=
ze should
> > > >                * have already been validated above, causing this fu=
nction to
> > > >                * bail with EFI_BUFFER_TOO_SMALL.
> > > >                */
> > > >               return EFI_DEVICE_ERROR;
> > > > -     }
> > >
> > > Personally (no idea what the actual style guide says) leaving braces
> > > around the multiline if statement would be nice.... that being said,
> > > that's my opinion :)
> > >
> > > <snip>
> > > > @@ -704,12 +635,7 @@ static efi_status_t qsee_uefi_query_variable_i=
nfo(struct qcuefi_client *qcuefi,
> > > >       if (max_variable_size)
> > > >               *max_variable_size =3D rsp_data->max_variable_size;
> > > >
> > > > -out_free:
> > > > -     kfree(rsp_data);
> > > > -out_free_req:
> > > > -     kfree(req_data);
> > > > -out:
> > > > -     return efi_status;
> > > > +     return EFI_SUCCESS;
> > > >  }
> > > >
> > > >  /* -- Global efivar interface. -----------------------------------=
----------- */
> > > > @@ -838,6 +764,10 @@ static int qcom_uefisecapp_probe(struct auxili=
ary_device *aux_dev,
> > > >       if (status)
> > > >               qcuefi_set_reference(NULL);
> > > >
> > > > +     qcuefi->mempool =3D devm_qcom_tzmem_pool_new(&aux_dev->dev, S=
Z_256K);
> > >
> > > Any particular reason for this size? Just curious, it was (one) of th=
e
> > > reasons I had not marked patch 4 yet (it looks good, but I wanted to =
get
> > > through the series to digest the Kconfig as well).
> > >
> >
> > I cannot test this. Do you know what the minimum correct size would be?
>
> I've got no insight into these firmware interfaces unfortunately. Was
> mostly curious if Qualcomm had provided a suggestion behind the scenes
> or if this was picked as a "sufficiently large" pool size.
>

No, I chose a small but reasonable value and intend to see if it
breaks anything. :)

But if anyone from QCom reading knows a better value - be it smaller
or larger, please let me know.

Bartosz

> >
> > Bart
> >
> > > Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> > >
> >
>
