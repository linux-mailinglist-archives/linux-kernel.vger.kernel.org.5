Return-Path: <linux-kernel+bounces-80569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C100B8669BA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A701C20B99
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4BC1B966;
	Mon, 26 Feb 2024 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Re2K+9Ep"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131D51B7E5;
	Mon, 26 Feb 2024 05:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708926504; cv=none; b=Qq3Qt3NEa9HYGTZrzkmxZ/ah9yBIl8xsUmTGmhITuXyGBBsczNWTr+eiqnhbzZnyPiQhmlAdlpM16CmkUBBf3VK/xuHSCCF+pEZ27th+xywyRHu7hqkp5S6AVs5dDkSYPIII6onEnKJQeMMFlosv3DLuNGZpqEiWGOVDapv/WpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708926504; c=relaxed/simple;
	bh=u7CLzGGgeUR5UtKNQZH1WZ/ThLdbAF6AVV2qj9OlCAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jsa3Kb5voP3nMgILulAvmr02zYehSSnV0ksS1zImabKfVDGl6iXJq+Efnnx3tzmmT/owGgJ6RpJm+VCuONC+seV+mR34KI9jPoj77elEgm/Ezzsegm+Z5wveXytAt1dksc8NIRcXRwAsHnLwY5VW6ud6xiAoVP5R3jGyb2KH1AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Re2K+9Ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88076C433C7;
	Mon, 26 Feb 2024 05:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708926503;
	bh=u7CLzGGgeUR5UtKNQZH1WZ/ThLdbAF6AVV2qj9OlCAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Re2K+9EpWgBJYLju3xPpZNKzqf/DDqnINN06XzRitwLoXkyj7FE4onm70DLwHv1cl
	 57ztG9665u7pyl8hlVYlPy27dyUexRxx8dIRsGniv1wv3ihWeyq0jEWY9Lgb0qFbWL
	 fZtZUkGUEfavnIntohPt1a2KMqT/VrX4m1vH1hwHqfVDHBLisurebLsFZ/6ga04idt
	 9MxQ9VORcoj+po1kiIwKczZYf9xwaq7YETjs5mvfsusAA9reNeZFAk4BBN+bXr+DC6
	 fPZp4LMBh846PWETAef8eAQHlL5/f/yLsrEb9vuhkC3DE7IZPSdriI9jIdu5vYbwi6
	 fUadevw3ThF3w==
Date: Mon, 26 Feb 2024 13:48:20 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH 7/7] extcon: usbc-cros-ec: Convert to platform remove
 callback returning void
Message-ID: <ZdwmJNGLJgAa5Z45@google.com>
References: <cover.1708876186.git.u.kleine-koenig@pengutronix.de>
 <52d0a4317d5372f1135259d4fbbd2822b86ba8f4.1708876186.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52d0a4317d5372f1135259d4fbbd2822b86ba8f4.1708876186.git.u.kleine-koenig@pengutronix.de>

On Sun, Feb 25, 2024 at 04:54:56PM +0100, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

