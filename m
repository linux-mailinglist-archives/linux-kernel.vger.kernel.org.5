Return-Path: <linux-kernel+bounces-1798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECB9815407
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A7A2871A7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7071118EC2;
	Fri, 15 Dec 2023 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="hj2r5sV/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F9C18EAE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c6e2a47f6so7041345e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702681040; x=1703285840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ei+AUsiByd+qVmoHH8n3a6qywaMrPaDJDhrNpWkh19o=;
        b=hj2r5sV/tHZGQM2XebygCLQ7bcyyrbDMQDL/JpjpEDfJG6lTaHkl+MI0OPnYCFlSv7
         /zoTMZ+HdZG6ABVRiHpxAZzOBYaaABuRBnVoHh3N9lHqeDI/PxARUza+umd6x9SKeL/Z
         QJSJ1tqHXH6clCG/cz8l7aXJHJDyDVaPYt1vhnNCvNX9RsjIp6A4hL6sm5aGGm3X3Xl0
         B9EHQIKnnKPomQnJJguqKeKBoIOqvGJP4WySuLEFZJlBzOnAYsN5Od8X5qyWrhqHFEXG
         xq/6qxJbDCkDLfTMtPHu3K+45UvrjHqeCdsx/H3lUupy4JMHSmnJOE3+x3sIgHUd9WDQ
         1gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702681040; x=1703285840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ei+AUsiByd+qVmoHH8n3a6qywaMrPaDJDhrNpWkh19o=;
        b=dYBqLP1EO5Ei23JQDzOnpIn8AODrXzUZhHBaW79SvJvYwQrowK6E/4Fz8dxQQjxo7Y
         6QE9U2XreV+A3fgt4fSABTiblIahE6zcBwOQI+YH+r3vNsxtHwaqVWtS7hKsJbrmwOiL
         EeUMcltslopWdsUHbPUsEXQfiFgmedKklSQkAkLPYk/BAKfyvObFXLK82wjcTR8HGa7n
         MSai1LQksR4Q3x9Zen6W8QG1rMVpRoe1IYZIFV13gKUhcMtvFSZERlsx6TEwt11nXGzr
         QMKtAJ69sp/V/88+5F+FPSrjDee8nPWO7Qzn9J3L8+dREPz8SEIv9s+zkrDdGdZzZegT
         4bAQ==
X-Gm-Message-State: AOJu0YwQqR0/YPo4C6/8hQxbM0njRlgCg3WkOwMjM2TvttEQO3uMFOYI
	DcMeGqGUqRJi340vgff13ugcmg==
X-Google-Smtp-Source: AGHT+IELTISCWgGNq85OGjVAETRnYGZhdefp5CU7xP1J3IYfJ0SauSTDZQKf4HPfngBteuiRUWipNA==
X-Received: by 2002:a7b:ca54:0:b0:40c:2db0:c803 with SMTP id m20-20020a7bca54000000b0040c2db0c803mr3101760wml.92.1702681040070;
        Fri, 15 Dec 2023 14:57:20 -0800 (PST)
Received: from airbuntu (host86-135-101-43.range86-135.btcentralplus.com. [86.135.101.43])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c154900b0040c4be1af17sm19385495wmg.21.2023.12.15.14.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 14:57:19 -0800 (PST)
Date: Tue, 12 Dec 2023 15:59:16 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20231212155916.cqlgv5eypuvfom3n@airbuntu>
References: <20231212154056.626978-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231212154056.626978-1-qyousef@layalina.io>

On 12/12/23 15:40, Qais Yousef wrote:

> Food for thoughts: should misfit cause balance_interval to double? This patch
> will still be needed if the answer is yes to avoid unnecessary misfit-lb to
> trigger repeatedly anyway.

I should add, should balance_interval be capped to smaller values? Anything
above 64ms looks too high to me, even 64ms for systems that need responsiveness
can be considered too high. 16ms or 32ms look more reasonable to my (likely
very) naive eyes :-)

We should probably look at reducing TICK value as well. 1ms requires 3 failures
to reach 8ms for example. But 4ms TICK requires one failure to go to 8ms. Maybe
there's room to make the doubling logic more normalized. 3 failures on 4ms will
reach 32ms.


Cheers

--
Qais Yousef

