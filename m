Return-Path: <linux-kernel+bounces-156925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93D08B0A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8159B24414
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7C715B541;
	Wed, 24 Apr 2024 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z7L2v9NA"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5095015B133
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963984; cv=none; b=LoXDpRVfiEMNjLpGylNccfvs9kj8e9V5ogceQofJxPZ5qPb82dr1X9BoarF4fL8K9CM0/hE6AbBxhLkRnFmqn8lf3z/d8BriebX+y8t6Hc+A7Ks86F7CLSZT7QBwjXUy6iOZ6x5CpbafQ7n83JohmyOE9K+HG95amJBRxSYmx1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963984; c=relaxed/simple;
	bh=1X/4OOsHJ1KCbUAws4NmpoimMT/p0DvtpIV8MG8B394=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrRTDttvqmK6MWzJnEeroyolB3vmcJVlXY3D0vVPTX3rKXButY8pVeda5M02xgBNJzRB6qktvwoO8gYj1oJxVOD4D7ctjOYvWQpF7t2WSCwVz17btbdM/h0KFQI7ecoggdfp5SeGF/nikDKhrFrc1rXWtdPFVrj6fTAFMHcj9ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z7L2v9NA; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51b2f105829so4803364e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713963981; x=1714568781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oXPDyQAT+HitFMuQv0udxwIiXElf7T1dd2oYrE6rTrM=;
        b=z7L2v9NAChHGyNtJtkbm9xJ73l2sZ7/OorIH3YPPwjZozGA9BaZmiVLaHU8tUDd4QP
         djgc6nXigSemjUK80wUoPavrbC6brJHERNVnxu90jPELVO4nFRCgou4Ueg4lWDAdBn0P
         tf5ghtBpELQCh+v0zzmqa1AdDE7iKu7agSBcFQumegh8BqEPhq05/QfVwpibUQDxxAW0
         93JXbc2FB13jvhO63FUOXl7EoURDxFnU1is/U4ArthkQXwld/1TLeZEk/YRl8d6qb3Mx
         +TSN1Y5dUFH+Kq505SI49n80Sf8p5j/+ZgwSdWqK9K+TyyXnl3RQe+1JWqNwzReSeoaI
         y9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713963981; x=1714568781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXPDyQAT+HitFMuQv0udxwIiXElf7T1dd2oYrE6rTrM=;
        b=bupWARuHbLUV4v1QYADlTaNn6Y515wiZGDgarGIM8YZyQ1fgXQ+mXFWwPBWBo/HrvY
         htRfgcLWnrggTsHZlWJwgC95ZgBvFI6VJ+NELfWQUG+54WmtK4qYTxBBaHgjIqoldMJ8
         W1uHVmX6JaZ6LXRKtjXlFhBZVmuJLU5DQCeujCG50VGFTmlgjNngJJFNSvtZinlkz5JJ
         MYdhklmGDNaDUnOaoRZkzLxV1egm32pb5wgmVV+Dt5cOjRWN2zRVvXrFpUgaIRqdI11C
         sIN2pKfOGNT0K7lZP109XQF2p5gOa0J5M6Kz6+ulHWulKZgt73ervry3RpacM7QkUmtj
         XzeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO+Ph3UNVghv5CdT5f3PmQLGmm7N0vfhWKxEWQ5zK1ErrHyKvi5fR7l9bllM4uBFa7TkjoQjpr1E59xB9ZB7iuQDgeWgMlF+A18Y1m
X-Gm-Message-State: AOJu0YxUVXH5JcWngA7OTMadlxeQ5c7AHHLq2FQCE3e2L/fH6a5iRSTe
	l2o4i3t2vWOfYm6MgY7x3zTkyZLLwwAEok5eCT2AaKQVvQkuD2hqNzXH5UUNf8TpZ/2xTAe7/LR
	nn2GeuctsVxRHMQjcLpPV2yDK31I+Ridl2x2o6A==
X-Google-Smtp-Source: AGHT+IFefKvAYRBqhr8QCesj7hq8WHWt10BLztHIAMclGVcycqHpNCSNgO9jv0EcYEOBsbpQ6CS9FIGy90LZsASyIU0=
X-Received: by 2002:a19:915b:0:b0:51a:f31f:fc6e with SMTP id
 y27-20020a19915b000000b0051af31ffc6emr2425780lfj.14.1713963981412; Wed, 24
 Apr 2024 06:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412084056.1733704-1-steven.price@arm.com>
 <20240412084213.1733764-1-steven.price@arm.com> <20240412084213.1733764-15-steven.price@arm.com>
In-Reply-To: <20240412084213.1733764-15-steven.price@arm.com>
From: Thomas Fossati <thomas.fossati@linaro.org>
Date: Wed, 24 Apr 2024 15:06:04 +0200
Message-ID: <CA+1=6ydMVk4Vcouc2ag8G7tfqZy80VWFxWHSHEKF1JaABd=A7A@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] virt: arm-cca-guest: TSM_REPORT support for realms
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Sami Mujawar <sami.mujawar@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, 
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven, Sami,

On Fri, 12 Apr 2024 at 10:47, Steven Price <steven.price@arm.com> wrote:
> +/**
> + * arm_cca_report_new - Generate a new attestation token.
> + *
> + * @report: pointer to the TSM report context information.
> + * @data:  pointer to the context specific data for this module.
> + *
> + * Initialise the attestation token generation using the challenge data
> + * passed in the TSM decriptor.

Here, it'd be good to document two interesting facts about challenge data:
1. It must be at least 32 bytes, and
2. If its size is less than 64 bytes, it will be zero-padded.

cheers!

