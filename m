Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1B67A99F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjIUSep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjIUSed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:34:33 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F16AAF976;
        Thu, 21 Sep 2023 11:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=H0wDWGM/2PBIbk/yXbAOjYkvlXpuBN14KtZzTicg7Ms=; b=T9l7Wlkzjg1dnAjRsTuSln5NmA
        Bar1e75HbYp3F8T+58G5qIwVYIKi3U0u+k5HEbjVloOlAzzo8D9Oql8vgUxAt4fnK2ERnDOoPFOTH
        vhNQpssCvxDQ6NlfonCuO0Rk5xyhZi8z/hTluRa0p2CBxn0NJd2N/dhtCasD+FcPB19w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qjMKC-0076Vj-W7; Thu, 21 Sep 2023 18:14:44 +0200
Date:   Thu, 21 Sep 2023 18:14:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        afd@ti.com, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srk@ti.com, r-gunasekaran@ti.com
Subject: Re: [PATCH v2 3/4] arm64: dts: ti: k3-am654-idk: Add ICSSG Ethernet
 ports
Message-ID: <a39316d6-8804-4dc4-b5d8-a2dfd82b972e@lunn.ch>
References: <20230921060913.721336-1-danishanwar@ti.com>
 <20230921060913.721336-4-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921060913.721336-4-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* Dual Ethernet application node on PRU-ICSSG0 */
> +	/* Dual Ethernet application node on PRU-ICSSG1 */

Not relevant to this patch, but to the ongoing discussions around
adding switchdev support.

Are these two PRU-ICSSG instances completely separate? It is
physically impossible to combine these four ethernet ports in one
acceleration domain? It will always be two separate switches, and if
frames need to go from one switch to the other it happens in software?

       Andrew
