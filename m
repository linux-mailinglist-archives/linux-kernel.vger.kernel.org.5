Return-Path: <linux-kernel+bounces-161317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 354EB8B4A9A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450E21C20C2B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD1D51C5E;
	Sun, 28 Apr 2024 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDWCmKih"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E724F2F25
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714291537; cv=none; b=Ha2dGTnR6VY3bu4UFMaFozcDlDIhISFsGHWbz/BTkNhKqmV2b7CwFYGtyOWyfz0nt8frTDN+/sNuRvFPp3bfrTFbjLZVSVlaBUkruj1DCLjFVRXRy241y7zoYB67Dsvkw27JltHXpLilnYYC+/GkeaLHjTg3LXUlM7vcXqixgrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714291537; c=relaxed/simple;
	bh=Wuw8OxdyhJoifrv891YDOBEAeTYahgJhK0M7c5Rc6og=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TNnKdypjvd6Fo7heFJ9gk21vyRdrEwAiNo8RJz14l3l3SjB4uNj72HcxmjsEF2XKqrREThAyPlY2Dg6M8lyvqU0A6AbENBeWNcu2KBpfMRAsE+tPqWaBAM7dhH+1qXDnY87cnvyu5ZJ7qZKRCV+EUpflSScDtQeE+YpmrJ77TXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDWCmKih; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-346406a5fb9so2936153f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 01:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714291534; x=1714896334; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VHnmbGRWkJwyRcCXZFcMSmmyI7/rnbD54Au5nm1J+aU=;
        b=VDWCmKihgaZRTgEH3aC3VAXEKdt++uw7kDIb1OXwB3/88ud5oQy9/ILMUQUwAaoqwj
         TrLzJW8FIXUEuf3I5poaJtFuL56HkUR6DI1uS5ibYxBggyyxhbhRUI6oS7q+aOZcFd0F
         m5AVJnTXKewhS6DgTZDYPpGel6C6oY4wLn7gf5sNTO2eYwu5jPc2lMZiIWA0KNVNdtem
         OouNpAOn0pMYZiY3YYexj99UR2AhiJXRKPa6LQViYal5ReCi4Rm3d3na3y8UHr1t8G0W
         tCprSKVq0fsK6CmtbwTW8NI197B2eWhrRWTjE9eTy65bL684DJELfhg4KrExsmUOtgty
         8jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714291534; x=1714896334;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHnmbGRWkJwyRcCXZFcMSmmyI7/rnbD54Au5nm1J+aU=;
        b=W4HhnRNnzH97uCsvBsvEyZDzJ1lHTsJTx956oiF95DXfZhfnI4Jn30uah5rHWBSfbJ
         mEoywLbp/iw59VkgKBnm4pLxT0B3PFMe9lNGQ2t6HZuavDG5s3zlbdG1mzOW3vjOfqDv
         fhKh+/iWETSqLPYo//5lX1H4Qsz7uqZkwhsqnm7Y38EOo273+nupb69NE14EcqNd70ZY
         Vha0GpGCICuSjr4b4axaQAR3Xs06hUNIzXxtkP2I+UtbfBwpFhl1rvJ4WHzfuU6Fc7C9
         kqoa0uX8hKv/ETpYc0kg/EeY3n5ttLaOeVlwLjLQdv65jgj7KLv7ZyhZmDoERv/iNtsc
         GSgQ==
X-Gm-Message-State: AOJu0YyUwbnm3dy7qjgirJ86y/ntVtOpcuJdEUGcurdYIi01nFgked1t
	8k3Ksrdqm8JQlHdRne3QEaljp8xeEv7WhuS3MbVhB/jp2Dok7TEr
X-Google-Smtp-Source: AGHT+IGXwiM7pbATAJv72x3XbUMZdl4tbY6AjtIMiGq4/ISTsia+OxLzfi46JYyHvvP8BlaMr76Otw==
X-Received: by 2002:a5d:5f86:0:b0:343:f3d9:a9d5 with SMTP id dr6-20020a5d5f86000000b00343f3d9a9d5mr6132458wrb.10.1714291533720;
        Sun, 28 Apr 2024 01:05:33 -0700 (PDT)
Received: from gmail.com (1F2EF175.nat.pool.telekom.hu. [31.46.241.117])
        by smtp.gmail.com with ESMTPSA id h1-20020a5d5481000000b003437a76565asm26521641wrv.25.2024.04.28.01.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 01:05:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 28 Apr 2024 10:05:31 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>, Marc Zyngier <maz@kernel.org>
Subject: [GIT PULL] IRQ fix
Message-ID: <Zi4DS9dFnKE45Huc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest irq/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-04-28

   # HEAD: c26591afd33adce296c022e3480dea4282b7ef91 irqchip/gic-v3-its: Prevent double free on error

Fix a double free bug in the init error path of the
GICv3 irqchip driver.

 Thanks,

	Ingo

------------------>
Guanrui Huang (1):
      irqchip/gic-v3-its: Prevent double free on error


 drivers/irqchip/irq-gic-v3-its.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2a537cbfcb07..5f7d3db3afd8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4567,13 +4567,8 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 		irqd_set_resend_when_in_progress(irq_get_irq_data(virq + i));
 	}
 
-	if (err) {
-		if (i > 0)
-			its_vpe_irq_domain_free(domain, virq, i);
-
-		its_lpi_free(bitmap, base, nr_ids);
-		its_free_prop_table(vprop_page);
-	}
+	if (err)
+		its_vpe_irq_domain_free(domain, virq, i);
 
 	return err;
 }

