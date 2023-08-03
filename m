Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DE876EDD1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbjHCPRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbjHCPRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:17:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6003CE75;
        Thu,  3 Aug 2023 08:17:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E847A61DF3;
        Thu,  3 Aug 2023 15:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A334BC433C8;
        Thu,  3 Aug 2023 15:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691075825;
        bh=LNlFY8r0rZ0GR1yOKg9X0+pzM4ebRtAw7S93DLMNDwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fd+kbFpuW4Nw3RZmyDiTaptdo5jcre+w5/5LkJpXMrj8+2+9EWTgtsXCVTeesQfBA
         lbvEaWr4jwNb54qE4I642udRoZf33ic0WxMHqbtENr969acnlOKblUSAIWWbqMKQ5R
         RQusVCsXUtC5dia1TgEwo9GxFh89HWvDOA79sllcQLWwKBg75iAQlAE2x+72L5cNUc
         28x+lxRj048TqTtOWvCUIKY/Md57whq1B54XxhQTTa8b4xQKt1uIAh/5Gbz2WfVS1m
         rzXuL2nWOch03zQejFWi2kdHZkgtXyC2UYPenzsBqr0zo6yINasUyNQx0t3XiO2XmS
         0eG+tDCpR2uYQ==
Date:   Thu, 3 Aug 2023 17:16:59 +0200
From:   Simon Horman <horms@kernel.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] net: ti: icss-iep: Add IEP driver
Message-ID: <ZMvE63ooNyoRZK/y@kernel.org>
References: <20230803110153.3309577-1-danishanwar@ti.com>
 <20230803110153.3309577-3-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803110153.3309577-3-danishanwar@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 04:31:51PM +0530, MD Danish Anwar wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> Add a driver for Industrial Ethernet Peripheral (IEP) block of PRUSS to
> support timestamping of ethernet packets and thus support PTP and PPS
> for PRU ethernet ports.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

...

> +static int icss_iep_pps_enable(struct icss_iep *iep, int on)
> +{
> +	int ret = 0;
> +	struct timespec64 ts;
> +	struct ptp_clock_request rq;
> +	unsigned long flags;
> +	u64 ns;

For networking code, please arrange local variables in reverse xmas tree
order - longest line to shortest.

https://github.com/ecree-solarflare/xmastree is your friend here.

...
