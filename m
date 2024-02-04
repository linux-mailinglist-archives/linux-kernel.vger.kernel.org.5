Return-Path: <linux-kernel+bounces-51726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70C4848EA0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3215A280EA7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171842421E;
	Sun,  4 Feb 2024 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWVHLUTx"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3391DDD7;
	Sun,  4 Feb 2024 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058118; cv=none; b=gah6b5tffi3pkyXmDeTuvF6fwhmCwpqAJufdxNAYlt0tFzsKwEVZbJhUFfCY9C4z4kkaJlCJRPUWHK3QcNwmifXADPAX9C6N5qAuwsk4Ibd6igGsz2qXlrlngXkOpsVS0zk0ZKEnydVeRql0xzqygpe/anCUJREsw6U4hDIUkpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058118; c=relaxed/simple;
	bh=ooIi/1QGnf/ezDs7WAGx/IEPHCDl2ojz9SvsPTXAG6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hji7n7vlYuur0ym4r6Bk1Myo4JafCrzDiFyzfSZN6I+SRh4sLrg7sVhMlf/Y9pf+hwiA4+Zq0GUVEp6g6g9qHzt9EEFKrkLw9Vqg24MI3SdbVOhtsvR0BD1bMMgbMejg+F6DrbGOOoPnF7jTQJdDmRy0CG4/c76zMZ9VeEusS9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWVHLUTx; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso3165696a12.2;
        Sun, 04 Feb 2024 06:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707058116; x=1707662916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oV1quv1LSs4xKhcNKj1sxuqXbgVxSujexYb7rKSHu78=;
        b=AWVHLUTxZJSC/3rrDTp8hyO5pdY6J5rWrx0mFM36EGr7M55EYXH/XJqeDAZQtks6wm
         c/qp7BmUkktCiPBfO60cyUGMPk50bRG1WNFA+B0zb4PDWl+BoKjbVKctswMHBGatgiVx
         2vOgxQN8X1TYYwBqGOznwL268S2dkVmDWTcsFPwNZbXn2aWfcNQ0AL9G5EqxM/180LXz
         Nlwk8KFmaPHUD8UIA5k1lROhPSKLyWLThc7NI3gSmoUSyonX+uxCoe5ImnF9vXnPUsB6
         5Lsi0Tnlbm74CxATOFaLLgPBIyj1KHkYOE2KkkIZhUowZtcqaJ3KIAzMMG4b0cX5Eho1
         72jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707058116; x=1707662916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oV1quv1LSs4xKhcNKj1sxuqXbgVxSujexYb7rKSHu78=;
        b=cJ8mA6kl59pKj4kxLm2g1vXCbTJso7TkObAB8l8qdBBisazBHiwsgavSjTy6AuHD67
         r1gYX10Xp2niiHmyOHfoHp47Y0y4I8sCYsmNs02N0bnHXoJPvzAst3Jb44V/cVT8tlzo
         9HYjYTmT0IPwHzedYWFKufuDYSXd4Xt0XNqipgp2TFxEkRAvzYMJ77qQfdC0jOejz7G3
         dx+4GwEjz+8ygeB+4wMWluU0MDcFE9fsTqdgfC0D0qbuQ9fTWtZsG/kAd+c1QCAHaP1K
         gT+57i+iZrYZFzONx+UqBmd0ACdVN0kgnhpMHRp69WZGprUrpB5tv3N2frRLKB7VwJOn
         ol2g==
X-Forwarded-Encrypted: i=0; AJvYcCWILZzFiZl6rP9cu1ojtd2QwVY3OAq4YP/NjjXUCtH2il8Bk0JaJDww0k1AIm+HDPg7b79hrz8qb9kiuF5CLU8EWT9JMVKw8d8xAY2L+uJk0KT1GkG97q56d0VHw4teLeEK7gubxUyWSiU=
X-Gm-Message-State: AOJu0YzCzj/zUAISRVT0vrp7pxufRLw6PEMzwguFXYzZoRTcStgp6QOx
	iYfRIBCYp0A482IeWKP1AF9y0/4doY/fa4IU1MnVgaOim52/DxIk6+tm61+b
X-Google-Smtp-Source: AGHT+IFqHz2nJ6GZxAlel+MIPj9OpuLwTS8v+fYjpFklCLOOD/+IVY5Kh5onUu/YyaqF9Vd5XUvXwA==
X-Received: by 2002:a05:6a21:2d85:b0:19c:aaee:bb1b with SMTP id ty5-20020a056a212d8500b0019caaeebb1bmr9873310pzb.7.1707058116255;
        Sun, 04 Feb 2024 06:48:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWL33Rnh7sjElVwAOgrx0THjKCaVCviypCNq6p3SpgXzKq1lSqzSkYc4/QjO+k17/GQkWMuytUpcyGkxqFttvowgDqkw1y8ofbFYxx9muEvYITaOuV0QCcaTyhrp/0zS/BMKhJNTwS3VO+fEybX/P8ZS1Wrmt8/GDXzPAHPFnus
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b12-20020aa7810c000000b006dbdb5946d7sm4908604pfi.6.2024.02.04.06.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:48:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 4 Feb 2024 06:48:34 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Zhang Rui <rui.zhang@intel.com>
Cc: jdelvare@suse.com, fenghua.yu@intel.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 09/11] hwmon: (coretemp) Split package temp_data and
 core temp_data
Message-ID: <71c2c19e-fd9b-40d0-b261-3d95f87953b3@roeck-us.net>
References: <20240202092144.71180-1-rui.zhang@intel.com>
 <20240202092144.71180-10-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202092144.71180-10-rui.zhang@intel.com>

On Fri, Feb 02, 2024 at 05:21:42PM +0800, Zhang Rui wrote:
> Saving package temp_data and core temp_data in one array with different
> offsets is fragile.
> 
> Split them and clean up crabbed maths and macros. This also fixes a
> problem that pdata->core_data[0] was never used.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Applied.

Thanks,
Guenter

