Return-Path: <linux-kernel+bounces-75562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0950285EB29
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22261F22C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9364126F22;
	Wed, 21 Feb 2024 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0O+i4Lj"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D7D86158
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551879; cv=none; b=RurKJ+lDs+zQnvhZgOZK2PXEl6gQ587WxUKUrTH+1uBWNAGgq69awEXzOhi/8uDV0rXlrVDvu9mgLvTOIdrakRkRAM+mikfeeXMkOMpFRgviBW1A1CE8m72ZUN2k9P99UlgaNYJhcwdr7RETe3KWZtYoQ33AKt8LdXmBBwAI/qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551879; c=relaxed/simple;
	bh=w6/upBbbVOX2neZWjPgWOwjLXbT/MJOWIoLuxKe+ycQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bhCBW+cpjH5LW7aswTlCI2P6qv4IU24SAJ1oW9d1zpbHMDQ+MjdnkIDU69E5863sJbH1vHpV5Fq5sli/KLQ61jA5Ar4hq8xKp6XOWHJo8ja6odqZrWlzNWH+qiugHA1y1+/4iDRAQKmxijiX+f1AvWzkBXh8nGL1b+8CPKgxcLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0O+i4Lj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d449fc292so85681f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708551874; x=1709156674; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9gRpd2/XJA05Kc7l2MYELGuRxnYw+uQz71chRC49KQ=;
        b=h0O+i4LjWRZUzLffujXpVPojCE4gXOiliqqzfPC4rFvOboIKNm2aESfz/sDOFR2RBw
         PhJLahs94dNHGzBPWG27RZCGzEzuAzksQFfsHoRMIjyKy2Wm1f1RK7+Adjk86Ba8T/oF
         YWxSemMG+1SvTCKLptNJDZIrwDpDEv1sT8NYMKtoiOezLgKEjFwCKBzIV6tpdYMl4JFr
         wfhbndobno/3Q9cpgri6JJ2c66QjSEvVvkYNQP0BxOjGiZmMY5LvLqAqzUBL8jGd+36G
         7DNtkwsOUDBda2wTs9LPMH4wIgdxO9CHbKc8r6u8oBNQuxFLYXgiN/BHPGY9gZNe8WEv
         313w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551874; x=1709156674;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9gRpd2/XJA05Kc7l2MYELGuRxnYw+uQz71chRC49KQ=;
        b=wANYuKWVnypMy1+5Rmmm7uAWt6L0xEWYEzhT2/0SrzDs+bWEQ8p/mcYMxB9QxN/rfb
         Te+jL9N1Svdg4QKrbkR4ku+F+X98K/nWjzjDEvTqPtB2bvwrmaOwPWNoNYTNCKZsHHzQ
         4BOXTtN1mYICOPR96SUbuSU0DKKjLsyYMyJHo9cX7Knrr32EK+s3Xu57RkgFZBrflXjs
         vQssCHN4RVudS3DlBY+voNxUWNsdZbwlnU80+esePtLWqEVlQ5HxnueT6eSpICBXGPxB
         wsvxvkLjXEw0na5IQMYAS3UeMiH/fpQNQQ7SFTnOd/q7b/q5kdF5RHG5IiLqJ9+6hbPX
         z8bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXATmW7pqikHcF56i2LBUnn/4XuQPZQommzBlRou00hTNNHeURS79LzzKZne/mXWEpoTV6uAFuUX4u0g1TU1K4ajMh6eAijHyeLeg0Z
X-Gm-Message-State: AOJu0YzkHXEtp7sKmP0ztobKxsIieZwzmB/ea0psTSyHYCXpuvLxUQH0
	M2w4MO3qNl5Zx1Vs0QazcTRjlrJ8hlwo78tnrGkLRgElb272UJpJ
X-Google-Smtp-Source: AGHT+IHV2f6siKZmt9s061XJbXxmOcZFs4yDgm7j5gmLk41hx/4/Emys54msjb15wy5+dMwF9Bwblg==
X-Received: by 2002:a05:6000:38d:b0:33d:8cb5:142c with SMTP id u13-20020a056000038d00b0033d8cb5142cmr120816wrf.1.1708551874235;
        Wed, 21 Feb 2024 13:44:34 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id cl2-20020a5d5f02000000b0033d4dab14a8sm11991310wrb.22.2024.02.21.13.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:44:27 -0800 (PST)
Date: Wed, 21 Feb 2024 22:44:19 +0100
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Remove unused variables from rtllib_rx_stats
Message-ID: <cover.1708461563.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove unused or unevaluated variables from struct rtllib_rx_stats.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (8):
  staging: rtl8192e: Remove variables tsf, beacon_time and Antenna
  staging: rtl8192e: Remove variables Wakeup, Reserved0 and AGC
  staging: rtl8192e: Remove unused variable bShift
  staging: rtl8192e: Remove variables bIsQosData and RxIs40MHzPacket
  staging: rtl8192e: Remove variables fraglength and packetlength
  staging: rtl8192e: Remove unused variables nic_type and RxPower
  staging: rtl8192e: Remove unused variables bShortPreamble and
    fragoffset
  staging: rtl8192e: Remove unused variables ntotalfrag and Seq_Num

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 20 -------------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  2 --
 drivers/staging/rtl8192e/rtllib.h             | 17 ----------------
 drivers/staging/rtl8192e/rtllib_rx.c          |  3 ---
 4 files changed, 42 deletions(-)

-- 
2.43.2


