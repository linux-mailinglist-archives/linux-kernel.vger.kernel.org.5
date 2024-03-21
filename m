Return-Path: <linux-kernel+bounces-110520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C37088600D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5543E1C21834
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080F3131748;
	Thu, 21 Mar 2024 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqXmvWG+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492D2224D7;
	Thu, 21 Mar 2024 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711043344; cv=none; b=X1xXUgZHA8gUx8i7hZYZFBO+scQjzip3NP4MORbNR3//ZJ71uz1BpnaB7FnUA4bnLkvxQE1ZHw0rNMC+CDZ9Fqc4JcqXscWHNNsBUm9bgz20D0MsRB7uib623ARDqLocBln0aMgWk/jGvH7xknJIphwVNOqyrTF9sE8muOs2elE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711043344; c=relaxed/simple;
	bh=giBCJwrUkuQp6cs98rqZmR8x+6CYDC+Tv2EgE/bACow=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=duPETzm9iEdBhT/Ovz8wxGzPn4/pMAF7FHJUW5iuJPIdY9fUfO1AL9OURs9at6upt9EhIb7JZsqbKDBReggfQwlDUiQXgiBUIReuYw70GMQP/Pc/kteOAmD7i9+6/N9tdeP1zM0/IlU7Shbw/qU2b6UYQ7t0SB6ufiP2BgJkybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqXmvWG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BB7C433C7;
	Thu, 21 Mar 2024 17:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711043342;
	bh=giBCJwrUkuQp6cs98rqZmR8x+6CYDC+Tv2EgE/bACow=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fqXmvWG+zMk0i82vT6ojt2EQOALh+vHgy2tHP8phBKvo2XdKGB2N6MG3nk9nbR25X
	 Zlwwyhg51SQLnjcxeQlFtnXE9hyIhXrMLy8Bb4I5aXytBwH2JgQHXD27MiBGCI3kJH
	 kwQNASpds8l3AT/tA3H5iYu+tY978RrbzfHIYalgxZhCBshkXJYo/T94YuCWJHBWDe
	 W3JJ6Jk5dHh4mTQ9qDeDZZ0s0lxMFKns5uZfNKY764nKtfH6yzGvfNFVI+mLxjzjjo
	 hnBMwQY4E8/uApq5Diy7IHn7amF+FbM4+1H6qflikoG8lJxbwAp82MfsZ5P8A3ZlKZ
	 k4t4D3MOUz/AQ==
From: Lee Jones <lee@kernel.org>
To: andy.shevchenko@gmail.com, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xing Tong Wu <xingtong_wu@163.com>
Cc: Hans de Goede <hdegoede@redhat.com>, 
 Xing Tong Wu <xingtong.wu@siemens.com>, 
 Gerd Haeussler <gerd.haeussler.ext@siemens.com>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Henning Schild <henning@hennsch.de>
In-Reply-To: <20240314070506.2384-1-xingtong_wu@163.com>
References: <20240314070506.2384-1-xingtong_wu@163.com>
Subject: Re: (subset) [PATCH v4] leds: simatic-ipc-leds-gpio: add support
 for module BX-59A
Message-Id: <171104334055.133767.17062777596741822181.b4-ty@kernel.org>
Date: Thu, 21 Mar 2024 17:49:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Thu, 14 Mar 2024 15:05:06 +0800, Xing Tong Wu wrote:
> This is used for the Siemens Simatic IPC BX-59A, which has its LEDs
> connected to GPIOs provided by the Nuvoton NCT6126D.
> 
> 

Applied, thanks!

[1/1] leds: simatic-ipc-leds-gpio: add support for module BX-59A
      commit: ca66b10a11da3c445c9c0ca1184f549bbe9061f2

--
Lee Jones [李琼斯]


