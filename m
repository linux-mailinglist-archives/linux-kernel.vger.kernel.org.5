Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2D17AA4BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjIUWQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjIUWPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:15:30 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC635AF97E;
        Thu, 21 Sep 2023 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=PZoJibFgab/vN9GIaKJ3/1GHrki3dxSUD2jY1bTI4vI=; b=eRFcMdCA9qvR+q+a9CgGajuBM1
        95+mHIxZFcop86v4Bg58gAHW33MUSAy/zRn/p0eTplitvq5yj70/F/Pbsg8ygMu8au1nuM6c4PWvO
        2BPmXQe/3KXMYrV0CkO924pf+xQkdU4T1T6CfMnA/ZH6x4qEKhQrU+MX5omAYqLc2OyQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qjMFe-0076Ut-Gt; Thu, 21 Sep 2023 18:10:02 +0200
Date:   Thu, 21 Sep 2023 18:10:02 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        afd@ti.com, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srk@ti.com, r-gunasekaran@ti.com
Subject: Re: [PATCH v2 2/4] arm64: dts: ti: k3-am654-base-board: add ICSSG2
 Ethernet support
Message-ID: <bdb60c9f-467e-4960-b516-9d79f43544ed@lunn.ch>
References: <20230921060913.721336-1-danishanwar@ti.com>
 <20230921060913.721336-3-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921060913.721336-3-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* Dual Ethernet application node on PRU-ICSSG2 */

How relevant is "Dual Ethernet" here? You are talking of adding
switchdev support, and runtime swapping the application. All these
properties should be valid for the switch application as well?

In fact, you are describing hardware here, so the application should
not actually matter.

So maybe this comment should be:

Ethernet node on PRU-ICSSG2

	Andrew
