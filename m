Return-Path: <linux-kernel+bounces-86079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B0986BF4C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12321F2407E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6F137155;
	Thu, 29 Feb 2024 03:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5T64va/"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C552EAE5;
	Thu, 29 Feb 2024 03:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709176080; cv=none; b=fApMxTjlrcSGhEjLNFVNJafbxzkooVyBeZohCT8r9P/mLxW9cLXGju81QdzbhLcspJc+4zt6etCR76THOgLczUSfWofzajMhXIMTx4gCDIMVq/xenucAlVeMBbqzVlQWwvZxJ3aZki/4PmbtmeQdGHaxj7Q+GDB4Y41/yfni7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709176080; c=relaxed/simple;
	bh=WxtnRfVycHp+xzWlunm6r8qLU8tq4xLTOZNgwowCK54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dh0PQPDTkfCMGaGs2Jr4La3JE41bySt2aHrCrGtZG+JbgFEcCXaCRyOGI7t45BulEC0pADSJi5jKMspsqmBAQLUaxchyL7foXoZUUs9LNKPcxzgMIr5Cl1h/ZMUe8BDz4zr4uidZ1p06OwHIc5D1OdURsLldAgto4JA6/EIWATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5T64va/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412bcb76947so1066365e9.0;
        Wed, 28 Feb 2024 19:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709176077; x=1709780877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EkouPOMvFWwVrVc/fIndlp72UUd7z+dXVUSYXm0JMeg=;
        b=O5T64va/4rIolo21p7z7vy5bLCOeowr0hp8FxUI4GihRwGtcr5CcSNHp57k1YgWI6U
         3Cx+JKHFG0F0mZEYOYzDuTOZUwQm8xppAph9huV+9mcsFqd1p3qWx8riYhzKKcv78vVc
         ONk08alPMzfQo00EO7nuvw2QbMhmrGQau2av80fNGWYVXppAEy/8AyvzaBLr3+3fk6Ln
         bx4k0bgMX0vvXckwA6lGMQjQm7kvcmeAap/jyQPI7QmQO7CGzfK42xpCxqS+e/EO+vE1
         1TAtZgzpaEUCh5kJu7gk4f602/RBI28BUO0mfypcWGUXA+O+maQ6+RMWkMCYreo4MsNf
         ZKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709176077; x=1709780877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EkouPOMvFWwVrVc/fIndlp72UUd7z+dXVUSYXm0JMeg=;
        b=KToVsGth+KJmkRMuLkENPF01Se3RyEf9j6JgEX0zFhxkUmeEWa1OkM/Hm/UMi7rbuQ
         Uq/+0x6//uc+IwJMgmW7MtSoRcNmGL4mz6tFVtqBFpG+1aZ9di3ul0RjjZwIbgVZ/HUw
         JrczmZ/pF5avCvnaRH5HzLd5wIG65E5EoH/jgPV5T5SOzS2ZqlMnmjhtZYNisTcDnI+P
         qZPYpP6QKkFm3hexqWDQA+tNKCpuFqMOSXTmeVcOWF5h/NAITYIMdcoaSxR6JyDj2CRz
         frea/kGwn43T8Eslw+yYOExc7/AexxvUWG3DP8MOLasligVI9us1iWGqqUkFFLyBHGaC
         qxiw==
X-Forwarded-Encrypted: i=1; AJvYcCV2mt+TeMTkggM5x+SeMZhhWZ1Zml/L391ArzbQS912YdnNey+Xz9ULt4UBM/byUlk2a8pYOTZmkR7QbJdQBD9zxBG14DJA2h71HRtpWdnrY0f5tZySkOnMS1/XdXxKdY4b2vC61OLXAZSjvSXzyBZhHrsTJf/qWWRVY47XRosbwN+m
X-Gm-Message-State: AOJu0Yz/C5i4WD8+J9BY9MNXOleR2LXQdLh8SsQVqHzcYFhWc7DxWSPL
	O8KwzX3+BllFqFZ0L41nWMd1IcL2pwCD1ji4fC5iYWYRWqByhdsD
X-Google-Smtp-Source: AGHT+IGLmFULnNY4TZd8PUVFn9bO0FwgIL17RntH5YTBWZKjxAYejAU9aihel6IHqb9kL2zIwG7MjA==
X-Received: by 2002:adf:f30a:0:b0:33d:6186:3ca0 with SMTP id i10-20020adff30a000000b0033d61863ca0mr472405wro.19.1709176076447;
        Wed, 28 Feb 2024 19:07:56 -0800 (PST)
Received: from lola.. ([2a02:810d:7e40:14b0:d371:e319:5dd0:9b35])
        by smtp.gmail.com with ESMTPSA id u1-20020adfb201000000b0033b1c321070sm417512wra.31.2024.02.28.19.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 19:07:56 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 0/3] docs: submit-checklist: structure by category
Date: Thu, 29 Feb 2024 04:07:40 +0100
Message-ID: <20240229030743.9125-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Jonathan,

this v2 series addresses all review feedback of the patch v1 here:

  https://lore.kernel.org/linux-doc/20240226104653.54877-1-lukas.bulwahn@gmail.com/

Immediate actionable review feedback was:

from Jani Nikula:
  - turn categories into subheadings
  - use common heading adornment
  - change to bullet or autonumbered lists
  - propose those changes as separate additional patches

from Randy Dunlap:
  - if subheadings, drop the colons at the end.
  - acked change to test with linux-next
  - Stephen Rothwell requested item 1 to stay item 1.
  - pointed out swapping the config names in the commit message.

v1 -> v2:
The commit message of patch 1/3 is improved addressing Randy's
feedback on the commit message.
The diff itself of patch 1/3 is unchanged.

Patch 2/3 and 3/3 addresses Jani's and Randy's feedback.

The extended discussion and feedback was:

  - Is the checkstack script worth mentioning or can it be replaced?
  - missing some nowadays more important points.
  - consider getting it coherent with submitting-patches.rst

I have put the extended feedback onto my todo list; for the next
iteration on this document---after cleaning up submitting-patches and
making the howto and submitting-patches more coherent.

I followed Jani's request and created three patches, this might help
in the next/final review---if any further review happens now.

However, I do not think the kernel repository needs to be swamped with
three patches for this 'logically one change' to a single document. So,
I also squashed the three patches back into one patch, sent out as
PATCH v2-squashed:

  https://lore.kernel.org/linux-doc/20240229030146.8418-1-lukas.bulwahn@gmail.com/

Please either pick this patch series or just the PATCH v2-squashed as
you see fit.

Lukas Bulwahn (3):
  docs: submit-checklist: structure by category
  docs: submit-checklist: use subheadings
  docs: submit-checklist: change to autonumbered lists

 Documentation/process/submit-checklist.rst | 163 +++++++++++----------
 1 file changed, 88 insertions(+), 75 deletions(-)

-- 
2.43.2


