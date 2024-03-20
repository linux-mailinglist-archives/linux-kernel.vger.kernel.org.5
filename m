Return-Path: <linux-kernel+bounces-109433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED01A881904
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6831C20F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1888595A;
	Wed, 20 Mar 2024 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mULEKCkm"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A701DFC6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710969912; cv=none; b=HMLHBAeY4FoMna/01eCyM1NlkpqBX/wXLjopY5YnS7RPx3RtsumNqEpJkQid5KPcV9MR24QHkgNxwZFIttM8z0+ds1BS6lvt2f+DKZafhyDXvqAAiF0h0Pa1A0JpOFSW52lg5/rDafgA8/yGZUXNj1KuvB9E5sgggZCX8N0RXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710969912; c=relaxed/simple;
	bh=wd1nYr8m1KR2n3urOxGOjtHYYjJVJHI4iyGiHvDBp6c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PMVCZsDfV/W5N+7FCey+bo35eO9NcmdIGMqLId6c/QKY5wlth3cifkkhP2TO7T9IIExKQIQzArvpszz+RtbxENfIyJVqzuaPDnpW40qzreBsnmCudCfLFArSspAK9PCM9g8uzuYO5XEIi21atipouZsjlbYR8Xkg2695GQQ7ag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mULEKCkm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6b729669bso336944b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710969910; x=1711574710; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7fFGAwFervR59ppe1kqtK+ZKXlEJIswmFJJz9qkT1I=;
        b=mULEKCkmdvz44Yatcyh2LtPkSjllXB9R+FiyEKs45uyEMYprE0SZ8uwG1JlRygdP8T
         sw7rbjdniqWM+muSh+dz8saSzcnJBdTo5CydunxPKFJ1cF4n1+fHhgAJjH/jSGz4e+5a
         kxEQKKRHw6slx5hWItbPjbvfk/1cgM484WxGM1DxupwiFDA6ocGWmChCbvHTXp7XZj9J
         9iZRwGwc0U9EKBwJ9kbFjX7OvlMdCfJOv5vItMyhHC/X2oE3Ovx+y/cD7QIIbMGWQSRS
         8WP/em6nNrFxL3wygm1W0U8K/tHJV2DHFdnL2Fpc2uBJH8CL++1zU0Oy6vwNil9t2KuV
         iPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710969910; x=1711574710;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7fFGAwFervR59ppe1kqtK+ZKXlEJIswmFJJz9qkT1I=;
        b=PxOIwxkCZ3QskBbSeMinBLebEoEosCC63zGeqSSROtNFh4EOp/CqJrwRWbNSYY/G6D
         tjBIOdX3KfoR9FVNCnSlcXGucbJTD451GyH6qjGkO2+RJFvDejB5JOwajbB2UHN19unL
         krdaeU3zIrsW7HIl0uUEQCx7ybblJdEhdinyD02zpd9nlaTPGMU2FxXPFqPc9t3jHBgU
         qmu+iOeDNh2U77zAAXhaTPaPTdD898XQl0jqnQIhxukJt81EqxLMhtK/dEjhlp1xcIHM
         Uu4MIB+erYxzSPMYw8aQ/elKGBZ6DqieTM3QHwxrGH6WRrCZ+z+0c7FGzPUDwdvo7RDs
         GgbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJnDWBPP7NySJDvyC8ygMijEGEgnyKcBAk5VAge8kaFBi5q7tC/0eFqNjXTBHdJUcDSvBTs9UEZz9jXUaNR0NH9YyfSbyl+sa9Q8Fd
X-Gm-Message-State: AOJu0YxvmD5whMX07CQjtgQAXGmOrNZUAGlkLRBC6lo64aoOrjmvdVVp
	ZKvcK4c7PiMJTy6y7lxWk71yqP66QKHmCu8SGN2oInMeNOORjuIW
X-Google-Smtp-Source: AGHT+IH2iUmTzhbDC2TmnDtaOhfOaTiy54ieMvi2ChxgK6MlFkCA1hhh283Kt/vMNF7Bll4ocq00jA==
X-Received: by 2002:a05:6a20:72a4:b0:1a3:72a8:b7ea with SMTP id o36-20020a056a2072a400b001a372a8b7eamr7697543pzk.39.1710969910002;
        Wed, 20 Mar 2024 14:25:10 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id f5-20020a056a000b0500b006e67edb113fsm12116691pfu.219.2024.03.20.14.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 14:25:09 -0700 (PDT)
Date: Thu, 21 Mar 2024 02:55:07 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v3 0/3] Trivial code cleanup patches
Message-ID: <cover.1710965653.git.ayushtiw0110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Address different kinds of checkpatch complains for the rtl8712 module
to ensure adherence to coding style guidelines.

Changes in v3: Fixed issues about backupPMKIDList and verified with
CONFIG_WERROR set and built the kernel.

Changes in v2: Checked any possible reuse of backup_PMKID_list
manually and rebuilt, rebooted the kernel and loaded the driver
with modprobe.

Ayush Tiwari (3):
  staging: rtl8712: rename backupPMKIDList to backup_PMKID_list
  staging: rtl8712: rename backupPMKIDIndex to backup_PMKID_index
  staging: rtl8712: rename backupTKIPCountermeasure to
    backup_TKIP_countermeasure

 drivers/staging/rtl8712/mlme_linux.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.40.1


