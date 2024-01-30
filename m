Return-Path: <linux-kernel+bounces-44025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70BB841C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46A41C24ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C52B4D583;
	Tue, 30 Jan 2024 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEVhxuW6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FC03F9FF;
	Tue, 30 Jan 2024 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706598691; cv=none; b=GK2tJ/oAWdDgjgOx7mbsuVbzqIwZEC+ZTgtP80jCOrMPHM7DIoJKuwlshBNqDh/ThCfT3tiVrFojaBi5ZRIxp/7/QIdlg8njOk+mfiQHzB5yUuGzNMN9B3bCncQ0TSFyETfiPcfNFrbEF6XIleumebIsONtVq2RHH+jaMw/W9HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706598691; c=relaxed/simple;
	bh=/mbPmutB696Z/bJKrfIZZp7vsMdnA8Gy7aSJ+2QeAxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjmdednHRzw1dttE6nTo+Uz+PaKno9F31HjbXoSjko4aSL0IwkDgvZ3lcfkL2Xb+rB/f5+ym2YRwERXspPOA8q+4tepU/nb5P+jOZwZ1JVOLq1JQBYMcAJQ8KH73xPGSv8XF+oMSQ4izDCq3G1zwXHdT5ckqqVyEFO4NtzsNXZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEVhxuW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD15C433C7;
	Tue, 30 Jan 2024 07:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706598691;
	bh=/mbPmutB696Z/bJKrfIZZp7vsMdnA8Gy7aSJ+2QeAxU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FEVhxuW61BOZ3Pn6GEx6hk5yoch/F8YmE79nTxoUYkorlnF3OJfQ4cqak/DB2cHDd
	 NVLdcVeyOzT/ERLxcjKtezGX8BkD14xvZ7Tsj0sEgBZeq2tjCQ8VrIfvwhhOIW78Sa
	 ijrMHEhkUpzlivy1ZFKWBuO4UGN4ivKDewxRza3hoMaKwWdqYBtjQ4QL/EOSiyGMeH
	 uPJIWzrddSizA6wX16ae9hogD4S8mAJPze09YMN2sh83Isi8XCJ8l/1WwgPq7zqvCp
	 nBqrlwfXM/lGdqRKlt7iv6fRo/pHplWJUZvF+ocsMbABGszUQ22CjzSqYLPvmcKXpv
	 EFgC9opf4M9jQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5100cb238bcso6451762e87.3;
        Mon, 29 Jan 2024 23:11:31 -0800 (PST)
X-Gm-Message-State: AOJu0YzV45K0QRJkvhvocTfh+SpXRnn3l6OtVlMY882gs8qIuo4vipFs
	S/xwdcdqShw4p4DMKAveISDm2d3+TW29q1RvJNVz2tc7YOasRkCLLxF9wuFhAJdxZvEVLLsaP5u
	waCT3VkuFlYtqIPhk4yx2JTXK3k8=
X-Google-Smtp-Source: AGHT+IFYljsBr5X9Oy6xoH/nk93DqjXnl/ITwiRz9xl2fE7+ctb5xEFUtTyDzkDbi5vPzPTghutoDa4JqBGpm7RghPY=
X-Received: by 2002:a05:6512:3e10:b0:510:9c45:149a with SMTP id
 i16-20020a0565123e1000b005109c45149amr4649550lfv.31.1706598689443; Mon, 29
 Jan 2024 23:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104133629.1277517-1-lilingfeng@huaweicloud.com>
In-Reply-To: <20240104133629.1277517-1-lilingfeng@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 29 Jan 2024 23:11:18 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7y32Mw+PmvnLg-o=ZS22ZOuzLd19zDHix3qA93_X8SGA@mail.gmail.com>
Message-ID: <CAPhsuW7y32Mw+PmvnLg-o=ZS22ZOuzLd19zDHix3qA93_X8SGA@mail.gmail.com>
Subject: Re: [PATCH] md: use RCU lock to protect traversal in md_spares_need_change()
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai3@huawei.com, yukuai1@huaweicloud.com, linan122@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 5:39=E2=80=AFAM Li Lingfeng <lilingfeng@huaweicloud.=
com> wrote:
>
> From: Li Lingfeng <lilingfeng3@huawei.com>
>
> Since md_start_sync() will be called without the protect of mddev_lock,
> and it can run concurrently with array reconfiguration, traversal of rdev
> in it should be protected by RCU lock.
> Commit bc08041b32ab ("md: suspend array in md_start_sync() if array need
> reconfiguration") added md_spares_need_change() to md_start_sync(),
> casusing use of rdev without any protection.
> Fix this by adding RCU lock in md_spares_need_change().
>
> Fixes: bc08041b32ab ("md: suspend array in md_start_sync() if array need =
reconfiguration")
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>

Looks good to me. Applied to md-tmp-6.9.

Thanks,
Song

