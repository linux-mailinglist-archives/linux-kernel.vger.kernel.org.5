Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A6D7A6ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjISWrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjISWrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:47:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6951EBF;
        Tue, 19 Sep 2023 15:47:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6970CC433C8;
        Tue, 19 Sep 2023 22:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695163628;
        bh=Zz55Rzz0ip2wh5I/XTQWnZtdEa5fny//y92DvP3sTKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q/MlhSvv21ZgsuWDJddvDo3okpD2ESxhiWA4KP6uCQrXFhFeM1z6i/y/8YgD2JDlx
         Dlg2ZF2NQ02VFG12UeUtc8KNuyPIgCIu3HR28cNUHw+kPBHFMK5vYQpvL9r/nxOJmb
         1l8mxY5n5KPIPvWsr+wd59z1+MZ88qnI1EQbqBqP+yThkpxz4khj1BIpQLjxbYU0dv
         moYuyJMSJWVPr29lKbBJ6CkAeahaArs1xfHGW2sac1FBgnhnjGz0F8xdeDt7u+O6HU
         +JTdFVGhU9gfglulQ/+tfq3yM1tO7JJCbFYS+Lv74t9P85QhyPkCiZeKL6MmoNM7yY
         xkgxZWDQ7dpQw==
Date:   Tue, 19 Sep 2023 15:51:16 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Walter Broemeling <wallebroem@gmail.com>,
        Joe Mason <buddyjojo06@outlook.com>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Gareth Peoples <mail@gpeopl.es>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: msm8916-samsung-fortuna: Add
 initial device trees
Message-ID: <lpoghxjh3nid67iv6r3sqfd7ol3ut73fzm2zpb2w5eca4rbeiw@irmzrhnj3mia>
References: <20230801111745.4629-1-linmengbo0689@protonmail.com>
 <20230801112123.4672-1-linmengbo0689@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801112123.4672-1-linmengbo0689@protonmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 11:22:47AM +0000, Lin, Meng-Bo wrote:
> From: Walter Broemeling <wallebroem@gmail.com>
> 
> Samsung Galaxy Core Prime, Grand Prime and Ace 4 are phones based on
> MSM8916. They are similar to the other Samsung devices based on MSM8916
> with only a few minor differences.
> 
> This initial commit adds support for:
>  - fortuna3g (SM-G530H)
>  - fortunaltezt (SM-G530Y)
>  - gprimeltecan (SM-G530W)
>  - grandprimelte (SM-G530FZ)
>  - heatqlte (SM-G357FZ)
>  - rossa (SM-G360G)
> 
> The device trees contain initial support with:
>  - GPIO keys
>  - Regulator haptic
>  - SDHCI (internal and external storage)
>  - USB Device Mode
>  - UART (on USB connector via the SM5502/SM5504 MUIC)
>  - WCNSS (WiFi/BT)
>  - Regulators
> 
> There are different variants of Grand Prime, with some differences
> in accelerometer, NFC and panel.
> Core Prime and Grand Prime are similar, with some differences in MUIC,
> panel and touchscreen.
> Ace 4 and Core Prime are similar, with some differences in panel and
> touchscreen.
> 
> The common parts are shared in
> msm8916-samsung-fortuna-common.dtsi and msm8916-samsung-rossa-common.dtsi
> to reduce duplication.
> 
> Unfortunately, SM-G357FZ and SM-G530Y were released with outdated 32-bit
> only firmware and never received any update from Samsung. Since the 32-bit
> TrustZone firmware is signed there seems to be no way currently to
> actually boot this device tree on arm64 Linux at the moment.
> 
> However, it is possible to use this device tree by compiling an ARM32
> kernel instead. The device tree can be easily built on ARM32 with
> an #include and it works really well there. To avoid confusion for others
> it is still better to add this device tree on arm64. Otherwise it's easy
> to forget to update this one when making some changes that affect all
> MSM8916 devices.
> 
> Maybe someone finds a way to boot ARM64 Linux on this device at some
> point. In this case I expect that this device tree can be simply used
> as-is.
> 

Can you please help me understand the development flow of this patch?

> Signed-off-by: Walter Broemeling <wallebroem@gmail.com>
> Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Walter and Stephan wrote the initial patch, right?

> [Add fortuna-common.dtsi, buttons, and WiFi]
> Co-developed-by: Joe Mason <buddyjojo06@outlook.com>
> Signed-off-by: Joe Mason <buddyjojo06@outlook.com>

Then Joe added fortuna-common, buttons and Wifi.

If so, then Joe shouldn't be "Co-developed-by", the [note] and
Signed-off-by is sufficient here.

But it is customary to prefix the "changes note" with ones first name,
such as:

[joe: Add fortuna-common.dtsi, buttons, and WiFi]

> [Add fortuna3g]
> Co-developed-by: Siddharth Manthan <siddharth.manthan@gmail.com>
> Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>

Then Siddharth picked it up, ad added fortuna3g. Again, it looks like he
did this step alone, and as such no Co-developed-by, please.

> [Add heatqlte]
> Co-developed-by: Gareth Peoples <mail@gpeopl.es>
> Signed-off-by: Gareth Peoples <mail@gpeopl.es>

Again, no Co-developed-by, and please prefix the change note with
"Gareth:", or "gareth:".

> [Add grandprimelte and fortunaltezt]
> [Use msm8916-samsung-rossa-common.dtsi and reword the commit]

Why two different notes? Is this one note split over two separate
entries? Please just comma-separate them, possible line wrap within the
[].

> Co-developed-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>

You should be alone here.


Alternatively, if y'all all contributed to this one patch through the
entire flow, please drop the change notes and just list out each
contributor with the Co-developed-by and Signed-off-by.


PS. Could you please drop the ',' from your name. When I tried to apply
this everything after the ',' disappeared.

Regards,
Bjorn
