Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496027A968A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjIURFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjIURFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:05:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD803594;
        Thu, 21 Sep 2023 10:03:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09295C611A1;
        Thu, 21 Sep 2023 16:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695313466;
        bh=hpue0sB74rS4F/criJlPgC2g4ffost9T7IkqkvG5o7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MW1t3p6kmhqAnz3ktOUjYfePzkbrS8bYgELu1FgpNLdcvPH0EXT7frDVB+0wLM8Ar
         TgU4d09o+oc5yn9Hem87L8fDUGdeZ+ffDr8ou91ViZlt8MuU599+KordOEBkonrN00
         agkAaYF1ivB68+Dw+3HoMcZAXNoFTKovfovaQupnjKesckbwHO2foL12N61Ar3SSC6
         LfSaoJWRPYE0elOWIWzsn30yFPdI7l90uuls0e0zNi/p6nONq/Whs+u63LlPNaIB6m
         aqiGcs1Rkg5UpuUWi9rPDGEbihWrdLQpmy6hIlPtsKfVPZOIa1rGCCcI6Sa5PrBDmY
         Takmdaw9N1Zlg==
Received: (nullmailer pid 441560 invoked by uid 1000);
        Thu, 21 Sep 2023 16:24:24 -0000
Date:   Thu, 21 Sep 2023 11:24:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        hvilleneuve@dimonoff.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: sc16is7xx: add vendor prefix to
 irda-mode-ports property
Message-ID: <20230921162424.GA435508-robh@kernel.org>
References: <20230920152015.1376838-1-hugo@hugovil.com>
 <20230920152015.1376838-4-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920152015.1376838-4-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 11:20:14AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The NXP-specific "irda-mode-ports" property lacks a proper vendor
> prefix. Add "nxp," prefix to comply with DT best practises.

The opposite direction would be worth carrying in the driver, but I 
don't think adding a vendor prefix is. I would just leave this as-is.

Rob
