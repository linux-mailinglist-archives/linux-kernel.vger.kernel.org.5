Return-Path: <linux-kernel+bounces-142986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B418C8A32F2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695FB1F21A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE1213C8FC;
	Fri, 12 Apr 2024 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfMiWMYK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8202E14884C;
	Fri, 12 Apr 2024 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937393; cv=none; b=jVyrZEn7apMGo//5hJeDQ92QUnzTfY1Am3exlpFB17yNGP8qar7T40FGPxzgCh8dctpxnckIj7yPgoMvvBN48YBwaxM0x80mPxASioDYeM/hjYB2sWzlBpEMRTod1par/qPoU5nwoNB25zybkThy7ZZ2vp1wFwe7eDEn76pZGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937393; c=relaxed/simple;
	bh=EH2WjFmIHkNUY/vFnUTVm2nyvZug9GDXvhQF7t60oDQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BaTPFLbaKW9KM0lFFsoaX4sPunO6CKPDUcZuprdwMD2skZxPOtp3/9m9wbuf9BqU7LFB/NSdAwi+ykjFkIBXWSnQoXg2YuUiQQyFwtANxzZdFM0sYkJlQRQcCdI2ucV0CbweO+vCNtCIFDir7G/zvBDtmUpSTeHqgZI7f3yASXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfMiWMYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02907C2BBFC;
	Fri, 12 Apr 2024 15:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712937393;
	bh=EH2WjFmIHkNUY/vFnUTVm2nyvZug9GDXvhQF7t60oDQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=lfMiWMYKSk0qOL004piEiMPPR8E9SZFLnp1H2MXblnITXGvs9Y0nRkQif86Zw7vbk
	 /rUw10BpQljJb5U++nUl6ZQzx35pdXDjO5CISxvb+pN1wpdbwjq2fN6TBXriHEh9o7
	 iRYKt/OzL3PRRjBIOYTgV9zNtO4WGvszyWszg/VvokNmrq27o/fXlkfBHXI/t4/0Zv
	 QM0vpklANtsOT7DeB84RkV26n/aXzIcVDwur5pLJBjnMmhCOCuh7RpoOoHJaqmVKm6
	 rN/m1SB+UWn7eo0gXSyMDGsCTyTzoMRXaRyIp+aSyMjHrvhmY7EFIwK9AyvhPU/1F/
	 pS3IBbaqS3MKg==
Date: Fri, 12 Apr 2024 17:56:31 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] HID: sony: remove redundant assignment to variable
 ret
In-Reply-To: <20240328122213.762889-1-colin.i.king@gmail.com>
Message-ID: <nycvar.YFH.7.76.2404121756200.5680@cbobk.fhfr.pm>
References: <20240328122213.762889-1-colin.i.king@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 28 Mar 2024, Colin Ian King wrote:

> The variable ret is being assigned a value that is never read
> afterwards. The assignment is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/hid/hid-sony.c:2020:3: warning: Value stored to 'ret'
> is never read [deadcode.DeadStores]

That assignment is indeed bogus. Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


