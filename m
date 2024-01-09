Return-Path: <linux-kernel+bounces-20546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E45828075
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCB61F21D75
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B2929419;
	Tue,  9 Jan 2024 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EydCsM9E"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE80625756
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d5aefcc2fso30284785e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 00:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704788566; x=1705393366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RkCvYd5950mTrHdIV/MAXFZQdz85NWu1PStSMrB5EH4=;
        b=EydCsM9EqdNaI/ywRN7BtF+ud3wE4FWe+gxk0GABMc2S0NIW2agDSLuVy0yH+rNtBJ
         +1gu51vvuSwhP6gLXv2ak8zVXAvMoBATFuLmjCLggFUudBqZip7zuiKWh6iLT1F5zZkm
         aY9z7sxG/4me/BQrWrqPN6AdxNS62R6pXAJgXUA0on2icMOXx4f6+0SinbDL7V8N7Ax1
         yLcc9xk7Re3ALB4VIe+OntvBvSeDwdGaNZ1wHk5AjXPMDW5mSgbN2Q0FDUwyRCBGqd4l
         X6bFGnBrT3UOLAQulHKb3ruoUZVbQhizzIDBTVDB5zyHPNVzfpSwAXD702E5DwYIXu++
         msPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704788566; x=1705393366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkCvYd5950mTrHdIV/MAXFZQdz85NWu1PStSMrB5EH4=;
        b=nYhnLDdEfaQGErGajVlMQAl2WmEutLu2A1aaxOuR8Hy73kb+eRi04fruZ0iSOJ6nUo
         oiVolDMvrRDqW8MyCY9XUxlxmHqldPbyvb8RTf+9dX8nNCuoh56gWOxf0iEmtBwicOiA
         CtOnVmaKKzeY5aYs9kMYKbVAFIj3u8RhQ7eGL9vcYac5kGS9de0q8VbR9NMDNvWCa7RF
         42Zim+DbxYHjI0FV0wb7BHxm3I2PU738ABLeJxiqi7gQ3mvQOLlq7Sg1n2mBGMB4bvs5
         zZa7qQnz4etLHJOIIgjE80rfy5MmWafZRcG7jkPJj5VLndRlE80bVBM179rcdcmgaj2h
         81vw==
X-Gm-Message-State: AOJu0YxJf3lt+M5YL/SDdyS6Q5XpmPEOLrp3hWVa/zRz52PEPxKNQAhn
	JMoM7CFSRe1y8VP9tV4s0VQAii9zSpzljn6nQWvE4UABC+8=
X-Google-Smtp-Source: AGHT+IEXsKE979te2TRibhc6ZGRZCmyLFT3MKUrY3beCGOOKb/lThn1WsQOhRrpexVi+V89VsDhUqA==
X-Received: by 2002:a05:600c:19d4:b0:40d:4e28:43e8 with SMTP id u20-20020a05600c19d400b0040d4e2843e8mr2408207wmq.167.1704788565926;
        Tue, 09 Jan 2024 00:22:45 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id be10-20020a05600c1e8a00b0040e49994116sm4442375wmb.14.2024.01.09.00.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 00:22:45 -0800 (PST)
Date: Tue, 9 Jan 2024 11:22:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthias Yee <mgyee9@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: fixed check alignment of open
 parenthesis in card.c
Message-ID: <cea37e85-cc21-498a-a09e-cfdaf7921844@moroto.mountain>
References: <20240109063618.2810-1-mgyee9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109063618.2810-1-mgyee9@gmail.com>

On Mon, Jan 08, 2024 at 10:36:19PM -0800, Matthias Yee wrote:
> This patch adjusts whitespace to fix the checkpatch warning Alignment Should Match Open Parenthesis.
> 

Line wrap your commit message at 75 characters, and also run checkpatch.pl
on your patches.  Otherwise it's okay by me.

regards,
dan carpenter


