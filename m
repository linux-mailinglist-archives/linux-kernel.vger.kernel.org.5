Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C65079D49B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbjILPRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbjILPRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:17:04 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC86E12E;
        Tue, 12 Sep 2023 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=jFPJPtOQiBv3IhWxAw0Q5iM0GxNxlqc2wIPcTSRUyiE=; b=J9WfzMRk7vtrOBv9/ivNmDv7cW
        LnyjxkV9J9oSuK2UzkbrQ8iAWQBeVu4BuJ7fqQ8/FD++F+kAo4aYplVrw5IjeZzHiLHPguQTYg4Pm
        eXI9hkGCEwtYU9uTYzkRjiOLFlElYlA88AqqvbgHoaN6l7Cy8r+Dn8SI8JVUB1pYtBQo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qg588-006F0K-0q; Tue, 12 Sep 2023 17:16:44 +0200
Date:   Tue, 12 Sep 2023 17:16:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
        r-gunasekaran@ti.com, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: Add documentation for
 Half duplex support.
Message-ID: <90b3e6cc-7246-4d02-bd0f-2ce7847bc261@lunn.ch>
References: <20230911060200.2164771-1-danishanwar@ti.com>
 <20230911060200.2164771-2-danishanwar@ti.com>
 <20230911164628.GA1295856-robh@kernel.org>
 <0c23d883-0a79-ee7c-332c-c6580f8691df@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c23d883-0a79-ee7c-332c-c6580f8691df@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sure Rob, I will change the description to below.
> 
>     description:
>       Indicates that the PHY output pin (COL) is routed to ICSSG GPIO

The PHY has multiple output pins, so i would not put COL in brackets,
but make it explicit which pin you are referring to.

>       pin (PRGx_PRU0/1_GPIO10) as input and ICSSG MII port is capable
>       of half duplex operations.

"input and so the ICSSG MII port is"

       Andrew
