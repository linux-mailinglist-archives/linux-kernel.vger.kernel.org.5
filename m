Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEAA809972
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjLHCoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHCoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:44:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF99171D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:44:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E85C433C7;
        Fri,  8 Dec 2023 02:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702003452;
        bh=I5sJy6eBAvZlN23cukfV2ZcXAxpxPV68kGFNnW99WKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AMA7D1EEet+ynKSS9KDL9zUfLr6wB9r9ua9duUOZYYtMPleXgg9eUSAqvsTWaYhg7
         R7kRMr5QDu00YSaQ9gyRQkyG+FI8f1Pw56SowXjXxL7eDNior9txEP2sYJpN+G7Rmo
         25Gfng57aiH8vwOMdBvLqUzYiq9CqYdVGWTKZCrmFZebjlbRAlryk3OqiuraZvB6o0
         v1G1e96oPc+vx+XlIoLeyX+Hf9jyOvoBvwhG95iMKXlAl1aKW3Ha6LYWn+J0Rb2H1r
         3hIb1IiuSCQAB8iNrFesNlhkeyXySV64Tz3MWXkejegm4F9Qm0PROypz4ZLJds8cjz
         64eHddmzL6IZw==
Date:   Thu, 7 Dec 2023 18:48:47 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: pm8916: Add BMS and charger
Message-ID: <mmxk4dko6ib2pgrzcotxf65q5c7d4eaykd4sfh2ryrmfbdabd7@wnttadck2mda>
References: <20231120-pm8916-dtsi-bms-lbc-v4-0-4f91056c8252@trvn.ru>
 <20231120-pm8916-dtsi-bms-lbc-v4-2-4f91056c8252@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-pm8916-dtsi-bms-lbc-v4-2-4f91056c8252@trvn.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 07:03:04PM +0500, Nikita Travkin wrote:
> diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
[..]
>  
> +		pm8916_bms: battery@4000 {

"battery" is not a valid child of the pmic according to
mfd/qcom,spmi-pmic.yaml, so please update the binding to remove the
warnings that this introduces.

Thanks,
Bjorn
