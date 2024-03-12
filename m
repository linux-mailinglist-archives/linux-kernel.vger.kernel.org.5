Return-Path: <linux-kernel+bounces-100136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2410A87925C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1912283AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C78169D0C;
	Tue, 12 Mar 2024 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fi++c9Vq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE77959147;
	Tue, 12 Mar 2024 10:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240303; cv=none; b=NBteDvkcpIKIFjn1kWAgWdqGrWdzcMbJmArsJgeIEr8Fv7y/rTIsoC+gPDPlD7Z5cUKBtnIILF8TupkU9O0NGXkJharl+pxdhIIlhZYmxdHZ0KAlofqgIWIH4dwwmRvFCjyakdKVjlCC39g1BPQXGxcLnTNxT75hWdxpWrLikO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240303; c=relaxed/simple;
	bh=FsPCYcZaKzqSZ2us0EWfKrjuJpzBgnJIjOqeITPr6SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iB+kZ0zRCtXxSOLmMYxwTIFg6Fc4Y2S5WCiJ7zeM8t5pcYKnNselnUM9t7hapii+gRUAjMkpabNONNr4GlHVshmjim67+5wZFgCwe8RjNOWyAAvU3XCq9FsAhleNgfUGHwIW+A1WlpoWX8+/JhQl0YB2YQWC7BZKTKli3X/ZpB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fi++c9Vq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44C5C433F1;
	Tue, 12 Mar 2024 10:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710240302;
	bh=FsPCYcZaKzqSZ2us0EWfKrjuJpzBgnJIjOqeITPr6SE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fi++c9VqMMvO6hQeEG7Gx+JJWNa+ISYp5gul7DkdLKxAtK8iIPnY16n14L1zby2rF
	 nvIQ4p6ymU/3dbISEvFoYvjTM2FDGDSxJvp26KN+Y4vQo4q6Ra6J/C782KkclySJiV
	 6ZN2cZX8OgBfHZiLutS/S/MZfZL67wkqO5laVBn+/hh8Vc+86QdHaCITx1tU2ujXQK
	 iJ6KPb9Krj7R01vUYTeqkisFr6o8BAvGkHhZTtmQDwDvxJK/TFZW4UXaIlEDuF07I9
	 wydFTRdhHnY11z5dhMpoHqrdlS844JQFIvAXRdOnU5vsaJ18TQe1sCyoSiYkTy7Xhl
	 wTGZFXIQiFlKw==
Date: Tue, 12 Mar 2024 11:44:57 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, 
	Viken Dadhaniya <quic_vdadhani@quicinc.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the i2c-host tree
Message-ID: <yb2yieqtfot2vzjrr4xihartlz7gmlmrv5r3y7kk66pr3unonq@mzhhakwmiaja>
References: <20240312104127.3fb5e650@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312104127.3fb5e650@canb.auug.org.au>

Hi Stephen,

> After merging the i2c-host tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/i2c/busses/i2c-qcom-geni.c: In function 'i2c_gpi_cb_result':
> drivers/i2c/busses/i2c-qcom-geni.c:493:18: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
>   493 |         status = FIELD_GET(I2C_DMA_TX_IRQ_MASK, i2c_res->status);
>       |                  ^~~~~~~~~
> cc1: all warnings being treated as errors

sorry about that, will remove it.

Thanks,
Andi

