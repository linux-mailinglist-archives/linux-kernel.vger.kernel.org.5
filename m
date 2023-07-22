Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFC375D986
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 05:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjGVD4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 23:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGVD4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 23:56:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1BBF0;
        Fri, 21 Jul 2023 20:56:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1952C61DAA;
        Sat, 22 Jul 2023 03:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9D6C433C7;
        Sat, 22 Jul 2023 03:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689998171;
        bh=xeB+GD2/T24xF60NZo1JJmzAvsqgxo+DoSn3WlJgCIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=faZF1KEUZg15a9P7i8vAO8suVPQbBPUuTK0vSMmEa7OlCqWmTtf7talDmAR5G/5dx
         z+LOle+d7ZtPNFnyTyvpNxOX4LMOcwaLvz3aD7vtDeDX6ePCv2iino4cxeyOkSHs9I
         WKqEleV+Q0O9RaQD2DuIfFtInqNguzUe7aZtIjir6JWg4Fa6uYVThFrS4eBMG+Q4bm
         /K7UWNfsQKIdqkNQ45GptZZpPq6oGs9xl435/0jigXUpyMlm0qTxyqPpMX3VO5wHp/
         fNhbRGVvMNivpHoJpe5l9AXTDaHG/2A5l524Ft/m+R82bfe2506cOsfHQnkiE72b3R
         VgZj3bg27Ru5g==
Date:   Fri, 21 Jul 2023 20:59:30 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Eric Chanudet <echanude@redhat.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sa8540p-ride: enable rtc
Message-ID: <dtussvqzf7x5p633pxt3julkffhzt5rxwp3aghs4ocj5odq4la@ed6jhcv76hbk>
References: <20230718145105.3464105-1-echanude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718145105.3464105-1-echanude@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:46:10AM -0400, Eric Chanudet wrote:
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
[..]
> +&pmm8540a_sdam_7 {
> +	status = "okay";
> +
> +	rtc_offset: rtc-offset@ac {
> +		reg = <0xac 0x4>;

I'm still trying to get confirmation that this is a good choice.

Regards,
Bjorn
