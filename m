Return-Path: <linux-kernel+bounces-21277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62F5828CEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F874287708
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262DA3C6A4;
	Tue,  9 Jan 2024 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di825C1f"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B80863B5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3e84fded7so16824285ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704826614; x=1705431414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2jPr+SDh04cibZ+Jz/fbZ1baj85lZM6byocbkZfLXFo=;
        b=di825C1fp97/FntKCigeY9Isf1JZUfq6Fo6zQUkMp0gPSTYgdjJ2uqdjzKo1OdEEnR
         TVcCg5BiMJ65LQaDzIDg7gyjnG84qf94q4ru7OnV476MF+pU2yHABGP4AOK7W+aMPhaW
         CJLguhMu1GMgm3CWZL9NULuAUp0Rcv0YZZvn1QtM1nVBwc5oOtUH5NdlV/AnQ6THjc90
         LWQeJc4Zh291wxxyjnNzMzvzz5RjeM6nVO9tsoGNe3Yesd3pNXHF+wMN2rrxf7b8tvAj
         arqYP2qiw7omRVDPT8A87Tr+O6tzuRApBbn9VOLIgrjhy5z9RqkGMzL/iKdJBr8UkUXK
         leKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704826614; x=1705431414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jPr+SDh04cibZ+Jz/fbZ1baj85lZM6byocbkZfLXFo=;
        b=rXGrKMj6Nrcj347XWbwCHZ1pqW7lZq8MNR7Zdxjg759tDqqpyZCeTJIVMpFMPxibHB
         LKdofLlAH71MNTsHAec8XYaWdiV/V2SsOVXxzo5yO1/rNZLDw9eyeEzJO6OvifqKSJKf
         MRYhbA23oskk+wE3f/6KD2d6tjBIU5CJZVBs4rrTRIezGuhLbQ7N2JCLzkn3cxxI2883
         43d05m3BL8Y9ebVqMUBzBF30PXFBGJY7mwPa+fJWLs2Bo0poAzJhbUzQUBqWTE1dxahZ
         7Z8Ahm225TFSEjNtHl8bAi9ugtbgvwYL0kiNSrgw3p+1GIoEcrnL+g9gt3yFE5GnzHAq
         Qwag==
X-Gm-Message-State: AOJu0YxTVW1gykYBj6qXY3H440b4cj2OZELLlaBhYQwXv9zY5mOWyOv6
	QDvvaP8P4PAONZzjs/grAeqgDYb1MQo=
X-Google-Smtp-Source: AGHT+IE1w0FHYtfTGUzm/jTiCE5Ev+DGOi60RZ7MAmkeZ2qAKAHzsDJ3Acbhaa6gEC0nWNIsQtF+Ng==
X-Received: by 2002:a17:903:2654:b0:1d4:abc8:8934 with SMTP id je20-20020a170903265400b001d4abc88934mr3025255plb.42.1704826614295;
        Tue, 09 Jan 2024 10:56:54 -0800 (PST)
Received: from mgyee-VirtualBox ([47.152.33.114])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902b40800b001d54c41cf84sm2124992plr.63.2024.01.09.10.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:56:53 -0800 (PST)
Date: Tue, 9 Jan 2024 10:56:51 -0800
From: Matthias Yee <mgyee9@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: fixed check alignment of open
 parenthesis in card.c
Message-ID: <ZZ2W85ap2aMBDi8F@mgyee-VirtualBox>
References: <20240109063618.2810-1-mgyee9@gmail.com>
 <cea37e85-cc21-498a-a09e-cfdaf7921844@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cea37e85-cc21-498a-a09e-cfdaf7921844@moroto.mountain>

On Tue, Jan 09, 2024 at 11:22:42AM +0300, Dan Carpenter wrote:
> On Mon, Jan 08, 2024 at 10:36:19PM -0800, Matthias Yee wrote:
> > This patch adjusts whitespace to fix the checkpatch warning Alignment Should Match Open Parenthesis.
> > 
> 
> Line wrap your commit message at 75 characters, and also run checkpatch.pl
> on your patches.  Otherwise it's okay by me.
> 

Sounds good, will do. However, checkpatch.pl gives an avoid CamelCase
warning. Is it okay to ignore if I am only focusing on the parenthesis
alignment warning in this patch?

thanks,
matthias

