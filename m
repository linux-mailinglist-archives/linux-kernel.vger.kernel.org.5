Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF47C7D2EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjJWJul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjJWJuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:50:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ED810CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:50:29 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C643366072A2;
        Mon, 23 Oct 2023 10:50:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698054628;
        bh=/ObcFQuAnvwvg8clbUwhTsVg7LUyueOEjvMxprImgQE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GvjFWnuRehz6ZRBUY0Pi0dLinHaOTymW6WkU8bFA2oP1UlhpLQvuBQtzrLmhg2YMm
         sSjpjOqS65iFm/Alcsf3eGYSG1vcc9Cd0qsDF4+YSvBDD+LAOpZ8dIWF7ISNtEs71D
         0VQrnLLMELymGF/3PE+bZGcJeKYMnUSKlIYRYxSOWk33Fz3DjLcUVsObYwDanFfgQM
         llJgmX1D5wwp+ZRz5kUIbF8vTLLa+7ryUXbsgH4hm2574fRPFpUOSQz3LhTkkpxfgh
         82msGXNctNa8p6cTrEa9NPFPBXg2EYNZjfEK9d1IO5R9y0lKyE2WKHxfCG9N0iZ6uZ
         VpM/8E6mEsRQA==
Message-ID: <687aeef8-a413-4f02-9c6b-3a3adc23cc36@collabora.com>
Date:   Mon, 23 Oct 2023 11:50:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] soc: mailbox: Add cmdq_pkt_logic_command to
 support math operation
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
 <20231023043751.17114-4-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231023043751.17114-4-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/10/23 06:37, Jason-JH.Lin ha scritto:
> Add cmdq_pkt_logic_command to support match operation.
> 
> cmdq_pkt_logic_command can append logic command to the CMDQ packet,
> ask GCE to execute a arithematic calculate instruction,
> such as add, subtract, multiply, AND, OR and NOT, etc.
> 
> Note that all instructions just accept unsigned calculate.
> If there are any overflows, GCE will sent the invalid IRQ to notify
> CMDQ driver.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Please always run `git log` on the file that you're changing to properly format the
commit title.

In this case, this should be:

soc: mediatek: cmdq: .....

> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c | 36 ++++++++++++++++++++++
>   include/linux/soc/mediatek/mtk-cmdq.h  | 41 ++++++++++++++++++++++++++
>   2 files changed, 77 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index b0cd071c4719..5194d66dfc0a 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -13,9 +13,18 @@
>   #define CMDQ_WRITE_ENABLE_MASK	BIT(0)
>   #define CMDQ_POLL_ENABLE_MASK	BIT(0)
>   #define CMDQ_EOC_IRQ_EN		BIT(0)
> +#define CMDQ_IMMEDIATE_VALUE	0
>   #define CMDQ_REG_TYPE		1
>   #define CMDQ_JUMP_RELATIVE	1
>   
> +#define CMDQ_OPERAND_GET_IDX_VALUE(operand) \
> +	({ \
> +		struct cmdq_operand *op = operand; \
> +		op->reg ? op->idx : op->value; \
> +	})
> +#define CMDQ_OPERAND_TYPE(operand) \
> +	((operand)->reg ? CMDQ_REG_TYPE : CMDQ_IMMEDIATE_VALUE)
> +
>   struct cmdq_instruction {
>   	union {
>   		u32 value;
> @@ -380,6 +389,33 @@ int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
>   }
>   EXPORT_SYMBOL(cmdq_pkt_poll_mask);
>   
> +int cmdq_pkt_logic_command(struct cmdq_pkt *pkt, enum CMDQ_LOGIC_ENUM s_op,
> +			   u16 result_reg_idx,
> +			   struct cmdq_operand *left_operand,
> +			   struct cmdq_operand *right_operand)
> +{
> +	struct cmdq_instruction inst = { {0} };
> +	u32 left_idx_value;
> +	u32 right_idx_value;
> +
> +	if (!left_operand || !right_operand)

I would also check that the requested logic operation is actually implemented:

	if (!left_operand || !right_operand || s_op >= CMDQ_LOGIC_MAX)
		return -EINVAL;

> +		return -EINVAL;
> +
> +	left_idx_value = CMDQ_OPERAND_GET_IDX_VALUE(left_operand);
> +	right_idx_value = CMDQ_OPERAND_GET_IDX_VALUE(right_operand);
> +	inst.op = CMDQ_CODE_LOGIC;
> +	inst.dst_t = CMDQ_REG_TYPE;
> +	inst.src_t = CMDQ_OPERAND_TYPE(left_operand);
> +	inst.arg_c_t = CMDQ_OPERAND_TYPE(right_operand);
> +	inst.sop = s_op;
> +	inst.arg_c = right_idx_value;
> +	inst.src_reg = left_idx_value;
> +	inst.reg_dst = result_reg_idx;
> +
> +	return cmdq_pkt_append_command(pkt, inst);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_logic_command);
> +
>   int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value)
>   {
>   	struct cmdq_instruction inst = {};
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index a253c001c861..ea4fadfb5443 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -26,6 +26,30 @@
>   
>   struct cmdq_pkt;
>   
> +enum CMDQ_LOGIC_ENUM {

Please no capital letters in enumeration names.
Besides, it's clearer if you named this

enum cmdq_logic_operation {

or

enum cmdq_logic_op {

> +	CMDQ_LOGIC_ASSIGN = 0,
> +	CMDQ_LOGIC_ADD = 1,
> +	CMDQ_LOGIC_SUBTRACT = 2,
> +	CMDQ_LOGIC_MULTIPLY = 3,
> +	CMDQ_LOGIC_XOR = 8,
> +	CMDQ_LOGIC_NOT = 9,
> +	CMDQ_LOGIC_OR = 10,
> +	CMDQ_LOGIC_AND = 11,
> +	CMDQ_LOGIC_LEFT_SHIFT = 12,
> +	CMDQ_LOGIC_RIGHT_SHIFT = 13,

You should also add a `CMDQ_LOGIC_MAX,` here to use it in the code for validation.

> +};
> +
> +struct cmdq_operand {
> +	/* register type */
> +	bool reg;
> +	union {
> +		/* index */
> +		u16 idx;
> +		/* value */
> +		u16 value;
> +	};
> +};
> +
>   struct cmdq_client_reg {
>   	u8 subsys;
>   	u16 offset;
> @@ -244,6 +268,23 @@ int cmdq_pkt_poll(struct cmdq_pkt *pkt, u8 subsys,
>   int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
>   		       u16 offset, u32 value, u32 mask);
>   
> +/**
> + * cmdq_pkt_logic_command() - Append logic command to the CMDQ packet, ask GCE to
> + *		          execute an instruction that store the result of logic operation
> + *		          with left and right operand into result_reg_idx.
> + * @pkt:		the CMDQ packet
> + * @s_op:		the logic operator enum
> + * @result_reg_idx:	SPR index that store operation result of left_operand and right_operand
> + * @left_operand:	left operand
> + * @right_operand:	right operand
> + *

I think that there's a way to dramatically increase human readability of calls to
this function: being this a request to perform calculations, it would be way easier
to read it like an actual calculation :-)

cmdq_pkt_logic_command(pkt, result, op_x, CMDQ_LOGIC_ADD, op_y);

At least in my head, this easily resembles "result = op_x + op_y".

I therefore propose to change this to:

int cmdq_pkt_logic_command(struct cmdq_pkt *pkt, u16 result_reg_idx,
			   struct cmdq_operand *left_operand,
			   enum cmdq_logic_operation s_op,
			   struct cmdq_operand *right_operand);

> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_pkt_logic_command(struct cmdq_pkt *pkt, enum CMDQ_LOGIC_ENUM s_op,
> +			   u16 result_reg_idx,
> +			   struct cmdq_operand *left_operand,
> +			   struct cmdq_operand *right_operand);
> +
>   /**
>    * cmdq_pkt_assign() - Append logic assign command to the CMDQ packet, ask GCE
>    *		       to execute an instruction that set a constant value into


Regards,
Angelo

