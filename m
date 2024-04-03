Return-Path: <linux-kernel+bounces-130112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35C5897435
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D718283889
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6F114A0BF;
	Wed,  3 Apr 2024 15:41:53 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EAE433A8;
	Wed,  3 Apr 2024 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158912; cv=none; b=S6t7r6qFoczLre6XtgZzfGZQhU7UlF3qOb4Q5KQ9eAza+CTS6zNl4nyIg/DtKda8WSUMCuOAlZciS8r6Z2jbc2G39NC45I1pir3LmjeB8CFLmt/1kgTx9ZBQ4QSpPmlrb1BJfJ0CBQiuc6d3dnBIhf2CHxIM1pI0QuC/EtQglh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158912; c=relaxed/simple;
	bh=uOAOUbv3JDIP5FfSjwmVya7Dhk/mOV2/ffsRhnQsD5w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3fNLSWQvvM2xSWJGyeiFxc9XOs2jg0xMBsax0ak97xkffstdHjR9f7CwLE67CwTWtpL2ePg9qhMLbh4jhH5iBFD8tnE0Nn+UyVueZL7mPz2G3NM7qJ49lgF+wvOl1c3YePq6/J2hQmyFaEleTNUhQmyNZpCi/SZkQwVEdV3vr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8pqH2sdRz6D8XQ;
	Wed,  3 Apr 2024 23:40:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FBAB140B73;
	Wed,  3 Apr 2024 23:41:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 16:41:46 +0100
Date: Wed, 3 Apr 2024 16:41:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Kwangjin Ko
	<kwangjin.ko@sk.com>
Subject: Re: [PATCH] cxl/test: Enhance event testing
Message-ID: <20240403164145.00007bcd@Huawei.com>
In-Reply-To: <20240401-enhance-event-test-v1-1-6669a524ed38@intel.com>
References: <20240401-enhance-event-test-v1-1-6669a524ed38@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 01 Apr 2024 22:31:58 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> An issue was found in the processing of event logs when the output
> buffer length was not reset.[1]
> 
> This bug was not caught with cxl-test for 2 reasons.  First, the test
> harness mbox_send command [mock_get_event()] does not set the output
> size based on the amount of data returned like the hardware command
> does.  Second, the simplistic event log testing always returned the same
> number of elements per-get command.
> 
> Enhance the simulation of the event log mailbox to better match the bug
> found with real hardware to cover potential regressions.
> 
> NOTE: These changes will cause cxl-events.sh in ndctl to fail without
> the fix from Kwangjin.  However, no changes to the user space test was
> required.  Therefore ndctl itself will be compatible with old or new
> kernels once both patches land in the new kernel.

Good to state how many events are read out (22 I think) as that allows
reader of this patch to see that it will cycle all the way around, so we
will get the 4 to 1 reduction between two reads ensuring things work
correctly when smaller number of events are returned.

1, 2, 3, 4, 1, 2, 3, 4, 1, 1 
I think.
> 
> [1] Link: https://lore.kernel.org/all/20240401091057.1044-1-kwangjin.ko@sk.com/
> 
> Cc: Kwangjin Ko <kwangjin.ko@sk.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  tools/testing/cxl/test/mem.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 35ee41e435ab..6584443144de 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -127,7 +127,7 @@ static struct {
>  #define CXL_TEST_EVENT_CNT_MAX 15
>  
>  /* Set a number of events to return at a time for simulation.  */
> -#define CXL_TEST_EVENT_CNT 3
> +#define CXL_TEST_EVENT_RET_MAX 4
>  
>  struct mock_event_log {
>  	u16 clear_idx;
> @@ -222,6 +222,12 @@ static void mes_add_event(struct mock_event_store *mes,
>  	log->nr_events++;
>  }
>  
> +/*
> + * Vary the number of events returned to simulate events occuring while the
> + * logs are being read.
> + */
> +static int ret_limit = 0;
> +
>  static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  {
>  	struct cxl_get_event_payload *pl;
> @@ -233,14 +239,18 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  	if (cmd->size_in != sizeof(log_type))
>  		return -EINVAL;
>  
> -	if (cmd->size_out < struct_size(pl, records, CXL_TEST_EVENT_CNT))
> +	ret_limit = (ret_limit + 1) % CXL_TEST_EVENT_RET_MAX;
> +	if (!ret_limit)
> +		ret_limit = 1;
> +
> +	if (cmd->size_out < struct_size(pl, records, ret_limit))
>  		return -EINVAL;
>  
>  	log_type = *((u8 *)cmd->payload_in);
>  	if (log_type >= CXL_EVENT_TYPE_MAX)
>  		return -EINVAL;
>  
> -	memset(cmd->payload_out, 0, cmd->size_out);
> +	memset(cmd->payload_out, 0, struct_size(pl, records, 0));
>  
>  	log = event_find_log(dev, log_type);
>  	if (!log || event_log_empty(log))
> @@ -248,7 +258,7 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  
>  	pl = cmd->payload_out;
>  
> -	for (i = 0; i < CXL_TEST_EVENT_CNT && !event_log_empty(log); i++) {
> +	for (i = 0; i < ret_limit && !event_log_empty(log); i++) {
>  		memcpy(&pl->records[i], event_get_current(log),
>  		       sizeof(pl->records[i]));
>  		pl->records[i].event.generic.hdr.handle =
> @@ -256,6 +266,7 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  		log->cur_idx++;
>  	}
>  
> +	cmd->size_out = struct_size(pl, records, i);
>  	pl->record_count = cpu_to_le16(i);
>  	if (!event_log_empty(log))
>  		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
> 
> ---
> base-commit: 8d025e2092e29bfd13e56c78e22af25fac83c8ec
> change-id: 20240401-enhance-event-test-cebeff5189cd
> 
> Best regards,


