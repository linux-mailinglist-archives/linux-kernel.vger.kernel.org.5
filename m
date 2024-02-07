Return-Path: <linux-kernel+bounces-57233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D14D484D567
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2111F2B4AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63B81369B9;
	Wed,  7 Feb 2024 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rlkmi2uf"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B93912BEA1;
	Wed,  7 Feb 2024 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341518; cv=none; b=KYHrLZIzmsywVdZviT4MX0af80Z/k2VPDOI1vd2GmmJHNc4rYKj4RA7e3qkOzX5+F1ahIVrDMO43PJQEc2icO/dZrpwoF5dfLykn4z0NWj8dh5X7o+KQhJGOTGd86UlpadX3oVmhQ298pyqc+REqeo3rjmcr1QaAezK9VOmfm44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341518; c=relaxed/simple;
	bh=gqjZETUL6PAgOvbJQT7MF+wa+Ca8B6h5fNnUMQjtPZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8qvDEpKHjlrKUFjdz45uVTrWFx5YfxCLp+vjG4h/2bvQ5G/MC7DwTmbPj2pMgotNl2lWtG21tb2rNQFm5trpmdd3WCPdpka/GtxXBybbz43CeUFDH3MviHoQgvHzQ3cbL6AUmZUMmo/0CAGUtTdXFTzoD4MhkNNmGJetfZ3TqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rlkmi2uf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d95d67ff45so9362735ad.2;
        Wed, 07 Feb 2024 13:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707341515; x=1707946315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g93e1bBzvkihfZLg20AxxWUEZDEf5mUGENjPC73ozn0=;
        b=Rlkmi2uf/6PsXi1NWrRTm9delWf6ZHl2ancW0/yTe4KMXqrY98LjRUOyPhDoTsGhSt
         3xFDL7ieytY6rN5Tsz6uHDH5F2Xe7TJuxfJz1WzCjYcyt+7rs41I1RI6CB9n2zv+SXIi
         +SmXylZ+Oz51PozFC4QDhlv1Ztkj+ZeYMhIVdd6w8YOwkj91Kzx52ojfAGIBQ6wvi6hB
         SmPqLsBbxEdKXykM+IULawosM0XQPCLB9vkpHV7jbZpaO3bWJDj3l8IGt0h9ykBjx0dg
         5fPsXy9qqb9ojOQ7IHZxU6p2wZXQjQVEiw45t9zINPWL+laW2/u8ULE/m5xLtitzHDQt
         MLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707341515; x=1707946315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g93e1bBzvkihfZLg20AxxWUEZDEf5mUGENjPC73ozn0=;
        b=IU3GF7X+3kBrdzYtKrkbXKox/m3/p/holsag+UMmFEjqL0oGUwVqek9hHB8zD+xMEn
         SPBBWBWw8QHr3rrinXA9D5ATejASxEtAuZrWmns+DovciYf3cNkAP5sihl0ZTX1pHonU
         oqh1Bd3HqI+0zLUl6db3DqKrU0zcUQjWkwt8rF3lWKi6SYhaZPOMewBrqf3mnLAEI4o1
         zjhLzMS/Oc83qPQWVA/c2M3TYDiSI+0X2JVgVNdOwG7a2C6UCHCo8HMSBKPswHC1M1PD
         JCBCzL3C8HZP5YURS2cpSWn4Y6Pn3Lygkms9Dq8nBERjCPt/aKRijCXO5IMCIJt4HBBo
         Eoxw==
X-Gm-Message-State: AOJu0YyjIuiHzoWAuDD2Ig2xUbncy4vh8iXzMUTEe3V5kDIQe4I9m2BU
	Mh7o5zkKFyVEn8WcynUlYvIU6HfqCa6tzEfg1+TzFumluAUg3fvx
X-Google-Smtp-Source: AGHT+IFiGChlBRIhV9nBYZfP5296dQ/+pbvlrHhYAi0+PZt0oOqX4llfnT6PQPja6eBh7FBUpRMb5g==
X-Received: by 2002:a17:90a:d790:b0:295:f9a5:f8f0 with SMTP id z16-20020a17090ad79000b00295f9a5f8f0mr3955820pju.10.1707341515533;
        Wed, 07 Feb 2024 13:31:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU86gaXtfpoUq1hmDDsnfJGYAsnLrWjuN1MVjn1BvSwaDNf5X3AtUBvEvVu80JpZrgBMNyp9Q3CosaGrm/FrrmMHSqlTtxlIUNzGHpor8dnouo1clsjF5QatzOs8ZpD3pyIOpGY0GXzZpBSJc6qk3avtF60VsrdlcjVSw5VzoaRgjZGwQ==
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kr14-20020a170903080e00b001d9537cf238sm1949141plb.295.2024.02.07.13.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:31:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 7 Feb 2024 13:31:52 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: chipcap2: fix uninitialized variable in
 cc2_get_reg_val()
Message-ID: <9d5409a6-b309-4d71-8658-52589eedb28b@roeck-us.net>
References: <20240207-chipcap2_init_vars-v1-0-08cafe43e20e@gmail.com>
 <20240207-chipcap2_init_vars-v1-1-08cafe43e20e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207-chipcap2_init_vars-v1-1-08cafe43e20e@gmail.com>

On Wed, Feb 07, 2024 at 10:17:08PM +0100, Javier Carrasco wrote:
> The reg_val variable in cc2_get_reg_val() might be used without a known
> value if cc2_read_reg() fails. That leads to a useless data conversion
> because the returned error means the read operation failed and the data is
> not relevant.
> 
> That makes its initial value irrelevant as well, so skip the data
> conversion instead. If no error happens, a value is assigned to reg_val
> and the data conversion is required.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-hwmon/294e4634-89d4-415e-a723-b208d8770d7c@gmail.com/T/#t
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

