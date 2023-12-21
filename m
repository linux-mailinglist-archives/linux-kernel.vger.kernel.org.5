Return-Path: <linux-kernel+bounces-8584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC59581B9C5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0821C2145E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2437F36085;
	Thu, 21 Dec 2023 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oropyjTP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A4A6D6EE;
	Thu, 21 Dec 2023 14:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CA1C433C7;
	Thu, 21 Dec 2023 14:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703169842;
	bh=wbDZJ6O5IZQROliTzl4IOXJ9tEt9UoMOKZMf4TpnVAk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oropyjTPdVPF5cgG/rXhRAGIr6tUxiDZHUHPKf3gr9N1y+1M4cLFPlL5nHBy1kpxu
	 Z4DUAYj5WthcRO48rPT5XxPtlGejnY9daS24K7qbhQd0wtuF/Z9cLftSxF72p1c/mC
	 MMu8dEhJnVYKsXGYp5Dtoquma0GK9TeeTbiN9sBxKqOjElI9jd+EwYqi6lQ/tN5MqZ
	 1MemhhsvJcw4ljC2V+WZ1th8ePgtXqe5NX+HeuIhbIHSXQPw49qcaSVTfNeaCAvLGY
	 SrRd/StHhncxxcHLfcywPrczvZpz94ezPsBcGXQb3hIkBQIwJJAcfTikW9Tu2vqnhy
	 sZE4m+QRGiZJQ==
From: Lee Jones <lee@kernel.org>
To: Patrick Rudolph <patrick.rudolph@9elements.com>, 
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
In-Reply-To: <20231214184050.1272848-1-andriy.shevchenko@linux.intel.com>
References: <20231214184050.1272848-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/4] leds: max5970: Allow to use on non-OF platforms
Message-Id: <170316984054.602239.8396148878635955139.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 14:44:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Thu, 14 Dec 2023 20:40:07 +0200, Andy Shevchenko wrote:
> Allow to use driver on non-OF platforms and other cleanups.
> 
> Andy Shevchenko (4):
>   leds: max5970: Remove unused variable
>   leds: max5970: Make use of device properties
>   leds: max5970: Make use of dev_err_probe()
>   leds: max5970: Add missing headers
> 
> [...]

Applied, thanks!

[1/4] leds: max5970: Remove unused variable
      commit: d3578b4982e6ebccbd898806ac86b2db4b2bcc5e
[2/4] leds: max5970: Make use of device properties
      commit: 6d63d05e26f8d5e22308efc25793660101fd7602
[3/4] leds: max5970: Make use of dev_err_probe()
      commit: e7baa5b437a782308b86c1517ae252fd1353eb0b
[4/4] leds: max5970: Add missing headers
      commit: 808c7881876756dfcd8c4d0c3efc27c9262da822

--
Lee Jones [李琼斯]


