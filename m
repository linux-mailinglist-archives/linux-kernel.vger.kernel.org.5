Return-Path: <linux-kernel+bounces-66115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F13DD855728
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A868528264E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BB41419A9;
	Wed, 14 Feb 2024 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igzNy4bW"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FF413DB90;
	Wed, 14 Feb 2024 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952774; cv=none; b=WqGgKbd+hlVM7uZ7SgRLHpM603agwE5yd34aOnzinJYKVJ7b/KP3cMorFg6eTeO33i+KBB3uj9DPzm8Glj/GVGSCoMZJDfyoVOAL0cLEFjjDAO0nb/wa5Q0Wa0ZqU1BY/TM4JIrdpbJzC5iefmtMcp+HCV5C6ubeIsuXUdOcAxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952774; c=relaxed/simple;
	bh=miSMayeRVuM7L/9Qg5Y58BUzCMyECi8HqVmi/jTfK0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaWeqs6kDKtXoVVwTIC4tr7hzLe1xgeiAXHsDIsmYsv4jwegi6j1CX/5WtRVx1lKP+/EjY89ItDOsJ9F1zKfEdBJ1h92ghLHwJNe6MfVDmpuyVFDm1ZoVAgUPTq+HIYs6iP9UcN/CKbYEezKV3BO37fR/VeY2/fNvqR6jc4+1EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igzNy4bW; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso276388a12.0;
        Wed, 14 Feb 2024 15:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707952771; x=1708557571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfYCw4MdLIRHFv5AKbCeEG6HvalV9dnyMbsDHMZepoU=;
        b=igzNy4bW38ecSwELXehay2I2mO2Nyww2k+RkMVqqimnBiVGjV3SrQ9UF9CNp7qK/X9
         A297XD+fqmsy2+7kUhE9MsHWThD6mhc0pQmrZAqYxtOO45DL0tUdivZ8QeThGykSIgc+
         KNXinSXSNMnx80K/3DLLuhcLVwgv2q/7DGh6CvpHGPjtFTf5cFOpRSUg6hg/y+9/A4zK
         qPlXu7EU/BAhAKd8m7l5HDrqFLbgn+tt2/Q6sSzJ/7veshAgr2sFOHoIB8sG23yC/1Kw
         TF2kFv/d0zqwcxdKhocDEiDJEbGMh4tyHajt4R6sUljhaxVWHAGQP2jig25K7CBxhTXf
         jxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707952771; x=1708557571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfYCw4MdLIRHFv5AKbCeEG6HvalV9dnyMbsDHMZepoU=;
        b=SX1x96eEcJ7+beYrB+rMIhES9FO92jO1YMXSipWKdwcz72gTIqPYcDgPUnFa2lYwd2
         45k745o3GlJI36F8Yxss2EmvJkB2cTWvrZdEBexq2xkRAh/njvC8xZCtpuvw9hKEJr+c
         gduyYVn9tPew4biGWjUcdTevadkzS706n3u1zIwg4sS77QetZvuyAG5vFxM9MkI9AI6f
         gMunfXb1BdnwzT9uRJbtceNydXuyZi+fwRwh06/EfIhJyoL5o1qkFpjlRNQqvgimYOao
         sN5u7JHfTbayyWUo9BFOIRS0SKPRU2p+vsiHyHpHDfVq00XFMoVEkwaKcqUU09/I/oWL
         wlvw==
X-Forwarded-Encrypted: i=1; AJvYcCUD9NAPHdChLu8Q1D2nmrd8sHewPGhlBMjdqHBoMb+cuzmH2MelHQCs2lkKX780rfls1mlk7Huy7W2W3m7puDi07RI2tYr2fGUAqzRlWDNuQI+p45NTmGv7s2Z34OK6xosYE/oVrmm+KjeNVh5B3go9Dg==
X-Gm-Message-State: AOJu0YzUvo5DznJFLyZKIujNLd2465A3jP1BUF637YIU4MwXpR5rHxTj
	gw7OZZftO3Haq7B9/7R09xhoSzqvib6naDb+v8eBFWMU9o3/pN0yuj9pRthLMcznoIbxUUHGYfH
	rRir/vPraiMrsa7k6Dlu10KqOFOs=
X-Google-Smtp-Source: AGHT+IGZeRZTQGRLi2M8lGNB5Q3QpoJwDOPYrK78i8JUxy3FU8AlMDwDwhPrlt59R7whsFT3sKCKxpjmtbzdHEzuIwM=
X-Received: by 2002:a05:6a21:2d0c:b0:19e:aaba:a7cb with SMTP id
 tw12-20020a056a212d0c00b0019eaabaa7cbmr344220pzb.39.1707952771342; Wed, 14
 Feb 2024 15:19:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214052959.8550-1-vishnuocv@gmail.com> <c49e4415-7cd5-e1ba-e6c6-5086730b9866@linux.intel.com>
In-Reply-To: <c49e4415-7cd5-e1ba-e6c6-5086730b9866@linux.intel.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Thu, 15 Feb 2024 08:18:51 +0900
Message-ID: <CABxCQKvJScRKDJ+bStMF-jd6=iVnbCUPO3RFA8CFYMvXE+uE3g@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/x86: thinkpad_acpi: Simplify thermal mode checking
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	vsankar@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ilpo,
Thanks a lot for the review.

On Wed, Feb 14, 2024 at 7:14=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 14 Feb 2024, Vishnu Sankar wrote:
>
> Thanks for doing this, it's major improvement to readability already as
> is, and even more of after the second patch!!
>
> > Add a thermal_read_mode_check helper function to make the code
>
> thermal_read_mode_check()
>
> remove "function" as it's obvious.
Acked
>
> > simpler during init.
> > This helps particularly when the new TPEC_12 mode is added in
> > the next patch.
>
> Flow the paragraph normally without the premature line break.
Acked.
>
> > Suggested-by: Ilpo Jarvinen <ilpo.jarvinen@intel.com>
>
> This is not my email address, please use
>
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Sorry for this.
Will correct email address.
>
> > Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> > ---
> >  drivers/platform/x86/thinkpad_acpi.c | 136 +++++++++++++--------------
> >  1 file changed, 66 insertions(+), 70 deletions(-)
> >
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x8=
6/thinkpad_acpi.c
> > index c4895e9bc714..2428c8bd0fa2 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > @@ -6147,6 +6147,71 @@ struct ibm_thermal_sensors_struct {
> >  static enum thermal_access_mode thermal_read_mode;
> >  static bool thermal_use_labels;
> >
> > +/* Function to check thermal read mode */
> > +static enum thermal_access_mode thermal_read_mode_check(void)
> > +{
> > +     u8 t, ta1, ta2, ver =3D 0;
> > +     int i;
> > +
> > +     if (thinkpad_id.ec_model) {
> > +             /*
> > +              * Direct EC access mode: sensors at registers
> > +              * 0x78-0x7F, 0xC0-0xC7.  Registers return 0x00 for
>
> Remove the double space, one is enough in kernel comments.
Acked
>
> > +              * non-implemented, thermal sensors return 0x80 when
> > +              * not available
>
> Add the missing . please.
>
> Perhaps add a empty line here to make this two paragraphs.
Acked
>
> > +              * The above rule is unfortunately flawed. This has been =
seen with
> > +              * 0xC2 (power supply ID) causing thermal control problem=
s.
> > +              * The EC version can be determined by offset 0xEF and at=
 least for
> > +              * version 3 the Lenovo firmware team confirmed that regi=
sters 0xC0-0xC7
> > +              * are not thermal registers.
> > +              */
>
> While the patch touches this, this entire comment should be reflowed
> properly for 80 columns.
Will try re-writing the comments block for 80 columns.
>
> > +             if (!acpi_ec_read(TP_EC_FUNCREV, &ver))
> > +                     pr_warn("Thinkpad ACPI EC unable to access EC ver=
sion\n");
> > +
> > +             ta1 =3D ta2 =3D 0;
> > +             for (i =3D 0; i < 8; i++) {
> > +                     if (acpi_ec_read(TP_EC_THERMAL_TMP0 + i, &t)) {
> > +                             ta1 |=3D t;
> > +                     } else {
> > +                             ta1 =3D 0;
> > +                             break;
> > +                     }
> > +                     if (ver < 3) {
> > +                             if (acpi_ec_read(TP_EC_THERMAL_TMP8 + i, =
&t)) {
> > +                                     ta2 |=3D t;
> > +                             } else {
> > +                                     ta1 =3D 0;
> > +                                     break;
> > +                             }
> > +                     }
> > +             }
> > +
> > +             if (ta1 =3D=3D 0) {
> > +                     pr_err("ThinkPad ACPI EC access misbehaving, disa=
bling thermal sensors access\n");
> > +                     return TPACPI_THERMAL_NONE;
> > +             }
> > +
> > +             if (ver >=3D 3) {
> > +                     thermal_use_labels =3D true;
> > +                     return TPACPI_THERMAL_TPEC_8;
> > +             }
> > +
> > +             return (ta2 !=3D 0) ? TPACPI_THERMAL_TPEC_16 : TPACPI_THE=
RMAL_TPEC_8;
> > +     }
> > +
> > +     if (acpi_evalf(ec_handle, NULL, "TMP7", "qv")) {
> > +             if (tpacpi_is_ibm() &&
> > +                 acpi_evalf(ec_handle, NULL, "UPDT", "qv"))
>
> Single line and keep the braces please (I know it will go >80 chars but n=
o
> important info is lost).
Acked.
Will change this.
>
> > +                     /* 600e/x, 770e, 770x */
> > +                     return TPACPI_THERMAL_ACPI_UPDT;
> > +             /* IBM/LENOVO DSDT EC.TMPx access, max 8 sensors */
> > +             return TPACPI_THERMAL_ACPI_TMP07;
> > +     }
> > +
> > +     /* temperatures not supported on 570, G4x, R30, R31, R32 */
> > +     return TPACPI_THERMAL_NONE;
> > +}
> > +
> >  /* idx is zero-based */
> >  static int thermal_get_sensor(int idx, s32 *value)
> >  {
> > @@ -6375,78 +6440,9 @@ static const struct attribute_group temp_label_a=
ttr_group =3D {
> >
> >  static int __init thermal_init(struct ibm_init_struct *iibm)
> >  {
> > -     u8 t, ta1, ta2, ver =3D 0;
> > -     int i;
> > -     int acpi_tmp7;
> > -
> >       vdbg_printk(TPACPI_DBG_INIT, "initializing thermal subdriver\n");
> >
> > -     acpi_tmp7 =3D acpi_evalf(ec_handle, NULL, "TMP7", "qv");
> > -
> > -     if (thinkpad_id.ec_model) {
> > -             /*
> > -              * Direct EC access mode: sensors at registers
> > -              * 0x78-0x7F, 0xC0-0xC7.  Registers return 0x00 for
> > -              * non-implemented, thermal sensors return 0x80 when
> > -              * not available
> > -              * The above rule is unfortunately flawed. This has been =
seen with
> > -              * 0xC2 (power supply ID) causing thermal control problem=
s.
> > -              * The EC version can be determined by offset 0xEF and at=
 least for
> > -              * version 3 the Lenovo firmware team confirmed that regi=
sters 0xC0-0xC7
> > -              * are not thermal registers.
> > -              */
> > -             if (!acpi_ec_read(TP_EC_FUNCREV, &ver))
> > -                     pr_warn("Thinkpad ACPI EC unable to access EC ver=
sion\n");
> > -
> > -             ta1 =3D ta2 =3D 0;
> > -             for (i =3D 0; i < 8; i++) {
> > -                     if (acpi_ec_read(TP_EC_THERMAL_TMP0 + i, &t)) {
> > -                             ta1 |=3D t;
> > -                     } else {
> > -                             ta1 =3D 0;
> > -                             break;
> > -                     }
> > -                     if (ver < 3) {
> > -                             if (acpi_ec_read(TP_EC_THERMAL_TMP8 + i, =
&t)) {
> > -                                     ta2 |=3D t;
> > -                             } else {
> > -                                     ta1 =3D 0;
> > -                                     break;
> > -                             }
> > -                     }
> > -             }
> > -             if (ta1 =3D=3D 0) {
> > -                     /* This is sheer paranoia, but we handle it anywa=
y */
> > -                     if (acpi_tmp7) {
> > -                             pr_err("ThinkPad ACPI EC access misbehavi=
ng, falling back to ACPI TMPx access mode\n");
> > -                             thermal_read_mode =3D TPACPI_THERMAL_ACPI=
_TMP07;
>
> Eh, where did this go in the new helper?
Sorry.
This will be added in V2.
>
> --
>  i.
>
> > -                     } else {
> > -                             pr_err("ThinkPad ACPI EC access misbehavi=
ng, disabling thermal sensors access\n");
> > -                             thermal_read_mode =3D TPACPI_THERMAL_NONE=
;
> > -                     }
> > -             } else {
> > -                     if (ver >=3D 3) {
> > -                             thermal_read_mode =3D TPACPI_THERMAL_TPEC=
_8;
> > -                             thermal_use_labels =3D true;
> > -                     } else {
> > -                             thermal_read_mode =3D
> > -                                     (ta2 !=3D 0) ?
> > -                                     TPACPI_THERMAL_TPEC_16 : TPACPI_T=
HERMAL_TPEC_8;
> > -                     }
> > -             }
> > -     } else if (acpi_tmp7) {
> > -             if (tpacpi_is_ibm() &&
> > -                 acpi_evalf(ec_handle, NULL, "UPDT", "qv")) {
> > -                     /* 600e/x, 770e, 770x */
> > -                     thermal_read_mode =3D TPACPI_THERMAL_ACPI_UPDT;
> > -             } else {
> > -                     /* IBM/LENOVO DSDT EC.TMPx access, max 8 sensors =
*/
> > -                     thermal_read_mode =3D TPACPI_THERMAL_ACPI_TMP07;
> > -             }
> > -     } else {
> > -             /* temperatures not supported on 570, G4x, R30, R31, R32 =
*/
> > -             thermal_read_mode =3D TPACPI_THERMAL_NONE;
> > -     }
> > +     thermal_read_mode =3D thermal_read_mode_check();
> >
> >       vdbg_printk(TPACPI_DBG_INIT, "thermal is %s, mode %d\n",
> >               str_supported(thermal_read_mode !=3D TPACPI_THERMAL_NONE)=
,
> >



--=20

Regards,

      Vishnu Sankar
     +817015150407 (Japan)

