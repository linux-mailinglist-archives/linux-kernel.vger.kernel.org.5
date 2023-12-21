Return-Path: <linux-kernel+bounces-8979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC0D81BED6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE242862AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8472B651BC;
	Thu, 21 Dec 2023 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tw7aH+eS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A35651B3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703185833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPTRfp6XgPJwYrXbStNGHlrTw26cplB52DVfER92OzE=;
	b=Tw7aH+eS6mn1oGdWZSFzfzvxRgu0Oo2EGHydNOXHT6YmmeVqOU6mbEFHy8X6eX2t2iya7g
	Rl0LTR3HRoJLof+JZtAmw9uJlJg3b62vXCqi8UcO8a+J3oWSYAVH4MDWYLufrvGnrisqT7
	MobdRkhOUkqb0HMj9PkBUNMLfv4lA98=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-Eop6SLygOmKuvzHm3Ezn8Q-1; Thu, 21 Dec 2023 14:10:31 -0500
X-MC-Unique: Eop6SLygOmKuvzHm3Ezn8Q-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7811b42ac40so137421585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:10:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703185830; x=1703790630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPTRfp6XgPJwYrXbStNGHlrTw26cplB52DVfER92OzE=;
        b=SSeDaPFKND+fInjcmj+0LcD99uXDMIqMBPG+2vFaPZ3gH4tJ14OuPxoVtsHqmGZgtG
         fXUyw4V8CG8PnZKPyr/4AzFgrTkJh3WhU2NEXArsxZQmgcOAv8uk5zjFADl1q6pAusRM
         HkCdKPuPbSBOzpO0xhmIzQMs7rY2GLnoJ9qQRLUlpJm5soTLz09b+5bEfRkueeWI1vKv
         tU2OzCclpEU4Hb0zhMXjwbSiwIUTK4klHHlZxOHol2wH8hPncLJx034Z+b88w8IFB5mD
         yu18wB0AzkgiSq8RpXBIVDLwEKSowhtasXrV23Fz/w6WNHl9JDiL2KUzixWHxszO2lzI
         AZMg==
X-Gm-Message-State: AOJu0Yyfg71Lj1R1NNEsKpEZcD2ZmW8Cvp7fRlOwT6V9NtxZDraLdOSH
	jAlowUxNIM1BXgv2PJRNY7dqVG73yIBBJSGlKysLztX+pMxAvGMVKw/c3RDIOUkPoEHc2EAg2wG
	D4VbbgDWqaguHsgVWbXq/9LwZUWVzuw7u
X-Received: by 2002:a05:620a:40d2:b0:781:1d86:730e with SMTP id g18-20020a05620a40d200b007811d86730emr409220qko.46.1703185830372;
        Thu, 21 Dec 2023 11:10:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjjwBX3fNd+UfPIhDxLgwriLU4sXMgeQMKrJUsdhqERZm93cgr9Xu5T3I+sMzpxXCKV6r9cg==
X-Received: by 2002:a05:620a:40d2:b0:781:1d86:730e with SMTP id g18-20020a05620a40d200b007811d86730emr409201qko.46.1703185830108;
        Thu, 21 Dec 2023 11:10:30 -0800 (PST)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id 25-20020a05620a04d900b0077f0a4bd3c6sm846370qks.77.2023.12.21.11.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 11:10:29 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH RFC v3 01/11] scsi: ufs: qcom: Perform read back after writing reset bit
Date: Thu, 21 Dec 2023 13:09:47 -0600
Message-ID: <20231221-ufs-reset-ensure-effect-before-delay-v3-1-2195a1b66d2e@redhat.com>
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

Currently, the reset bit for the UFS provided reset controller (used by
its phy) is written to, and then a mb() happens to try and ensure that
hit the device. Immediately afterwards a usleep_range() occurs.

mb() ensure that the write completes, but completion doesn't mean that
it isn't stored in a buffer somewhere. The recommendation for
ensuring this bit has taken effect on the device is to perform a read
back to force it to make it all the way to the device. This is
documented in device-io.rst and a talk by Will Deacon on this can
be seen over here:

    https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678

Let's do that to ensure the bit hits the device. By doing so and
guaranteeing the ordering against the immediately following
usleep_range(), the mb() can safely be removed.

Fixes: 81c0fc51b7a7 ("ufs-qcom: add support for Qualcomm Technologies Inc platforms")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/ufs/host/ufs-qcom.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 9dd9a391ebb7..b9de170983c9 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -151,10 +151,10 @@ static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
 	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
 
 	/*
-	 * Make sure assertion of ufs phy reset is written to
-	 * register before returning
+	 * Dummy read to ensure the write takes effect before doing any sort
+	 * of delay
 	 */
-	mb();
+	ufshcd_readl(hba, REG_UFS_CFG1);
 }
 
 static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
@@ -162,10 +162,10 @@ static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
 	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, 0, REG_UFS_CFG1);
 
 	/*
-	 * Make sure de-assertion of ufs phy reset is written to
-	 * register before returning
+	 * Dummy read to ensure the write takes effect before doing any sort
+	 * of delay
 	 */
-	mb();
+	ufshcd_readl(hba, REG_UFS_CFG1);
 }
 
 /* Host controller hardware version: major.minor.step */

-- 
2.43.0


