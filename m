Return-Path: <linux-kernel+bounces-135661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741D189C96D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BE26B2459D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82D0142645;
	Mon,  8 Apr 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="g78SMyDu"
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2B81422AD;
	Mon,  8 Apr 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.211.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592729; cv=none; b=ZMiQWUKAP4Zgz58yoXOOH4AFNszBtXZVBBuk9gOZnjl3a2cLtNnBhrQiKolHQw1wpRE+XbEVZlH81SYwrMmYB2AJtI3gmShiSVcn3z3GUS9OkeQY7yTQkVumKFLjcZCjKeBeKpjZUlxUw+/LYQMAkAAUkfUyqf8zC3xsr7AAthk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592729; c=relaxed/simple;
	bh=0DE7r32VFtUIG8n2nfPOL90306FmFYMquVvov1Qgxl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7nMybJJxX9pGQU9qGncjzpaetqxuzvhC5DfiJY7c988wVZVF5Cn91RMTsKx3qAE+rrJdBTLBknS48yarBpNtAXuvM4TEHUghoJ4cb1cgCWwqK8C+LXH26eWHv7tNIWCw9d1fjCAUxLBLhcKeRyQYJUoM3rHSSFmLEnM5Ud+hMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=g78SMyDu; arc=none smtp.client-ip=51.81.211.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=default; t=1712592721;
	bh=0DE7r32VFtUIG8n2nfPOL90306FmFYMquVvov1Qgxl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g78SMyDukG/6UN5kQIHMABq2GOy9A+4516u0C2xPvVZtLHp1xWyYQOuVatQDrfmet
	 9FbAJdmfcV3wqyXDwU0Kthy4uNo5VdHeSo5jXLPlRkp00PvYbfUYBvX+uk1F1CODex
	 auRsQiGeOJcFdlG5KKR1vW2gtr2yWiOuZLSRFEjilmTPgeFkNXgaxHDgpA6nkADp+r
	 Z+Gj7pm34+SgW8jRcCFlWL2Dan8P8tkGFUsotfsWsu7ZUnK4r2Wl8Q+0VcSdJSF/Wd
	 xX14Hk4dk8Yk2x2IZEJtYwdic7GF8G85ZRJ9v4RhY2ZU+JyVDl3SbHzw+r67Eiq1Jf
	 xwCD2MFYYE6NQ==
Received: from bloom.tail0d56f.ts.net (unknown [88.235.219.169])
	by gnuweeb.org (Postfix) with ESMTPSA id 5913D249D1C;
	Mon,  8 Apr 2024 23:11:56 +0700 (WIB)
From: Stella Bloom <windowz414@gnuweeb.org>
To: =?UTF-8?q?Mustafa=20Ek=C5=9Fi?= <mustafa.eskieksi@gmail.com>
Cc: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
	Ammar Faizi <ammarfaizi2@gnuweeb.org>,
	Bedirhan KURT <bedirhan_kurt22@erdogan.edu.tr>,
	GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	jdelvare@suse.com,
	lee@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux@roeck-us.net,
	pavel@ucw.cz,
	platform-driver-x86@vger.kernel.org,
	Stella Bloom <stelbl@elrant.team>
Subject: Re: [PATCH v5 0/1] platform/x86: Add wmi driver for Casper Excalibur laptops
Date: Mon,  8 Apr 2024 19:11:49 +0300
Message-ID: <20240408161149.141407-1-windowz414@gnuweeb.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <15fdc072-9329-4675-8d9e-189862d88351@gmail.com>
References: <15fdc072-9329-4675-8d9e-189862d88351@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

--
Stella Bloom

