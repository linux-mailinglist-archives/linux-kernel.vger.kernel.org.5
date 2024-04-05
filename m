Return-Path: <linux-kernel+bounces-133482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF3989A45C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4771C225B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C852172BAC;
	Fri,  5 Apr 2024 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gjJR7JMP"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349F0172793
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712342544; cv=none; b=t7bIEnTViL1aSdKcMP1S2/jaC6cPWPrBo5dLVP+Ok9e85BXbuPtCnfOqzZd+PvI3ldpboW2lTfJcxCBP32WH2Bl8c3cc6qzaWXV9/CKOg4h8Ozbycd2Be9gLfFZ1/jQ94VcGOi2KTfm02t5LdKlPQ39wq1O9f44MOHiG0D9NurM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712342544; c=relaxed/simple;
	bh=aKzj2nNlzMJ8azIYfSPAwEduj86IzTAYqe3VzO9WswM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAoSUnQ36VqHkhZfJNm0uErtR5p0OE+XzMUl9prTtoBOFea29lxV+nMmEeeTbxW26lZmq+hIBBSAwuv1uJN85++Wb7KHKUqzOOF8gx6HoH1nY1jtzXJedca2pqqkyMTdFAFfkW0sfotaWwJZG2MKcTvlQld7CqTpS5hcwHyHtWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gjJR7JMP; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Apr 2024 14:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712342539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tZ+uiehsJ3wgEMKI7SgICdPj63wSJBV8Zz0Zm6XtKDI=;
	b=gjJR7JMPwM69GilljNxaLsraANZiI6ZRtq1EYVMXDo+DU9QnxgReuT6F28u6Gk1vvV1aKA
	xO8AU8gk5FRrrcr5U3/R50gv77g3bYT79QBgMK3FUOm4LFJ4EkJi7ohhby7osRXx+CbPpA
	9jPo5NKxNAaopVsaY52eQbFhnH3JOS8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] bcachefs: fix ! vs ~ typo in __clear_bit_le64()
Message-ID: <ojophuwjmdwwq3ki6zi5lxzsma3xjmfgpwvutb6lden3j746sl@fe5lg43ptovd>
References: <5ecccc80-70b2-4c04-8c09-1113fef3e515@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ecccc80-70b2-4c04-8c09-1113fef3e515@moroto.mountain>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 05, 2024 at 06:01:02PM +0300, Dan Carpenter wrote:
> The ! was obviously intended to be ~.  As it is, this function does
> the equivalent to: "addr[bit / 64] = 0;".
> 
> Fixes: 27fcec6c27ca ("bcachefs: Clear recovery_passes_required as they complete without errors")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks, applied

