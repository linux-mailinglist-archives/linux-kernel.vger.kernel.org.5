Return-Path: <linux-kernel+bounces-76396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C78285F6A2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2671F21ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC6541760;
	Thu, 22 Feb 2024 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxFYP9tI"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF3341235
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600781; cv=none; b=FvTLYSseu+vUgkO/aSSXXByz/gmiCLVzNEYbVaaTvv+5oFROC8rcwKn58NXs1oDWlUhOgjNlD8cBhu9aJgrcnaBB8+jFNiyJJEzYVY7GQVp+gRGNra1rPrDpSevmooMKi9DMmoEe5LyzGCbp7uZrnBKArEam1FF3mwdYeoZrfGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600781; c=relaxed/simple;
	bh=FqTbz2D2gTxpyB9VwCCqqL9YFJIQagi087SYexBr+e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwEkglCu8mSZHVihWpKfvATfocMdLjDfLEzs+dluoc9u4h0SABfp8UmIK3RxpVPA4yxijbQ7YGcIHxUZDnU8LTlCa/YwNF8+mm7V99QkXEAXkO3OhIBrS9nswGFWIhWVawHosU6jHM2+q9oQtIICSlByUP/FjAV6nNlXDbKpjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxFYP9tI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e75e30d36so130644466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708600778; x=1709205578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSel0K+jW3G7oIUBLnh40+t8+RQ+O6NgVmJw2vixq0I=;
        b=KxFYP9tIndC6EVEiay5P301PyUDTqc/dXlbGfTQwV2dRMf1sK6OsPwv6fCTv6eoi1r
         1pZgpq8F1I0I0weI+DsU6ng7VBXdGP8Gg4on10xidtALZAwgUkphcE87HUOrjVeZUk5s
         Z0tDfvKL7MANzETirRzHhdF08MQv4tpqLDaHs6EAePCHEgPNeSVLFI6ve3X6BUdNBaUk
         rhvrtGkruMrffsSieeZuETTZISKAL/2foWhsGDQtsW5L0Ut0ZAc2WNv2oxPQhObyKX9S
         oOxlygSxFV/E8pKrSD0ddIBUWQG0Yy7Fds/rW6UXXKFMsAZvL8rTcNUlnHO951/SVgl2
         qshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708600778; x=1709205578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSel0K+jW3G7oIUBLnh40+t8+RQ+O6NgVmJw2vixq0I=;
        b=Eb8XOUETkwiEjYLfFsczdiuUUqQUpzGI2bLW/KJ3rUVvyXS52TcOUP2U2sRUTPBgro
         L66jU6BKrbY0vwc9I5/ZTO7lBeE3euEyJa8C9tiWMD6FyLVuuNptnkHLNARaTDi1Aa4L
         S32dhdtCw6lZxaEI7D4gt3W7cCOitrbZL6GMzWouTymSCwim/fKiDChvx19zp31g2J9m
         tjbPF8geLfIAz/7+0VQkCr0Y94Gb8J/2xl6Fn6VBv4VvPFq8BbOipwG7FJ4n1w6Zx3kR
         s488y/ge2Te9Br46txZ1xgLNJSOfHEZTOrDd8ZUp0esTIQdqwuw+usVcFn+UDq+UVt+1
         qK0Q==
X-Gm-Message-State: AOJu0YyhXSnDiqVbRqiGdyrRQVRUwzl4aTq17nLmtvhmGv3D2OF6Bkmd
	qY4EmIA0kwbAX5fn0qZj9UkOVKilYYTLeOlZvKdUb/na6P3dujM=
X-Google-Smtp-Source: AGHT+IGKAC6wZEBHTG2aqAxwyxDq0zgJwe5JqF9EUVdUxOd7oHFIF3z8/qlZqRMK62rbjftZPOITcA==
X-Received: by 2002:a17:906:c182:b0:a3f:2b3b:baa9 with SMTP id g2-20020a170906c18200b00a3f2b3bbaa9mr1695242ejz.14.1708600777419;
        Thu, 22 Feb 2024 03:19:37 -0800 (PST)
Received: from p183 ([46.53.251.190])
        by smtp.gmail.com with ESMTPSA id ot18-20020a170906ccd200b00a3ecdd0ba23sm3270814ejb.52.2024.02.22.03.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:19:36 -0800 (PST)
Date: Thu, 22 Feb 2024 14:19:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] cpu: mark cpu_possible_mask as __ro_after_init
Message-ID: <11d7a34f-909b-4923-a15f-d32015463c35@p183>
References: <41cd78af-92a3-4f23-8c7a-4316a04a66d8@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41cd78af-92a3-4f23-8c7a-4316a04a66d8@p183>

cpu_possible_mask is by definition "cpus which could be hotplugged without
reboot". It's a property which is fixed after kernel enumerates hardware
configuration.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	v2: fix parisc compilation

 kernel/cpu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3107,10 +3107,10 @@ const DECLARE_BITMAP(cpu_all_bits, NR_CPUS) = CPU_BITS_ALL;
 EXPORT_SYMBOL(cpu_all_bits);
 
 #ifdef CONFIG_INIT_ALL_POSSIBLE
-struct cpumask __cpu_possible_mask __read_mostly
+struct cpumask __cpu_possible_mask __ro_after_init
 	= {CPU_BITS_ALL};
 #else
-struct cpumask __cpu_possible_mask __read_mostly;
+struct cpumask __cpu_possible_mask __ro_after_init;
 #endif
 EXPORT_SYMBOL(__cpu_possible_mask);
 

