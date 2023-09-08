Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A112E798001
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 03:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbjIHBLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 21:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjIHBLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 21:11:12 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838CD1BCB;
        Thu,  7 Sep 2023 18:11:08 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so25578721fa.3;
        Thu, 07 Sep 2023 18:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694135467; x=1694740267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bx8foFNhrfnEFqYrw1yPcsgvr+XmSSnNMk5PfQGbNnk=;
        b=adbHhY+KegOybp7wX3TehTmh5Yk9G4AS/ShNvFIpWsJOi17bmLw5yp3b7oko9JXMEx
         43EUYFeTcgFfbUXbe+hkLYUsC2+2M6KL+gf3YtLFmR5K52IusLhwMOLTgVl2Vpy9sqF9
         vAOxWzsy6x/vSD+u3Xfn4CdepO5a4lmmM4cvoiHgB1uiul/Xj0Y/GEpzS2gjTyPKEsn0
         xr5mIKWszI5bW5s9wiJcMq1o0Wf8YF3sbBnvEU+6KVEVqvMHw9hTidtpIgG5MUzMBq5+
         BBynBNmDw2sFEnpUbhwmH1qzzP/ikAMlN7EvJvI1cXN2P2LRm2LaIaB/RDQKf9YS6Qxs
         5rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694135467; x=1694740267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bx8foFNhrfnEFqYrw1yPcsgvr+XmSSnNMk5PfQGbNnk=;
        b=Uh9/S4hFpe9nBKttaFhqDBnSgM87Jdoen7GK30bSMuwlyX260dTMVqHSY2SokPnulT
         CDJOLou3FkKQtEoTbKMpshJKBsJehJkJnBRMDW+CGbOW5sJz1CL6fht0BV2G7qPNxA/H
         w4KME7H+gmgtHcjwOfZpSqJ6y2wPtQYOHcm4ZgFZ2UHocaf4VQ2lQ0ue5sgvFYmbRypb
         t/J7XkUTd0cJvG80kIaRBngnsLZqiC2bwhdscwY73PJWRU29IX+PeVpKINQdnVD6Ur/y
         ZoYKcwBmGyA/X7iFVVq0FQn6Y48Sbugre7K89CnPRjiLm/Uax+GU+enimRx7TpTA29U1
         PdOQ==
X-Gm-Message-State: AOJu0YzVhxI3PGqSFsMCnMkyKgNxHeZR3ucPpU2cYgqAL1NEGqS/klP5
        kd8qKRe78l8Q7glDkdPCqegYVvHH/zHIkPtdoPlRZFSa
X-Google-Smtp-Source: AGHT+IGLkUNfUAVoPPl1Fw4C2EH7VcKQadbwCD1PYm5yL5A8RL4nKzxjF47HJgIEga7SpQX1409vG6/bnEsD6Xaq9HI=
X-Received: by 2002:a2e:3517:0:b0:2b6:e2aa:8fbc with SMTP id
 z23-20020a2e3517000000b002b6e2aa8fbcmr562178ljz.8.1694135466348; Thu, 07 Sep
 2023 18:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230906102507.15504-2-tinozzo123@gmail.com>
In-Reply-To: <20230906102507.15504-2-tinozzo123@gmail.com>
From:   Daniel Ogorchock <djogorchock@gmail.com>
Date:   Thu, 7 Sep 2023 21:10:55 -0400
Message-ID: <CAEVj2tk3uUa625YVO+2Mv80FbNT6gE=16_GTxuLUB1ncT_jV2A@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] HID: nintendo: reinitialize USB Pro Controller
 after resuming from suspend
To:     Martino Fontana <tinozzo123@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Sep 6, 2023 at 6:25=E2=80=AFAM Martino Fontana <tinozzo123@gmail.co=
m> wrote:
>
> When suspending the computer, a Switch Pro Controller connected via USB w=
ill
> lose its internal status. However, because the USB connection was technic=
ally
> never lost, when resuming the computer, the driver will attempt to commun=
icate
> with the controller as if nothing happened (and fail).
> Because of this, the user was forced to manually disconnect the controlle=
r
> (or to press the sync button on the controller to power it off), so that =
it
> can be re-initialized.
>
> With this patch, the controller will be automatically re-initialized afte=
r
> resuming from suspend.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D216233
>
> Signed-off-by: Martino Fontana <tinozzo123@gmail.com>

Hi Martino,

Thanks for the patch. This has been on the backlog for a long time, so
it's great to see that USB resume is handled now.

Have you tested how this behaves for bluetooth controllers? Does the
pm resume hook always result in error logs for bluetooth controllers,
or has the kernel already removed the device before resume?

> ---
>  drivers/hid/hid-nintendo.c | 178 ++++++++++++++++++++++---------------
>  1 file changed, 106 insertions(+), 72 deletions(-)
>
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 250f5d2f8..a5ebe857a 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -2088,7 +2088,9 @@ static int joycon_read_info(struct joycon_ctlr *ctl=
r)
>         struct joycon_input_report *report;
>
>         req.subcmd_id =3D JC_SUBCMD_REQ_DEV_INFO;
> +       mutex_lock(&ctlr->output_mutex);
>         ret =3D joycon_send_subcmd(ctlr, &req, 0, HZ);
> +       mutex_unlock(&ctlr->output_mutex);
>         if (ret) {
>                 hid_err(ctlr->hdev, "Failed to get joycon info; ret=3D%d\=
n", ret);
>                 return ret;
> @@ -2117,6 +2119,88 @@ static int joycon_read_info(struct joycon_ctlr *ct=
lr)
>         return 0;
>  }
>
> +static int joycon_init(struct hid_device *hdev)
> +{
> +       struct joycon_ctlr *ctlr =3D hid_get_drvdata(hdev);
> +       int ret =3D 0;
> +
> +       mutex_lock(&ctlr->output_mutex);
> +       /* if handshake command fails, assume ble pro controller */
> +       if ((jc_type_is_procon(ctlr) || jc_type_is_chrggrip(ctlr)) &&
> +           !joycon_send_usb(ctlr, JC_USB_CMD_HANDSHAKE, HZ)) {
> +               hid_dbg(hdev, "detected USB controller\n");
> +               /* set baudrate for improved latency */
> +               ret =3D joycon_send_usb(ctlr, JC_USB_CMD_BAUDRATE_3M, HZ)=
;
> +               if (ret) {
> +                       hid_err(hdev, "Failed to set baudrate; ret=3D%d\n=
", ret);
> +                       goto err_mutex;
> +               }
> +               /* handshake */
> +               ret =3D joycon_send_usb(ctlr, JC_USB_CMD_HANDSHAKE, HZ);
> +               if (ret) {
> +                       hid_err(hdev, "Failed handshake; ret=3D%d\n", ret=
);
> +                       goto err_mutex;
> +               }
> +               /*
> +                * Set no timeout (to keep controller in USB mode).
> +                * This doesn't send a response, so ignore the timeout.
> +                */
> +               joycon_send_usb(ctlr, JC_USB_CMD_NO_TIMEOUT, HZ/10);
> +       } else if (jc_type_is_chrggrip(ctlr)) {
> +               hid_err(hdev, "Failed charging grip handshake\n");
> +               ret =3D -ETIMEDOUT;
> +               goto err_mutex;
> +       }
> +
> +       /* get controller calibration data, and parse it */
> +       ret =3D joycon_request_calibration(ctlr);
> +       if (ret) {
> +               /*
> +                * We can function with default calibration, but it may b=
e
> +                * inaccurate. Provide a warning, and continue on.
> +                */
> +               hid_warn(hdev, "Analog stick positions may be inaccurate\=
n");
> +       }
> +
> +       /* get IMU calibration data, and parse it */
> +       ret =3D joycon_request_imu_calibration(ctlr);
> +       if (ret) {
> +               /*
> +                * We can function with default calibration, but it may b=
e
> +                * inaccurate. Provide a warning, and continue on.
> +                */
> +               hid_warn(hdev, "Unable to read IMU calibration data\n");
> +       }
> +
> +       /* Set the reporting mode to 0x30, which is the full report mode =
*/
> +       ret =3D joycon_set_report_mode(ctlr);
> +       if (ret) {
> +               hid_err(hdev, "Failed to set report mode; ret=3D%d\n", re=
t);
> +               goto err_mutex;
> +       }
> +
> +       /* Enable rumble */
> +       ret =3D joycon_enable_rumble(ctlr);
> +       if (ret) {
> +               hid_err(hdev, "Failed to enable rumble; ret=3D%d\n", ret)=
;
> +               goto err_mutex;
> +       }
> +
> +       /* Enable the IMU */
> +       ret =3D joycon_enable_imu(ctlr);
> +       if (ret) {
> +               hid_err(hdev, "Failed to enable the IMU; ret=3D%d\n", ret=
);
> +               goto err_mutex;
> +       }
> +
> +       mutex_unlock(&ctlr->output_mutex);
> +       return 0;

If desired, you could remove the above two lines and allow flow to
continue through err_mutex even in the success case.

> +
> +err_mutex:
> +       mutex_unlock(&ctlr->output_mutex);
> +       return ret;
> +}
> +
>  /* Common handler for parsing inputs */
>  static int joycon_ctlr_read_handler(struct joycon_ctlr *ctlr, u8 *data,
>                                                               int size)
> @@ -2248,85 +2332,19 @@ static int nintendo_hid_probe(struct hid_device *=
hdev,
>
>         hid_device_io_start(hdev);
>
> -       /* Initialize the controller */
> -       mutex_lock(&ctlr->output_mutex);
> -       /* if handshake command fails, assume ble pro controller */
> -       if ((jc_type_is_procon(ctlr) || jc_type_is_chrggrip(ctlr)) &&
> -           !joycon_send_usb(ctlr, JC_USB_CMD_HANDSHAKE, HZ)) {
> -               hid_dbg(hdev, "detected USB controller\n");
> -               /* set baudrate for improved latency */
> -               ret =3D joycon_send_usb(ctlr, JC_USB_CMD_BAUDRATE_3M, HZ)=
;
> -               if (ret) {
> -                       hid_err(hdev, "Failed to set baudrate; ret=3D%d\n=
", ret);
> -                       goto err_mutex;
> -               }
> -               /* handshake */
> -               ret =3D joycon_send_usb(ctlr, JC_USB_CMD_HANDSHAKE, HZ);
> -               if (ret) {
> -                       hid_err(hdev, "Failed handshake; ret=3D%d\n", ret=
);
> -                       goto err_mutex;
> -               }
> -               /*
> -                * Set no timeout (to keep controller in USB mode).
> -                * This doesn't send a response, so ignore the timeout.
> -                */
> -               joycon_send_usb(ctlr, JC_USB_CMD_NO_TIMEOUT, HZ/10);
> -       } else if (jc_type_is_chrggrip(ctlr)) {
> -               hid_err(hdev, "Failed charging grip handshake\n");
> -               ret =3D -ETIMEDOUT;
> -               goto err_mutex;
> -       }
> -
> -       /* get controller calibration data, and parse it */
> -       ret =3D joycon_request_calibration(ctlr);
> -       if (ret) {
> -               /*
> -                * We can function with default calibration, but it may b=
e
> -                * inaccurate. Provide a warning, and continue on.
> -                */
> -               hid_warn(hdev, "Analog stick positions may be inaccurate\=
n");
> -       }
> -
> -       /* get IMU calibration data, and parse it */
> -       ret =3D joycon_request_imu_calibration(ctlr);
> -       if (ret) {
> -               /*
> -                * We can function with default calibration, but it may b=
e
> -                * inaccurate. Provide a warning, and continue on.
> -                */
> -               hid_warn(hdev, "Unable to read IMU calibration data\n");
> -       }
> -
> -       /* Set the reporting mode to 0x30, which is the full report mode =
*/
> -       ret =3D joycon_set_report_mode(ctlr);
> -       if (ret) {
> -               hid_err(hdev, "Failed to set report mode; ret=3D%d\n", re=
t);
> -               goto err_mutex;
> -       }
> -
> -       /* Enable rumble */
> -       ret =3D joycon_enable_rumble(ctlr);
> -       if (ret) {
> -               hid_err(hdev, "Failed to enable rumble; ret=3D%d\n", ret)=
;
> -               goto err_mutex;
> -       }
> -
> -       /* Enable the IMU */
> -       ret =3D joycon_enable_imu(ctlr);
> +       ret =3D joycon_init(hdev);
>         if (ret) {
> -               hid_err(hdev, "Failed to enable the IMU; ret=3D%d\n", ret=
);
> -               goto err_mutex;
> +               hid_err(hdev, "Failed to initialize controller; ret=3D%d\=
n", ret);
> +               goto err_close;
>         }
>
>         ret =3D joycon_read_info(ctlr);
>         if (ret) {
>                 hid_err(hdev, "Failed to retrieve controller info; ret=3D=
%d\n",
>                         ret);
> -               goto err_mutex;
> +               goto err_close;
>         }
>
> -       mutex_unlock(&ctlr->output_mutex);
> -
>         /* Initialize the leds */
>         ret =3D joycon_leds_create(ctlr);
>         if (ret) {
> @@ -2352,8 +2370,6 @@ static int nintendo_hid_probe(struct hid_device *hd=
ev,
>         hid_dbg(hdev, "probe - success\n");
>         return 0;
>
> -err_mutex:
> -       mutex_unlock(&ctlr->output_mutex);
>  err_close:
>         hid_hw_close(hdev);
>  err_stop:
> @@ -2383,6 +2399,20 @@ static void nintendo_hid_remove(struct hid_device =
*hdev)
>         hid_hw_stop(hdev);
>  }
>
> +#ifdef CONFIG_PM
> +
> +static int nintendo_hid_resume(struct hid_device *hdev)
> +{
> +       int ret =3D joycon_init(hdev);
> +
> +       if (ret)
> +               hid_err(hdev, "Failed to restore controller after resume"=
);
> +
> +       return ret;
> +}
> +
> +#endif
> +
>  static const struct hid_device_id nintendo_hid_devices[] =3D {
>         { HID_USB_DEVICE(USB_VENDOR_ID_NINTENDO,
>                          USB_DEVICE_ID_NINTENDO_PROCON) },
> @@ -2404,6 +2434,10 @@ static struct hid_driver nintendo_hid_driver =3D {
>         .probe          =3D nintendo_hid_probe,
>         .remove         =3D nintendo_hid_remove,
>         .raw_event      =3D nintendo_hid_event,
> +
> +#ifdef CONFIG_PM
> +       .resume         =3D nintendo_hid_resume,
> +#endif

Something else we should do is add a suspend hook to power off the
bluetooth-connected controllers. As of now, they remain powered on
during suspend.

>  };
>  module_hid_driver(nintendo_hid_driver);
>
> --
> 2.41.0
>

Thanks,
Daniel
