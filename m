Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9359777FF44
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354991AbjHQUrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355028AbjHQUrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:47:06 -0400
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58CA35B8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:46:46 -0700 (PDT)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
        by cmsmtp with ESMTP
        id WdyCqkt1Xez0CWjt1q3w0U; Thu, 17 Aug 2023 20:46:32 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id WjtFquf5J1rJFWjtFq97TV; Thu, 17 Aug 2023 20:46:45 +0000
X-Authority-Analysis: v=2.4 cv=PYPsOwtd c=1 sm=1 tr=0 ts=64de8735
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=cm27Pg_UAAAA:8 a=-9WsS909tJ0spEJWnesA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=cvBusfyB2V15izCimMoJ:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=i5T8ndZFl8vyvsMJH3vQ714dMBof7MQxooIw2wR0TQ4=; b=XRy3wHexQQxKuhb/Rdaqonl2oI
        jutVrdKLHCgPOyRTv/THziwoQsxLUc0Z9+VDeQrBysFVd5ALmIwkoMLdXb2pRMc4Ah8AzWHfdQ3/K
        D5P3rtdjqiqJpiEwe7CDqfJ8OnOhpz4OUzygGS7zY2iQvjReZ64yVRrIMwZ8GW+e6y2DoJyCcpRlD
        T0t5zZ0y1HVn/tEtHjPVcUowpHN+ZYMPmnpKYHqHdtVDPP9PahjW9Qs50HA9GbRIjE/FShXMvRqUy
        4nTtTgnIu/1ovrgrWpLjPGKcSPIayaec1ieV2THaXdTLhKHhmMLMhLhJN2uQWs11AKxgMlozLQa18
        QeXq7qfw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:50972 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWjtD-001GLK-0h;
        Thu, 17 Aug 2023 15:46:43 -0500
Message-ID: <cba15a51-ce0a-4478-4616-8e542867d3ff@embeddedor.com>
Date:   Thu, 17 Aug 2023 14:47:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] interconnect: qcom: Annotate struct icc_onecell_data with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230817204215.never.916-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817204215.never.916-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qWjtD-001GLK-0h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:50972
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 42
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJYDNuRYgkIbGhorWn4h+8co6OBYC52rx0gxzo+nGeK9Vu44gq0CelRJ9JQSJl+EKeRKJvjfHof6Wd9bRZ6vo+NU+tYRhBnDQNzqX7ffJ99J4aD9RceB
 1MIHr0YstuIZrSnNc3fzI6JhZJi/mRGaVXT0mH9QKnv2HzmH+6TMKjjKk1l2Cuw7SBxWKoFagGXxwgr1y+YL9uVKL3qrE0YAgfDRBZOk3wUC1sixTgZl0jD6
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/23 14:42, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct icc_onecell_data.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Georgi Djakov <djakov@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/interconnect/qcom/icc-rpmh.c  | 3 +--
>   drivers/interconnect/qcom/msm8974.c   | 2 +-
>   drivers/interconnect/qcom/osm-l3.c    | 2 +-
>   include/linux/interconnect-provider.h | 2 +-
>   4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index 8053ec8ab01b..b9f27ce3b607 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -185,6 +185,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>   	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes), GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;
> +	data->num_nodes = num_nodes;
>   
>   	provider = &qp->provider;
>   	provider->dev = dev;
> @@ -228,8 +229,6 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>   		data->nodes[i] = node;
>   	}
>   
> -	data->num_nodes = num_nodes;
> -
>   	ret = icc_provider_register(provider);
>   	if (ret)
>   		goto err_remove_nodes;
> diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
> index b85cab2f208f..885ca9d6d4ed 100644
> --- a/drivers/interconnect/qcom/msm8974.c
> +++ b/drivers/interconnect/qcom/msm8974.c
> @@ -675,6 +675,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
>   			    GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;
> +	data->num_nodes = num_nodes;
>   
>   	qp->bus_clks = devm_kmemdup(dev, msm8974_icc_bus_clocks,
>   				    sizeof(msm8974_icc_bus_clocks), GFP_KERNEL);
> @@ -721,7 +722,6 @@ static int msm8974_icc_probe(struct platform_device *pdev)
>   
>   		data->nodes[i] = node;
>   	}
> -	data->num_nodes = num_nodes;
>   
>   	ret = icc_provider_register(provider);
>   	if (ret)
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> index 056ac91225c4..dc321bb86d0b 100644
> --- a/drivers/interconnect/qcom/osm-l3.c
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -232,6 +232,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>   	data = devm_kzalloc(&pdev->dev, struct_size(data, nodes, num_nodes), GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;
> +	data->num_nodes = num_nodes;
>   
>   	provider = &qp->provider;
>   	provider->dev = &pdev->dev;
> @@ -261,7 +262,6 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
>   
>   		data->nodes[i] = node;
>   	}
> -	data->num_nodes = num_nodes;
>   
>   	ret = icc_provider_register(provider);
>   	if (ret)
> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
> index e6d8aca6886d..7ba183f221f1 100644
> --- a/include/linux/interconnect-provider.h
> +++ b/include/linux/interconnect-provider.h
> @@ -33,7 +33,7 @@ struct icc_node_data {
>    */
>   struct icc_onecell_data {
>   	unsigned int num_nodes;
> -	struct icc_node *nodes[];
> +	struct icc_node *nodes[] __counted_by(num_nodes);
>   };
>   
>   struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
