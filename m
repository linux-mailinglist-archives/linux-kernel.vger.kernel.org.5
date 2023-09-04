Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524B0791E5F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbjIDUl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjIDUl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:41:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 923E612A;
        Mon,  4 Sep 2023 13:41:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C0F6143D;
        Mon,  4 Sep 2023 13:42:01 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C52B33F793;
        Mon,  4 Sep 2023 13:41:19 -0700 (PDT)
Date:   Mon, 4 Sep 2023 21:40:18 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rogerio Goncalves <rogerlz@gmail.com>,
        Martin Botka <martin@biqu3d.com>
Subject: Re: [PATCH 2/6] cpufreq: dt-platdev: Blocklist allwinner,h616 SoC
Message-ID: <20230904214018.0a8f12e2@slackpad.lan>
In-Reply-To: <20230904-cpufreq-h616-v1-2-b8842e525c43@somainline.org>
References: <20230904-cpufreq-h616-v1-0-b8842e525c43@somainline.org>
        <20230904-cpufreq-h616-v1-2-b8842e525c43@somainline.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2023 17:57:02 +0200
Martin Botka <martin.botka@somainline.org> wrote:

> The AllWinner H616 uses H6 cpufreq driver.
> Add it to blocklist so its not created twice

That looks alright, but I think needs to be squashed into the patch
that enables the H616 driver operation, to avoid regressions during
bisecting.

Cheers,
Andre

> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index e2b20080de3a..51818cef8979 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -104,6 +104,7 @@ static const struct of_device_id allowlist[] __initconst = {
>   */
>  static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "allwinner,sun50i-h6", },
> +	{ .compatible = "allwinner,sun50i-h616", },
>  
>  	{ .compatible = "apple,arm-platform", },
>  
> 

