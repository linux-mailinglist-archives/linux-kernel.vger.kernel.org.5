Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190247EA100
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjKMQLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjKMQLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:11:42 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A51D44;
        Mon, 13 Nov 2023 08:11:38 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32df66c691dso2684771f8f.3;
        Mon, 13 Nov 2023 08:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699891897; x=1700496697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvmPP40QAmaSDip2r3L5S1EZ53Tf38T1B8bFC5L/BSg=;
        b=iMkJiSBokWEVgp947YfXVcuo6qKHbycbp8XaDjmeO7ur8+NglGgIqYqNuX5dJQvHGv
         L4SetnzX9l5HWVNPu2njHysNEW8E7qTfxs+qd62LLwH3IBr0gL0JxLlOqQjmQ+kjtPnd
         x0U41NU/cevU9bPTCgDeJMLHEnH60YHm0ruySmM6J95cfqS5IotDyROF3NCbpKrCeHeU
         xbUiB9JL81lMHsJw9rx6HogFnzfV6Wi6r3wNWprsYFEtGCfZuyinjlKhmuL4DDcZ5KCk
         3BmHjtdC7KF1JCUzbJNsanEYWnW2YOfFtAatDgliFs+//b5V5O9dEiP32OR1tZSIoqQK
         nKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699891897; x=1700496697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvmPP40QAmaSDip2r3L5S1EZ53Tf38T1B8bFC5L/BSg=;
        b=bDGB2YrllWHR3M5B4cgKTg6DYYYZjz/GM+9JquziSwh479Dqi2Xc9iFS+mTSIsoyiF
         mtOHu18PEli4fx37PeldXJmImo5HIcwiicS2f5Ry/Z1RehALiVXzDNaELZmeilqpqpHr
         lNjTdrLYvX4kvqfrBimTkX+9LLnml+fz3ddDBP/f4w+fAZSeCuyRzrYKHAyPSUB9uf96
         p1iqd6BPgEog0lLHFcZHBauuFmRcKyaW3bfphh5aEa9PK+LtsQ67OFa7wq7HG5QsTSHp
         ZNfvYsSB8CEr9aQxwpSrvpS9dZAHSNbcAMEWjn0PP46wQSej/d79cCLBqA0ZS4P8ETXX
         rNfg==
X-Gm-Message-State: AOJu0YwUA/IzeVb46b0V8MXtwWVdUL2QWUk5wJiIbLTrFJutPzC59Xhf
        mc3QieLNcNs5objNBe7bNqRPpr6AATPFY02tNdA=
X-Google-Smtp-Source: AGHT+IHaRisWpjOsj5b+sS6PZcT4DTSUWt2n7ssMISYOAaBun9wlinKFs+GM3jPVDHxW/YbMG50KW6OUdWBrSec3VTg=
X-Received: by 2002:a05:6000:1447:b0:331:393d:aea1 with SMTP id
 v7-20020a056000144700b00331393daea1mr5143254wrx.13.1699891896874; Mon, 13 Nov
 2023 08:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20231113131634.614467-1-debug.penguin32@gmail.com>
 <20231113155354.620298-1-debug.penguin32@gmail.com> <ZVJJAReXiEVc35HZ@smile.fi.intel.com>
In-Reply-To: <ZVJJAReXiEVc35HZ@smile.fi.intel.com>
From:   Ronald Monthero <debug.penguin32@gmail.com>
Date:   Tue, 14 Nov 2023 02:11:25 +1000
Message-ID: <CALk6UxpBbbvRKo1L-KZ-5C_1YEZfZtiQGJmvVzH2j_y1oA+0Sg@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand
 controller response
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        martin.blumenstingl@googlemail.com, paul@crapouillou.net,
        robh@kernel.org, u.kleine-koenig@pengutronix.de,
        AVKrasnov@sberdevices.ru, r.czerwinski@pengutronix.de,
        jaimeliao.tw@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,
Thanks for the feedback, I had not seen your response by then. I will
modify and send it again.

BR,
Ron

On Tue, Nov 14, 2023 at 2:04=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> You are too quick with v2, below my comments (new and old).
>
> On Tue, Nov 14, 2023 at 01:53:51AM +1000, Ronald Monthero wrote:
> > Under heavy load it is likely that the controller is done
> > with its own task but the thread unlocking the wait is not
> > scheduled in time. Increasing IFC_TIMEOUT_MSECS allows the
> > controller to respond within allowable timeslice of 1 sec
>
> Missing period at the end?
>
> > fsl,ifc-nand 7e800000.nand: Controller is not responding
>
> > main/smp_fsm.c:1884 <inrcu: rcu_preempt detected stalls on CPUs/tasks:
> > rcu:    Tasks blocked on level-0 rcu_node (CPUs 0-1): P116/2:b..l
> >         (detected by 1, t=3D2102 jiffies, g=3D7729, q=3D754)
> > task:irq/31-arm-irq1 state:D stack: 0 pid: 116 ppid: 2 flags:0x00000000
> > [<8064b97f>] (__schedule) from [<8064bb01>] (schedule+0x8d/0xc2)
> > [<8064bb01>] (schedule) from [<8064dacd>]
> > [<8064dacd>] (rt_mutex_slowlock_block.constprop.0) from [<8064db57>]
> > [<8064db57>] (__rt_mutex_slowlock.constprop.0) from [<8064dbf7>]
> > [<8064dbf7>] (rt_mutex_slowlock.constprop.0) from [<804b2047>]
>
> At least above 9 lines are not important and may be removed.
>
> > [<804b2047>] (nand_get_device) from [<804b5335>] (nand_write_oob+0x1b/0=
x4a)
> > [<804b5335>] (nand_write_oob) from [<804a3585>] (mtd_write+0x41/0x5c)
> > [<804a3585>] (mtd_write) from [<804c1d47>] (ubi_io_write+0x17f/0x22c)
> > [<804c1d47>] (ubi_io_write) from [<804c047b>] (ubi_eba_write_leb+0x5b/0=
x1d0)
>
> ...
>
> > -#define IFC_TIMEOUT_MSECS    500  /* Maximum number of mSecs to wait
> > +#define IFC_TIMEOUT_MSECS    1000  /* Maximum number of mSecs to wait
> >                                       for IFC NAND Machine    */
>
> While at it, you may improve the comment, e.g.,
>
>   "Maximum timeout to wait for IPC NAND Machine"
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
