Return-Path: <linux-kernel+bounces-153107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B34B58AC92A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48741C21305
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F1C6F067;
	Mon, 22 Apr 2024 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZUlxk0o5"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84AD5644B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778977; cv=none; b=f/WddzSyex5FPVV6UXetg0x+4WBynvEC9dVadLcU+s+MNsDaAhp4m2vzkZPgpRDwRy4rFJja6zUpYWLRWtjRlonFx9DzJZKIn67uizdVBEDQGy15dd/OSlnInCJSyyGpu6szT9V2QHU9+98VD+jSvgVdAytrVK3ipiqv6Klo4sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778977; c=relaxed/simple;
	bh=MELS3amIpY8Okfd3pwKIT1bLX6InE6Jx3WPvVhkGH8w=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAF2ruQFXeAOZ2dE7mz1+0B5Bbj6rhNuhzmMzWRtQxngUe+Iwu/lgSZ99NsEtUvaNn/1nfiLIj7DoChXxBNuS3SjP+tL0OI5Ysw7F/1OgW6qXinu9QjM95DihELOapNgcV6EIA54atTj6xWLgnPW4tREcAMqhhnpg6/YqIgWSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZUlxk0o5; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E45761BF203;
	Mon, 22 Apr 2024 09:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713778968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvESqQLIr6i2TR5VCevKMyG/QWxSODM4U0/ZVV3MUg0=;
	b=ZUlxk0o5iIBQ9H5zTkXndXqvZYBXsvcxJe5+Qebrun0xgm9KXCSeZ7vocvP5c9OlXD9Bv8
	+0OPFGwQ4gNLtIGtKJcYqCs8pKt/LFzHzvjqfC7nbFjfoXc7x1jySEJWuY1BDS9NzsKW/a
	6FPEk1MWrYYZwsRHHCRYKK2ND81/sg+H+dm2VRuvMjC124dh7D9Xs4M67hzwyyGlmPVaEV
	TChrTfaZARP2THievYmb1pD/dmOXeJVbjxMdv6CYtqLkPJFH9jwPFNOTgKr1tHlVap06p/
	AfoOlOpTEJZ2f0/Gv1xP6LqBHRHcvH5y3/fW4TJxZi+rC71tBfkTaDPsv58oSA==
Date: Mon, 22 Apr 2024 11:42:46 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Konstantin Khlebnikov <koct9i@gmail.com>, Stephen Boyd
 <swboyd@chromium.org>, Sasha Levin <sashal@kernel.org>, Alexis
 =?UTF-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, Luca Ceresoli
 <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 0/3] scripts/decode_stacktrace.sh: improve error
 reporting and usability
Message-ID: <20240422114246.5320a638@booty>
In-Reply-To: <20240311-decode_stacktrace-find_module-improvements-v1-0-8bea42b421aa@bootlin.com>
References: <20240311-decode_stacktrace-find_module-improvements-v1-0-8bea42b421aa@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello,

On Mon, 11 Mar 2024 16:24:53 +0100
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> This small series improves usability of scripts/decode_stacktrace.sh by
> improving the usage text and correctly reporting when modules are built
> without debugging symbols.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Gently pinging about this series.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

