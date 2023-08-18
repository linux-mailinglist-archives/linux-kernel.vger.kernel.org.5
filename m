Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B08A7814A3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240554AbjHRVQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240938AbjHRVQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:16:17 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DD34216;
        Fri, 18 Aug 2023 14:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=rL+yCFTqPV6vMaMpVLPjexEK3wO35JlGcBYvNLZoT7E=; b=jbDWgCkIrMUikDz6bhEugXcErF
        mMyjF2iydXoHmA1pHiydHiNm+ju+V7seWdcM+o2OVUSrgoUxUoadMNDdMNS863H9otR0RS7jg5MV3
        QHQgCbfM/Axwev5MO1wxXUlYK4Mnh+6wsgISKfpOeK8MI4VGDTSmkvNcBN8P2E8JHHnw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qX6p5-004XJU-Io; Fri, 18 Aug 2023 23:15:59 +0200
Date:   Fri, 18 Aug 2023 23:15:59 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] net: hpe: Add GXP UMAC Driver
Message-ID: <1b8058e1-6e7f-4a4a-a191-09a9b8010e0a@lunn.ch>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-5-nick.hawkins@hpe.com>
 <01e96219-4f0c-4259-9398-bc2e6bc1794f@lunn.ch>
 <88B3833C-19FB-4E4C-A398-E7EF3143ED02@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88B3833C-19FB-4E4C-A398-E7EF3143ED02@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Would this be the #include <linux/dmapool.h> library?

<include/net/page_pool/helpers.h>

Take a look at driver/net/ethernet/freescale/fec_main.c That
driver/device is of similar complexity to yours. It had a recent
change from its own buffer management to page pool. It
started with

commit 95698ff6177b5f1f13f251da60e7348413046ae4
Author: Shenwei Wang <shenwei.wang@nxp.com>
Date:   Fri Sep 30 15:44:27 2022 -0500

    net: fec: using page pool to manage RX buffers

but there are additional patches later.

    Andrew
