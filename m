Return-Path: <linux-kernel+bounces-161393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 879BB8B4B74
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D541C208F5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFCB56455;
	Sun, 28 Apr 2024 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9gdxeT3"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6521E495
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714302622; cv=none; b=Vo/BPqi3igya6r9fGps5kL0Jzyx5r/Nt7xdI/A7/fWtWmyY4idPCPObx1bxez2yikeEvSb2z66+KMgHcWfDm5HIUWJ8V4jIH7+u3YYVMNRkvgLmUJ4dpOtVOVP1A4aDAd5ALEvz2a7wBbitMKZFNJ75B2UjW+qA7aJm6P8QlwwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714302622; c=relaxed/simple;
	bh=+PkoAp4bAsc+2jHRlfS6PmVGfkfnRE4zZhVegUAT/Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hj3sa8B3FtQzJ/9YkMjYMQRWJdX8H4XsQTJfGz3fDOYT8J/CXFoxKpxSALc3wgwSJSSLXK6RqyZPL1hmq+1X8l00HeLTb+8KOq7OORR0jF8FRv55oenSrbamF7HLKMk1QzvRlikP2Lx0EGHnbFqqMNBSbNG2eJC7DkaUUKXbDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9gdxeT3; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2690217a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714302620; x=1714907420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0Fl9Xl8UBJIzLoWawbGovJK0UTUwu2+7Q1CeI9zq5U=;
        b=H9gdxeT3NW0sveDqSxzvi9IuzJ07x1nGT1WPnK3W7FsZy5S9Ps/9lqM/PZJnyr/AX5
         aXOiiETuGeJdH+DUVntlfHixhAl8TH99znFzJX7Rh8Ty0u1h1Y3JNsKuG+9XkImNfuoD
         4m4X8D0p2Ch7vGiJahYusckk3dkw9fsg8Tf+C/HE3QYeX0umxyTRvoDw60mDWngFyOL8
         +V5nVElHZpOKMN22TlABWM1DTRMpdM1ZSgxVGgvg/N5ugnMj938cmlF5kfFmgRS+YLsE
         ITwYJ2FwGThxtLahLybVsl32J/FPtigKAVbm99SpQvKQcSTfBxr2sD9tZRrQ5Lk8Ay7y
         AsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714302620; x=1714907420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0Fl9Xl8UBJIzLoWawbGovJK0UTUwu2+7Q1CeI9zq5U=;
        b=EYjRb0y+2KSw1yEa0OeH9gElls3IGXo0csKhHxHj6rNG5XYmJVcHVvRV0c8pdR6bve
         QAmWb957oAHH1t4hTvxQEl4uKG0b7atvpKyCTgCNnIc8c4NhZF2LGk59Vf7lVzvMirTN
         f62OETU7NxLtgM4j4l+Qqbwf+8KljSgEoUXYyNddtuy5uDWHWkFrt9N6Vn7nbAc5IvbN
         z8zZ1nTrKe29tZmtXokMtzEusRHoHuuY0HUyd27jhPWfdaDmC/ZNJOisiltYRfQ7WpPw
         h7M5mCtoQ9+YFUuvgoPT9qcUUFnzLA617ByqTzqe7AABtgbMdIGCfIZb3fVoPGkLcHzJ
         cITg==
X-Gm-Message-State: AOJu0YzDeTcd590Tgcj7MZXA8t1W52Qhb1NVFPVyuzMuYudjjOpFqrUL
	Ks4iCf3dkp8Fz0oJKoriOgQ6pqlJnLLLq/3ouJWMnfEiKB+1hyRJI8PWtw==
X-Google-Smtp-Source: AGHT+IFd3RbGVM2O5Wgx7iEsS2JQwgB4Q7LZZoaPz35wBYnkJ0KXAR3gCfvYu0HjuNqL1h4dlgt2sg==
X-Received: by 2002:a17:90b:1085:b0:2a7:d810:2f5e with SMTP id gj5-20020a17090b108500b002a7d8102f5emr6844424pjb.48.1714302620572;
        Sun, 28 Apr 2024 04:10:20 -0700 (PDT)
Received: from [192.168.0.107] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id sd3-20020a17090b514300b002af05d7e60bsm8002319pjb.18.2024.04.28.04.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 04:10:20 -0700 (PDT)
Message-ID: <221f6cfe-07c9-4fc0-a908-84276b8e4088@gmail.com>
Date: Sun, 28 Apr 2024 18:10:16 +0700
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
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <2024042828-occupier-confused-e046@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/24 16:56, Greg Kroah-Hartman wrote:
> On Sun, Apr 28, 2024 at 04:47:31PM +0700, Bagas Sanjaya wrote:
>> Hi Greg,
>>
>> Sometimes I'm tempted to send patches as .eml attachments (just like in
>> error messages sent by mail servers to me). Is patch submission by
>> aforementioned way accepted?
> 
> No.
> 
>> If not, why?
> 
> Why would they be?
> 
> Attachments don't usually work as you can not reply to them and comment
> on the contents, right?  Try it yourself and see.
> 

OK.

I experimented this by sending dummy patches to myself, as attachment.
I replied to the patch using mutt and thunderbird. In mutt, the patch
contents was quoted, whereas in the latter, it was missing. Hence,
email clients are inconsistent on handling patch attachments.

> Also, .eml is an odd standard, what's wrong with text?
> 

It's also text format like mbox or git-format-patch(1) patches,
though.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara


