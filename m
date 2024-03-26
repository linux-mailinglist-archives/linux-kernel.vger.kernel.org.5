Return-Path: <linux-kernel+bounces-118515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7B788BBF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E14B22F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A53C13667F;
	Tue, 26 Mar 2024 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QB0gFE+p"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B2132811
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440484; cv=none; b=HtHAma1xWpNlC2YVXcTOclYsg0jTiQ8Y5Fw7grN9Q9g216kECZoCVKJJiefP5PIZMPfpFbWmZ8B+18T+UKZZjU/MXcOyza82uyMb1on2mMjWuJBGq2oKaZyZIIT/vcN+UmCF1ztbBr4ILZc6pMlO8D+Iu44X+ZoTvlagk1zl2gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440484; c=relaxed/simple;
	bh=2xVA99bePe+j6Vg/ZBkrE49832DO5fQrfsEuBjVPvaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEE6lTTqUinPc/QHGnQG/cAI7JAjuupAOEfhsovhuXJ2j+qfL3ThOXDxbV9TGBFPuGHB/ExXy4npomvHrkhY80TGPwhZnfMmGVFNbIV5VO7kvV2MzHBQp/jCEjIS6pfAZbz/F1z87mudr1LrBzoGlqqvsG9nkdOIYoeDIYs+tjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QB0gFE+p; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ed4dd8659so3836078f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711440481; x=1712045281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FebEuKGKxEkVs9mnT4s55KdAqLCsppHV1mquMLNE7A=;
        b=QB0gFE+pDfOzAIdFSRFXbjRcm9PGw0HTzNPZ3a1ARI7aNDgXbgqALVgfDKw0e19MV4
         5wATBNBzL6GUsbVjLcdxU5ocPKpRRygP0vc0fDJcXxfedNmq7R23LkN9RtFpbR+Ci/JQ
         y6XEP/AIt3b1P57WI2jYyoAzQoyld0rXU6eqIeLLZMFZDiddM+1/I6PSGA0Nj1dMNfSj
         xK1oGYQv/Es6wb4r+lSwR7MUGkgwvFwLNLY0/ZaLPc4MwNJ5ZdBqD8pMEIwPGtdieMxA
         J20oZZmq9JnTJTFf7Y1uYlkFy2HgZYvev5XVlohuTWbk/qzMM4NTS+cAAqsubI1HBcLC
         +2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711440481; x=1712045281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FebEuKGKxEkVs9mnT4s55KdAqLCsppHV1mquMLNE7A=;
        b=ZHtGnOLRImthk0kvNcGdcKH6eeRaCHPAvAB9vnklQcesIsItrr9Bxu0ddQEUR/mcck
         +hvfJHEEs/mrky/2FFl83z/0qkpXfY/HxvFtLetAokCzTzxMlYTKcGxhsHj+oUgx+UQc
         57A9o3iRPdrnwUZMEKS31W8eVXTXATGR+ToZwCXD8cwVWmXLLoBHLMhF5wh8OOj5MR5W
         vRZ5VnzzCXiLDpMIenar7ws2cHTBqxRwrKkrjsdERNSsWW49eiZy5Mkeq2dEreRMhQ54
         zd9v5zveHjB98SJMEbDRxnRL0Bn2bwkw7CiMpQLlFnV5DcoTFbLUUZmXlgA/Y6WzpJfx
         yTiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6JN5mvCiywyMiT1NbNIlwxo5i/ErxomixVlgd4Tja8mnPE9jZxk4RgslMbeo1LpabjmbwMZvJ2p9jKX5wFeEo2wxmGtBarjFZvB28
X-Gm-Message-State: AOJu0YyOevaEWLgptQbF7FC2clr6NJ8g/TQ+eyyDoAvt7VJ8j/+Pwz/e
	hgB929VNblGlhTWmBV0nUNMjjUKMn4dDQvL6Dsk0zsfZNaidGMN3
X-Google-Smtp-Source: AGHT+IE9rvkX7BR4bCYQe8Jcrg8v7TPqaHYSJvrcC7pmRFCQwrDXUH93vVqRGcrzqZE4BRPZRnzRHw==
X-Received: by 2002:a5d:5917:0:b0:33e:c69f:6769 with SMTP id v23-20020a5d5917000000b0033ec69f6769mr567209wrd.26.1711440480701;
        Tue, 26 Mar 2024 01:08:00 -0700 (PDT)
Received: from gmail.com (1F2EF63C.nat.pool.telekom.hu. [31.46.246.60])
        by smtp.gmail.com with ESMTPSA id bf12-20020a0560001ccc00b0033e745b8bcfsm11495208wrb.88.2024.03.26.01.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 01:08:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 26 Mar 2024 09:07:58 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: peterz@infradead.org, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, qyousef@layalina.io,
	linux-kernel@vger.kernel.org, vschneid@redhat.com,
	joshdon@google.com, riel@surriel.com
Subject: Re: [PATCH] sched/fair: Simplify continue_balancing for newidle
Message-ID: <ZgKCXrUbBIxp6+mu@gmail.com>
References: <20240325153926.274284-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325153926.274284-1-sshegde@linux.ibm.com>


* Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> newidle(CPU_NEWLY_IDLE) balancing doesn't stop the load balancing if the
> continue_balancing flag is reset. Other two balancing (IDLE, BUSY) do
> that. newidle balance stops the load balancing if rq has a task or there
> is wakeup pending. The same checks are present in should_we_balance for
> newidle. Hence use the return value and simplify continue_balancing
> mechanism for newidle. Update the comment surrounding it as well.

Assuming there are no side-effects to balancing behavior.

> No change in functionality intended.

Is this actually true? Any change to behavior invalidates such a sentence.

>  	/*
> +	 * We must set idle_stamp _before_ calling sched_balance_rq()
> +	 * for CPU_NEWLY_IDLE, such that we measure the this duration
> +	 * as idle time.
>  	 */

'the this' ...?

Thanks,

	Ingo

