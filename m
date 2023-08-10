Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886FF777127
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjHJHTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjHJHTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:19:44 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC2410C;
        Thu, 10 Aug 2023 00:19:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1691651981; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RqlqJ1Kw8h3wcJyiyw9pg1k1rB/3C2+5Wke3f3dbz9Y5m3BhlM4+22vBcJjthQJ9F8
    t9iXKbZ+9+zRUSJOpTwB5t8Ue72E3M23t2MdD2UNsYNbKlArkZUlPC9pKGUfFXWz6Ly8
    pfkarTSoSxak75tl5uP7iZ8Y8UZjY9B1cS/dn0sn/1wtdNd9O8BwffKlt7bM8ee/AwqY
    ItMrRwdYwn4pMbQ2SWtROgHfeXWuDer9xqT/8kQlgwvn5h3khfLeGJbxHXmuWAlv7ztS
    +3x+us4iM13Y/KPiDqcnKdopRAIqBqZJUNpXpe/PjQwnBM3F5e3EiWhz/KnjDNp+tvq/
    hqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1691651981;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=O2PDmOcbHjPei4x7y9EfiO+A5zdOesrXbRmidgnJo5Y=;
    b=iqOEGZ70Z2N6GO57dxflFGfZH6lPMthlyC2FEeGQsJ8oQ8bJ143uosSf+3WsStuRNM
    1EWtM+AfnQpw8MphPLdh62c74GbeW/+pMjQwwtaiv/lKdzvmCxUAvFSZB/0IVaPznRFL
    x05c4cJClXOnFVq2El9G48un660YdRVe8LpQ5YmTIcRKO8KsYhq/C6LenSG+1ctVGwyL
    noips4QrGsrREcxth4PvSOPu5CpETPCl3Es6pF3/Wx7NQxB0ukrhQpfsHr8cAWDNSC5T
    aLTDkRBY9XSpCjU6ENxZEscB0rBEY3MM1nywnXC7TPassOOkPP/d5uVe4eegEVfUY7S6
    YlLA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1691651981;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=O2PDmOcbHjPei4x7y9EfiO+A5zdOesrXbRmidgnJo5Y=;
    b=LFYalGSvuZkn+Ln264GyL4BUIpHdZ/uI2d8VGfU1ReCKuL7yxcLx8HIWWiFraAVxbX
    OXUFhFGShJRD5950MtWyq26fOjZlWDjCUSe43ipVnDfH79VC88uiNxq5tE1CDKVDyFbv
    gZhMWUeYUgIJMlGXBpmaIXnByAmeJ36z6dtQ7ijjEWtuKJYN8d+suYuO0D0bOzzawVf+
    EEqoosQC/fqxqcdTim0zVhTPBK4TYKmFdWnbt9Zg2qTFqxA6FtOG8z57/eh1I2I5jPlw
    mlznAA7Cmw+NQglLyrqBH2dYMLTP8os4ryjyibNIpMPKGHzTjXeOYT4DEOH60Q4Chfh+
    DyDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1691651981;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=O2PDmOcbHjPei4x7y9EfiO+A5zdOesrXbRmidgnJo5Y=;
    b=KBoxmHsM6lS2b3Hxf2/DuuqEkIx+YMFhb6RCZeSPmqNIaW+byRCf0mQxk+0SXqbkJ/
    n/9flLjhhQ09gyEu71Aw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8p+L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.6 DYNA|AUTH)
    with ESMTPSA id k61817z7A7JepSg
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Aug 2023 09:19:40 +0200 (CEST)
Date:   Thu, 10 Aug 2023 09:19:39 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] pinctrl: qcom: sm6115: Add MPM pin mappings
Message-ID: <ZNSPi3mDScn9ZMNJ@gerhold.net>
References: <20230809-topic-mpm_mappings-v1-0-5e17dd76b3c8@linaro.org>
 <20230809-topic-mpm_mappings-v1-3-5e17dd76b3c8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809-topic-mpm_mappings-v1-3-5e17dd76b3c8@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:38:56PM +0200, Konrad Dybcio wrote:
> Add pin <-> wakeirq mappings to allow for waking up the AP from sleep
> through MPM-connected pins.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-sm6115.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm6115.c b/drivers/pinctrl/qcom/pinctrl-sm6115.c
> index 2a06025f4885..4e91c75ad952 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sm6115.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sm6115.c
> @@ -867,6 +867,16 @@ static const struct msm_pingroup sm6115_groups[] = {
>  	[120] = SDC_QDSD_PINGROUP(sdc2_data, SOUTH, 0x73000, 9, 0),
>  };
>  
> +static const struct msm_gpio_wakeirq_map sm6115_mpm_map[] = {
> +	{ 0, 84 }, { 3, 75 }, { 4, 16 }, { 6, 59 }, { 8, 63 }, { 11, 17 }, { 13, 18 },
> +	{ 14, 51 }, { 17, 20 }, { 18, 52 }, { 19, 53 }, { 24, 6 }, { 25, 71 }, { 27, 73 },
> +	{ 28, 41 }, { 31, 27 }, { 32, 54 }, { 33, 55 }, { 34, 56 }, { 35, 57 }, { 36, 58 },
> +	{ 39, 28 }, { 46, 29 }, { 62, 60 }, { 63, 61 }, { 64, 62 }, { 65, 30 }, { 66, 31 },
> +	{ 67, 32 }, { 69, 33 }, { 70, 34 }, { 72, 72 }, { 75, 35 }, { 79, 36 }, { 80, 21 },
> +	{ 81, 38 }, { 83, 9 }, { 84, 39 }, { 85, 40 }, { 86, 19 }, { 87, 42 }, { 88, 43 },
> +	{ 89, 45 }, { 91, 74 }, { 93, 46 }, { 94, 47 }, { 95, 48 }, { 96, 49 }, { 97, 50 },
> +};

Did you omit the mappings for GPIO 99-112 here on purpose?

The order here looks fine BTW. Maybe downstream changed the order and
you got confused? :)

Thanks,
Stephan
