Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438107CB72B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjJPXuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjJPXuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:50:08 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1B392;
        Mon, 16 Oct 2023 16:50:05 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1e9c28f8193so742020fac.1;
        Mon, 16 Oct 2023 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697500205; x=1698105005; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=afy0MXtsD2D0MnkMCMjfUzfom4xI2vJk8/IezA0lkPA=;
        b=lY5wrcHzULZ75Wp8T3L/Qloqq0P9/zq7XFUEJCUgdwfGL0b5dxc/M+VftDmLbJ98rY
         nHmHmCPjr/4HopW6Xco/xLywuJVY58X3XXrcf0oZYYhoC4yvIbBWQXh8i+zxDhSzY4fo
         drE7z03FrzDs/bAcYCYNLu7l5Ju0FSjbLoWZD9oXdPDGaF6XjxOBxodyKX19xgoqzWxC
         mf4XfBIjxtfHBuqVBOR/7EfMhCwZEALZD+oIbGj2tTAcJwf2z3pBonnJ9hGUTVBIzg9Q
         tRU4qfEAbBdEaR6l1bP8Sv1Hwa7qEucYgI97XN5niA1hI8ihfmlfjN76P6ncU01k7Pvm
         YTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697500205; x=1698105005;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afy0MXtsD2D0MnkMCMjfUzfom4xI2vJk8/IezA0lkPA=;
        b=k2VLqiSt9Z+wUDbe3pXeo3zx44JhSzpHbA2FlwtGxvU6rKKm+Oy3D8kzFs/HXJEqFs
         IK2FRX6vPWAyzVU3RnvE/PdWytrDSBBjXXS1Gz8Ts9t3MM1GvCanU2DbtEaiHN3LLKL4
         Lph+JI2fNU/HKudjN/3QZNqDcjxO7G5MkylG/mzRlOLxYnK2Tgvu+YZnK9gNBm9LyCG1
         3SbwJHhimEQI+1JLOgbmtorspgnmquBWlx8hvuq3dPShJRwjUMeOnb9ZCF8NC6L6lgaa
         GjKw4a3sGRrz/i+uErxkVF5HHxjS/O3nJvdhzwlfNs2pIh3MPstEpOVebmaRgBeRZGly
         akqg==
X-Gm-Message-State: AOJu0Ywb/DrpZsFyG8uPsKR7QVA6ZnscFgMzyvGTwfiKFCUPqzgO+L3T
        GZsp5fVGqH8yap2aLJfAP8s=
X-Google-Smtp-Source: AGHT+IF9NDk7vMXYl4HgcoULTLbuUz2pmcjxzd86mfYEhJqbGcJzQ6XJsen27bFhDcH/ydszMmCDCA==
X-Received: by 2002:a05:6870:4d1c:b0:1e9:bbfe:6458 with SMTP id pn28-20020a0568704d1c00b001e9bbfe6458mr721692oab.1.1697500205156;
        Mon, 16 Oct 2023 16:50:05 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id s15-20020a63af4f000000b005b628aa2a8dsm174591pgo.69.2023.10.16.16.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 16:50:04 -0700 (PDT)
Date:   Mon, 16 Oct 2023 16:50:01 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Message-ID: <ZS3MKWlnPqTe8gkq@hoboy.vegasvil.org>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
 <20231009155138.86458-9-kory.maincent@bootlin.com>
 <2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
 <20231010102343.3529e4a7@kmaincent-XPS-13-7390>
 <20231013090020.34e9f125@kernel.org>
 <6ef6418d-6e63-49bd-bcc1-cdc6eb0da2d5@lunn.ch>
 <20231016124134.6b271f07@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231016124134.6b271f07@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 12:41:34PM +0200, Köry Maincent wrote:

> Still I am wondering why hardware timestamping capabilities can be enabled
> without phc.

There is hardware that simply provides time values on frames from a
free running clock, and that clock cannot be read, set, or adjusted.

So the time stamps only relate to other time stamps from the same
device.  That might be used for performance analysis.

Thanks,
Richard
