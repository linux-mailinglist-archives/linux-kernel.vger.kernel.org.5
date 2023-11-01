Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AF37DE4E2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344267AbjKAQzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKAQzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:55:06 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57507FD;
        Wed,  1 Nov 2023 09:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=uRia4cZK0HeSMeK6jPeNFLxgVj3O+ilb8mVwJsKRUHs=; b=lokuY4XvzNt/boNaj0aIXwFkPA
        rk25+FMrQwyt4JGcGkEz0ES3KIdjkwOWg00D4+FrroqkoIC7+feeto8zgMPjME/XzUgV0rx8WyEyj
        hNBxUcvXrlAbgi0YMRsiMaqSAdtZf1+FoRwd9xZZiQKLjE7AGH4FeqlFfQ03Fwmwhmhg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qyEUU-000hEa-IB; Wed, 01 Nov 2023 17:54:50 +0100
Date:   Wed, 1 Nov 2023 17:54:50 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robimarko@gmail.com>
Subject: Re: [net-next PATCH v2 1/2] net: phy: aquantia: add firmware load
 support
Message-ID: <c9dad91a-1de1-4c30-ab7f-414552702009@lunn.ch>
References: <20231101123608.11157-1-ansuelsmth@gmail.com>
 <4b536ad3-2112-4f28-90e4-586b5745be20@lunn.ch>
 <65427400.5d0a0220.41c58.0ded@mx.google.com>
 <34a0b76e-aa0e-4148-ba01-c3b4608f17f7@lunn.ch>
 <65427fd4.df0a0220.28d26.1955@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65427fd4.df0a0220.28d26.1955@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There are plenty of firmware around so it can be checked by from what I
> have, it looks like they are word aligned... Ok I will use the
> get_unaligned and add a comment saying that we assume the iram and dram
> section are always word aligned.

We probably want to know if there is firmware out there which is not
word aligned. So i would probably do phydev_err() and return -EINVAL.

     Andrew
