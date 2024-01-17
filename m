Return-Path: <linux-kernel+bounces-28555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA42583000D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CA1EB241AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1605DB662;
	Wed, 17 Jan 2024 06:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O1v2tJE8"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF12B647
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 06:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705472271; cv=none; b=piimt+ICQ1nEBOjbrS3V2Ft0eJJjLz+0P7CQQccLsaDWgR4C8QzTqp4GMjRhucrm5EDrfw+K5O9GDKvK8DasAGW8tPcvqNqsBgnsSRmEycU6vbe/A78ANj2zkHiO7PBUvHdMMiYKVsZmFb6hl+2/6cF21r79CYWCSaO+lOMq4uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705472271; c=relaxed/simple;
	bh=9HbbufgCpeF1Z72M682Qsrwsj1hDdBuxzZl+OJESr+A=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BXxRJVkILH9sFpikVtVKWZxOWhf6+WuVZecU2p2XzOfTKmLNSSexASGNi9EPVAVEIz7zR53hqls75OtL0fN80HM8HwfCkdu1ARWbF4VN8i7wLay+LwKFRlAtfSBOLTKoTFs7DDkCsR6p2NCjk5vJaPWWAela2RwmqSIk8Sw9/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O1v2tJE8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e80046264so24920395e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705472267; x=1706077067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RIh/mdSxC+QwbifziEsMcuiyyKp0fbIFDG5Z0ia7now=;
        b=O1v2tJE8GB/4VFndIAYyHfqcCjHb6epVbi3HQ7bfwThuSe2hVJv85W73zKE/LXddLt
         pWnoUOldQdryZsL+20SZIo46nsG1yZgBiAmuRI0QGKdicmNn1TVMIjU9OhJFBhsAc3ls
         vUlLhcWxBfiQoU16m8kgtTEKo86zlICCvw8237pOIWgwaRdc3DRjxVKsXKq7sZ1wfY9f
         Uce+GSqn5OfWVEh2tJAiT3JT3MEyq6ms7d6gRRJMz6A3+8ego7KhEwBIa/wvt8lfp7fL
         Ul724rwXgv7KGBFO06IgvuvE+eP3zfCZVAhlHPaKEuy2ObVxJz6S2gjhdqxgKzruttCB
         5s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705472267; x=1706077067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIh/mdSxC+QwbifziEsMcuiyyKp0fbIFDG5Z0ia7now=;
        b=nKGCPJrHZse3uY9RJ7qMaUhtHxnnv5e5bUowFjVAy1I1a+OMA67jme81bec2Llw1wP
         67WxzNC/UIIggqj2U+yxm2gKRRnJPMCNtiZnILmPHrrgvkM4qdF3VFxXmHz+jdhDs01w
         NjOFRYylu8pYZ6eEpT5WCGFX66AZnIjaW/4S20iLPuaWUg2tztJhzGxdgNEwvM7P6Ouk
         nk79PekZK1Zqwd4NzoF1xmlZOcF27VmrJWFmdf+d0L8MNcxL3Z7DNjd9dtsdMWRjuXJa
         +SGVzPcUPcZdbE4uDkH4N7eSTxwPQso8O92GCXFYNoi9BGlwRRKKLlfT6XYdjT+ERpgX
         Mh9w==
X-Gm-Message-State: AOJu0YxAi+qcuFkczQkuqg9gj2e1+5+lYoJTeYKWAapp+27j21KezEkl
	RKhmmTRmcEuQEEwB9c129uFh+IL7ywd7WQ==
X-Google-Smtp-Source: AGHT+IEjNToRxgw9nShUjPn8KuIT4SgjhM1xOslW2JtRdjLTz9PVVr6v+9Nx51Fkr36WQYPXiuV3Kw==
X-Received: by 2002:a05:600c:138a:b0:40e:4800:c91f with SMTP id u10-20020a05600c138a00b0040e4800c91fmr4422019wmf.9.1705472267266;
        Tue, 16 Jan 2024 22:17:47 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c314500b0040e5e21cd7bsm21036545wmo.11.2024.01.16.22.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 22:17:46 -0800 (PST)
Date: Wed, 17 Jan 2024 09:17:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hoorad Farrokh <hourrad.f@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: prism2mgmt: Removed unnecessary parentheses in
 if statment
Message-ID: <1f875e5c-34ad-44bf-bcaf-241ec393a6e9@moroto.mountain>
References: <so663sd33rgvgzufcxe4oc666os2gq5nrdinqaqquksrkvnr3c@odkxhcxhb3ux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <so663sd33rgvgzufcxe4oc666os2gq5nrdinqaqquksrkvnr3c@odkxhcxhb3ux>

On Wed, Jan 17, 2024 at 07:11:17PM +1300, Hoorad Farrokh wrote:
> Fixed a Linux coding style problem.
> 
> Reported by checkpatch:
> 
> CHECK: Unnecessary parentheses around 'msg->prismheader.status ==
>                      P80211ENUM_msgitem_status_data_ok'
> 
> Signed-off-by: Hoorad Farrokh <hourrad.f@gmail.com>

Just ignore these warnings.

https://lore.kernel.org/all/?q=prism2mgmt_wlansniff+Unnecessary+parentheses

regards,
dan carpenter


