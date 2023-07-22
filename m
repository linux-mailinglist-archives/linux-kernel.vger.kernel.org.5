Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E3D75D9EA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjGVFDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGVFDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:03:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8C030FF;
        Fri, 21 Jul 2023 22:03:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D698860AB0;
        Sat, 22 Jul 2023 05:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A96C433C8;
        Sat, 22 Jul 2023 05:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002224;
        bh=dpEkrC9sBtiVEfiM0x7VPJCsAGNzmWmplxWvorExXgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iykTUv9mGESoPIo0JGJYJeA15/sWcmNDlfv+5tZJbmdyXL6n2F9z9SjBMTIuSgx1e
         TIHayPAe5k6abwyg3/jdMFVJ3d/bfZeq4UCc9XYoRVTcbkPsz2yPE5iY1C/KMPsEr/
         PLcaf0rqXbrtAnSdI5F296h1M2OvFNtjKqBwDN6jIIA79g3lay9lMLbI8pUJB2o8YZ
         OtXU8KwCFeYR4aN6EHT6CPLln959OmNt7VQgMMO39MyzrvQZCDW0HoFM/fTJxVvcsz
         L4RLl0Qw0GJDLlu2xCNj7ZC5yDVkMOEE1tZkoteuZd6/NlTYy7BWvE92TRCVYphf4P
         OlweRJK6zi+mQ==
Date:   Fri, 21 Jul 2023 22:07:01 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 5/6] arm64: dts: qcom: ipq5332: Enable USB
Message-ID: <uuw5fzqjgalcffutdp3cxkilht76ocvnf7okx5nfng6433hq3o@ujl2kugkefuj>
References: <cover.1689913334.git.quic_varada@quicinc.com>
 <2f8f86fdef6cad65954b7668cb13fc132b685a4b.1689913334.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f8f86fdef6cad65954b7668cb13fc132b685a4b.1689913334.git.quic_varada@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:05:30AM +0530, Varadarajan Narayanan wrote:
> Enable USB2 in host mode.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v1:
> 	Enable usb-phy node
> ---
>  arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
> index f96b0c8..f5dea16 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
> @@ -79,3 +79,15 @@
>  		bias-pull-up;
>  	};
>  };
> +
> +&usbphy0 {
> +	status = "okay";

Is this phy not powered? Should there be some regulators controlled?

Regards,
Bjorn
