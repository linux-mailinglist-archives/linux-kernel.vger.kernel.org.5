Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665787CA0C9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjJPHh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjJPHhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:37:53 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2452AD;
        Mon, 16 Oct 2023 00:37:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1697441859; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Q7m8ITfBvAJ8v4ng1TMJI2xyAn+ApY7whJVrGseOfx/a2FcDvfWvOyaUrl7GGPWDZY
    Ocu+VCLHA5WSQY+u4YVCONfL2awR6hbIEhFVk/lM9rbgynOHCode2ebRU5ubD6eVTIDy
    TDA46/rncawma8Yd/OG0bZ5cmx2I3Dx+JvXknEp0WREb4jqdBc5w5yQi7Rq7yoW3yaH8
    0zC6HHGdNMWWfMa1JEaojMNI3w3QnDzOESQ/Vchqp8BIq5K0jy4TIiGdAsB1lPkbA0fh
    GxrYxebkFZiQ/9Y4QNn6lOtJ+LdDY5rFIHMwqwhddxiHvlt2Y0s6gm6GJhqvsJx5tpDb
    SGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1697441859;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=AlaJj77DqQEREN4W2oqNqqXui1B4mTuRTUEpEAgS0r8=;
    b=fj1zC7R6C6s9VINtX4t1g4g1GwL6TIeWjJ+B2C14xlKa63pjJPxR9bE37k3zIa11PX
    4B9Kab6uhjgxb4wRLgYZGhFXf1Xd+R6lZk9c7erDb1OY0uigUVnyA6PuabDmgNrr/kC5
    KyV81YbVg5K2F5eQE2punq8HVTkg3KpAoLE1MDDAipzgoMBgXjd0Tebl7GMRs1DJ6JCD
    0C7oTVbwnU/HnsEb1dNM5hwE9rvMPDp817F3mKPW0eDmr5hwPHb5EFg2vgnHRfF7SMWo
    Lex3rWRw7wNNEjFzFEIi1TJ7ttJlzeCkNUSDz+oXXc0fnFAX0RUbuXSU3EFHQhYaXR4a
    PW0w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1697441859;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=AlaJj77DqQEREN4W2oqNqqXui1B4mTuRTUEpEAgS0r8=;
    b=GATbcje9ZIPvGG9aoyTPYw9TbkgmY2rJM+D/Et2SeZDZob6MvZ+LaStP83a57t1VI0
    +4510Ibba1zZxYZgPpCjqnXv+1n3uBfc5MaaCjThO8lWna/npO2MgfYhpPgPA5hiRBiY
    8Z604Nm65fJK7wiRqTqxkkNrSMhQb94WJvInAAcCwvyqV7Ag/JoCKzOMhIgTYDslEzN/
    ctHF4N5YV5vKnkz28PBOa4Q2R2HybSU1haWDoonGHbYeJLcIl4m5SWE8pmf6/ABGjKy8
    KlYMfNt+Ws/ga0GYHr5WJzJ5FFE3x8MC3R+Up+88nBzam/qFWA9g5CWoJNh3JRwT8lWu
    CF/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1697441859;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=AlaJj77DqQEREN4W2oqNqqXui1B4mTuRTUEpEAgS0r8=;
    b=5CUdjxelU8c93FFsQRaUtMK6Iyi5VN7qlbQyuc9UcIzmcjkUw+Hc/jaM0Ecs+TkH5D
    QCWq+1Fihukfm0oX+sCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA+p3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z9G7bcla6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 16 Oct 2023 09:37:38 +0200 (CEST)
Date:   Mon, 16 Oct 2023 09:37:31 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: msm8953: Set initial address for
 memory
Message-ID: <ZSzoO9QhwVmL8jLk@gerhold.net>
References: <20231015-msm8953-misc-fixes-v1-0-b800deca9e46@z3ntu.xyz>
 <20231015-msm8953-misc-fixes-v1-1-b800deca9e46@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015-msm8953-misc-fixes-v1-1-b800deca9e46@z3ntu.xyz>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 10:26:01PM +0200, Luca Weiss wrote:
> The dtbs_check really doesn't like having memory without reg set.
> Address this by setting it to 0x10000000 which seems to be the value
> filled in by the bootloader.
> 

Looks like MSM8953 has the same RAM setup as MSM8916, where the base
address depends on the amount of RAM you have:

  <= 2.00 GiB RAM: 0x80000000
   = 3.00 GiB RAM: 0x40000000
   = 3.75 GiB RAM: 0x10000000
 (more does not fit into the 32-bit physical address space)

So, 0x10000000 will only end up being used on devices with 3.75 GiB RAM.

Can you add a note about this in the commit message maybe? We don't know
in advance which base address a device will use, so I think it's fine to
hardcode one of the choices by default. msm8916.dtsi does the same.

Thanks,
Stephan

> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> index e7de7632669a..a3ba24ca599b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -174,10 +174,10 @@ scm: scm {
>  		};
>  	};
>  
> -	memory {
> +	memory@10000000 {
>  		device_type = "memory";
>  		/* We expect the bootloader to fill in the reg */
> -		reg = <0 0 0 0>;
> +		reg = <0 0x10000000 0 0>;
>  	};
>  
>  	pmu {
> 
> -- 
> 2.42.0
> 
