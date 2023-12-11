Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E385880D2AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344506AbjLKQr2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 11:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjLKQr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:47:26 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C0F98;
        Mon, 11 Dec 2023 08:47:29 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 0FE9F7FD3;
        Tue, 12 Dec 2023 00:47:26 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 00:47:26 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 12 Dec
 2023 00:47:20 +0800
From:   Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To:     <krzysztof.kozlowski@linaro.org>
CC:     <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <jisheng.teoh@starfivetech.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <leyfoon.tan@starfivetech.com>, <linux-kernel@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <samin.guo@starfivetech.com>,
        <wim@linux-watchdog.org>, <xingyu.wu@starfivetech.com>
Subject: Re: [PATCH v1 1/2] watchdog: starfive-wdt: Add JH8100 watchdog compatible string
Date:   Tue, 12 Dec 2023 00:47:00 +0800
Message-ID: <20231211164700.1590908-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <84145eba-7877-4dc0-a221-2debb5a40d40@linaro.org>
References: <84145eba-7877-4dc0-a221-2debb5a40d40@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 11:06:42 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 09/12/2023 15:27, Ji Sheng Teoh wrote:
> > Add "starfive,jh8100-wdt" compatible for StarFive's JH8100 watchdog.
> > JH8100 watchdog reuses JH7110 register mapping.
> > 
> > Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> > ---
> >  drivers/watchdog/starfive-wdt.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/watchdog/starfive-wdt.c
> > b/drivers/watchdog/starfive-wdt.c index 5f501b41faf9..31785bb373d5
> > 100644 --- a/drivers/watchdog/starfive-wdt.c
> > +++ b/drivers/watchdog/starfive-wdt.c
> > @@ -581,6 +581,7 @@ static const struct dev_pm_ops
> > starfive_wdt_pm_ops = { static const struct of_device_id
> > starfive_wdt_match[] = { { .compatible = "starfive,jh7100-wdt",
> > .data = &starfive_wdt_jh7100_variant }, { .compatible =
> > "starfive,jh7110-wdt", .data = &starfive_wdt_jh7110_variant },
> > +	{ .compatible = "starfive,jh8100-wdt", .data =
> > &starfive_wdt_jh7110_variant },  
> 
> Device is compatible, so why not expressing it in the bindings and
> dropping this change?
> 
> Best regards,
> Krzysztof
> 

Ok, will drop this change.

Thanks,
Ji Sheng
