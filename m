Return-Path: <linux-kernel+bounces-116846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9FE88A3C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BF32C31BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F2D1BAA5B;
	Mon, 25 Mar 2024 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRgqPuxZ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE6F13B58D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363003; cv=none; b=HUOOxJpSvfGLtNDFcuThXAGVI+JdcjlG7ePf5zmiYghLtcJ1wHa0RWd2Qw0TxAl9maNVTTwWK96r8s1UNyzaaK5ZoKIcXiAh/CNNu18oDzP+9w2lgbwbIRrxTCqmVtzASB4nfKCf7MLC8u9o86UHT6wwjMDu+0bcy1kHug0znL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363003; c=relaxed/simple;
	bh=YdAGvLHgaCqu4Jw0vs2raNroBxAXX1REtXxAcoS0g+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPgxxaHYBx0pIL+OZUXp19cjYb+EXmNm2GTACJa1zntsT6JTEH0s54H8Z5rJXcSC8m1OgTVsw4j3gVtM85Ws7y3/wMQ18vD8KUMnFHQ1msqcJ5kFVc/nmD16ZJoUBWjPqYRh0qfdL794En/3060+5lCzTzcQQwX67EE9vWfOFDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRgqPuxZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4a34516955so101964166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711363000; x=1711967800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoLFByqv9SuKcb48SqGjXzMZ/gFLFOWm84zGVd1qysA=;
        b=lRgqPuxZZAM08nUApBbz4DYLHqBcSAzSd7iCjg2hoixB09E7MyXwfv+W4w84gWKpZN
         oDZ+KAbKrRxQX69nmj9lxKZ3zNtRqSMqJqCUMuF4+/w28VCLu0dBafBnDXEQ6EzDjyZD
         XN7NgFEP7doiEWo9Hi+Imngq2RUevZNbi16K++arq2ajF5DqRq+Xtzpgk6xG4BED57p7
         aed3Nd1LPJnp02cxda/HBqf9HT6NzbeuGny1NBytQtFASuW5PM/aJH5b7V70AHw9r8vY
         yE8cjNPyxidGsSBIc072IOpmhuxQLIJxRjCzbuq4J0ot71Y0Fga0BBsq1DXPcXGKcuW+
         pr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711363000; x=1711967800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoLFByqv9SuKcb48SqGjXzMZ/gFLFOWm84zGVd1qysA=;
        b=vxm997gIP2YEYsX9fL9TYwnGPvaffzB3IxhzbYWRoYWCcqrpql8td12U3GENhMUVyL
         lkaK710mY7aMJtMe/DsXeoWQ85FeGh6nAfZF6gnjwPxYK5PqGYNHa3grrhZxyO44M65u
         g2GpMAFTufUYfNeEjZ0jTzemhpBFbWASTADSjzrb1yVWcP70otSN4Yac/DLa+SFXLLdx
         qqGBbuBISrgMnjK3Z3weRyZ4I0/PVKN4m4lZ/90KDxh3bD1nbrtj4IM5uszNiZ6S/qOM
         Q2bRMipD5iJUBwArKpXiIdjLXmH0lgcJiBiyFC/tK8Zs39706zvEqvr+sSulbN8tZ9LT
         65JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj83+kKpOy0nbpDoIrdWRbG8fYXZqNR+M45CeRYnS9/DL0KrkCZdVViBny8ggoWXUZSh7yBON2pc9N5QPWJoGfkvk7/dCFCIPHae0B
X-Gm-Message-State: AOJu0Yz2QpW4Q4Bt4oosAtCALEBzRFmxNk3rHfpJ4eja5IC7fWIwruxz
	IeZ0Oqlr5gyTxMFeJP/MQnOzgbNryfBbIHpd/cmDxGSzbrlFbXtP
X-Google-Smtp-Source: AGHT+IGZjtDw+CT5fwdF/rhf2TA5KqwCAZIY76ngtATg4psvxNZfS1W//CP5fRFQ2RjsvdULEbz2vw==
X-Received: by 2002:a17:906:fc0d:b0:a46:4d16:439b with SMTP id ov13-20020a170906fc0d00b00a464d16439bmr4344370ejb.43.1711362999349;
        Mon, 25 Mar 2024 03:36:39 -0700 (PDT)
Received: from gmail.com (1F2EF63C.nat.pool.telekom.hu. [31.46.246.60])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709060e8200b00a46cddf1efbsm2927821ejf.29.2024.03.25.03.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:36:38 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 25 Mar 2024 11:36:36 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: peterz@infradead.org, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, qyousef@layalina.io,
	linux-kernel@vger.kernel.org, vschneid@redhat.com
Subject: Re: [PATCH v3 0/2] sched: Minor changes for rd->overload access
Message-ID: <ZgFTtAOw39tIyfzR@gmail.com>
References: <20240325054505.201995-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325054505.201995-1-sshegde@linux.ibm.com>


* Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> v2 -> v3:
> - Wrapped check for value change inside ser_rd_overload_status
>   as suggested by Qais.
> - Added reviewed-by tags.
> 
> v1 -> v2:
> - dropped Fixes tag.
> - Added one of the perf probes in the changelog for reference.
> - Added reviewed-by tags.
> 
> tl;dr
> When running workloads in large systems, it was observed that access to
> rd->overload was taking time. It would be better to check the value
> before updating since value changes less often. Patch 1/2 does that.
> With patch updates happen only if necessary. CPU Bus traffic reduced a
> bit. No significant gains in workload performance.

Could you please post this against the latest scheduler tree, ie. tip:sched/core?

Thanks,

	Ingo

