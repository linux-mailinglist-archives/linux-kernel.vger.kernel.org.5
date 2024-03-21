Return-Path: <linux-kernel+bounces-110172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6EC885B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C6D28480E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BD38528B;
	Thu, 21 Mar 2024 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL5cFI7r"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4DA947;
	Thu, 21 Mar 2024 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032363; cv=none; b=A+mEno+F6v2v3SdHhD3ymoeDHla5d04grVdNiG5lG4iSuSCV9Z2k+V1LHncL4/ZCn9Ix7kD6PSZXMPo1AUEEgWd/dMG4ATQ6oyYgp92v0+HIXUYTpFwjuAEgqruaNdhakUgGqS/k0Ievg97bY8BA8E3eX4CZSl0UyydDBYVfO+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032363; c=relaxed/simple;
	bh=hmFR+A1emygyeDkPd3cRDw5F7A9p/5ewMxdwGilktg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bI/m/BqNB1FxH1b/+90dWQH4hpo3s0ugOXY+/PvNEsXvww+FU5zSMp5EP0kLBLh0lUnhIjjUb1Z+HsHaj36JYKId0gvKSz+L7HRWJXVuxcQSlZjINu6W/i2yLJ/qAMtIcwJhwC7cmjK33/kUd4EVexw8Q8Xd5A7V5TJgowemJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL5cFI7r; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41464711dc8so8842435e9.1;
        Thu, 21 Mar 2024 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711032360; x=1711637160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fb6fGfxlkuJOz49c8nIlvUqhq4r8FWilTvBwvl4ZbcQ=;
        b=bL5cFI7rf1tnNgeGnqCnumumdGlPBxGopBUG7z+pBmhPM1mqCKXT2IQkG+JgHWTvse
         ll94QPvkgThLu0zpeoC6N3p+yrzNbdX8sbpMleZTb2QcwQhWjklchqlaNriBCnBXpgFz
         tGWCF55Jah87Y1o2Ez52FyAXR6LFAbktHk29bY1Mq8vvn+mg73Xc4I3fTuxxF5AVDsOz
         eskNpZs+A4EOjD1uzPDktJm2f6yYmZH+TRE5LPqKozjkegEqT4B3b83jb/qcLtquUNKK
         GvDGfJMWMlKQJUyq9X/8HlJcXnqitNkF3G/t2fWAhesKIeeuyoz8FuCSmMgyuIlmjx+8
         K5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711032360; x=1711637160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fb6fGfxlkuJOz49c8nIlvUqhq4r8FWilTvBwvl4ZbcQ=;
        b=txGvVfz08bBwis2Bb+RZ2JqQgZvgrsRs++fCDsrh3cH+owz/45tc9tOJ3d95HMOq7f
         38JxGpn1YpdJ3Zs78YTDj86qKZXeCFvFLxqDnE82Se3CQWmAK7jmHxlcx0wKP/s9239S
         HFsU4tRNSCWicGmgEDWdp61PJ11SK9/TbUp+k0l9QMZdFMv/G+4hCA0ijK7zk66CVlLj
         stGrL8UXb9PS4dQnNLTX0ilzy0om8usPz3O1uQXOI2qRcOwLp/G/Ik5J0DaJV2uuD62J
         ULtFAD6VoQlBdv9ZqbUzc6K9ktSBHJ/ZGsLhNqbxhfmxBb6KcxwJvdYmzHmcAFLcnl5D
         //PA==
X-Forwarded-Encrypted: i=1; AJvYcCVlXcLDh7qex0S0LsI1BTym/JTXZcj+iRjyW7d0oWfpXzXREsINuYFX2x54QvaaQ3O0t0hJMoIQFIoAWGDXl8u4H+XT1CJgWkTKCThc97Rel8ZNflRC4VLhxU+6KOa8icQoIK+BYNYxjnY=
X-Gm-Message-State: AOJu0YywI5WyH/PcUyUE9AhsMqXEMRaue58G1z/xxOEWD9+B/DEQa2Lm
	jDuFyGtKFil+Tqt954069Cr1Jmx2WhrCuAiGjUCMTqSAiTTYEs2H
X-Google-Smtp-Source: AGHT+IGOnpTSDTXcx2YzcYG1iGrfHlL5tUyK4tl9tQ+b3d2DT1+yOy/4J3eUUxg5Q0xXnmjv2XZ9Cg==
X-Received: by 2002:a05:600c:4f0e:b0:413:f3f0:c591 with SMTP id l14-20020a05600c4f0e00b00413f3f0c591mr4896762wmq.41.1711032359784;
        Thu, 21 Mar 2024 07:45:59 -0700 (PDT)
Received: from fedora.. ([94.73.33.46])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b004146d736fcdsm5253378wmo.36.2024.03.21.07.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 07:45:59 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/2] Expose firmware name to identify tablets in libwacom
Date: Thu, 21 Mar 2024 15:38:03 +0100
Message-ID: <20240321144553.262409-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi everyone,

This series exposes the UCLogic tablets firmware name to user userspace
via sysfs.

libwacom can use it to identify this family of tablets, which has been
very difficult until now because vendor keep reusing the same VIP/PID.

This is the PR consuming the new interface:
https://github.com/linuxwacom/libwacom/pull/620

Finally, I created a tool to generate a list of firmware name <-> table
model for UCLogic-like drawing tablets:
https://github.com/JoseExposito/uclogic-firmware-names

Best wishes,
José Expósito

José Expósito (2):
  HID: uclogic: Store firmware name in params
  HID: uclogic: Expose firmware name via sysfs

 drivers/hid/hid-uclogic-core.c   | 16 ++++++++++++++++
 drivers/hid/hid-uclogic-params.c | 14 +++++++-------
 drivers/hid/hid-uclogic-params.h |  5 +++++
 3 files changed, 28 insertions(+), 7 deletions(-)

-- 
2.44.0


