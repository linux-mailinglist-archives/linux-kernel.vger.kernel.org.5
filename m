Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE4275FF99
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjGXTKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXTKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:10:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA54D10F6;
        Mon, 24 Jul 2023 12:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F36F6131D;
        Mon, 24 Jul 2023 19:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8569DC433C7;
        Mon, 24 Jul 2023 19:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690225805;
        bh=gi/Kpw0YoiBU5vrnlwQ4STkpZ+7UQf+MK+WxWW9gHCI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=O45liGQFcvfhI7XioJJ+28GH3YveLiU9NTHY1/FhZH0M4eF0F2gPfUKBhIg0ETBuq
         VQIwtjuQOTGMgPAgEJ9LgNuGYWwojiQbUciwP2//cyctufvtO9X341Uc01Avzz0qpo
         5syeEZ2iZQsKJ5QMdOBRd8LFc7l/Y4ZXfbYNMaDjZzanCrmgSbJuZiuSu5dLjfC2MO
         bvp5UI09UgfriiqInmnRBQFYDgKUU03cXpHybnbhx9CcyiaTGnkkr+d9h8iIGmYfsX
         QWehe4k53kbX2g0MPqsZcPs1I0OhGK2wVo7DsgC3bEmgCpYY7QfkCIecR+NLeOgWVW
         U8e11tkdSll2g==
Message-ID: <a9f20ae3-74a3-fe3a-7de5-a57eb2d5aa81@kernel.org>
Date:   Mon, 24 Jul 2023 21:09:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] pinctrl: qcom: Remove the unused _groups variable build
 warning
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, quic_varada@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev
References: <1689934361-32642-1-git-send-email-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1689934361-32642-1-git-send-email-quic_srichara@quicinc.com>
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

On 21/07/2023 12:12, Sricharan Ramabadhran wrote:
> When building with clang toolchain and arm64-randconfig-r015-20230712
> kernel test robot reports the below warning.
> 
>  drivers/pinctrl/qcom/pinctrl-ipq5018.c:244:27: warning: unused variable '_groups' [-Wunused-const-variable]
>    static const char * const _groups[] = {
>                              ^
>    1 warning generated.
> 
>      static const char * const _groups[] = {
>              "gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6", "gpio7",
>              "gpio8", "gpio9", "gpio10", "gpio11", "gpio12", "gpio13", "gpio14",
>              "gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21",
>              "gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27", "gpio28",
>              "gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34", "gpio35",
>              "gpio36", "gpio37", "gpio38", "gpio39", "gpio40", "gpio41", "gpio42",
>              "gpio43", "gpio44", "gpio45", "gpio46",
>    };
> 
> Fixing it by removing the variable.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307120814.vWPY6URk-lkp@intel.com/
> Fixes: 725d1c891658 ("pinctrl: qcom: Add IPQ5018 pinctrl driver")
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

This seems to be a duplicate of gpio_groups, so:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

