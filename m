Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517A37A20C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbjIOOW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjIOOW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:22:57 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5951AC;
        Fri, 15 Sep 2023 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:From:Sender:Reply-To:Subject:Date:
        Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=1yldzElETnKeG++jsfq4NDMKuUjbp7vxfG0LMRVCp+g=; b=gC4Y5GJ0aa3btSElsa7kth3hsR
        Imj4jo7cfSaCOxWwacFJtO0H3jCEEism5QMuYcKyRLmBb0oqzdZdMjyodqdEW9wgprGVJqA8kcsIR
        Yq7PcDp/9EmKpZsmluS23ulfsem7FOqamfTpw12+A3YghxYaLIUace+RMYWKE4F2qjpA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qh9iP-006YAD-9H; Fri, 15 Sep 2023 16:22:37 +0200
Date:   Fri, 15 Sep 2023 16:22:37 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, steen.hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: Re: [RFC PATCH net-next 0/6] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Message-ID: <ac528d48-44f9-4717-a61d-35365a11de78@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230915-wizard-junction-b58f2aad64c5@ifak-system.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915-wizard-junction-b58f2aad64c5@ifak-system.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 03:56:59PM +0200, Alexander Dahl wrote:
> Hello,
> 
> this is interesting, by chance I just looked at a chip claiming
> similar features today, which already has a driver in kernel: Analog
> Devices ADIN1110.

Ah, interesting. I had no idea this driver/device is an OA TC6 device.

So ideally, we want the adin1110.c to also use the new framework, and
remove the duplicate code. Parthiban, please look at the driver and
make sure the APIs are such that Alexandru Tachici can swap his driver
to using it. Having two implementations should help make it clear what
is the same and what is different.

   Andrew
