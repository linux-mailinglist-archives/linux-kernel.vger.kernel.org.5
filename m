Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CB27F3A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjKUXko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjKUXkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:40:42 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D93AD1;
        Tue, 21 Nov 2023 15:40:39 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc703d2633so12361985ad.0;
        Tue, 21 Nov 2023 15:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700610039; x=1701214839; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MOHSQX7ZL42y7X9VBdiGccX+MZ48VMsvFXhqB/qEHb4=;
        b=JkTSUQxGueyS6QrPVhKAqx3r7Us23KiwVCjSELh3DixoYXZBZrBt3e8RoP+YIBdrQc
         bUNOT3r/KS7xQ0UNiv41ovnTGcrud+1j4kJdBJMq64Z/rI9ABOuT+33hBtC2xRE89cLJ
         kgHVejgUD6e1NcJhuRvif096mDYoF4YedLU4dqa40k+Hh5vzyXOdOSIYjNib1fzQHCRT
         Sd12jxKofgh0Fgu3GiaXYYhqDQXAsM9/vTjBhGSMInNsA+ZDOZIl6D1xeG3EYpddqC/E
         qqeWZwMA2xybq8BaS/50/ztgEcq7RnUzIG+FoFUAd851JYEdFZM4RKuAAEkWkCLoMqlO
         gAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700610039; x=1701214839;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOHSQX7ZL42y7X9VBdiGccX+MZ48VMsvFXhqB/qEHb4=;
        b=rZq58VaVXh73/fwrgqZ6kqemkKKIvqjetwtkIkUenEFBEtECSZaouSM+u5RYRNLQks
         NhZCeRktkjYVCZjNOPh7kg6OcBD1qt+3ti5bD2Uv7w/wHzL7dASObq1iasn8zWoLmZD6
         +Yd8YslRKjAfxQWrEYdsfXjKtingdxHb0zvnSHYd0gc45+2VsCiU/wrYALVNj+GBD/tq
         9FDhbtw+YzDMzoSQfpdo+1mjw+3v/lh+Ygw9umIK6YRX5Eg/xu+4VNQQ1ZWqqgZ7BCZV
         aRu47/o+Zq7a4WjYTgso+HfBbczYhAeHh/xOtZfKa8nFpve6rFKcn+Fo53pkTNNowQBd
         KBSw==
X-Gm-Message-State: AOJu0YyAD1t44673OF99bfFTmxRqRSzHUtFFW2gi9F+uFqY/60BM1uaI
        Q+M8BF8xft3bT0Savc2c+/4=
X-Google-Smtp-Source: AGHT+IH/PfQdSm90OYQN0ARLJlgkZNz6Bi7j4vUF9qz7A8OfeISjFqEzImYQMUy16f/Je4z2J9rBhg==
X-Received: by 2002:a05:6a20:428e:b0:18a:716d:4d4 with SMTP id o14-20020a056a20428e00b0018a716d04d4mr608015pzj.6.1700610038565;
        Tue, 21 Nov 2023 15:40:38 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id o14-20020a056a001b4e00b006c33bf9905fsm8456943pfv.25.2023.11.21.15.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 15:40:38 -0800 (PST)
Date:   Tue, 21 Nov 2023 15:40:34 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <ZV0_8oOaHarW4rMQ@hoboy.vegasvil.org>
References: <20231120120601.ondrhbkqpnaozl2q@skbuf>
 <20231120144929.3375317e@kmaincent-XPS-13-7390>
 <20231120142316.d2emoaqeej2pg4s3@skbuf>
 <20231120093723.4d88fb2a@kernel.org>
 <20231120190023.ymog4yb2hcydhmua@skbuf>
 <20231120115839.74ee5492@kernel.org>
 <20231120211759.j5uvijsrgt2jqtwx@skbuf>
 <20231120133737.70dde657@kernel.org>
 <20231120220549.cvsz2ni3wj7mcukh@skbuf>
 <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 06:31:14PM +0100, Köry Maincent wrote:
> If I summarize, a solution could be this:
> 
> - Expand struct hwtstamp_config with a phc_index member for the SIOCG/SHWTSTAMP
>   commands.
>   To keep backward compatibility if phc_index is not set in the hwtstamp_config
>   data from userspace use the default hwtstamp (the default being selected as
>   done in my patch series).
>   Is this possible, would it breaks things?

You can't "expand" hwtstamp_config because it is an established ABI.

(You could introduce SIOC[GS]HWTSTAMP_2 with an expanded layout)

Thanks,
Richard
