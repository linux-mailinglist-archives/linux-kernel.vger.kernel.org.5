Return-Path: <linux-kernel+bounces-93069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B1D872A6B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C9C1F26C00
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4058812D1FA;
	Tue,  5 Mar 2024 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBKK9uzm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7812A165;
	Tue,  5 Mar 2024 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678875; cv=none; b=cicsttLzYeMqNrAKyZQUD+EH471TpY94AZ/Ft0gLifsBI1oBFnjjfIfQ83HNoCLqglKR7H54jG4nFbdCFRFHvjLcV8V3L+m7IJrCNqtRhwf+D1WOVxJmiRJCGjHMxYt83ToGN+Kkrs0EjuKSFNUdHjcUH4mi83kIWCc2qdUl6Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678875; c=relaxed/simple;
	bh=+kYkTcVA7hi1Wv8xajbL/byDW64WRWkihTfoEYjupQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiVg3/LeVlKpXFHd/A55L7RyaMjVravjYAm67HA21BovviqLVZtogPAhy7szt40JWycVri3z13lSexCq7cBoJb/es3oGbQJf+hC3ELcWFNIe1mYQwFsIWikQtQGM4pAaMZLVIA0MfyOTNuee4Z4ZqWBvEBzWm1qt6Gxp35hEJZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBKK9uzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54279C433F1;
	Tue,  5 Mar 2024 22:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709678875;
	bh=+kYkTcVA7hi1Wv8xajbL/byDW64WRWkihTfoEYjupQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBKK9uzmWcaY3ldeUPW7dhNdgB7nWu69j8Rf9U9WJgT2vt6Yh0LgSFu3Xhh18Y2mC
	 KgVjoJTnXdN1StsLoq/44LG0SNWsMoFSIX3QjE0iXkJnUZGYrbyHJO9QKlf9jNcCgH
	 4rDR9fQgPJmR5pEsoWmCVqyYUr3mGClUhiYbxhlxoYP4pkAj2x3uefO2kN57bEdD+Y
	 jQ0GQVje/+gUKbJ1KVDPf8L09laKKwHR0dC8B8xFTU5Y3fUn7w9cGJsFY6KZneS4tZ
	 G+sxHWFr+PTNJBYtF12v1EdDMNQdcRyVfztNqPmWJt3s9D9ejBUxCcbyN4mfbPLYB9
	 CoudBCE8Wx9Dw==
Date: Tue, 5 Mar 2024 23:47:51 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Young <sean@mess.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [SPAM] [PATCH v1 3/5] media: ir-spi: Utilise temporary variable
 for struct device
Message-ID: <msqi2e4otrsunq734rd53rrzwsnxynasglbwrwwwzdlafdlm5c@fookph6kuu3k>
References: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
 <20240305174933.1370708-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305174933.1370708-4-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Tue, Mar 05, 2024 at 07:48:28PM +0200, Andy Shevchenko wrote:
> We have a temporary variable to keep pointer to struct device.
> Utilise it inside the ->probe() implementation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi

