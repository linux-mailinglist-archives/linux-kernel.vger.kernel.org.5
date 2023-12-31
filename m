Return-Path: <linux-kernel+bounces-13750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5D4820BFF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 17:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31071C21608
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661C38F42;
	Sun, 31 Dec 2023 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0hD9vUB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7008483;
	Sun, 31 Dec 2023 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d427518d52so41947125ad.0;
        Sun, 31 Dec 2023 08:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704040436; x=1704645236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoRqjvUgh8JU685KBdBRezA/nzCz/FKUz4z7zC2ePDk=;
        b=D0hD9vUBKcfN/Dcm5eWH032uznEs5Fq2KNSF5RlUZays70GVyyTu+rbPTXMDTTmNim
         csAwBqYW/o05yPqlUe69ZTziR8+EKOY6WUO203aZL0TMsuUeGUJiDxImBdWAEWzdSFaW
         OshIDnffc81JpRy75bRO4RY0GtBgC55v6atmRxZ58mjGGc3gsvyURBXpT+AvA+VFSD9y
         j3sv/P3OEqqD4gGzuzKfkYDAjuA9OijjosIKswIJmpughSCynPRQs8KvfUidZao77cwZ
         w/N+tWc38dv2MACW7APbX+T3xIocR3aPXrCJ3my/L2NTEshcAZaCYQNgThyUDfyZ+sKf
         gJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704040436; x=1704645236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoRqjvUgh8JU685KBdBRezA/nzCz/FKUz4z7zC2ePDk=;
        b=fovXU/Ml584pnQsVbAbiyqP68qUpZ2WODNBlS1lxahCCPwy9o2J/09mXebRFqXQOKr
         6hfQVR5Vgcdp/ctwc279ARMP7mcFJEa4UUA60fJtO7wByIKn4OxiyChGikrN/CIa93PO
         BUR0TAcycJ7WvoEUvcu8fg37fHx8nnQ8y2tbs/7ExE8Y/xH8+5T6FB0hThjg9bwJn45H
         Rl3jppwOQjX0N1suCfBNEFYAHxw1E7YSpJaruGbm0E48skhnl37Jbs58/ZZ8Wnrophcv
         BR1DpBJkBAwGgi1ziEV9DnxqelsRUxB1huX6LS1PFCo78VQ3tt+b3sXj7CLJF+xCr8Zp
         12HA==
X-Gm-Message-State: AOJu0Yyba2eGplnHxQs+a31w0sBfYkbMB5WZeuM+KSO7LdwqUWdUwRf0
	IRit/AlR48aKmwbk4bexrV8=
X-Google-Smtp-Source: AGHT+IHgL5gGyZDuBEhl14AgPpSIdkLnqgk8VZzGiZbirzfA50CFCKnOtDvmGuvntYuu7oPq+LX68A==
X-Received: by 2002:a17:902:ced2:b0:1d3:f344:6b01 with SMTP id d18-20020a170902ced200b001d3f3446b01mr17882203plg.3.1704040435686;
        Sun, 31 Dec 2023 08:33:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902b28a00b001d3dfebc05esm18812619plr.21.2023.12.31.08.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 08:33:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 31 Dec 2023 08:33:54 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/156] 6.6.9-rc1 review
Message-ID: <15cdead7-b9bd-4531-9222-3d41d2989f7f@roeck-us.net>
References: <20231230115812.333117904@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>

On Sat, Dec 30, 2023 at 11:57:34AM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.9 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 01 Jan 2024 11:57:43 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 545 pass: 545 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

