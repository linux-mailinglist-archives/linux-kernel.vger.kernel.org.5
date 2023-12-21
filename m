Return-Path: <linux-kernel+bounces-8916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A5F81BE25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68CF28619A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED42745E6;
	Thu, 21 Dec 2023 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/FX71AV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5920B5990A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703183143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oX0CWwSSb/xcfXKSUEFguRgCx8LqXafuU1W5XbBtf6I=;
	b=O/FX71AVb5nVc4R4SzW2qCSlI1JfFtEViu75wb+ENyO10+Zu6gCUKA1p2funQQ7Q6lLyTp
	hCiy0dDk9s2E1S5e8T/+bfJ6rjt7Zs85sIkzmr/KZv3nWkP5s5YpROSGVkDF5GjdUlj7zA
	bg0PJepFw5ZMSoW8GWkKs+AtMkuNndw=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-9Yk4IXSlM8uf9EoQYUFpmw-1; Thu, 21 Dec 2023 13:25:41 -0500
X-MC-Unique: 9Yk4IXSlM8uf9EoQYUFpmw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b9e358994fso1140629b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:25:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703183141; x=1703787941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oX0CWwSSb/xcfXKSUEFguRgCx8LqXafuU1W5XbBtf6I=;
        b=fGYDFtvH6j7Joup2OaHY0MTOs/Ef7m47XmYk5Zp6PFm6sTB61RBSonqZh6Qs7d9aV7
         XfEpCPS2PCKaTW6POecALAsO29cL+jyh72BJEq/wSzcPMFxdT1J7QptaQitV84UTD0gN
         +1xgeXtmmUBXQ6tHvUzWg19oDmWR7TZksYfMgiVKcOfyxJZTYzk2bbz64HTr3uLQf3Uy
         jdKBDoNl0yfo4Lr34ileIIGHNJQ/RRkcfaTwwvi3kHFKxo6e1SOYDjVq7WCUSq4Mngxs
         CDsY273dIt3kqMUUZsvaQff7/QrEOTtHlVCFb7CCgsLovohOW5ERksc4/dQpG6I/3jTS
         hzBw==
X-Gm-Message-State: AOJu0Yyj2e2ssm0UkeczpHe4sMhdAvjvOT0Sqqphi+osRet6w0tDkpE5
	VkEtYr5c84hwQ67kNit/cBETY/whPHxJwPBDl10BDy+h+uCx7CZFsJsP7sy3WBKC2U6/iZ+zB6p
	DtNklIVivEZOzpnxxDkBubKSby4LpJlRF
X-Received: by 2002:a05:6808:e8a:b0:3b9:e47d:631d with SMTP id k10-20020a0568080e8a00b003b9e47d631dmr90702oil.96.1703183141144;
        Thu, 21 Dec 2023 10:25:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGk4XM7Ucd1ORiXMq9oHfABoA0n2G2V/78MhvX5VtAkYZbvn53wbv8iIbog6TkfOKmdNndrEQ==
X-Received: by 2002:a05:6808:e8a:b0:3b9:e47d:631d with SMTP id k10-20020a0568080e8a00b003b9e47d631dmr90675oil.96.1703183140902;
        Thu, 21 Dec 2023 10:25:40 -0800 (PST)
Received: from [192.168.1.163] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id da7-20020a05621408c700b0067f2c03d4adsm779605qvb.100.2023.12.21.10.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:25:40 -0800 (PST)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Thu, 21 Dec 2023 12:25:22 -0600
Subject: [PATCH RFC v2 05/11] scsi: ufs: qcom: Perform read back after
 writing CGC enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231221-ufs-reset-ensure-effect-before-delay-v2-5-75af2a9bae51@redhat.com>
References: <20231221-ufs-reset-ensure-effect-before-delay-v2-0-75af2a9bae51@redhat.com>
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v2-0-75af2a9bae51@redhat.com>
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
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3

Currently, the CGC enable bit is written and then an mb() is used to
ensure that completes before continuing.

mb() ensure that the write completes, but completion doesn't mean that
it isn't stored in a buffer somewhere. The recommendation for
ensuring this bit has taken effect on the device is to perform a read
back to force it to make it all the way to the device. This is
documented in device-io.rst and a talk by Will Deacon on this can
be seen over here:

    https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678

Let's do that to ensure the bit hits the device. Because the mb()'s
purpose wasn't to add extra ordering (on top of the ordering guaranteed
by writel()/readl()), it can safely be removed.

Fixes: 81c0fc51b7a7 ("ufs-qcom: add support for Qualcomm Technologies Inc platforms")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/ufs/host/ufs-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index ab1ff7432d11..3db19591d008 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -409,7 +409,7 @@ static void ufs_qcom_enable_hw_clk_gating(struct ufs_hba *hba)
 		    REG_UFS_CFG2);
 
 	/* Ensure that HW clock gating is enabled before next operations */
-	mb();
+	ufshcd_readl(hba, REG_UFS_CFG2);
 }
 
 static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,

-- 
2.43.0


