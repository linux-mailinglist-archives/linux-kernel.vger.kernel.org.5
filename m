Return-Path: <linux-kernel+bounces-17363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B78824C4C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE0C1F233E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C8E1874;
	Fri,  5 Jan 2024 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaXTFf9w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352151FB2;
	Fri,  5 Jan 2024 01:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d426ad4433so7456295ad.0;
        Thu, 04 Jan 2024 17:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704416585; x=1705021385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+E1EN+rUnjR39IpeK1CRBGdfzTUqlP4IkUwFqZSxS0=;
        b=GaXTFf9wnDjTmyQijPzTe3QV6Mv5/Bp8L10VIDDyFCjkBoaOFqwD+txBnXwEIjD6Vi
         FxXGhHNdbgZiJt74X++CqgBA3+wIrjK/ARaTbRthDxMdD5jc1EC/yarUek04Hmxa0GIa
         CKUz+A/3+DAnHjPesFQplAMR2Yusg/Y3/7uJ4lqQY8vCTMDD3FQxG+by6/liY3umyFKs
         l0l+6r9LisCrlFPN1cOEHTwVRUGZ/9L9qSuhpKbXMN2DyWiFDpAWKIKATOq44nlZPY+E
         79jK2g/GbCBM5QCjmIP2UQKxfPq4pwFXCLRC18LtCBQfzz9K5wHeWPl2n/IxuD+DuaRy
         O8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704416585; x=1705021385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+E1EN+rUnjR39IpeK1CRBGdfzTUqlP4IkUwFqZSxS0=;
        b=WpP7cJFlJSz2zpukyJIo/hYql1lUOT4Xv0bNofbtY+url3Mzpqd1IcxwdKFVqjVo5N
         bq6/a8NGRIXsYcw1buD0rZY4ntor6YKhGT2tZlQ9r8HDPcj564DFmZVQALRigPztWl4V
         i0BwHr3cEEfi+UwQLmCM98P3AFLw2EOgFxJfcdeouYFgbzlJQwzWxxdrbkm8xw556WGT
         y/xGMa6qj0zrXRfxApq5+zs2WFpupiFXtUZ+JDkt3h1xt3AXiATR7fYoAc4fx0ezN28N
         s4zkqOWto5eo1LvyehqU10T28px3Kv/2MVlDLKyRHJE4W3RAvn5K9+DhZ0zw9Kes9Ur/
         6yFA==
X-Gm-Message-State: AOJu0YyukMPL78WAojUZAe8yi0tL0VY5OiSYX4lvm3wa63YupiHpO646
	EZFy5i9BDwrBaGWGwlynKuQ=
X-Google-Smtp-Source: AGHT+IEDYk4x1UpqQnc07Rpd0SOWtPQYdpWlUa3NF1yl+hUMq6LSTxKcQMkj3gsk66xJNT8YjhQvRg==
X-Received: by 2002:a17:902:a50b:b0:1d3:f203:6110 with SMTP id s11-20020a170902a50b00b001d3f2036110mr1087089plq.75.1704416585175;
        Thu, 04 Jan 2024 17:03:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cp5-20020a170902e78500b001d04d730687sm221803plb.103.2024.01.04.17.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 17:03:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Jan 2024 17:03:03 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 00/75] 5.10.206-rc1 review
Message-ID: <09e8374e-2dd6-41dc-8b33-f194d9590e74@roeck-us.net>
References: <20240103164842.953224409@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103164842.953224409@linuxfoundation.org>

On Wed, Jan 03, 2024 at 05:54:41PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.206 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 495 pass: 495 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

