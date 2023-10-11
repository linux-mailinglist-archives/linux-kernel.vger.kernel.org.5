Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6178D7C4C36
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345394AbjJKHpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344927AbjJKHpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:45:10 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A90C9C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:45:06 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-4577c1259c6so1128285137.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697010305; x=1697615105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH8dO8P8jk4qRPtIhdpshR5FUbXSZA/6Cs8Pjyzxf8I=;
        b=H4/o8NBFF4tEYVkdZwImKnHmOBbCUsXQK09IMzqCTs5P21MJfi1bZUZh/FDyzz9Lmx
         Q1hnCpjTl2MU4r6XLkTT3ZbzoyQGf2nL8dKppTG+B222VolDIEx6CAkKCzX7DwZlNMLi
         yUglhzX0CDVSNzm1qD1gq9xsRO+UkrIa/fPNDgC7q2edfTbK1dEuOtvEj/JBUdj908AJ
         zRx1YuRF7hreV4BeWyE8pS92eIBp1tek5gFjQdIXIig+klez4OK9WRqLLspxAGmbgO34
         0jNudXH3rocr+YGnhC4CyB/otAILxrFnjziwUbpmFSvVcw6L4K376frvEJ6bzAb5XAYj
         FYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697010305; x=1697615105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kH8dO8P8jk4qRPtIhdpshR5FUbXSZA/6Cs8Pjyzxf8I=;
        b=idfHLVSioaJxJA//iDipfNGD1gDT5VqKXA/+sWKKKnt/hyapaL3sz2ncyOjgCoCAuV
         U0PPrvAtr2Ez62aW6BN1Wj8G7yehw9bIsJA24WQbnn0nfvhCbjq5S15P0m2inobWocGa
         /M9v612G8ZIxD2cWZ92bAURXMjh9NzJV/IN2fYiJz6e75Dvc4pnRBHrWd/g9T0O8ERKf
         Q2RXmnKbT1qM8iyfQYzR894VPkqqjdUIoeIZFUYskbRgRfzGmFK35WIHkVqgAgTXbi0G
         7BAPnJ7704PgWzUDVm3vlE98HXH3NrO/q1kyN4ocgcpMbjKSMxFMFiCKnv7veub+5Tl+
         0xyw==
X-Gm-Message-State: AOJu0YxqEWes+ZaLAr1BfJvSwW1zEEH7Vwo2BG94Gs2m+H6UeteSnIHz
        ENBbSkqt7mfPHaLVxL5S/8AKeNA6kdGq441zxkR5kw==
X-Google-Smtp-Source: AGHT+IHBzIdHIAC/Xi9T/BSsEBKTKirSfIIjBZMXX6Vq3zMSbOBpga7cOpH94Ly/Vr1jhGL17psjjlVJIPg+gS9tySA=
X-Received: by 2002:a67:ce13:0:b0:44d:3d29:4940 with SMTP id
 s19-20020a67ce13000000b0044d3d294940mr12207630vsl.35.1697010305073; Wed, 11
 Oct 2023 00:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153427.20951-1-brgl@bgdev.pl> <20231009153427.20951-12-brgl@bgdev.pl>
 <y5otsuzhc27xeay6js4nkqss2bo5bsmygwdjuhqpdzce4yffxk@gkkh522s5e3b>
In-Reply-To: <y5otsuzhc27xeay6js4nkqss2bo5bsmygwdjuhqpdzce4yffxk@gkkh522s5e3b>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 11 Oct 2023 09:44:54 +0200
Message-ID: <CAMRc=MdfZzG-C7=OVhR7x_vEmCexS39GEJ3F-CHM7cfya+A-VA@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 12:49=E2=80=AFAM Andrew Halaney <ahalaney@redhat.co=
m> wrote:
>
> On Mon, Oct 09, 2023 at 05:34:23PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Drop the DMA mapping operations from qcom_scm_qseecom_app_send() and
> > convert all users of it in the qseecom module to using the TZ allocator
> > for creating SCM call buffers. Together with using the cleanup macros,
> > it has the added benefit of a significant code shrink. As this is
> > largely a module separate from the SCM driver, let's use a separate
> > memory pool.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> <snip>
>
> > @@ -567,20 +529,14 @@ static efi_status_t qsee_uefi_get_next_variable(s=
truct qcuefi_client *qcuefi,
> >               return EFI_INVALID_PARAMETER;
> >
> >       status =3D qcom_qseecom_app_send(qcuefi->client, req_data, req_si=
ze, rsp_data, rsp_size);
> > -     if (status) {
> > -             efi_status =3D EFI_DEVICE_ERROR;
> > -             goto out_free;
> > -     }
> > +     if (status)
> > +             return EFI_DEVICE_ERROR;
> >
> > -     if (rsp_data->command_id !=3D QSEE_CMD_UEFI_GET_NEXT_VARIABLE) {
> > -             efi_status =3D EFI_DEVICE_ERROR;
> > -             goto out_free;
> > -     }
> > +     if (rsp_data->command_id !=3D QSEE_CMD_UEFI_GET_NEXT_VARIABLE)
> > +             return EFI_DEVICE_ERROR;
> >
> > -     if (rsp_data->length < sizeof(*rsp_data)) {
> > -             efi_status =3D EFI_DEVICE_ERROR;
> > -             goto out_free;
> > -     }
> > +     if (rsp_data->length < sizeof(*rsp_data))
> > +             return EFI_DEVICE_ERROR;
> >
> >       if (rsp_data->status) {
> >               dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n=
",
> > @@ -595,77 +551,59 @@ static efi_status_t qsee_uefi_get_next_variable(s=
truct qcuefi_client *qcuefi,
> >               if (efi_status =3D=3D EFI_BUFFER_TOO_SMALL)
> >                       *name_size =3D rsp_data->name_size;
> >
> > -             goto out_free;
> > +             return efi_status;
> >       }
> >
> > -     if (rsp_data->length > rsp_size) {
> > -             efi_status =3D EFI_DEVICE_ERROR;
> > -             goto out_free;
> > -     }
> > +     if (rsp_data->length > rsp_size)
> > +             return EFI_DEVICE_ERROR;
> >
> > -     if (rsp_data->name_offset + rsp_data->name_size > rsp_data->lengt=
h) {
> > -             efi_status =3D EFI_DEVICE_ERROR;
> > -             goto out_free;
> > -     }
> > +     if (rsp_data->name_offset + rsp_data->name_size > rsp_data->lengt=
h)
> > +             return EFI_DEVICE_ERROR;
> >
> > -     if (rsp_data->guid_offset + rsp_data->guid_size > rsp_data->lengt=
h) {
> > -             efi_status =3D EFI_DEVICE_ERROR;
> > -             goto out_free;
> > -     }
> > +     if (rsp_data->guid_offset + rsp_data->guid_size > rsp_data->lengt=
h)
> > +             return EFI_DEVICE_ERROR;
> >
> >       if (rsp_data->name_size > *name_size) {
> >               *name_size =3D rsp_data->name_size;
> > -             efi_status =3D EFI_BUFFER_TOO_SMALL;
> > -             goto out_free;
> > +             return EFI_BUFFER_TOO_SMALL;
> >       }
> >
> > -     if (rsp_data->guid_size !=3D sizeof(*guid)) {
> > -             efi_status =3D EFI_DEVICE_ERROR;
> > -             goto out_free;
> > -     }
> > +     if (rsp_data->guid_size !=3D sizeof(*guid))
> > +             return EFI_DEVICE_ERROR;
> >
> >       memcpy(guid, ((void *)rsp_data) + rsp_data->guid_offset, rsp_data=
->guid_size);
> >       status =3D ucs2_strscpy(name, ((void *)rsp_data) + rsp_data->name=
_offset,
> >                             rsp_data->name_size / sizeof(*name));
> >       *name_size =3D rsp_data->name_size;
> >
> > -     if (status < 0) {
> > +     if (status < 0)
> >               /*
> >                * Return EFI_DEVICE_ERROR here because the buffer size s=
hould
> >                * have already been validated above, causing this functi=
on to
> >                * bail with EFI_BUFFER_TOO_SMALL.
> >                */
> >               return EFI_DEVICE_ERROR;
> > -     }
>
> Personally (no idea what the actual style guide says) leaving braces
> around the multiline if statement would be nice.... that being said,
> that's my opinion :)
>
> <snip>
> > @@ -704,12 +635,7 @@ static efi_status_t qsee_uefi_query_variable_info(=
struct qcuefi_client *qcuefi,
> >       if (max_variable_size)
> >               *max_variable_size =3D rsp_data->max_variable_size;
> >
> > -out_free:
> > -     kfree(rsp_data);
> > -out_free_req:
> > -     kfree(req_data);
> > -out:
> > -     return efi_status;
> > +     return EFI_SUCCESS;
> >  }
> >
> >  /* -- Global efivar interface. ---------------------------------------=
------- */
> > @@ -838,6 +764,10 @@ static int qcom_uefisecapp_probe(struct auxiliary_=
device *aux_dev,
> >       if (status)
> >               qcuefi_set_reference(NULL);
> >
> > +     qcuefi->mempool =3D devm_qcom_tzmem_pool_new(&aux_dev->dev, SZ_25=
6K);
>
> Any particular reason for this size? Just curious, it was (one) of the
> reasons I had not marked patch 4 yet (it looks good, but I wanted to get
> through the series to digest the Kconfig as well).
>

I cannot test this. Do you know what the minimum correct size would be?

Bart

> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
>
