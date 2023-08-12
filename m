Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8CD779C6F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 04:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbjHLCAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 22:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjHLCAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 22:00:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E31E30F8;
        Fri, 11 Aug 2023 19:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D80D76108A;
        Sat, 12 Aug 2023 02:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722E9C433C7;
        Sat, 12 Aug 2023 02:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691805653;
        bh=rNbl8qxbyJJcKxmVj7kxuK0nzZioJI2hGiYbGM61zQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kpocs/H9CJKF2NIY81ejYcjI3FyWLvo2eNHu+hqrsI4WayaknSOGD+0/wbMXI/+PQ
         JBcp3uBd/v0WtZR0B7Q1SMGlhv36uMAJ3Jj3EXytpM5F+vWE6zyaEcRas5N9xB+pK1
         dojO9jHO/YAkxSqDT6/FSLEloXuLXSz02OPI98kPKgB6kZ4bmyPwXzMDEeLX3voAIo
         JddhPjW2XiKgeGf3mbiNecQR7sn5nxO8YHG0yXjLI/9xyfaJbtxwYhjy9KlXD27n1e
         Usg9uT/6X46R5ilzsv5Rnd/JM6WkSdcPcoMigIhVt09xdcRxoSHr4krhDwItA5NIDM
         +8zhpQV2vv/hA==
Date:   Sat, 12 Aug 2023 10:00:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        kernel@puri.sm, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        David Heidelberg <david@ixit.cz>,
        Sherry Sun <sherry.sun@nxp.com>
Subject: Re: [PATCH v2 2/4] arm64: dts: imx8mq-librem5-devkit: Mark buck2 as
 always on
Message-ID: <20230812020037.GH151430@dragon>
References: <cover.1691684726.git.agx@sigxcpu.org>
 <513d6f6d1525ad9f7996a9976c06b2a858f8a6a4.1691684726.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <513d6f6d1525ad9f7996a9976c06b2a858f8a6a4.1691684726.git.agx@sigxcpu.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 07:59:50PM +0200, Guido Günther wrote:
> Otherwise the A53 cores are shut down which doesn't end well.
> 
> Reported-by: David Heidelberg <david@ixit.cz>
> Tested-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Applied, thanks!
