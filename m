Return-Path: <linux-kernel+bounces-153639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2377D8AD0F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28441F23095
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D3E15351A;
	Mon, 22 Apr 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HHmJO+F+"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4D91534EB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800037; cv=none; b=LWwMlj42TIKW8J2DLKR0ME5YDDRqIXiW6XDcnDRCh0PJD1p2mcX3BMwEktd/qCpDvbmsWj8PLe/iV85Z9G649dAwx8hPqSi8Y8XfkefPq9MuGLQQ3BhC/cgxxkW60dUn9dBcYEqhOjfinvoWzr7kSTqGmP/0tVK3EYJnc2fa/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800037; c=relaxed/simple;
	bh=irdtWnpnc/sFcWuh/FSKxtLO6PVCadV+GOlUWl825wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXs7qdMlpf23PhkKoX/YYQYIOh2FB742Kh3/f9aKCVP9DZbDNZhrv3RsLdTT91MnOuuQc0Yle17aIE9mfbFRRCQh2rXGLGpXFdM0tJXgeRVmQTE7IcHUFM896Tw4ZWX2NhU6pi4ogLG8LxN/YNJogiI25WurA17d4sRr+krtADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HHmJO+F+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6eff9dc1821so4496733b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713800034; x=1714404834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6I/SOw0pUiSSjpPPaHWiOVLaLSAV+6ewHL/rVDMpowo=;
        b=HHmJO+F+QBWGrQrIaFgklul7xdKfh4XUf9D79fWw5wVG7SkQuSiC12E8dZxJD7GSG+
         RUKpHoPnGTWwACYXWQe6CQl2DY5kNcI5AxT2u3VGXRaZsI1mQ4Hf+dDCptptp3IEsFcA
         56qpJj+y6zhRj0qcSSx8wMas7ldvnVTkYtQiTSeUO+sZsDxg0cdwo4oYBfLdRokbcNnf
         ltXwo99d3PpKg8gMcJc4lHLbhqEfScx9bi9Zlb3We/IJdIHvR2ohJNj809fhrQ8+9vWR
         Ny06X4Ljs4nXImjIZdzU5P421lHJXlmyYlFZ9hWGuEUbbbwUkjAASEjPyakEMMPK7ysj
         I0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800034; x=1714404834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6I/SOw0pUiSSjpPPaHWiOVLaLSAV+6ewHL/rVDMpowo=;
        b=Y/TFVRk+byCybPL+sgqw/IlkhVUWafPsIHhnDyWZRXktBaHQassjtf4Yy2aztdziSQ
         70fV4OswzYqf+L5wkkavaMbCeeMpBTRA2CXMzyoT7mwmbqnNZPb+M/PZrane/feCYPog
         X3bY3PdZQJYawibrb8aImaof4X26kLZkn2FzPTpg5iZruteaIXiadxXw789+SDcUTieB
         uYdgXdLXgtztGFilejrltBbI/b85W6qiwgFMMSlgHV12c5ibToIr7L2SDAU8bH3DYoDw
         Ai8URoGgKWq7QySYy3UkHKlAAm0+qO0QZ6MaIBcsOfwH9ByxhT30w0MIuzwTbM59eR6C
         vdFA==
X-Forwarded-Encrypted: i=1; AJvYcCW0ITapfxS9FvJFfOPEkkDnc2wz3EakJc91zRinl00AH65KUJJD5X7eCNF0wAOoFVUqBYfWKoYvzJkbudGT4h3byldBtBjmDgCImkTX
X-Gm-Message-State: AOJu0YzJfj+wIQFLI+wNZLKVaaKrtwuj0DawTOa0fCVYqIpDkdmI5YUG
	PivzE1YjZJYBQlUpkYpbOTf7pOWU68uOK1+Dsr8H1JHFH8jUp3xbNFOXIGzC3a8=
X-Google-Smtp-Source: AGHT+IESRvln7rh8eB+yJt/tbRZN/zTg5uJsuuGTINVfKnsg5lO1od5Ktq5lpKD+C397LmEzhzAj4A==
X-Received: by 2002:a17:902:c405:b0:1e4:6e70:25d8 with SMTP id k5-20020a170902c40500b001e46e7025d8mr12302945plk.13.1713800034239;
        Mon, 22 Apr 2024 08:33:54 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:b2a0:f51d:b8f7:33f5])
        by smtp.gmail.com with ESMTPSA id kf12-20020a17090305cc00b001e43a00ee07sm8269533plb.211.2024.04.22.08.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:33:53 -0700 (PDT)
Date: Mon, 22 Apr 2024 09:33:50 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Olivia Wen <olivia.wen@mediatek.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Tinghan Shen <tinghan.shen@mediatek.com>,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	jason-ch.chen@mediatek.com, yaya.chang@mediatek.com,
	teddy.chen@mediatek.com
Subject: Re: [PATCH v2 2/2] remoteproc: mediatek: Support MT8188 SCP core 1
Message-ID: <ZiaDXnFrjEcCxu7Y@p14s>
References: <20240419084211.31901-1-olivia.wen@mediatek.com>
 <20240419084211.31901-3-olivia.wen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419084211.31901-3-olivia.wen@mediatek.com>

Hi Olivia,

On Fri, Apr 19, 2024 at 04:42:11PM +0800, Olivia Wen wrote:
> From: "olivia.wen" <olivia.wen@mediatek.com>
> 
> There are three primary modifications.
> 
> 1. The struct mtk_scp_of_data usage on MT8188
> MT8192 functions are unsuitable for the dual-core MT8188 SCP,
> which has two RISC-V cores similar to MT8195 but without L1TCM.
> We've added MT8188-specific functions to configure L1TCM
> in multicore setups.
> 
> 2. SCP_IPI_IMGSYS_CMD feature
> This version also adds SCP_IPI_IMGSYS_CMD to facilitate
> communication between the imgsys kernel and the backend driver.
> 
> 3. Different code sizes and IPI share buffer sizes
> Each SCP necessitates different code and IPI share buffer sizes.
> Introducing a structure mtk_scp_sizes_data to handle them.
> 

Please split in 3 different patches and in the changelog, concentrate on "why"
you are making the changes rather than "what" changes are done.

Thanks,
Mathieu

> Signed-off-by: olivia.wen <olivia.wen@mediatek.com>
> ---
>  drivers/remoteproc/mtk_common.h    |  11 +-
>  drivers/remoteproc/mtk_scp.c       | 230 +++++++++++++++++++++++++++++++++----
>  drivers/remoteproc/mtk_scp_ipi.c   |   7 +-
>  include/linux/remoteproc/mtk_scp.h |   1 +
>  4 files changed, 223 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index 6d7736a..fd5c539 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -78,7 +78,6 @@
>  #define MT8195_L2TCM_OFFSET			0x850d0
>  
>  #define SCP_FW_VER_LEN			32
> -#define SCP_SHARE_BUFFER_SIZE		288
>  
>  struct scp_run {
>  	u32 signaled;
> @@ -97,6 +96,11 @@ struct scp_ipi_desc {
>  
>  struct mtk_scp;
>  
> +struct mtk_scp_sizes_data {
> +	size_t max_dram_size;
> +	size_t ipi_share_buffer_size;
> +};
> +
>  struct mtk_scp_of_data {
>  	int (*scp_clk_get)(struct mtk_scp *scp);
>  	int (*scp_before_load)(struct mtk_scp *scp);
> @@ -110,6 +114,7 @@ struct mtk_scp_of_data {
>  	u32 host_to_scp_int_bit;
>  
>  	size_t ipi_buf_offset;
> +	const struct mtk_scp_sizes_data *scp_sizes;
>  };
>  
>  struct mtk_scp_of_cluster {
> @@ -141,10 +146,10 @@ struct mtk_scp {
>  	struct scp_ipi_desc ipi_desc[SCP_IPI_MAX];
>  	bool ipi_id_ack[SCP_IPI_MAX];
>  	wait_queue_head_t ack_wq;
> +	u8 *share_buf;
>  
>  	void *cpu_addr;
>  	dma_addr_t dma_addr;
> -	size_t dram_size;
>  
>  	struct rproc_subdev *rpmsg_subdev;
>  
> @@ -162,7 +167,7 @@ struct mtk_scp {
>  struct mtk_share_obj {
>  	u32 id;
>  	u32 len;
> -	u8 share_buf[SCP_SHARE_BUFFER_SIZE];
> +	u8 *share_buf;
>  };
>  
>  void scp_memcpy_aligned(void __iomem *dst, const void *src, unsigned int len);
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 6751829..e281d28 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -20,7 +20,6 @@
>  #include "mtk_common.h"
>  #include "remoteproc_internal.h"
>  
> -#define MAX_CODE_SIZE 0x500000
>  #define SECTION_NAME_IPI_BUFFER ".ipi_buffer"
>  
>  /**
> @@ -94,14 +93,15 @@ static void scp_ipi_handler(struct mtk_scp *scp)
>  {
>  	struct mtk_share_obj __iomem *rcv_obj = scp->recv_buf;
>  	struct scp_ipi_desc *ipi_desc = scp->ipi_desc;
> -	u8 tmp_data[SCP_SHARE_BUFFER_SIZE];
>  	scp_ipi_handler_t handler;
>  	u32 id = readl(&rcv_obj->id);
>  	u32 len = readl(&rcv_obj->len);
> +	const struct mtk_scp_sizes_data *scp_sizes;
>  
> -	if (len > SCP_SHARE_BUFFER_SIZE) {
> -		dev_err(scp->dev, "ipi message too long (len %d, max %d)", len,
> -			SCP_SHARE_BUFFER_SIZE);
> +	scp_sizes = scp->data->scp_sizes;
> +	if (len > scp_sizes->ipi_share_buffer_size) {
> +		dev_err(scp->dev, "ipi message too long (len %d, max %zd)", len,
> +			scp_sizes->ipi_share_buffer_size);
>  		return;
>  	}
>  	if (id >= SCP_IPI_MAX) {
> @@ -117,8 +117,9 @@ static void scp_ipi_handler(struct mtk_scp *scp)
>  		return;
>  	}
>  
> -	memcpy_fromio(tmp_data, &rcv_obj->share_buf, len);
> -	handler(tmp_data, len, ipi_desc[id].priv);
> +	memset(scp->share_buf, 0, scp_sizes->ipi_share_buffer_size);
> +	memcpy_fromio(scp->share_buf, &rcv_obj->share_buf, len);
> +	handler(scp->share_buf, len, ipi_desc[id].priv);
>  	scp_ipi_unlock(scp, id);
>  
>  	scp->ipi_id_ack[id] = true;
> @@ -133,6 +134,8 @@ static int scp_ipi_init(struct mtk_scp *scp, const struct firmware *fw)
>  {
>  	int ret;
>  	size_t buf_sz, offset;
> +	size_t share_buf_offset;
> +	const struct mtk_scp_sizes_data *scp_sizes;
>  
>  	/* read the ipi buf addr from FW itself first */
>  	ret = scp_elf_read_ipi_buf_addr(scp, fw, &offset);
> @@ -152,12 +155,15 @@ static int scp_ipi_init(struct mtk_scp *scp, const struct firmware *fw)
>  		return -EOVERFLOW;
>  	}
>  
> +	scp_sizes = scp->data->scp_sizes;
>  	scp->recv_buf = (struct mtk_share_obj __iomem *)
>  			(scp->sram_base + offset);
> +	share_buf_offset = sizeof(scp->recv_buf->id)
> +		+ sizeof(scp->recv_buf->len) + scp_sizes->ipi_share_buffer_size;
>  	scp->send_buf = (struct mtk_share_obj __iomem *)
> -			(scp->sram_base + offset + sizeof(*scp->recv_buf));
> -	memset_io(scp->recv_buf, 0, sizeof(*scp->recv_buf));
> -	memset_io(scp->send_buf, 0, sizeof(*scp->send_buf));
> +			(scp->sram_base + offset + share_buf_offset);
> +	memset_io(scp->recv_buf, 0, share_buf_offset);
> +	memset_io(scp->send_buf, 0, share_buf_offset);
>  
>  	return 0;
>  }
> @@ -471,6 +477,86 @@ static int mt8186_scp_before_load(struct mtk_scp *scp)
>  	return 0;
>  }
>  
> +static int mt8188_scp_l2tcm_on(struct mtk_scp *scp)
> +{
> +	struct mtk_scp_of_cluster *scp_cluster = scp->cluster;
> +
> +	mutex_lock(&scp_cluster->cluster_lock);
> +
> +	if (scp_cluster->l2tcm_refcnt == 0) {
> +		/* clear SPM interrupt, SCP2SPM_IPC_CLR */
> +		writel(0xff, scp->cluster->reg_base + MT8192_SCP2SPM_IPC_CLR);
> +
> +		/* Power on L2TCM */
> +		scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> +		scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> +		scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> +		scp_sram_power_on(scp->cluster->reg_base + MT8192_L1TCM_SRAM_PDN, 0);
> +	}
> +
> +	scp_cluster->l2tcm_refcnt += 1;
> +
> +	mutex_unlock(&scp_cluster->cluster_lock);
> +
> +	return 0;
> +}
> +
> +static int mt8188_scp_before_load(struct mtk_scp *scp)
> +{
> +	writel(1, scp->cluster->reg_base + MT8192_CORE0_SW_RSTN_SET);
> +
> +	mt8188_scp_l2tcm_on(scp);
> +
> +	scp_sram_power_on(scp->cluster->reg_base + MT8192_CPU0_SRAM_PD, 0);
> +
> +	/* enable MPU for all memory regions */
> +	writel(0xff, scp->cluster->reg_base + MT8192_CORE0_MEM_ATT_PREDEF);
> +
> +	return 0;
> +}
> +
> +static int mt8188_scp_c1_before_load(struct mtk_scp *scp)
> +{
> +	u32 sec_ctrl;
> +	struct mtk_scp *scp_c0;
> +	struct mtk_scp_of_cluster *scp_cluster = scp->cluster;
> +
> +	scp->data->scp_reset_assert(scp);
> +
> +	mt8188_scp_l2tcm_on(scp);
> +
> +	scp_sram_power_on(scp->cluster->reg_base + MT8195_CPU1_SRAM_PD, 0);
> +
> +	/* enable MPU for all memory regions */
> +	writel(0xff, scp->cluster->reg_base + MT8195_CORE1_MEM_ATT_PREDEF);
> +
> +	/*
> +	 * The L2TCM_OFFSET_RANGE and L2TCM_OFFSET shift the destination address
> +	 * on SRAM when SCP core 1 accesses SRAM.
> +	 *
> +	 * This configuration solves booting the SCP core 0 and core 1 from
> +	 * different SRAM address because core 0 and core 1 both boot from
> +	 * the head of SRAM by default. this must be configured before boot SCP core 1.
> +	 *
> +	 * The value of L2TCM_OFFSET_RANGE is from the viewpoint of SCP core 1.
> +	 * When SCP core 1 issues address within the range (L2TCM_OFFSET_RANGE),
> +	 * the address will be added with a fixed offset (L2TCM_OFFSET) on the bus.
> +	 * The shift action is tranparent to software.
> +	 */
> +	writel(0, scp->cluster->reg_base + MT8195_L2TCM_OFFSET_RANGE_0_LOW);
> +	writel(scp->sram_size, scp->cluster->reg_base + MT8195_L2TCM_OFFSET_RANGE_0_HIGH);
> +
> +	scp_c0 = list_first_entry(&scp_cluster->mtk_scp_list, struct mtk_scp, elem);
> +	writel(scp->sram_phys - scp_c0->sram_phys, scp->cluster->reg_base + MT8195_L2TCM_OFFSET);
> +
> +	/* enable SRAM offset when fetching instruction and data */
> +	sec_ctrl = readl(scp->cluster->reg_base + MT8195_SEC_CTRL);
> +	sec_ctrl |= MT8195_CORE_OFFSET_ENABLE_I | MT8195_CORE_OFFSET_ENABLE_D;
> +	writel(sec_ctrl, scp->cluster->reg_base + MT8195_SEC_CTRL);
> +
> +	return 0;
> +}
> +
>  static int mt8192_scp_before_load(struct mtk_scp *scp)
>  {
>  	/* clear SPM interrupt, SCP2SPM_IPC_CLR */
> @@ -661,14 +747,16 @@ static int scp_start(struct rproc *rproc)
>  static void *mt8183_scp_da_to_va(struct mtk_scp *scp, u64 da, size_t len)
>  {
>  	int offset;
> +	const struct mtk_scp_sizes_data *scp_sizes;
>  
> +	scp_sizes = scp->data->scp_sizes;
>  	if (da < scp->sram_size) {
>  		offset = da;
>  		if (offset >= 0 && (offset + len) <= scp->sram_size)
>  			return (void __force *)scp->sram_base + offset;
> -	} else if (scp->dram_size) {
> +	} else if (scp_sizes->max_dram_size) {
>  		offset = da - scp->dma_addr;
> -		if (offset >= 0 && (offset + len) <= scp->dram_size)
> +		if (offset >= 0 && (offset + len) <= scp_sizes->max_dram_size)
>  			return scp->cpu_addr + offset;
>  	}
>  
> @@ -678,7 +766,9 @@ static void *mt8183_scp_da_to_va(struct mtk_scp *scp, u64 da, size_t len)
>  static void *mt8192_scp_da_to_va(struct mtk_scp *scp, u64 da, size_t len)
>  {
>  	int offset;
> +	const struct mtk_scp_sizes_data *scp_sizes;
>  
> +	scp_sizes = scp->data->scp_sizes;
>  	if (da >= scp->sram_phys &&
>  	    (da + len) <= scp->sram_phys + scp->sram_size) {
>  		offset = da - scp->sram_phys;
> @@ -694,9 +784,9 @@ static void *mt8192_scp_da_to_va(struct mtk_scp *scp, u64 da, size_t len)
>  	}
>  
>  	/* optional memory region */
> -	if (scp->dram_size &&
> +	if (scp_sizes->max_dram_size &&
>  	    da >= scp->dma_addr &&
> -	    (da + len) <= scp->dma_addr + scp->dram_size) {
> +	    (da + len) <= scp->dma_addr + scp_sizes->max_dram_size) {
>  		offset = da - scp->dma_addr;
>  		return scp->cpu_addr + offset;
>  	}
> @@ -717,6 +807,47 @@ static void mt8183_scp_stop(struct mtk_scp *scp)
>  	writel(0, scp->cluster->reg_base + MT8183_WDT_CFG);
>  }
>  
> +static void mt8188_scp_l2tcm_off(struct mtk_scp *scp)
> +{
> +	struct mtk_scp_of_cluster *scp_cluster = scp->cluster;
> +
> +	mutex_lock(&scp_cluster->cluster_lock);
> +
> +	if (scp_cluster->l2tcm_refcnt > 0)
> +		scp_cluster->l2tcm_refcnt -= 1;
> +
> +	if (scp_cluster->l2tcm_refcnt == 0) {
> +		/* Power off L2TCM */
> +		scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> +		scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> +		scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> +		scp_sram_power_off(scp->cluster->reg_base + MT8192_L1TCM_SRAM_PDN, 0);
> +	}
> +
> +	mutex_unlock(&scp_cluster->cluster_lock);
> +}
> +
> +static void mt8188_scp_stop(struct mtk_scp *scp)
> +{
> +	mt8188_scp_l2tcm_off(scp);
> +
> +	scp_sram_power_off(scp->cluster->reg_base + MT8192_CPU0_SRAM_PD, 0);
> +
> +	/* Disable SCP watchdog */
> +	writel(0, scp->cluster->reg_base + MT8192_CORE0_WDT_CFG);
> +}
> +
> +static void mt8188_scp_c1_stop(struct mtk_scp *scp)
> +{
> +	mt8188_scp_l2tcm_off(scp);
> +
> +	/* Power off CPU SRAM */
> +	scp_sram_power_off(scp->cluster->reg_base + MT8195_CPU1_SRAM_PD, 0);
> +
> +	/* Disable SCP watchdog */
> +	writel(0, scp->cluster->reg_base + MT8195_CORE1_WDT_CFG);
> +}
> +
>  static void mt8192_scp_stop(struct mtk_scp *scp)
>  {
>  	/* Disable SRAM clock */
> @@ -876,6 +1007,7 @@ EXPORT_SYMBOL_GPL(scp_mapping_dm_addr);
>  static int scp_map_memory_region(struct mtk_scp *scp)
>  {
>  	int ret;
> +	const struct mtk_scp_sizes_data *scp_sizes;
>  
>  	ret = of_reserved_mem_device_init(scp->dev);
>  
> @@ -891,8 +1023,8 @@ static int scp_map_memory_region(struct mtk_scp *scp)
>  	}
>  
>  	/* Reserved SCP code size */
> -	scp->dram_size = MAX_CODE_SIZE;
> -	scp->cpu_addr = dma_alloc_coherent(scp->dev, scp->dram_size,
> +	scp_sizes = scp->data->scp_sizes;
> +	scp->cpu_addr = dma_alloc_coherent(scp->dev, scp_sizes->max_dram_size,
>  					   &scp->dma_addr, GFP_KERNEL);
>  	if (!scp->cpu_addr)
>  		return -ENOMEM;
> @@ -902,10 +1034,13 @@ static int scp_map_memory_region(struct mtk_scp *scp)
>  
>  static void scp_unmap_memory_region(struct mtk_scp *scp)
>  {
> -	if (scp->dram_size == 0)
> +	const struct mtk_scp_sizes_data *scp_sizes;
> +
> +	scp_sizes = scp->data->scp_sizes;
> +	if (scp_sizes->max_dram_size == 0)
>  		return;
>  
> -	dma_free_coherent(scp->dev, scp->dram_size, scp->cpu_addr,
> +	dma_free_coherent(scp->dev, scp_sizes->max_dram_size, scp->cpu_addr,
>  			  scp->dma_addr);
>  	of_reserved_mem_device_release(scp->dev);
>  }
> @@ -969,6 +1104,7 @@ static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
>  	struct resource *res;
>  	const char *fw_name = "scp.img";
>  	int ret, i;
> +	const struct mtk_scp_sizes_data *scp_sizes;
>  
>  	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
>  	if (ret < 0 && ret != -EINVAL)
> @@ -1016,6 +1152,13 @@ static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
>  		goto release_dev_mem;
>  	}
>  
> +	scp_sizes = scp->data->scp_sizes;
> +	scp->share_buf = kzalloc(scp_sizes->ipi_share_buffer_size, GFP_KERNEL);
> +	if (!scp->share_buf) {
> +		dev_err(dev, "Failed to allocate IPI share buffer\n");
> +		goto release_dev_mem;
> +	}
> +
>  	init_waitqueue_head(&scp->run.wq);
>  	init_waitqueue_head(&scp->ack_wq);
>  
> @@ -1035,6 +1178,8 @@ static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
>  remove_subdev:
>  	scp_remove_rpmsg_subdev(scp);
>  	scp_ipi_unregister(scp, SCP_IPI_INIT);
> +	kfree(scp->share_buf);
> +	scp->share_buf = NULL;
>  release_dev_mem:
>  	scp_unmap_memory_region(scp);
>  	for (i = 0; i < SCP_IPI_MAX; i++)
> @@ -1050,6 +1195,8 @@ static void scp_free(struct mtk_scp *scp)
>  
>  	scp_remove_rpmsg_subdev(scp);
>  	scp_ipi_unregister(scp, SCP_IPI_INIT);
> +	kfree(scp->share_buf);
> +	scp->share_buf = NULL;
>  	scp_unmap_memory_region(scp);
>  	for (i = 0; i < SCP_IPI_MAX; i++)
>  		mutex_destroy(&scp->ipi_desc[i].lock);
> @@ -1236,6 +1383,21 @@ static void scp_remove(struct platform_device *pdev)
>  	mutex_destroy(&scp_cluster->cluster_lock);
>  }
>  
> +static const struct mtk_scp_sizes_data default_scp_sizes = {
> +	.max_dram_size = 0x500000,
> +	.ipi_share_buffer_size = 288,
> +};
> +
> +static const struct mtk_scp_sizes_data mt8188_scp_sizes = {
> +	.max_dram_size = 0x500000,
> +	.ipi_share_buffer_size = 600,
> +};
> +
> +static const struct mtk_scp_sizes_data mt8188_scp_c1_sizes = {
> +	.max_dram_size = 0xA00000,
> +	.ipi_share_buffer_size = 600,
> +};
> +
>  static const struct mtk_scp_of_data mt8183_of_data = {
>  	.scp_clk_get = mt8183_scp_clk_get,
>  	.scp_before_load = mt8183_scp_before_load,
> @@ -1247,6 +1409,7 @@ static const struct mtk_scp_of_data mt8183_of_data = {
>  	.host_to_scp_reg = MT8183_HOST_TO_SCP,
>  	.host_to_scp_int_bit = MT8183_HOST_IPC_INT_BIT,
>  	.ipi_buf_offset = 0x7bdb0,
> +	.scp_sizes = &default_scp_sizes,
>  };
>  
>  static const struct mtk_scp_of_data mt8186_of_data = {
> @@ -1260,18 +1423,33 @@ static const struct mtk_scp_of_data mt8186_of_data = {
>  	.host_to_scp_reg = MT8183_HOST_TO_SCP,
>  	.host_to_scp_int_bit = MT8183_HOST_IPC_INT_BIT,
>  	.ipi_buf_offset = 0x3bdb0,
> +	.scp_sizes = &default_scp_sizes,
>  };
>  
>  static const struct mtk_scp_of_data mt8188_of_data = {
>  	.scp_clk_get = mt8195_scp_clk_get,
> -	.scp_before_load = mt8192_scp_before_load,
> -	.scp_irq_handler = mt8192_scp_irq_handler,
> +	.scp_before_load = mt8188_scp_before_load,
> +	.scp_irq_handler = mt8195_scp_irq_handler,
>  	.scp_reset_assert = mt8192_scp_reset_assert,
>  	.scp_reset_deassert = mt8192_scp_reset_deassert,
> -	.scp_stop = mt8192_scp_stop,
> +	.scp_stop = mt8188_scp_stop,
>  	.scp_da_to_va = mt8192_scp_da_to_va,
>  	.host_to_scp_reg = MT8192_GIPC_IN_SET,
>  	.host_to_scp_int_bit = MT8192_HOST_IPC_INT_BIT,
> +	.scp_sizes = &mt8188_scp_sizes,
> +};
> +
> +static const struct mtk_scp_of_data mt8188_of_data_c1 = {
> +	.scp_clk_get = mt8195_scp_clk_get,
> +	.scp_before_load = mt8188_scp_c1_before_load,
> +	.scp_irq_handler = mt8195_scp_c1_irq_handler,
> +	.scp_reset_assert = mt8195_scp_c1_reset_assert,
> +	.scp_reset_deassert = mt8195_scp_c1_reset_deassert,
> +	.scp_stop = mt8188_scp_c1_stop,
> +	.scp_da_to_va = mt8192_scp_da_to_va,
> +	.host_to_scp_reg = MT8192_GIPC_IN_SET,
> +	.host_to_scp_int_bit = MT8195_CORE1_HOST_IPC_INT_BIT,
> +	.scp_sizes = &mt8188_scp_c1_sizes,
>  };
>  
>  static const struct mtk_scp_of_data mt8192_of_data = {
> @@ -1284,6 +1462,7 @@ static const struct mtk_scp_of_data mt8192_of_data = {
>  	.scp_da_to_va = mt8192_scp_da_to_va,
>  	.host_to_scp_reg = MT8192_GIPC_IN_SET,
>  	.host_to_scp_int_bit = MT8192_HOST_IPC_INT_BIT,
> +	.scp_sizes = &default_scp_sizes,
>  };
>  
>  static const struct mtk_scp_of_data mt8195_of_data = {
> @@ -1296,6 +1475,7 @@ static const struct mtk_scp_of_data mt8195_of_data = {
>  	.scp_da_to_va = mt8192_scp_da_to_va,
>  	.host_to_scp_reg = MT8192_GIPC_IN_SET,
>  	.host_to_scp_int_bit = MT8192_HOST_IPC_INT_BIT,
> +	.scp_sizes = &default_scp_sizes,
>  };
>  
>  static const struct mtk_scp_of_data mt8195_of_data_c1 = {
> @@ -1308,6 +1488,13 @@ static const struct mtk_scp_of_data mt8195_of_data_c1 = {
>  	.scp_da_to_va = mt8192_scp_da_to_va,
>  	.host_to_scp_reg = MT8192_GIPC_IN_SET,
>  	.host_to_scp_int_bit = MT8195_CORE1_HOST_IPC_INT_BIT,
> +	.scp_sizes = &default_scp_sizes,
> +};
> +
> +static const struct mtk_scp_of_data *mt8188_of_data_cores[] = {
> +	&mt8188_of_data,
> +	&mt8188_of_data_c1,
> +	NULL
>  };
>  
>  static const struct mtk_scp_of_data *mt8195_of_data_cores[] = {
> @@ -1320,6 +1507,7 @@ static const struct of_device_id mtk_scp_of_match[] = {
>  	{ .compatible = "mediatek,mt8183-scp", .data = &mt8183_of_data },
>  	{ .compatible = "mediatek,mt8186-scp", .data = &mt8186_of_data },
>  	{ .compatible = "mediatek,mt8188-scp", .data = &mt8188_of_data },
> +	{ .compatible = "mediatek,mt8188-scp-dual", .data = &mt8188_of_data_cores },
>  	{ .compatible = "mediatek,mt8192-scp", .data = &mt8192_of_data },
>  	{ .compatible = "mediatek,mt8195-scp", .data = &mt8195_of_data },
>  	{ .compatible = "mediatek,mt8195-scp-dual", .data = &mt8195_of_data_cores },
> diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
> index cd0b601..c068227 100644
> --- a/drivers/remoteproc/mtk_scp_ipi.c
> +++ b/drivers/remoteproc/mtk_scp_ipi.c
> @@ -162,10 +162,13 @@ int scp_ipi_send(struct mtk_scp *scp, u32 id, void *buf, unsigned int len,
>  	struct mtk_share_obj __iomem *send_obj = scp->send_buf;
>  	u32 val;
>  	int ret;
> +	const struct mtk_scp_sizes_data *scp_sizes;
> +
> +	scp_sizes = scp->data->scp_sizes;
>  
>  	if (WARN_ON(id <= SCP_IPI_INIT) || WARN_ON(id >= SCP_IPI_MAX) ||
>  	    WARN_ON(id == SCP_IPI_NS_SERVICE) ||
> -	    WARN_ON(len > sizeof(send_obj->share_buf)) || WARN_ON(!buf))
> +	    WARN_ON(len > scp_sizes->ipi_share_buffer_size) || WARN_ON(!buf))
>  		return -EINVAL;
>  
>  	ret = clk_prepare_enable(scp->clk);
> @@ -184,7 +187,7 @@ int scp_ipi_send(struct mtk_scp *scp, u32 id, void *buf, unsigned int len,
>  		goto unlock_mutex;
>  	}
>  
> -	scp_memcpy_aligned(send_obj->share_buf, buf, len);
> +	scp_memcpy_aligned(&send_obj->share_buf, buf, len);
>  
>  	writel(len, &send_obj->len);
>  	writel(id, &send_obj->id);
> diff --git a/include/linux/remoteproc/mtk_scp.h b/include/linux/remoteproc/mtk_scp.h
> index 7c2b7cc9..344ff41 100644
> --- a/include/linux/remoteproc/mtk_scp.h
> +++ b/include/linux/remoteproc/mtk_scp.h
> @@ -43,6 +43,7 @@ enum scp_ipi_id {
>  	SCP_IPI_CROS_HOST_CMD,
>  	SCP_IPI_VDEC_LAT,
>  	SCP_IPI_VDEC_CORE,
> +	SCP_IPI_IMGSYS_CMD,
>  	SCP_IPI_NS_SERVICE = 0xFF,
>  	SCP_IPI_MAX = 0x100,
>  };
> -- 
> 2.6.4
> 

