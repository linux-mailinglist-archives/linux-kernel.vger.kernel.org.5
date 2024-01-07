Return-Path: <linux-kernel+bounces-18924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6FF82652D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C521C215BD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558BD13AE6;
	Sun,  7 Jan 2024 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFeBvTtD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3904113AD5
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-336788cb261so1123734f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 08:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704645971; x=1705250771; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=spp2negAoDE91Yk0CKaN80jgjnsO3+MueAKeHJ0K3J8=;
        b=SFeBvTtDFGkLgstgTtvhvP+oq5MhqtFeo5ZEK7aLqXWkwPqJudKhUgNIKtZU9wqrIn
         Vs3GcZB8jnxsplvH10E0JpgCCVswOcgZbP+eQxgJw8OASbsDWD+S2aeMXtFwUTlLrJ8v
         PEBQEKxKI8U5zje+kpNnZn7E6ZiPzC18tLj1p5z4lphw0NuMD5QFj2DA4flRYUxPuV5I
         SffUh7Z+7OU7+cMAvI91lZELgU56NJg6vwKfuHWL/yofMHWow9idDm0EuluQyU13ZBuG
         Mc32XCc1CmKCGS26vGjqJLPpUVkc51ZF6AMW7LpLjinF/WLpkD+atukEAbAv7rkH8PbC
         uzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704645971; x=1705250771;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spp2negAoDE91Yk0CKaN80jgjnsO3+MueAKeHJ0K3J8=;
        b=NyrC24cx7LN0bjWuN0d+ENhC/ab3pCyABHuyp+Dy5xCPC9gdjyUTHsfwbTZB3uTR8N
         RUiMWjS62NQ0Ex+/R0Vrkt5EuHaZSnghH4kW6tBUIZdMtJgI0g0v9FWWNDgAWcEo/hm7
         NlcFMQa3qKqaV24rF+aWWwKTmP0qNrdGucVEJLLTGxxIB+pbrmCC08FbwmSKTecPz6pJ
         953Cp/i5o4qnZZ5VNlY5q6IcPKuklEhfC6b1Kz1/J1EfPhlREK4h75d944Ghu43ZRsnN
         xDvLeYc1ZEsEBpCtkRhh16aNuFAESR2RF1Ka5t4iIRFrhFLIwgIRiBC3jNlv3zaptJXo
         OzNw==
X-Gm-Message-State: AOJu0YyfvstZwEKI75xD6nqdfZ8KvN/gXHsjGxVk3s/e3MQ9ywYeZ4LQ
	tSI99p8hEHS6LAZJ0wxi3YGsUQc3rw==
X-Google-Smtp-Source: AGHT+IFJevYv44/dRUU2ofTCb7feZrNp8BTU230fVcjBlOG47rFgBq2708qj+2PHJl3OxMwzHcMLKQ==
X-Received: by 2002:a5d:690d:0:b0:336:e366:471 with SMTP id t13-20020a5d690d000000b00336e3660471mr1225561wru.58.1704645971108;
        Sun, 07 Jan 2024 08:46:11 -0800 (PST)
Received: from p183 ([46.53.248.125])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d4cd1000000b00336a0c083easm5685483wrt.53.2024.01.07.08.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 08:46:10 -0800 (PST)
Date: Sun, 7 Jan 2024 19:46:08 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Yukai Wu <wuyukai0403@qq.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Remove unnecessary casts in init_64.c
Message-ID: <b1abc6a9-91f4-48a3-b096-239ea65f3256@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> - pgd = (pgd_t *)page_address(page) + pgd_index(addr);
> + pgd = page_address(page) + pgd_index(addr);

Please learn C operator precedence rules before touching this code.

> - pgd = (pgd_t *)page_address(page) + pgd_index(addr);
> + pgd = page_address(page) + pgd_index(addr);

