Return-Path: <linux-kernel+bounces-52567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5378499C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4931C220B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE94F1B944;
	Mon,  5 Feb 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="D75Ygvr6"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6541AADB
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134873; cv=none; b=VOeB2kBPSohzoXTatREuILbtvzmmvTulYXjwp7n7XR6tyWaUBNdPtiCJEkyt69LSaW/ibU4RNltqjUxu1dR+qXzc+CWvb1IgetQ+oCDVLBhp7D0N3beLO+v4eyMHm7s/FtblyA//wg7fiquP1KUdw4bMUcX0QFO4KB8yFtL3Toc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134873; c=relaxed/simple;
	bh=nYYHVcoHYUdNn+h1ISBs7vmeauh5+//ep94UgTFIkZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGZUriSFbMFXredJ2Ii4pEEQ+/YhSsw86WQpYoy8fI6+B457xZ0TKjQnzYrsaQXJkJF5zDRHW6vUY7f7zSODLksG4fjgHWhxOnWexmB81mhDGC4WPjlh7yH63Cx5u4uQUAkZPce1XIP9xm4p17ydA9Wpt23GIAs2KLEG1Xs2UUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=D75Ygvr6 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d73066880eso37348885ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707134871; x=1707739671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=okcATfsqmM9HdbdR1ZaKAA33LmgfKaKFBGgMV86AS0c=;
        b=jBJHTm8r566ZTGUlCukIcZpSZZKp39+9rjsXQLVN1LrYuIQiaqyLkyPXrkJxq9za43
         rLN4dELl6HxGM+1O+fOIZEbcaMxdI2GK3JxzyoZmYEJ8Nv1xL/QpXMuvIyNF1W0Z8usO
         rFqjas6nnlHhBZuOhmLvT+MMNwhBTqil2MgxoL2qcdzSre3QwBCGcnehOUSlc3+SgZis
         Npnt5aP9uLXYMUZaKPpuAvHA1jHqwQ8vlC91tRQHdzJB146Q1gukQJ2TK0j/Te98A+yL
         YHNhnpXN9oDY72Mh1mL0zX0adKuiOsQ+LkE/d1KMECd1bYGwXaN7cRvStvB3huyfaHCL
         /+OA==
X-Gm-Message-State: AOJu0YwScw50+GV/bypqRhc5Ro0VKNhkjqbyYaMHx89ZPVrdQ/KwLdXR
	Kg1CC9EToaMmBm+jQzr8SkcrTolXfMYgcnGIGghuMvz8iT9CUOeQl9xghIcTcEGiEw==
X-Google-Smtp-Source: AGHT+IFxWHHdGbNMjLSmN4GD9YfAWIeS+hPxkVLgb8d9M27wPDCqlExpu8DXpE2CWyigM2ykSRp0zw==
X-Received: by 2002:a17:902:f68a:b0:1d9:a2d5:a113 with SMTP id l10-20020a170902f68a00b001d9a2d5a113mr6824734plg.67.1707134870767;
        Mon, 05 Feb 2024 04:07:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUB1kbsydGTq8nzYJchFqkir7awN4E1JkeFqPE4cun8d2klYa1/KnJnwWkmkV1oVjR9ewIu00A4oUItHn2wMcxECKmnkZ72YXHXgw==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001d752c4f36asm6128400pld.78.2024.02.05.04.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:07:50 -0800 (PST)
Date: Mon, 5 Feb 2024 09:08:20 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707134868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=okcATfsqmM9HdbdR1ZaKAA33LmgfKaKFBGgMV86AS0c=;
	b=D75Ygvr6jm39ZXZEeINvuygQHHZJyH2e9QeIB91q1FsMOQfWsB0TcXk8k6DdpeAUOpCyav
	NYEtLUzqZpuEYUvvkunAcYzefuduqpuOT99H8P5ddzqCkBtGhvxoqA15WlrDJtBIwOb918
	50T/TZhtJThF0toWQAhjLM3Tc2taIPPJKUhvxwk7UujZG1TYSECJHHNZpZgs38vljh91zH
	gQ+5VrYollTb7/24ujRtzLKhwMnIGASIEiRlHzuU6euAVfbyRfYfEajVTW59HHyBfM0wj/
	rJNsMw+1xPPjnapl8FyzXEjrVDsR7NycIwtulThU+Pk2qZAR03O6oMfHfY4ZyQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] w1: make w1_bus_type const
Message-ID: <hk2w5pow3kqhw3vk5hlgeoy3dntbujb2s2xup2vkivtabwwb2k@do5ud3tj33jj>
References: <20240204-bus_cleanup-w1-v1-1-a0f4c84d7db3@marliere.net>
 <80d80422-139a-4bfe-9d8b-4ef193e72d8b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d80422-139a-4bfe-9d8b-4ef193e72d8b@linaro.org>

On  5 Feb 08:34, Krzysztof Kozlowski wrote:
> On 04/02/2024 21:55, Ricardo B. Marliere wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> 
> Does "Now" means some dependency on other patches?

Hi Krzysztof!

Please check:
https://lore.kernel.org/all/1305850262-9575-5-git-send-email-gregkh@suse.de/

You can apply as is.

Thanks for reviewing,
-	Ricardo


> 
> > move the w1_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> 
> Best regards,
> Krzysztof
> 

