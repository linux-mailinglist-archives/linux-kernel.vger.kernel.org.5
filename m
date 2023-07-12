Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABE47510CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjGLS4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjGLS4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:56:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBCA1993
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:56:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-992b27e1c55so888819566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689188206; x=1691780206;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pQ/w7qTO/xIqWPgcpXOvEE7hB1hBsoMBAQU0zpmlS9s=;
        b=FDZZPSv+IiVnQ66ZD9DruGmdf8iKXiVDdvwhsWt1qvZfh8xb6IZqHHaIpqGeNrHd38
         AdJZx4pQp1VGNf1mh1qWyByB8PeZeyMQ9/mA3SXkdSzXW3e7RKRbQDfHxqKP1f4WCiyD
         SERBnlX1IzswtOjdsusPCuzyxRT5c952dKr+okrs361EtpOwwif0jW6gi6w5XjLA+77t
         2e5Ine2FrgWE35qCinqnfyYvkEGKxlQKCaqulOiriWSjKw4S76GgqlW6g0Waa0I7CrIM
         0EeiR4cSxrgyjLDfCzfySppJgp8ufDr5H1+k/WNfmel+jnNjR6A1JT2Oio5NJX2ob1mm
         uLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689188206; x=1691780206;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQ/w7qTO/xIqWPgcpXOvEE7hB1hBsoMBAQU0zpmlS9s=;
        b=e/KBEJjVc3gcwvPPU2fbnITL9BGWF6co02XSjTCcx6U7UB1GZYDop/wCLr6Ao80XoL
         KIHapIwwhm6M5T035H941FFGuXUUbJsC9y7W3n6Ta66X3nfOClKBUX/yws1oUc6fdnSq
         mTjmQZHqLIYYaxKPc3zKXmrrk8hG9jETRJK574l+xagWWEC5iOn/04+KazrJwqpXAQxn
         FWYkjToxmfn2Eeq1RAZfdy9MK/C9iRq8bvtaAg4pvFSQZA42Q6xJH5SvV47XXFgOe9yx
         8yjLNCPCdqk5gqST2MAOPQPe9eXPJFSHI7EiuF+C1vyYRfmDE+/vhiXITsHU74wFbOBB
         ZzPQ==
X-Gm-Message-State: ABy/qLb5p4PouAsby2IkiKiZjxnz8nL0sUTBE9FqZewc2SSu0hiO6/O/
        i+mUeNcSuH0TJDcQDhfuhVd2ug==
X-Google-Smtp-Source: APBJJlHP/rydv75YU7s/lGCb//r18z0CJZMmr3iYpr5kGHUBE+qJAKEjrPjQgygjnUgrVIPGeK5/PQ==
X-Received: by 2002:a17:906:c30e:b0:992:16bb:2b6e with SMTP id s14-20020a170906c30e00b0099216bb2b6emr17408182ejz.29.1689188206006;
        Wed, 12 Jul 2023 11:56:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id gx17-20020a170906f1d100b00992aea2c55dsm2904496ejb.153.2023.07.12.11.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 11:56:45 -0700 (PDT)
Message-ID: <e143fd58-5c2b-fdb6-96bf-57bbf799d76c@linaro.org>
Date:   Wed, 12 Jul 2023 20:56:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 6/7] firmware: imx: add driver for NXP EdgeLock Enclave
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, clin@suse.com,
        conor+dt@kernel.org, pierre.gondois@arm.com, ping.bai@nxp.com,
        xiaoning.wang@nxp.com, wei.fang@nxp.com, peng.fan@nxp.com,
        haibo.chen@nxp.com, festevam@gmail.com, linux-imx@nxp.com,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     kernel test robot <lkp@intel.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-7-pankaj.gupta@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230712121219.2654234-7-pankaj.gupta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 14:12, Pankaj Gupta wrote:
> The Edgelock Enclave , is the secure enclave embedded in the SoC
> to support the features like HSM, SHE & V2X, using message based
> communication channel.
> 
> ELE FW communicates on a dedicated MU with application core where
> kernel is running. It exists on specific i.MX processors. e.g. i.MX8ULP,
> i.MX93.
> 
> Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>

What did the robot report? New driver?

...

> +
> +/* Fill a command message header with a given command ID and length in bytes. */
> +static int plat_fill_cmd_msg_hdr(struct mu_hdr *hdr,
> +				 uint8_t cmd,
> +				 uint32_t len)
> +{
> +	struct ele_mu_priv *priv = NULL;
> +	int err;
> +
> +	err = get_ele_mu_priv(&priv);
> +	if (err) {
> +		pr_err("Error: iMX EdgeLock Enclave MU, used before probing.\n");

dev_err(), everywhere.

> +		return err;
> +	}
> +
> +	hdr->tag = priv->cmd_tag;
> +	hdr->ver = ELE_BASE_API_VERSION;
> +	hdr->command = cmd;
> +	hdr->size = len >> 2;
> +
> +	return err;
> +}
> +
> +static u32 plat_add_msg_crc(uint32_t *msg, uint32_t msg_len)
> +{
> +	uint32_t i;
> +	uint32_t crc = 0;
> +	uint32_t nb_words = msg_len >> 2;
> +
> +	for (i = 0; i < nb_words - 1; i++)
> +		crc ^= *(msg + i);
> +
> +	return crc;
> +}
> +
> +int imx_ele_msg_send_rcv(struct ele_mu_priv *priv)
> +{
> +	unsigned int wait;
> +	int err;
> +
> +	mutex_lock(&priv->mu_cmd_lock);
> +	mutex_lock(&priv->mu_lock);
> +
> +	err = mbox_send_message(priv->tx_chan, &priv->tx_msg);
> +	if (err < 0) {
> +		pr_err("Error: mbox_send_message failure.\n");
> +		mutex_unlock(&priv->mu_lock);
> +		return err;
> +	}
> +	mutex_unlock(&priv->mu_lock);
> +
> +	wait = msecs_to_jiffies(1000);
> +	if (!wait_for_completion_timeout(&priv->done, wait)) {
> +		pr_err("Error: wait_for_completion timed out.\n");
> +		err = -ETIMEDOUT;
> +	}
> +
> +	mutex_unlock(&priv->mu_cmd_lock);
> +
> +	return err;
> +}
> +
> +static int read_otp_uniq_id(struct ele_mu_priv *priv, u32 *value)
> +{
> +	unsigned int tag, command, size, ver, status;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +
> +	if (tag == priv->rsp_tag &&
> +	    command == ELE_READ_FUSE_REQ &&
> +	    size == ELE_READ_FUSE_RSP_MSG_SZ &&
> +	    ver == ELE_BASE_API_VERSION &&
> +	    status == ELE_SUCCESS_IND) {
> +		value[0] = priv->rx_msg.data[1];
> +		value[1] = priv->rx_msg.data[2];
> +		value[2] = priv->rx_msg.data[3];
> +		value[3] = priv->rx_msg.data[4];
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int read_fuse_word(struct ele_mu_priv *priv, u32 *value)
> +{
> +	unsigned int tag, command, size, ver, status;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +
> +	if (tag == priv->rsp_tag &&
> +	    command == ELE_READ_FUSE_REQ &&
> +	    size == ELE_READ_FUSE_REQ_MSG_SZ &&
> +	    ver == ELE_BASE_API_VERSION &&
> +	    status == ELE_SUCCESS_IND) {
> +		value[0] = priv->rx_msg.data[1];
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +int read_common_fuse(uint16_t fuse_id, u32 *value)
> +{
> +	struct ele_mu_priv *priv = NULL;
> +	int err;
> +
> +	err = get_ele_mu_priv(&priv);
> +	if (err) {
> +		pr_err("Error: iMX EdgeLock Enclave MU, used before probing.\n");
> +		return err;
> +	}
> +	err = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv->tx_msg.header,
> +				    ELE_READ_FUSE_REQ, 8);
> +	if (err) {
> +		pr_err("Error: plat_fill_cmd_msg_hdr failed.\n");
> +		return err;
> +	}
> +
> +	priv->tx_msg.data[0] = fuse_id;
> +	err = imx_ele_msg_send_rcv(priv);
> +	if (err < 0)
> +		return err;
> +
> +	switch (fuse_id) {
> +	case OTP_UNIQ_ID:
> +		err = read_otp_uniq_id(priv, value);
> +		break;
> +	default:
> +		err = read_fuse_word(priv, value);
> +		break;
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(read_common_fuse);
> +
> +int ele_ping(void)

No, why this is void? Don't do some singletons when not necessary. It's
wrong design, error prone and tricky to make work with deferred probe.

Why the consumers cannot be designed like a consumer - take a respective
phandle from producer?

> +{
> +	struct ele_mu_priv *priv = NULL;
> +	unsigned int tag, command, size, ver, status;
> +	int err;
> +
> +	err = get_ele_mu_priv(&priv);
> +	if (err) {
> +		pr_err("Error: iMX EdgeLock Enclave MU, used before probing.\n");
> +		return err;
> +	}
> +	err = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv->tx_msg.header,
> +				    ELE_PING_REQ, 4);
> +	if (err) {
> +		pr_err("Error: plat_fill_cmd_msg_hdr failed.\n");
> +		return err;
> +	}
> +
> +	err = imx_ele_msg_send_rcv(priv);
> +	if (err < 0)
> +		return err;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +
> +	if (tag == priv->rsp_tag && command == ELE_PING_REQ &&
> +	    size == ELE_PING_REQ_MSG_SZ && ver == ELE_BASE_API_VERSION &&
> +	    status == ELE_SUCCESS_IND)
> +		return 0;
> +
> +	return -EAGAIN;
> +}
> +EXPORT_SYMBOL_GPL(ele_ping);

Nope. You have one driver. This does not have to be exported.

This is a strong NAK.


> +
> +int ele_service_swap(phys_addr_t addr, u32 addr_size, u16 flag)
> +{
> +	struct ele_mu_priv *priv;
> +	int ret;
> +	unsigned int tag, command, size, ver, status;
> +
> +	ret = get_ele_mu_priv(&priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv->tx_msg.header,
> +				    ELE_SERVICE_SWAP_REQ, 24);
> +	if (ret)
> +		return ret;
> +
> +	priv->tx_msg.data[0] = flag;
> +	priv->tx_msg.data[1] = addr_size;
> +	priv->tx_msg.data[2] = ELE_NONE_VAL;
> +	priv->tx_msg.data[3] = lower_32_bits(addr);
> +	priv->tx_msg.data[4] = plat_add_msg_crc((uint32_t *)&priv->tx_msg, 24);
> +	ret = imx_ele_msg_send_rcv(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +	if (tag == priv->rsp_tag &&
> +	    command == ELE_SERVICE_SWAP_REQ &&
> +	    size == ELE_SERVICE_SWAP_REQ_MSG_SZ &&
> +	    ver == ELE_BASE_API_VERSION &&
> +	    status == ELE_SUCCESS_IND) {
> +		if (flag == ELE_IMEM_EXPORT)
> +			return priv->rx_msg.data[1];
> +		else
> +			return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(ele_service_swap);
> +
> +int ele_get_info(phys_addr_t addr, u32 data_size)
> +{
> +	struct ele_mu_priv *priv;
> +	int ret;
> +	unsigned int tag, command, size, ver, status;
> +
> +	ret = get_ele_mu_priv(&priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv->tx_msg.header,
> +				    ELE_GET_INFO_REQ, 16);
> +	if (ret)
> +		return ret;
> +
> +	priv->tx_msg.data[0] = upper_32_bits(addr);
> +	priv->tx_msg.data[1] = lower_32_bits(addr);
> +	priv->tx_msg.data[2] = data_size;
> +	ret = imx_ele_msg_send_rcv(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +	if (tag == priv->rsp_tag &&
> +	    command == ELE_GET_INFO_REQ &&
> +	    size == ELE_GET_INFO_REQ_MSG_SZ &&
> +	    ver == ELE_BASE_API_VERSION &&
> +	    status == ELE_SUCCESS_IND)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(ele_get_info);
> +
> +/*
> + * ele_get_trng_state() - prepare and send the command to read
> + *                        crypto lib and TRNG state
> + * TRNG state
> + *  0x1		TRNG is in program mode
> + *  0x2		TRNG is still generating entropy
> + *  0x3		TRNG entropy is valid and ready to be read
> + *  0x4		TRNG encounter an error while generating entropy
> + *
> + * CSAL state
> + *  0x0		Crypto Lib random context initialization is not done yet
> + *  0x1		Crypto Lib random context initialization is on-going
> + *  0x2		Crypto Lib random context initialization succeed
> + *  0x3		Crypto Lib random context initialization failed
> + *
> + * returns: csal and trng state.
> + *
> + */
> +int ele_get_trng_state(void)
> +{
> +	struct ele_mu_priv *priv;
> +	int ret;
> +	unsigned int tag, command, size, ver, status;
> +
> +	/* access ele_mu_priv data structure pointer*/
> +	ret = get_ele_mu_priv(&priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv->tx_msg.header,
> +				    ELE_GET_TRNG_STATE_REQ, 4);
> +	if (ret)
> +		return ret;
> +
> +	ret = imx_ele_msg_send_rcv(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +	if (tag == priv->rsp_tag &&
> +	    command == ELE_GET_TRNG_STATE_REQ &&
> +	    size == ELE_GET_TRNG_STATE_REQ_MSG_SZ &&
> +	    ver == ELE_BASE_API_VERSION &&
> +	    status == ELE_SUCCESS_IND) {
> +		return (priv->rx_msg.data[1] & CSAL_TRNG_STATE_MASK);
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(ele_get_trng_state);
> +
> +/*
> + * ele_start_rng() - prepare and send the command to start
> + *                   initialization of the ELE RNG context
> + *
> + * returns:  0 on success.
> + */
> +int ele_start_rng(void)
> +{
> +	struct ele_mu_priv *priv;
> +	int ret;
> +	unsigned int tag, command, size, ver, status;
> +
> +	/* access ele_mu_priv data structure pointer*/
> +	ret = get_ele_mu_priv(&priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv->tx_msg.header,
> +				    ELE_START_RNG_REQ, 4);
> +	if (ret)
> +		return ret;
> +
> +	ret = imx_ele_msg_send_rcv(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +	if (tag == priv->rsp_tag &&
> +	    command == ELE_START_RNG_REQ &&
> +	    size == ELE_START_RNG_REQ_MSG_SZ &&
> +	    ver == ELE_BASE_API_VERSION &&
> +	    status == ELE_SUCCESS_IND) {
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(ele_start_rng);
> diff --git a/drivers/firmware/imx/ele_fw_api.c b/drivers/firmware/imx/ele_fw_api.c
> new file mode 100644
> index 000000000000..2a3fdc42294b
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_fw_api.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2023 NXP
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/firmware/imx/ele_fw_api.h>
> +
> +#include "se_fw.h"
> +
> +/* Fill a command message header with a given command ID and length in bytes. */
> +static int plat_fill_cmd_msg_hdr(struct mu_hdr *hdr, uint8_t cmd, uint32_t len)
> +{
> +	struct ele_mu_priv *priv = NULL;
> +	int err = 0;
> +
> +	err = get_ele_mu_priv(&priv);
> +	if (err) {
> +		pr_err("Error: iMX EdgeLock Enclave MU is not probed successfully.\n");
> +		return err;
> +	}
> +	hdr->tag = priv->cmd_tag;
> +	hdr->ver = MESSAGING_VERSION_7;
> +	hdr->command = cmd;
> +	hdr->size = (uint8_t)(len / sizeof(uint32_t));
> +
> +	return err;
> +}
> +
> +/*
> + * ele_get_random() - prepare and send the command to proceed
> + *                    with a random number generation operation
> + *
> + * returns:  size of the rondom number generated
> + */
> +int ele_get_random(struct hwrng *rng, void *data, size_t len, bool wait)
> +{
> +	struct ele_mu_priv *priv;
> +	unsigned int tag, command, size, ver, status;
> +	dma_addr_t dst_dma;
> +	u8 *buf;
> +	int ret;
> +
> +	/* access ele_mu_priv data structure pointer*/
> +	ret = get_ele_mu_priv(&priv);
> +	if (ret)
> +		return ret;
> +
> +	buf = dmam_alloc_coherent(priv->dev, len, &dst_dma, GFP_KERNEL);
> +	if (!buf) {
> +		dev_err(priv->dev, "Failed to map destination buffer memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv->tx_msg.header, ELE_GET_RANDOM_REQ, 16);
> +	if (ret)
> +		goto exit;
> +
> +	priv->tx_msg.data[0] = 0x0;
> +	priv->tx_msg.data[1] = dst_dma;
> +	priv->tx_msg.data[2] = len;
> +	ret = imx_ele_msg_send_rcv(priv);
> +	if (ret < 0)
> +		goto exit;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +	if (tag == 0xe1 && command == ELE_GET_RANDOM_REQ && size == 0x02 &&
> +	    ver == 0x07 && status == 0xd6) {
> +		memcpy(data, buf, len);
> +		ret = len;
> +	} else
> +		ret = -EINVAL;
> +
> +exit:
> +	dmam_free_coherent(priv->dev, len, buf, dst_dma);
> +	return ret;
> +}
> +
> +int ele_init_fw(void)
> +{
> +	struct ele_mu_priv *priv;
> +	int ret;
> +	unsigned int tag, command, size, ver, status;
> +
> +	ret = get_ele_mu_priv(&priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv->tx_msg.header, ELE_INIT_FW_REQ, 4);
> +	if (ret)
> +		return ret;
> +
> +	ret = imx_ele_msg_send_rcv(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +
> +	if (tag == 0xe1 && command == ELE_INIT_FW_REQ && size == 0x02 &&
> +	    ver == 0x06 && status == 0xd6)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> diff --git a/drivers/firmware/imx/se_fw.c b/drivers/firmware/imx/se_fw.c
> new file mode 100644
> index 000000000000..14e4bb4225e1
> --- /dev/null
> +++ b/drivers/firmware/imx/se_fw.c
> @@ -0,0 +1,1443 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2021-2023 NXP
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/completion.h>
> +#include <linux/dev_printk.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/firmware/imx/ele_fw_api.h>
> +#include <linux/firmware/imx/ele_base_msg.h>
> +#include <linux/firmware/imx/ele_mu_ioctl.h>
> +#include <linux/genalloc.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/sys_soc.h>
> +#include <linux/workqueue.h>
> +
> +#include "se_fw.h"
> +
> +#define ELE_PING_INTERVAL		(3600 * HZ)
> +#define ELE_TRNG_STATE_OK		0x203
> +#define ELE_GET_TRNG_STATE_RETRY_COUNT	0x5
> +
> +#define ELE_GET_INFO_BUFF_SZ		0x100
> +#define ELE_GET_INFO_READ_SZ		0xA0
> +#define ELE_IMEM_SIZE			0x10000
> +#define ELE_IMEM_STATE_OK		0xCA
> +#define ELE_IMEM_STATE_BAD		0xFE
> +#define ELE_IMEM_STATE_WORD		0x27
> +#define ELE_IMEM_STATE_MASK		0x00ff0000
> +
> +#define SOC_ID_OF_IMX8ULP		0x084D
> +#define SOC_ID_OF_IMX93			0x9300
> +#define SOC_VER_MASK			0xFFFF0000
> +#define SOC_ID_MASK			0x0000FFFF
> +#define DEVICE_GET_INFO_SZ		0x100
> +
> +#define GET_INFO_SOC_INFO_WORD_OFFSET	1
> +#define GET_INFO_UUID_WORD_OFFSET	3
> +#define GET_INFO_SL_NUM_MSB_WORD_OFF \
> +	(GET_INFO_UUID_WORD_OFFSET + 3)
> +#define GET_INFO_SL_NUM_LSB_WORD_OFF \
> +	(GET_INFO_UUID_WORD_OFFSET + 0)
> +
> +#define RESERVED_DMA_POOL		BIT(1)
> +
> +struct ele_mu_priv *ele_priv_export;
> +
> +struct imx_info {
> +	bool socdev;
> +	uint8_t max_dev_ctx;
> +	uint8_t cmd_tag;
> +	uint8_t rsp_tag;
> +	uint8_t *pool_name;
> +	/* platform specific flag to enable/disable the ELE True RNG */
> +	bool start_rng;
> +	bool enable_ele_trng;
> +	bool reserved_dma_ranges;
> +	bool init_fw;
> +	bool imem_mgmt;
> +};
> +
> +static const struct imx_info imx8ulp_info = {
> +	.socdev = true,
> +	.max_dev_ctx = 4,
> +	.cmd_tag = 0x17,
> +	.rsp_tag = 0xe1,
> +	.pool_name = "sram-pool",
> +	.start_rng = true,
> +	.enable_ele_trng = false,
> +	.reserved_dma_ranges = true,
> +	.init_fw = false,
> +	.imem_mgmt = true,
> +};
> +
> +static const struct imx_info imx93_info = {
> +	.socdev = true,
> +	.max_dev_ctx = 4,
> +	.cmd_tag = 0x17,
> +	.rsp_tag = 0xe1,
> +	.pool_name = NULL,
> +	.start_rng = true,
> +	.enable_ele_trng = true,
> +	.reserved_dma_ranges = true,
> +	.init_fw = true,
> +	.imem_mgmt = false,
> +};
> +
> +static const struct of_device_id ele_mu_match[] = {
> +	{ .compatible = "fsl,imx-ele", .data = (void *)&imx8ulp_info},
> +	{ .compatible = "fsl,imx93-ele", .data = (void *)&imx93_info},
> +	{},
> +};
> +
> +int get_ele_mu_priv(struct ele_mu_priv **export)
> +{
> +	if (!ele_priv_export)
> +		return -EPROBE_DEFER;
> +
> +	*export = ele_priv_export;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(get_ele_mu_priv);
> +
> +/*
> + * Callback called by mailbox FW when data are received
> + */
> +static void ele_mu_rx_callback(struct mbox_client *c, void *msg)
> +{
> +	struct device *dev = c->dev;
> +	struct ele_mu_priv *priv = dev_get_drvdata(dev);
> +	struct ele_mu_device_ctx *dev_ctx;
> +	bool is_response = false;
> +	int msg_size;
> +	struct mu_hdr header;
> +
> +	dev_dbg(dev, "Message received on mailbox\n");

Drop.

> +
> +	/* The function can be called with NULL msg */
> +	if (!msg) {
> +		dev_err(dev, "Message is invalid\n");
> +		return;
> +	}
> +
> +	if (IS_ERR(msg)) {

IS_ERR_OR_NULL is a sign of poor coding or bug.

> +		dev_err(dev, "Error during reception of message: %ld\n",
> +				PTR_ERR(msg));
> +		return;
> +	}

> +
> +	header.tag = ((u8 *)msg)[TAG_OFFSET];
> +	header.command = ((u8 *)msg)[CMD_OFFSET];
> +	header.size = ((u8 *)msg)[SZ_OFFSET];
> +	header.ver = ((u8 *)msg)[VER_OFFSET];
> +
> +	dev_dbg(dev, "Selecting device\n");

Drop, useless debug.

> +
> +	/* Incoming command: wake up the receiver if any. */
> +	if (header.tag == priv->cmd_tag) {
> +		dev_dbg(dev, "Selecting cmd receiver\n");
> +		dev_ctx = priv->cmd_receiver_dev;
> +	} else if (header.tag == priv->rsp_tag) {
> +		if (priv->waiting_rsp_dev) {
> +			dev_dbg(dev, "Selecting rsp waiter\n");
> +			dev_ctx = priv->waiting_rsp_dev;
> +			is_response = true;
> +		} else {
> +			/* Reading the EdgeLock Enclave response
> +			 * to the command sent by other
> +			 * linux kernel services.
> +			 */
> +			spin_lock(&priv->lock);
> +			priv->rx_msg = *(struct ele_api_msg *)msg;
> +			complete(&priv->done);
> +			spin_unlock(&priv->lock);
> +			return;
> +		}
> +	} else {
> +		dev_err(dev, "Failed to select a device for message: %.8x\n",
> +				*((u32 *) &header));
> +		return;
> +	}
> +
> +	if (!dev_ctx) {
> +		dev_err(dev, "No device context selected for message: %.8x\n",
> +				*((u32 *)&header));
> +		return;
> +	}
> +	/* Init reception */
> +	msg_size = header.size;
> +	if (msg_size > MAX_RECV_SIZE) {
> +		devctx_err(dev_ctx, "Message is too big (%d > %d)", msg_size,
> +				MAX_RECV_SIZE);
> +		return;
> +	}
> +
> +	memcpy(dev_ctx->temp_resp, msg, msg_size << 2);
> +	dev_ctx->temp_resp_size = msg_size;
> +
> +	/* Allow user to read */
> +	dev_ctx->pending_hdr = dev_ctx->temp_resp[0];
> +	wake_up_interruptible(&dev_ctx->wq);
> +
> +	if (is_response)
> +		priv->waiting_rsp_dev = NULL;
> +
> +}
> +
> +static void ele_ping_handler(struct work_struct *work)
> +{
> +	int ret;
> +
> +	ret = ele_ping();
> +	if (ret)
> +		pr_err("ping ele failed, try again!\n");

Why? How to try again?

> +
> +	/* reschedule the delay work */
> +	schedule_delayed_work(to_delayed_work(work), ELE_PING_INTERVAL);
> +}
> +static DECLARE_DELAYED_WORK(ele_ping_work, ele_ping_handler);
> +
> +static phys_addr_t get_phy_buf_mem_pool(struct device_node *of_node,
> +					char *mem_pool_name,
> +					u32 **buf,
> +					uint32_t size)
> +{
> +	struct gen_pool *mem_pool = of_gen_pool_get(of_node,
> +						    mem_pool_name, 0);
> +	if (!mem_pool) {
> +		pr_err("Unable to get sram pool\n");
> +		return 0;
> +	}
> +
> +	*buf = (u32 *)gen_pool_alloc(mem_pool, size);
> +	if (!buf) {
> +		pr_err("Unable to alloc sram from sram pool\n");
> +		return 0;
> +	}
> +
> +	return gen_pool_virt_to_phys(mem_pool, (ulong)*buf);
> +}
> +
> +static void free_phybuf_mem_pool(struct device_node *of_node,
> +				 char *mem_pool_name,
> +				 u32 *buf,
> +				 uint32_t size)
> +{
> +	struct gen_pool *mem_pool = of_gen_pool_get(of_node,
> +						    mem_pool_name, 0);
> +	if (!mem_pool)
> +		pr_err("%s failed: Unable to get sram pool.\n", __func__);
> +
> +	gen_pool_free(mem_pool, (unsigned long)buf, size);
> +}
> +
> +
> +static int imx_soc_device_register(struct platform_device *pdev,
> +				   struct imx_info *info)
> +{
> +	struct soc_device_attribute *attr;
> +	struct soc_device *dev;
> +	phys_addr_t get_info_addr = 0;
> +	u32 *get_info_data = NULL;
> +	u8 major_ver, minor_ver;
> +	int err;
> +
> +	if (info->pool_name) {
> +		get_info_addr = get_phy_buf_mem_pool(pdev->dev.of_node,
> +						     info->pool_name,
> +						     &get_info_data,
> +						     DEVICE_GET_INFO_SZ);
> +	} else {
> +		get_info_data = dmam_alloc_coherent(&pdev->dev,
> +						    DEVICE_GET_INFO_SZ,
> +						    &get_info_addr,
> +						    GFP_KERNEL);
> +	}
> +	if (!get_info_addr) {
> +		pr_err("Unable to alloc buffer for device info.\n");
> +		return -ENOMEM;
> +	}
> +
> +	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
> +	if (!attr)
> +		return -ENOMEM;
> +
> +	err = ele_get_info(get_info_addr, ELE_GET_INFO_READ_SZ);
> +	if (err) {
> +		attr->revision = kasprintf(GFP_KERNEL, "A0");
> +	} else {
> +		major_ver = (get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_VER_MASK) >> 24;
> +		minor_ver = ((get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_VER_MASK) >> 16) & 0xFF;
> +		if (minor_ver)
> +			attr->revision = kasprintf(GFP_KERNEL,
> +						   "%x.%x",
> +						   major_ver,
> +						   minor_ver);
> +		else
> +			attr->revision = kasprintf(GFP_KERNEL,
> +						   "%x",
> +						   major_ver);
> +
> +		switch (get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> +				& SOC_ID_MASK) {
> +			case SOC_ID_OF_IMX8ULP:
> +				attr->soc_id = kasprintf(GFP_KERNEL,
> +							 "i.MX8ULP");
> +				break;
> +			case SOC_ID_OF_IMX93:
> +				attr->soc_id = kasprintf(GFP_KERNEL,
> +							 "i.MX93");
> +				break;
> +		}
> +	}
> +
> +	err = of_property_read_string(of_root, "model",
> +				      &attr->machine);
> +	if (err) {
> +		kfree(attr);
> +		return -EINVAL;
> +	}
> +	attr->family = kasprintf(GFP_KERNEL, "Freescale i.MX");

Why are you doing soc attr for entire machine in unrelated driver?

> +
> +	attr->serial_number
> +		= kasprintf(GFP_KERNEL, "%016llX",
> +			    (u64)get_info_data[GET_INFO_SL_NUM_MSB_WORD_OFF] << 32
> +			    | get_info_data[GET_INFO_SL_NUM_LSB_WORD_OFF]);
> +
> +	if (info->pool_name) {
> +		free_phybuf_mem_pool(pdev->dev.of_node, info->pool_name,
> +				     get_info_data, DEVICE_GET_INFO_SZ);
> +	} else {
> +		dmam_free_coherent(&pdev->dev,
> +				   DEVICE_GET_INFO_SZ,
> +				   get_info_data,
> +				   get_info_addr);
> +	}
> +
> +	dev = soc_device_register(attr);

Nope, this is not a soc device.

> +	if (IS_ERR(dev)) {
> +		kfree(attr->soc_id);
> +		kfree(attr->serial_number);
> +		kfree(attr->revision);
> +		kfree(attr->family);
> +		kfree(attr->machine);
> +		kfree(attr);
> +		return PTR_ERR(dev);
> +	}
> +
> +	return 0;
> +}
> +

...

> +	return err;
> +}
> +
> +
> +

Drop stray blank lines. Everywhere.


> +/* Open a char device. */
> +static int ele_mu_fops_open(struct inode *nd, struct file *fp)
> +{
> +	struct ele_mu_device_ctx *dev_ctx
> +		= container_of(fp->private_data,
> +			       struct ele_mu_device_ctx,
> +			       miscdev);
> +	int err;
> +
> +	/* Avoid race if opened at the same time */
> +	if (down_trylock(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	/* Authorize only 1 instance. */
> +	if (dev_ctx->status != MU_FREE) {
> +		err = -EBUSY;
> +		goto exit;
> +	}
> +
> +	/*
> +	 * Allocate some memory for data exchanges with S40x.
> +	 * This will be used for data not requiring secure memory.
> +	 */
> +	dev_ctx->non_secure_mem.ptr = dmam_alloc_coherent(dev_ctx->dev,
> +					MAX_DATA_SIZE_PER_USER,
> +					&dev_ctx->non_secure_mem.dma_addr,
> +					GFP_KERNEL);
> +	if (!dev_ctx->non_secure_mem.ptr) {
> +		err = -ENOMEM;
> +		devctx_err(dev_ctx, "Failed to map shared memory with S40x\n");
> +		goto exit;
> +	}
> +
> +	err = ele_mu_setup_ele_mem_access(dev_ctx,
> +					  dev_ctx->non_secure_mem.dma_addr,
> +					  MAX_DATA_SIZE_PER_USER);
> +	if (err) {
> +		err = -EPERM;
> +		devctx_err(dev_ctx,
> +			   "Failed to share access to shared memory\n");
> +		goto free_coherent;
> +	}
> +
> +	dev_ctx->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
> +	dev_ctx->non_secure_mem.pos = 0;
> +	dev_ctx->status = MU_OPENED;
> +
> +	dev_ctx->pending_hdr = 0;
> +
> +	goto exit;
> +
> +free_coherent:
> +	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
> +			   dev_ctx->non_secure_mem.ptr,
> +			   dev_ctx->non_secure_mem.dma_addr);
> +
> +exit:
> +	up(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +/* Close a char device. */
> +static int ele_mu_fops_close(struct inode *nd, struct file *fp)
> +{
> +	struct ele_mu_device_ctx *dev_ctx = container_of(fp->private_data,
> +					struct ele_mu_device_ctx, miscdev);
> +	struct ele_mu_priv *priv = dev_ctx->priv;
> +	struct ele_buf_desc *b_desc;
> +
> +	/* Avoid race if closed at the same time */
> +	if (down_trylock(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	/* The device context has not been opened */
> +	if (dev_ctx->status != MU_OPENED)
> +		goto exit;
> +
> +	/* check if this device was registered as command receiver. */
> +	if (priv->cmd_receiver_dev == dev_ctx)
> +		priv->cmd_receiver_dev = NULL;
> +
> +	/* check if this device was registered as waiting response. */
> +	if (priv->waiting_rsp_dev == dev_ctx) {
> +		priv->waiting_rsp_dev = NULL;
> +		mutex_unlock(&priv->mu_cmd_lock);
> +	}
> +
> +	/* Unmap secure memory shared buffer. */
> +	if (dev_ctx->secure_mem.ptr)
> +		devm_iounmap(dev_ctx->dev, dev_ctx->secure_mem.ptr);
> +
> +	dev_ctx->secure_mem.ptr = NULL;
> +	dev_ctx->secure_mem.dma_addr = 0;
> +	dev_ctx->secure_mem.size = 0;
> +	dev_ctx->secure_mem.pos = 0;
> +
> +	/* Free non-secure shared buffer. */
> +	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
> +			   dev_ctx->non_secure_mem.ptr,
> +			   dev_ctx->non_secure_mem.dma_addr);
> +
> +	dev_ctx->non_secure_mem.ptr = NULL;
> +	dev_ctx->non_secure_mem.dma_addr = 0;
> +	dev_ctx->non_secure_mem.size = 0;
> +	dev_ctx->non_secure_mem.pos = 0;
> +
> +	while (!list_empty(&dev_ctx->pending_in) ||
> +	       !list_empty(&dev_ctx->pending_out)) {
> +		if (!list_empty(&dev_ctx->pending_in))
> +			b_desc = list_first_entry_or_null(&dev_ctx->pending_in,
> +							  struct ele_buf_desc,
> +							  link);
> +		else
> +			b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
> +							  struct ele_buf_desc,
> +							  link);
> +
> +		if (!b_desc)
> +			continue;
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		__list_del_entry(&b_desc->link);
> +		devm_kfree(dev_ctx->dev, b_desc);
> +	}
> +
> +	dev_ctx->status = MU_FREE;
> +
> +exit:
> +	up(&dev_ctx->fops_lock);
> +	return 0;
> +}
> +
> +/* IOCTL entry point of a char device */
> +static long ele_mu_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
> +{
> +	struct ele_mu_device_ctx *dev_ctx
> +		= container_of(fp->private_data,
> +			       struct ele_mu_device_ctx,
> +			       miscdev);
> +	struct ele_mu_priv *ele_mu_priv = dev_ctx->priv;
> +	int err = -EINVAL;
> +
> +	/* Prevent race during change of device context */
> +	if (down_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	switch (cmd) {
> +	case ELE_MU_IOCTL_ENABLE_CMD_RCV:
> +		if (!ele_mu_priv->cmd_receiver_dev) {
> +			ele_mu_priv->cmd_receiver_dev = dev_ctx;
> +			err = 0;
> +		};
> +		break;
> +	case ELE_MU_IOCTL_GET_MU_INFO:
> +		err = ele_mu_ioctl_get_mu_info(dev_ctx, arg);
> +		break;
> +	case ELE_MU_IOCTL_SHARED_BUF_CFG:
> +		devctx_err(dev_ctx,
> +			   "ELE_MU_IOCTL_SHARED_BUF_CFG not supported [0x%x].\n",
> +			   err);
> +		break;
> +	case ELE_MU_IOCTL_SETUP_IOBUF:
> +		err = ele_mu_ioctl_setup_iobuf_handler(dev_ctx, arg);
> +		break;
> +	case ELE_MU_IOCTL_SIGNED_MESSAGE:
> +		devctx_err(dev_ctx,
> +			   "ELE_MU_IOCTL_SIGNED_MESSAGE not supported [0x%x].\n",
> +			   err);
> +		break;
> +	default:
> +		err = -EINVAL;
> +		devctx_dbg(dev_ctx, "IOCTL %.8x not supported\n", cmd);
> +	}
> +
> +	up(&dev_ctx->fops_lock);
> +	return (long)err;
> +}
> +
> +/* Char driver setup */
> +static const struct file_operations ele_mu_fops = {

Where did you document user-space ABI?

> +	.open		= ele_mu_fops_open,
> +	.owner		= THIS_MODULE,
> +	.release	= ele_mu_fops_close,
> +	.unlocked_ioctl = ele_mu_ioctl,
> +	.read		= ele_mu_fops_read,
> +	.write		= ele_mu_fops_write,
> +};
> +
> +/* interface for managed res to free a mailbox channel */
> +static void if_mbox_free_channel(void *mbox_chan)
> +{
> +	mbox_free_channel(mbox_chan);
> +}
> +
> +/* interface for managed res to unregister a char device */
> +static void if_misc_deregister(void *miscdevice)
> +{
> +	misc_deregister(miscdevice);
> +}
> +
> +static int ele_mu_request_channel(struct device *dev,
> +				 struct mbox_chan **chan,
> +				 struct mbox_client *cl,
> +				 const char *name)
> +{
> +	struct mbox_chan *t_chan;
> +	int ret = 0;
> +
> +	t_chan = mbox_request_channel_byname(cl, name);
> +	if (IS_ERR(t_chan)) {
> +		ret = PTR_ERR(t_chan);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev,
> +				"Failed to request chan %s ret %d\n", name,
> +				ret);
> +		goto exit;
> +	}
> +
> +	ret = devm_add_action(dev, if_mbox_free_channel, t_chan);
> +	if (ret) {
> +		dev_err(dev, "failed to add devm removal of mbox %s\n", name);
> +		goto exit;
> +	}
> +
> +	*chan = t_chan;
> +
> +exit:
> +	return ret;
> +}
> +
> +static int ele_probe_cleanup(struct platform_device *pdev)
> +{
> +	int ret;
> +	int i;
> +	struct device *dev = &pdev->dev;
> +	struct ele_mu_priv *priv = dev_get_drvdata(dev);
> +
> +	if (!priv) {
> +		ret = -EINVAL;
> +		dev_err(dev, "Invalid ELE-MU Priv data");
> +		return ret;
> +	}
> +
> +	if (priv->tx_chan)
> +		mbox_free_channel(priv->tx_chan);
> +	if (priv->rx_chan)
> +		mbox_free_channel(priv->rx_chan);
> +
> +	/* free the buffer in ele-mu remove, previously allocated
> +	 * in ele-mu probe to store encrypted IMEM
> +	 */
> +	if (priv->imem.buf) {
> +		dmam_free_coherent(&pdev->dev,
> +				   ELE_IMEM_SIZE,
> +				   priv->imem.buf,
> +				   priv->imem.phyaddr);
> +		priv->imem.buf = NULL;
> +	}
> +
> +	if (priv->flags & RESERVED_DMA_POOL) {
> +		of_reserved_mem_device_release(dev);
> +		priv->flags &= (~RESERVED_DMA_POOL);
> +	}
> +	if (priv->ctxs) {
> +		for (i = 0; i < priv->max_dev_ctx; i++) {
> +			if (priv->ctxs[i])
> +				devm_kfree(dev, priv->ctxs[i]);
> +		}
> +		devm_kfree(dev, priv->ctxs);
> +	}
> +	devm_kfree(dev, priv);
> +	return ret;
> +}
> +
> +static int ele_mu_probe(struct platform_device *pdev)
> +{
> +	struct ele_mu_device_ctx *dev_ctx;
> +	struct device *dev = &pdev->dev;
> +	struct ele_mu_priv *priv;
> +	struct device_node *np;
> +	const struct of_device_id *of_id = of_match_device(ele_mu_match, dev);
> +	struct imx_info *info = (of_id != NULL) ? (struct imx_info *)of_id->data
> +						: NULL;

That's some spaghetti code. Can of_id be NULL?

> +	char *devname;
> +	uint32_t tmp_dt_value = 0;
> +	int ret;
> +	int i;
> +
> +	if (!info) {
> +		ret = -EINVAL;
> +		dev_err(dev, "%s: Incompatible Device.\n", __func__);

NAK, explain how this is even possible.

> +		return ret;
> +	}
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		dev_err(dev, "Fail allocate mem for private data\n");

I asked about doing internal review. This is trivial mistake, so I doubt
you did any internal review. Even tools point it out (coccinelle,
smatch, sparse).

> +		return ret;
> +	}
> +	memset(priv, 0x0, sizeof(*priv));
> +	priv->dev = dev;
> +	dev_set_drvdata(dev, priv);
> +
> +	/*
> +	 * Get the address of MU to be used for communication with the SCU
> +	 */
> +	np = pdev->dev.of_node;
> +	if (!np) {
> +		dev_err(dev, "Cannot find MU User entry in device tree\n");

No, how is this even possible? Please, do not add code which cannot
work/happen.

> +		ret = -EOPNOTSUPP;
> +		goto exit;
> +	}
> +
> +	/* Initialize the mutex. */
> +	mutex_init(&priv->mu_cmd_lock);
> +	mutex_init(&priv->mu_lock);
> +
> +	priv->cmd_receiver_dev = NULL;
> +	priv->waiting_rsp_dev = NULL;
> +
> +	ret = of_property_read_u32(np, "fsl,mu-did", &tmp_dt_value);
> +	if (ret) {
> +		ret = -EINVAL;
> +		dev_err(dev, "%s: Not able to read mu-did", __func__);
> +		goto exit;
> +	}
> +	priv->ele_mu_did = tmp_dt_value & 0xFF;
> +
> +	ret = of_property_read_u32(np, "fsl,mu-id", &tmp_dt_value);
> +	if (ret) {
> +		ret = -EINVAL;
> +		dev_err(dev, "%s: Not able to read mu-id", __func__);
> +		goto exit;
> +	}
> +	priv->ele_mu_id = tmp_dt_value & 0xFF;
> +
> +	priv->max_dev_ctx = info->max_dev_ctx;
> +
> +	priv->cmd_tag = info->cmd_tag;
> +	priv->rsp_tag = info->rsp_tag;
> +
> +	/* Mailbox client configuration */
> +	priv->ele_mb_cl.dev		= dev;
> +	priv->ele_mb_cl.tx_block	= false;
> +	priv->ele_mb_cl.knows_txdone	= true;
> +	priv->ele_mb_cl.rx_callback	= ele_mu_rx_callback;
> +
> +	ret = ele_mu_request_channel(dev, &priv->tx_chan,
> +				     &priv->ele_mb_cl, "tx");
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to request tx channel\n");
> +
> +		goto exit;
> +	}
> +
> +	ret = ele_mu_request_channel(dev, &priv->rx_chan,
> +				     &priv->ele_mb_cl, "rx");
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to request rx channel\n");
> +
> +		goto exit;
> +	}
> +
> +	priv->ctxs = devm_kzalloc(dev, sizeof(dev_ctx) * priv->max_dev_ctx,
> +				  GFP_KERNEL);
> +
> +	if (!priv->ctxs) {
> +		ret = -ENOMEM;
> +		dev_err(dev, "Fail allocate mem for private dev-ctxs.\n");
> +		goto exit;
> +	}
> +
> +	/* Create users */
> +	for (i = 0; i < priv->max_dev_ctx; i++) {
> +		dev_ctx = devm_kzalloc(dev, sizeof(*dev_ctx), GFP_KERNEL);
> +		if (!dev_ctx) {
> +			ret = -ENOMEM;
> +			dev_err(dev,
> +				"Fail to allocate memory for device context\n");
> +			goto exit;
> +		}
> +
> +		dev_ctx->dev = dev;
> +		dev_ctx->status = MU_FREE;
> +		dev_ctx->priv = priv;
> +
> +		priv->ctxs[i] = dev_ctx;
> +
> +		/* Default value invalid for an header. */
> +		init_waitqueue_head(&dev_ctx->wq);
> +
> +		INIT_LIST_HEAD(&dev_ctx->pending_out);
> +		INIT_LIST_HEAD(&dev_ctx->pending_in);
> +		sema_init(&dev_ctx->fops_lock, 1);
> +
> +		devname = devm_kasprintf(dev, GFP_KERNEL, "ele_mu%d_ch%d",
> +					 priv->ele_mu_id, i);
> +		if (!devname) {
> +			ret = -ENOMEM;
> +			dev_err(dev,
> +				"Fail to allocate memory for misc dev name\n");
> +			goto exit;
> +		}
> +
> +		dev_ctx->miscdev.name = devname;
> +		dev_ctx->miscdev.minor = MISC_DYNAMIC_MINOR;
> +		dev_ctx->miscdev.fops = &ele_mu_fops;
> +		dev_ctx->miscdev.parent = dev;
> +		ret = misc_register(&dev_ctx->miscdev);
> +		if (ret) {
> +			dev_err(dev, "failed to register misc device %d\n",
> +				ret);
> +			goto exit;
> +		}
> +
> +		ret = devm_add_action(dev, if_misc_deregister,
> +				      &dev_ctx->miscdev);
> +		if (ret) {
> +			dev_err(dev,
> +				"failed[%d] to add action to the misc-dev\n",
> +				ret);
> +			goto exit;
> +		}
> +	}
> +
> +	init_completion(&priv->done);
> +	spin_lock_init(&priv->lock);
> +
> +	ele_priv_export = priv;
> +
> +	if (info && info->reserved_dma_ranges) {
> +		ret = of_reserved_mem_device_init(dev);

You don't have reserved memory, according to your bindings.

> +		if (ret) {
> +			dev_err(dev,
> +				"failed to init reserved memory region %d\n",
> +				ret);
> +			priv->flags &= (~RESERVED_DMA_POOL);
> +			goto exit;
> +		}
> +		priv->flags |= RESERVED_DMA_POOL;
> +	}
> +
> +	if (info && info->init_fw) {
> +		/* start initializing ele fw */
> +		ret = ele_init_fw();
> +		if (ret)
> +			dev_err(dev, "Failed to initialize ele fw.\n");
> +	}
> +
> +	if (info && info->socdev) {
> +		ret = imx_soc_device_register(pdev, info);

It's not a soc device.

> +		if (ret) {
> +			dev_err(dev,
> +				"failed[%d] to register SoC device\n", ret);
> +			goto exit;
> +		}
> +	}
> +
> +	if (info && info->imem_mgmt) {
> +		/* allocate buffer where ELE store encrypted IMEM */
> +		priv->imem.buf = dmam_alloc_coherent(dev, ELE_IMEM_SIZE,
> +						     &priv->imem.phyaddr,
> +						     GFP_KERNEL);
> +		if (!priv->imem.buf) {
> +			dev_err(dev,
> +				"dmam-alloc-failed: To store encr-IMEM.\n");
> +			ret = -ENOMEM;
> +			goto exit;
> +		}
> +	}
> +
> +	/* start ele rng */
> +	ret = ele_do_start_rng();
> +	if (ret)
> +		dev_err(dev, "Failed to start ele rng\n");
> +
> +	if (!ret && info && info->enable_ele_trng) {
> +		ret = ele_trng_init(dev);
> +		if (ret)
> +			dev_err(dev, "Failed to init ele-trng\n");
> +	}
> +
> +	/*
> +	 * A ELE ping request must be send at least once every day(24 hours),
> +	 * so setup a delay work with 1 hour interval
> +	 * to ping ELE periodically.
> +	 */
> +	schedule_delayed_work(&ele_ping_work, ELE_PING_INTERVAL);
> +
> +	dev_set_drvdata(dev, priv);
> +
> +	pr_info("Misc-devices on i.MX enclave MU is configured.\n");

No silly probe success messages.


> +	return devm_of_platform_populate(dev);

No. You do not have children. Just open your own binding and look there.

This driver is in terrible shape and I asked to do some internal review
in NXP. Internal review should point such trivial comments but your
changelog from v1 tp v4 says nothing about it.

So internal review did not happen. Don't use upstream as cheap reviewers
for poor quality code. Please work internally till it starts looking
correct and all automated tools pass. NXP is not some small, amateour
company which can be excused of this. Or is it?

Best regards,
Krzysztof

