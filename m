Return-Path: <linux-kernel+bounces-8989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD9581BEF5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1702865E9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868C17608B;
	Thu, 21 Dec 2023 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wp6mmAo4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932876A029
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703185883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4cSBdvbxI8LSVPr25rTyKCoUJu91IkN+EuBnNL3WBh0=;
	b=Wp6mmAo4C8iKE11bowaB1/bgdB4aTLZjL8k4UmvIV1tVcnItijdfKujdMuu1OglrJhEk0C
	2rClTBVB8wDgPWiuuwt8gclzhgZ9kOfIU9RhmNKo+ZtC8uWM/q4yJP9etNk/jV9hvtTigS
	pRBU0wu7OmdyT+K8FAmbMw0OI8p9m5s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-5nmJXuNxOCS2dRuRt0Lh5g-1; Thu, 21 Dec 2023 14:11:22 -0500
X-MC-Unique: 5nmJXuNxOCS2dRuRt0Lh5g-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67a696be34cso15223386d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703185881; x=1703790681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cSBdvbxI8LSVPr25rTyKCoUJu91IkN+EuBnNL3WBh0=;
        b=fHIE1sKzWenjit8b7Waf2mOXconM6unKlrXb+xt9qfmVAqsgIOqcL+01LjmWl2FEPN
         azE2i+IWFR9gh4F4ogz4dxKIRFRyCQm6DNjh5VzZ6Ra5BUFO8uBZLhPfG7Joj3+194xt
         +X2WbRk+gYnNScIGxrF/lKIdIXk9B3/x2j7SsOHceBEAjmdMMpTbnrA6I9drnfMDZqWn
         KKw3Qw0HUnZuZKVRIeQLE2f0fqHC67bFuIcnk9x/bnl0GdwaOBUvGhiYbdoFsyUIqdOi
         ktLe37CvLOy9AopXoN3uAqEW4igSPpqO6LzvFFUEtbbLZTkas+PZb2OvIIgN703M6fGA
         qERw==
X-Gm-Message-State: AOJu0YzXbjvGw2StT0O5pEVrLrdbagorVc3JH5vwi2MizaEJ31bkswVI
	dAqVdSHfFvZrBBsdH2Fvq3NcI1vqfHRBHMyaFjqVyRvXsBBdf4g4Mk8E87s31qmef1vQRP9Ceif
	zcg1bGN4cLsyeR+0afc6kVRU54d7HOk3i
X-Received: by 2002:ad4:5e8c:0:b0:67f:2201:81e1 with SMTP id jl12-20020ad45e8c000000b0067f220181e1mr222523qvb.13.1703185881310;
        Thu, 21 Dec 2023 11:11:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGf7+G9N49GFMXR/htbqQ1Lb5/TJZIyMXTWcnIiiUlAQ5o6qGsg7peSQ1lv4VxWTuFlkzHUAg==
X-Received: by 2002:ad4:5e8c:0:b0:67f:2201:81e1 with SMTP id jl12-20020ad45e8c000000b0067f220181e1mr222500qvb.13.1703185881066;
        Thu, 21 Dec 2023 11:11:21 -0800 (PST)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id 25-20020a05620a04d900b0077f0a4bd3c6sm846370qks.77.2023.12.21.11.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 11:11:19 -0800 (PST)
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
Subject: [PATCH RFC v3 11/11] scsi: ufs: core: Perform read back before writing run/stop regs
Date: Thu, 21 Dec 2023 13:09:57 -0600
Message-ID: <20231221-ufs-reset-ensure-effect-before-delay-v3-11-2195a1b66d2e@redhat.com>
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

Currently a wmb() is used to ensure that writes to the
UTP_TASK_REQ_LIST_BASE* regs are completed prior to following writes to
the run/stop registers.

wmb() ensure that the write completes, but completion doesn't mean that
it isn't stored in a buffer somewhere. The recommendation for
ensuring the bits have taken effect on the device is to perform a read
back to force it to make it all the way to the device. This is
documented in device-io.rst and a talk by Will Deacon on this can
be seen over here:

    https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678

Let's do that to ensure the bits hit the device. Because the wmb()'s
purpose wasn't to add extra ordering (on top of the ordering guaranteed
by writel()/readl()), it can safely be removed.

Fixes: 897efe628d7e ("scsi: ufs: add missing memory barriers")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index caebd589e08c..7c1975a1181f 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4726,7 +4726,7 @@ int ufshcd_make_hba_operational(struct ufs_hba *hba)
 	 * Make sure base address and interrupt setup are updated before
 	 * enabling the run/stop registers below.
 	 */
-	wmb();
+	ufshcd_readl(hba, REG_UTP_TASK_REQ_LIST_BASE_H);
 
 	/*
 	 * UCRDY, UTMRLDY and UTRLRDY bits must be 1

-- 
2.43.0


