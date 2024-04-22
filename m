Return-Path: <linux-kernel+bounces-153328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 131EF8ACCAA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929D01F22D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD241474D2;
	Mon, 22 Apr 2024 12:17:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42528502A4;
	Mon, 22 Apr 2024 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713788223; cv=none; b=D0h+n0sIpGAsFRhRtEc4PrmlwMo3hvsrCDXO8qTNfGzE0ptH/2dZ9hbW3itvdQX/OLvbKjm6A9CfoJJW22THqgwUCHS/yli2PaCleratwj4ltobIfEzbt5qHm0YAXIwzIeWbpilcyQuo7Hj4g4R/4S03Qy3+sm09WNmGJif27JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713788223; c=relaxed/simple;
	bh=vMseEv/bLusVAy8oaK+blU0KsyBdn0WNVCJrAowA5JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zkq76BSMO4CymmLr0vPTFDJAn4sERf0obAeqtpHRDz3hdcAzXBTyyUe4NFIM48/CpacWFUo60zG8wZeiHe28jCvKTatbHeb4+q8zfBctwm3R3ZbT3iGpCDjW/fzCPYgIKuL4EWjhNy/nl9pJlNmMk8Z0KujcIs8cod+82xuqLG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9549C113CC;
	Mon, 22 Apr 2024 12:17:00 +0000 (UTC)
Message-ID: <99b9aa7f-f2eb-450a-a589-0e63adf97fcf@xs4all.nl>
Date: Mon, 22 Apr 2024 14:16:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: vivid: Enforce a monotonic sequence number
Content-Language: en-US, nl
To: Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240417-vivid-seq-v1-1-0e56ea08b682@chromium.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20240417-vivid-seq-v1-1-0e56ea08b682@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2024 11:30, Ricardo Ribalda wrote:
> Make sure that the sequence number is at least one unit bigger than the
> previous one.
> 
> This solves situations where the sequence number calculation does not
> have enough accuracy and repeats a sequence number.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> We have seen some examples where the sequence number has been
> duplicated. This should not happen.
> ---
>  drivers/media/test-drivers/vivid/vivid-kthread-cap.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/test-drivers/vivid/vivid-kthread-cap.c b/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
> index 42048727d7ff..6375e6484a4b 100644
> --- a/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
> +++ b/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
> @@ -665,7 +665,7 @@ static int vivid_thread_vid_cap(void *data)
>  {
>  	struct vivid_dev *dev = data;
>  	u64 numerators_since_start;
> -	u64 buffers_since_start;
> +	u64 buffers_since_start = ~0;
>  	u64 next_jiffies_since_start;
>  	unsigned long jiffies_since_start;
>  	unsigned long cur_jiffies;
> @@ -691,6 +691,7 @@ static int vivid_thread_vid_cap(void *data)
>  	vivid_cap_update_frame_period(dev);
>  
>  	for (;;) {
> +		u64 tmp;
>  		try_to_freeze();
>  		if (kthread_should_stop())
>  			break;
> @@ -719,9 +720,10 @@ static int vivid_thread_vid_cap(void *data)
>  		/* Calculate the number of jiffies since we started streaming */
>  		jiffies_since_start = cur_jiffies - dev->jiffies_vid_cap;
>  		/* Get the number of buffers streamed since the start */
> -		buffers_since_start = (u64)jiffies_since_start * denominator +
> -				      (HZ * numerator) / 2;
> -		do_div(buffers_since_start, HZ * numerator);
> +		tmp = (u64)jiffies_since_start * denominator +
> +		      (HZ * numerator) / 2;
> +		do_div(tmp, HZ * numerator);
> +		buffers_since_start = max(tmp, buffers_since_start + 1);
>  
>  		/*
>  		 * After more than 0xf0000000 (rounded down to a multiple of
> @@ -746,7 +748,7 @@ static int vivid_thread_vid_cap(void *data)
>  		 * Calculate the number of 'numerators' streamed since we started,
>  		 * including the current buffer.
>  		 */
> -		numerators_since_start = ++buffers_since_start * numerator;
> +		numerators_since_start = (buffers_since_start + 1) * numerator;
>  
>  		/* And the number of jiffies since we started */
>  		jiffies_since_start = jiffies - dev->jiffies_vid_cap;
> 

Just FYI: this patch isn't right: it's fixing the symptom, not the cause.
I am working on a better patch for this. It's the same for the v4l2-compliance
patch.

So I'll reject these two patches in patchwork.

Regards,

	Hans

> ---
> base-commit: 836e2548524d2dfcb5acaf3be78f203b6b4bde6f
> change-id: 20240417-vivid-seq-d0eb044a085f
> 
> Best regards,


