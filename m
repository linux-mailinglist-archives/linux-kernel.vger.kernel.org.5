Return-Path: <linux-kernel+bounces-67482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BFB856C40
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1941284CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204AE1384BA;
	Thu, 15 Feb 2024 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flw+uQMV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA1136642;
	Thu, 15 Feb 2024 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020927; cv=none; b=MpJvTNzLXV2QOVwAfmIGnIZbZrF/1E8D3PGVhe9BNgoyX9zhcwQRZp+phdz29BEa2ndJ0SRVj8vfkOreSXYjuT1AKexUR2ogH2olAUydg0rpsI5fYCEHfV1rBJ4z2zgq4nmfdtGND8nLvaesXX3LKT+uvQhbCKkpRro8gx127E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020927; c=relaxed/simple;
	bh=/tRgUyJ1kN5lOG9h641EhrX4DWRyxFSJ+IDVag2vG2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCqXKHkUyLVn3SkckCStKxvSmipRpEuQL6KmoxgYecK+PF1feLzNpdjHb07neceO66rTrQ2pZaDKD94ww0c1+wGciQ9EOUq5DoZYkEcCspihbKmcPzEzHJKBeLpZw4fuuRYuuu8TzXnaU1cDVnxzoNThd6Q1wpIRyoDWPzOHg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flw+uQMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB9BC433C7;
	Thu, 15 Feb 2024 18:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708020926;
	bh=/tRgUyJ1kN5lOG9h641EhrX4DWRyxFSJ+IDVag2vG2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=flw+uQMVyQlYiGFcuLIWtwJqSO0Wqyaqmz+ERXsV8fgW8CSnYcdDlfg/n/SYUZ3L9
	 13zRFa8rxCyBJVTpOJapbt15iHX3v5xYoVgophFoCJIYV4rhpTea9RJg9oZ3C9Btyc
	 lNtJd/9a4YCJ4r7JBGl51QDNwSMQtOizvGxxQis9nldGmJkGzYlyABZejF7LLOUp0O
	 rGRwu8VBORKFwwC6QWn0ozBmYo76YM+Wf/BMw5jCV2zygSEmG5zFH68A+qSGlIb1Bk
	 H7L1ASVRJ/pUGeXk7BDPyE+1BGAolxewXhdp+DZ+qo1w09aanpAgIFDzFHeMjGdG4c
	 NB5S2udn1Wvxw==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	allen.lkml@gmail.com,
	conor@kernel.org,
	f.fainelli@gmail.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.6 000/124] 6.6.17-rc2 review
Date: Thu, 15 Feb 2024 19:15:08 +0100
Message-ID: <20240215181508.865801-1-ojeda@kernel.org>
In-Reply-To: <20240214142247.920076071@linuxfoundation.org>
References: <20240214142247.920076071@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 14 Feb 2024 15:30:09 +0100, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.17 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 16 Feb 2024 14:22:24 +0000.
> Anything received after that time might be too late.

Built and QEMU-booted for Rust:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel


