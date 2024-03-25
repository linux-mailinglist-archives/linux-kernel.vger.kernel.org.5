Return-Path: <linux-kernel+bounces-116470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67548889F78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9871E1C36444
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E0C1386D2;
	Mon, 25 Mar 2024 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvgUnoWh"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E9214AD1C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345962; cv=none; b=VtW9JzfAEYYIGLTc4cEEJTXrr8ymUGBg6mhKh9YbUJrCpz6UFnctGz5qgVSUGcnKpgKTYvbKkdD/V5bsMQK1X1/v//uPBBUxHp54iXzWQ7upFjpMlwK4gylzwCc8RnU0ypxBQCEAFkLR/spyuj9A4/lE8cERTkAwcXCFpkeRBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345962; c=relaxed/simple;
	bh=Ca+XvmlXKeGYPksLbW1qY3T/nyJfcNvs3uDjLng276o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQ325qgiy+u2nc9tZZiVb2zuwGZ5wvb47K+VjA/ttRZHntZ8k+moTGyJ3eIPNbtioqiNVmyh2SNiGwkxuLF7N3C1FweC+aTJUKNEuumlkv78pJnJvGw4RlWfyMg9rH6x8cgWPIZYHf+4GSwcRME3MK29Raikz1J2/K9qyKJyz7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rvgUnoWh; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46a7208eedso541120866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 22:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711345959; x=1711950759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KQMqHnlXbBG6D/HNGUsVRBxdn6P40gz4MCzg880daGs=;
        b=rvgUnoWhnl62wMVlwyoUIZisp+Axa53VGkZvIX1W6RnLIgeWac+y1GzIO5azdgH6MN
         T3hh0xzSaOUYvFAupoK6Ve0WfG4eXNEVuH7tjHtJCvNzLqsOlgEWytn+fharD36oqAux
         8w+EZjluNppFVQO/qZMvjCdKNTcpQRq8XXZK3HE8PZrYG9gSyArmH35NQK4NH1W1MBWz
         vYelHQk+CeFBWxWhRe4+h88ielVSHOLcQPZDH5gTPc8euQ49CQFsm+wK8aO9E0k3qHBt
         aWF/OLjyyvn/USogRJo8zsLjb7auH39WJ8fH8sd5fUTlVhC7hUcUT3R0tcxSK+n9DOJh
         fu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711345959; x=1711950759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQMqHnlXbBG6D/HNGUsVRBxdn6P40gz4MCzg880daGs=;
        b=mtnO3PxTCqz6k6iZUhsTRlYL1sR5Cfg0KGIn4LO9npA4DW5zyHeyRT8kX0N5AbCCOG
         btc2yg0YHJmHKpxTJzbt4oFjm2oBi3W8ps/VjZZuJPMLSMstsMJXPy+tseUTJfGiS+Rc
         ZXFiU4pU02CvHa6qW11GkCnlmZ/GljWpGGTqE0iixug1J9z2mTSSF8Y5xXiLQuCII3EP
         1HpuDydFiPorrZAZf30RoPw6Ezq6Cv0STw2Cr4zPAPpV5NjSHv3eRXC4WdZ0FUsBYejm
         MHGZC0bJ8qayVI2NFcQ95N3WzOhSQX/uqCu89yMBRhBfWhZMx+uLn62dQUDcyzefaBc5
         iFbg==
X-Forwarded-Encrypted: i=1; AJvYcCVXMhQ+exHCq00BlihRDiyMtBKdbHRKM6VpTn040nUDh8VXGRnO6m8aUnbVA2jy+2DvuHqeoGTuelsgr5Or4pBk0nLXgkqu0Gvd/Ty1
X-Gm-Message-State: AOJu0Yzn0ft5xhhEvYshZrj4NHGiaHKPc/rRg/qacoDjviZ8aLFOltAI
	vL2P/8GWCZbuoeKbJXzPAGUW0l9WEJG+S2AO7YSNAcJYki/AcCCSVaQ5HkMAVj0=
X-Google-Smtp-Source: AGHT+IE+RzKFPbfOR436dI+w5MSweWdPphLKMDQVzXF5JvnyobxPPFXdyQ/VwDYCB4hZSUuYQrE7NQ==
X-Received: by 2002:a17:906:a28a:b0:a46:8d93:6c4d with SMTP id i10-20020a170906a28a00b00a468d936c4dmr3137486ejz.25.1711345958573;
        Sun, 24 Mar 2024 22:52:38 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id v22-20020a1709061dd600b00a466fccbe96sm2644067ejh.122.2024.03.24.22.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 22:52:38 -0700 (PDT)
Date: Mon, 25 Mar 2024 08:52:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shahar Avidar <ikobh7@gmail.com>
Cc: gregkh@linuxfoundation.org, elder@linaro.org,
	andriy.shevchenko@linux.intel.com, robh@kernel.org,
	parthiban.veerasooran@microchip.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: pi433: Reduce N_PI433_MINORS to conform
 with N_SPI_MINORS.
Message-ID: <662306a0-1544-4f16-81cc-68324a0c3172@moroto.mountain>
References: <20240324093201.793485-1-ikobh7@gmail.com>
 <20240324093201.793485-3-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324093201.793485-3-ikobh7@gmail.com>

On Sun, Mar 24, 2024 at 11:32:00AM +0200, Shahar Avidar wrote:
> The driver can't actually support 2^20 devices.
> Current RasPis GPIO pins can actually support only 1 device.
> Other or future platforms might support more.
> 

Why are you doing this?  Is it just a clean up or does it have some
effect on runtime?  And if it does have an effect on runtime, what does
that look like to the user?  This all needs to be in the commit message.

regards,
dan carpenter


