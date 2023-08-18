Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44C1780D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377580AbjHROA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377692AbjHROAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AEC3C3F;
        Fri, 18 Aug 2023 06:59:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A15667CC5;
        Fri, 18 Aug 2023 13:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B704EC433C9;
        Fri, 18 Aug 2023 13:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692367162;
        bh=QmgqfANqunFsl3QUOMKT/jwcOpjyJ8Qzz1C4HPJaFqw=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=ChdSZ5XpicUNnIRAmqWiFaQmNwfZ7MttJfBorDUXrsjxFLdVAow1qlEnnBDMq3Fqp
         kcttPfaOQGC7z6/i0HJc2b9QYzoCb+IpFsJd2bxOx4X4tRr1tnXtV0axEan322hrJl
         sOHTowReJkpdSd6FliExg7zGGSow5Ijn7D2f2acR8eo4l+bp4Cxr40WDXD/jfjGX0X
         ewUwSK877Ab5k6o+mi9ffH1JJAcZkHOGkMHj0QMYHT2YBEXb1hVv/fMh9Xedzc9r/O
         S9T1P9UFHkIZRVkf7L24iq89Nf6hKzWpZ8DSu2b/cXh0CzhE0Hcy5ZTDobAZBpHoFF
         67MlQsgDVZ3gQ==
Message-ID: <1dd0bad4-fbb4-3861-9bc0-7a5f3067aeaf@kernel.org>
Date:   Fri, 18 Aug 2023 15:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] pinctrl: qcom-pmic-gpio: silence -EPROBE_DEFER message on
 probe
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     andersson@kernel.org, linus.walleij@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230817145941.1091418-1-bmasney@redhat.com>
 <a3431eaf-053a-4e1c-b082-e87a3aaefbf3@linaro.org> <ZN5KIlI+RDu92jsi@brian-x1>
 <09df85cd-27c7-d64c-9792-41110bf32fce@kernel.org>
In-Reply-To: <09df85cd-27c7-d64c-9792-41110bf32fce@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2023 15:51, Krzysztof Kozlowski wrote:
>>     qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: no hogs found
>>     qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: error -EPROBE_DEFER: can't add gpio chip
>>     qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: Driver qcom-spmi-gpio requests probe deferral
>>     platform c440000.spmi:pmic@2:gpio@8800: Added to deferred list
>>
>> The second time it probes the device is successfully added.
> 
> There is a bug in DTS. I'll send a patch.

https://lore.kernel.org/linux-arm-msm/20230818135538.47481-1-krzysztof.kozlowski@linaro.org/T/#u

Best regards,
Krzysztof

