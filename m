Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CEB769B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjGaPuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjGaPup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:50:45 -0400
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E2C188
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:50:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=DMi77ear/iZF1UDc+VOzM2c7AtwCSig4GAd85tFsfDcAeXP2E0L34dIJokY4Em/Tlo4xLIKWjtIFLZoOXzUyAY4KB+otQ7aex7+sc0es9ElO0eBNjSgh6ijys1/cyl9yHBJUgD+9uS8qmdFXbgrZgJt71Dx0dejar9znxDwedoFvN+9HW2ShH2JTnvPdzY3LCWYp7s0Vi94ZsXYmTrVw6hJNhVxjBnyXmmksHS45viVscrcBhVLha29cTP/SnWjMwa4L2vKSOkUoevJd/7Y5l87pin2gXOSDxkdZXMFYOR9pO1b26OMgTQQJjwmyTeztSLIbViBuNUjaP3cBvvFqMQ==; s=purelymail1; d=iskren.info; v=1; bh=eNdJS1WJkEMJiLxhmli0JSlZQRMNa/96vjAbAJHmhoU=; h=Received:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=Q9GpMGbQj8hvBCF5gmgA0xSnJmBsCgbcfv+1IQPKwvp9qCsq0hPLMt868WCQekcq0R9UBTK6uSdSc7YNMIR1v5eFDqUUQ6WPh6wQ92I93ZWOqKwoQ8ObAa6EyMFlXu9Hlt/lNbjAkKNmp3xapqPfrlVi11A9QaRismj96MVcLx4I474uJeI4/31wxLfdz7odwJKqeyXVzsm7aCRfhnImqByU3kXj1MEflm80Vp9F72IX/9X+LR8BvkKK5O9SbM9wgrj/wgItl1S0OS3znk/Ew6245N1jvitPwEN1jSnvF8z2Ed7Cn01SAN9ysQEIWL4RYTQyuB3PvuCyaZFnp8YhTA==; s=purelymail1; d=purelymail.com; v=1; bh=eNdJS1WJkEMJiLxhmli0JSlZQRMNa/96vjAbAJHmhoU=; h=Feedback-ID:Received:Subject:To:From;
Feedback-ID: 10275:2339:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1185265924;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 31 Jul 2023 15:49:41 +0000 (UTC)
Message-ID: <95135e09-75d2-fea1-775b-1233a83349a1@iskren.info>
Date:   Mon, 31 Jul 2023 18:49:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Add optional properties to MAX17040
To:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stefan Hansson <newbie13xd@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20230731073613.10394-1-clamor95@gmail.com>
Content-Language: en-US
From:   Iskren Chernev <me@iskren.info>
In-Reply-To: <20230731073613.10394-1-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/23 10:36, Svyatoslav Ryhel wrote:
> Extend properties supported by max17040 fuel gauge if it is accompanied
> by different devices.
> 
> If max17040 is coupled with a charger, pass charger status since it should
> match and max17040 has no dedicated status detection ability.
> 
> max17040_get_online can be reused for PRESENT property since if it is
> online it must be present.
> 
> Finally, max17040 may be coupled with a dedicated thermal sensor which
> monitors battery temperature so lets add support for iio channel to match
> hw setup. With that said, the driver got dependency on CONFIG_IIO which
> was added to Kconfig. All defconfigs apart s5pv210_defconfig have IIO
> already enabled so only s5pv210_defconfig needed adjustment.

[whole series]
Reviewed-by: Iskren Chernev <me@iskren.info>

> ---
> Changes from v2:
> - documentation: fixed typo i2c0 > i2c
> - added dependency on CONFIG_IIO
> - enabled CONFIG_IIO for s5pv210_defconfig to avoid regressions (all other
>   defconfigs which include max17040 already have IIO enabled)
> 
> Changes from v1:
> - documentation: dropped monitored-battery and power-supplies (inherited
>   from inclusion)
> - dropped passing charger health as battery health
> - dropped patch for simple battery cell support
> - switched iio_read_channel_raw to iio_read_channel_processed_scale
> - switched iio_channel_get to devm_iio_channel_get
> - re-organized implementation of temp channel (implemented in way 
>   *_get_optional functions usually act)
> ---
> 
> Svyatoslav Ryhel (4):
>   dt-bindings: power: supply: maxim,max17040: update properties
>   power: max17040: pass status property from supplier
>   power: max17040: get thermal data from adc if available
>   ARM: configs: s5pv210_defconfig: enable IIO required by MAX17040
> 
>  .../bindings/power/supply/maxim,max17040.yaml | 31 +++++++++++++++++++
>  arch/arm/configs/s5pv210_defconfig            |  1 +
>  drivers/power/supply/Kconfig                  |  2 +-
>  drivers/power/supply/max17040_battery.c       | 27 ++++++++++++++++
>  4 files changed, 60 insertions(+), 1 deletion(-)
> 
