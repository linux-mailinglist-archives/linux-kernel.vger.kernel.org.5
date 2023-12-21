Return-Path: <linux-kernel+bounces-8986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227D581BEEE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70671F25C46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC90277F1E;
	Thu, 21 Dec 2023 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLplHAme"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63577F11
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703185870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4md7/lhuz61o/OLaxynlTwcjr95vaOPE75vAR/46vcY=;
	b=cLplHAme+7gr7Wx9qwJy48Btj1dy1ZFa+k4nAOllFqr8d5KUAkD4rryKL0hnWWuURNJEqC
	riB7TMqMMFXvm5PSc2xrwf1IJFNyEA5UumIqcQwjavfydtnFPo7yqsOog8r382oGRwo8WP
	bX+KWNaclt/ifKf90FlOKIK2Xn/3IUU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-c58E-_A4Mge6UtiJVW9rGA-1; Thu, 21 Dec 2023 14:11:08 -0500
X-MC-Unique: c58E-_A4Mge6UtiJVW9rGA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-781168a5772so101018985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703185865; x=1703790665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4md7/lhuz61o/OLaxynlTwcjr95vaOPE75vAR/46vcY=;
        b=F7+/7KkXVZiYA5YExaIe2tq1Ta7MFftF4XIE4SqpNLM+kdf47UKja4XYd9TFcdYVSq
         ExgU0uCM6LOnOTUBBipDfS8FFCXby+pezgbmCFi0EnyM1fTth3Ca9RrbonBzbdeP5CNz
         BS6njLPNCvlG2AcQHo13RG9h++6M9d5fxjOjMEQLirKi6GiINIMtfRKun7n/+f/l8yL6
         9ZgkUwZnCe72cG7/y75LPlI0vwLm0SnQBa6TLdCHp336YGbpJkZxzGESA1DifBl8P32u
         /9Dulq007Fmy3REScnqbj4EVblfL1ZW4WLvntBY34YyHRY5KGsn9gRb34NmM4pJMaCPC
         OPSw==
X-Gm-Message-State: AOJu0YwHiXdp+XHiejDsrUsKKXH/HeKbGapZTsnGXBTrfnwg+7QBG3AD
	+dtDll26tWfp0XOnURvoPGWNyiK//iZufb+YS9+/0lQ8+yPHJv0rvY4fauqC2LsqGMQrC7uGRdi
	6enSK7DrLIQ1gU1EmqKVUPh7oRuS2RFCZ
X-Received: by 2002:a05:620a:5632:b0:77f:983d:9627 with SMTP id vv18-20020a05620a563200b0077f983d9627mr329705qkn.23.1703185864732;
        Thu, 21 Dec 2023 11:11:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/K49x9prGlGjnmr9HhZOKjCQCFmB8Y6MsD0syYqTALaQ0fnr3fNWCWPBeNe6I2HaLNE6Ynw==
X-Received: by 2002:a05:620a:5632:b0:77f:983d:9627 with SMTP id vv18-20020a05620a563200b0077f983d9627mr329687qkn.23.1703185864363;
        Thu, 21 Dec 2023 11:11:04 -0800 (PST)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id 25-20020a05620a04d900b0077f0a4bd3c6sm846370qks.77.2023.12.21.11.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 11:11:01 -0800 (PST)
From: Andrew Halaney <ahalaney@redhat.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Janek Kotas <jank@cadence.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Can Guo <quic_cang@quicinc.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v3 08/11] scsi: ufs: core: Perform read back after disabling interrupts
Date: Thu, 21 Dec 2023 13:09:54 -0600
Message-ID: <20231221-ufs-reset-ensure-effect-before-delay-v3-8-2195a1b66d2e@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v3-0-2195a1b66d2e@redhat.com>
References: <20231221-ufs-reset-ensure-effect-before-delay-v3-0-2195a1b66d2e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit

Currently, interrupts are cleared and disabled prior to registering the
interrupt. An mb() is used to complete the clear/disable writes before
the interrupt is registered.

mb() ensure that the write completes, but completion doesn't mean that
it isn't stored in a buffer somewhere. The recommendation for
ensuring these bits have taken effect on the device is to perform a read
back to force it to make it all the way to the device. This is
documented in device-io.rst and a talk by Will Deacon on this can
be seen over here:

    https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678

Let's do that to ensure these bits hit the device. Because the mb()'s
purpose wasn't to add extra ordering (on top of the ordering guaranteed
by writel()/readl()), it can safely be removed.

Fixes: 199ef13cac7d ("scsi: ufs: avoid spurious UFS host controller interrupts")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 7bfb556e5b8e..bb603769b029 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -10568,7 +10568,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	 * Make sure that UFS interrupts are disabled and any pending interrupt
 	 * status is cleared before registering UFS interrupt handler.
 	 */
-	mb();
+	ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
 
 	/* IRQ registration */
 	err = devm_request_irq(dev, irq, ufshcd_intr, IRQF_SHARED, UFSHCD, hba);

-- 
2.43.0


