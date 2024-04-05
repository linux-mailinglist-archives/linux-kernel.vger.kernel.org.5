Return-Path: <linux-kernel+bounces-133202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8657389A06C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD8B1F2437F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0211516F840;
	Fri,  5 Apr 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tW+/vp2A"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E0216F293
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329271; cv=none; b=sKLuK0RqbrSBHj1IM1iF2WVd+DD/NE5Q5/z+B6ZIDHDelN7DeB/ey4HPOQVvSJFNj9KjpE/aMQWFdtPP7Cg19ZdQJxZRlTKPHxoSwdFtOH9oZnlHx4vcssgbZnpPt9fw5KyU3xWyx/EunGPXU3APdMRTaF9CbMZNHZ9j+EoRqjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329271; c=relaxed/simple;
	bh=FDM+rqfjgcFF5IHN0e96vKKuLr3OVua6OMs3SeJABUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cnxcmJjkVFYshNwLRybSa+W5qem5PzJcTy+q2h0o2KDMvH7HaJhDRipKLLD+KPeXmruaiRbvFDjPFCGp5A/iZBZVWKB+Sp0x60u1PJsBxYUOhoRzEKAfqpRqD/9alT7lbOaE/nB0zjz6fs408LLvoc9Rmnc8dr0yf1lc5vSCD4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tW+/vp2A; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e0acaf69aso2904933a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712329267; x=1712934067; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ls3xSfROj02Oi9qADH98tOOJ7brRe2Fo3DATo6V7VGo=;
        b=tW+/vp2ADq5/tEdf9Z8vMZH7zjFrfszf5L9zT9mwHzxKLFq89WJkhAStubuJ6F+H9p
         3uAL8BJyUPnGyYTKsZf230oqRGImGRi4cg5lsxLTMW8WhLF+uPG21wgO7AXTnZHp1i3h
         nFaCCDnR1ktGOc9/HUhR8jE6OV6ByGFrR+sXiqOl4lkAHHyTxF4ThMd5XDNyh6jbyyAl
         LJ0zsyT9dnllf79P+7CLwj38ZvJ3LtGnYYAgOqV+EysZ7MP8XHeAXQLsOU3gVceXh826
         4y0IXsQHBTGvA3xROWC70MQxDA4ig3QyCBsMfLQRw9XU4WckqxfLeImkl311WINcQ5Kk
         6zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712329267; x=1712934067;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls3xSfROj02Oi9qADH98tOOJ7brRe2Fo3DATo6V7VGo=;
        b=aE40TDnPs1NEizh6LoFvX9B1Njfm38tbpV8qK+qDybfBoLhg2SNpcEqRa2cPNN24Xh
         ySMwsT429p8MmWsC123Wz+NegRYnVB3jgWtqT36+iBTDj/jQaEk3xX5q4aMeMfBWkTzB
         E0U3ngeee1+NP6lY8NLx8Hc0bubZzUtkS+8+g+rrxdjhOPapRazyrCgxGd2ofgm3pEqx
         Y+Tq7ZzYa4aVCcSGyiJAJUejxtyKJOkDs318TrFcT/IDHme7RgdY1ABpFl8ZRfRdBEVl
         gWhmveA4CnJ43jGBPrmC4VRndcupDxjR8wiSTQsn64DgssOuB8Juecw+bYk8Y0mshLh5
         J3lw==
X-Forwarded-Encrypted: i=1; AJvYcCW4lba21mcs4KQ7mOZrbIwQtwrL3RaBg56xacLmC6vqG5zVyyzPDYqD7e75VWE3mNj51zWscH5zAPz2TamZgOIaFroTDdt2Ak2SIcxZ
X-Gm-Message-State: AOJu0Yw5JIQiQICbbYx2JQMfwF96p0rF5pH0z+Eq+MG6cXvUIUjQZ/uk
	aQ647FDOifGneGuMkdY06hLRZJbzK4hsGQN4whmFKQewbmj9M1pDy+Sd/1Zegdk=
X-Google-Smtp-Source: AGHT+IHKy57nSuGOHzyW+AHTWzhaIS8bsMFdSatM6N6CkW3nKL+4boqP2WuHmw6B6CE+NVXx+7nQUw==
X-Received: by 2002:a17:907:7245:b0:a4e:768a:1445 with SMTP id ds5-20020a170907724500b00a4e768a1445mr1664506ejc.16.1712329267179;
        Fri, 05 Apr 2024 08:01:07 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id jx24-20020a170907761800b00a46baba1a0asm926271ejc.100.2024.04.05.08.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:01:06 -0700 (PDT)
Date: Fri, 5 Apr 2024 18:01:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] bcachefs: fix ! vs ~ typo in __clear_bit_le64()
Message-ID: <5ecccc80-70b2-4c04-8c09-1113fef3e515@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The ! was obviously intended to be ~.  As it is, this function does
the equivalent to: "addr[bit / 64] = 0;".

Fixes: 27fcec6c27ca ("bcachefs: Clear recovery_passes_required as they complete without errors")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/bcachefs/util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index b7e7c29278fc..de639e8a3ab5 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -795,7 +795,7 @@ static inline void __set_bit_le64(size_t bit, __le64 *addr)
 
 static inline void __clear_bit_le64(size_t bit, __le64 *addr)
 {
-	addr[bit / 64] &= !cpu_to_le64(BIT_ULL(bit % 64));
+	addr[bit / 64] &= ~cpu_to_le64(BIT_ULL(bit % 64));
 }
 
 static inline bool test_bit_le64(size_t bit, __le64 *addr)
-- 
2.43.0


