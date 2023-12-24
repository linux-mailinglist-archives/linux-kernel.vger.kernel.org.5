Return-Path: <linux-kernel+bounces-10705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B34281D902
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 12:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0374A28231C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 11:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA62E3C05;
	Sun, 24 Dec 2023 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZKwJL9/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A23220FA;
	Sun, 24 Dec 2023 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e7409797a1so27159877b3.0;
        Sun, 24 Dec 2023 03:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703418980; x=1704023780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vLI2Hst7POaVkLY3rGjxAdqgMVoR5qg64ubCPOHEMk=;
        b=kZKwJL9/KxgPAktiP1Fo2c02Jg/0MM5wLq+RiYVyL9dBREiW6yu22xI6cWW7S0xugk
         E0Ho/D31bSml9NOPEqS4IQuK3i+Kgzvz2BDcK0n9ekMJ+aVVd2SlNR/GVOg5zLK3Z1zk
         GYC/9b/t3JTwMcNMqMAV4Nwj7GRyWr37jm4HJ6FGILuC1Am/8pyJayirBz0nfUP+6h4E
         CdXI8AoWlyqDeaEt5eqAUHzGIcz9souTIr2eIC9l6Bb54P7Z1484cjoL+hTnhFl4WULu
         Es50lDPipRfu8S8ruYGok71BzpNhIv0vp8uDjv7sr61MOyDGFGKQYh3nk4RUwV+byba3
         cWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703418980; x=1704023780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vLI2Hst7POaVkLY3rGjxAdqgMVoR5qg64ubCPOHEMk=;
        b=BQNlF3mT/YTivAq0HBlpH5rwzOOsR+xGfpbyWchsFBNp9Ns4iReM0oWFXzqeJxwcV7
         mynCpofxBYsQVLda8rIGyluU01OUWrHs2cE9sNQCIu69F/f1rI+SI87oWYXDoPiypK+5
         DLg67MBlJ/+gtDyF4ZxpFvSL378w3ldT7BOTDPiHM480/myzob+UAJrFCFR8+F8LE1Kg
         rvmLW8lKDYNP6LavQfRtzb61zIJ35kGekckMv0uqI97wCVS5GC6BBFNc0Ak6LJYSTDdt
         trPAOIO5BcrTs5mLCqSzWd3ZwTtlwhKjVm74Ar+2vxrwHYUiM92Nql7MVcFrY09tYYX6
         aeYw==
X-Gm-Message-State: AOJu0YyegZi1ln3UWxPqg6kNY2EnLbDBHCksHhSfxqOcqpsNpnV8sUsE
	yK2C70UznnX4LHNcbu6ez7iIPIhg/Sy8E3hhmAA=
X-Google-Smtp-Source: AGHT+IGnwYlz7Jmg5JJnfhftJ/6FETXwr/Ehm2ELymqwJsRtTHKoapfVr6nSrYWLQ36z4cF3lvDoCDEzw6Zm9OPltbE=
X-Received: by 2002:a81:7254:0:b0:5e9:ed1:8791 with SMTP id
 n81-20020a817254000000b005e90ed18791mr2104560ywc.61.1703418980345; Sun, 24
 Dec 2023 03:56:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221153755.2690-1-maimon.sagi@gmail.com> <35550a06-c1fe-4e96-9705-ba0474cd94d1@linux.dev>
In-Reply-To: <35550a06-c1fe-4e96-9705-ba0474cd94d1@linux.dev>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Sun, 24 Dec 2023 13:56:09 +0200
Message-ID: <CAMuE1bE-RCLSWX-N5TmGPqXBEuHJAwLNJSOk=w-2XUDhrwYjAQ@mail.gmail.com>
Subject: Re: [PATCH v1] ptp: ocp: add Adva timecard support
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: richardcochran@gmail.com, jonathan.lemon@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 6:56=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
Vadim Thanks for your comments.

>
> On 21/12/2023 15:37, Sagi Maimon wrote:
> > Adding support for the Adva timecard.
> > The card uses different drivers to provide access to the
> > firmware SPI flash (Altera based).
> > Other parts of the code are the same and could be reused.
> >
> > Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> > ---
> >   drivers/ptp/ptp_ocp.c | 257 ++++++++++++++++++++++++++++++++++++++++-=
-
> >   1 file changed, 247 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> > index 4021d3d325f9..73e91b8a2887 100644
> > --- a/drivers/ptp/ptp_ocp.c
> > +++ b/drivers/ptp/ptp_ocp.c
> > @@ -34,6 +34,9 @@
> >   #define PCI_VENDOR_ID_OROLIA                        0x1ad7
> >   #define PCI_DEVICE_ID_OROLIA_ARTCARD                0xa000
> >
> > +#define PCI_VENDOR_ID_ADVA                   0xad5a
> > +#define PCI_DEVICE_ID_ADVA_TIMECARD          0x0400
> > +
> >   static struct class timecard_class =3D {
> >       .name           =3D "timecard",
> >   };
> > @@ -63,6 +66,13 @@ struct ocp_reg {
> >       u32     status_drift;
> >   };
> >
> > +struct servo_val {
> > +     u32     servo_offset_p_val;
> > +     u32     servo_offset_i_val;
> > +     u32     servo_drift_p_val;
> > +     u32     servo_drift_i_val;
> > +};
> > +
>
> I don't really like naming here. Let's go with ptp_ocp prefix first.
> Then it's more like configuration rather than actual values, so I would
> say ptp_ocp_servo_conf is better here. And let's remove "_val" - no real
> need for this suffix.
>
Will be fixed on patch V2
> >   #define OCP_CTRL_ENABLE             BIT(0)
> >   #define OCP_CTRL_ADJUST_TIME        BIT(1)
> >   #define OCP_CTRL_ADJUST_OFFSET      BIT(2)
> > @@ -401,6 +411,12 @@ static const struct ocp_attr_group fb_timecard_gro=
ups[];
> >
> >   static const struct ocp_attr_group art_timecard_groups[];
> >
> > +static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_reso=
urce *r);
> > +
> > +static const struct ocp_attr_group adva_timecard_groups[];
> > +
> > +static const struct ocp_sma_op ocp_adva_sma_op;
> > +
> >   struct ptp_ocp_eeprom_map {
> >       u16     off;
> >       u16     len;
> > @@ -835,10 +851,122 @@ static struct ocp_resource ocp_art_resource[] =
=3D {
> >       { }
> >   };
> >
> > +static struct ocp_resource ocp_adva_resource[] =3D {
> > +     {
> > +             OCP_MEM_RESOURCE(reg),
> > +             .offset =3D 0x01000000, .size =3D 0x10000,
> > +     },
> > +     {
> > +             OCP_EXT_RESOURCE(ts0),
> > +             .offset =3D 0x01010000, .size =3D 0x10000, .irq_vec =3D 1=
,
> > +             .extra =3D &(struct ptp_ocp_ext_info) {
> > +                     .index =3D 0,
> > +                     .irq_fcn =3D ptp_ocp_ts_irq,
> > +                     .enable =3D ptp_ocp_ts_enable,
> > +             },
> > +     },
> > +     {
> > +             OCP_EXT_RESOURCE(ts1),
> > +             .offset =3D 0x01020000, .size =3D 0x10000, .irq_vec =3D 2=
,
> > +             .extra =3D &(struct ptp_ocp_ext_info) {
> > +                     .index =3D 1,
> > +                     .irq_fcn =3D ptp_ocp_ts_irq,
> > +                     .enable =3D ptp_ocp_ts_enable,
> > +             },
> > +     },
> > +     {
> > +             OCP_EXT_RESOURCE(ts2),
> > +             .offset =3D 0x01060000, .size =3D 0x10000, .irq_vec =3D 6=
,
> > +             .extra =3D &(struct ptp_ocp_ext_info) {
> > +                     .index =3D 2,
> > +                     .irq_fcn =3D ptp_ocp_ts_irq,
> > +                     .enable =3D ptp_ocp_ts_enable,
> > +             },
> > +     },
> > +     /* Timestamp for PHC and/or PPS generator */
> > +     {
> > +             OCP_EXT_RESOURCE(pps),
> > +             .offset =3D 0x010C0000, .size =3D 0x10000, .irq_vec =3D 0=
,
> > +             .extra =3D &(struct ptp_ocp_ext_info) {
> > +                     .index =3D 5,
> > +                     .irq_fcn =3D ptp_ocp_ts_irq,
> > +                     .enable =3D ptp_ocp_ts_enable,
> > +             },
> > +     },
> > +     {
> > +             OCP_EXT_RESOURCE(signal_out[0]),
> > +             .offset =3D 0x010D0000, .size =3D 0x10000, .irq_vec =3D 1=
1,
> > +             .extra =3D &(struct ptp_ocp_ext_info) {
> > +                     .index =3D 1,
> > +                     .irq_fcn =3D ptp_ocp_signal_irq,
> > +                     .enable =3D ptp_ocp_signal_enable,
> > +             },
> > +     },
> > +     {
> > +             OCP_MEM_RESOURCE(pps_to_ext),
> > +             .offset =3D 0x01030000, .size =3D 0x10000,
> > +     },
> > +     {
> > +             OCP_MEM_RESOURCE(pps_to_clk),
> > +             .offset =3D 0x01040000, .size =3D 0x10000,
> > +     },
> > +     {
> > +             OCP_MEM_RESOURCE(tod),
> > +             .offset =3D 0x01050000, .size =3D 0x10000,
> > +     },
> > +     {
> > +             OCP_MEM_RESOURCE(image),
> > +             .offset =3D 0x00020000, .size =3D 0x1000,
> > +     },
> > +     {
> > +             OCP_MEM_RESOURCE(pps_select),
> > +             .offset =3D 0x00130000, .size =3D 0x1000,
> > +     },
> > +     {
> > +             OCP_MEM_RESOURCE(sma_map1),
> > +             .offset =3D 0x00140000, .size =3D 0x1000,
> > +     },
> > +     {
> > +             OCP_MEM_RESOURCE(sma_map2),
> > +             .offset =3D 0x00220000, .size =3D 0x1000,
> > +     },
> > +     {
> > +             OCP_SERIAL_RESOURCE(gnss_port),
> > +             .offset =3D 0x00160000 + 0x1000, .irq_vec =3D 3,
> > +             .extra =3D &(struct ptp_ocp_serial_port) {
> > +                     .baud =3D 9600,
> > +             },
> > +     },
> > +     {
> > +                     OCP_MEM_RESOURCE(freq_in[0]),
> > +                     .offset =3D 0x01200000, .size =3D 0x10000,
> > +     },
> > +     {
> > +                     OCP_SPI_RESOURCE(spi_flash),
> > +                     .offset =3D 0x00310400, .size =3D 0x10000, .irq_v=
ec =3D 9,
> > +                     .extra =3D &(struct ptp_ocp_flash_info) {
> > +                             .name =3D "spi_altera", .pci_offset =3D 0=
,
> > +                             .data_size =3D sizeof(struct altera_spi_p=
latform_data),
> > +                             .data =3D &(struct altera_spi_platform_da=
ta) {
> > +                                     .num_chipselect =3D 1,
> > +                                     .num_devices =3D 1,
> > +                                     .devices =3D &(struct spi_board_i=
nfo) {
> > +                                             .modalias =3D "spi-nor",
> > +                                     },
> > +                             },
> > +                     },
> > +     },
> > +     {
> > +             .setup =3D ptp_ocp_adva_board_init,
> > +     },
> > +     { }
> > +};
> > +
> >   static const struct pci_device_id ptp_ocp_pcidev_id[] =3D {
> >       { PCI_DEVICE_DATA(FACEBOOK, TIMECARD, &ocp_fb_resource) },
> >       { PCI_DEVICE_DATA(CELESTICA, TIMECARD, &ocp_fb_resource) },
> >       { PCI_DEVICE_DATA(OROLIA, ARTCARD, &ocp_art_resource) },
> > +     { PCI_DEVICE_DATA(ADVA, TIMECARD, &ocp_adva_resource) },
> >       { }
> >   };
> >   MODULE_DEVICE_TABLE(pci, ptp_ocp_pcidev_id);
> > @@ -917,6 +1045,27 @@ static const struct ocp_selector ptp_ocp_art_sma_=
out[] =3D {
> >       { }
> >   };
> >
> > +static const struct ocp_selector ptp_ocp_adva_sma_in[] =3D {
> > +     { .name =3D "10Mhz",      .value =3D 0x0000,      .frequency =3D =
10000000},
> > +     { .name =3D "PPS1",       .value =3D 0x0001,      .frequency =3D =
1 },
> > +     { .name =3D "PPS2",       .value =3D 0x0002,      .frequency =3D =
1 },
> > +     { .name =3D "TS1",        .value =3D 0x0004,      .frequency =3D =
0 },
> > +     { .name =3D "TS2",        .value =3D 0x0008,      .frequency =3D =
0 },
> > +     { .name =3D "FREQ1",      .value =3D 0x0100,      .frequency =3D =
0 },
> > +     { .name =3D "None",       .value =3D SMA_DISABLE, .frequency =3D =
0 },
> > +     { }
> > +};
> > +
> > +static const struct ocp_selector ptp_ocp_adva_sma_out[] =3D {
> > +     { .name =3D "10Mhz",      .value =3D 0x0000,  .frequency =3D 1000=
0000},
> > +     { .name =3D "PHC",        .value =3D 0x0001,  .frequency =3D 1 },
> > +     { .name =3D "GNSS1",      .value =3D 0x0004,  .frequency =3D 1 },
> > +     { .name =3D "GEN1",       .value =3D 0x0040 },
> > +     { .name =3D "GND",        .value =3D 0x2000 },
> > +     { .name =3D "VCC",        .value =3D 0x4000 },
> > +     { }
> > +};
> > +
> >   struct ocp_sma_op {
> >       const struct ocp_selector *tbl[2];
> >       void (*init)(struct ptp_ocp *bp);
> > @@ -1363,20 +1512,20 @@ ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
> >   }
> >
> >   static int
> > -ptp_ocp_init_clock(struct ptp_ocp *bp)
> > +ptp_ocp_init_clock(struct ptp_ocp *bp, struct servo_val *servo_vals)
> >   {
> >       struct timespec64 ts;
> >       u32 ctrl;
> >
> > +
>
> no need for the second empty line
>
Will be fixed on patch V2

> >       ctrl =3D OCP_CTRL_ENABLE;
> >       iowrite32(ctrl, &bp->reg->ctrl);
> >
> > -     /* NO DRIFT Correction */
> > -     /* offset_p:i 1/8, offset_i: 1/16, drift_p: 0, drift_i: 0 */
> > -     iowrite32(0x2000, &bp->reg->servo_offset_p);
> > -     iowrite32(0x1000, &bp->reg->servo_offset_i);
> > -     iowrite32(0,      &bp->reg->servo_drift_p);
> > -     iowrite32(0,      &bp->reg->servo_drift_i);
> > +     /* servo configuration */
> > +     iowrite32(servo_vals->servo_offset_p_val, &bp->reg->servo_offset_=
p);
> > +     iowrite32(servo_vals->servo_offset_i_val, &bp->reg->servo_offset_=
i);
> > +     iowrite32(servo_vals->servo_drift_p_val, &bp->reg->servo_drift_p)=
;
> > +     iowrite32(servo_vals->servo_drift_p_val, &bp->reg->servo_drift_i)=
;
> >
> >       /* latch servo values */
> >       ctrl |=3D OCP_CTRL_ADJUST_SERVO;
> > @@ -2362,6 +2511,14 @@ static const struct ocp_sma_op ocp_fb_sma_op =3D=
 {
> >       .set_output     =3D ptp_ocp_sma_fb_set_output,
> >   };
> >
> > +static const struct ocp_sma_op ocp_adva_sma_op =3D {
> > +     .tbl            =3D { ptp_ocp_adva_sma_in, ptp_ocp_adva_sma_out }=
,
> > +     .init           =3D ptp_ocp_sma_fb_init,
> > +     .get            =3D ptp_ocp_sma_fb_get,
> > +     .set_inputs     =3D ptp_ocp_sma_fb_set_inputs,
> > +     .set_output     =3D ptp_ocp_sma_fb_set_output,
> > +};
> > +
> >   static int
> >   ptp_ocp_set_pins(struct ptp_ocp *bp)
> >   {
> > @@ -2420,6 +2577,7 @@ static int
> >   ptp_ocp_fb_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
> >   {
> >       int err;
> > +     struct servo_val servo_vals;
> >
> >       bp->flash_start =3D 1024 * 4096;
> >       bp->eeprom_map =3D fb_eeprom_map;
> > @@ -2441,7 +2599,14 @@ ptp_ocp_fb_board_init(struct ptp_ocp *bp, struct=
 ocp_resource *r)
> >               return err;
> >       ptp_ocp_sma_init(bp);
> >
> > -     return ptp_ocp_init_clock(bp);
> > +     /* NO DRIFT Correction */
> > +     /* offset_p:i 1/8, offset_i: 1/16, drift_p: 0, drift_i: 0 */
> > +     servo_vals.servo_offset_p_val =3D 0x2000;
> > +     servo_vals.servo_offset_i_val =3D 0x1000;
> > +     servo_vals.servo_drift_p_val =3D 0;
> > +     servo_vals.servo_drift_p_val =3D 0;
>
> instead of adding this to every particular initialization function,
> struct ptp_ocp_servo_conf can be put to .extra field of the resource
> holding init function. This will move all configuration points to the
> list of card-specific resources, the place to have differences of cards
> and will make the code cleaner and eliminate all these local structs.
> We can potentially create another static function to configure servo
> part, but it's up to you.
>
Will be done on patch V2
> > +
> > +     return ptp_ocp_init_clock(bp, &servo_vals);
> >   }
> >
> >   static bool
> > @@ -2583,6 +2748,7 @@ static int
> >   ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
> >   {
> >       int err;
> > +     struct servo_val servo_vals;
> >
> >       bp->flash_start =3D 0x1000000;
> >       bp->eeprom_map =3D art_eeprom_map;
> > @@ -2603,7 +2769,49 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, struc=
t ocp_resource *r)
> >       if (err)
> >               return err;
> >
> > -     return ptp_ocp_init_clock(bp);
> > +     /* NO DRIFT Correction */
> > +     /* offset_p:i 1/8, offset_i: 1/16, drift_p: 0, drift_i: 0 */
> > +     servo_vals.servo_offset_p_val =3D 0x2000;
> > +     servo_vals.servo_offset_i_val =3D 0x1000;
> > +     servo_vals.servo_drift_p_val =3D 0;
> > +     servo_vals.servo_drift_p_val =3D 0;
> > +
> > +     return ptp_ocp_init_clock(bp, &servo_vals);
> > +}
> > +
> > +/* ADVA specific board initializers; last "resource" registered. */
> > +static int
> > +ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
> > +{
> > +     int err;
> > +     struct servo_val servo_vals;
> > +
> > +     bp->flash_start =3D 0xA00000;
> > +     bp->fw_version =3D ioread32(&bp->image->version);
> > +     bp->sma_op =3D &ocp_adva_sma_op;
> > +
> > +     ptp_ocp_fb_set_version(bp);
> > +
> > +     ptp_ocp_tod_init(bp);
> > +     ptp_ocp_nmea_out_init(bp);
> > +     ptp_ocp_signal_init(bp);
> > +
> > +     err =3D ptp_ocp_attr_group_add(bp, adva_timecard_groups);
> > +     if (err)
> > +             return err;
> > +
> > +     err =3D ptp_ocp_set_pins(bp);
> > +     if (err)
> > +             return err;
> > +     ptp_ocp_sma_init(bp);
> > +
> > +     /* offset_p:i 3/4, offset_i: 1/16, drift_p: 0, drift_i: 0 */
> > +     servo_vals.servo_offset_p_val =3D 0xc000;
> > +     servo_vals.servo_offset_i_val =3D 0x1000;
> > +     servo_vals.servo_drift_p_val =3D 0;
> > +     servo_vals.servo_drift_p_val =3D 0;
> > +
> > +     return ptp_ocp_init_clock(bp, &servo_vals);
> >   }
> >
> >   static ssize_t
> > @@ -3578,6 +3786,35 @@ static const struct ocp_attr_group art_timecard_=
groups[] =3D {
> >       { },
> >   };
> >
> > +static struct attribute *adva_timecard_attrs[] =3D {
> > +     &dev_attr_serialnum.attr,
> > +     &dev_attr_gnss_sync.attr,
> > +     &dev_attr_clock_source.attr,
> > +     &dev_attr_available_clock_sources.attr,
> > +     &dev_attr_sma1.attr,
> > +     &dev_attr_sma2.attr,
> > +     &dev_attr_sma3.attr,
> > +     &dev_attr_sma4.attr,
> > +     &dev_attr_available_sma_inputs.attr,
> > +     &dev_attr_available_sma_outputs.attr,
> > +     &dev_attr_clock_status_drift.attr,
> > +     &dev_attr_clock_status_offset.attr,
> > +     &dev_attr_ts_window_adjust.attr,
> > +     &dev_attr_tod_correction.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group adva_timecard_group =3D {
> > +     .attrs =3D adva_timecard_attrs,
> > +};
> > +
> > +static const struct ocp_attr_group adva_timecard_groups[] =3D {
> > +     { .cap =3D OCP_CAP_BASIC,     .group =3D &adva_timecard_group },
> > +     { .cap =3D OCP_CAP_SIGNAL,    .group =3D &fb_timecard_signal0_gro=
up },
> > +     { .cap =3D OCP_CAP_FREQ,      .group =3D &fb_timecard_freq0_group=
 },
> > +     { },
> > +};
> > +
> >   static void
> >   gpio_input_map(char *buf, struct ptp_ocp *bp, u16 map[][2], u16 bit,
> >              const char *def)
>
> starting from here ...
>
> > @@ -4492,7 +4729,7 @@ ptp_ocp_remove(struct pci_dev *pdev)
> >       cancel_delayed_work_sync(&bp->sync_work);
> >       for (i =3D 0; i < OCP_SMA_NUM; i++) {
> >               if (bp->sma[i].dpll_pin) {
> > -                     dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin=
, &dpll_pins_ops, bp);
> > +                     dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin=
, &dpll_pins_ops, &bp->sma[i]);
> >                       dpll_pin_put(bp->sma[i].dpll_pin);
> >               }
> >       }
>
> the chuck is already in a different patch and is reviewed actually, no
> need to post it again.

Will be fixed on patch V2

