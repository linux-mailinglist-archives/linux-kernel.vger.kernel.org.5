Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6DE79F1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjIMTXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjIMTXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:23:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3791999;
        Wed, 13 Sep 2023 12:23:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6068C433C9;
        Wed, 13 Sep 2023 19:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694632999;
        bh=xHPajjcaSgUxOp3lOz5ae0i7Jgb7LDtoA5lxJzyLkK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mANMcwjV8QHwsSyVqiTrJGwP8QFXffhV48htFsUaqv7J9WPh7JhjKHYFMNOlTLRkx
         fKS0mjrpLcXyh7ju9iRJjE/2vmInTrfRdG0DQ28RQrI9ziDQNwOqVnFiVDQKZlie5F
         wB2OkIrtludGtehX+1oRpV19iBx5py8EQncT9DEqDQP5Wmvpx6z+F7IigXPH7nJ+68
         km3rxvjKI/SydyLsKCpPFwwet7jdTFYwerfCSps3TQuKgf3Zd8u/Mu9nELHfRwposc
         TufqJTqpibNw8AZhZUqJGfoX93OdDsduFP6/omlKK8pFXOgj+jUJrTixSm96b58/2k
         YsFsO1cWoq2hA==
Date:   Wed, 13 Sep 2023 12:27:24 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     srinivas.kandagatla@linaro.org,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] nvmem: core: Add stub for nvmem_cell_read_u8
Message-ID: <pvif5decuie62pid3zjpsb2tp5hzndxvww7v3jdhl6jkymbpcn@bjhud2hevjm6>
References: <20230830105654.28057-1-quic_kbajaj@quicinc.com>
 <20230830105654.28057-4-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830105654.28057-4-quic_kbajaj@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 04:26:51PM +0530, Komal Bajaj wrote:
> Add the stub nvmem_cell_read_u8() function for drivers running with
> CONFIG_NVMEM disabled.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>

Srini, do you have any concerns with me taking this together with the
remaining patches through my tree?

Regards,
Bjorn

> ---
>  include/linux/nvmem-consumer.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> index 4523e4e83319..6ec4b9743e25 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -127,6 +127,12 @@ static inline int nvmem_cell_write(struct nvmem_cell *cell,
>  	return -EOPNOTSUPP;
>  }
> 
> +static inline int nvmem_cell_read_u8(struct device *dev,
> +				     const char *cell_id, u8 *val)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline int nvmem_cell_read_u16(struct device *dev,
>  				      const char *cell_id, u16 *val)
>  {
> --
> 2.41.0
> 
