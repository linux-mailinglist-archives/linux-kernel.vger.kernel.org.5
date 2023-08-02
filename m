Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AF476C8EB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjHBJB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjHBJBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:01:16 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE417272D;
        Wed,  2 Aug 2023 02:01:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690966682; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Q/k3Lgf/XlQYCG7loQ+KXywduAQQ8jt4jdt0K4Bmyp96B0XhRj6/fJyzeHdiBZVWm/
    A1gqIZJWsbmZtj/RzgAVrmaW6lOn3XejDEnGbOieh85XQ4m/AWlP/8BrV21KRMN29Eib
    bEToRUX0S5IOM5pTFwPVmwl2oqk9rhO9hCWkNiemEB0CePhJp5GE4OQqtpWYjNpPi9c/
    DUMr6FWJWk/0RLuOs+eXEGkr6AngLw3VGNf9eTgE6f8YsnHmbFJagXmgFOVwz4isN6ab
    9gk5NaMrq1XEogUFprm0QQ4DdJPog6Zhy6hVBHWKevHKBXJ096gT5qa1GGG0IfihixrS
    Pskw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690966682;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=9gfOXaLYqA7n9aISMUCYty1dCdYf8XP7q3JR+0afV78=;
    b=TBM4bzuNNvnf2mN6J/mrB0Urxdz4kxECtMh9fEDzNxNoLyYL/OObQX7/71Px/zPHYK
    cKMHMFXtsRlnpwdWdBpR8C6hghghjuYVSxPr/mwkmhXt9ujCOMfHYwU/thfTP1/Jm89T
    KealC43swfdxc4Klg5V+6I7POiLIrIvhXFgIqC6Qwh/+uriAaIXq3wYsz6dfvVGFg8Xp
    q0F9I6uTeXI6/C9up1Tn0uA81uzjM3F6aMXa2W4/9InxY65hFdDKFAD0SeUgrSLHLtNM
    HDE8JRTI4O+eblP0/J1OUBZO64IBNXy95Y5exXS4IuwmWx98AvO+m+nZo7CWYo0i8RLv
    dU8A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690966682;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=9gfOXaLYqA7n9aISMUCYty1dCdYf8XP7q3JR+0afV78=;
    b=qmf6NbDKKZXq8jOWnBS+EkUoVSiww0DwU4Vta9uVyvrAv1SKlqoEEvjejf9EqhVNe4
    /zE/SB1LKsx1kig3Ti0KThWux6V9FioqnSTtvOVakB1IyXN9MPRH6LerxZXUKwUyrOBZ
    yxf/6Vr17T11RUVLqq0/vU/e3/qknm+a6WMPwrZFY3P3624f/DMtYcGzV9i8gxROLhLM
    I/eoh4rKFPxM1eDuHghQc3J22CvCtv4uc2Cm7QQ2u8h7E5KUguUyBOijeWl20PmTy5JS
    mCJYtPakTK0w3QX2NAWlhtELugwZv89KJUGWHnBLn57xh/Ky3n6GDF+XQPuX5F5Y1DqL
    Hgcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690966682;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=9gfOXaLYqA7n9aISMUCYty1dCdYf8XP7q3JR+0afV78=;
    b=9MLYpKfWhe9Wts/vrosi5h558l5IYUze+jap/igK0RvNaTgHKTrR+rZ6Mouo0vhihO
    buwaFmlH0zNjDLvlxaCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z+P1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.6 DYNA|AUTH)
    with ESMTPSA id k61817z728w2RE1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 2 Aug 2023 10:58:02 +0200 (CEST)
Date:   Wed, 2 Aug 2023 10:57:55 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Cc:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: venus: firmware: Use of_reserved_mem_lookup()
Message-ID: <ZMoak_qaUSX-pkP2@gerhold.net>
References: <20230529-venus-of-rmem-v1-1-dfcdc5047ffb@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529-venus-of-rmem-v1-1-dfcdc5047ffb@gerhold.net>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

I see that you already tagged the Venus updates for 6.6, but could you
try to still apply this patch as well for 6.6? It's a requirement for
some DT cleanup I'm working on and ideally needs to go in a kernel
release earlier to avoid bisect problems.

AFAICT it's been on the list for more than two months now with two
Reviewed-by, so should be fine to just apply it. :)

Thanks!
Stephan

On Mon, May 29, 2023 at 08:16:14PM +0200, Stephan Gerhold wrote:
> Reserved memory can be either looked up using the generic function
> of_address_to_resource() or using the special of_reserved_mem_lookup().
> The latter has the advantage that it ensures that the referenced memory
> region was really reserved and is not e.g. status = "disabled".
> 
> of_reserved_mem also supports allocating reserved memory dynamically at
> boot time. This works only when using of_reserved_mem_lookup() since
> there won't be a fixed address in the device tree.
> 
> Switch the code to use of_reserved_mem_lookup(). There is no functional
> difference for static reserved memory allocations.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> See e.g. [1] for an example of dynamically allocated reserved memory.
> (This patch does *not* depend on [1] and is useful without as well...)
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20230510-dt-resv-bottom-up-v1-5-3bf68873dbed@gerhold.net/
> ---
>  drivers/media/platform/qcom/venus/firmware.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index cfb11c551167..2e7ffdaff7b2 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -10,6 +10,7 @@
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_device.h>
>  #include <linux/firmware/qcom/qcom_scm.h>
> @@ -82,9 +83,9 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  			 phys_addr_t *mem_phys, size_t *mem_size)
>  {
>  	const struct firmware *mdt;
> +	struct reserved_mem *rmem;
>  	struct device_node *node;
>  	struct device *dev;
> -	struct resource r;
>  	ssize_t fw_size;
>  	void *mem_va;
>  	int ret;
> @@ -99,13 +100,16 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  		return -EINVAL;
>  	}
>  
> -	ret = of_address_to_resource(node, 0, &r);
> -	if (ret)
> -		goto err_put_node;
> +	rmem = of_reserved_mem_lookup(node);
> +	of_node_put(node);
> +	if (!rmem) {
> +		dev_err(dev, "failed to lookup reserved memory-region\n");
> +		return -EINVAL;
> +	}
>  
>  	ret = request_firmware(&mdt, fwname, dev);
>  	if (ret < 0)
> -		goto err_put_node;
> +		return ret;
>  
>  	fw_size = qcom_mdt_get_size(mdt);
>  	if (fw_size < 0) {
> @@ -113,17 +117,17 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  		goto err_release_fw;
>  	}
>  
> -	*mem_phys = r.start;
> -	*mem_size = resource_size(&r);
> +	*mem_phys = rmem->base;
> +	*mem_size = rmem->size;
>  
>  	if (*mem_size < fw_size || fw_size > VENUS_FW_MEM_SIZE) {
>  		ret = -EINVAL;
>  		goto err_release_fw;
>  	}
>  
> -	mem_va = memremap(r.start, *mem_size, MEMREMAP_WC);
> +	mem_va = memremap(*mem_phys, *mem_size, MEMREMAP_WC);
>  	if (!mem_va) {
> -		dev_err(dev, "unable to map memory region: %pR\n", &r);
> +		dev_err(dev, "unable to map memory region %pa size %#zx\n", mem_phys, *mem_size);
>  		ret = -ENOMEM;
>  		goto err_release_fw;
>  	}
> @@ -138,8 +142,6 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  	memunmap(mem_va);
>  err_release_fw:
>  	release_firmware(mdt);
> -err_put_node:
> -	of_node_put(node);
>  	return ret;
>  }
>  
> 
> ---
> base-commit: 9f9f8ca6f012d25428f8605cb36369a449db8508
> change-id: 20230529-venus-of-rmem-f649885114fd
> 
> Best regards,
> -- 
> Stephan Gerhold <stephan@gerhold.net>
> 
