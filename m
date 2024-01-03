Return-Path: <linux-kernel+bounces-15814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFFD8233AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966FC1C23BEF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6311C680;
	Wed,  3 Jan 2024 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n11hRldY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wcd01m6v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E341C684;
	Wed,  3 Jan 2024 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 3 Jan 2024 18:44:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704303895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXE3wCqeNnmfYrmRPdVySqOQzWJba0ATlinJAcsB6Ac=;
	b=n11hRldYbf/Bl+1fNKjAOVsJnIJrY3agtA8a1W6Hu+jcFvTO75dCfNOeVa95cYZETnxfI1
	ERpdpM3vYikRFetnHwQkCUi8l4tKGhj/3itk91lTJAm/AU4AoYMGBMQyjvshTsnAadIo0M
	2tn72Q7nBN9llmBHZTTa3T6n4D5J8vOERZtlENDR+27iYsSpxfi8UuJdepKtr2yLRG9Su6
	4aZL9o9WYAb8b0OJHbZtiXWzmrevFYnUM84FCBG866GXO8hKS37nRS1DDiUy/ICCovrRoR
	VQdNsRWc1AQ0w+wuVOHPToXUzGeThqRA0O+YH+tWMk4N7Hp8CM97sNB8lSxwfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704303895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXE3wCqeNnmfYrmRPdVySqOQzWJba0ATlinJAcsB6Ac=;
	b=wcd01m6vhOxYKTXKbcioEhRPdM0dQ9iEvNTOtApRWB3HYikB0qjaKDqjE7t9nKbQPRA1zs
	uynQdYit0+5i3tBw==
From: Nam Cao <namcao@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
Message-ID: <20240103184454.2d65386a@namcao>
In-Reply-To: <20240103164834.970234661@linuxfoundation.org>
References: <20240103164834.970234661@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jan 2024 17:55:20 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 6.6.10 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Works for my Visionfive2 board (riscv64):

Tested-by: Nam Cao <namcao@linutronix.de>

Best regards,
Nam

