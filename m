Return-Path: <linux-kernel+bounces-166451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC9C8B9AE4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7981C21C98
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07766433DF;
	Thu,  2 May 2024 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b="FrekxQg7"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5121E485
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653116; cv=none; b=cMtw95SQ0vRfzZqPgy4aGNNGBCUuyyZOB7oswmG0In6SyeRfV3F3Ryj0/hbUwnaY3GAmDi2EmasASkKC0fLTzAdcpGW+FQ5BqN6NXjO1V1eKwz47zcB/xJWMKh466xvFPWXPtsNuzUzRvhFIiu0i4TM5g+XSqnEAhWO0K7NQz+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653116; c=relaxed/simple;
	bh=89xc0zYkaas1DPRRwBQjMjBYyX0aPwX4rvAOn+BufGU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=NyhMe7fkbVEnIc9Ya4WL0MZNnPuTHgps02AlhuexvyvNyZJcuZDjCxBMvvL4rbS7H0ahDF2eJgw6FdrsxRssLCcW056B+OGLJLWjIMn8tN250ZIS/fjFbXaaTV+iyIfB97Cz6NKJKqfIbn7jskvWstU8lWPgM5CXrPOh0AqLXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org; spf=pass smtp.mailfrom=bit-x.org; dkim=pass (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b=FrekxQg7; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-x.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-x.org;
	s=ds202404; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=89xc0zYkaas1DPRRwBQjMjBYyX0aPwX4rvAOn+BufGU=; b=FrekxQg72C/1DkrSVKPGd7knNX
	A1shPnSrfh25JKXY+QXtCTG/DYIcYZhcdDt14cvoph7Is9+ya6nfvNah0Ah/F9qU9zQKl/C3SwZ0W
	lpFFbcYeddeakyCGpHaviOykZvvSB7GAbIVYr8PfMVvbq/eY6bIdHP4sYvRcMU2JJ2aqU3v48+XiQ
	NxCd8qeGUeg+zG7+EUwcCJjtfuvmc4Ha2KSnaQpTvczUdOYcYz5PDsvKJVHCwWhPRdCOseMSNYNGD
	IjAtteyPwk/oZsTRm5xZxdstjJwed1wA88/PPIesptm0b3VNVv7zvYUB2X7S3Fe50DKWka6uUcRev
	ZDH75TXg==;
Received: from [2a02:fe1:7001:f100:e8d1:4752:2997:ba78] (port=51381)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <ywe_caerlyn@bit-x.org>)
	id 1s2VbL-00DN8j-VJ
	for linux-kernel@vger.kernel.org;
	Thu, 02 May 2024 14:31:52 +0200
Message-ID: <b6ba7728-2e46-46d7-8197-0d19d6ade066@bit-x.org>
Date: Thu, 2 May 2024 14:31:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe_caerlyn@bit-x.org>
Subject: My Activity Summarized (Fair Pay, Low Jitter, Philosophy)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Made a little webpage:

https://bit-x.org/BIT/BIT.html

Hope You Enjoy.

The Light Be With You,
Ywe.

