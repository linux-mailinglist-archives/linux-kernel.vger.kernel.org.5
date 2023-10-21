Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA337D1D91
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjJUOtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUOtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:49:17 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2705CDA
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:49:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9d4f08d7cso121865ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697899751; x=1698504551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyLPGEgSgRLGHS320ryZpZAtQHgBe1tEJpa9w8HoNtg=;
        b=bQpwkWZJmA7EbWbzOLHu6uDMR7R+l9SfpBsW5fi+bjxDk20zK+5sr4NofIRyA6AktG
         1uuxfHsOuQIwkcODOoRYcC28V12FA7OEMNNuzU6cvN/xXtfDshFTOrefmZSW+ZMlaGdq
         06rTvm1Xvxrff5nHe73s3pQk9a20ZB+Y2lBrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697899751; x=1698504551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyLPGEgSgRLGHS320ryZpZAtQHgBe1tEJpa9w8HoNtg=;
        b=vcJEywtFgG+nARniuhS/F1iSIjxZJkg1jwmGrPp6Zikcyn1xc6RZAI9wwdW5eh0vXJ
         g22rIQBEq5uB8Zbp2vAv72XLnxJHEt81zTWGoWJyG2ikMDjM7qZQ+dwclFF2XJR/8EWB
         1jzWaUauC2zz/8ZC7lBfpeYOskCy+JpeaU4I0clrGCzUETyv6NjHDQh+UtxhUfkFwKKZ
         AYzlSDihCVL3bmp4MoNsn4UEZyEu3TzZAV++z5uXhDiOzQ852INE1MdoUoDnc+md0Pcu
         AOfXheAaVQkXCO+AvYamVLHxQURwbOBZSs14+4Pop6O9qHQaLnguonEKBDaKGVbJFJJj
         Biqg==
X-Gm-Message-State: AOJu0YxJA14uvG8ElUFVu/cR8qCz5JUr07rJqnaaEcynvOHC6SV9L+Sv
        2AGE6ZYDQx5AsAQjn32avjAgHSuEio1EOV4Cf/xN6Q==
X-Google-Smtp-Source: AGHT+IGx45bKoTmSOmzU5whM53/iKa3jjAyv96uOcz7czttM7eEekfroNUFJNHD+RLt3Q47QRGLttyuWy2+TAUUop3E=
X-Received: by 2002:a17:903:24a:b0:1c4:65d5:34c5 with SMTP id
 j10-20020a170903024a00b001c465d534c5mr391892plh.23.1697899751177; Sat, 21 Oct
 2023 07:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231020210751.3415723-1-dianders@chromium.org> <20231020140655.v5.1.I6e4fb5ae61b4c6ab32058cb12228fd5bd32da676@changeid>
In-Reply-To: <20231020140655.v5.1.I6e4fb5ae61b4c6ab32058cb12228fd5bd32da676@changeid>
From:   Grant Grundler <grundler@chromium.org>
Date:   Sat, 21 Oct 2023 07:48:59 -0700
Message-ID: <CANEJEGt4HwnPDyO=R0uRju5NtZDfXYd1G0_Tzu7ioNcFVz7cZA@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] r8152: Increase USB control msg timeout to 5000ms
 as per spec
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>, linux-usb@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 2:08=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> According to the comment next to USB_CTRL_GET_TIMEOUT and
> USB_CTRL_SET_TIMEOUT, although sending/receiving control messages is
> usually quite fast, the spec allows them to take up to 5 seconds.
> Let's increase the timeout in the Realtek driver from 500ms to 5000ms
> (using the #defines) to account for this.
>
> This is not just a theoretical change. The need for the longer timeout
> was seen in testing. Specifically, if you drop a sc7180-trogdor based
> Chromebook into the kdb debugger and then "go" again after sitting in
> the debugger for a while, the next USB control message takes a long
> time. Out of ~40 tests the slowest USB control message was 4.5
> seconds.
>
> While dropping into kdb is not exactly an end-user scenario, the above
> is similar to what could happen due to an temporary interrupt storm,
> what could happen if there was a host controller (HW or SW) issue, or
> what could happen if the Realtek device got into a confused state and
> needed time to recover.
>
> This change is fairly critical since the r8152 driver in Linux doesn't
> expect register reads/writes (which are backed by USB control
> messages) to fail.
>
> Fixes: ac718b69301c ("net/usb: new driver for RTL8152")
> Suggested-by: Hayes Wang <hayeswang@realtek.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Grant Grundler <grundler@chromium.org>

> ---
>
> (no changes since v1)
>
>  drivers/net/usb/r8152.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 0c13d9950cd8..482957beae66 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -1212,7 +1212,7 @@ int get_registers(struct r8152 *tp, u16 value, u16 =
index, u16 size, void *data)
>
>         ret =3D usb_control_msg(tp->udev, tp->pipe_ctrl_in,
>                               RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
> -                             value, index, tmp, size, 500);
> +                             value, index, tmp, size, USB_CTRL_GET_TIMEO=
UT);
>         if (ret < 0)
>                 memset(data, 0xff, size);
>         else
> @@ -1235,7 +1235,7 @@ int set_registers(struct r8152 *tp, u16 value, u16 =
index, u16 size, void *data)
>
>         ret =3D usb_control_msg(tp->udev, tp->pipe_ctrl_out,
>                               RTL8152_REQ_SET_REGS, RTL8152_REQT_WRITE,
> -                             value, index, tmp, size, 500);
> +                             value, index, tmp, size, USB_CTRL_SET_TIMEO=
UT);
>
>         kfree(tmp);
>
> @@ -9494,7 +9494,8 @@ static u8 __rtl_get_hw_ver(struct usb_device *udev)
>
>         ret =3D usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
>                               RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
> -                             PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp), =
500);
> +                             PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp),
> +                             USB_CTRL_GET_TIMEOUT);
>         if (ret > 0)
>                 ocp_data =3D (__le32_to_cpu(*tmp) >> 16) & VERSION_MASK;
>
> --
> 2.42.0.758.gaed0368e0e-goog
>
