Return-Path: <linux-kernel+bounces-161439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E07E68B4BFE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8C61F2150F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF0A6D1A9;
	Sun, 28 Apr 2024 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFUrmGeX"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D008F516
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714311139; cv=none; b=UyS37S3xKFNsd2vf85XGRtAOeZE8zpM+BKWXnMWpY4MpVMVbmgaG+HnIPC+vF7Bepin2Ol83bmtCBLkhZlsjxpbsxXALmo6khqB7ROjID4nDbPvVjampDvU7SnDGrRYkLgyfiXIuxqjua6vBUM4h10c82BmRUK1VkstXowsK7dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714311139; c=relaxed/simple;
	bh=dNfKAzc2n0aQjeRf37SRwgv/cL+MXMbKtLDCrQubHuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eaBhf+GrO3/gidJp2WB1eOcqSn+2VR31eA2fjhen+swDXRfti6JPP20Ql5CfI1vUxW8+OUVCHES7ozhp+wG5o4uvYD1at1YmWgPX9vXXRtzD2Ggr2lVVRbdpOtaBz6YXaYOSxbMazsfgqXWZiZngg3PKV4q91LUhduvcM6+ZXSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFUrmGeX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed627829e6so4451940b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 06:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714311137; x=1714915937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jduh4GqUwvRZ4zY8Yj7RDLOSNJbHnEuldPhAhc4IioM=;
        b=OFUrmGeXJH09c+3v/x/zwcLPQ6k+nUkvuY3ksKKDnFMq2+ZLrdJ53RtKVaa6PKRih+
         qV2SAE0Iivpa22Hbc8EcSu7NUkCHrrXB2FzHDARdamG+p6XNEgg82Y7Soohj4SyAYFWM
         DxgLaUEfCxtNNznGN4laD5iCDS5OMCQH4zFfOCpaLgwBd+QF1rvBDOlteQe43qJenk8A
         CO7yNsuBHmZtA2G8OciRVvDmupAq5oQmmFQEvCb1BJx/l2AxN0LspN8SB+CQm7DmZ+5P
         OQj/lUD7EkTnB+k5HQmlanslMvkZJMToikqjwU9FvQt6+3phsWDZY4gCyKBKi74lWoGO
         nz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714311137; x=1714915937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jduh4GqUwvRZ4zY8Yj7RDLOSNJbHnEuldPhAhc4IioM=;
        b=XdfEmWwFFyvpsS8dHOdPf+zN9xZnWxw8pPuiwKwpiXRykfBz1lHdrVrxuim3J0FOx6
         nJnX6eC9u0PXBFpzPlBv5Vf+27ufj7UrULShzCf4bmOzEeeXN/Lef+RiyJ4WJUEqr6uU
         NqDRz/zb3w3imha404nzbjZzGor16GJMl+/h8QYvragvXPrh2zWo+AfgbUjFVM2vx5nI
         jGtCR9kfZHvbdZiKPfgK3youlNU4jwXJ+Y3jUpLPwLcIPgOAetsvqcCeXv+iiL5PVePT
         kfBzluypIL8SPTB5aZxd2yhziVlbGDBFqppvgH5kKRqwysunsdKgQ14g+0BXNfRsixhR
         UsyQ==
X-Gm-Message-State: AOJu0YxtBQcjV/NW0+HwgpxYfAvKmoGo9LStdi9+aU4NPPfurHn5/OLA
	ooDIaW1IWTwh2lFJiKbxDOPT9FVX9AK2DqFCggEV/gN3DbTZN5gyF2R/Ew==
X-Google-Smtp-Source: AGHT+IFnBXdXBesbWY0nAX1ZFUw6nivCyZeO8uxLNEtkhb+41pihpFkZDcJ8pxVjh2DVM0aDKKt5/A==
X-Received: by 2002:a05:6a20:394d:b0:1a7:a86a:113a with SMTP id r13-20020a056a20394d00b001a7a86a113amr10599703pzg.6.1714311137365;
        Sun, 28 Apr 2024 06:32:17 -0700 (PDT)
Received: from [192.168.0.107] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id i6-20020aa787c6000000b006e6b52eb59asm17591218pfo.126.2024.04.28.06.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 06:32:16 -0700 (PDT)
Message-ID: <ee12e2f4-3e43-406b-816a-5f5822002f39@gmail.com>
Date: Sun, 28 Apr 2024 20:32:10 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Sending patches as eml message attachment?
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Zi4bMx2FKuviJi0M@archie.me>
 <2024042828-occupier-confused-e046@gregkh>
 <221f6cfe-07c9-4fc0-a908-84276b8e4088@gmail.com>
 <2024042844-disfigure-dose-e194@gregkh>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <2024042844-disfigure-dose-e194@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/24 18:18, Greg Kroah-Hartman wrote:
> On Sun, Apr 28, 2024 at 06:10:16PM +0700, Bagas Sanjaya wrote:
>> On 4/28/24 16:56, Greg Kroah-Hartman wrote:
>>> Why would they be?
>>>
>>> Attachments don't usually work as you can not reply to them and comment
>>> on the contents, right?  Try it yourself and see.
>>>
>>
>> OK.
>>
>> I experimented this by sending dummy patches to myself, as attachment.
>> I replied to the patch using mutt and thunderbird. In mutt, the patch
>> contents was quoted, whereas in the latter, it was missing. Hence,
>> email clients are inconsistent on handling patch attachments.
> 
> That is true, which is why we say "do not attach patches".  It's as if
> people assume we are new at this whole thing...
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara


