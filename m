Return-Path: <linux-kernel+bounces-60843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9C7850A19
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22561C20F4D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5AF5B684;
	Sun, 11 Feb 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="XaXKuMmt"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9339338F97
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666274; cv=none; b=eGOFs6JvVanhanimVvJEqbNPBjJe0kOXmYt4NV1HllEv+jwtUl0VPXRcQKHz+MkF7PEnhQU3abhlllXkhKs8IqRwcrhW9t3kHa+GzjEg/oWfLw47jvwaDlJgcqH1p5ItpJ7BPebPCk4Jr/BtruY2Y4WY4Gxi7FC5tBGb4J58Rys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666274; c=relaxed/simple;
	bh=gEOm0A9HxhtT0ToHBtW5wPYxu1/NZcFG8ycY66XAqQA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=igmUD7aMnX6JvHb3msprG1OtOCG1o8p7OlldWORex1dJOO3c/Lw17rbCm6l3PZEIHu/4/puxhUoLrmn2+/tJ+em4o+moaJ+VOzzquE7svERzveakZMG86LynDMk3ml1BEZERjd57pIW/hehQwFsDc5IjzIzZteX9ARPO2tUXDdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=XaXKuMmt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d74045c463so19425155ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 07:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707666272; x=1708271072;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5tNlqyKVcD2JCRQKsna6Vl1wVCfVwrAQA3PsQcUJP04=;
        b=RzZoaytvgoZlrp5Pg8jCCPzSokXEctZoXvD7sp9l8dWj3IF5AGOtPZHK5JmATRFdeh
         RHcBjYa7pCrmXY1pS4SdhSUdXBsShwQmhIpyyrgD/HsyHDzzb3AZKHuzCWPq/f1TAda7
         swft0lfMGCjiEfN35SzA4nznxbOFWk7SzUhhjIsc+zGOAB+6ZleD+hP9hLHXUlV70jMT
         UNEI7ym+wuFOQS3GWNRkP5A2B4fDWyGU0kcuTBf9WodkZ6tROo4azS6YM2b7BWHzrqOU
         rjxmKJyTB0vsLJ1kF+pzb0EBb2mMW6nOrZRR/bh50qyTsVuzZVtsB2lXKksHcnBkloiw
         TjjA==
X-Forwarded-Encrypted: i=1; AJvYcCVF9AMRVy23JiZbxgxYhuaPRE3fGc1uQT8CcOJyFnBrFTgWKirZc9OaU222RUJJkmY3pgcU4L95wftiekPw/byjkWAvvHnq/GU7CuDN
X-Gm-Message-State: AOJu0Yxzgm4XTx066a/2GQpmCSshtKpiVJ7GD32O7rM6RYM+8Nr4yZR1
	+NcyfN/OKd8d6SCGdi5L82LYr6BB4kIdY8mGSv59aCRsy/eVS0XI
X-Google-Smtp-Source: AGHT+IEL9ClmJ2nRX1SclKFcrqCXlbb7x1e2l9TyBORDkkAGAFtf5V6iUv4wGJ6iz8p6sSfwm36vdg==
X-Received: by 2002:a17:903:5c6:b0:1d9:5b8b:f70 with SMTP id kf6-20020a17090305c600b001d95b8b0f70mr3637223plb.29.1707666271856;
        Sun, 11 Feb 2024 07:44:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8uY+mhJLy/dvFbmj/TX2JuLJqu613NusbhxlLuIpZukluRkB/2ZEgoTeBU0WlI1Dvl7P7pK8iDbMvYyVPchibFdQ5PBI2B+e8lvwWGGVQnIhAblma4EH4IJguvnDeTWwOtW8JC4JkSQ==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id mp6-20020a170902fd0600b001d5f1005096sm4447053plb.55.2024.02.11.07.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 07:44:31 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707666270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5tNlqyKVcD2JCRQKsna6Vl1wVCfVwrAQA3PsQcUJP04=;
	b=XaXKuMmteTv78/6BoE7RVYQEmpZ4EJI7nPkrONG+lQ8Owtxr4ccW4u/dafdyfD/nlhdc2n
	di7zJdRH/+X19Ke6FcjSWb8QL9Is+oVqs4ryZMqEqgOIHb892/AJsFkN9d+GFuPtUZgOUl
	+nsyKhUuP3YcuBGDhQGaoFMeIHwgBsWthR9B1xIXmAaaEMMvK7IGRj/HadusbPViGjELZ3
	tAT9MQ79mkJNf+2l2K7KwLQiOldTCbyaaejEsFYzoFtMlxJx68U2wnNEDD90L7KHmid4Mp
	QkgzDHe/fkbjEsxWU5+5wb1I9caA9pYfWmpedAzyhplFHwN/13CssyXLK2w6Bg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] ARM: struct bus_type cleanup
Date: Sun, 11 Feb 2024 12:45:06 -0300
Message-Id: <20240211-bus_cleanup-rmk-v1-0-65668e578d55@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAILryGUC/x3MQQqAIBBA0avErBNSpKKrRITaVENl4WAE4d2Tl
 m/x/wuMgZChK14IeBPT6TNkWYBbjV9Q0JQNqlK6UlIKG3l0OxofLxGOTTSzs9piq52qIVdXwJm
 e/9gPKX0Y+DssYQAAAA==
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=gEOm0A9HxhtT0ToHBtW5wPYxu1/NZcFG8ycY66XAqQA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlyOuDFI0/PkQL9gktx02ndKh8QoAMAX6GtDPG1
 zbBQU7ST82JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcjrgwAKCRDJC4p8Y4ZY
 ptEoD/4krvVw1nJlgzCNDYjJ8bvrX+m4GkoB5HoFkdBRwc9k8QK0IoYvJAnk/9EORt+WvvhnwXc
 HIuVI7MZ++bCtIS+g8s0IlxAdV0y5OmEy2c6IJDbE7ykdYEVkeYYyHBKiJGcWUzfgS9erN8xyzh
 QsbI810VduufeV1jPNwd6thPaPibazoUm8lD+/oru9HtOxXDiiz6gKPBUMGSlZOU/K/YVHitmH9
 GlT7THXuubFH5jPuuDhri/ExzDyE3ut5fwYlh/YigiqxT0NmkxUsjQVYRfc7St4lzLe/6jCZgVR
 wyLWT50/XSnpw3JwaJkFmHbyGolbM8M/js/DIyevQ8RUCLfI63UR+jltqDgd8TRr19bhfzNOhmH
 BZz4sgbOkOV3d80tx0/4TgjWGXdPeMoHqbqxmwfuROr2HLQMu26ylye47OxjxaTSkegewHP4BE8
 TBZ19vnzzzUGUEez2sqyQFgdjZXAUm/cZ1MU4bEHNowxgmMceUdGHPV1zfL2IcoZ3UWdbCCEW6J
 PK9qZZ2qEXOLR7erG3/5NzJXyL/2RaETHRgjAVSOjn/aTyY04MlarIi4TklRUKMocoJyAyAq2ct
 iKXTThUlH+JGETv/lU37N5JLJzPGjzKkzNHh96W64QNgaGBBR4qKNLxc3GNfoQ22zZfsdW1pjBZ
 zcYY5mR3IMQadSg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This series is part of an effort to cleanup the users of the driver
core, as can be seen in many recent patches authored by Greg across the
tree (e.g. [1]).

---
[1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Ricardo B. Marliere (2):
      ARM: sa1111: make sa1111_bus_type const
      ARM: ecard: make ecard_bus_type const

 arch/arm/common/sa1111.c               | 2 +-
 arch/arm/include/asm/ecard.h           | 2 +-
 arch/arm/include/asm/hardware/sa1111.h | 2 +-
 arch/arm/mach-rpc/ecard.c              | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 8790fade1a19caf714ba1d91ce1fdceb9f2067f2
change-id: 20240211-bus_cleanup-rmk-7fcb4be84c26

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


