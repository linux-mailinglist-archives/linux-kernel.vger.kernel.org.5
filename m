Return-Path: <linux-kernel+bounces-119219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37B088C5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4601C63120
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A031D13C691;
	Tue, 26 Mar 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i12YhC9I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E529E13C3DF;
	Tue, 26 Mar 2024 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464694; cv=none; b=K7hN9CKdPh8tjbtEjvNn4Z92fthJZkAtepK6AmWbyt+dgRy0A9BUhpwsiz24oir8gEI3NM5pmC3clyST4Y6Vu6J2jWItMeoadq0A4d+kWNIwcmQPVifxLg//Yoj8dRXVIqFKut5lB2IfDhqPUEOO0jSlHVpSLNs9m6GwQsRlVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464694; c=relaxed/simple;
	bh=1S8YmvZLnnCGp5cJzXZPgCZSBORNP5o8RFFdyrmMUUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ror8IXa6mV6TgyHUiQkwEf+223dtcEoZnA4qEPOdLBfr4slnnVMFMKFXJWdq1kvI5IxwUcypt6Wvb2d6UtGqLTuERT7Aimd+4Jzpodtn8yDpY8QVRRfXhpJ41koX4ekUE5XslTovx5n0oR/p+CD6OMD9U2eg+5D1TxhY2QSMygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i12YhC9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C504AC433F1;
	Tue, 26 Mar 2024 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464693;
	bh=1S8YmvZLnnCGp5cJzXZPgCZSBORNP5o8RFFdyrmMUUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i12YhC9IHvVr88VSmIMvBIlqOTNkY+QfcqMcXOOkqm26jHwqBHLQMIAqcdHPunwD2
	 Xa402wCQInYxGps99pBmnXJ4JXIrWz5S3fxAev7eUuTraxmJVXVdYECMuFj43BQ18D
	 auwg5sGWjn5xlOHil8XS9RNrErrr5wupAsLQyqDzcsNMiif8ch4pWHU5M3simcuNo9
	 c5D2oAwB++v/BKp5P8CYp8RYKdnfyOuNogvpetVw/JoWmn6Amw3oVY93pLfjS/h0ym
	 Fc3VtfYYBNKAGT6iPqVlbuEafuTJGsx82BZG6A1RV+nUHRsNkxxgQKOO+4/oCWsWJx
	 xOGI6Up0u4JPg==
Date: Tue, 26 Mar 2024 14:51:29 +0000
From: Simon Horman <horms@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] net: amd8111e: Drop unused copy of pm_cap
Message-ID: <20240326145129.GD403975@kernel.org>
References: <20240325220633.1453180-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325220633.1453180-1-helgaas@kernel.org>

On Mon, Mar 25, 2024 at 05:06:33PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The copy of pdev->pm_cap in struct amd8111e_priv is never used.  Drop it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


