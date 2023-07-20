Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C87775AEC1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjGTMv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjGTMu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:50:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA367110
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689857457; x=1721393457;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0AeQWKZgQumjGRyu50VkLRMKLVhVKVhQS0rXychQk0w=;
  b=LRdtQW3RMH/e4kDsMyWwwpJAIVLiXFGxaNN1kGUar6k18gTUFvrBF+nN
   Dg2x/49iM5NQRBnvO9tYJjnsxbdKKVQhot0DYaUZIwiAZSpZ2xByNXMXo
   T+U2JZTa0UnQR74olNKiQyELvd5BbinspSHZBI7AhhYcI1+AdMx2K1eJA
   v1/mYQqOERfS1H/OERJuKBFcj8vFP/p+2tyq4O8L3ucO70mQsaI4JUSlb
   tXD/uvB7SuSOU5nys4vo81I8fpHwhtXMqxLARTzPkj8c3/fwuG1TgMBDY
   hQ42vpnY9vsY/tIX4Yl4fDVhqWD2ab05/zJGqS8MA0j12MgxUUf+IZs50
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="453091707"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="453091707"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:50:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="848436243"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="848436243"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.109]) ([10.252.191.109])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:50:48 -0700
Message-ID: <2556751a-c439-bb69-a102-583dd985fc5e@linux.intel.com>
Date:   Thu, 20 Jul 2023 20:50:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Subject: Re: [PATCH 05/11] RISC-V: drivers/iommu/riscv: Add sysfs interface
Content-Language: en-US
To:     Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <610abe685f90870be52bc7c2ca45ab5235bd8eb4.1689792825.git.tjeznach@rivosinc.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <610abe685f90870be52bc7c2ca45ab5235bd8eb4.1689792825.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/20 3:33, Tomasz Jeznach wrote:
> +#define sysfs_dev_to_iommu(dev) \
> +	container_of(dev_get_drvdata(dev), struct riscv_iommu_device, iommu)
> +
> +static ssize_t address_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct riscv_iommu_device *iommu = sysfs_dev_to_iommu(dev);
> +	return sprintf(buf, "%llx\n", iommu->reg_phys);

Use sysfs_emit() please.

> +}
> +
> +static DEVICE_ATTR_RO(address);
> +
> +#define ATTR_RD_REG32(name, offset)					\
> +	ssize_t reg_ ## name ## _show(struct device *dev,		\
> +			struct device_attribute *attr, char *buf)	\
> +{									\
> +	struct riscv_iommu_device *iommu = sysfs_dev_to_iommu(dev);	\
> +	return sprintf(buf, "0x%x\n",					\
> +			riscv_iommu_readl(iommu, offset));		\
> +}
> +
> +#define ATTR_RD_REG64(name, offset)					\
> +	ssize_t reg_ ## name ## _show(struct device *dev,		\
> +			struct device_attribute *attr, char *buf)	\
> +{									\
> +	struct riscv_iommu_device *iommu = sysfs_dev_to_iommu(dev);	\
> +	return sprintf(buf, "0x%llx\n",					\
> +			riscv_iommu_readq(iommu, offset));		\
> +}
> +
> +#define ATTR_WR_REG32(name, offset)					\
> +	ssize_t reg_ ## name ## _store(struct device *dev,		\
> +			struct device_attribute *attr,			\
> +			const char *buf, size_t len)			\
> +{									\
> +	struct riscv_iommu_device *iommu = sysfs_dev_to_iommu(dev);	\
> +	unsigned long val;						\
> +	int ret;							\
> +	ret = kstrtoul(buf, 0, &val);					\
> +	if (ret)							\
> +		return ret;						\
> +	riscv_iommu_writel(iommu, offset, val);				\
> +	return len;							\
> +}
> +
> +#define ATTR_WR_REG64(name, offset)					\
> +	ssize_t reg_ ## name ## _store(struct device *dev,		\
> +			struct device_attribute *attr,			\
> +			const char *buf, size_t len)			\
> +{									\
> +	struct riscv_iommu_device *iommu = sysfs_dev_to_iommu(dev);	\
> +	unsigned long long val;						\
> +	int ret;							\
> +	ret = kstrtoull(buf, 0, &val);					\
> +	if (ret)							\
> +		return ret;						\
> +	riscv_iommu_writeq(iommu, offset, val);				\
> +	return len;							\
> +}

So this allows users to change the registers through sysfs? How does
it synchronize with the iommu driver?

Best regards,
baolu
