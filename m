Return-Path: <linux-kernel+bounces-58148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D67A84E1E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7E828F555
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59976763EE;
	Thu,  8 Feb 2024 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmvigZwh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E7971B57;
	Thu,  8 Feb 2024 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398589; cv=none; b=bCsMMTNLv2ap4OdW7nPw/rmkweHxTZY69KBHPD4lCD+ylQ9aMqrXWGuLO7NcTcOfZ+UFRpibCIU6zRkZH9Cb52QPIyjpfOs9rMG4YdwOmMgC1CLpMolMO2Hj9LE9NAT3WO5EE6kd1BiVjn4X/VN0uFOFGITDhiZ3CnGbB+fSOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398589; c=relaxed/simple;
	bh=RBoYUxz2Zy7BMEEQpFfCmXhv2Y9zg2/qIjf9E1tAN+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SufSFSZcKOvkgISZJkZebD3dvHxStoZOIjBRU13JNHFYxjpAiVJ6ltWmTg/RVuz6Bx8sNtLTUbzgPIdhQkwRLM3yQRfl7nI2gMqAGUMVA3OnQRs6G4s1/kg1f5VMfrU8H7fKsbkdmnQgVMWJJ5UUXlPKsWNFV+qm6f9c5WvpTrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmvigZwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1A0C433F1;
	Thu,  8 Feb 2024 13:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707398589;
	bh=RBoYUxz2Zy7BMEEQpFfCmXhv2Y9zg2/qIjf9E1tAN+k=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=hmvigZwhdDidzjjHIH90n+8M5/TQFVMz76fH30KTEFJ7LV/oj6Xs2DOmQHvewChNw
	 uK6dP/YK7WMmXgDExLuLu1Lg9lsKriafrzbvAYXBNNyS4Lykn1F+w+5Y1ZtHs1zIVo
	 W6TTKpBOSaJ5hz4t5gKJePDbvdv7gbtW6ANREvKE33esqtuvSirpMlG2c7Dp05y1sT
	 0CuoKDyiBqynLiLw0TtI9/oeClODFJHGOvh9QL7SjsM7EiabZy2/pyRLfSBLC/h1GU
	 7s2tyEYrKvoOKyctMQKolm2Pgko2bzgkj+sbe6BS/e4BvBPunkFIV9FdOh1L29kgPW
	 QaAVgdbpKceSA==
Message-ID: <a3997425-ef59-471c-a3cc-0429596d1fbd@kernel.org>
Date: Thu, 8 Feb 2024 14:23:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtla: osnoise: timerlat: exit with EXIT_SUCCESS when help
 is invoked
To: John Kacur <jkacur@redhat.com>, linux-trace-devel@vger.kernel.org,
 lkml <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <20240203001607.69703-1-jkacur@redhat.com>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240203001607.69703-1-jkacur@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/24 01:16, John Kacur wrote:
> Fix rtla so that the following commands exit with 0 when help is invoked
> 
> rtla osnoise top -h
> rtla osnoise hist -h
> rtla timerlat top -h
> rtla timerlat hist -h

right, I am setting this as a fix.

Thanks John.

-- Daniel

