Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109587A9D49
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjIUTam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjIUTaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:30:07 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F8CAD957;
        Thu, 21 Sep 2023 11:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695319453; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JjgtlM1qT5peRew9uUMoUtgT2/JunfOouUA4TgH7RMjRCJf/7nfKu+ru+pifhtPdFX
    3ICcbIPOHtyusCdFPulR7EQv9Uct4D5zYhC+O5NVVAjCA6ChwKLTFNHqZFcLbd+qduFD
    KYvCbutM0E61oKWIkO/w4g9CgQr7gVZ9mGrZlhjSX3e08bcyi7SPsvTGmgd6ZL8WJoT0
    evWIoc/LXkiJAxW1MXcFOJvxWaRuJU+nl/sLTb5TUscN4qAvBkFuIiXgtx7YI+Eachhg
    89dDWjBzVaNu2aoQclREoqKvH5cgyXbagStXzwBQi6YA3cq1FlZO/nm33efnohEtD0hx
    Dp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695319453;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ER9Rl/dAAvA3/1hcaTkniApxXyi9907vmiYDjLpHhQU=;
    b=cBGZvzqZz+loVgGaSlYXg2fqn0eSCgaw84UnZYLdW/+gFfhLTFdVMO7UZ29Tvfzjeu
    o757p9ZdUUnzGyCSJG3Una9WIW/DR/DM3GQ6SioLXRQfoe51/IG3JRp+x1tU1eDDu4yb
    NF2V0ebblZTFEuypYOFKWG2lo2ISBQND7yOfGyainEV9Ye09P69pbsYvpMzDXxs9q1Wl
    HqDJh/1k3oHN/8wE9QTqU2MtnLt1hmhcgXcVxT0DzZUIPpzQUmynYescs9+MnVjGAt+p
    K0eYvIWTDtAEkKP/SjOjO6Cs07ZkaL9nPlCnU/6LvbXxJICUTOFLxYQiHD9ToFNLMhki
    h7tw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695319453;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ER9Rl/dAAvA3/1hcaTkniApxXyi9907vmiYDjLpHhQU=;
    b=CXgfIu6PKRYcEA5pamfwHgdUKe4UnFcMMOQBITnekEUVD6ygZXJD+H6XAPFLhfJ2zz
    mJwGc8kIM2mKWd/NrOg4tsxiiISxvfMAmxLCLWFnUySLHBKitw03V8ma4Mme4qfLIrZ2
    CG/EOS8diWeYuvgc/4Shv+jsSY+G7cMJJYGG/hEsWWpwzfSYaIrSWk4QB0hNA5a6mE6y
    IiZuBc3QwoPzNuXRdN3HuiMz91l5QRz3Fpd9lwHa7cy3T3B5PcBxHKTPPZn05fknrp7a
    bWNjvadJJgHMX/+Auof+XBM3MBjTPO8tDqFFOuAG7GSm5V/OJq+ZuBjfXZUQwiam55Mm
    C4Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695319453;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ER9Rl/dAAvA3/1hcaTkniApxXyi9907vmiYDjLpHhQU=;
    b=EFnJfmaS9VXsw64L4JveushSUYVIw38yNjjKOoqNLYG1L38gul3cNOAwj0/AEzk+j3
    WnzGDxAZQ7GmPU2qpbAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z+P1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8LI4DRMY
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 21 Sep 2023 20:04:13 +0200 (CEST)
Date:   Thu, 21 Sep 2023 20:04:06 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] soc: qcom: rmtfs: Support discarding guard pages
Message-ID: <ZQyFliFYV7dUwGJg@gerhold.net>
References: <20230920-rmtfs-mem-guard-pages-v3-0-305b37219b78@quicinc.com>
 <20230920-rmtfs-mem-guard-pages-v3-2-305b37219b78@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920-rmtfs-mem-guard-pages-v3-2-305b37219b78@quicinc.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 07:37:31PM -0700, Bjorn Andersson wrote:
> In some configurations, the exact placement of the rmtfs shared memory
> region isn't so strict. The DeviceTree author can then choose to use the
> "size" property and rely on the OS for placement (in combination with
> "alloc-ranges", if desired).
> 
> But on some platforms the rmtfs memory region may not be allocated
> adjacent to regions allocated by other clients. Add support for
> discarding the first and last 4k block in the region, if
> qcom,use-guard-pages is specified in DeviceTree.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/soc/qcom/rmtfs_mem.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> index f83811f51175..83bba9321e72 100644
> --- a/drivers/soc/qcom/rmtfs_mem.c
> +++ b/drivers/soc/qcom/rmtfs_mem.c
> @@ -200,6 +200,15 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  	rmtfs_mem->client_id = client_id;
>  	rmtfs_mem->size = rmem->size;
>  
> +	/*
> +	 * If requested, discard the first and last 4k block in order to ensure
> +	 * that the rmtfs region isn't adjacent to other protected regions.
> +	 */
> +	if (of_property_present(node, "qcom,use-guard-pages")) {

I think of_property_read_bool() would be more fitting here. Right now
of_property_present() is just a wrapper around of_property_read_bool().
Semantically reading a bool fits better here though. :-)

Feel free to fix that up while applying.

FWIW I don't really have an opinion if "qcom,use-guard-pages" is a good
way to describe this in the DT. For the implementation side feel free to
add my

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

Thanks,
Stephan

> +		rmtfs_mem->addr += SZ_4K;
> +		rmtfs_mem->size -= 2 * SZ_4K;
> +	}
> +
>  	device_initialize(&rmtfs_mem->dev);
>  	rmtfs_mem->dev.parent = &pdev->dev;
>  	rmtfs_mem->dev.groups = qcom_rmtfs_mem_groups;
> 
> -- 
> 2.25.1
> 
