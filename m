Return-Path: <linux-kernel+bounces-163219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371E58B6755
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61645B2210E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B401D2107;
	Tue, 30 Apr 2024 01:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lLFpyqSo"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5443117F5;
	Tue, 30 Apr 2024 01:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439972; cv=none; b=WOEf/bWJZVsIqL03D1pu9CyG7JA+XirbR18JS8/ckQNYjgKKhfOl6SWSo1fGAaXS856TGbGfDTha4GrDKo0UKiEYj1soTFMjnIdMHafNboUNP92orCygkCZ+OoxorMqR1C0AAuN9zXb5Ox35DWXS4knc/43ndZtDSE/qhOkaDHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439972; c=relaxed/simple;
	bh=5iZ99hL8rLW9Omic3Ib3QCvQr5r/yy03qKPRpwL6b1Q=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kDNlD+5lH3uPP7b/9o/THnLX8BAWmDko+A8zvxpurrhlUSOISn6+6QyOFPcXcUeuO6n4SEWDGMnalJwrt1y4hDk2mU74HxOCfrukJTZxf5hH9pNNm/4X7G14Qcebey5IkMHTCah1K4SbGdtUNWvlusQlghEHiPU4i2fEERN+EPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lLFpyqSo; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714439967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PqS7lS1pIBbD6kDZllq0+3D20q6bY1tUda5Uk1RI7Lw=;
	b=lLFpyqSoCd4YDFQ3nZQfh4C6eELTR5tG/ZP9vYPoNtjb/kLirRgx/DUgkP35dbA89vuCcK
	bHwvEBfFW+jo0m76i/nEXK4OQ3wybwZgHaXOeUblKjjJf46AQ8sNTPGDX6aXq2ZC1OP6We
	BeF1JwG29iBMQSDGrTh5t8kHLk7k0pJV6d5JNx6wnjSbV4tTs68xqeVYdhwhex/HVLsij1
	2FVSXsdGAx7kmzMhw66TzLD+I2cFsrvRnv+LG3HCz0Mc+DjQxC7HO1seesL+cV7kdttVgq
	PmaF/06kHwNAfGtmHepLTbnZUEK9hJWxvsNnooSpPP4iVpBQHqo0zgolVQ8xTg==
Date: Tue, 30 Apr 2024 03:19:27 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Avri
 Altman <avri.altman@wdc.com>, Felix Qin <xiaokeqinhealth@126.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: core: Convert to use __mmc_poll_for_busy()
 SD_APP_OP_COND too
In-Reply-To: <581352225de29859544b88f95ae5de89@manjaro.org>
References: <20240425133034.79599-1-ulf.hansson@linaro.org>
 <581352225de29859544b88f95ae5de89@manjaro.org>
Message-ID: <0062850816281e5720d88577cff2bfa9@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-30 03:17, Dragan Simic wrote:
> Hello Ulf,
> 
> Please see my comment below.
> 
> On 2024-04-25 15:30, Ulf Hansson wrote:
>> Similar to what has already been changed for eMMC and the 
>> MMC_SEND_OP_COND
>> (CMD1), let's convert the SD_APP_OP_COND (ACMD41) for SD cards to use 
>> the
>> common __mmc_poll_for_busy() too.
>> 
>> This change means the initial delay period, that starts as 10ms will 
>> now
>> increase for every loop when being busy. The total accepted timeout 
>> for
>> being busy is 1s, which is according to the SD spec.
>> 
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/core/sd_ops.c | 77 
>> +++++++++++++++++++++++++--------------
>>  1 file changed, 50 insertions(+), 27 deletions(-)
>> 
>> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
>> index a59cd592f06e..3ce1ff336826 100644
>> --- a/drivers/mmc/core/sd_ops.c
>> +++ b/drivers/mmc/core/sd_ops.c
>> @@ -19,6 +19,15 @@
>>  #include "sd_ops.h"
>>  #include "mmc_ops.h"
>> 
>> +#define SD_APP_OP_COND_PERIOD_US	(10 * 1000) /* 10ms */
>> +#define SD_APP_OP_COND_TIMEOUT_MS	1000 /* 1s */
>> +
>> +struct sd_app_op_cond_busy_data {
>> +	struct mmc_host *host;
>> +	u32 ocr;
>> +	struct mmc_command *cmd;
>> +};
>> +
>>  int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
>>  {
>>  	int err;
>> @@ -115,10 +124,44 @@ int mmc_app_set_bus_width(struct mmc_card *card,
>> int width)
>>  	return mmc_wait_for_app_cmd(card->host, card, &cmd);
>>  }
>> 
>> +static int sd_app_op_cond_cb(void *cb_data, bool *busy)
>> +{
>> +	struct sd_app_op_cond_busy_data *data = cb_data;
>> +	struct mmc_host *host = data->host;
>> +	struct mmc_command *cmd = data->cmd;
>> +	u32 ocr = data->ocr;
>> +	int err;
> 
> Minor nitpick...  An empty line should be added here, to
> separate the variable definitions from the subsequent code.
> 
> Otherwise, the patch is looking to me, so please include my

Oops...  s/looking to me/looking good to me/
Sorry for the noise.

> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> 
>> +	*busy = false;
>> +
>> +	err = mmc_wait_for_app_cmd(host, NULL, cmd);
>> +	if (err)
>> +		return err;
>> +
>> +	/* If we're just probing, do a single pass. */
>> +	if (ocr == 0)
>> +		return 0;
>> +
>> +	/* Wait until reset completes. */
>> +	if (mmc_host_is_spi(host)) {
>> +		if (!(cmd->resp[0] & R1_SPI_IDLE))
>> +			return 0;
>> +	} else if (cmd->resp[0] & MMC_CARD_BUSY) {
>> +		return 0;
>> +	}
>> +
>> +	*busy = true;
>> +	return 0;
>> +}
>> +
>>  int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>>  {
>>  	struct mmc_command cmd = {};
>> -	int i, err = 0;
>> +	struct sd_app_op_cond_busy_data cb_data = {
>> +		.host = host,
>> +		.ocr = ocr,
>> +		.cmd = &cmd
>> +	};
>> +	int err;
>> 
>>  	cmd.opcode = SD_APP_OP_COND;
>>  	if (mmc_host_is_spi(host))
>> @@ -127,36 +170,16 @@ int mmc_send_app_op_cond(struct mmc_host *host,
>> u32 ocr, u32 *rocr)
>>  		cmd.arg = ocr;
>>  	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
>> 
>> -	for (i = 100; i; i--) {
>> -		err = mmc_wait_for_app_cmd(host, NULL, &cmd);
>> -		if (err)
>> -			break;
>> -
>> -		/* if we're just probing, do a single pass */
>> -		if (ocr == 0)
>> -			break;
>> -
>> -		/* otherwise wait until reset completes */
>> -		if (mmc_host_is_spi(host)) {
>> -			if (!(cmd.resp[0] & R1_SPI_IDLE))
>> -				break;
>> -		} else {
>> -			if (cmd.resp[0] & MMC_CARD_BUSY)
>> -				break;
>> -		}
>> -
>> -		err = -ETIMEDOUT;
>> -
>> -		mmc_delay(10);
>> -	}
>> -
>> -	if (!i)
>> -		pr_err("%s: card never left busy state\n", mmc_hostname(host));
>> +	err = __mmc_poll_for_busy(host, SD_APP_OP_COND_PERIOD_US,
>> +				  SD_APP_OP_COND_TIMEOUT_MS, &sd_app_op_cond_cb,
>> +				  &cb_data);
>> +	if (err)
>> +		return err;
>> 
>>  	if (rocr && !mmc_host_is_spi(host))
>>  		*rocr = cmd.resp[0];
>> 
>> -	return err;
>> +	return 0;
>>  }
>> 
>>  static int __mmc_send_if_cond(struct mmc_host *host, u32 ocr, u8 
>> pcie_bits,

