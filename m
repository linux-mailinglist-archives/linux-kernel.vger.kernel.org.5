Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD89076C71A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjHBHiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjHBHhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:37:45 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D97B1BD8;
        Wed,  2 Aug 2023 00:37:14 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 79C97120008;
        Wed,  2 Aug 2023 10:37:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 79C97120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1690961832;
        bh=ySPKX71AR7ERlZqWHs70b/+0JtWIHCcnxyCVYb0RFag=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=Dj6meVIX3MeqLcmfIkTZqFQG1v3B2SbOMvk9jCr8DhdLYIodSUHINdybqbo6vAOSs
         DAxPP4bbTkjs+CFCkcTiiG47wKiKv3LhWm5oaLL2N7zhirBDVie/ZYev7hZhPB6Kfj
         wLkllYRs8A81wk4qWfHF3e3DqR6BPGjOifKJFtlfP43xYUR/kQtGMpQSSqYkzbO0kU
         NVsIEWf9j6mpsCnQCTNIAr3XPR9Q9Mv0Hlz+nuGYW1by2Uud6JNeiSdd11DhrfH6sA
         WWmJOxWu1bIQHGf/ilSSS0R+mVoDwMwqdvpFg2+WB2c0vPSRXjATQci5/C/M1IsW1u
         QYDijZwGYzBVA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  2 Aug 2023 10:37:12 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 10:37:11 +0300
Date:   Wed, 2 Aug 2023 10:37:12 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Huqiang Qin <huqiang.qin@amlogic.com>
CC:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 3/4] watchdog: Add support for Amlogic-T7 SoCs
Message-ID: <20230802073712.6gd6jigprlryxstu@CAB-WSD-L081021>
References: <20230802033222.4024946-1-huqiang.qin@amlogic.com>
 <20230802033222.4024946-4-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230802033222.4024946-4-huqiang.qin@amlogic.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178796 [Jul 22 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 525 525 723604743bfbdb7e16728748c3fa45e9eba05f7d, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/07/23 10:45:00
X-KSMG-LinksScanning: Clean, bases: 2023/07/23 10:46:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/23 08:49:00 #21663637
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 11:32:21AM +0800, Huqiang Qin wrote:
> Compared with the previous Amlogic-GXBB, the watchdog of Amlogic-T7
> has a different reset enable bit.
> 
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

> ---
> 
> V1 -> V2: Use the BIT() macro to build rst initial value.
> 
>  drivers/watchdog/meson_gxbb_wdt.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> index 18180d91543e..a48622d11ad7 100644
> --- a/drivers/watchdog/meson_gxbb_wdt.c
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -147,8 +147,13 @@ static const struct wdt_params gxbb_params = {
>  	.rst = BIT(21),
>  };
>  
> +static const struct wdt_params t7_params = {
> +	.rst = BIT(22),
> +};
> +
>  static const struct of_device_id meson_gxbb_wdt_dt_ids[] = {
>  	 { .compatible = "amlogic,meson-gxbb-wdt", .data = &gxbb_params, },
> +	 { .compatible = "amlogic,t7-wdt", .data = &t7_params, },
>  	 { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, meson_gxbb_wdt_dt_ids);
> -- 
> 2.37.1
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Thank you,
Dmitry
