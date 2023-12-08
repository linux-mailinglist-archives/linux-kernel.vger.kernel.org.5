Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F9C80A726
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574282AbjLHPRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574257AbjLHPRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:17:04 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C97198D;
        Fri,  8 Dec 2023 07:17:09 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ce939ecfc2so1654037b3a.2;
        Fri, 08 Dec 2023 07:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702048628; x=1702653428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=li2KL7zM1Esoqlny5utwNXNaFWmHhkUuIGKdA34eRTA=;
        b=bzydPdUsBHCcfMm2QJmhCcRPdFdmKDB9ZbSukPBu1oAkQpAkJlJOcW4rJzJWOQXGPo
         fUPpFFrvBjNb+zeRzZgdofjMEeAAcfWvntTl7K9prfs74w1uciNuFxqcFk4aXLLb7en2
         +fOFzmGIG7MCaaLuVamgCJuY5KeCv7Xlz/syKwZcP/9+iz58srOlZJBzmqrJESzpQVji
         iTwPPlr19ii6l2/Ucp8gxw70cw5pznLPR8qJ0RPmAEYRwk24Ub37yrLWPXCpqE6oO5uL
         W8IpS8lK7WrQMQq0TMR7WDR5UnVCx+ChtlgFe+d5nWxb9hVlFfPwTtyw9x5emc09l8lP
         Uv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048628; x=1702653428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=li2KL7zM1Esoqlny5utwNXNaFWmHhkUuIGKdA34eRTA=;
        b=E1sSNUEq6xSwc76uCXH8rbpeGV3jQitKipX+3pxfOGLWXl4iL4diVU6gs4k/QYXlv8
         yWsy6QQG8vUTyN3KWn/iSdVhCUpdubJ9WV7qTq7d1h3q918jF73sRuUCCK2dsgcia1VH
         TBsjgG1QrPcNYRdJk121MHN6LtWXOWFX0WxI3vJGR9E5xY0PirCNk6lF7sIImbfzudhY
         DvwH1UdSh+5/kPraAdPo5ESHBevD/Lf+r+1RwwPuu3ICtK0H6FSX0GRCa9F94vLO9fdb
         myvu5TGZR+8UQupZX4yF8jxWqit5hYU01UjHyZydk5VRdhQInUyQ0IJ+y+zOFjFxksZN
         IcsQ==
X-Gm-Message-State: AOJu0Yw42JTO4ghmFJw9gcYattDbro2XlXtggE9cNfwAhOovSsaqLHrn
        i9f3IjTopR1XPTXgyycSvQdS8P6Eg/Cv3efKAvE=
X-Google-Smtp-Source: AGHT+IF9mEwqyGWguiz1ByXrCL5Wq5zoOQs5vxn7xsxXoqJKnxzQPmUlyuH3gpGKE+5i4W9r2z4/oCQwlYj7tUxRePE=
X-Received: by 2002:a05:6a20:748b:b0:18f:97c:615d with SMTP id
 p11-20020a056a20748b00b0018f097c615dmr186836pzd.90.1702048628344; Fri, 08 Dec
 2023 07:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20231206162003.92010-1-vishnuocv@gmail.com> <2ae27a1b-a472-8a57-994e-f016cc25dafc@linux.intel.com>
In-Reply-To: <2ae27a1b-a472-8a57-994e-f016cc25dafc@linux.intel.com>
From:   Vishnu Sankar <vishnuocv@gmail.com>
Date:   Sat, 9 Dec 2023 00:16:28 +0900
Message-ID: <CABxCQKvMj8DkmYpPvNeGtdHRNWe7fqENyfTSGomr2hs1dojwQA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: fix for incorrect fan
 reporting on some ThinkPad systems
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     hdegoede@redhat.com, mpearson-lenovo@squebb.ca,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        markgross@kernel.org
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

Hi Ilpo,

Thank you for the review

On Fri, Dec 8, 2023 at 7:53=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 7 Dec 2023, Vishnu Sankar wrote:
>
> Hi Vishnu,
>
> Thanks for the patch.
>
> > Some ThinkPad systems ECFW use non-standard addresses for fan control
> > and reporting. This patch adds support for such ECFW so that it can rep=
ort
> > the correct fan values.
> > Tested on Thinkpads L13 Yoga Gen 2 and X13 Yoga Gen 2.
> >
> > Co-developed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
>
> If Mark wrote any lines, his Signed-off-by is also required before yours,
> as per Documentation/process/5.Posting.rst, this is a hard requirement.
>
> If he only helped towards the right direction/solution but provided no
> code, I recommend using Suggested-by tag instead.
>

Ack.
Will change to Suggested-by.

> > ---
> >  drivers/platform/x86/thinkpad_acpi.c | 88 ++++++++++++++++++++++++----
> >  1 file changed, 76 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x8=
6/thinkpad_acpi.c
> > index d0b5fd4137bc..51ec20e07b23 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > @@ -7950,6 +7950,11 @@ static struct ibm_struct volume_driver_data =3D =
{
> >   *   but the ACPI tables just mention level 7.
> >   */
> >
> > +#define FAN_RPM_CAL_CONST 491520     /* FAN RPM calculation offset for=
 some non-standard ECFW */
> > +
> > +#define FAN_NS_CTRL_STATUS   BIT(2)          /* Bit which determines c=
ontrol is enabled or not */
> > +#define FAN_NS_CTRL          BIT(4)          /* Bit which determines c=
ontrol is by host or EC */
> > +
> >  enum {                                       /* Fan control constants =
*/
> >       fan_status_offset =3D 0x2f,       /* EC register 0x2f */
> >       fan_rpm_offset =3D 0x84,          /* EC register 0x84: LSB, 0x85 =
MSB (RPM)
> > @@ -7957,6 +7962,11 @@ enum {                                 /* Fan co=
ntrol constants */
> >       fan_select_offset =3D 0x31,       /* EC register 0x31 (Firmware 7=
M)
> >                                          bit 0 selects which fan is act=
ive */
> >
> > +     fan_status_offset_ns =3D 0x93,    /* Special status/control offse=
t for non-standard EC Fan1 */
> > +     fan2_status_offset_ns =3D 0x96,   /* Special status/control offse=
t for non-standard EC Fan2 */
> > +     fan_rpm_status_ns =3D 0x95,       /* Special offset for Fan1 RPM =
status for non-standard EC */
> > +     fan2_rpm_status_ns =3D 0x98,      /* Special offset for Fan2 RPM =
status for non-standard EC */
> > +
> >       TP_EC_FAN_FULLSPEED =3D 0x40,     /* EC fan mode: full speed */
> >       TP_EC_FAN_AUTO      =3D 0x80,     /* EC fan mode: auto fan contro=
l */
> >
> > @@ -7967,6 +7977,7 @@ enum fan_status_access_mode {
> >       TPACPI_FAN_NONE =3D 0,            /* No fan status or control */
> >       TPACPI_FAN_RD_ACPI_GFAN,        /* Use ACPI GFAN */
> >       TPACPI_FAN_RD_TPEC,             /* Use ACPI EC regs 0x2f, 0x84-0x=
85 */
> > +     TPACPI_FAN_RD_TPEC_NS,          /* Use non-standard ACPI EC regs =
(eg: L13 Yoga gen2 etc.) */
> >  };
> >
> >  enum fan_control_access_mode {
> > @@ -7994,6 +8005,8 @@ static u8 fan_control_desired_level;
> >  static u8 fan_control_resume_level;
> >  static int fan_watchdog_maxinterval;
> >
> > +static bool fan_with_ns_addr;
> > +
> >  static struct mutex fan_mutex;
> >
> >  static void fan_watchdog_fire(struct work_struct *ignored);
> > @@ -8123,6 +8136,15 @@ static int fan_get_status(u8 *status)
> >               }
> >
> >               break;
> > +     case TPACPI_FAN_RD_TPEC_NS:
>
> There's a big comment about FAN ACCESS MODES and now you seem to be addin=
g
> another one. Can you please check if there would be something useful to
> add/edit in that big comment because of the addition of
> TPACPI_FAN_RD_TPEC_NS.

I will look into adding this.

>
> > +             /* Default mode is AUTO which means controlled by EC */
> > +             if (unlikely(!acpi_ec_read(fan_status_offset_ns, &s)))
>
> I'm skeptical that all these unlikely/likely() are useful. Some might eve=
n
> be harmful if e.g. is some error condition keeps repeating itself and
> the particular if handling that is marked with unlikely().
>
> I know the code in that file is littered with them already but it would
> be better to add into that, IMO.

I will look into this as well (removing likely/unlikely).
>
> > +                     return -EIO;
> > +
> > +             if (likely(status))
> > +                     *status =3D s;
> > +
> > +             break;
> >
> >       default:
> >               return -ENXIO;
> > @@ -8139,7 +8161,8 @@ static int fan_get_status_safe(u8 *status)
> >       if (mutex_lock_killable(&fan_mutex))
> >               return -ERESTARTSYS;
> >       rc =3D fan_get_status(&s);
> > -     if (!rc)
> > +     /* NS EC doesn't have register with level settings */
> > +     if (!rc && !fan_with_ns_addr)
> >               fan_update_desired_level(s);
> >       mutex_unlock(&fan_mutex);
> >
> > @@ -8166,7 +8189,13 @@ static int fan_get_speed(unsigned int *speed)
> >
> >               if (likely(speed))
> >                       *speed =3D (hi << 8) | lo;
> > +             break;
> > +     case TPACPI_FAN_RD_TPEC_NS:
> > +             if (unlikely(!acpi_ec_read(fan_rpm_status_ns, &lo)))
> > +                     return -EIO;
> >
> > +             if (likely(speed))
> > +                     *speed =3D lo ? FAN_RPM_CAL_CONST / lo : 0;
> >               break;
> >
> >       default:
> > @@ -8178,7 +8207,7 @@ static int fan_get_speed(unsigned int *speed)
> >
> >  static int fan2_get_speed(unsigned int *speed)
> >  {
> > -     u8 hi, lo;
> > +     u8 hi, lo, status;
> >       bool rc;
> >
> >       switch (fan_status_access_mode) {
> > @@ -8194,7 +8223,21 @@ static int fan2_get_speed(unsigned int *speed)
> >
> >               if (likely(speed))
> >                       *speed =3D (hi << 8) | lo;
> > +             break;
> >
> > +     case TPACPI_FAN_RD_TPEC_NS:
> > +             rc =3D !acpi_ec_read(fan2_status_offset_ns, &status);
> > +             if (rc)
> > +                     return -EIO;
> > +             if (!(status & FAN_NS_CTRL_STATUS)) {
> > +                     pr_info("fan fan2 control not supported\n");
>
> Perhaps "fan2 control ..." would be enough or perhaps "secondary fan
> control ..." (the latter matching fan_init() printouts) ?

Acked

>
> > +                     return -EIO;
> > +             }
> > +             rc =3D !acpi_ec_read(fan2_rpm_status_ns, &lo);
> > +             if (rc)
> > +                     return -EIO;
> > +             if (likely(speed))
> > +                     *speed =3D lo ? FAN_RPM_CAL_CONST / lo : 0;
> >               break;
> >
> >       default:
> > @@ -8697,6 +8740,7 @@ static const struct attribute_group fan_driver_at=
tr_group =3D {
> >  #define TPACPI_FAN_2FAN              0x0002          /* EC 0x31 bit 0 =
selects fan2 */
> >  #define TPACPI_FAN_2CTL              0x0004          /* selects fan2 c=
ontrol */
> >  #define TPACPI_FAN_NOFAN     0x0008          /* no fan available */
> > +#define TPACPI_FAN_NS                0x0010          /* For EC with no=
n-Standard register addresses */
> >
> >  static const struct tpacpi_quirk fan_quirk_table[] __initconst =3D {
> >       TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
> > @@ -8715,6 +8759,8 @@ static const struct tpacpi_quirk fan_quirk_table[=
] __initconst =3D {
> >       TPACPI_Q_LNV3('N', '2', 'O', TPACPI_FAN_2CTL),  /* P1 / X1 Extrem=
e (2nd gen) */
> >       TPACPI_Q_LNV3('N', '3', '0', TPACPI_FAN_2CTL),  /* P15 (1st gen) =
/ P15v (1st gen) */
> >       TPACPI_Q_LNV3('N', '3', '7', TPACPI_FAN_2CTL),  /* T15g (2nd gen)=
 */
> > +     TPACPI_Q_LNV3('R', '1', 'F', TPACPI_FAN_NS),    /* L13 Yoga Gen 2=
 */
> > +     TPACPI_Q_LNV3('N', '2', 'U', TPACPI_FAN_NS),    /* X13 Yoga Gen 2=
*/
> >       TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN), /* X1 Tablet (2nd=
 gen) */
> >  };
> >
> > @@ -8749,6 +8795,13 @@ static int __init fan_init(struct ibm_init_struc=
t *iibm)
> >               return -ENODEV;
> >       }
> >
> > +     if (quirks & TPACPI_FAN_NS) {
> > +             pr_info("ECFW with non-standard fan reg control found\n")=
;
> > +             fan_with_ns_addr =3D 1;
> > +             /* Fan ctrl support from host is undefined for now */
> > +             tp_features.fan_ctrl_status_undef =3D 1;
> > +     }
> > +
> >       if (gfan_handle) {
> >               /* 570, 600e/x, 770e, 770x */
> >               fan_status_access_mode =3D TPACPI_FAN_RD_ACPI_GFAN;
> > @@ -8756,11 +8809,13 @@ static int __init fan_init(struct ibm_init_stru=
ct *iibm)
> >               /* all other ThinkPads: note that even old-style
> >                * ThinkPad ECs supports the fan control register */
> >               if (likely(acpi_ec_read(fan_status_offset,
> > -                                     &fan_control_initial_status))) {
> > +                                     &fan_control_initial_status)) || =
fan_with_ns_addr) {
>
> So if we know the addresses are non-standard, why is the acpi_ec_read
> performed at all? That is, why isn't the || logic in reverse order?
>
Agreed.
I will change the logic to reverse order.

> I also wonder what will fan_control_initial_status be set to in this case=
,
> is it garbage?

0x84 is still a valid register (but not related to Fan)

>
> >                       int res;
> >                       unsigned int speed;
> >
> > -                     fan_status_access_mode =3D TPACPI_FAN_RD_TPEC;
> > +                     fan_status_access_mode =3D fan_with_ns_addr ?
> > +                             TPACPI_FAN_RD_TPEC_NS : TPACPI_FAN_RD_TPE=
C;
> > +
> >                       if (quirks & TPACPI_FAN_Q1)
> >                               fan_quirk1_setup();
> >                       /* Try and probe the 2nd fan */
> > @@ -8769,7 +8824,8 @@ static int __init fan_init(struct ibm_init_struct=
 *iibm)
> >                       if (res >=3D 0 && speed !=3D FAN_NOT_PRESENT) {
> >                               /* It responded - so let's assume it's th=
ere */
> >                               tp_features.second_fan =3D 1;
> > -                             tp_features.second_fan_ctl =3D 1;
> > +                             /* fan control not currently available fo=
r ns ECFW */
> > +                             tp_features.second_fan_ctl =3D fan_with_n=
s_addr ? 0 : 1;
>
> =3D !fan_with_ns_addr;

Agreed.

>
> >                               pr_info("secondary fan control detected &=
 enabled\n");
> >                       } else {
> >                               /* Fan not auto-detected */
> > @@ -8944,6 +9000,7 @@ static int fan_read(struct seq_file *m)
> >                              str_enabled_disabled(status), status);
> >               break;
> >
> > +     case TPACPI_FAN_RD_TPEC_NS:
> >       case TPACPI_FAN_RD_TPEC:
> >               /* all except 570, 600e/x, 770e, 770x */
> >               rc =3D fan_get_status_safe(&status);
> > @@ -8958,13 +9015,20 @@ static int fan_read(struct seq_file *m)
> >
> >               seq_printf(m, "speed:\t\t%d\n", speed);
> >
> > -             if (status & TP_EC_FAN_FULLSPEED)
> > -                     /* Disengaged mode takes precedence */
> > -                     seq_printf(m, "level:\t\tdisengaged\n");
> > -             else if (status & TP_EC_FAN_AUTO)
> > -                     seq_printf(m, "level:\t\tauto\n");
> > -             else
> > -                     seq_printf(m, "level:\t\t%d\n", status);
> > +             if (fan_status_access_mode =3D=3D TPACPI_FAN_RD_TPEC_NS) =
{
> > +                     /* No full speed bit in NS EC*/
>
> Missing space. But I'd convert these two comments into a multiline one
> anyway.
>
Acked

> > +                     /* EC Auto mode is set by default. No other level=
s settings available*/
> > +                     (status & FAN_NS_CTRL) ? seq_puts(m, "level:\t\tu=
nknown\n")
> > +                                     : seq_puts(m, "level:\t\tauto\n")=
;
>
> seq_printf(m, "level:\t\t%s\n", status & FAN_NS_CTRL ? "unknown" : "auto"=
);
>

Acked.

> > +             } else {
> > +                     if (status & TP_EC_FAN_FULLSPEED)
> > +                             /* Disengaged mode takes precedence */
> > +                             seq_puts(m, "level:\t\tdisengaged\n");
> > +                     else if (status & TP_EC_FAN_AUTO)
> > +                             seq_puts(m, "level:\t\tauto\n");
>
> Please don't make an unrelated seq_printf() -> seq_puts() change in this
> patch.

Ack.
(The checkpatch.pl threw a warning regarding seq_printf() for these
lines after the changes I made.)

>
> > +                     else
> > +                             seq_printf(m, "level:\t\t%d\n", status);
> > +             }
> >               break;
> >
> >       case TPACPI_FAN_NONE:
> >
>
> --
>  i.
>

Thank you for correcting these and Apologize for any inconvenience caused.
I have noted the comments. Will share the updated patch soon.

--=20

Regards,

      Vishnu Sankar
     +817015150407 (Japan)
