Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2FD781A90
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 18:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjHSQmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 12:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHSQmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 12:42:31 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F40C27807;
        Sat, 19 Aug 2023 09:42:28 -0700 (PDT)
Date:   Sat, 19 Aug 2023 16:42:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1692463345; x=1692722545;
        bh=KEGHC+AEt8aDTz0BwmmuwiXP402wD0tAxCWiWn2DZXM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=jQsIoxRDS7zrngS9myVX5uKBZSi9bKM8Tv7WBZEdYrodBLi6u9neVWLiHGlIlxhVv
         aFGORViJdy0MVqwn7GYFXu+xgtmEqc78ZV0YXdeF7muXgqKfz2sxLL8/a7AarPJRz/
         A/dF5u5zJ/5/eZFm6mvFdfZDcchX0FwxRpqqsZkk+mGRYRuDHu2F/awsXu31wMDnjF
         wzo1AW9iy9ZloEz2Y8udImaL1Aq2O9xKZgEdtMBvhOOHOAnukP7FoDZwGVrXFAv9xe
         2Tt761mmnoI/V69DKsJUTEEKHxEEteSwVlYpmbuUlE6a4MiqKJAi1IByxXWV/zZsyv
         sEcCrDMS5fLFw==
To:     johannes@gnu-linux.rocks
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        andi.shyti@kernel.org, christophe.jaillet@wanadoo.fr,
        rdunlap@infradead.org, ak@it-klinger.de
Subject: Re: [PATCH v5] hid-mcp2200: added driver for GPIOs of MCP2200
Message-ID: <87a5unt25h.fsf@protonmail.com>
In-Reply-To: <20230818104852.64923-1-johannes@gnu-linux.rocks>
References: <20230818104852.64923-1-johannes@gnu-linux.rocks>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit message subject should probably start with "HID: mcp2200:"
rather than "hid-mcp2200:". This matches mcp2221.

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/dr=
ivers/hid/hid-mcp2221.c

On Fri, 18 Aug, 2023 12:48:52 +0200 <johannes@gnu-linux.rocks> wrote:
> From: Johannes Roith <johannes@gnu-linux.rocks>
>
> Added a gpiochip compatible driver to control the 8 GPIOs of
> the MCP2200 by using the HID interface.
>
> Using GPIOs with alternative functions (GP0<->SSPND, GP1<->USBCFG,
> GP6<->RXLED, GP7<->TXLED) will reset the functions, if set (unset by
> default).
>
> The driver was tested while also using the UART of the chip. Setting
> and reading the GPIOs has no effect on the UART communication. However,
> a reset is triggered after the CONFIGURE command. If the GPIO Direction
> is constantly changed, this will affect the communication at low baud
> rates. This is a hardware problem of the MCP2200 and is not caused by
> the driver.
>

The content below should not be in the commit message body but rather
git notes or a section in the patch that will not be applied.

> Feedback from reviewers Christophe JAILLET <christophe.jaillet@wanadoo.fr=
>
> and Andi Shyti <andi.shyti@kernel.org> was added.
>
> Changelog:
>
> - v1: added driver
> - v2: added ProductID in hid-ids.h
> - v3: added feedback from review and make patch compilable
> - v4: added more feedback from second review, tested as module and
>   builtin on x86 and arm64
> - v5: adopted Kconfig to style guidelines, fixed mcp_set_direction

For your reference in case you find it helpful.

  * https://git-scm.com/docs/git-notes
  * https://git-scm.com/docs/git-format-patch#Documentation/git-format-patc=
h.txt---notesltrefgt

>
> Signed-off-by: Johannes Roith <johannes@gnu-linux.rocks>
> ---
>  drivers/hid/Kconfig       |  10 +
>  drivers/hid/Makefile      |   1 +
>  drivers/hid/hid-ids.h     |   1 +
>  drivers/hid/hid-mcp2200.c | 419 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 431 insertions(+)
>  create mode 100644 drivers/hid/hid-mcp2200.c
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index e11c1c803676..efe01b473cc2 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1301,6 +1301,16 @@ config HID_MCP2221
>  =09To compile this driver as a module, choose M here: the module
>  =09will be called hid-mcp2221.ko.
>
> +config HID_MCP2200
> +=09tristate "Microchip MCP2200 HID USB-to-GPIO bridge"
> +=09depends on USB_HID
> +=09imply GPIOLIB
> +=09help
> +=09  Provides GPIO functionality over USB-HID through MCP2200 device.
> +
> +=09  To compile this driver as a module, choose M here: the module
> +=09  will be called hid-mcp2200.ko.
> +

Alphabetically, HID_MCP2200 should be before HID_MCP2221.

>  config HID_KUNIT_TEST
>  =09tristate "KUnit tests for HID" if !KUNIT_ALL_TESTS
>  =09depends on KUNIT
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 7a9e160158f7..050f740304c4 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -79,6 +79,7 @@ obj-$(CONFIG_HID_MACALLY)=09+=3D hid-macally.o
>  obj-$(CONFIG_HID_MAGICMOUSE)=09+=3D hid-magicmouse.o
>  obj-$(CONFIG_HID_MALTRON)=09+=3D hid-maltron.o
>  obj-$(CONFIG_HID_MCP2221)=09+=3D hid-mcp2221.o
> +obj-$(CONFIG_HID_MCP2200)=09+=3D hid-mcp2200.o

Similar comment as previous here.

>  obj-$(CONFIG_HID_MAYFLASH)=09+=3D hid-mf.o
>  obj-$(CONFIG_HID_MEGAWORLD_FF)=09+=3D hid-megaworld.o
>  obj-$(CONFIG_HID_MICROSOFT)=09+=3D hid-microsoft.o
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 8a310f8ff20f..4926ca41225b 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -914,6 +914,7 @@
>  #define USB_DEVICE_ID_PICK16F1454_V2=090xf2f7
>  #define USB_DEVICE_ID_LUXAFOR=09=090xf372
>  #define USB_DEVICE_ID_MCP2221=09=090x00dd
> +#define USB_DEVICE_ID_MCP2200=09=090x00df

This file is sorted primarily by the define name rather than the device
id, so I would expect the define for mcp2200 to be before mcp2221 (even
though its device id would be after).

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/hid/hid-ids.h?id=3Daa9ea98cca3a56869df1dc6347f3e3bfe0c01f44#n449

>
>  #define USB_VENDOR_ID_MICROSOFT=09=090x045e
>  #define USB_DEVICE_ID_SIDEWINDER_GV=090x003b
> diff --git a/drivers/hid/hid-mcp2200.c b/drivers/hid/hid-mcp2200.c
> new file mode 100644
> index 000000000000..ed4483fa5bdf
> --- /dev/null
> +++ b/drivers/hid/hid-mcp2200.c
> @@ -0,0 +1,419 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MCP2200 - Microchip USB to GPIO bridge
> + *
> + * Copyright (c) 2023, Johannes Roith <johannes@gnu-linux.rocks>
> + *
> + * Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/22228A.pd=
f
> + * App Note for HID: https://ww1.microchip.com/downloads/en/DeviceDoc/93=
066A.pdf
> + */
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/hid.h>
> +#include <linux/hidraw.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include "hid-ids.h"
> +
> +/* Commands codes in a raw output report */
> +#define SET_CLEAR_OUTPUTS=090x08
> +#define CONFIGURE=09=090x10
> +#define READ_EE=09=09=090x20
> +#define WRITE_EE=09=090x40
> +#define READ_ALL=09=090x80
> +
> +/* MCP GPIO direction encoding */
> +enum MCP_IO_DIR {
> +=09MCP2200_DIR_OUT =3D 0x00,
> +=09MCP2200_DIR_IN  =3D 0x01,
> +};
> +
> +/* Altternative pin assignments */
> +#define TXLED=09=092
> +#define RXLED=09=093
> +#define USBCFG=09=096
> +#define SSPND=09=097
> +#define MCP_NGPIO=098
> +
> +/* CMD to set or clear a GPIO output */
> +struct mcp_set_clear_outputs {
> +=09u8 cmd;
> +=09u8 dummys1[10];
> +=09u8 set_bmap;
> +=09u8 clear_bmap;
> +=09u8 dummys2[3];
> +} __packed;
> +
> +/* CMD to configure the IOs */
> +struct mcp_configure {
> +=09u8 cmd;
> +=09u8 dummys1[3];
> +=09u8 io_bmap;
> +=09u8 config_alt_pins;
> +=09u8 io_default_val_bmap;
> +=09u8 config_alt_options;
> +=09u8 baud_h;
> +=09u8 baud_l;
> +=09u8 dummys2[6];
> +} __packed;
> +
> +/* CMD to read all parameters */
> +struct mcp_read_all {
> +=09u8 cmd;
> +=09u8 dummys[15];
> +} __packed;
> +
> +/* Response to the read all cmd */
> +struct mcp_read_all_resp {
> +=09u8 cmd;
> +=09u8 eep_addr;
> +=09u8 dummy;
> +=09u8 eep_val;
> +=09u8 io_bmap;
> +=09u8 config_alt_pins;
> +=09u8 io_default_val_bmap;
> +=09u8 config_alt_options;
> +=09u8 baud_h;
> +=09u8 baud_l;
> +=09u8 io_port_val_bmap;
> +=09u8 dummys[5];
> +} __packed;
> +
> +struct mcp2200 {
> +=09struct hid_device *hdev;
> +=09struct mutex lock;
> +=09struct completion wait_in_report;
> +=09u8 gpio_dir;
> +=09u8 gpio_val;
> +=09u8 gpio_inval;
> +=09u8 baud_h;
> +=09u8 baud_l;
> +=09u8 config_alt_pins;
> +=09u8 gpio_reset_val;
> +=09u8 config_alt_options;
> +=09int status;
> +=09struct gpio_chip gc;
> +};
> +
> +/* this executes the READ_ALL cmd */
> +static int mcp_cmd_read_all(struct mcp2200 *mcp)
> +{
> +=09struct mcp_read_all *read_all;
> +=09int len, t;
> +
> +=09reinit_completion(&mcp->wait_in_report);
> +=09read_all =3D kzalloc(sizeof(struct mcp_read_all), GFP_KERNEL);
> +=09if (!read_all)
> +=09=09return -ENOMEM;

My personal recommendation is to just have a single DMA buffer allocated
for the mcp2200 instance rather than having to call the allocator and
release the memory per command.

Here is a reference.

  https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/tree/drivers/=
hid/hid-nvidia-shield.c?id=3D1d7546042f8fdc4bc39ab91ec966203e2d64f8bd#n502

> +
> +=09read_all->cmd =3D READ_ALL;
> +
> +=09mutex_lock(&mcp->lock);
> +=09len =3D hid_hw_output_report(mcp->hdev, (u8 *) read_all,
> +=09=09=09=09   sizeof(struct mcp_read_all));
> +
> +=09mutex_unlock(&mcp->lock);
> +=09kfree(read_all);
> +
> +=09if (len !=3D sizeof(struct mcp_read_all))
> +=09=09return -EINVAL;
> +
> +=09t =3D wait_for_completion_timeout(&mcp->wait_in_report,
> +=09=09=09=09=09msecs_to_jiffies(4000));
> +=09if (!t)
> +=09=09return -ETIMEDOUT;
> +
> +=09/* return status, negative value if wrong response was received */
> +=09return mcp->status;
> +}
> +
> +static void mcp_set_multiple(struct gpio_chip *gc, unsigned long *mask,
> +=09=09=09     unsigned long *bits)
> +{
> +=09struct mcp2200 *mcp =3D gpiochip_get_data(gc);
> +=09u8 value;
> +=09int status;
> +=09struct mcp_set_clear_outputs *cmd;
> +
> +=09cmd =3D kzalloc(sizeof(struct mcp_set_clear_outputs), GFP_KERNEL);
> +=09if (!cmd)
> +=09=09return;
> +
> +=09mutex_lock(&mcp->lock);
> +
> +=09value =3D mcp->gpio_val & ~*mask;
> +=09value |=3D (*mask & *bits);
> +
> +=09cmd->cmd =3D SET_CLEAR_OUTPUTS;
> +=09cmd->set_bmap =3D value;
> +=09cmd->clear_bmap =3D ~(value);
> +
> +=09status =3D hid_hw_output_report(mcp->hdev, (u8 *) cmd,
> +=09=09       sizeof(struct mcp_set_clear_outputs));
> +
> +=09if (status =3D=3D sizeof(struct mcp_set_clear_outputs))
> +=09=09mcp->gpio_val =3D value;
> +
> +=09mutex_unlock(&mcp->lock);
> +=09kfree(cmd);
> +}
> +
> +static void mcp_set(struct gpio_chip *gc, unsigned int gpio_nr, int valu=
e)
> +{
> +=09unsigned long mask =3D 1 << gpio_nr;
> +=09unsigned long bmap_value =3D value << gpio_nr;
> +
> +=09mcp_set_multiple(gc, &mask, &bmap_value);
> +}
> +
> +static int mcp_get_multiple(struct gpio_chip *gc, unsigned long *mask,
> +=09=09unsigned long *bits)
> +{
> +=09u32 val;
> +=09struct mcp2200 *mcp =3D gpiochip_get_data(gc);
> +=09int status;
> +
> +=09status =3D mcp_cmd_read_all(mcp);
> +=09if (status !=3D 0)

Can be simplified as 'if (status)'.

> +=09=09return status;
> +
> +=09val =3D mcp->gpio_inval;
> +=09*bits =3D (val & *mask);
> +=09return 0;
> +}
> +
> +static int mcp_get(struct gpio_chip *gc, unsigned int gpio_nr)
> +{
> +=09unsigned long mask =3D 0, bits =3D 0;

You do not need to zero init these variables? It's useful to avoid
initializing variables unnecessarily for compile time checking/static
analysis purposes.

> +
> +=09mask =3D (1 << gpio_nr);
> +=09mcp_get_multiple(gc, &mask, &bits);
> +=09return bits > 0;
> +}
> +
> +static int mcp_get_direction(struct gpio_chip *gc, unsigned int gpio_nr)
> +{
> +=09struct mcp2200 *mcp =3D gpiochip_get_data(gc);
> +
> +=09return (mcp->gpio_dir & (MCP2200_DIR_IN << gpio_nr))
> +=09=09? GPIO_LINE_DIRECTION_IN : GPIO_LINE_DIRECTION_OUT;
> +}
> +
> +static int mcp_set_direction(struct gpio_chip *gc, unsigned int gpio_nr,
> +=09=09=09     enum MCP_IO_DIR io_direction)
> +{
> +=09struct mcp2200 *mcp =3D gpiochip_get_data(gc);
> +=09struct mcp_configure *conf;
> +=09int status;
> +=09/* after the configure cmd we will need to set the outputs again */
> +=09unsigned long mask =3D ~(mcp->gpio_dir); /* only set outputs */
> +=09unsigned long bits =3D mcp->gpio_val;
> +=09/* Offsets of alternative pins in config_alt_pins, 0 is not used */
> +=09u8 alt_pin_conf[8] =3D {SSPND, USBCFG, 0, 0, 0, 0, RXLED, TXLED};
> +=09u8 config_alt_pins =3D mcp->config_alt_pins;
> +
> +=09/* Read in the reset baudrate first, we need it later */
> +=09status =3D mcp_cmd_read_all(mcp);
> +=09if (status !=3D 0)
> +=09=09return status;
> +
> +=09conf =3D kzalloc(sizeof(struct mcp_configure), GFP_KERNEL);
> +=09if (!conf)
> +=09=09return -ENOMEM;
> +
> +=09mutex_lock(&mcp->lock);
> +
> +=09/* configure will reset the chip! */
> +=09conf->cmd =3D CONFIGURE;
> +=09conf->io_bmap =3D (mcp->gpio_dir & ~(1 << gpio_nr))
> +=09=09| (io_direction << gpio_nr);
> +=09/* Don't overwrite the reset parameters */
> +=09conf->baud_h =3D mcp->baud_h;
> +=09conf->baud_l =3D mcp->baud_l;
> +=09conf->config_alt_options =3D mcp->config_alt_options;
> +=09conf->io_default_val_bmap =3D mcp->gpio_reset_val;
> +=09/* Adjust alt. func if necessary */
> +=09if (alt_pin_conf[gpio_nr])
> +=09=09config_alt_pins &=3D ~(1 << alt_pin_conf[gpio_nr]);
> +=09conf->config_alt_pins =3D config_alt_pins;
> +
> +=09status =3D hid_hw_output_report(mcp->hdev, (u8 *) conf,
> +=09=09=09=09      sizeof(struct mcp_set_clear_outputs));
> +
> +=09if (status =3D=3D sizeof(struct mcp_set_clear_outputs)) {
> +=09=09mcp->gpio_dir =3D conf->io_bmap;
> +=09=09mcp->config_alt_pins =3D config_alt_pins;
> +=09} else {
> +=09=09mutex_unlock(&mcp->lock);
> +=09=09kfree(conf);
> +=09=09return -EIO;
> +=09}
> +
> +=09mutex_unlock(&mcp->lock);
> +=09kfree(conf);
> +
> +=09/* Configure CMD will clear all IOs -> rewrite them */
> +=09mcp_set_multiple(gc, &mask, &bits);
> +=09return 0;
> +}
> +
> +static int mcp_direction_input(struct gpio_chip *gc, unsigned int gpio_n=
r)
> +{
> +=09return mcp_set_direction(gc, gpio_nr, MCP2200_DIR_IN);
> +}
> +
> +static int mcp_direction_output(struct gpio_chip *gc, unsigned int gpio_=
nr,
> +=09=09=09=09int value)
> +{
> +=09int ret;
> +=09unsigned long mask, bmap_value;
> +
> +=09mask =3D 1 << gpio_nr;
> +=09bmap_value =3D value << gpio_nr;
> +
> +=09ret =3D mcp_set_direction(gc, gpio_nr, MCP2200_DIR_OUT);
> +=09if (ret =3D=3D 0)

'if (!ret)' can be used here.

> +=09=09mcp_set_multiple(gc, &mask, &bmap_value);
> +=09return ret;
> +}
> +
> +static const struct gpio_chip template_chip =3D {
> +=09.label=09=09=09=3D "mcp2200",
> +=09.owner=09=09=09=3D THIS_MODULE,
> +=09.get_direction=09=09=3D mcp_get_direction,
> +=09.direction_input=09=3D mcp_direction_input,
> +=09.direction_output=09=3D mcp_direction_output,
> +=09.set=09=09=09=3D mcp_set,
> +=09.set_multiple=09=09=3D mcp_set_multiple,
> +=09.get=09=09=09=3D mcp_get,
> +=09.get_multiple=09=09=3D mcp_get_multiple,
> +=09.base=09=09=09=3D -1,
> +=09.ngpio=09=09=09=3D MCP_NGPIO,
> +=09.can_sleep=09=09=3D true,
> +};
> +
> +/*
> + * MCP2200 uses interrupt endpoint for input reports. This function
> + * is called by HID layer when it receives i/p report from mcp2200,
> + * which is actually a response to the previously sent command.
> + */
> +static int mcp2200_raw_event(struct hid_device *hdev, struct hid_report =
*report,
> +=09=09u8 *data, int size)
> +{
> +=09struct mcp2200 *mcp =3D hid_get_drvdata(hdev);
> +=09struct mcp_read_all_resp *all_resp;
> +
> +=09switch (data[0]) {
> +=09case READ_ALL:
> +=09=09all_resp =3D (struct mcp_read_all_resp *) data;
> +=09=09mcp->status =3D 0;
> +=09=09mcp->gpio_inval =3D all_resp->io_port_val_bmap;
> +=09=09mcp->baud_h =3D all_resp->baud_h;
> +=09=09mcp->baud_l =3D all_resp->baud_l;
> +=09=09mcp->gpio_reset_val =3D all_resp->io_default_val_bmap;
> +=09=09mcp->config_alt_pins =3D all_resp->config_alt_pins;
> +=09=09mcp->config_alt_options =3D all_resp->config_alt_options;
> +=09=09break;
> +=09default:
> +=09=09mcp->status =3D -EIO;
> +=09=09break;
> +=09}
> +
> +=09complete(&mcp->wait_in_report);
> +=09return 1;

While this is not problematic today, I think it would be better to
return 0 here rather than 1.

> +}
> +
> +static void mcp2200_hid_unregister(void *ptr)
> +{
> +=09struct hid_device *hdev =3D ptr;
> +
> +=09hid_hw_close(hdev);
> +=09hid_hw_stop(hdev);
> +}
> +
> +static int mcp2200_probe(struct hid_device *hdev, const struct hid_devic=
e_id *id)
> +{
> +=09int ret;
> +=09struct mcp2200 *mcp;
> +
> +=09mcp =3D devm_kzalloc(&hdev->dev, sizeof(*mcp), GFP_KERNEL);
> +=09if (!mcp)
> +=09=09return -ENOMEM;
> +
> +=09ret =3D hid_parse(hdev);
> +=09if (ret) {
> +=09=09hid_err(hdev, "can't parse reports\n");
> +=09=09return ret;
> +=09}
> +
> +=09/*
> +=09 * This driver uses the .raw_event callback and therefore does not ne=
ed any
> +=09 * HID_CONNECT_xxx flags.
> +=09 */
> +=09ret =3D hid_hw_start(hdev, 0);
> +=09if (ret) {
> +=09=09hid_err(hdev, "can't start hardware\n");
> +=09=09return ret;
> +=09}
> +
> +=09hid_info(hdev, "USB HID v%x.%02x Device [%s] on %s\n", hdev->version =
>> 8,
> +=09=09=09hdev->version & 0xff, hdev->name, hdev->phys);
> +
> +=09ret =3D hid_hw_open(hdev);
> +=09if (ret) {

Need to call hid_hw_stop here since hid_hw_start succeeded.

> +=09=09hid_err(hdev, "can't open device\n");
> +=09=09return ret;
> +=09}
> +
> +=09mutex_init(&mcp->lock);
> +=09init_completion(&mcp->wait_in_report);
> +=09hid_set_drvdata(hdev, mcp);
> +=09mcp->hdev =3D hdev;
> +
> +=09ret =3D devm_add_action_or_reset(&hdev->dev, mcp2200_hid_unregister, =
hdev);
> +=09if (ret)

You probably want to call mcp2200_hid_unregister here since the action
was not added?

> +=09=09return ret;
> +
> +=09mcp->gc =3D template_chip;
> +=09mcp->gc.parent =3D &hdev->dev;
> +
> +=09ret =3D devm_gpiochip_add_data(&hdev->dev, &mcp->gc, mcp);
> +=09if (ret < 0) {
> +=09=09hid_err(hdev, "Unable to register gpiochip\n");
> +=09=09return ret;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static void mcp2200_remove(struct hid_device *hdev)
> +{
> +=09(void) hdev;
> +=09/*
> +=09 * With no remove function you sometimes get a segmentation fault whe=
n
> +=09 * unloading the module or disconnecting the USB device
> +=09 */

The reason you run into this is likely because of the action added to
devm conflicting with hid_device_remove....

I recommend not depending on devm for teardown rather than making a stub
remove function to work around the issue.

  static void hid_device_remove(struct device *dev)
  {
    struct hid_device *hdev =3D to_hid_device(dev);
    struct hid_driver *hdrv;

    down(&hdev->driver_input_lock);
    hdev->io_started =3D false;

    hdrv =3D hdev->driver;
    if (hdrv) {
      if (hdrv->remove)
        hdrv->remove(hdev);
      else /* default remove */
        hid_hw_stop(hdev);

hid_device_remove will call hid_hw_stop and so will
mcp2200_hid_unregister because of the devm action you added.

> +}
> +
> +static const struct hid_device_id mcp2200_devices[] =3D {
> +=09{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_MCP2200) },
> +=09{ }
> +};
> +MODULE_DEVICE_TABLE(hid, mcp2200_devices);
> +
> +static struct hid_driver mcp2200_driver =3D {
> +=09.name=09=09=3D "mcp2200",
> +=09.id_table=09=3D mcp2200_devices,
> +=09.probe=09=09=3D mcp2200_probe,
> +=09.remove=09=09=3D mcp2200_remove,
> +=09.raw_event=09=3D mcp2200_raw_event,
> +};
> +
> +/* Register with HID core */
> +module_hid_driver(mcp2200_driver);
> +
> +MODULE_AUTHOR("Johannes Roith <johannes@gnu-linux.rocks>");
> +MODULE_DESCRIPTION("MCP2200 Microchip HID USB to GPIO bridge");
> +MODULE_LICENSE("GPL");

--
Thanks,

Rahul Rameshbabu

