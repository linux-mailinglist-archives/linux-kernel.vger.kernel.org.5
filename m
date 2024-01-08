Return-Path: <linux-kernel+bounces-19762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4DD827303
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0081F246E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9FD4F893;
	Mon,  8 Jan 2024 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmr+mC9q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DD24C623;
	Mon,  8 Jan 2024 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28ca8a37adeso1726784a91.3;
        Mon, 08 Jan 2024 07:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704727615; x=1705332415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XPv1Ep5KEmoiH0/ap4wgz6gXJwNfptUMbkgWqOQLAk=;
        b=Gmr+mC9qX4gPSucVi6k1xqrruFwol6tbgaUkTQVIOXxV6t1QHo1pnYlNDcQABU66mS
         5V6ATekRDsm6asgZg02eE4m4diT2h6uJ9ZNVUru9EmCW2HXQGDfZchUgy34rcxwyaGcQ
         FtH8Y1ig/QBegLkus4BdJxQc5yFOYj/eKn2BfDdjG+TZhcMVa5t0/pZe5q+dAG0hViFJ
         8aze3YufD8gmKrLl3XDbTZ4JcPtsX+sJ0EexVcNNRnJdV3Ow61AYNNBFiKxQE+Rxiz5+
         ogNv7mc32/G1t7ORHzt/xRZgxykutjqVmwNE7q81bMYjCvXHZu2XQKvavdfrN/bhizVT
         efiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704727615; x=1705332415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XPv1Ep5KEmoiH0/ap4wgz6gXJwNfptUMbkgWqOQLAk=;
        b=E3IGg56vt8lupVcXUuV7PgzPUN9BwZ7EcgbHnuafLl9RoX8yRaHz0IwMq+vI2SU9q9
         /CGhX/usPZBtMT1u9whY7MLIAX7mdHQa469ra8L7xTmXQ85cqJDLrKpz2RHt1o+xXN28
         Gv9wrPI1j3KuesSOjA764HTrqY8vTUlCIrcNhcYH/l8zRh02qN0VRSYcEhKDDZbLbYbn
         A3ihpCnxyiR+/X75e5CfLE4lwN65JlR82BUC87UN1Ldf4Kody1Mq1P75QKVoVcMMwVhH
         WGbDZZRb4D/0DKj+OhXkOXR/OzsV7C0pQb94o5vetN4mA80wtVPntC86L6jy4SZf9XkU
         9Sww==
X-Gm-Message-State: AOJu0Yxm/rucgwh/MOmYRML2JdBzzf/vTNDFdwF75rfe5zJTkLjunPY9
	zKZw+s5FSY2Ml1L95LXljoY=
X-Google-Smtp-Source: AGHT+IHWAMECPgnsIz1/WTetDoIVwXbIQJfi/+tTQ/Fk803tGhdNoUIAXwXiFs8FVuyMcujIraxoKw==
X-Received: by 2002:a17:90a:a095:b0:286:a089:c3dd with SMTP id r21-20020a17090aa09500b00286a089c3ddmr1834053pjp.62.1704727614698;
        Mon, 08 Jan 2024 07:26:54 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id sj8-20020a17090b2d8800b0028c95804922sm6632836pjb.51.2024.01.08.07.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 07:26:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 8 Jan 2024 07:26:52 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (lm75) Fix tmp112 default config
Message-ID: <cb7ee767-f102-452c-aa37-11febb7fda04@roeck-us.net>
References: <20240106030254.384963-1-alkuor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106030254.384963-1-alkuor@gmail.com>

On Fri, Jan 05, 2024 at 10:02:53PM -0500, Abdel Alkuor wrote:
> Set tmp112 conversion rate to 8 HZ and 12-bit mode.
> 
> Fixes: 35cd18048542 ("hwmon: (lm75) Aproximate sample times to data-sheet values")
> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>

Applied.

Thanks,
Guenter

