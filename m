Return-Path: <linux-kernel+bounces-165108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ECE8B882F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEAD128347F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680AE50A6A;
	Wed,  1 May 2024 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLfM/jPu"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E7E645
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714556601; cv=none; b=GmCDZyCktM0O+hOxcwC5Eoy55/oQlqXyg/WxvNyDxzZmlYKgsSp6AicPRpLQXCyoTs5YWo2BRIBEz7bE7OxVCPe2s21rGg2HikCRy/sGdcoFDdX7fHfbqfaTMA3j4nX34LOtTKFNyBiRT9YxPzYamAlgTqG/A3aVnjnFnGcGprA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714556601; c=relaxed/simple;
	bh=WDPfSW7rmSU3/bVUHG8XIdxIlYAHEvyAQQDoftdKIzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AIMG2VSLjIVkQ90apsWUHxtzSfSl3S4efIxJobMPNur9XNJFl1qFHIPP1cN9KQv9yDCPYKostrfPzy2JiKZm+jTd5iJv7oArSTS8FQZt3hWZaAY9gK9QjuP2xlPOIQ1JyYvagU7hE4SMZ2MlbRpPmfBf2YnHIuPORZ6zwdgK3Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLfM/jPu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so8290339a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 02:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714556598; x=1715161398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ShqCFL2qGth5NDut0k8NwWK/CsV6gr2MWSaUrw2v/0=;
        b=bLfM/jPuJNVSYUL/mWJZSXE0m80uqYP/11qvO/SJaN//2W9OOaGMhoA8xCcBA+hCxO
         c1k06pjMO0wCOq/kcZxKlDX+XNm1j6Kpitek2HQ4NZYsBH5UEeosDH3tkuS8G0CmN1nW
         ULDm9FdZoTSlK1ZmFO1RVuEQokBcbHIMyJOpLP6hEHzN5VGVdkwuKoLLK/Jhvj07upGd
         ME3Vmrq6Kdpl5FMnMA9dGyniS9ieH7TcPw1R1HhKUZMfsocl+YrdtNTZit4rmMcvOtuw
         luOZ0ITaVOicOyW5U0hpI5rHyYob3dLNLAApyxhAhoskIhcsSr8MdYcyuDz6VBZj10lI
         ARPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714556598; x=1715161398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ShqCFL2qGth5NDut0k8NwWK/CsV6gr2MWSaUrw2v/0=;
        b=ZlI9v6jlJQh0yoWKLkjXs7NhMryZwx0FB714Q/7oEftX/VOsTRiieeQw28CtJ+I62m
         5i7+iRj8cSfr/DXA5s4vEgMcKXcLO4ZBVgFJPtZK92UItA6GEQxY9XUvvhszuRrsviWQ
         7vuq2ScVGwyKJ7Qm/LBHIoGr8Zw5Zy6eMb/JuiCddOLHYziVl5ppQZAN6GY8IWrfqsug
         QXwtgHLc+biCPygGomKxiI70HXFOd/c+pNy4sRMxe+Z7czFbeUUi1m9JaALHLHe4BVj7
         T0lQ7Kef2Brr1XAs719N34416lyYfkjA3ndGL8xuqennudlWhG69t6nI1PP0wDxeBH41
         mVIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMu0HXLEnG8UozI4j0ebmxa7UF+TfVmAiDILF5lo90uvKdRpr0ds2C/XBdnXilaVhvR/1TeM1Dw+3CskrOrVSEL5rP1MVsqEI8ENnR
X-Gm-Message-State: AOJu0Yy5pr/pEEsuwMNl4nepQoMhWBh+iqtYfCoRzV0IrINhhWw8WIen
	3c47n31b7WZXhGGUyjVDOFypL7I5zfKdCpcT49zuPZvQxO800uBl
X-Google-Smtp-Source: AGHT+IE2ed72oTsa5hBQ9MiFc2+HTqC3Wui3sr2IVy3aKDsHkj8UUG+Qt3wIpOVsLjMZYpE8bsl9Ug==
X-Received: by 2002:a17:907:b9c7:b0:a55:6602:e3a9 with SMTP id xa7-20020a170907b9c700b00a556602e3a9mr1885466ejc.1.1714556598203;
        Wed, 01 May 2024 02:43:18 -0700 (PDT)
Received: from sacco-Inspiron-5559.station (net-37-182-167-227.cust.vodafonedsl.it. [37.182.167.227])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090666c900b00a52274ee0a7sm16328635ejp.171.2024.05.01.02.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 02:43:17 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: sudeep.holla@arm.com
Cc: gregkh@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	skhan@linuxfoundation.org,
	vincenzo.mezzela@gmail.com
Subject: [PATCH 0/2 v3] drivers: introduce automatic cleanup feature
Date: Wed,  1 May 2024 11:43:11 +0200
Message-Id: <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424125401.oxvt5n64d7a57ge3@bogus>
References: <20240424125401.oxvt5n64d7a57ge3@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces the automatic cleanup feature using the __free
attribute. With this modification, resources allocated with __free are 
automatically released at the end of the scope.

In some cases, modifying the structure of loops is necessary to utilize the
__free attribute effectively. For example:

```
struct device_node *t;

do {
    t = of_get_child_by_name(..);
    if (t) {
        
        // some code here

        of_node_put(t);
    }
    i++;

} while (t);

//       ^
//       |
//  device_node here
```

To use the __free attribute here, we need to move the declaration of the device_node
within the loop, otherwise the automatic cleanup is called only at the end of the
function, and not at end of each iteration of the loop, being it scope-based. 

However, moving the declaration of the device_node within the loop, we can no
longer check the exit condition in the loop statement, being it outside
the loop's scope.

Therefore, this work is split into two patches. The first patch moves the exit
condition of the loop directly within the loop's scope with an explicit break
statement:

```
struct device_node *t;

do {
    t = of_get_child_by_name(..);
    if (!t)
        break;

    // some code here

    of_node_put(t);
    i++;

} while (1);
```
The second patch eliminates all of_node_put() calls, introducing the __free 
attribute to the device_node.


changes in v2:
    - check loop exit condition within the loop
    - add cleanup.h header

changes in v3:
    - split patch in two
    - fix misalignment
    - fix checkpatch warnings
    - replace break with return statement where possible


Vincenzo Mezzela (2):
  drivers: reorganize do-while loops
  drivers: use __free attribute instead of of_node_put()

 drivers/base/arch_topology.c | 140 +++++++++++++++++------------------
 1 file changed, 67 insertions(+), 73 deletions(-)

-- 
2.34.1


