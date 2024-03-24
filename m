Return-Path: <linux-kernel+bounces-112839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49085887EE6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6BA4B20B07
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1660414A8B;
	Sun, 24 Mar 2024 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwGriz5g"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06ED1426B
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711313288; cv=none; b=AFSDK99aPDE/qfEYlB39H94PQqPi+CzTFI7vT/vDzQ/O+PjlCK4YXdhhk81NK4qXv9iBXA2wQLthijKtSIt4xuL11WabwZbsi53dVwyvnTzc9zLwZ9FWaxF51DVFfOWlKFqWSBlRzmb+EhJR4OVVIeBNc0Lrmzf1DsgPASPX8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711313288; c=relaxed/simple;
	bh=o0ThGP2jpKKCnWSeV748HKSHrZ/Hu6nvzbdySrCVn/k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Zk3BqbgXwhbBXPTeDRQBlKroiuCxX30Fv7mQWVPCJ/wz/bfj2clRNkoh0oTfNh2NHqpZ4x/UBzJQJr6Z4F3LhDiSetY1SNiU2Ws7KQ8pLpfdBopMFpVnqjR0REy0npYAzLrivGmz6BZl7sV8QGJA+07PHiHLl8h3hq6WpF+AJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwGriz5g; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6f4ad4c57so2773600b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 13:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711313286; x=1711918086; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gOr4nW9GygCT5+f5JrX7f9aw7Oxhps1fXXCviiZ2/1I=;
        b=jwGriz5gnO79RGzCwLUZT+caZutsRNmLRYhs3kqaNHRZXBX2Eu3zng/k74f5aT6xB9
         9/Ji253HcTmsL/w2UqpKFaBnIfylbS+0EupBs03umWfkPYyZnMOq2A1dyIInI7WTtqH7
         zbqJ7vcquD2PgBDVm+3TD+sIzSdQ//j5TLff5OhH1UIE2+cJKeqRRqJTQzIokHrnoXW6
         ZHFSkUCtNEIJCuOnOL8oRUTu6a5rlKZrokPkVDa7cY5mF+Hv6ZbUp72FUqi+sieenpii
         FlNrMoHESBbZbHa7YCt02abu/W5BXDv/ygJ/ocR5fQGeNwzXxK7JvvTN5t3f2PA57U2I
         fnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711313286; x=1711918086;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOr4nW9GygCT5+f5JrX7f9aw7Oxhps1fXXCviiZ2/1I=;
        b=C2nekM3DwiqyDVEc/pTZw+o3dqOfkRZsFvR2teve2YP3OSvcw6y6phTcDhXqBZs0y6
         qmilaKWgddl/swcegJii7zOvVXkRRyNYQZxs8wTKZrg/Tq021LI5s+fhSNUsPdeYd84A
         Ru4fX92W0xbla7b+ZomtjRsGOJuBHmR/WhofE+g9bmi6/3ZYbVjn5/7YwcQBOcRlKMC/
         rpMcvY5obeGTss0NN3uKYpoXeLt1XAk0fqDuMN0SjQ9jQj1BwtE5zN5oMqkvZQluephM
         JPLgPseHDYsnDwMRR3CLSTYjvp6yTUAk69X6dr92ePfG8q558Dt57OLywqTtRK9zSG6m
         0UPw==
X-Forwarded-Encrypted: i=1; AJvYcCXqmfOhatFa2NZ357/bR2xeJLejqFIegscIhRY7qKQD0KaGhZ0ELWdIOPmkqlGC9shGCDBuOenFeoNq1HquqfAUCer3tIQhAC21pLZp
X-Gm-Message-State: AOJu0YwVsK//2H7M7p8mPJwj0LRssBD3OhyfV0dSdSCwED7C9Xe7SLZP
	R4DC2n4sThQbeR0xlbmv6SoXGjYft1mZP+o/j6lJu39/DcBCKgQFf0aV+aoqMCw=
X-Google-Smtp-Source: AGHT+IH8zVKwvFo2k5FG+Ns3x6y2zB3+ejGnDFLscJrM991V+62Zie9TTaYq6h0PgwlxBeCuO9Lyeg==
X-Received: by 2002:a05:6a21:3986:b0:1a3:a637:9753 with SMTP id ad6-20020a056a21398600b001a3a6379753mr7952698pzc.12.1711313286020;
        Sun, 24 Mar 2024 13:48:06 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id o18-20020a639a12000000b005cfc1015befsm4726936pge.89.2024.03.24.13.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 13:48:05 -0700 (PDT)
Date: Mon, 25 Mar 2024 02:17:58 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v4 0/3] Trivial code cleanup patches
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


v4: Update the changelog to match revision history
v3: Update memcpy() param to match new name backup_PMKID_list
v2: No changes. Just a patch sending error.

Ayush Tiwari (3):
  staging: rtl8712: rename backupPMKIDList to backup_PMKID_list
  staging: rtl8712: rename backupPMKIDIndex to backup_PMKID_index
  staging: rtl8712: rename backupTKIPCountermeasure to
    backup_TKIP_countermeasure

 drivers/staging/rtl8712/mlme_linux.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.40.1


