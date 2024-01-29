Return-Path: <linux-kernel+bounces-42283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6014C83FEFE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AA41C231AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C234EB35;
	Mon, 29 Jan 2024 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6C7bYy4"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E544E1C5;
	Mon, 29 Jan 2024 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706513383; cv=none; b=EXR2G4m3B/KJHiWmYp8lO4WXKR9vM0+ovoAn3hmOT3Rjh3sR7CODPp1Cyd1nzhktva5Rriy/zvXG1W4lbTUgvG8jO1hfJFuRUHPbJtHJ6BUVpqNCv4BiVU9Bu00KrKMnro98716c9n4UDcocGdN5GsPa6NZ8P1aQynMPE/Bx7do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706513383; c=relaxed/simple;
	bh=Jc9jn5Kx2NmcVs/vW6S/Hjf8twBJz4qR4JDcZ6C83/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fwKVDhb20Lwm6avACeVz5Zng4JqFtth8eGjVzd37brpJyvSRPejZoKveGGkx3ejs5uk3TD/3izJvuU4jP+waJtX1Wjo2Vd2rFAxjU09+n14+UfL9Sl91xBOnWjaIO4Vmngmw+P3GRRAFqFJ6SuIC9x8vpd+N9KpKLyDU42s9OhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6C7bYy4; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce74ea4bf2so1416447a12.0;
        Sun, 28 Jan 2024 23:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706513382; x=1707118182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jc9jn5Kx2NmcVs/vW6S/Hjf8twBJz4qR4JDcZ6C83/c=;
        b=O6C7bYy4/j6vwHVuQhwux+PfuAnH8Lok5uqAktj37niW1R7prWiw7HL5gigVJqIUon
         Qx18ASGfqaz79gN/W1UxWsYJ4KUrZTJT5vV2z5lYKQzBhd2iRAo7pa2xnUXcN2YOVYvD
         rSFQggkdmKDp7a53JXwbPmv2rg+gEy4axbk4teSchAJ6brFDU7N4Vglu6WBqDJAi9GoB
         S7n0zMaHHQMqNue2PcMWSSQpVbQL7vF8AY8kR9fLAvIdiROvmY11g4Z/BrNGUqboD+wp
         xTf2oOwcYxv6Uyt/s+2jitLHUP8GmY9AkICYMHX3fdXp/Yb9pDcxBgTmApDLwZp+A1mn
         Y+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706513382; x=1707118182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jc9jn5Kx2NmcVs/vW6S/Hjf8twBJz4qR4JDcZ6C83/c=;
        b=An50vc1InKuA3IYcYJ+ccF8MQ152Qs438m0YLNB2wTtiTDKOHoYU/8ZOeVR4leohs1
         rRQuWp7bi1tSOxrEz4OJUmUwFNRbmX+FNAHFH0U3dL/3eq57deBA9Lqlet1eLk1Ob4xz
         EsvODKKceF3HmK6otLhvBaMT9yJe4TkI3ZLDs8JGzHLRnevGMgxI9vPh67KAnvwFeKYa
         veHolOUS4CvxuqTx2A3dOJcCCOZSGwbEfEW1en/FOq4tOqcyNaPahOTliHHp9VWhkfrC
         geKJHDaAwj4PmXj3zb2siZphxfmLt7GddkB0/houIkowxnRQAYmL6IYD/rrmfvib0Skg
         lmGw==
X-Gm-Message-State: AOJu0YwTy4wceRX1c60LisSqmpPJJ9543gcTATGD1hu9uZLDcLXczCMn
	7sT6UtKVfIb5WEkQFwstR34+98csbFPMo78BjRAduJQwm3OZCVTsGBRvJ7C6lsOQgg==
X-Google-Smtp-Source: AGHT+IGGTBO+r3eRZTFlF3sN1pAYGUMy9Jx9OlnDSVJHQnlJLn/6GIgPdJD+ktAzomESSLxfbBW1/w==
X-Received: by 2002:a05:6a20:9e4b:b0:19c:9c76:e9b2 with SMTP id mt11-20020a056a209e4b00b0019c9c76e9b2mr4376473pzb.13.1706513381660;
        Sun, 28 Jan 2024 23:29:41 -0800 (PST)
Received: from kohshi54-ThinkCentre-M715q.. ([2404:7a80:c880:6500:a374:2c9:8d38:9a2d])
        by smtp.gmail.com with ESMTPSA id h8-20020aa79f48000000b006ddcadb1e2csm5166597pfr.29.2024.01.28.23.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 23:29:41 -0800 (PST)
From: Kohshi Yamaguchi <kohshi54.yam@gmail.com>
To: rdunlap@infradead.org
Cc: sakari.ailus@linux.intel.com,
	bingbu.cao@intel.com,
	tian.shu.qiu@intel.com,
	mchehab@kernel.org,
	gregkh@linuxfoundation.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] doc: ipu3: Fix UAPI header doc warnings
Date: Mon, 29 Jan 2024 16:29:37 +0900
Message-Id: <20240129072937.51850-1-kohshi54.yam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <621fe651-8538-43d5-a797-c1e66436b2dc@infradead.org>
References: <621fe651-8538-43d5-a797-c1e66436b2dc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Thank you for reviewing my patch and pointing out the overlap.
I appreciate your feedback.

Best regards,
--
Kohshi Yamaguchi

