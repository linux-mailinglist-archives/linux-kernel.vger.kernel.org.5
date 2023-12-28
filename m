Return-Path: <linux-kernel+bounces-12807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F02881FA40
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EFD1C21265
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8FFF9CA;
	Thu, 28 Dec 2023 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="SE9s4t14"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8C4F9C7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d5aef534eso21723785e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 09:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1703783682; x=1704388482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d5bhZr4OZWNhAWGe5k8YtvZn7JH/mPSTxU7SneuBK2M=;
        b=SE9s4t14+uJnP8aRfGIjtqA/6q5KNgWDdQWHwyDOjBIj2F4qIbY5aMRg8l9h0pJQQP
         7ET0/ZrE9gRbKe0bID3ttWKoYAquyYImJg5yVedh8AbBPpsbycK+2y509N0+ckxMqSjW
         ySsfiGykN2m99KXBsB1z5Iho5UwSrMDBfa7XwTdvpIFN1uZSZEfh251ds/7ZbVd4ZOZ/
         9muEUHx5axYvqYBrMXLiSvae1urijB8DOyd8poLIJnVKdZeDMpJLFWWRIfPUTB9yTjtJ
         7AVMsqHum20LCQcn7qox56uma8gDlV14PP50Wv00EmxwITb6dpxVCCjc5dcrCl9rIs5f
         4+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703783682; x=1704388482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5bhZr4OZWNhAWGe5k8YtvZn7JH/mPSTxU7SneuBK2M=;
        b=C/RAWqESUInzRGH2h1SVhNtePvaE/AKnn/8SshkBEGQZRncn8QTSpMAq5gCXtCj4vO
         2qEVHgaL20OueX05DR4bERiymtkWYUr30fU0NVk51UNckFx+urR3WgbLdl/7eepV7wTF
         FTmckwl8DgVoDs2k/Gs9v6Rm2zi0h7sTRgEVxqTXnZV15xDUYuVhzJqrQikrjmCAK7r3
         Fbq6vIZUBbzwnUFK/ybpoCFFHFDysLIVnOkiD3BCBa5zf52shaYH7QqbVZuSjWsrY87O
         lVDK0qhjbN/1qpb6cP/Woc7e4lIzQMk1WjtrZGzpYOOyPq5CRMNQbdpZO8fZ58yWTrsv
         czGQ==
X-Gm-Message-State: AOJu0Ywrxf+hGlbkVtQulk2FDXPNUEpJkC5fT5MXt3d9AVjJyLQcTKr5
	nmXNjNNnIXhmpAEAPMYeb34yKgik9Bl2sw==
X-Google-Smtp-Source: AGHT+IHTkh/6edX4qHjr6QTUR6Vo2mxhnQqGjR8riEsvT7YhXvjEzVuTLLE+BAEdL5iB+sx3JUDMBw==
X-Received: by 2002:a05:600c:1503:b0:40d:355e:ab92 with SMTP id b3-20020a05600c150300b0040d355eab92mr5759877wmg.22.1703783682448;
        Thu, 28 Dec 2023 09:14:42 -0800 (PST)
Received: from airbuntu (host109-154-238-212.range109-154.btcentralplus.com. [109.154.238.212])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b0040d61b1cecasm4180432wmq.33.2023.12.28.09.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 09:14:42 -0800 (PST)
Date: Thu, 28 Dec 2023 17:14:41 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 05/23] PM: EM: Refactor a new function
 em_compute_costs()
Message-ID: <20231228171441.jgyjtp3knbtcqgf7@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-6-lukasz.luba@arm.com>
 <20231217175845.2jdeqaz62mmcjuwu@airbuntu>
 <5f7f52a4-4f0a-4694-a743-478c5e4e4079@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f7f52a4-4f0a-4694-a743-478c5e4e4079@arm.com>

On 12/19/23 10:59, Lukasz Luba wrote:
> 
> 
> On 12/17/23 17:58, Qais Yousef wrote:
> > On 11/29/23 11:08, Lukasz Luba wrote:
> > > Refactor a dedicated function which will be easier to maintain and re-use
> > > in future. The upcoming changes for the modifiable EM perf_state table
> > > will use it (instead of duplicating the code).
> > 
> > nit: What is being refactored? Looks like you took em_compute_cost() out of
> > em_create_perf_table().
> 
> Yes, it's going to be re-used later for also update code path, not only
> register code path.

Sorry I was terse. I meant the commit message could be clearer to require less
effort untangling what is actually being changed.

