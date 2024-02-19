Return-Path: <linux-kernel+bounces-71221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9ED85A221
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5ED1F21EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE9D2C691;
	Mon, 19 Feb 2024 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dUCI/3Yo"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39C02C861
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342733; cv=none; b=JNiQbqfmTsTUEm6aqvz5Db6zKUNraK82RvKr+pXkgtzZEsISg7GXsbR/FcQrfdyo1riPwVOV8HK/2buGNrORk9wZqX/KOA8+yh63HgaKZerxzfX+EhHbxL1hmC9jaLcy4BgwKNYK9adU00Lz+0TSXT6kFx1IcwqzFbaLOS7Bx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342733; c=relaxed/simple;
	bh=jr44VXtqh1WfN5s8vQyEdoQue8G83eRGigWTX8V3R/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iVkwMZFObv5O7Y/U4gys+ybVUfwDgAOPKQ+b8zX/+0dlXMqiFDBSq6zyN3+zVhAWJbkelSYJ/pui3vQ30vP0AWxTA31VgkwRUF2StdiICKs2RO0yUFjfnm6W5Z4/v8ACsaX/SpTAC3usObghpidf1GtuaJRpWLvblasqqfA3pBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dUCI/3Yo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d153254b7so1871622f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708342730; x=1708947530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RgCc9xkjAlHBUoV30Un9Gq7IYtTdQzKUjRHl/TDRQVI=;
        b=dUCI/3YoLDn74dH7MKxWqlh6o+/F141AOh/fE41nsuSgNjweRLMuvwCNxUjW8ujySG
         ujtf+dgRgSoYWsvebx8Mxy2MOG4OTs4qg6Kk5Yjvqrt/0xQUsU+SwC5WCHccwCJLmnW7
         D3IWDBT8sE+k9iX6YG60OUJNZN1P1H0zwRQ6ohUwXdF9ft29zjWRIYUcSXl2BlNrJ9U+
         KT2I+nffPIB3fcknUe/T1X5BdL51/aJ6cZJAOAInKPi7U3pyNyDeMk3ODDpE9NrqxuIU
         KMPIDpT1hDo+sL0aSbZQAWv2ustU4kuW2Y2rdd6F0clmXIwdWgMSK2dxr7JQRweIkyEy
         lcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708342730; x=1708947530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgCc9xkjAlHBUoV30Un9Gq7IYtTdQzKUjRHl/TDRQVI=;
        b=cRrnEZP7aeCxUtrhHPj1aksnX+Ym4IazsIsc44mU+VREDlXt/O3ZDbLgc8Gt8mkINt
         geIiAMSFBS5F/svgcOz7YUTLV2uGiVXc1+qYSY8WL1lZSFVFzvdMJ9CsmUoQkoH1Mkz/
         gbnA4pBTHIRJMi0t6ssdFte6rtAfZwPDEB+fQFdbcKmtGRs6+XoExsb92xqycBHpsSUM
         oe8EoY29C8FqYO48ntI1ww6TIgFlif/cmacEGFv7TH/2ltrf5nZETd+dR5nawAEutQEk
         TtO2TghUO40Aa+zLTnjXBWbtEeJFcMgZPtlBzyfP6X3hHThcKrHxeecBg0I2PfkV7r2Y
         HgCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/St0Gba3bX+v9r7d0jXlsEjUASg8GpO7OpLApoqQrsRkXx18GsAXRjQ1ESPIAbGqoytnVwDoSOxUR9BihxuMjsUnIFm/mAEeNdxok
X-Gm-Message-State: AOJu0Yz5c/fWPgEdL4I8O87JOlQ65FizZVY+sBNVu+oeZD3rRKcf1ebC
	pDZlhGAeJjYNIlKxnKvYq53mHgCwOlPUfvZseITrHOg5+XBs688cyxhkNKLkxxU=
X-Google-Smtp-Source: AGHT+IFmuNVQ7UlRuPrxHeguM8IFbjVIjhzZhoC+9YobmX6Mn/J7gsAOTr3zn1otvedrjfDNc9H2TA==
X-Received: by 2002:a5d:4e52:0:b0:33d:3909:ff6 with SMTP id r18-20020a5d4e52000000b0033d39090ff6mr3046644wrt.29.1708342730078;
        Mon, 19 Feb 2024 03:38:50 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d4e8e000000b0033cdf1f15e8sm10152630wru.16.2024.02.19.03.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 03:38:49 -0800 (PST)
Message-ID: <058be836-bcd4-403e-bbc3-bb75f3f3d896@linaro.org>
Date: Mon, 19 Feb 2024 11:38:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: spi-mem: add statistics support to ->exec_op()
 calls
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dhruva Gole <d-gole@ti.com>, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20240216-spi-mem-stats-v2-1-9256dfe4887d@bootlin.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240216-spi-mem-stats-v2-1-9256dfe4887d@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/16/24 16:42, Théo Lebrun wrote:
> Current behavior is that spi-mem operations do not increment statistics,
> neither per-controller nor per-device, if ->exec_op() is used. For
> operations that do NOT use ->exec_op(), stats are increased as the
> usual spi_sync() is called.
> 
> The newly implemented spi_mem_add_op_stats() function is strongly
> inspired by spi_statistics_add_transfer_stats(); locking logic and
> l2len computation comes from there.
> 
> Statistics that are being filled: bytes{,_rx,_tx}, messages, transfers,
> errors, timedout, transfer_bytes_histo_*.
> 
> Note about messages & transfers counters: in the fallback to spi_sync()
> case, there are from 1 to 4 transfers per message. We only register one
> big transfer in the ->exec_op() case as that is closer to reality.
> 
> This patch is NOT touching:
>  - spi_async, spi_sync, spi_sync_immediate: those counters describe
>    precise function calls, incrementing them would be lying. I believe
>    comparing the messages counter to spi_async+spi_sync is a good way
>    to detect ->exec_op() calls, but I might be missing edge cases
>    knowledge.
>  - transfers_split_maxsize: splitting cannot happen if ->exec_op() is
>    provided.
> 
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com
> ---
> Changes in v2:
> - Turn len and l2len into u64. Remove casts on all 4 nbytes fields.
>   Remove clamp of l2len to be positive.
> - Replace "xferred" in comment by "transferred".
> - Remove sysfs demo from commit message. Moved to below the tear line.
> - Take Reviewed-by Dhruva Gole.
> - Link to v1: https://lore.kernel.org/r/20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
> 
> Testing this patch:
> 
>    $ cd /sys/devices/platform/soc
>    $ find . -type d -path "*spi*" -name statistics
>    ./2100000.spi/spi_master/spi0/statistics
>    ./2100000.spi/spi_master/spi0/spi0.0/statistics
>    $ cd ./2100000.spi/spi_master/spi0/statistics
> 
>    $ for f in *; do printf "%s\t" $f; cat $f; done | \
>          grep -v transfer_bytes_histo | column -t
>    bytes                    240745444
>    bytes_rx                 240170907
>    bytes_tx                 126320
>    errors                   0
>    messages                 97354
>    spi_async                0
>    spi_sync                 0
>    spi_sync_immediate       0
>    timedout                 0
>    transfers                97354
>    transfers_split_maxsize  0
> ---
>  drivers/spi/spi-mem.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 2dc8ceb85374..c9d6d42a88f5 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -297,6 +297,49 @@ static void spi_mem_access_end(struct spi_mem *mem)
>  		pm_runtime_put(ctlr->dev.parent);
>  }
>  
> +static void spi_mem_add_op_stats(struct spi_statistics __percpu *pcpu_stats,
> +				 const struct spi_mem_op *op, int exec_op_ret)
> +{
> +	struct spi_statistics *stats;
> +	u64 len, l2len;
> +
> +	get_cpu();
> +	stats = this_cpu_ptr(pcpu_stats);
> +	u64_stats_update_begin(&stats->syncp);
> +
> +	/*
> +	 * We do not have the concept of messages or transfers. Let's consider
> +	 * that one operation is equivalent to one message and one transfer.
> +	 */
> +	u64_stats_inc(&stats->messages);
> +	u64_stats_inc(&stats->transfers);
> +
> +	/* Use the sum of all lengths as bytes count and histogram value. */
> +	len = op->cmd.nbytes + op->addr.nbytes;
> +	len += op->dummy.nbytes + op->data.nbytes;
> +	u64_stats_add(&stats->bytes, len);
> +	l2len = min(fls(len), SPI_STATISTICS_HISTO_SIZE) - 1;
> +	u64_stats_inc(&stats->transfer_bytes_histo[l2len]);
> +
> +	/* Only account for data bytes as transferred bytes. */
> +	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
> +		u64_stats_add(&stats->bytes_tx, op->data.nbytes);
> +	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN)
> +		u64_stats_add(&stats->bytes_rx, op->data.nbytes);
> +
> +	/*
> +	 * A timeout is not an error, following the same behavior as
> +	 * spi_transfer_one_message().
> +	 */
> +	if (exec_op_ret == -ETIMEDOUT)
> +		u64_stats_inc(&stats->timedout);
> +	else if (exec_op_ret)
> +		u64_stats_inc(&stats->errors);
> +
> +	u64_stats_update_end(&stats->syncp);
> +	put_cpu();
> +}
> +
>  /**
>   * spi_mem_exec_op() - Execute a memory operation
>   * @mem: the SPI memory
> @@ -339,8 +382,12 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		 * read path) and expect the core to use the regular SPI
>  		 * interface in other cases.
>  		 */
> -		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP)
> +		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP) {
> +			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
> +			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
> +
>  			return ret;
> +		}
>  	}
>  
>  	tmpbufsize = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
> 
> ---
> base-commit: 19b50f80b3a4865bd477aa5c026dd234d39a50d2
> change-id: 20240209-spi-mem-stats-ff9bf91c0f7e
> 
> Best regards,

