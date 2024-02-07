Return-Path: <linux-kernel+bounces-56348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 805E184C908
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1915AB23D9A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB0817BD6;
	Wed,  7 Feb 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzexBDYh"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB7417BC9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303358; cv=none; b=lO+ArZ1E0N1yddcy0AF4XfFBc2J2moamhSSIL9tIIowD4z3rFoZyRZC1eC7GR2qkhYyhqFyRZ1rlsayQMFNpIty4j/vQ8t59HBt0KkvclJo0eT5q3JtdCO+YwjqGklYBOInWdapA3PQeTRj3ekKhkQ/OQG2pBvGFo/S+WGyT3ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303358; c=relaxed/simple;
	bh=lItl1HgQctg0yGO3vQoW8No5gH2g/kKbqcRUSlAmvso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0SLjAYWnZfxisEnVdQNW1nhkKUWCeKyzz+fGa8W8sXjuJnolW2aPB/LXZtTmvRh2CmkRzsL+btkWz/msO6Y3I6L6LS5Y0ZX1JPI1sWGu+3F+OYD2koY1p1GPepWS9QDFcvIaXfDepemI6dZMknABTii74RDfXkAl0FiPKsDksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzexBDYh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a385fa34c66so61501766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 02:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707303355; x=1707908155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLCLXsc5fUpptpYla60epcYi7vijOWLdq8xCpov6J+E=;
        b=OzexBDYhUX2kIg2DWq2wDOb0iHCw/fJ5Xe5gn0PIPSdcHBT4e286sY12aO+8TLUBIA
         uO6f1mkvmxrqQP0XKW80p0x1nhyNx7KYF/v5t4lYCeBCBp5uRwfRIoQGHRjp1c1VMne6
         /Z1LJWahaoJJ6KgHU258oJe7jcZ7pW8cd2OpMY4pqha1LTD/uFzrkO2K3XKx7wAGMEG9
         ze3O7ZCVPR/F0qDVw5Hy6HVK9cM0BCuOvVlfrPAkRa84ZdRaOlWGOtp6BmzDdgc0/ePH
         Fkld6g8ke9vYIiNyWHVfTy5+4bI5HOTzBpxNos0ZCazr7mNC4w0d2zmi3NYHjVFZ94Sm
         gV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707303355; x=1707908155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLCLXsc5fUpptpYla60epcYi7vijOWLdq8xCpov6J+E=;
        b=V72UgJX4SshIShmqSG3B4p69cx1O8bwBP1luRnReG+5H+7c4dJQnT0ieA8IvSYZ+jR
         WZVSoye1vh67b5VxnRLEjhwcSYvcObPLIno8UVxyGWX2+Xq1vT9vmbx4wNK1P/7fRxjn
         cCC571sdlxVC0jDiJfVL6lzfVPHK/VVikgar5iP5H6wl+zXXx1Ag+Au4Zmdcf321DPSA
         GKkFhTRSBIM0v4ytsnXUtMCg/8nCOnX3NdbF/0RAmqjRU/IxY0Hbl2nwRHILf388dNHj
         qRJEp7v+IiSWxzasDBQH9Tp2DCtpnlPsEJPImDufWqf9HSMObFP8kk1Uarfdrlv1DeoB
         vblg==
X-Gm-Message-State: AOJu0YzGRMP8EFOwj/XTRlxtEZ7ZqCwOxjDi5Tpf9mqP4sQ0xff+s7N3
	Apd9WMJRoEP7OhjGgvSvKKOEFkdjY4RlGytFVa0gIDNbkyXbxFVL
X-Google-Smtp-Source: AGHT+IG45p9GOrVYDWYexIC+i3WbKpGc8eD4wiqw2CDKsihG2jvG+xhWIxjCsdmid7rhutrQ0vEAqw==
X-Received: by 2002:a17:907:3c25:b0:a38:551d:ff1d with SMTP id gh37-20020a1709073c2500b00a38551dff1dmr1516680ejc.73.1707303354560;
        Wed, 07 Feb 2024 02:55:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLoIXfY+ERKrpUa2c4Uedi7yheP7R34zr6Q0XQOpvQT/qv/PFI1XIpHYmRTfCqFbPI+9HOVMOcKzkCp7b+y7B8NHIr4K4pK0A11agu5ZBd2l7z2sZK6DyGHytottEKkvRDGNknz4MxzOxcKkwAu0etrc+ELfkCD0n/2OB7uxRxJA==
Received: from [192.168.0.101] ([95.90.186.51])
        by smtp.gmail.com with ESMTPSA id vb5-20020a170907d04500b00a388723b7a1sm314137ejc.50.2024.02.07.02.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 02:55:54 -0800 (PST)
Message-ID: <a7bb4065-6e78-459f-b280-caa0b922a317@gmail.com>
Date: Wed, 7 Feb 2024 11:55:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192e: remove redundant braces from single
 line if-else blocks
To: Greg KH <gregkh@linuxfoundation.org>,
 Ahmet Sezgin Duran <sezgin.duran@linux.org.tr>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Michael Straube <straube.linux@gmail.com>
References: <b97e1f8927d81b9b72cdea7a30f300b35854c38d.camel@linux.org.tr>
 <2024020757-desktop-atlantic-749e@gregkh>
Content-Language: en-US
From: Michael Straube <straube.linux@gmail.com>
In-Reply-To: <2024020757-desktop-atlantic-749e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/24 11:13, Greg KH wrote:
> On Tue, Feb 06, 2024 at 11:53:38PM +0300, Ahmet Sezgin Duran wrote:
>> >From de5c5bb23c77fe62987b446c740b971e85105526 Mon Sep 17 00:00:00 2001
>> From: Ahmet Sezgin Duran <sezgin.duran@linux.org.tr>
>> Date: Tue, 6 Feb 2024 22:28:55 +0300
>> Subject: [PATCH] staging: rtl8192e: remove redundant braces from single line
>> if-else blocks
> 
> Why is all of this here in the changelog body?
> 
> Please fix up and send a v2.
> 

There is already a pending patch with these changes.

https://lore.kernel.org/lkml/20240201081824.6998-2-straube.linux@gmail.com/

regards,
Michael

