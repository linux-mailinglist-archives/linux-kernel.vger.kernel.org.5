Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F45775456
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjHIHmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHIHmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:42:50 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D00172A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:42:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52327d63d7cso5534547a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 00:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691566968; x=1692171768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhWuye7WtnKHQ5EWBkx1THX5ai7IhNWbpzXM2iw1dpk=;
        b=NnFLFFG4mH5u+fqqyqdLGuQFjqzUu9Y7OaXafnvW5qNyQikw92Qvis5gNmlzcxcd4d
         Iyf4fkYm104bSKVAdHPcUiaAkyn8eZD9k2xcZH/BDYD/tlZQ4hc6DLQKc3n326hdQ/gh
         z2Asn+/O4gXl+vROALbD9dWVTlVKie9kVwcbNEJy64HFzOcJlWbgPGMfC3m2C6Q8/QSn
         /Xw31vfdd74wLFv1eFgYZDviwC7jBP9ZpbaySZPQxqAsKeKwoBOPiQgd1drm6MH6Rnwr
         UX9J3Gyz1sCf1B+BWf/bAuE9vsmOVJa6kxyu1JUzxOq+tXmo66tLqO6pycHWRkSXhPHY
         Y/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691566968; x=1692171768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhWuye7WtnKHQ5EWBkx1THX5ai7IhNWbpzXM2iw1dpk=;
        b=hkbqhRaIEy9Y/eHwzLLyAuoEs9JvJec11J+/nS59gRROxRH/DTGSSsPh1xxGHO0POR
         f9h28ljzWjvhCxq6O9j2A+jJLhw9NjiC+cMZy1no0xkvm2SZWVp1OBT+IBTInT53o1gx
         JLihKXe7xK5Bp7UiygF3kjQk/Ky8R5EkQkc6x9dNrnsyMeia0XC4KL8G2AhhcYztwwDX
         50a3jnirQUIgTw+cmFKJEYkDAbe5G5GE2pNOW2AKfQN0GzrGcNpms/xaFbKn0LcQl73D
         ZxExp0fOHCNeydJLTzTZWl0HNJ1A6WRsvQIt//Xm+MCWXqcDe6kbZgG9wzqUANdiTt9w
         5zzg==
X-Gm-Message-State: AOJu0YwoLxQqeba4Csv39oHu15UgwglQUyCTAYjfNIGnoYCaKy80WUEe
        P9F+zBgB/xw+6gy40u+UGxxV0xvl8B9Tw38dOVU=
X-Google-Smtp-Source: AGHT+IHJfwkK9RHkJwOOGqO3vtCLBioPrgFXfYIvFUA2dAdkVLRZjpM0YBuZ6DQw75l0m60lwHLIdl9f0Jo42+DSynk=
X-Received: by 2002:a17:907:270d:b0:99d:101b:8403 with SMTP id
 w13-20020a170907270d00b0099d101b8403mr801389ejk.36.1691566968172; Wed, 09 Aug
 2023 00:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230807121432.3970610-1-peng.fan@oss.nxp.com> <20230807121432.3970610-8-peng.fan@oss.nxp.com>
In-Reply-To: <20230807121432.3970610-8-peng.fan@oss.nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 9 Aug 2023 10:42:36 +0300
Message-ID: <CAEnQRZBECPn+JC1PF6hvvroZZBzuVXTU2Zy+Kc_giKsFUFQxVA@mail.gmail.com>
Subject: Re: [PATCH V6 7/8] firmware: imx: scu-irq: enlarge the IMX_SC_IRQ_NUM_GROUP
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 4:11=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Per SCFW update, update the IMX_SC_IRQ_NUM_GROUP to 9.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/imx-scu-irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/im=
x-scu-irq.c
> index 6549f3792a0f..8d902db1daf2 100644
> --- a/drivers/firmware/imx/imx-scu-irq.c
> +++ b/drivers/firmware/imx/imx-scu-irq.c
> @@ -14,7 +14,7 @@
>
>  #define IMX_SC_IRQ_FUNC_ENABLE 1
>  #define IMX_SC_IRQ_FUNC_STATUS 2
> -#define IMX_SC_IRQ_NUM_GROUP   4
> +#define IMX_SC_IRQ_NUM_GROUP   9

This is tricky. Shouldn't we have some sort of versioning so that the user =
knows
that kernel and scfw are not compatible anymore?
