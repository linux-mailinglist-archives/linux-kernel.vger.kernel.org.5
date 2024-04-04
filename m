Return-Path: <linux-kernel+bounces-130795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E59E3897D30
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D0928809A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C05F4C9F;
	Thu,  4 Apr 2024 00:57:37 +0000 (UTC)
Received: from sxb1plsmtpa01-11.prod.sxb1.secureserver.net (sxb1plsmtpa01-11.prod.sxb1.secureserver.net [188.121.53.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B834C4C65
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712192256; cv=none; b=nUOT5Ke//T3o0uWlZwkySmSCvro/uzSQm7dqupukjVBOQvAqshIwTKC9XndRv8xcEYw+o3SAFkMsTx6iH2d6ZP4do7RrVBSD3Umu9EDUY7HH63wqh7cgh6pH3i1CV0onEBZhmcO12IOs9fVM0OsBKHGaA2DYOnWEhHGfGDFHuKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712192256; c=relaxed/simple;
	bh=wkVVPzfd0UQTkvZ8xc/BmRhj+WUj2Lu/IgPhkOElz1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QByoSWB58ogMhZJMDCckYbutdpl7+4ezOYjrk/MvzLz6DTLwhh+eYdSdYzkMDdcNuNmuXfzwnIl6iOh5eRncGGAeFrzKqG6SlPqLft+IzEyUHAwes87K/SjI8jGMWohPFgRBvcZcz6fEG+9KyBOTTEg0PTYunDqgSTUvCB3EmOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.90] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id sB7er3FFsvAPUsB7frsYBM; Wed, 03 Apr 2024 17:38:32 -0700
X-CMAE-Analysis: v=2.4 cv=R+XIGsRX c=1 sm=1 tr=0 ts=660df688
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=FXvPX3liAAAA:8 a=W08pmZW3enM1sLpWauQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <356bd1ed-9877-461d-9593-bbf1b23b3d8c@squashfs.org.uk>
Date: Thu, 4 Apr 2024 01:38:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Squashfs: replace deprecated strncpy with strscpy
To: Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240328-strncpy-fs-squashfs-namei-c-v1-1-5c7bcbbeb675@google.com>
 <594a6365-5cc6-4778-aec5-c5ad2a4b2930@squashfs.org.uk>
 <CAFhGd8pCE11Xm219Pc8uyJnsDkSqaTM6gpY8Tpa2fWmHg4OnCA@mail.gmail.com>
Content-Language: en-GB
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <CAFhGd8pCE11Xm219Pc8uyJnsDkSqaTM6gpY8Tpa2fWmHg4OnCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBq20SukAjsHUGUSD81ZufCFLj2kOVSbjtsHJxDyR/RYet6SRJVmHlsADOcDUkZyYBBOFeMIBvOVZLXPTw3bitAkOGgGp0utu0wfwHWSvsgYAQt41tz9
 /gBKeMmU2ckl8QthIAXK4vuu+psXeUDL+R2kANNGLtgpszVHStA8bIKFxZcjOlgv7peYlopIw2CUMrOCHOZ5t8fkGohWUhYUIef3W6G5kgEJBaCvrehEtVzl
 Rpv0g2bmmvbqrpH8cnYkHl2y3QXBw/i4t0ANDDMvMAXWsw0UtE7tAxoo5kS0YO88

On 04/04/2024 01:30, Justin Stitt wrote:
> On Wed, Apr 3, 2024 at 12:32 PM Phillip Lougher <phillip@squashfs.org.uk> wrote:
>> A better way to remove the strncpy() is to remove the unnecessary string
>> copy, which I have done in this patch here:
> 
> Great! Cleaning up this code while removing strncpy() is a two for one.

Yes - thanks for your reply.

Phillip

