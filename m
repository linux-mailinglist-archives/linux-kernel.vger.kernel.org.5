Return-Path: <linux-kernel+bounces-78395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC978612E9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A8A2830AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DB17F7DB;
	Fri, 23 Feb 2024 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O1pfL0Nj"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8666280B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695578; cv=none; b=eYIi47quYRXUWptev36wCLvlwgHEn5aIShi10fMDqCmTNgzu43Nu56K/sBBh8vWpOUBPb5PM4/UJ/mcsdOCi6mzKD7VLAwgi7eb9rtAbc+WLFWpQdFfdnBJi65I7i7fRjMEpm8o81WYclPFixd/8w6kamnx+psq/w1gdZLSbsAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695578; c=relaxed/simple;
	bh=Twp7tfSTw0JcrYxColLY4Ax9TG/pkPRhM7VLYkZRS4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fcOvLTO+HAqbLOOmAxSM9jTgTuzW4wPJYTLPdzM/O/87iwkV7tYuudOYDU+L7fMkIYh0wwmhvZoPTx5N5PEIQuDTv8PQq4c9tXNRZu7l7IZ4bxDOvM4fANBh2g/C2YxcT33pYcOSRISwKWAHS2OrpfUCd1HBRwFiGX/dgJT/s50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O1pfL0Nj; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c40863de70so44332239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708695575; x=1709300375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4x2sMmK8Ljy9DYC/W73ZknuhG0GdB53Q7DPx/D50TQ=;
        b=O1pfL0NjKwcPNi6v4TRbX29zYKLHT9rMUoyBA4x2AZuL0ZSjaepb9uKDoEpUo3cMzk
         pJ9Imwnzko2bF3xyF4oqRTx3yD+bDoWAtWke12lKiK1u8FVmMYJGv8J2C24svYf45wow
         xTp4qQ7ZXEjU1BbrXn5OZ5+fmmRd7M2ERjJrtmT00sj5N8j1m7DmsgMNOtWy11a1fKPo
         hcJpWg8Baju6GSUd/gPvjBVW95iGZhqW/sUnGZfMc8y420mj4lABxgkkREtMgbtuiX7t
         x5sulLg0C39I3Dyt0Tk4ZZ6wxXAdpSwCzpD1TyKtIhVYM2/ckv/0/PlqMbrtc+tbvB9/
         pxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708695575; x=1709300375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4x2sMmK8Ljy9DYC/W73ZknuhG0GdB53Q7DPx/D50TQ=;
        b=sYdht2RZax2KzNPdm/a87vb/mEgnOYFffk4F03WiYg2x/PXpd56fxYfcq2BtEKm5nN
         vUHnpZ49AVJOAFeqwcOJ89Oqljdb9+xZR0kFw4ZKVW8oZ3LMvl1NyKQzZjeAbP8IjuMF
         6/1cwNIOKXIc+XoEZNEmunFrn8atWUMzkBpL167U/5vaAs4Fo0UeR4NE7iKCuF6G7f7T
         jLe97S0L5KoqTBNiurNEKnDU2eKqDehUhjaoBPylibNX3MAWNFSJsk6MTM6ehXH/eU+7
         G+RHaSVrzxJl4bz/EjclFWtOQVC7uEX37BMd76cE6JsgwTgn4Bhm5mfxS7tbqNuNG4Zo
         V4pA==
X-Forwarded-Encrypted: i=1; AJvYcCUH+5l8Mzoykf+ZT1qfFV7w/tpfVQBvol0TNO3cTHBoUGMN46I7tTq0lbCxvvzhM7hwoLpYxogQqy3tx1ljvC3xt2e+eLgiPdhNgVn+
X-Gm-Message-State: AOJu0YxWA/tWeoCBJA4RugoXwQrZivym9hO0xOAy0GixKmb7xmmDldgF
	6mjhGVEAtIiIWTR0j5QW8EMMGok7xwVmLiVoV5xOu7vpJDUqFBoAgezVF6n5e1E=
X-Google-Smtp-Source: AGHT+IFrz5R0BlotlFi4jZ+FPrD+nKWN+cqkiTi9yfrUfHfyDhCGmqbGauLW7N/Kb+gQyn8NGnS1AQ==
X-Received: by 2002:a6b:c90e:0:b0:7c7:9185:e58e with SMTP id z14-20020a6bc90e000000b007c79185e58emr1936714iof.12.1708695575154;
        Fri, 23 Feb 2024 05:39:35 -0800 (PST)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id p11-20020a6b630b000000b007c76a2d6a98sm1836838iog.53.2024.02.23.05.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:39:34 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/6] net: ipa: don't abort system suspend
Date: Fri, 23 Feb 2024 07:39:24 -0600
Message-Id: <20240223133930.582041-1-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the IPA code aborts an in-progress system suspend if an
IPA interrupt arrives before the suspend completes.  There is no
need to do that though, because the IPA driver handles a forced
suspend correctly, quiescing any hardware activity before finally 
turning off clocks and interconnects.

This series drops the call to pm_wakeup_dev_event() if an IPA
SUSPEND interrupt arrives during system suspend.  Doing this
makes the two remaining IPA power flags unnecessary, and allows
some additional code to be cleaned up--and best of all, removed.
The result is much simpler (and I'm really glad not to be using
these flags any more).

The first patch implements the main change.  The second and
third remove the flags that were used to determine whether to
call pm_wakeup_dev_event().  The next two remove a function that
becomes a trivial wrapper, and the last one just avoids writing
a register unnecessarily.

Note that the first two patches will have checkpatch warnings,
because checkpatch disagrees with my compiler on what to do when
a block contains only a semicolon.  I went with what the compiler
recommends.

clang says: warning: suggest braces around empty body
checkpatch: WARNING: braces {} are not necessary for single statement blocks

					-Alex

Alex Elder (6):
  net: ipa: don't bother aborting system resume
  net: ipa: kill IPA_POWER_FLAG_SYSTEM
  net: ipa: kill the IPA_POWER_FLAG_RESUMED flag
  net: ipa: move ipa_interrupt_suspend_clear_all() up
  net: ipa: kill ipa_power_suspend_handler()
  net: ipa: don't bother zeroing an already zero register

 drivers/net/ipa/ipa_interrupt.c | 50 ++++++++++++++++-----------------
 drivers/net/ipa/ipa_interrupt.h |  8 ------
 drivers/net/ipa/ipa_power.c     | 33 ----------------------
 drivers/net/ipa/ipa_power.h     | 11 --------
 4 files changed, 25 insertions(+), 77 deletions(-)

-- 
2.40.1


