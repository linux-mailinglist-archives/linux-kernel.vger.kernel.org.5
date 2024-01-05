Return-Path: <linux-kernel+bounces-17367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFE1824C54
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6202BB23C96
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4361FA3;
	Fri,  5 Jan 2024 01:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1ynMPpl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4195017CA;
	Fri,  5 Jan 2024 01:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9b2c8e2a4so88084b3a.0;
        Thu, 04 Jan 2024 17:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704416704; x=1705021504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dH+F/QKQH6E1OsUIiJJTGUViUA5WXNbG9cweobn3So=;
        b=G1ynMPpl0tFFvCvkPGUGfvrfcVvLDE4oKtFYzK/zCcxlTmjOpP7TYJzrz92lvGoR4D
         JgyyTUNqAs4xhZkZM/TVQd3VmSwHau2ZPqPZpF7oqmLWEu5TcMpkZmy6K+kM5Vmpp5CH
         5xjbEQ9XCJSQt7yIZUhG7KQ1YthK+jsECUVFnc3jHOg1jzXwJRyPGWnrQjVLoPqgu9CD
         c/IIhmL5mJvzhImSzr1CX26SUFxaQsFI7qXN+HaC9X9/3fx0WXShy9OQi6F6HYN5Xl+y
         Z+yQIsCknZNZYQ9jnC5yQiciX4CE9TfXBLFsuj2wqkrkbGAfCVgj63MKInXUr0WxFflj
         O/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704416704; x=1705021504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dH+F/QKQH6E1OsUIiJJTGUViUA5WXNbG9cweobn3So=;
        b=jnlFhT+Mwo1wn9hxOPo7IhZZSScIiAijXB6RIoNCTrr0pheTQ7GQbGBLjwg43KwT7t
         mFTzFKdQUJJLu+vRzNYTHzaLjsSJYLcJvJ2HE6lt6cx5RmBvCjbFIIXx98NPJzSPqZRu
         AAr1wbCdEnQuyywKaRMEbNeJqDIwOAQ7bn4TfzHlHQuLRiuhFe1sNVCn6aK4uINdTMZb
         YAhnyLdjEsjIv/f81TA3aBLnS0EwYBP+c9vF2hnQ/AS9pw7U7TgzD2lXfHxubDzC3V2z
         ZNs0/83Avp4Rz+WBTCtPZ0VFlB7Z8ujK8N+bUjvMfnWnvFlY0r2zB7ODBqW3r0tVSZdc
         2ncA==
X-Gm-Message-State: AOJu0YyRSpcR+8hxVUSwirgCtBfEZ2+YFeWhwvR3z7Xh8yXH9cOsNLN2
	loK8fkWJJJKlfWFdo3d0/is=
X-Google-Smtp-Source: AGHT+IHJ0ADFw6/58wTNB8QD7JMLXWQZA+eOoK9PfRVDPGM4RVjsunisoFAKyY/PwIu53W0h04dHYA==
X-Received: by 2002:a05:6a20:6320:b0:196:1b73:3bbe with SMTP id h32-20020a056a20632000b001961b733bbemr1148206pzf.63.1704416704564;
        Thu, 04 Jan 2024 17:05:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j5-20020a056a00174500b006da8f6650a2sm258580pfc.155.2024.01.04.17.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 17:05:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Jan 2024 17:05:03 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 5.15 00/95] 5.15.146-rc1 review
Message-ID: <b5532cee-6e11-45b4-9157-f2c3de331e95@roeck-us.net>
References: <20240103164853.921194838@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103164853.921194838@linuxfoundation.org>

On Wed, Jan 03, 2024 at 05:54:08PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.146 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 524 pass: 524 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

