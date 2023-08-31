Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511AE78F28B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347005AbjHaSZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjHaSZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:25:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F72E5F;
        Thu, 31 Aug 2023 11:25:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BC19ACE2168;
        Thu, 31 Aug 2023 18:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6EDC433C8;
        Thu, 31 Aug 2023 18:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693506335;
        bh=HX+LsS71C3YAX9zxZxNXGCOSH6tcuNhHV+Qq0DsTkRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sIcWQLiiJEmqNg1U8AU/O/skuvuq3R3SqjMyRMDeuPLE05ii9AuKe2zi4eXPK8AAZ
         Lb0X7wnGImFPjMSNy6GhWcMFUz5DPWGsdVzSSkhYEbMltSaeRL30sRnQi6wcB4v/B2
         ZgSxIpbCGIScfcKgoyfRrYH5rZLkDYLQj8F6ApeGCURUmtFbdDp8LRTmJUzPOFCMCN
         G1hB7gF+KmgsCrQPtWk7NKA2wK3U0/UYFSIM6dOabodpZEj70ggjIGjLwMx7aUQkZa
         OzjrWNkQWa7+APPkbW3z/ESF1k9bsapb+9Mq+cEzDodsiyue0WnHVUrvVRPmjTTNHJ
         zrUelRhJkl2QA==
Received: (nullmailer pid 2548329 invoked by uid 1000);
        Thu, 31 Aug 2023 18:25:32 -0000
Date:   Thu, 31 Aug 2023 13:25:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        aford@beaconembedded.com, marex@denx.de,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH V3 3/3] clk: imx8mp: Remove non-existent
 IMX8MP_CLK_AUDIOMIX_PDM_ROOT
Message-ID: <169350633203.2548268.6713389438245540707.robh@kernel.org>
References: <20230831044431.250338-1-aford173@gmail.com>
 <20230831044431.250338-3-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831044431.250338-3-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Aug 2023 23:44:31 -0500, Adam Ford wrote:
> The TRM shows there is only one AUDIOMIX PDM Root Clock Select
> register, and it's called IMX8MP_CLK_AUDIOMIX_PDM_SEL.  That
> selector doesn't appear to have any more children and the
> MICFIL driver can reference IMX8MP_CLK_AUDIOMIX_PDM_SEL
> directly without the need for any other.  Remove this
> errant clock, since it doesn't really exist.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> 
> V3:  New to series

Acked-by: Rob Herring <robh@kernel.org>

