Return-Path: <linux-kernel+bounces-167988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291238BB1EE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DEE28308D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DE31586D7;
	Fri,  3 May 2024 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+1GCw2H"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E704A158202;
	Fri,  3 May 2024 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714758761; cv=none; b=jyStyiTZKkz3woQ/T8uwvS3nEry16Pl90hlQe7QfIdg/+pwx1O+AcUYln8vp76B5JlaIVXd9oHXAU1sFyUiwyu2/1O5OT4WWXC00eYhnAa4FRlxeNHp+ce3t9hDOCqjT8DuB4A+JMdUTj+k388z7vAyDOz3zVATD1+3tYmHtpak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714758761; c=relaxed/simple;
	bh=Mri5fTd2blYcQR3oWWDwHWSCOTzmuxEMWx67fmd/ZzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MGjKVyQTBPGIW5znjnKfJkIGaIsrM78y7vRTPDHUV2jLpwzNSWaw5ybdOZSsfpeEJnCBGBhWUez6VxjtOVWUn3KK76IthXTpedj6rjvZ1z5HMfDXEi6KAPsfSKhAxY36RZdnkReJeFWl+SNMj6ot8iZL0ISXh+6ev0BGe3Y9FKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+1GCw2H; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5872b74c44so1257015766b.3;
        Fri, 03 May 2024 10:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714758758; x=1715363558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hv8U88MGPjGVlknzKUx2MPXN0ijTnWvKrGGtFBeWuHY=;
        b=j+1GCw2Hb5yVK5bM43zhvseYTuP1bFc7kTCaZoySIAS6EvN3fZr+aXNPTapUnOqgUM
         PPT+hVuF6Y0CW8lwC2OgRrh534WF8xm2BxHAPXYzbRzoY77LJHKqwZLLs2afnAfws2bH
         F2GNQJaU/uqiCkY+mloD0Ebg7aMQWEYX/Int/eCaKzjTWiDX9yBs6Jr4KU9B2mA47960
         3J2Y/6LmSFzTkI9EQJ/+pZXM5oOoIzD9Tk3LHxNmVpYflfkW+LJxI9zECCQnE7IA2V8x
         nOgbunW3uBsVY4cOypUYC1O+fDPHHwUgf3QH/9R0TtAVNfANq7B3t6izn1IUQwjpLLTF
         OQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714758758; x=1715363558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hv8U88MGPjGVlknzKUx2MPXN0ijTnWvKrGGtFBeWuHY=;
        b=DDwvoEYMjv/vhesaXwDfDSym2MeUESt1yHjOAFSsHmU0+jnSiBRkwLxjIb7TdgMBid
         jKrTv5vaTVZYst3FeYx0inSvtTpRzi936pX7IHDrLDkAaWYpN24nfsa7r8r3Ff4hvUjl
         yHgbEmsVebPGJUiHrRPKZ+ICCronB7FGq90CT1zy48FjZaEraNdqL2qAQiQcPKgnZvqW
         vOZJ0SxZlVGwff2s+JcyROrZe8CChSp7JLglNGzuiqxX7+7OIGp9/BGzhwvjUDZyHBX2
         6YGnIyqPxyZVGrA+vmXFpeaFtqSbIbnB6nFV0QBJTgbTLcrqRiNABB42Ojuk6aiRpo4O
         yIXg==
X-Forwarded-Encrypted: i=1; AJvYcCW1ze0pVjZhrWJa1ZsEztA4dJJe3UAqiJhTx3Al64d5hKJUIifGu0mktbN1jGhHq+R4KvP49C3wSUXNegbBDTEf+zBeX8m75LkgeZmo
X-Gm-Message-State: AOJu0YxefErl8kOeeXYF9QOtaoaqzKnWL8IwqBHGzHFRLwAmuZZQicXQ
	C0CdYU/k+w9uibs2Gbgsk4QtozrmpfA7S27VhTjevTkVZ9VA+mgb
X-Google-Smtp-Source: AGHT+IFda4IBg1SIoYzq/bSKmyVZMSDW+3JXaIB3rFnqcRC9ICD1D1DRaJaPNDAiCVlEqa/qxNFdkg==
X-Received: by 2002:a50:9fa8:0:b0:56e:2b31:b111 with SMTP id c37-20020a509fa8000000b0056e2b31b111mr2253828edf.7.1714758758304;
        Fri, 03 May 2024 10:52:38 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-47.cable.dynamic.surfer.at. [84.115.213.47])
        by smtp.gmail.com with ESMTPSA id q28-20020a50aa9c000000b00572469a7948sm1968368edc.45.2024.05.03.10.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 10:52:37 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 03 May 2024 19:52:32 +0200
Subject: [PATCH 1/2] cpufreq: sun50i: fix memory leak in
 dt_has_supported_hw()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-1-0a2352cac46b@gmail.com>
References: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-0-0a2352cac46b@gmail.com>
In-Reply-To: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-0-0a2352cac46b@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714758755; l=1326;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Mri5fTd2blYcQR3oWWDwHWSCOTzmuxEMWx67fmd/ZzI=;
 b=udeaJHPt5rHhF46vbOWjAj99SPixn91bwWQoY9RNNRD/rc/kOQ3iLjl9RVmcNade0FxgOeYLv
 Xx9Nip+KoJxDW65l/77GOlzgmH9ZN45UEINZI5sCgACTRCbPC02afj6
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The for_each_child_of_node() loop does not decrement the child node
refcount before the break instruction, even though the node is no
longer required.

This can be avoided with the new for_each_child_of_node_scoped() macro
that removes the need for any of_node_put().

Fixes: fa5aec9561cf ("cpufreq: sun50i: Add support for opp_supported_hw")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 0b882765cd66..ef83e4bf2639 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -131,7 +131,7 @@ static const struct of_device_id cpu_opp_match_list[] = {
 static bool dt_has_supported_hw(void)
 {
 	bool has_opp_supported_hw = false;
-	struct device_node *np, *opp;
+	struct device_node *np;
 	struct device *cpu_dev;
 
 	cpu_dev = get_cpu_device(0);
@@ -142,7 +142,7 @@ static bool dt_has_supported_hw(void)
 	if (!np)
 		return false;
 
-	for_each_child_of_node(np, opp) {
+	for_each_child_of_node_scoped(np, opp) {
 		if (of_find_property(opp, "opp-supported-hw", NULL)) {
 			has_opp_supported_hw = true;
 			break;

-- 
2.40.1


