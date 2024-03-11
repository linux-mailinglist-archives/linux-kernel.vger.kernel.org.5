Return-Path: <linux-kernel+bounces-98589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D58DA877C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133821C20DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E0D182CC;
	Mon, 11 Mar 2024 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZvKGhlH"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E49A17745
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148409; cv=none; b=B9Q1sbuI4lOwytomTz0+iwj8ubm938zM9kEECMjwMuGdhuM88lzpJdUNowOQFXXwvV0DkXl7GG4ubVdD3aALhs3W89BOwAND1vmJnR+vBpZYHbwFRe0NcDIpRYDqDRW8TyYT4kc0iwEeIseyG8V4OgB9UGAaS8uRY80zZnLTW2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148409; c=relaxed/simple;
	bh=TK8X9sM9kW6dwfMkzsCCI6shDz1pyiiVg7D3z7c9sRg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q7xV/8avTzdU1UJF9zXm/KKzbfdlDVZbkaLIYmh5YsXfjxroKVtQnUzQ5xg7YD4tH+yyFi97RS7DVAjsaeqzyPSBjCPFaxxG6ZEaSiyos5ZVbGGdWUPIoL2JsXJ/SswwECcVO6R0lRADkWpSNFfN0rkP1dH3LUjOH03YoichJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZvKGhlH; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2204e9290f9so1807245fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710148407; x=1710753207; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=G0t4DyXR98AS/goDoQ+5PMwi0emTXG9o44d4l+3uefE=;
        b=WZvKGhlHAEuE02s789XmhRN+AQg1pzwU92adjN/0TbvyOS/5lWkV86IT4TEMjbCoFv
         1UHL/1FQDG10G76QrKwrgd5A8Cfv47TiDLDUSvzZ9dZPlK2sKsy93F0wnfe7yF9SfAmZ
         XGNz5TTQy+HdwwzUbs8dUxO1fzmKniK4I+PU8CMBMWS0PpiYfMQTEbevEnIhwsNi4eYA
         NVUPgaVw3iQCMQlfLeLj7r/wXPgLnUBYQMMPHAWy2XR4hP5UJSMufNfQ/bjDHAUJ+LhN
         TSIlK/7xiRqRx2+WAiV5NdKpOn20wAxUYdK5FKbWtboTso8gED6v2nCshYOUgnpShBSZ
         9g9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710148407; x=1710753207;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0t4DyXR98AS/goDoQ+5PMwi0emTXG9o44d4l+3uefE=;
        b=iIlnnR0gpu4n9iadi+PB5m9r61zOLVA3nTGfC/TIEL9jBbHu5Y7t9u1sqetHs/DKda
         /y/7PHh6jgXgXY0jJ1c06IfUgFdsKTSUWtlmFpILp8KrPfeBtZgqpImmDsmo5Q/MSjAy
         JLE7kIgIeIvsyeFjl0y5kftWnn6TrRbGyI5jOvKgnqdlcpccHliY7oZW12WlvrHfD9Qc
         yRkfEQRjRW8PLv4sxNZKQRtszaekvmAv8puRPxCWXQxsvFfFl99CLwQd7H5R7Nol9Mn2
         eJbKln1kuVr+RcuLl+MQoHdd1qw1XUXg2I5fe55re8wFssg1fcDRimeXXClQr4ihMzlr
         w4nQ==
X-Gm-Message-State: AOJu0Yz9Za+7rUjOol4a8niRjPYX7NN6V2OUvoawHwOfj5ND9yVltKut
	iniwcc9RW2Lg070ZuLhB6ONm+o/D87CcJQUc2Y7tOObMgCUJrVR4
X-Google-Smtp-Source: AGHT+IFZfA/M89E2cUNmgp6V/U5KfOLjehQmf7CELraT0hEZDdXUlKchVEjMx/4xHPJEWzca3jjVPA==
X-Received: by 2002:a05:6870:5e13:b0:221:d6cc:b551 with SMTP id nd19-20020a0568705e1300b00221d6ccb551mr2995404oac.2.1710148406995;
        Mon, 11 Mar 2024 02:13:26 -0700 (PDT)
Received: from localhost ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id l66-20020a633e45000000b005b7dd356f75sm3918028pga.32.2024.03.11.02.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 02:13:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 10 Mar 2024 23:13:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue BH conversions for v6.9
Message-ID: <Ze7LNUCf8bWg_wo5@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

This should be pulled after wq-for-6.9.

The following changes since commit 8eb17dc1a6b5db7e89681f59285242af8d182f95:

  workqueue: Skip __WQ_DESTROYING workqueues when updating global unbound cpumask (2024-02-05 07:52:22 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.9-bh-conversions

for you to fetch changes up to 8fea0c8fda30129b4168464975505d5dc9735ac1:

  usb: core: hcd: Convert from tasklet to BH workqueue (2024-02-05 13:22:38 -1000)

----------------------------------------------------------------
workqueue: BH workqueue conversions for v6.9

This pull request contains two patches that convert tasklet users to BH
workqueue - backtractest and usb hcd. DM conversions are being routed
through the respective subsystem tree. Hopefully, the next cycle will see a
lot more conversions.

----------------------------------------------------------------
Tejun Heo (2):
      backtracetest: Convert from tasklet to BH workqueue
      usb: core: hcd: Convert from tasklet to BH workqueue

 drivers/usb/core/hcd.c  | 23 ++++++++++++-----------
 include/linux/usb/hcd.h |  2 +-
 kernel/backtracetest.c  | 18 +++++++-----------
 3 files changed, 20 insertions(+), 23 deletions(-)

-- 
tejun

