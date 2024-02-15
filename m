Return-Path: <linux-kernel+bounces-67000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2C085649E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7E028BA3A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACCB131734;
	Thu, 15 Feb 2024 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYSiuNa0"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056F312BE88;
	Thu, 15 Feb 2024 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004458; cv=none; b=EvMxmNObpYkgbiUTlHdWTvuNE0f87Jnuywa535wUrdh+4Ux8IqyPKo//qOn2sVbOQI/nimnRC7H7LC3gZ3qHaby5JUxbTMkGzR5nxjYR262ujKulw3CEUtfQU6mFDcwQWkE97Bs5MBFM0MnXnOwJCFJvv3I8j3WyYL3I+e4tCak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004458; c=relaxed/simple;
	bh=plKKOsjcVDNC3BZf+gPr1nfSPGe/mslre9dzGeiehf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtOr6Xs35iU1IpwRn03Yi0X+4mg9z+Xo4XajeEX7u66M5sp3OqCrcIjbwnYSn9y4SGhT17GQPtrNeVMeT3EJYNmQ4YDMbWb0pPiLqgyaqWLG+d6Mg8DIeI1neQhdBKz6o8W2Vd5FDOV1O8igyNhnkoAn88TYEhSPIh0y0FVKZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYSiuNa0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e1040455b5so576056b3a.0;
        Thu, 15 Feb 2024 05:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708004456; x=1708609256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bkr+xueP4b0KmB4knxFyYBugl4UyONHoxgCWkkPTCIM=;
        b=hYSiuNa0e3qaHtWI55nueLo5KYVPCYQ/lKfuihWMowPX5z4y9n6UcABr334Xk4dzmb
         9Y0a8Xhox5zXYOwqITm222VtdfzfWgxGiJayEJEXgRquAVrC5XxrhW+/j2ORpsGZnXFa
         DCJOmMIUerrRWht7eL2wDEOzMZShef1bAb1pasHy6Qc5f/YRGF26atHVWmYosqNebWAM
         CXshQ+Gtr/oLYQ+unaUWGTlbF3fPrTk2zZqZ9+sM/BbrzQhmTsKCZK0/21B3e86HtlWQ
         N2HhVFPzNwQatwbMRvXg2m/5rKYyuPs4M3QBy4T22p9xdgCwqLBtRO45TGP/exoSh0N+
         7JjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708004456; x=1708609256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkr+xueP4b0KmB4knxFyYBugl4UyONHoxgCWkkPTCIM=;
        b=XQUt96TbN3Q1l3HkpqoXucsEDYuNL+UyvGPsI9kGtTFtnJPe4FmuLKpEfp9LmU622a
         paCglm7cnm7tHOHbNcnfRs0nl0n3E3ZmsQuMLswGu4+sKGZwvWrAVpStM9/E+EzNIfqP
         y2BX27FLNoyzB9Q64hEjeuH8rBpOG2fibsIbjjNAm4BWAdJ6Ug7F3W6lwIZjz2a+ce7P
         n2ok9XnVYBLqKU6XYx9SraIDqpgj33CBzwAp+CLOPXINQx2kiwXabCm2Pf+x+/70rmkt
         Rf1txlwJlAvYJTCBYHkWag7AfHlszMw+YunskdbGrAPlTKb4Z4sIVOcAXrGEIoGnqT3l
         noSA==
X-Forwarded-Encrypted: i=1; AJvYcCWbBvWOfU1qVzkkl2oDqqLYrQBeZVseSFwaKDhL+mTVVYnBImC9d4LTRzk341r0qx3n4ljJWB6TP7mLYvFcUraETeC99qQcktXyMw==
X-Gm-Message-State: AOJu0Yw0rvjGqZcum5EuFeGEZl+LPUWMqiyGvd573Zg8Ier/BgkkYD4q
	aFGpimfRD3oWsiVLZG9CYY6YnokHGv2On3nxaxZqUKaW8/Yj5Hi2
X-Google-Smtp-Source: AGHT+IFOy2oAuCsimSjUTlr+FbniAH8S3avp/Dtgyo3OSqiCb9v+fahkpPjDWs3p/Yh7HVqq7/EWew==
X-Received: by 2002:a05:6a21:626:b0:19e:ac67:13a9 with SMTP id ll38-20020a056a21062600b0019eac6713a9mr1797607pzb.19.1708004456148;
        Thu, 15 Feb 2024 05:40:56 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:fe87])
        by smtp.gmail.com with ESMTPSA id jb19-20020a170903259300b001db43f3629dsm1267283plb.140.2024.02.15.05.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:40:55 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 15 Feb 2024 03:40:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next-20240215: workqueue.c: undefined reference to
 `irq_work_queue_on'
Message-ID: <Zc4UZkFp6Jr051gE@slm.duckdns.org>
References: <CA+G9fYuHF34bSbN9ktKuMAv1eOFVrf+Gw1MC_rG5trUQv9A_Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuHF34bSbN9ktKuMAv1eOFVrf+Gw1MC_rG5trUQv9A_Pw@mail.gmail.com>

Hello,

Can you see whether the following patch fixes the build?

diff --git a/init/Kconfig b/init/Kconfig
index 8df18f3a9748..41be05a8ba5e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -107,6 +107,8 @@ config CONSTRUCTORS
 
 config IRQ_WORK
 	bool
+	depends on SMP
+	default y
 
 config BUILDTIME_TABLE_SORT
 	bool
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 04e35dbe6799..6ae441e13804 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1209,6 +1209,20 @@ static struct irq_work *bh_pool_irq_work(struct worker_pool *pool)
 	return &per_cpu(bh_pool_irq_works, pool->cpu)[high];
 }
 
+static void kick_bh_pool(struct worker_pool *pool)
+{
+#ifdef CONFIG_SMP
+	if (unlikely(pool->cpu != smp_processor_id())) {
+		irq_work_queue_on(bh_pool_irq_work(pool), pool->cpu);
+		return;
+	}
+#endif
+	if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
+		raise_softirq_irqoff(HI_SOFTIRQ);
+	else
+		raise_softirq_irqoff(TASKLET_SOFTIRQ);
+}
+
 /**
  * kick_pool - wake up an idle worker if necessary
  * @pool: pool to kick
@@ -1227,15 +1241,7 @@ static bool kick_pool(struct worker_pool *pool)
 		return false;
 
 	if (pool->flags & POOL_BH) {
-		if (likely(pool->cpu == smp_processor_id())) {
-			if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
-				raise_softirq_irqoff(HI_SOFTIRQ);
-			else
-				raise_softirq_irqoff(TASKLET_SOFTIRQ);
-		} else {
-			irq_work_queue_on(bh_pool_irq_work(pool), pool->cpu);
-		}
-
+		kick_bh_pool(pool);
 		return true;
 	}
 

