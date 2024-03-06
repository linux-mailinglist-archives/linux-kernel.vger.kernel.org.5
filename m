Return-Path: <linux-kernel+bounces-94624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804EC874251
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A12286A2F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996EE1B94D;
	Wed,  6 Mar 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="PfbYyyF7"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B09E1B81F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762434; cv=none; b=dCafAuvKAb3Lg/UxgXWppaRa9hez7oPsN0pinN32Mc6hDQBiHdPwPFEXNXvho7Xx0Bxr71jHFqJqv6+tb9z8CwYvESP1nEZcU4xks32yGu8IquDPqPKYur1fBO4bQkE8LJ9aVJXl4m2oWENPpJgqzvT3nHCwpS+BWS9L6A1ER60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762434; c=relaxed/simple;
	bh=hDwOgBcfiZUvGAVEwHEQbgSGzi8gfJaF9VyDIkEARlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IXB/PUDHJLFZwF6x2xAbrN9Cp+qUS/WWyjHFsu5gqRm5wRK9xE7BQpks9tRCgDlJfrh4HX2JtEcDxWDE9EZs6GRjefe+xsduPOz8LmgmrjY2OJBgF2cW3rCN8TddNR2ELoYfL8UDu973G67+v6aP3cHwq6HEVuFnuiAeutioHUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=PfbYyyF7; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97D2F20003;
	Wed,  6 Mar 2024 22:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1709762428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDYNGqN6w1YyDxJqmC877Bab2ohGefRUrXkbW8c41lo=;
	b=PfbYyyF77TWLxWYVLGEQuzIy4ZW94hqAyjP+KyZQrR0+6rIMU14annTzgaHWChwZxqQ2Qi
	p1LDb03rabTJBFztqaXvzkhV8BlYftOQ/WRu6nuF8RXlK4bKU4Lb5XyNRDvYI0e6/anX5j
	r+Oj0P9JNG03S+kNqs0GkpkJNZwgpR3hvC567H81ZY0BkSJTdv1FoLnCc62iWFguzwHxIh
	FUOPcUyW3vxdCN0AW6cZVMySk+SrSQBHQeqmKwgtMrH6TG8Zj3q404iAgc2EXTByHoItkj
	1yW8dKoX0yw6OBORIKZnZL/pdWzOpbA+2xhUC12hscxAgov51SmS66F4+xl0Qg==
Message-ID: <7360e276-653f-4223-9ffd-3f701844a84f@yoseli.org>
Date: Wed, 6 Mar 2024 23:00:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailmap: add entry for Jean-Michel Hautbois
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk,
 stephen@networkplumber.org, o.rempel@pengutronix.de,
 quic_bjorande@quicinc.com, heiko@sntech.de, konrad.dybcio@linaro.org,
 kuba@kernel.org
References: <20240306085934.35904-1-jeanmichel.hautbois@yoseli.org>
 <20240306125003.de7b09d64e28a7685eb22f17@linux-foundation.org>
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20240306125003.de7b09d64e28a7685eb22f17@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hello Andrew,

On 06/03/2024 21:50, Andrew Morton wrote:
> On Wed,  6 Mar 2024 09:59:34 +0100 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
> 
>> Despite having contributed several patches, my email address was not
>> previously included. This update ensures that my contributions are
>> correctly attributed.
>>
>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>> +++ b/.mailmap
>> @@ -250,6 +250,7 @@ Jayachandran C <c.jayachandran@gmail.com> <jchandra@broadcom.com>
>>   Jayachandran C <c.jayachandran@gmail.com> <jchandra@digeo.com>
>>   Jayachandran C <c.jayachandran@gmail.com> <jnair@caviumnetworks.com>
>>   <jean-philippe@linaro.org> <jean-philippe.brucker@arm.com>
>> +Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>>   Jean Tourrilhes <jt@hpl.hp.com>
>>   Jeevan Shriram <quic_jshriram@quicinc.com> <jshriram@codeaurora.org>
>>   Jeff Garzik <jgarzik@pretzel.yyz.us>
>> -- 
> 
> Well, this isn't ./CREDITS.  Why do we need this?
> 
> .mailmap has:
> 
> #
> # This list is used by git-shortlog to fix a few botched name translations
> # in the git archive, either because the author's full name was messed up
> # and/or not always written the same way, making contributions from the
> # same person appearing not to be so or badly displayed. Also allows for
> # old email addresses to map to new email addresses.
> #
> 
> Now if this entry was mapping your ideasonboard.com and/or veo-labs.com
> and/or vodalys.com and/or gmail.com addresses onto one address then I
> can see why we'd need the change.
> 

Indeed, I am sorry for the confusion :-/.

I will send a revised one to map the old addresses to this new one. Thanks.

JM

