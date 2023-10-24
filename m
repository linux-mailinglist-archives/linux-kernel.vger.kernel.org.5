Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDC47D5426
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343497AbjJXOfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjJXOfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:35:07 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AA912B;
        Tue, 24 Oct 2023 07:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=60bjIo94UkHE2CZZn3CoER1KB39T3WL/vpJfYuOAqwM=; b=dSonHfyUX22aEeD4r9NWDM83y6
        CUq0iRwLH/Hd8pErD2rrfDql/Ha+0XsucIQd/B7voadR9dZA0XJyGjUd/t6UTSLINycD15KQWIh56
        rqGerXXI9zUt22KPbxB0H64yH609c0DBdHpHSin0YUQ2D/9Y5YbxXEhwegmi1bNFRiJk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qvIUl-00056D-AO; Tue, 24 Oct 2023 16:34:59 +0200
Date:   Tue, 24 Oct 2023 16:34:59 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Elad Nachman <enachman@marvell.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, pali@kernel.org,
        mrkiko.rs@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: cn913x: add device trees for COM Express
 boards
Message-ID: <83c5d62a-0ec8-423a-b779-62437f5fca6a@lunn.ch>
References: <20231024131935.2567969-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024131935.2567969-1-enachman@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 04:19:35PM +0300, Elad Nachman wrote:
> Add support for CN9130 and CN9131 COM Express Type 7 CPU module boards
> by Marvell.

So these are modules, which plug into a carrier. Its a SOM.

Then this should be split into a DTSI file for all the things on the
SOM, and a DTS file for the carrier. You want somebody to take the SOM
and put it on their own custom carrier, which will have its on DTS
description but reuse the DTSI file.

	Andrew

