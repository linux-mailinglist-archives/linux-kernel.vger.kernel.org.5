Return-Path: <linux-kernel+bounces-97671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8BE876D5C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931041F2266C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740FF39FC0;
	Fri,  8 Mar 2024 22:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUiglckr"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3598936139;
	Fri,  8 Mar 2024 22:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709938537; cv=none; b=XFXvBbuQEfZe5gk1WyFaEWA1/K3/zBBSEVXS+Y7F6+x9zuWORwl2fTbDG1oGed+rLfilKbfMayrb7l+R1iewOIY8LVPKEXsrRQimvuHYKaWZDKeykmmKgzpYSqWwEPTIkMf8harR0cpjM7vpTl0OXKZbU52Ak/8SgOtS7bsKhkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709938537; c=relaxed/simple;
	bh=pfSg6It/BB7aJ2Ztply1ld0UBZWdSEmCaafMV+dOaHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JjCYgzwHJ8rPayrM2magsSdY5hLAYwhrKU3e2xLZEsJSpI0rpTjbV6ub6zhlJ1FbW+RxYpnsATLHr1s6kwVT8c9XXvnqybOPkJPNtUOTOErndETzO75sCQeFZqgBhYdBQAOqVXQyQQsqgnSPBpQ49oOhpnQxtffIdvm8tfKX1/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUiglckr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d38c9ca5bso1448646f8f.2;
        Fri, 08 Mar 2024 14:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709938534; x=1710543334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NYEGJ3+KsY3Gr5UtdEMMKdOU2b2xTlEcMdWaY9cKiX0=;
        b=EUiglckrfWJ7v0RsvoRfOu+y5LTjRjq0gVrUda6+gtHHiY4cql9ui1WFFXEew81Lpn
         hBA0bNDdIpvuQd1HRsc9HOi5aGxPTa+n4h301KUUVR3Tw+6nSyxAGAxQqYa3P2wXXq0u
         0XslnrILKxVFtmOdBjXVUKRXpOUp/Ce3582OEQLLV770mMqMKmnxnW+GvB6kzHtKjdZs
         2X45o+hzIqtSCVgdZSoaZX/eP+mqEwSTmIGaw1cMSQpM1aw5QgWTPRzjqbvRnDdvcR9X
         MiGmsHub1lC61aLkYS2b6SkPAQR+WnnA+MpiIbGX3K1HSLv4bRoyM9Rli/2RdcMLY8yI
         2G0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709938534; x=1710543334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYEGJ3+KsY3Gr5UtdEMMKdOU2b2xTlEcMdWaY9cKiX0=;
        b=uARq8VsGgRWDUtjkfte8I6H98rCkms5gmXiJGWwEIOGrRYNuTR5jY/FdKW13g9/FcE
         UIom7qmjOc0pwusrPohH6CENzLFBT4mAqH77uvoxEhwS0top5f1W0+b6L1HxZO3R56KU
         x2ph4FBpoXHs37wiXjRCXCpWb9fJs6KAIsBJaVMsPnY5S8hqg5sV2uBjK0mSZ9LCER3k
         1exauWTGRmmiHryxzHzBS/QYt7qz0bHPwwa5dqWipR/invx8F5MF+bqZ3f1QRBwwF/rF
         NQ0a7MVUIVKwp9owAEbMYkiHZVD0ZuiJA6iFIkk/pvB6jjbAl6EDsmnOeEAziV2hGCCP
         ToOA==
X-Forwarded-Encrypted: i=1; AJvYcCVytFiwfVypg7lun199DHYWXixHnmRnNkMeWQUG70HPlv5RoMIJkIjmoWUKSPQPGX2KbO0R4x5VdtCbo265vIhbzztcCQZMsD37OCH9
X-Gm-Message-State: AOJu0YwgxXzIweg20q0NouQ0GmUY6vrIVhlWtl1y9daFUYaO6FXNTTqR
	ni1T3/XN+fF93QFLo0w5aDuJwKREzKdpqJCfN5IYmF0ScstCdZQMn7zUVa/2
X-Google-Smtp-Source: AGHT+IHPETF3Ift0Imjx2qP+woHemr9mwseZ/sG4FNO4Tgl7m0MVLd4Ar45Yui8oflOwdkPKAqxIYg==
X-Received: by 2002:a05:6000:24f:b0:33d:6ef6:8762 with SMTP id m15-20020a056000024f00b0033d6ef68762mr326282wrz.29.1709938534350;
        Fri, 08 Mar 2024 14:55:34 -0800 (PST)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id q27-20020a056000137b00b0033e72e104c5sm473743wrz.34.2024.03.08.14.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:55:32 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fix for 6.8-rc8
Date: Fri,  8 Mar 2024 23:55:14 +0100
Message-ID: <20240308225519.2098316-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72:

  Linux 6.8-rc7 (2024-03-03 13:02:52 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc8

for you to fetch changes up to 321e3c3de53c7530cd518219d01f04e7e32a9d23:

  libceph: init the cursor when preparing sparse read in msgr2 (2024-03-06 12:43:01 +0100)

----------------------------------------------------------------
A follow-up for sparse read fixes that went into -rc4 -- msgr2 case was
missed and is corrected here.

----------------------------------------------------------------
Xiubo Li (1):
      libceph: init the cursor when preparing sparse read in msgr2

 net/ceph/messenger_v2.c | 3 +++
 1 file changed, 3 insertions(+)

