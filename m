Return-Path: <linux-kernel+bounces-98601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D025877C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266952822B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5592C171C2;
	Mon, 11 Mar 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kedEmf2N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D4414F75;
	Mon, 11 Mar 2024 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148753; cv=none; b=OhsX2AbbuwJpCpeYrk2LDFtBkbfsNZarp2df6EH9a61qCPDrj2b6TAsBO7amre5h+7+6qKlwAmVjRha7meYnO1BKIpy7uqB/c8v5pZgSLG7ixmAhTagtxYukBSBRFZ9GxKJOKZt9TI99NASF0suTH22t52AZT9GbWmXU+YWb2yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148753; c=relaxed/simple;
	bh=f358/S8h2Ce2PWrRrrYnNKSmmvuvtMvMHbSZG6pHh1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txyG0nLH5ReF/mvDDTBKEz6HdlJP5Y8sfNk58rwhlmX0nGvzswxt76qggYzDtn/8DfGqdrhlWJ7xnqaXCAW1G2VCix0vCNNc7js3hoEjmiywFAqhQI+qzqeLu6Pu5f8dj0Tx4f+CBck+0XQr2HRnW/hh0leCAScVo9jMvGVgqcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kedEmf2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6D3C433C7;
	Mon, 11 Mar 2024 09:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710148753;
	bh=f358/S8h2Ce2PWrRrrYnNKSmmvuvtMvMHbSZG6pHh1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kedEmf2N0bt+HvaSqadtfC81NqlOt2bYK/Ugcyhvr3UdDWucsQ/7uCIuyhYi9ydFS
	 IAkSLGWmgW4RZNxUbjzrOed0gDgS2qgmBqC6K6KxqhJVZVI2fi5+PeZ+FSDgROPesF
	 XiV+N6biSayNZkGn753KTulJetAoN9czi1ABu8B/DzL1kgQXqQk2LY8pjopuOg5xZf
	 9YzpYwvkJLODXMbMpFVbNzWC/VDSrEeYXSUFEc3FcIVfJg7fe0p2ReVjq/+JlSTfNP
	 K17bDUQWqIKwNKoazuEO5966cmHrVhqtpAwzwk5Uu3jCW93k+jXmaWFkUzvH+8gCGw
	 ZamNrCiHHpteg==
Date: Mon, 11 Mar 2024 09:19:04 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@resnulli.us, shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 net-next 4/4] net: hns3: add support to query scc
 version by devlink info
Message-ID: <20240311091904.GA24043@kernel.org>
References: <20240309100044.2351166-1-shaojijie@huawei.com>
 <20240309100044.2351166-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309100044.2351166-5-shaojijie@huawei.com>

On Sat, Mar 09, 2024 at 06:00:44PM +0800, Jijie Shao wrote:
> From: Hao Chen <chenhao418@huawei.com>
> 
> Add support to query scc version by devlink info for device V3.
> 
> Signed-off-by: Hao Chen <chenhao418@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  9 ++++
>  .../hns3/hns3_common/hclge_comm_cmd.h         |  8 ++++
>  .../hisilicon/hns3/hns3pf/hclge_devlink.c     | 44 +++++++++++++++++--
>  .../hisilicon/hns3/hns3pf/hclge_devlink.h     |  2 +
>  .../hisilicon/hns3/hns3pf/hclge_main.c        | 18 ++++++++
>  .../hisilicon/hns3/hns3pf/hclge_main.h        |  1 +
>  6 files changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
> index e9266c65b331..7c2c8bea4c06 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
> +++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
> @@ -366,6 +366,15 @@ struct hnae3_vector_info {
>  #define HNAE3_FW_VERSION_BYTE0_SHIFT	0
>  #define HNAE3_FW_VERSION_BYTE0_MASK	GENMASK(7, 0)
>  
> +#define HNAE3_SCC_VERSION_BYTE3_SHIFT	24
> +#define HNAE3_SCC_VERSION_BYTE3_MASK	GENMASK(31, 24)
> +#define HNAE3_SCC_VERSION_BYTE2_SHIFT	16
> +#define HNAE3_SCC_VERSION_BYTE2_MASK	GENMASK(23, 16)
> +#define HNAE3_SCC_VERSION_BYTE1_SHIFT	8
> +#define HNAE3_SCC_VERSION_BYTE1_MASK	GENMASK(15, 8)
> +#define HNAE3_SCC_VERSION_BYTE0_SHIFT	0
> +#define HNAE3_SCC_VERSION_BYTE0_MASK	GENMASK(7, 0)

Not strictly related to this patch, but FWIIW, I suspect that
hnae3_set_field() and hnae3_get_field() could be reworked to use / replaced
by use of FIELD_PREP and FIELD_GET.  In which case I suspect that the
*_SHIFT #defines would no longer be needed.

> +
>  struct hnae3_ring_chain_node {
>  	struct hnae3_ring_chain_node *next;
>  	u32 tqp_index;

..

