Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A28F76B33B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjHAL3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjHAL3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:29:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FA6E4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:28:56 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RFXrb4L7vzVjs7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:27:11 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 19:28:54 +0800
Message-ID: <6b2a52c8-041b-5dfc-8087-36b1d31c8dff@huawei.com>
Date:   Tue, 1 Aug 2023 19:28:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next v2] octeontx2: Remove unnecessary ternary
 operators
Content-Language: en-US
To:     <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20230801112409.304564-1-ruanjinjie@huawei.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230801112409.304564-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry！the patch has sent incorrectly.

On 2023/8/1 19:24, Ruan Jinjie wrote:
> There are a little ternary operators, the true or false judgement
> of which is unnecessary in C language semantics. So remove it
> to clean Code.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v2:
> - Fix the subject prefix and commit message issue.
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/ptp.c      | 4 ++--
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
> index 0ee420a489fc..c55c2c441a1a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
> @@ -61,12 +61,12 @@ static const struct pci_device_id ptp_id_table[];
>  
>  static bool is_ptp_dev_cnf10kb(struct ptp *ptp)
>  {
> -	return (ptp->pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_B_PTP) ? true : false;
> +	return ptp->pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_B_PTP;
>  }
>  
>  static bool is_ptp_dev_cn10k(struct ptp *ptp)
>  {
> -	return (ptp->pdev->device == PCI_DEVID_CN10K_PTP) ? true : false;
> +	return ptp->pdev->device == PCI_DEVID_CN10K_PTP;
>  }
>  
>  static bool cn10k_ptp_errata(struct ptp *ptp)
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 9551b422622a..61f62a6ec662 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -2027,7 +2027,7 @@ u16 otx2_select_queue(struct net_device *netdev, struct sk_buff *skb,
>  #endif
>  	int txq;
>  
> -	qos_enabled = (netdev->real_num_tx_queues > pf->hw.tx_queues) ? true : false;
> +	qos_enabled = netdev->real_num_tx_queues > pf->hw.tx_queues;
>  	if (unlikely(qos_enabled)) {
>  		/* This smp_load_acquire() pairs with smp_store_release() in
>  		 * otx2_qos_root_add() called from htb offload root creation
