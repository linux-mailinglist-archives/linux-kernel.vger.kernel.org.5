Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDB57D0027
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345199AbjJSRF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345614AbjJSRF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:05:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1100612D;
        Thu, 19 Oct 2023 10:05:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9bdf5829000so1010043566b.0;
        Thu, 19 Oct 2023 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697735122; x=1698339922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bveSVA+HFDA8Wqrpoim/LrAEl8uS+yqVoMbn6rwNYss=;
        b=HlVlFh1lvj+dT2xpPkUzq4AdgCXTjn+prEyOFLx0B6f3UfHz0n202HCtrS2ydVt0b8
         mirGv/RBMdy69V2uFVqNfli3QVjoAbRKH3QQ9yvbZFh0TYBQwgRHIbM6L8ZkqK6gKFxO
         sI6U12njP6/A58P/NFd/8ELHelLzeMzN57+W30//Kn9CwjfMBVdnEJXBMqF7hl3hSOij
         c2XoRiFM0BMuv1VE0MSleqGrJEIfhlgj5G4DHsiLY+8E1ESMbri+spEZzHCuR5qF/TBw
         CKCWkyo7jk++iZJeLlIae38Gybh4MrlTya37T8Lw/z92/iTsHyRDe3UIYlBO+ORIO9xF
         E6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697735122; x=1698339922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bveSVA+HFDA8Wqrpoim/LrAEl8uS+yqVoMbn6rwNYss=;
        b=ukRXz/Azd/FOCzpaSG+KXif8oUWPiR1zYjyUwYSoBH/Bos6oeNA91y8uzJAuLcu+si
         YWRyTrN+mR1M2BxqrkRXNMfAbWVNxDfS7gFaV1W/jfI+kIM3WoZhgUUt3K1BDs4SywbL
         6dd3QnqxNErHMbHAruchOxlHl+mZDLcVrL/c9zwCy0Ge/c8+deACCe4mxoMft+Y39paA
         ErNxfuCW/+0wt/U+Zi0/it73qL9sHxztO+MPLI4oJnBFn/nYJZT5Zng1zPxlQI7TqRGQ
         KRy1irzqTyrq7jqJnizxzPsmyOdTw++g7gfvZ46z6nqgo3/29xS7gWhqIzngGl9vvEpe
         oIdg==
X-Gm-Message-State: AOJu0YzJUj6j5j0otj1dh6icAN3xGcYYGpETEg02aoXxE9SaQdLDhNXX
        Zs6Np6s/Lg8kgx2v7bRNnSM=
X-Google-Smtp-Source: AGHT+IFUP+9w2s21EXX2dFd9XByPLS5jZCcAR6p1QJThCOs445IfVJcfeU2Jhkj4TKigivsQH/rIow==
X-Received: by 2002:a17:907:7b8f:b0:9bf:b8f7:1fa8 with SMTP id ne15-20020a1709077b8f00b009bfb8f71fa8mr2398496ejc.76.1697735122415;
        Thu, 19 Oct 2023 10:05:22 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id lz21-20020a170906fb1500b009ad829ed144sm3818101ejb.130.2023.10.19.10.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 10:05:22 -0700 (PDT)
Date:   Thu, 19 Oct 2023 20:05:19 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add missing MAC
 address register offset for ksz8863
Message-ID: <20231019170519.bfoqhelgbm2w63hn@skbuf>
References: <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019122850.1199821-2-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 02:28:42PM +0200, Oleksij Rempel wrote:
> Add the missing offset for the global MAC address register
> (REG_SW_MAC_ADDR) for the ksz8863 family of switches.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
