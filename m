Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A7A7DA698
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 12:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjJ1K5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 06:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjJ1K5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 06:57:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06437C0;
        Sat, 28 Oct 2023 03:57:04 -0700 (PDT)
Received: from kwepemm000009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SHbvW0csxzpWQ2;
        Sat, 28 Oct 2023 18:52:07 +0800 (CST)
Received: from [10.67.120.153] (10.67.120.153) by
 kwepemm000009.china.huawei.com (7.193.23.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 28 Oct 2023 18:57:02 +0800
Subject: Re: [PATCH] crypto: hisilicon/qm - remove incorrect type cast
To:     <herbert@gondor.apana.org.au>
References: <20231028104012.8648-1-qianweili@huawei.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulongfang@huawei.com>
From:   Weili Qian <qianweili@huawei.com>
Message-ID: <37257953-0931-9343-f3d7-3a4913071ede@huawei.com>
Date:   Sat, 28 Oct 2023 18:56:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20231028104012.8648-1-qianweili@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.153]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000009.china.huawei.com (7.193.23.227)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this one，this patch has been sent repeatedly. Sorry for it.

Thanks,
Weili

On 2023/10/28 18:40, Weili Qian wrote:
> The 'offset' type is unsigned long in 'struct debugfs_reg32',
> so type of values casts to unsigned long long is incorrect, and the
> values do not require type cast, remove them.
> 
> Signed-off-by: Weili Qian <qianweili@huawei.com>
> ---
>  drivers/crypto/hisilicon/debugfs.c      | 50 +++++++++++------------
>  drivers/crypto/hisilicon/zip/zip_main.c | 54 ++++++++++++-------------
>  2 files changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
> index 7e8186fe0512..415139b4abc1 100644
> --- a/drivers/crypto/hisilicon/debugfs.c
> +++ b/drivers/crypto/hisilicon/debugfs.c
> @@ -53,34 +53,34 @@ static struct qm_dfx_item qm_dfx_files[] = {
>  #define CNT_CYC_REGS_NUM		10
>  static const struct debugfs_reg32 qm_dfx_regs[] = {
>  	/* XXX_CNT are reading clear register */
> -	{"QM_ECC_1BIT_CNT               ",  0x104000ull},
> -	{"QM_ECC_MBIT_CNT               ",  0x104008ull},
> -	{"QM_DFX_MB_CNT                 ",  0x104018ull},
> -	{"QM_DFX_DB_CNT                 ",  0x104028ull},
> -	{"QM_DFX_SQE_CNT                ",  0x104038ull},
> -	{"QM_DFX_CQE_CNT                ",  0x104048ull},
> -	{"QM_DFX_SEND_SQE_TO_ACC_CNT    ",  0x104050ull},
> -	{"QM_DFX_WB_SQE_FROM_ACC_CNT    ",  0x104058ull},
> -	{"QM_DFX_ACC_FINISH_CNT         ",  0x104060ull},
> -	{"QM_DFX_CQE_ERR_CNT            ",  0x1040b4ull},
> -	{"QM_DFX_FUNS_ACTIVE_ST         ",  0x200ull},
> -	{"QM_ECC_1BIT_INF               ",  0x104004ull},
> -	{"QM_ECC_MBIT_INF               ",  0x10400cull},
> -	{"QM_DFX_ACC_RDY_VLD0           ",  0x1040a0ull},
> -	{"QM_DFX_ACC_RDY_VLD1           ",  0x1040a4ull},
> -	{"QM_DFX_AXI_RDY_VLD            ",  0x1040a8ull},
> -	{"QM_DFX_FF_ST0                 ",  0x1040c8ull},
> -	{"QM_DFX_FF_ST1                 ",  0x1040ccull},
> -	{"QM_DFX_FF_ST2                 ",  0x1040d0ull},
> -	{"QM_DFX_FF_ST3                 ",  0x1040d4ull},
> -	{"QM_DFX_FF_ST4                 ",  0x1040d8ull},
> -	{"QM_DFX_FF_ST5                 ",  0x1040dcull},
> -	{"QM_DFX_FF_ST6                 ",  0x1040e0ull},
> -	{"QM_IN_IDLE_ST                 ",  0x1040e4ull},
> +	{"QM_ECC_1BIT_CNT               ",  0x104000},
> +	{"QM_ECC_MBIT_CNT               ",  0x104008},
> +	{"QM_DFX_MB_CNT                 ",  0x104018},
> +	{"QM_DFX_DB_CNT                 ",  0x104028},
> +	{"QM_DFX_SQE_CNT                ",  0x104038},
> +	{"QM_DFX_CQE_CNT                ",  0x104048},
> +	{"QM_DFX_SEND_SQE_TO_ACC_CNT    ",  0x104050},
> +	{"QM_DFX_WB_SQE_FROM_ACC_CNT    ",  0x104058},
> +	{"QM_DFX_ACC_FINISH_CNT         ",  0x104060},
> +	{"QM_DFX_CQE_ERR_CNT            ",  0x1040b4},
> +	{"QM_DFX_FUNS_ACTIVE_ST         ",  0x200},
> +	{"QM_ECC_1BIT_INF               ",  0x104004},
> +	{"QM_ECC_MBIT_INF               ",  0x10400c},
> +	{"QM_DFX_ACC_RDY_VLD0           ",  0x1040a0},
> +	{"QM_DFX_ACC_RDY_VLD1           ",  0x1040a4},
> +	{"QM_DFX_AXI_RDY_VLD            ",  0x1040a8},
> +	{"QM_DFX_FF_ST0                 ",  0x1040c8},
> +	{"QM_DFX_FF_ST1                 ",  0x1040cc},
> +	{"QM_DFX_FF_ST2                 ",  0x1040d0},
> +	{"QM_DFX_FF_ST3                 ",  0x1040d4},
> +	{"QM_DFX_FF_ST4                 ",  0x1040d8},
> +	{"QM_DFX_FF_ST5                 ",  0x1040dc},
> +	{"QM_DFX_FF_ST6                 ",  0x1040e0},
> +	{"QM_IN_IDLE_ST                 ",  0x1040e4},
>  };
>  
>  static const struct debugfs_reg32 qm_vf_dfx_regs[] = {
> -	{"QM_DFX_FUNS_ACTIVE_ST         ",  0x200ull},
> +	{"QM_DFX_FUNS_ACTIVE_ST         ",  0x200},
>  };
>  
>  /* define the QM's dfx regs region and region length */
> diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
> index db4c964cd649..d6672b777efc 100644
> --- a/drivers/crypto/hisilicon/zip/zip_main.c
> +++ b/drivers/crypto/hisilicon/zip/zip_main.c
> @@ -270,28 +270,28 @@ static const u64 core_offsets[] = {
>  };
>  
>  static const struct debugfs_reg32 hzip_dfx_regs[] = {
> -	{"HZIP_GET_BD_NUM                ",  0x00ull},
> -	{"HZIP_GET_RIGHT_BD              ",  0x04ull},
> -	{"HZIP_GET_ERROR_BD              ",  0x08ull},
> -	{"HZIP_DONE_BD_NUM               ",  0x0cull},
> -	{"HZIP_WORK_CYCLE                ",  0x10ull},
> -	{"HZIP_IDLE_CYCLE                ",  0x18ull},
> -	{"HZIP_MAX_DELAY                 ",  0x20ull},
> -	{"HZIP_MIN_DELAY                 ",  0x24ull},
> -	{"HZIP_AVG_DELAY                 ",  0x28ull},
> -	{"HZIP_MEM_VISIBLE_DATA          ",  0x30ull},
> -	{"HZIP_MEM_VISIBLE_ADDR          ",  0x34ull},
> -	{"HZIP_CONSUMED_BYTE             ",  0x38ull},
> -	{"HZIP_PRODUCED_BYTE             ",  0x40ull},
> -	{"HZIP_COMP_INF                  ",  0x70ull},
> -	{"HZIP_PRE_OUT                   ",  0x78ull},
> -	{"HZIP_BD_RD                     ",  0x7cull},
> -	{"HZIP_BD_WR                     ",  0x80ull},
> -	{"HZIP_GET_BD_AXI_ERR_NUM        ",  0x84ull},
> -	{"HZIP_GET_BD_PARSE_ERR_NUM      ",  0x88ull},
> -	{"HZIP_ADD_BD_AXI_ERR_NUM        ",  0x8cull},
> -	{"HZIP_DECOMP_STF_RELOAD_CURR_ST ",  0x94ull},
> -	{"HZIP_DECOMP_LZ77_CURR_ST       ",  0x9cull},
> +	{"HZIP_GET_BD_NUM                ",  0x00},
> +	{"HZIP_GET_RIGHT_BD              ",  0x04},
> +	{"HZIP_GET_ERROR_BD              ",  0x08},
> +	{"HZIP_DONE_BD_NUM               ",  0x0c},
> +	{"HZIP_WORK_CYCLE                ",  0x10},
> +	{"HZIP_IDLE_CYCLE                ",  0x18},
> +	{"HZIP_MAX_DELAY                 ",  0x20},
> +	{"HZIP_MIN_DELAY                 ",  0x24},
> +	{"HZIP_AVG_DELAY                 ",  0x28},
> +	{"HZIP_MEM_VISIBLE_DATA          ",  0x30},
> +	{"HZIP_MEM_VISIBLE_ADDR          ",  0x34},
> +	{"HZIP_CONSUMED_BYTE             ",  0x38},
> +	{"HZIP_PRODUCED_BYTE             ",  0x40},
> +	{"HZIP_COMP_INF                  ",  0x70},
> +	{"HZIP_PRE_OUT                   ",  0x78},
> +	{"HZIP_BD_RD                     ",  0x7c},
> +	{"HZIP_BD_WR                     ",  0x80},
> +	{"HZIP_GET_BD_AXI_ERR_NUM        ",  0x84},
> +	{"HZIP_GET_BD_PARSE_ERR_NUM      ",  0x88},
> +	{"HZIP_ADD_BD_AXI_ERR_NUM        ",  0x8c},
> +	{"HZIP_DECOMP_STF_RELOAD_CURR_ST ",  0x94},
> +	{"HZIP_DECOMP_LZ77_CURR_ST       ",  0x9c},
>  };
>  
>  static const struct debugfs_reg32 hzip_com_dfx_regs[] = {
> @@ -303,11 +303,11 @@ static const struct debugfs_reg32 hzip_com_dfx_regs[] = {
>  };
>  
>  static const struct debugfs_reg32 hzip_dump_dfx_regs[] = {
> -	{"HZIP_GET_BD_NUM                ",  0x00ull},
> -	{"HZIP_GET_RIGHT_BD              ",  0x04ull},
> -	{"HZIP_GET_ERROR_BD              ",  0x08ull},
> -	{"HZIP_DONE_BD_NUM               ",  0x0cull},
> -	{"HZIP_MAX_DELAY                 ",  0x20ull},
> +	{"HZIP_GET_BD_NUM                ",  0x00},
> +	{"HZIP_GET_RIGHT_BD              ",  0x04},
> +	{"HZIP_GET_ERROR_BD              ",  0x08},
> +	{"HZIP_DONE_BD_NUM               ",  0x0c},
> +	{"HZIP_MAX_DELAY                 ",  0x20},
>  };
>  
>  /* define the ZIP's dfx regs region and region length */
> 
