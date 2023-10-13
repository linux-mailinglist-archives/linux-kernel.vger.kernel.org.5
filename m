Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0737C879F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjJMOP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjJMOPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:15:55 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33460BE;
        Fri, 13 Oct 2023 07:15:54 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1e9b6f39f9eso1197150fac.2;
        Fri, 13 Oct 2023 07:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697206553; x=1697811353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWktuGQwxmwZJubko50gUdVMFbWvuig15BInW1UTJYk=;
        b=Bfh83ISr0+vdfdUm1gysBcNS6BUYsq20//N/glC+KXUDpJPt4B9ifUjcX/tPsJMacp
         LCo3fZTiQOW8MFMHU/C3C8Ac7I6lNYU82LCjHMc0+82R8oipTUj4cUkxa33sWJnz+1JR
         Vhw1DBZXS9f6gP9H0mcOnWKZFezT0xzGJHXNj9KIM7qxB+JqvA1naQY4eFzGVklXwZ5V
         lV/RDhkxIDWUGuSJB6fCufFAAMWI4pRCN/qW8XlinH9PuITwlNF+Yl6AmIVT9x73lB9/
         3Y5bghFScxVwG0jaUThx9Sqe5rqoUDprKdoSZw1kg3APSaiE/7oLzxQ/MXrwd0mX1yVq
         HnLA==
X-Gm-Message-State: AOJu0Yzl28DAVTxKE1EXTEFwaskdb8fP4RPuPmObzguh5ZfVhDyslKlI
        8gOV0WdDcLPjChOK2Zhqsw==
X-Google-Smtp-Source: AGHT+IFxQ6Zt5gCf5x+LGxJcKIwPPoG64aRzLo+7gULbdh7i3h7BT4YN86VADnpDVoYme923pO6XMQ==
X-Received: by 2002:a05:6870:898c:b0:1d7:1533:6869 with SMTP id f12-20020a056870898c00b001d715336869mr31544207oaq.31.1697206553415;
        Fri, 13 Oct 2023 07:15:53 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dt1-20020a0568705a8100b001e12bb81363sm785920oab.35.2023.10.13.07.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:15:52 -0700 (PDT)
Received: (nullmailer pid 3800246 invoked by uid 1000);
        Fri, 13 Oct 2023 14:15:50 -0000
Date:   Fri, 13 Oct 2023 09:15:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] RFC: net: dsa: mv88e6xxx: Register mdio-external
Message-ID: <20231013141550.GA3793553-robh@kernel.org>
References: <20231013-marvell-88e6152-wan-led-v1-0-0712ba99857c@linaro.org>
 <20231013-marvell-88e6152-wan-led-v1-3-0712ba99857c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013-marvell-88e6152-wan-led-v1-3-0712ba99857c@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 12:35:16AM +0200, Linus Walleij wrote:
> Make it legal to have a subnode just named "mdio-external"
> and have that be recognized immediately as the external
> MDIO bus, register it and return. Only fallback to the
> old method with a compatible in the external bus node
> if this doesn't work.
> 
> This is the result of deprecating the old DT method
> of providing a node "mdio1" with a compatible string.

I think this is the wrong direction. Using compatible is much better 
than relying on node names. We've been "fixing" node names precisely 
because they are usually not ABI.

Rob
