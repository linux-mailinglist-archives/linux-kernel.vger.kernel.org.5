Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FF87EAA11
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 06:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjKNFYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 00:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKNFYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 00:24:17 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1049ADD;
        Mon, 13 Nov 2023 21:24:13 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 969D6408CE;
        Tue, 14 Nov 2023 10:24:07 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1699939448; bh=RbTQ9Gyko9mWKAoJcs4lYkr1Uh4l+RCsZid+oUd3BdE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FgY4eindZGM+SNgXzPoSmcUOE8Hj1OlaLA9b2ZwZ6sTxxd9nSjt75D7Sg2sZePxa0
         3n+tHROk4Y9HJN0+K2D53RCEjm1L8MVMxOK8o/O4bUjR13RsUtPQvyETViEiZqEGKV
         OayAyAkkWq57np0Di2wQ9BRnza3nTWr1l7TbdzKzFn9Vd2y1WZcutRX2POc2s0PpV3
         RG41MuRP2nry/mEFMlB/s70YYXq9bi4zyn4Jd8hf+LVhwK5QdRiHWLw/elhay3ujR3
         rAOX6oneX/5asBAw3DkXFRvq1xyVf/djCB+f6qrFZU89CFI7CuM6GzGnIp9c7Rg7Ta
         cDPIySPMvJzHQ==
MIME-Version: 1.0
Date:   Tue, 14 Nov 2023 10:24:06 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Lee Jones <lee@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: mfd: qcom,spmi-pmic: Add
 pm8916 vm-bms and lbc
In-Reply-To: <20231031075400.GR8909@google.com>
References: <20231023-pm8916-dtsi-bms-lbc-v2-0-343e3dbf423e@trvn.ru>
 <20231023-pm8916-dtsi-bms-lbc-v2-1-343e3dbf423e@trvn.ru>
 <169824868224.758275.3309948002942732059.b4-ty@kernel.org>
 <67b0e974-779c-434c-b558-81840ec46cdd@linaro.org>
 <20231031075400.GR8909@google.com>
Message-ID: <c72077299f457eabb1b885a5d2353f8c@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones писал(а) 31.10.2023 12:54:
> On Fri, 27 Oct 2023, Krzysztof Kozlowski wrote:
> 
>> On 25/10/2023 17:44, Lee Jones wrote:
>> > On Mon, 23 Oct 2023 11:20:32 +0500, Nikita Travkin wrote:
>> >> PM8916 (and probably some other similar pmics) have hardware blocks for
>> >> battery monitoring and charging. Add patterns for respecive nodes so the
>> >> devicetree for those blocks can be validated properly.
>> >>
>> >>
>> >
>> > Applied, thanks!
>> >
>> > [1/3] dt-bindings: mfd: qcom,spmi-pmic: Add pm8916 vm-bms and lbc
>> >       commit: e9aec86e211ee493081e8934b8c821d660b417ee
>>
>> Hi Lee,
>>
>> It seems this patch depends on something not in your tree. This should
>> have been clearly explained in cover letter or this patch changelog, but
>> wasn't.
>>
>> Please drop the patch.
> 
> Done.

Hi, v6.7-rc1 now includes the dependencies for this bindings change,
could you pick it up again? Or maybe I should respin the series
with it included back?

Sorry for making this inconvenient for you...

Nikita
