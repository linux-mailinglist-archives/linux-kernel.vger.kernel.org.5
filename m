Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A2379E394
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239269AbjIMJ03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjIMJ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:26:28 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0935B1999;
        Wed, 13 Sep 2023 02:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694597180; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jh7vTyw05MY3zs1yjcJ7pQj1CQ+ha8bZo1IOR5kK6OuUcV1N3H7AmaMnAoRG+n0pyL
    aN4CsHlampUTHKLKXmjvXLdK7wKALf2NeINRTBVfyh5l8qJrCUoDy/oBA54omuhNjzHM
    Re352kNT1/fR7+EPLUT+sEb/7/d+rMok+0kakMzaJ12EQnaORvO0PSWFJG4EIAF/nwJH
    U/f+Gpay5o8PzDa9W1KguC7ryvnwIWwb6MeVOfcARUsdRU13hgTixtGYaXcUUioJMyGB
    +qxbTfkJRs0nNeHIew/za2JQaRRm80DjnwMqVAWk1kKZ94hZ9vHx7VFMOg+59FH5gQs6
    bY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694597180;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=5CTXZnt4j2zCunCFXLIFwLCfjyTQk4HWDhbePahSWMo=;
    b=m+SEcaRbLb3aeHI3A8S1TxnxXahRpvT9usblEcgfbiSb8cXez+zxn2W3OdT1jzdcxV
    7GcD8ZBQ4t0dOgcmWRxYUwm4XRefV09pRu3pYWwl4gwOb/SvwBXjMJ+Oe9J1ttjx8oMa
    0xmkV8XxOx5J/O74UErrLmmabDOZiJWLQRY49h5JoD6gMIefDtEAjB+l+IZekyetwh2Y
    Q7YaU18XxWW3/nX8KFTtG2g3wgLdwmSeMiutnzgGiOiVGFB94agzpOiGZUKJujmCVjPI
    E5o/JbAKgYXir5peewd2hctyCXhN8vPt8G/9DFe7dw6d6TKfbSlISLSNlig+G26IHASd
    OpEQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694597180;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=5CTXZnt4j2zCunCFXLIFwLCfjyTQk4HWDhbePahSWMo=;
    b=lpWL5oJWRMe707OfzSm3HnsRmfuMrrl3zKQPhdGaXlETRhIeLEL+MZ88cx2bfvXEUu
    BB6oRV4JJLlDig+QBnw6k/2uLlojFuO47FfNaSOWpgeCXJVpB1Vc/MCTNSwG7fXf5pmt
    Brmj1ujU5swIXrb+jQ5ZwvHzB9PuPmu6sSQPPp/7918VovTEUatJC9fKeshYReFmVDwv
    63oXmIM48baCoJ2fAEKWuEJ0DkCjoaSLLzsA8YeVW+8Z2GGJtp5My9yEEhJqlE/3f7dB
    5kdkxZx5GU7biXExwlc0kYKO8roXedbNMXo9B/exOa32NeWuHVX83o5p6+RWEnxm7j+D
    VA5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694597180;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=5CTXZnt4j2zCunCFXLIFwLCfjyTQk4HWDhbePahSWMo=;
    b=Wvj+Z/LffVVSMzHsH2wr1O4pVcD0LB48YLwdXRgRNAEldlw1OiJkJQiuOi+XruZ6Ur
    EgWFW+JOmT0zkUnkeRBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8D9QJgbQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 13 Sep 2023 11:26:19 +0200 (CEST)
Date:   Wed, 13 Sep 2023 11:26:12 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] spi: qup: Vote for interconnect bandwidth to DRAM
Message-ID: <ZQGANOwy97w0RIHV@gerhold.net>
References: <20230912-spi-qup-dvfs-v1-0-3e38aa09c2bd@kernkonzept.com>
 <20230912-spi-qup-dvfs-v1-4-3e38aa09c2bd@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912-spi-qup-dvfs-v1-4-3e38aa09c2bd@kernkonzept.com>
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 04:30:39PM +0200, Stephan Gerhold wrote:
> When the SPI QUP controller is used together with a DMA engine it needs
> to vote for the interconnect path to the DRAM. Otherwise it may be
> unable to access the memory quickly enough.

I realized that I argue here that the interconnect vote is for DMA to
DRAM...

> [...]
> @@ -675,6 +698,12 @@ static int spi_qup_io_prep(struct spi_device *spi, struct spi_transfer *xfer)
>  		return -EIO;
>  	}
>  
> +	ret = spi_qup_vote_bw(controller, xfer->speed_hz);
> +	if (ret) {
> +		dev_err(controller->dev, "fail to vote for ICC bandwidth: %d\n", ret);
> +		return -EIO;
> +	}
> +

... but here I vote for the bandwidth even if PIO is used instead of DMA.

I think it would be more logical to only do the bandwidth vote in the
DMA setup path. I'll fix this in v2.

Thanks,
Stephan
