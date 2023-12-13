Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CDE8112D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjLMN0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbjLMN0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:26:42 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2764EB;
        Wed, 13 Dec 2023 05:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ZJVFEQtf1RlYavde8GnHeSGwhOHPUeHDQCpuIu2hLTE=; b=bOZjT7TL6qLOKBeEou7JtxyikH
        rrtrKNFMBgyjiLY2KVdWmq7wiRAoXD6v0YqoMsA9Z4x+gPGqNEqDtBBDFDnx4HkBkOdf3wmr80Juj
        eBCSjOUbI+wWbeXlbwBYbUbh50sbkVgX/vQ2O+GTZk/WeBwCkl25sjxnvS7vvSK8wWMc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rDPG6-002p2m-Q3; Wed, 13 Dec 2023 14:26:42 +0100
Date:   Wed, 13 Dec 2023 14:26:42 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>, srk@ti.com,
        r-gunasekaran@ti.com, afd@ti.com
Subject: Re: [PATCH v2 2/3] arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet
 support
Message-ID: <1a2aba0c-5c4d-4258-b89c-b1be4593d7ff@lunn.ch>
References: <20231212165832.3933335-1-danishanwar@ti.com>
 <20231212165832.3933335-3-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212165832.3933335-3-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 10:28:31PM +0530, MD Danish Anwar wrote:
> ICSSG1 provides dual Gigabit Ethernet support with proper FW loaded.
> 
> The ICSSG1 MII0 (RGMII1) has DP83869 PHY attached to it. The ICSSG1 shares
> MII1 (RGMII2) PHY DP83869 with CPSW3g and it's assigned by default to
> CPSW3g. The MDIO access to MII1 (RGMII2) PHY DP83869 is controlled by MDIO
> bus switch and also assigned to CPSW3g. Therefore the ICSSG1 MII1 (RGMII2)
> port is kept disable and ICSSG1 is enabled in single MAC mode by
> default.

FYI

I want to review all this MII muxing, but it won't be today.

  Andrew
