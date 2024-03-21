Return-Path: <linux-kernel+bounces-109696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2677D881C88
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54E2283780
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB11C3FE35;
	Thu, 21 Mar 2024 06:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu60oAlW"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6293FBAC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711003093; cv=none; b=aPVcLuWFqaYH5e17KiH/XCuX7Kxy/GkY/CZXjU7a6mHyWpUxvpaD3qkEYqwxnVrgMRq5dCjOJ0lLczN/PkWbxFIMIGW1M2gVVREUhOp90uag83D4Z754Ssi2LVZK4sP6YAObn1H4L/j4d1s+3nailjny+zcNFe5bchueyBhc5C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711003093; c=relaxed/simple;
	bh=IWzoRyiIq34RmhOn0iDV7qym3hPufd8Mn7S0DjBmBYA=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=nfBzNvaYc5aQ1CPWLAsiAkYpVEv7Cu9QXtDUqWdP6MhLFwyM1Y82X0PM/d7t1plcbxEUNj4GAYrlCuEb7vafjfbYBe0zE0AxeRJ570LLbwifQ11o2M3v5HT1CJxE2Vq164n2pkItxAV9Fp1H3rZCtY/BeKCkJf4ouS3PlhXS2BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu60oAlW; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7e0cfda8e00so61503241.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711003088; x=1711607888; darn=vger.kernel.org;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUEt2Z97b8lEWwJktqHAAwXS3vj2uI9IohvvSbiYwx0=;
        b=iu60oAlWbtiAGfjnnNOjCAOpa5mHTEx8ARY0uHgcXAugmPtlf0vMt7ITXJx5mcUtua
         217vQEEfBUkuIyGzMu53zsjvHpBarVTQB/i55mRpX7JBnRQmRTAJTYHBMz9SGOCjbq2y
         osmvV43WlePyzgYQ0QgIGhLbRYYz7OrlufKkGIjvGUwthpljNonA59v7LHAaaDq6jcEd
         VyvOphAgCfzP5bqb7dbCdW7f6ipoeCUkk8AxDiy3PhqFeuz+FRaQi0x6Xwcqwy0d3UjS
         cuLbRqRH7mC5TbxhkpUtTMT/OBti6BfJvAGdzneue3xMDcPrXIVMuhOmvObdyB2RDyG2
         HA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711003088; x=1711607888;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pUEt2Z97b8lEWwJktqHAAwXS3vj2uI9IohvvSbiYwx0=;
        b=W/v2lSaVweoeOA+ldZ1Vew9BTTlCgdYwi6ysxTlErnGftfGJWSoj9Uc2HGXYbeFnTB
         mW3XiCBniAtqV87BZfPxDCYjW5180VNVJQ3HpZJ3EyxuTXgzNmgP2/1zTDHgZM9GBO8P
         xhAjMgKC1b2S3/GLMuHX0Yz6eGElVL+3P5MzBcsZymL9RdAobwjId5gclyMesId9QU9z
         MsBb3YP+p8QQ4Sd1L4lEWIfJ2AP3/sSIoAEn3Cq38pvPWn4Lq8dz/FiBVPwcUpNWVIuT
         Ob8BBZawHkX4U1OzOBOlBDcJw1INgfXyRcuqfGNN7pgSmRq3gEBJp0altLfSpQFO/LOL
         KuhA==
X-Gm-Message-State: AOJu0Yz/G6Dn/X0DppFtkYrL/ID42IcZHET6eqhJr1xWryX5DT1FHxku
	v4CM2bkMJxmqtXqLpUaSyLaXU3qzpKeJFFSCMmMfKECaDVnENVPPAnJPCrIh
X-Google-Smtp-Source: AGHT+IHO7PmseZroElxnntRG+71U6hx+vXgI/ibXOCO5ih2++Dqy8JTgtAW2iIzj3czGDatlMYY9Yg==
X-Received: by 2002:a05:6a20:d707:b0:1a3:8195:17 with SMTP id iz7-20020a056a20d70700b001a381950017mr4736659pzb.42.1711002740254;
        Wed, 20 Mar 2024 23:32:20 -0700 (PDT)
Received: from ?IPv6:2409:4063:6c85:f395:d58f:6b15:5165:7028? ([2409:4063:6c85:f395:d58f:6b15:5165:7028])
        by smtp.gmail.com with ESMTPSA id sy15-20020a17090b2d0f00b0029df9355e79sm2825083pjb.13.2024.03.20.23.32.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 23:32:19 -0700 (PDT)
Reply-To: businesssolutionsrocks23@gmail.com
From: Raju Kumar <rajukumarkorav@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: RE:Mobile App Development || Web App Development
Message-ID: <839b67d6-4192-dbc7-b4a3-47ad7b0d8875@gmail.com>
Date: Thu, 21 Mar 2024 12:02:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB

Hi,

Just checking with you if you got a chance to see my previous email.

Please let us know if you have MOBILE APP or WEB APP DEVELOPMENT 
requirements; we can schedule a quick call to discuss further in detail.

Kindly suggest a good time to connect also best number to reach you.

Thank you
Raju Kumar

  On Tuesday 28 November 2023 5:43 PM, Raju Kumar wrote:


Hi,

We are a leading IT & Non-IT Staffing services company.
We design and develop web and mobile applications for our clients 
worldwide, focusing on outstanding user experience.

We help companies leverage technological capabilities by developing 
cutting-edge mobile applications with excellent UX (User Experience) 
across multiple platforms.

iOS App Development
Android App Development
Cross-platform App Development
Web App Development

Can we schedule a quick call with one of senior consultants so we can 
discuss this further in detail?
Please suggest a day and time and also share the best number to reach you.

Thank you
Raju Kumar

