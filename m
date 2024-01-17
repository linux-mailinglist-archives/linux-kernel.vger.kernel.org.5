Return-Path: <linux-kernel+bounces-29272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E67830BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5340F1F22423
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770B322636;
	Wed, 17 Jan 2024 17:29:50 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA722619;
	Wed, 17 Jan 2024 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512590; cv=none; b=DpHN+nf6iZkNeNP/LtW/MHFAYEt8HNj5cC57VqqQhBAX2l8DuHwjdlQyA+HKtJAyU3KUs6sFIpiBs7RleTJjurZHSZrrp33QUBeckslc6nEfhXHsE+A8jj0ZGb9jecll7jLcjY8m43B+/wDV71WIa63KFxAsgEtXL3c485JJhao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512590; c=relaxed/simple;
	bh=3RguxiLQXwXyKy+/MBUXqv78BPdbE9j/r5/BDuDJGGQ=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding; b=Mhp4HbHjwSMBNPPjkfii7zUzGQSlwIJPyxsZZyUFe0ptdOjUW/7qAEL/qTkCk+ud6nupFZDW3DBkvSWL2026HYvraWLwj7ZbB+TQ9JbFk6GVLrXtMWvCQULwu1U1UoLCAsZCm8lnfcJ6uBsgAgZT40oWa7iKWNL1HTPI0LZD65U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ddf1e88e51so5480393a34.0;
        Wed, 17 Jan 2024 09:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705512588; x=1706117388;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdFUEs5+PqYWiTaTyZYNjEQamHx46wf3N9eVAnVojFA=;
        b=hXjj3WE/wWjU7aeiEwx1BCibpQpWCg8O5k6mPWUP9RpxF8WpSKa2BkT3qyJ2Yebswv
         W3kk2M2q+TbjAuqiTPeH0PKF4DUBayWy+hiDVTy25H+Sl0bW4BpbAUEr+4HhsaXUC3ML
         6jZKGrsaM7oe6YaTU+4oCuPxTbCMBSPQLMDtog9Wz+nkHHbf59chhL8c+IUc7D+I7Q8u
         UGJTOYBGYjPzjd/xqayj8Z0CD7o+sNyTaC3DBjlXBngY4JOUEwKPYutikfsCiY0gtb/a
         yqpred3M/ftkHGJhiC1GY+ONVEi+IsNg0sMnVc5EhANeIzbHcYbZq1I/+potw/yl3D51
         ZJPA==
X-Gm-Message-State: AOJu0Yzo1mQGT0Lt+7hkUfpnCFui7sSsWJsxt9rP5iwkg+lnsqFnRT1R
	4t6pGBT/WhKce0BMwcxLKuA=
X-Google-Smtp-Source: AGHT+IG+FH7zCjgi/Z+ZeS0zl2Tjj1ArsPfPtOvQ3abP1FhMvb3AU15cAC4KywPUvX3blxub3iMr2A==
X-Received: by 2002:a05:6358:b107:b0:175:55e2:c8f6 with SMTP id a7-20020a056358b10700b0017555e2c8f6mr10907066rwo.31.1705512587678;
        Wed, 17 Jan 2024 09:29:47 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:5421:8f53:45a:4e37? ([2620:0:1000:8411:5421:8f53:45a:4e37])
        by smtp.gmail.com with ESMTPSA id ca33-20020a056a0206a100b005c60ad6c4absm10788772pgb.4.2024.01.17.09.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 09:29:46 -0800 (PST)
Message-ID: <5ff36535-7cd3-4e8f-a477-9d2a98d18dd9@acm.org>
Date: Wed, 17 Jan 2024 09:29:44 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] block: introduce activity based ioprio
Content-Language: en-US
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zhaoyang Huang <huangzhaoyang@gmail.com>,
 steve.kang@unisoc.com
References: <20240117092348.2873928-1-zhaoyang.huang@unisoc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240117092348.2873928-1-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/17/24 01:23, zhaoyang.huang wrote:
> +static enum dd_prio dd_req_ioprio(struct request *rq)
> +{
> +	enum dd_prio prio;
> +	const u8 ioprio_class = dd_rq_ioclass(rq);
> +#ifdef CONFIG_ACTIVITY_BASED_IOPRIO
> +	struct bio *bio;
> +	struct bio_vec bv;
> +	struct bvec_iter iter;
> +	struct page *page;
> +	int gen = 0;
> +	int cnt = 0;
> +
> +	if (req_op(rq) == REQ_OP_READ) {
> +		__rq_for_each_bio(bio, rq) {
> +			bio_for_each_bvec(bv, bio, iter) {
> +				page = bv.bv_page;
> +				gen += PageWorkingset(page) ? 1 : 0;
> +				cnt++;
> +			}
> +		}
> +		prio = (gen >= cnt / 2) ? ioprio_class_to_prio[IOPRIO_CLASS_RT] :
> +			ioprio_class_to_prio[ioprio_class];
> +	} else
> +		prio = ioprio_class_to_prio[ioprio_class];
> +#else
> +	prio = ioprio_class_to_prio[ioprio_class];
> +#endif
> +	return prio;
> +}

I don't like it that code is introduced in the mq-deadline scheduler
that accesses page cache information. Isn't that a layering violation?
Additionally, this approach only works for buffered I/O and not for
direct I/O. Shouldn't the I/O submitter set the I/O priority instead of
deciding the I/O priority in the mq-deadline scheduler?

Bart.

