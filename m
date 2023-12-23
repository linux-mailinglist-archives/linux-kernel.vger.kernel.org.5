Return-Path: <linux-kernel+bounces-10590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522E481D6A4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 22:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841F21C2153B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 21:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F48179A9;
	Sat, 23 Dec 2023 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQ56CmKR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF78171A7;
	Sat, 23 Dec 2023 21:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d9aa51571fso329310b3a.3;
        Sat, 23 Dec 2023 13:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703367233; x=1703972033; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K70ZFXiuLbOSEF/irteqqsTlGuNTUJTLizy4d5N5cjw=;
        b=nQ56CmKRgV+RbR2DiqQO1b7uTfsA11BWAplztynQEm8mi/V4S/cnzxf9tBwgUr8muZ
         s8tdq9AyXpriDGTb/YNUAty6V8mzVTEPH1r18jsjqzbGFBREZQIfbRTCaZ96ycdMhPUi
         x68V5WvSq6KL9X1wvKeBeCCPI1hffaXz0t6eZ48F37H0yP+Kmzq6qNP5yIKNyj66Dax+
         +gCbFatj6dMPLNkL/SVhm5ZamfOF3prPC27pKhzHUqSuxCUaJDGp71Q7iCswLz4n4QpB
         /OQOqkAw6V8EQJfL92uHIrymIm9lHK7jRY9E9JwaT9jbKCTp66xJ16IpGVg5Zl9uImCZ
         qv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703367233; x=1703972033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K70ZFXiuLbOSEF/irteqqsTlGuNTUJTLizy4d5N5cjw=;
        b=RS7vJpailpPozygs0eGkcMVVZMAsVlc5NNoRADAw5CC54Mq1SbG+RcvspcX1adnJJs
         ngCTJ0JSYHSzR7ix41Y/2CEJqftOfkfplzicIv/Ko+zfOtM9//KIki3TYrj8xbSVALJJ
         jplyXQ09eP382SzQGWDf6yMZW2B29dLtU9+Em7TrOeSn7UtzTgPXkfB/IgF+Fou4cSpW
         TvIuO3jbqVx9OvA0lv7NS3vfMxkX6BuNG4G8Y36h3FIs2oBJeAmvYDBWKjz5M4rp5sFm
         WDnRKpL49mnZIN3Pc5XjwlzQQMcq5lmFzdM2Jr7+xMlY3aYPYnxVAtFqp8LowKfRsPnp
         ZaHQ==
X-Gm-Message-State: AOJu0Yxex7/RYbRNiFlO1TrsV3QDZavlsMuY8xphYJ7bp0m4CFbc2xT5
	RqJzBm3wmDHv+Bro7dcmo44=
X-Google-Smtp-Source: AGHT+IGG8VXB/eoY8c50bN+CKlbtcOFY85/GeeV3SIhe+BIkWUPFKy+wJN3DD1ynaJqmHRG/xFOzjg==
X-Received: by 2002:a05:6a21:33a7:b0:195:41d9:1829 with SMTP id yy39-20020a056a2133a700b0019541d91829mr3540346pzb.106.1703367232763;
        Sat, 23 Dec 2023 13:33:52 -0800 (PST)
Received: from localhost ([185.169.0.79])
        by smtp.gmail.com with ESMTPSA id bd33-20020a056a0027a100b006d9a96b7d0dsm1201455pfb.208.2023.12.23.13.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 13:33:51 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 24 Dec 2023 06:33:48 +0900
From: Tejun Heo <tj@kernel.org>
To: attreyee-muk <tintinm2017@gmail.com>
Cc: jiangshanlai@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/core-api : fix typo in workqueue
Message-ID: <ZYdSPGWlILYcTIKu@mtj.duckdns.org>
References: <20231223175316.24951-1-tintinm2017@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231223175316.24951-1-tintinm2017@gmail.com>

Hello,

On Sat, Dec 23, 2023 at 11:23:17PM +0530, attreyee-muk wrote:
> Correct to “boundaries” from “bounaries” in “CPUs are grouped according to NUMA bounaries.”
> 
> Signed-off-by: Attreyee Mukherjee <tintinm2017@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Jonathan, would you mind taking this patch through doc tree? I don't have
any other wq patches queued for 6.8 and it's a bit awkward to just apply
this one.

Thanks.

-- 
tejun

