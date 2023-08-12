Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1FF779C76
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 04:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbjHLCB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 22:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbjHLCB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 22:01:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F8030FD;
        Fri, 11 Aug 2023 19:01:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C95E96128E;
        Sat, 12 Aug 2023 02:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F281C433C9;
        Sat, 12 Aug 2023 02:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691805714;
        bh=gZu3VCSXksAlch1l/Nn0DJCrwCclu/WcPo7SWLglZjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MYnrczVWhJ2d3+KS8jq0tJikwcuABKb3B8elSyBtYo+RjU4S7lcxHcY8f25FFTuIz
         4nzw3uz0jXEkrwCrP9BAsFST9iwQbOm3ihbV1hKmGCgwEz5CpEX25EOcF+dT+lb9K4
         RvUx3XN4YT8ehHu46Tz34oc4Mi5OYC871n9AuWThQCgQSwFqWJ9+NgZ8yU37SCJRKE
         /kZLdJ4IB7JdgiIxpa/7y0akjg/727pG11zmNbSrbOvgcW0FFLKKD0xdgJBHXCm/4I
         fM7dBtPSKOeyUavvdyAxipMSudWR71m2tLi1vRVDtUYe2h9U4TR2op20K+ykTkNX99
         DMdsl1XGYh6Eg==
Date:   Sat, 12 Aug 2023 10:01:38 +0800
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
Subject: Re: [PATCH v2 4/4] arm64: defconfig: Enable Redpine 91X wlan driver
Message-ID: <20230812020138.GJ151430@dragon>
References: <cover.1691684726.git.agx@sigxcpu.org>
 <ba8bc68cbe17224eafc84fc3fcad5a2522d3d97c.1691684726.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba8bc68cbe17224eafc84fc3fcad5a2522d3d97c.1691684726.git.agx@sigxcpu.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 07:59:52PM +0200, Guido Günther wrote:
> The Librem 5 and it's devkit have it connected via SDIO.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Applied, thanks!
