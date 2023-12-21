Return-Path: <linux-kernel+bounces-8906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF58081BE01
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8ED1C21B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2996464AA1;
	Thu, 21 Dec 2023 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeKqH2q9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B598464A8C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703182676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPTRfp6XgPJwYrXbStNGHlrTw26cplB52DVfER92OzE=;
	b=TeKqH2q9VcGDeaqCJl142Wl8tG8lmgbBQDH5SKXpSpbh9MpvwSyYDfOPFwDoKyXmoapqcc
	Fbn5yaVMs2x9cc+kk/fw1KlDFyaP4CmfVGxsERH5tcTXOCKyXSVsanXtoTDlRK8baXxAhD
	dMG564ptFvGWLjxwjF5IO2RMV3ROTTs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-xf0xMjg0OoKpCz9EsK_SGw-1; Thu, 21 Dec 2023 13:17:55 -0500
X-MC-Unique: xf0xMjg0OoKpCz9EsK_SGw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-42784a3e560so14277961cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703182672; x=1703787472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPTRfp6XgPJwYrXbStNGHlrTw26cplB52DVfER92OzE=;
        b=GRZo+DM0eX/arEJDZlwtAcY5t7e+xgo5Z6AGjbx4QsKMQu+h08bgxZr+PPYxzVlouW
         Pju0QCGXzyv9xv/lHRkSOy9v7d/TPE8nbgeHfPygzUEl5qPi7zyelWjHW5LJxNa2pc8n
         JHgnnLnd8UgdyXZUnDRorryNavg0JtCQFHJDfB8n6jVgoYhUCDM/cDkA6v2tWctB/W+M
         vum9BazA9zEK+o48jSPOEgEjDvHxG0KENB1rL60ZK9zVeqG0g6ASPhccnHHK12oo0LjP
         R9WcwIzEVHEOmBBr3VNakZfrwm5Wn6Mk7DyYleEjCe45SO8UvihopxoFac04iSZgymkb
         0ZUg==
X-Gm-Message-State: AOJu0Yz1QhkCcIhae2Dj4WwqYJ1zpZUZYCupTlaWofG/9IhuNlbEux11
	6gydO26eor/M58dLpUwiYSfelpv3ihHxF/T+8K0KX/nLNvRNPgYM2/Mu18azG6LDtKyW6dVnFCx
	LURh9/Y6MQ8vMCFd69LzJ4plmu2rEx1+4
X-Received: by 2002:a05:622a:94:b0:425:f0e0:eb6e with SMTP id o20-20020a05622a009400b00425f0e0eb6emr209506qtw.19.1703182672265;
        Thu, 21 Dec 2023 10:17:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcjXn2BW/AWUDCkYR+8jI419VRXJtkzGurVXqT4ZuggYayrxK9omBtR9cVrIEfl+WGQGlBCA==
X-Received: by 2002:a05:622a:94:b0:425:f0e0:eb6e with SMTP id o20-20020a05622a009400b00425f0e0eb6emr209477qtw.19.1703182671973;
        Thu, 21 Dec 2023 10:17:51 -0800 (PST)
Received: from [192.168.1.163] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b00425e8c7d65fsm1025758qtb.23.2023.12.21.10.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:17:50 -0800 (PST)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Thu, 21 Dec 2023 12:16:47 -0600
Subject: [PATCH RFC v2 01/11] scsi: ufs: qcom: Perform read back after
 writing reset bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231221-ufs-reset-ensure-effect-before-delay-v2-1-6dc6a48f2f19@redhat.com>
References: <20231221-ufs-reset-ensure-effect-before-delay-v2-0-6dc6a48f2f19@redhat.com>
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v2-0-6dc6a48f2f19@redhat.com>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Yaniv Gardi <ygardi@codeaurora.org>, Dov Levenglick <dovl@codeaurora.org>, 
 Hannes Reinecke <hare@suse.de>, Subhash Jadavani <subhashj@codeaurora.org>, 
 Gilad Broner <gbroner@codeaurora.org>, 
 Venkat Gopalakrishnan <venkatg@codeaurora.org>, 
 Janek Kotas <jank@cadence.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 Anjana Hari <quic_ahari@quicinc.com>, Dolev Raviv <draviv@codeaurora.org>, 
 Can Guo <quic_cang@quicinc.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.3

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


