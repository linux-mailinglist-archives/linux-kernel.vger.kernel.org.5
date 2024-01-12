Return-Path: <linux-kernel+bounces-24373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B38A82BBB0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A46C9B22B77
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516DF5D735;
	Fri, 12 Jan 2024 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv/C6LaG"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BE25EE74;
	Fri, 12 Jan 2024 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so4361445a12.1;
        Thu, 11 Jan 2024 23:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705044133; x=1705648933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyErejakExwmG9pfHn4z3Nqa6vi4ull1yxBGIBdvZUI=;
        b=Vv/C6LaGxpZjugpj9A3aaIELC31kDkqD9s+zARyO8v+XuOQn6Zy3UdgbWNjsm0579C
         45zg0Yq3zuvwZnmNtzfs+wDvRMZyvTjCnnAd6CQ8Cl3GhGmDqWU8Q8PxhWcRaj98bMT/
         uqUi+jAZeNrGwj5PABXqKnQFYVeUl4KuFeV4Q4d54YTZcdsU6j+O5neNnm3SHn9FlsSW
         Szs24R6l+H9ZuX2/nkTlZONR0QaFAIeLZgXSS6iQyDVc7IsnvYzRLxyoYdigMOKgSCpy
         o3c4/BIV3s60nO8vbwfwsbdHuJcA42JSX4X74eCMg9FapIRCAKAGiu30u8vwl2pbB9aK
         zrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705044133; x=1705648933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WyErejakExwmG9pfHn4z3Nqa6vi4ull1yxBGIBdvZUI=;
        b=TIVcinKpnmA54gnS2CFIWcKZmVCf3YAARYHqgALFCRXGLk/LeI+FM4WUzaVsrYpZqj
         aJiTYuBWJhjJ0x7yUJe6U8wjmIgH29SbGTgMEbFq2BrPtDQc8ndGfJsxMhhfr8/uQx00
         8GJnGIdvLJ6/7UzZ02n2DCMAhSPQIl4biK6cwg9UIYTp7vLJ8tAuIshi6YlBiD5Fw6fC
         0cLwNYq2EAWo3MrKTDjBmaq9kgu5VgxeyE2symRTT+vMat8GP4DdWpGkZrRKVq1xv29o
         Ex+TiRyp/cbCdQQ5bGbx0idq5lgnB7y9i457Oz3BBmCVr7+f4KtAYfIu7LJlghHURg0+
         ifiA==
X-Gm-Message-State: AOJu0YzIMllVAfXuhEvtcbYSQvusJ0srVLdFI8eNFiwPXNX52FDX3Nsw
	tPldACmQbdL+8HiCqTeT/e0=
X-Google-Smtp-Source: AGHT+IHwwgR9e97IdRC2ytr2WXSBi9QeOem5DU/Z8kAmpNRwDCvlXUWQye4rEnFTs5XEMB7ZUsIHgA==
X-Received: by 2002:a05:6a20:6a0c:b0:19a:3276:fa48 with SMTP id p12-20020a056a206a0c00b0019a3276fa48mr920793pzk.16.1705044133524;
        Thu, 11 Jan 2024 23:22:13 -0800 (PST)
Received: from [10.193.226.49] ([106.39.42.235])
        by smtp.gmail.com with ESMTPSA id ko20-20020a056a00461400b006da13bc46c0sm2609715pfb.171.2024.01.11.23.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 23:22:13 -0800 (PST)
Message-ID: <1469074f-3e5d-47b4-85b2-be0802e09eaf@gmail.com>
Date: Fri, 12 Jan 2024 15:22:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] md/raid5: fix atomicity violation in raid5_cache_count
To: Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@outlook.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240111082704.7503-1-2045gemini@gmail.com>
 <f4f19e58-f078-0e07-73e9-100f126f0d25@huaweicloud.com>
From: Gui-Dong Han <2045gemini@gmail.com>
In-Reply-To: <f4f19e58-f078-0e07-73e9-100f126f0d25@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Fixed in the patch v4!
Thank you for helpful advice.

Thanks,
Han


