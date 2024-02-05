Return-Path: <linux-kernel+bounces-52369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9D8849737
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0FB1F22172
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F5C171C4;
	Mon,  5 Feb 2024 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QteFg9OX"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84811426F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127285; cv=none; b=jjWkOZgDfDZbbpsRIbaySzVk23GpmTiFhyV2Af0NJbPRoy4xwKc85wsijUsHh6w7av/F5yjRuuq2YCwB9rU7+Bo6OuvGViV/EWeiIHPBFnK3Kbz9sVwMmi4aM19R9SQU8CTWCgqL2C7ie/B/U2yNRjVwQ5jXW8IUSxrY30V3l7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127285; c=relaxed/simple;
	bh=017RQOMONvnuGTW9DOEqdTXkZ2q9GflmjTVjuejRJlo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KLUdLghu9BqpZlgd/D2AwutXeVCzw06Kc2dke+Awl6E3isJIcxFLXU6wgh9K7RXP0W0awt5r6LgzlfVMHlEUZkBS6HO5se2Bkd8g0RPs5AMe76auEhnifswb5kdHgvJPcaYX7Bmc9YQcEbB485CQUYEkUaaS0iQ0MDrs3T6GL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QteFg9OX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so3339713f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 02:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707127282; x=1707732082; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=byoZEbZbwQaBw7NkssMZivW+HtsUJ0U6vmYkO81EoAA=;
        b=QteFg9OXn+knqSSbmstshjH2yMqEbQfWqyCGdKn5Qh5bwhLTQVKFwE0vlkaKD1O95D
         YeO9HkJ1VpmXAA/VL1sZOfkbDy25QXKdxvLB+c32Kpz5DRG9hVurhAg6/YdNhByyqwI6
         7ZoeGa79pD2s/UqEWtmysEmN8Uai/G35sCZi9JtarDJT7Nrr95Vx9hKsi80AtzQl90RX
         1u1e+5fOBaGZTA8k2MNNF+dasKxH3HyMGcowLW+9HYh1pv9KtPFmAlmeQyE2WnEjk+DO
         Ra49rYPG973EJiHkh/Op2fBxEBafuDEFgzJDwQ7wmsC1WHwD/t+0AVkr4SOaHor4htvP
         EsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707127282; x=1707732082;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=byoZEbZbwQaBw7NkssMZivW+HtsUJ0U6vmYkO81EoAA=;
        b=e9M6WoP2ISZY4uwPgC94mT/RACB9soT8+Fe42K0lYsyI9wwFeZS32LuslWM7E95FJT
         b0891BBdBtE5KzyQ7v9tdtD6HzWqYuGtDREB0ZttroxwtRftMzJQcG5cN1C1CiDMqa3X
         Cn6QYTwAHQz1Po/p05NUnvoSnWWwdZoEgWyc19pbOarGsfrsqBa7QvkmNYHK5f+QOS8J
         3Ua1CCet8gutjvp47X1m06VZRx6M6xx5/SUwwI7Je3xwh72+aExD+Jm+Y66ZcmxZhUEN
         /BifrI4nvTlJErzAmvbZ5zcOfY3phdAq6A3BkTK20UHz9wKqbHg3HBXagiteF5bjOjV1
         Tz+g==
X-Gm-Message-State: AOJu0Yza3tNg7KorvhzjsOSvIA/aTm2rd6FUVeWqg+GyZo4YmU/Ka5Qg
	qn+YiHGQKkvy433tJimMCyjUF1ihQI1kQ8tDM6laJs0G9UF51d7IZB+r8QLdeA==
X-Google-Smtp-Source: AGHT+IG1bJJuA82rQpt37UUK/dBgP5YdQHsUxr+ZUgEjUTFxvDUr+8eAGebzLeDfICAXpuGXZ498+Q==
X-Received: by 2002:a05:6000:701:b0:33b:3ccc:57a7 with SMTP id bs1-20020a056000070100b0033b3ccc57a7mr1942797wrb.7.1707127281699;
        Mon, 05 Feb 2024 02:01:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVYLoYJPb95xsZ/cTAtLl7NgF6Jp3hvZWU4v52PM5KcYAUyM8QxNBoRPzLsz7S7Rcv4lp2+xmZfpoZ5Q7pcvPKGDcLC+g==
Received: from p183 ([46.53.250.163])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d6604000000b00337d6f0013esm7653667wru.107.2024.02.05.02.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:01:21 -0800 (PST)
Date: Mon, 5 Feb 2024 13:01:19 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cpu: mark cpu_possible_mask as __ro_after_init
Message-ID: <41cd78af-92a3-4f23-8c7a-4316a04a66d8@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

cpu_possible_mask is by definition "cpus which could be hotplugged
without reboot" -- property which is fixed after kernel enumerates
motheboard capabilities and hardware configuration.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 kernel/cpu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3107,10 +3107,10 @@ const DECLARE_BITMAP(cpu_all_bits, NR_CPUS) = CPU_BITS_ALL;
 EXPORT_SYMBOL(cpu_all_bits);
 
 #ifdef CONFIG_INIT_ALL_POSSIBLE
-struct cpumask __cpu_possible_mask __read_mostly
+struct cpumask __cpu_possible_mask __ro_after_init;
 	= {CPU_BITS_ALL};
 #else
-struct cpumask __cpu_possible_mask __read_mostly;
+struct cpumask __cpu_possible_mask __ro_after_init;
 #endif
 EXPORT_SYMBOL(__cpu_possible_mask);
 

