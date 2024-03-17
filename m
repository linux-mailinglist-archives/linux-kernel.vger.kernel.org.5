Return-Path: <linux-kernel+bounces-105515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD9087DFA0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53A01F21233
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F51EB35;
	Sun, 17 Mar 2024 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzUhF2QH"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0EB1DFF9
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710703481; cv=none; b=EAFL8IAETet1uMFDJZ/Pgpg3hY/dfrjFDPfD5pKBF1P5C6wvJLRHsie2K2ZeuIGLALjSBM7MEOyt5olRChmUUq0r0yOXwdYIhpHx2PyLk0U1gA3VqCO/REmXF/MxiT0eEGN2ZLogwnH2nDj48AN2Yk8jFh5ZZqYRbvktbCMH4fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710703481; c=relaxed/simple;
	bh=0S8Kcefi0OdWNyioGk8KbiiNHd0Dho2QB0qXQHrsxOY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=svIB0qxMJd253+lianY/kr+jIhBkS5WBxdev5L3xJqAKbQXB1a5UXNCZeRV8cm+40WljxGx5IluMGc7bb/hiGvTiBIhtMfgJMat+gzzwyFwUOy3smHSpSRACKT73oV1mwof2G0G4HZvNxueEF1FqNqoYVGLAZjFn4juJxfey96A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzUhF2QH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29f9bffaa3bso199364a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710703479; x=1711308279; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vqFDKNyxulpVNjfcv+wJMiiAQLx8qUgtgobnsfC1+N4=;
        b=hzUhF2QH5OII6yWXZtnlNKm8jSXInf04mo36WRDEtmayMyLD+7xQVeTBxz34MKSMak
         Y/tc74coNLEfyuP8wEk02B6+eruKRUHx1S5dXi0/Lc2PMs4P6d8hKj4yamqFH15X5d1S
         sUWq/W/ClOHkbdtq2pMSY4Y0AyilPU9kzoO/uZxDX7rCxYYJFRAZ74nvPSAz3azh5TZb
         kAh9Y18il79DojzcJ5CCp94t9+JnME0r7TUFnQV+x6Yf1ewT7dJL9sppaNQ3SWwXgA4j
         nPvgquE9d4cb1qgFi2EJTjAHTsFTY2EWsup0V0ZbUWkqR92LbGNY/7HMQw9rsedtDK1z
         lh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710703479; x=1711308279;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqFDKNyxulpVNjfcv+wJMiiAQLx8qUgtgobnsfC1+N4=;
        b=T67KQOd4AweS0ilLE7nA7bF/F6Oke6itv7CwnDp/HtlvGHjRMCg8h005iqmri7ccqU
         F1wdFZAvpZ0QN/C11+BAA09RP9uYslGMLNVndR2+SnYuIqzYnq2XChTBw+ksjgENQcDD
         QmTScWNH7OVdjB79WT3wWK/MFw2mx8/poI8Ftb/5z44h4cVOi6pja6htb1kZ8euHNiFp
         uLAX4Z5jvnRuOpjV7n2x6e+UeCPzlUCP+hIXtUJJ35yZWu9BObjoqdHL0LsyLKdGhhci
         RC4poR/rHqj1GvD32zWNKOpYVv8TaJC9gLqyHbPEKxkKYdhl7UBn6TW0Cefmrk54W/41
         iwjg==
X-Forwarded-Encrypted: i=1; AJvYcCXMMyTYrJ+VsBiNn6CMBrTPPHG7wFn/E1PnIF2pTP5j/IBZjCbcw6J9skXNC6TnyYiau9f0PCiCWx5a/qUrOTiBmwm4ftxV/efCO0kn
X-Gm-Message-State: AOJu0Yzle9/sAFxAg6LksM2Bzey24Nesn0OqH5vycrPslhzmSw//C8fX
	FEoT2+pSVcA50zMaf4Hz5RE3Z+744i/StHvbYKO3DSEYJnm51F5A
X-Google-Smtp-Source: AGHT+IFCNkW3wFNNzbROIQVGU7hZ5kOn6+RCDn/alz0lJ/YoQ4vr4ATF76Bca4Gf1X6ehftoDcZa1w==
X-Received: by 2002:a17:902:cf08:b0:1e0:115c:e03e with SMTP id i8-20020a170902cf0800b001e0115ce03emr2865698plg.12.1710703479082;
        Sun, 17 Mar 2024 12:24:39 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id i8-20020a170902c94800b001db6da30331sm7619149pla.86.2024.03.17.12.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 12:24:38 -0700 (PDT)
Date: Mon, 18 Mar 2024 00:54:36 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH 0/3] Trivial code cleanup patches
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

Ayush Tiwari (3):
  staging: rtl8712: rename backupPMKIDList to backup_PMKID_list
  staging: rtl8712: rename backupPMKIDIndex to backup_PMKID_index
  staging: rtl8712: rename backupTKIPCountermeasure to
    backup_TKIP_countermeasure

 drivers/staging/rtl8712/mlme_linux.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.40.1


