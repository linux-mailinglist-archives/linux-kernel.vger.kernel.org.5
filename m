Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEBF7529FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjGMRjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjGMRjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:39:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0364D270A;
        Thu, 13 Jul 2023 10:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90D4461ADA;
        Thu, 13 Jul 2023 17:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34900C433CA;
        Thu, 13 Jul 2023 17:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689269943;
        bh=WaQGx34kCLJckhXKFnj8LFhA5pJxWostoEupTv48m+I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rDBFBCOkylQq6CifU8SMFoYsNZLcmPRV9W2cHRXT4TkVZWpS8eX9u6IytXbDb16X8
         GfIPeW7Q4aRYdXlwkcU/HxuhQXJ+zq6UGGwIXd2joHPXI8mXNWiPpw1sdMIWfGcHD7
         hyhwWkj0LV8P9nSlr7R17t5x/CHxEv2Elk7wfCdYPiaoxrWG9Dg1f6NkZtQYrnNxjY
         5+cZhylFWuV8JEkEe1ADk1TtW12Z2dgeZV+8+67HAgSyWzTMjqBb05a6s7IHXlEKzR
         1JOW784yfoH63v+IiNkxEUovJNhOQfgEXuZ0iwwCZ595vI41FmoHfeST9FGN8/L+ar
         MmdhNDXnqUBIg==
Message-ID: <afe1ac02-da07-327c-a1ce-1777e1ac9fb1@kernel.org>
Date:   Thu, 13 Jul 2023 20:38:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] Deprecate ti-serdes header file
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        peda@axentia.se
Cc:     s-vadapalli@ti.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230713151707.8109-1-j-choudhary@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230713151707.8109-1-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/07/2023 18:17, Jayesh Choudhary wrote:
> This series moves the ti-serdes.h header to arch/arm64/boot/dts/ti/
> as these constants do not have driver usage and are not suitable for
> bindings as discussed in [1].
> 
> Deprecating the bindings header for now instead of dropping them based
> on the discussion in [2].
> We expect to remove this bindings header in the next cycle.
> 
> [1]: <https://lore.kernel.org/all/b24c2124-fe3b-246c-9af9-3ecee9fb32d4@kernel.org/>
> [2]: <https://lore.kernel.org/linux-arm-kernel/71c7feff-4189-f12f-7353-bce41a61119d@linaro.org/>
> 
> Jayesh Choudhary (2):
>   arm64: dts: ti: Use local header for SERDES MUX idle-state values
>   dt-bindings: ti-serdes-mux: Deprecate header with constants
> 
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts       |   3 +-
>  .../dts/ti/k3-am642-phyboard-electra-rdk.dts  |   3 +-
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts        |   3 +-
>  .../boot/dts/ti/k3-am68-sk-base-board.dts     |   3 +-
>  .../dts/ti/k3-j7200-common-proc-board.dts     |   3 +-
>  .../ti/k3-j7200-evm-quad-port-eth-exp.dtso    |   2 +-
>  .../ti/k3-j721e-evm-quad-port-eth-exp.dtso    |   2 +-
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |   3 +-
>  .../dts/ti/k3-j721s2-common-proc-board.dts    |   3 +-
>  arch/arm64/boot/dts/ti/k3-serdes.h            | 204 ++++++++++++++++++
>  include/dt-bindings/mux/ti-serdes.h           |   8 +
>  11 files changed, 228 insertions(+), 9 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-serdes.h
> 

For this series:
Acked-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger
