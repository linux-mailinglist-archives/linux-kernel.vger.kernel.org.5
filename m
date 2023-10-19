Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA22D7CFD2E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345822AbjJSOsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjJSOsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:48:45 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7D1130;
        Thu, 19 Oct 2023 07:48:42 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-4587f9051e3so596151137.0;
        Thu, 19 Oct 2023 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697726921; x=1698331721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b30rUo9xIidkzyjBtbhasOWY/ZbF9XIuRRAYaEaFhXU=;
        b=CCFevrp3P7+zJ4FHC9QfN+qXJiLe1qBRNDg8HVSZBpk6gggPWwoP5PzFsx2NRApNlB
         OJcQoKwMtHZZYDKCQis+FsXb3P0lnqwQ/QEHpi3dvDRLHg/besvVP45PwUroVhw52K5u
         QDXCIJd1lL/++Pj11CNu+NkBAwp8xDZRILgiDJgEm89LnhT4m08UwMJzBQXWtlQfLbvT
         ckKGQTYkzK2nFu7RNd7TG38quijkUBhosu5xOyyCL8Q5FtEPkZCjukIFnSQ5nhGlLmpm
         GwVRO4e3AMs0hO+bu3vyTavC7beosYXyd+E1iSvFLvyXLDP90XWH0EWzlu4WQym7BVfa
         wTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726921; x=1698331721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b30rUo9xIidkzyjBtbhasOWY/ZbF9XIuRRAYaEaFhXU=;
        b=XMe7fxQ88jbxaAv/6aJJGwiD8/O2VJ2OU/VubpmoGnD9p1h6H6My3RX5k/Z+SzmLmo
         bdC/q8Bg30UxDGq8QwJuPcjP2xnm5Ob2zd5x1dvuwp9xFqZAPTgZPmydSTm5W0O+rks5
         RX8Y+T+FjAzAnrXlPT7mroE9shXcU4m8gHUCg+ztDdZRgC2IhFzNVpbPL9XPyGaLqdxU
         GmA5cpz53vPOzAUVWhlbZme15EW7sc187hWKfG30NCfZ/LBqYsyk5PJCrGb6t1fu4oz7
         9BqiE1yb2E5Ub83jYVwViZeAELWLMTqk24iQw7OZ6dqVIpJnsK7jqrlKUXiUxU7EhtDl
         HBHQ==
X-Gm-Message-State: AOJu0Yz+TCr7b4kFTDjN9K5OLUUqZtHjGagNKnQLTXzHy10EieZirT3u
        zSeaS9M3+6YJCmzkhP7LMqCV1rasAELgHYevyBs=
X-Google-Smtp-Source: AGHT+IHfKG6TgpivWYvKVUQ/ejBTh+LvTGzFACYFJt5iSwJHvTy53oC3RG9tprM79RoBpo6FxpZwZsUoCzx5dkH7zs4=
X-Received: by 2002:a05:6102:100a:b0:457:6999:968a with SMTP id
 q10-20020a056102100a00b004576999968amr2145047vsp.7.1697726921465; Thu, 19 Oct
 2023 07:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231019-feature_ptp_netnext-v6-0-71affc27b0e5@bootlin.com> <20231019-feature_ptp_netnext-v6-7-71affc27b0e5@bootlin.com>
In-Reply-To: <20231019-feature_ptp_netnext-v6-7-71affc27b0e5@bootlin.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 19 Oct 2023 10:48:04 -0400
Message-ID: <CAF=yD-+O6QxuYJzijMes7J_DHHd7yYCz8sBLFERM1U6pYN0Gkg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/16] net_tstamp: Add TIMESTAMPING SOFTWARE
 and HARDWARE mask
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
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

On Thu, Oct 19, 2023 at 10:29=E2=80=AFAM Kory Maincent
<kory.maincent@bootlin.com> wrote:
>
> Timestamping software or hardware flags are often used as a group,
> therefore adding these masks will easier future use.

This assumes that device support for timestamping is often symmetric:
a device supports both rx and tx, or neither.

All devices support software receive timestamping, as that timestamp
is taken in the core network stack. But to support transmit timestamps
drivers have to call sbk_tstamp_tx in their ndo_start_xmit.

For hardware timestamping it may be more common to support both or
neither, not sure.

> I did not use SOF_TIMESTAMPING_SYS_HARDWARE flag as it is deprecated and
> not use at all.
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  include/uapi/linux/net_tstamp.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tst=
amp.h
> index a2c66b3d7f0f..df8091998c8d 100644
> --- a/include/uapi/linux/net_tstamp.h
> +++ b/include/uapi/linux/net_tstamp.h
> @@ -48,6 +48,14 @@ enum {
>                                          SOF_TIMESTAMPING_TX_SCHED | \
>                                          SOF_TIMESTAMPING_TX_ACK)
>
> +#define SOF_TIMESTAMPING_SOFTWARE_MASK (SOF_TIMESTAMPING_RX_SOFTWARE | \
> +                                        SOF_TIMESTAMPING_TX_SOFTWARE | \
> +                                        SOF_TIMESTAMPING_SOFTWARE)
> +
> +#define SOF_TIMESTAMPING_HARDWARE_MASK (SOF_TIMESTAMPING_RX_HARDWARE | \
> +                                        SOF_TIMESTAMPING_TX_HARDWARE | \
> +                                        SOF_TIMESTAMPING_RAW_HARDWARE)
> +
>  /**
>   * struct so_timestamping - SO_TIMESTAMPING parameter
>   *
>
> --
> 2.25.1
>
