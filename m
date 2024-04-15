Return-Path: <linux-kernel+bounces-144963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDA78A4D35
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A063C1F25C63
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD2C60EF9;
	Mon, 15 Apr 2024 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0kqZI/D"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5C65FBB2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178956; cv=none; b=C5neOfH5Ea0byud0hLoAM71oKbwDSu50dz2Yjz7iI9eOKh4M2LBWX8G15ZcrzdKpPdruYW5PNNtbmsPiKnwsOGRv/5L1enelAkcMyOJBSFw6OlMObWlPUaKLCqoolIq3SviILcl5ZN9kGTjqhXegwXZlGQ7bz9lDXAsF5RS4ZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178956; c=relaxed/simple;
	bh=MIhq8mJ7oUvBQxJxZxPYeRGvclWcASUEntuazUTpXjM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oEwoHamJFScTKFChJsYzlhXn/961wXeUeeKf88LYfMzOnDO+yIomb/TrPImpK3n/rFvWd2XYV7rgc9tPI4LX77bKBPw2ZI3ipjFCPpJBa89RNShqk0g3do7YhLy8H3zjW9nPCrC5kLU2Twuedf1Da2P8Z6lUocoG4XwtNLv2E78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i0kqZI/D; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so6320916a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 04:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713178949; x=1713783749; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WkJt8HeL/rqFcaJaZy8EN1qlqgI1FfXx/hyDHSkD2yA=;
        b=i0kqZI/DtRidLnChzqNVe/ndRuPifY1gJbZDP5lj8ZDRNAn8bjHsINz0OJ32eNsQ/D
         0Fw2jhYK5a2PIKK3CBHdJ4OSfCU4cFNzuIq7zH4mr1JB6BrDxe0W0hqE7tu8DRmjfEPT
         TNa0FKxd+lewsQ8gJ7DvpKodGAqgE3JLZ2x7smoLyCUVfYNFWg9cYJBarFC+BXsOQAdF
         e3RxQT+jwn+Ac+90mYe7BHxR8yU18ptfrbllJxdbclaMhRgXuW4ZLJLwC7WPxDjM/Bwv
         0StKgFgTR8zG1EwC9PM5UyVMkTkebWPsUiqoqEWGXm93XrKMWOqcmXhZruODDKNS22z/
         891Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713178949; x=1713783749;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkJt8HeL/rqFcaJaZy8EN1qlqgI1FfXx/hyDHSkD2yA=;
        b=uYgU9PODePQUlyZpGyFAV66UpLVhiS1kjS5fvPF8QVd+jHrFHSPIkk+ViJSHb9oxFZ
         K7j0U7KNUytejlZCTZoYQGs2vrBORUVVHTZHopmk8U9tMZiGXpF7AKqksDqDpBTZ1Yi6
         QZBibUEIxRxhWxgEbVnsGXiu3/aW5PEyFkcIit4br4kIWWq3rQXYW8RCjqheF0jLdmab
         uHllsnNnh99pO93NIdwr+P/PzEqABqErAH571mut52ietkacVhm26qadMw+ehqdIW6rd
         Dtyjs2Z9RpDw8k7Zf5Y5EN78BboDojI/XputRKMiGaA6yLhv6wECxrfIZmTAZX8ibV/O
         p8sA==
X-Forwarded-Encrypted: i=1; AJvYcCUgGSf/3BifXt+cb6L2AeuU3evncMXl6VtbG+j6mc2RjeN2WqIiWJZsTHj53n8J317ZiOA+0piVdjkf5qB8Dtz0qMv3vBs1zweL1cdv
X-Gm-Message-State: AOJu0YxEFiH7IfYnJ2CwZOLskkfzpG6e65XJmWNrKXqLFJNzAvaW1d0v
	mZK6P6dt91Rdzt8ZY3GS+RjuDxPnqO50if7bjcE220i0iLHT1GQ6pOAfCQYtdVA=
X-Google-Smtp-Source: AGHT+IHqkqWiXTI3T2/BJrFEReF5SDv1Jethh7csBvaDPHHglMpeUb/vl41fsK+ns3JtlOqsePRXFQ==
X-Received: by 2002:a17:906:1713:b0:a51:8979:a7e6 with SMTP id c19-20020a170906171300b00a518979a7e6mr6895315eje.14.1713178948252;
        Mon, 15 Apr 2024 04:02:28 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709063f9200b00a523cf3293fsm3868215ejj.59.2024.04.15.04.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 04:02:27 -0700 (PDT)
Date: Mon, 15 Apr 2024 14:02:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: William Hubbs <w.d.hubbs@gmail.com>,
	Chris Brannon <chris@the-brannons.com>,
	Kirk Reiser <kirk@reisers.ca>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] speakup: Fix sizeof() vs ARRAY_SIZE() bug
Message-ID: <d16f67d2-fd0a-4d45-adac-75ddd11001aa@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "buf" pointer is an array of u16 values.  This code should be
using ARRAY_SIZE() (which is 256) instead of sizeof() (which is 512),
otherwise it can the still got out of bounds.

Fixes: c8d2f34ea96e ("speakup: Avoid crash on very long word")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/accessibility/speakup/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index 736c2eb8c0f3..f677ad2177c2 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -574,7 +574,7 @@ static u_long get_word(struct vc_data *vc)
 	}
 	attr_ch = get_char(vc, (u_short *)tmp_pos, &spk_attr);
 	buf[cnt++] = attr_ch;
-	while (tmpx < vc->vc_cols - 1 && cnt < sizeof(buf) - 1) {
+	while (tmpx < vc->vc_cols - 1 && cnt < ARRAY_SIZE(buf) - 1) {
 		tmp_pos += 2;
 		tmpx++;
 		ch = get_char(vc, (u_short *)tmp_pos, &temp);
-- 
2.43.0


