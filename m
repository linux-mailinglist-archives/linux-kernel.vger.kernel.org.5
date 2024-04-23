Return-Path: <linux-kernel+bounces-155343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC52C8AE925
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0F71C21C66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CB413B293;
	Tue, 23 Apr 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K17T5ZKL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0BD13AA49;
	Tue, 23 Apr 2024 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881342; cv=none; b=XVkzUEcBnIPFHL4yLVnHRvt2v6lWFAo9k6WI4CVu/pQ+9IHP2JQHx5FkZNrqrjsPDus7ZO//9ye8qhJmK2xOwgodJcowVfXMbINyJyDXl9NHhFfNm9BsHhm/sxFdRedQhYCoAKM8UkxZDqP6sfbPFx7YhiDEkiq1Fw8YUMKu3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881342; c=relaxed/simple;
	bh=ae0UaH0agR4uZehsctP27tn4c7cKM5B3o3ah3tgdjWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsO9ja4g8obuSB39kYPK6g+6tp5y4BdUAPBh8nNON13eF3VKrxW1DArhunIP6kH0ZgX3ypjlHiJ59RRDsdf2UniFlbOkPuDTBk5G7O6hdS/QFsiKPv541RCJaSrDf8ut2/PsFfQrPxjggys//DSqSVRm7VPuk/SpsGf1W5EBgUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K17T5ZKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379E2C2BD11;
	Tue, 23 Apr 2024 14:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713881342;
	bh=ae0UaH0agR4uZehsctP27tn4c7cKM5B3o3ah3tgdjWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K17T5ZKLS6k51ibrDQGd4CPx1PPNJ799DfePd72HrtLhlummtNxrkathL/3Gu+TBS
	 OPBKkIF5VJb4z+JisqWRChg960cv4cRDq8AruUugGkUCCnMjRINLlz8Xwz7NZUlDdU
	 63k4bRHX06yFHhYM6aLqJY7zN4uHlKQTRkLklOB1IQEGZpPmw99Y5kmHObrlNXUl6N
	 aq8abjEp1QngdLkyOfYJvU1e/CPgKwetJFhPd1pW2LwJqyj6lnPjpNGPI8TZMGQx+s
	 wJ/9wSxNeuYqBnc6kxG/yp5CMVnNmmg/5fTA11sk4UNrvafkIcvpHJtR13tmJ/ige1
	 mLkQYDc1E9w8w==
Date: Tue, 23 Apr 2024 09:09:00 -0500
From: Rob Herring <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] of: property: fw_devlink: Add support for
 "power-supplies" binding
Message-ID: <171388133742.134852.3802091421412746619.robh@kernel.org>
References: <20240417200738.1370896-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417200738.1370896-1-saravanak@google.com>


On Wed, 17 Apr 2024 13:07:37 -0700, Saravana Kannan wrote:
> Add support for parsing power-supplies binding so that fw_devlink can
> enforce the dependency.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!


