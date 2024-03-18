Return-Path: <linux-kernel+bounces-106580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EF287F09A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89ADC1C214E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13CD56B77;
	Mon, 18 Mar 2024 19:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPGILYGB"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0356B6E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791656; cv=none; b=UxRJACs52Gnf9zNloDf94JVvFQ9VkDCpuaoCWA5INa0viUa2967KegPE4Jw5ld5VQUrWdDuMORcYYoUl6A4i46JZKFzrLYsB+4Z9oAF2CJZ0/nsPdOQmt+4kozgiF6+iYcjkgnQ0EnbYrDLP+KUqIqXxabIuSO0PANIiXJy5luo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791656; c=relaxed/simple;
	bh=mtH10iBGfkgYna2G5tfTnlI8rWUj8bY1rkzj3C1aYYo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GuitJ7p8JH4puuwJxFx08zdWXtX+1FkKMjqoVaStetZxKBjMNIxw+J2mZkxYt5J1jWUvjoRSn2KTVEVeHKKnfHwmhbhS0ZRmMdJ8bVhlcWAqR8Dwn7U/FWqDB3WZ4BHQlweW/TpIRVFgbMG4ONxxaiF0XMFHuw9wCXksXBZOxl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPGILYGB; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a47a9f7755so1992265eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710791653; x=1711396453; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1flyVzcCsetu9NnMLrvXhAj5dUurHhoT3CHQTlJfpY=;
        b=JPGILYGBnnAsayBP1GjM1KqeRt2mmVKpWaTALMow3TFyCJu4dwOe/lpqOXVCvLKcij
         E0gtVFMAIN0dlA6FMSdEN/Enk6eisEobzqs47QL7+kjkxhgIc4ZxR94kfOCVGQaqjP7X
         Xf17mxCZXTRrL1bzGX/zDWCs6uM8bI+pH3tG/DlGnJZrtlR6aQSixYQXNlezz6JrCl29
         5KXAmWbTGZQjUifQqxwra+LJwTdQhaIQHEukf3NgxkfJoDGIE1U/0NF3BfXmuMRrH2YD
         WfF6BqInmKXkv18Fw4OYoKis4aUpX8Dw9hT7Hso6zJkAXpLm5/JDz8vmq7z4fAIjGTa5
         xfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710791653; x=1711396453;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1flyVzcCsetu9NnMLrvXhAj5dUurHhoT3CHQTlJfpY=;
        b=YxplFkrdUoHyCFk2/LOLtqNA6u6MUy25MiWEeEctTtvUuDrZ3BUC5h3q2lkSZFT7Jj
         XR3k7zecgHxlNQyK1C8h2KSqupiwVtVOEV9qeYbgCt+Bm6fCUPmrBXFdlDX6/vcXNOxH
         ELVavS1W3DWzvJseoXrAyjHYPs2eqBt8DQICDyj7yt02Fye07qjfeLJo5KjuPgLrCfXq
         RjNzURWewy084jdMLt5XLl2HSU84Lrnv0HiIubuo/v1R0vnNN2ZjA25BGUQQo0lPrfLA
         ikyTe5DeYnGFAF140QPpwW4sjb27iC+Hlm7RuFSdPc7uCTM8HmEWCWHkRzHHEmsl9iHl
         H8WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCxks/tpty91xZdozgRPAQ/cH7nVgHj6uiXX3IfHIYfzwm3k6VGeJ8+W0+DQg7sLB60K+ctEq0A8zflEvzGcaG5LCBToDVq/KRrKMJ
X-Gm-Message-State: AOJu0YyuNkHuPYkcdQCAa1qfj27d5yGYn8BoB6g3z2aEX8yBV5Rmbez1
	9k723rkyAnYt36NEg+w1P5OoMKEsgzxtY0r6rQweU1LtzoOo4k+4NK55rJx/QjY=
X-Google-Smtp-Source: AGHT+IGbiu9tU1tVXEcAIkUX6PVrEvdtAe8aYJQQQVayeZ/o0UATixwN7ebHXpAK8s+vohROKCqzOQ==
X-Received: by 2002:a05:6358:7e92:b0:17c:1e63:d02e with SMTP id o18-20020a0563587e9200b0017c1e63d02emr16325655rwn.2.1710791653519;
        Mon, 18 Mar 2024 12:54:13 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.68])
        by smtp.gmail.com with ESMTPSA id d14-20020a63d70e000000b005dc36761ad1sm7744927pgg.33.2024.03.18.12.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 12:54:13 -0700 (PDT)
Date: Tue, 19 Mar 2024 01:24:09 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v2 0/3] Trivial code cleanup patches
Message-ID: <cover.1710703217.git.ayushtiw0110@gmail.com>
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


