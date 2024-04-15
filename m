Return-Path: <linux-kernel+bounces-144806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF82A8A4AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900701F2120E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6873BBC1;
	Mon, 15 Apr 2024 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYAe4tg+"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3451A3F9D4;
	Mon, 15 Apr 2024 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171273; cv=none; b=IGLYHMjqFDKwyjvSP0QWN3qia7Jsch2XgPIfyxb/3Lci1Hun128k+tUouzRtJKucjxlh40HfaWcPpKhTOnWcCznkuzEQPnTT7ywYdKnFSF4iUXg6L9QfjBy2GK5BW8r0tXENxa4sOP47Wm6HaEuXaOKlNvOQ07y8mhtxYk0+50w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171273; c=relaxed/simple;
	bh=s40uCXQURYbe0UBuprud/njSs0ZIWjKApDAezTTAv5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSLvqLwr9gPdFKfNm5IK6ell6Yaru9YfMtNQCbg8O0Jg95wI8isTagWznX8S0E5v0+8w1klOIMMLISFzgy1GWb4kEWZeJs9TFNBg5q3UHRJTF4/3ULVL8+HKWUd7DciH+w1EpfaywSwyrDxuZBj6rAboZktypY288kkPxN7StjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYAe4tg+; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c6f6c5bc37so1232177b6e.1;
        Mon, 15 Apr 2024 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713171270; x=1713776070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s40uCXQURYbe0UBuprud/njSs0ZIWjKApDAezTTAv5A=;
        b=JYAe4tg+Incl0rrL+wJYWh8x605R709md1yYJejK+EzXHJNI7gxXZ8qvkc5ces0lfV
         E5/+wjORjv80nHc/wRl+5V59Ekaa6gzN9QhCSAJ5wc5s5mtGJIqteurD3Rlg1qE4QztX
         LhYyg7qCu3e+j9IwfHFaA//TSEA2Qd7HSgwfBAjlAJUGCvlusniIhtklTrOBz3xCDor+
         SQ7w1N1XYMDX3Bxx45k58/UzW/3EHe9FVs4/gUVB9wmeVgDhbvIRiJ1kFCgrWXBCf7zw
         Hhl/9A04+OEZPqkj47oVXvMOHDPIHUDMhFfw/gZkSuNHAwUVEwIWIua7IqyJbTFhzCCn
         +2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713171270; x=1713776070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s40uCXQURYbe0UBuprud/njSs0ZIWjKApDAezTTAv5A=;
        b=p0GigOI71KUSDo3zvJrppUe0IXElNcysDLt1+taVGokNZ8bqYWTWmpUQl6wZ8DlJlZ
         uswjP/pkDgVrXVMU2jn5bQqoaHRI27IZWiOCRCp+dF7e1PEkFAUD5gcbdcB8/pHb5Jbt
         mBHK9NcTOGtjL+fwl+ZIvZhv4V7BHbp0TAbt3rWKAUF5xA+COmXcgBOOFoiRDo8JhWgs
         Wiinh/ZUC3Ft69hj4am6MIP5MktIoFMP7TProNOzllDcT5vSy2RaJ5Q//PSW0l5vaVbD
         TFG3Yr21/86KUO6LxNwA+/AQybQkaR7BfIKSooVeMfTy4Sqc0dKJOyvb2Rlvjkx6g83E
         RjOw==
X-Forwarded-Encrypted: i=1; AJvYcCXp763sX5e4+cMUi/dnWWxJJyyuyUTboM8tDXV7Eh7UYH+K/k+dIx7Zl6UfyLK7plV+GJbFKdfju9QAGyE0VN5QN/ZCVUKJdDBSbzzxKApQSI3B/Bi6PG6KPiwUH1CT8tCegSflOxYapg==
X-Gm-Message-State: AOJu0Yw2eVD+z/SYppSqnHySdXwxjSTROJWyf7Tt8XqOLHs5+S18seIX
	b3V8kef5N6hOjWZJjM8wigXw8Lih4DIcmOs0eujsrpvgypBHmwsYC2gHRBh3KLFZsQ==
X-Google-Smtp-Source: AGHT+IFLGktyFceX77eS/EWTNIy/C/EEkP/6Uwj0JtLUM5Gch3gRYxudIsXV7Uwh5tX3uhb6kSATHw==
X-Received: by 2002:a05:6870:818b:b0:229:7f9f:adee with SMTP id k11-20020a056870818b00b002297f9fadeemr11347247oae.30.1713171270183;
        Mon, 15 Apr 2024 01:54:30 -0700 (PDT)
Received: from localhost.localdomain ([221.220.135.251])
        by smtp.gmail.com with ESMTPSA id h11-20020aa786cb000000b006eadc87233dsm6786293pfo.165.2024.04.15.01.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:54:29 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: krzk@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	robh@kernel.org,
	sfr@canb.auug.org.au,
	weizhao.ouyang@arm.com
Subject: Re: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add ArmSoM
Date: Mon, 15 Apr 2024 16:54:19 +0800
Message-Id: <20240415085419.6107-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <dcda2991-90bc-41eb-afa3-14a2071a6d19@kernel.org>
References: <dcda2991-90bc-41eb-afa3-14a2071a6d19@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

On Mon, 15 Apr 2024 10:04:14 +0200, Krzysztof Kozlowski wrote:
>> Add vendor prefix for ArmSoM (https://www.armsom.org)
>
>I feel some lawsuits coming...

The brand name "ArmSoM" was first registered on 10 December 2021, which
means "System-on-Module of ARM". Would you please explan it further
about the risk of law? We are working with ARM for the SystemReady
certification.

>Website says different name. Please use name from the website.

Sure, I will change it to "ArmSoM Technology Co., Ltd." in v3.

Best regards,
Jianfeng

