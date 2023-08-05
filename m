Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68526771158
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjHESNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjHESM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:12:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2506D1BC;
        Sat,  5 Aug 2023 11:12:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B13C660DF5;
        Sat,  5 Aug 2023 18:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E81C433C8;
        Sat,  5 Aug 2023 18:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691259177;
        bh=7Ank85kDcL0zPfhDN0t1xq7zO6IsGA0dtJ/2WUZ+waE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bb+zTIsNLqu+2SKXjCsSMusMaRcGuy4hU2XQimgUOBNolviY5AnEbYiJR3iX9Y4vH
         ZiAYiOIYza4yTUqONU/E3IIaMaF46FlcA2hhnUVLDgz/Eq4DNLad9QsnaTQTd220Xr
         Zm4Qc0Z0rjhtO14N3NGP/6/dDPC4NcgJBSTTOZZNKC8llGvCWaHS5rN2VMxSJclE9D
         GtsvISqE5RD7ekbWLqldCKgLbcOeJiMcTIe8TcgzAlwdskQ7grG0fRy/JvzbJi6Xo4
         loKhslDGMwe1yn0wS4Lz7fGkY4fHk3NUO2K3UMsF8PKDwKTZxiwLFS7fu21Rm2gump
         zqJLaJ3srI9gg==
Date:   Sat, 5 Aug 2023 11:15:54 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v14 17/25] virt: gunyah: Translate gh_rm_hyp_resource
 into gunyah_resource
Message-ID: <erpdi657m5cwh24ofscunqbs3ko2u2brtyiryg7ealif5n5m4i@35mf55xvv5df>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-18-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613172054.3959700-18-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:20:45AM -0700, Elliot Berman wrote:
> diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
[..]
> +struct gh_resource *gh_rm_alloc_resource(struct gh_rm *rm, struct gh_rm_hyp_resource *hyp_resource)
> +{
> +	struct gh_resource *ghrsc;
> +	int ret;
> +
> +	ghrsc = kzalloc(sizeof(*ghrsc), GFP_KERNEL);
> +	if (!ghrsc)
> +		return NULL;
> +
> +	ghrsc->type = hyp_resource->type;
> +	ghrsc->capid = le64_to_cpu(hyp_resource->cap_id);
> +	ghrsc->irq = IRQ_NOTCONNECTED;
> +	ghrsc->rm_label = le32_to_cpu(hyp_resource->resource_label);
> +	if (hyp_resource->virq) {
> +		struct gh_irq_chip_data irq_data = {
> +			.gh_virq = le32_to_cpu(hyp_resource->virq),
> +		};
> +
> +		ret = irq_domain_alloc_irqs(rm->irq_domain, 1, NUMA_NO_NODE, &irq_data);
> +		if (ret < 0) {
> +			dev_err(rm->dev,
> +				"Failed to allocate interrupt for resource %d label: %d: %d\n",
> +				ghrsc->type, ghrsc->rm_label, ret);
> +			kfree(ghrsc);
> +			return NULL;
> +		} else {

No need for the else here, the failure case has already returned.

> +			ghrsc->irq = ret;
> +		}
> +	}
> +
> +	return ghrsc;
> +}
[..]
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> index 982e27d10d57f..4b398b59c2c5a 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -27,6 +27,9 @@ struct gh_resource {
>  	enum gh_resource_type type;
>  	u64 capid;
>  	unsigned int irq;
> +
> +	struct list_head list;

This is unused.

Regards,
Bjorn
