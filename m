Return-Path: <linux-kernel+bounces-37438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEE383B028
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1190B2BD20
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA3886AEC;
	Wed, 24 Jan 2024 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aO5A95zm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09CF129A60;
	Wed, 24 Jan 2024 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117509; cv=none; b=qX9cceQpafldpiJfJFp4uPnormcNBU8NLOFK0+oOomZ3MQB2VywIIr7cSVbvpw5y+kGhOFJk9beX9ZlD1N2FObFqvYceAPmuCLelRo43wflK6dWFwsJBESUfPlooo7v0Mnh92Zp39JGvCLfHyqHTgte9b8lwZD/VybYGuItijM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117509; c=relaxed/simple;
	bh=lspDAIXZuY1DjZ1sRgzqDRNzeXiD5+2IL3TOwpkncnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Um77TYTadRkt66eKTwzt1VtTjMMRohzF1Rs5C2Xyl8JlrLu3BbNycOodrGe4bHvWoSnYq2Dk00Kn+pqKedyNouk80EjkcmABOSYPZlu2IU5qeBAKK1xTBOrZ9DUqGvNU0R/RNtP98byYC8QXLl1whJDABc8ou/BkoTdKAMKea9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aO5A95zm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597CEC43390;
	Wed, 24 Jan 2024 17:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706117508;
	bh=lspDAIXZuY1DjZ1sRgzqDRNzeXiD5+2IL3TOwpkncnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aO5A95zm76NFWYdcSjOXnfMIwlK3rjpvBfhZT6QFAy7gq1v/oIUBJMFmg1Ily85PW
	 3Nlo00EPdVOnOzSkv382qNb4e0lAQWFoBzL9EC/0Zq1POKIL3BCgJoW+CpOhlpYHlW
	 njY+u3Vv7Ld2As/l8OH89Lhi0Vd6/5nPyYZzHR7Q=
Date: Wed, 24 Jan 2024 09:31:47 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 10/33] misc: gehc-achc: Follow renaming of SPI
 "master" to "controller"
Message-ID: <2024012441-tweak-catching-f565@gregkh>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
 <9a5c94968010aaf0c1d013f357fcbef428bb11ce.1705944943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a5c94968010aaf0c1d013f357fcbef428bb11ce.1705944943.git.u.kleine-koenig@pengutronix.de>

On Mon, Jan 22, 2024 at 07:07:05PM +0100, Uwe Kleine-König wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
> 
> To be able to remove these compatibility macros push the renaming into
> this driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

