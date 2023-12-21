Return-Path: <linux-kernel+bounces-8981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 196D481BEE0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9942B234D5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A234F745EC;
	Thu, 21 Dec 2023 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVqiZ/qE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65C0768EA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703185850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4219KYM+Lx5MIoMXHlnouIE3ETSXouTN4mLohiWEzAY=;
	b=cVqiZ/qE973zKIjMx/mGBXZe6j6jFQtUnlaeYsrPHGY624nS5FaJcj9JpFl+Cgy9KxqQNX
	nS3Vv15qSFaCeKne8MJSpM/t7qEoTzd6G4xs0ljQl3fRifSbHsFcftoNQyzPlDtfdIZNvz
	bYDPM+X6FH001fDnzCK/of728PY/tVM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-lS_LYUlEMH-KRpaPAKRgoQ-1; Thu, 21 Dec 2023 14:10:48 -0500
X-MC-Unique: lS_LYUlEMH-KRpaPAKRgoQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67f6f0992fcso14607296d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703185845; x=1703790645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4219KYM+Lx5MIoMXHlnouIE3ETSXouTN4mLohiWEzAY=;
        b=XPEiAzqR6dGgKBijnV6Mop2t14MSHQiQ/OeXFPBSP+/lXG6t0eLtmZRWsQUUOf2nh5
         ayTgtFDWRzmBC02mvayYVI1Z5C6H/kf//wxr72Cq4tK49a9T2DIXxhv6bHvjElI2cdEM
         a7TBvbWvOxV+F8DSeuK85PPDg9iN8Hf0Bdp9EPnSIHL2rE+eC5e2bJqMovVAvdFbkFtW
         cO/uB74HA2sJQG252YoryuaHKKy+VBhqqZyUshQeMVov1YkWc8Z/dIzlmPVuhHt1Jo2n
         765d5A0JPQaju20wArsu5rfFTLKQ9iWbkBptrge7Td2Ka9qn/et2L0VYJ+5q/BjmlnMe
         Opuw==
X-Gm-Message-State: AOJu0YwK2MEsqaaKi/EqAG5ONmLrscdJCfyiFWaTooVWW5GENvtIGabq
	r6Qr9Igy80F9g3zO7aF9u15BbRznqnjZrGOPCWz3fGeWyNLa24ixcaDS5ofEgOfZn8qzegQnfJu
	UTjFSKWh6F9PMxCGr+XVaDfhCeqa7qn2Y
X-Received: by 2002:a37:c209:0:b0:77f:11d4:f58e with SMTP id i9-20020a37c209000000b0077f11d4f58emr286554qkm.148.1703185845042;
        Thu, 21 Dec 2023 11:10:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8jYkyl5NGRggoBhvuDpRsaNOweDEis0bQkLs57xnRD25grZcE9INmJJc/kRzCE79nsbsx3Q==
X-Received: by 2002:a37:c209:0:b0:77f:11d4:f58e with SMTP id i9-20020a37c209000000b0077f11d4f58emr286537qkm.148.1703185844782;
        Thu, 21 Dec 2023 11:10:44 -0800 (PST)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id 25-20020a05620a04d900b0077f0a4bd3c6sm846370qks.77.2023.12.21.11.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 11:10:42 -0800 (PST)
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
Subject: [PATCH RFC v3 04/11] scsi: ufs: qcom: Perform read back after writing unipro mode
Date: Thu, 21 Dec 2023 13:09:50 -0600
Message-ID: <20231221-ufs-reset-ensure-effect-before-delay-v3-4-2195a1b66d2e@redhat.com>
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

Currently, the QUNIPRO_SEL bit is written to and then an mb() is used to
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

Fixes: f06fcc7155dc ("scsi: ufs-qcom: add QUniPro hardware support and power optimizations")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/ufs/host/ufs-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 6df2ab3b6f23..ab1ff7432d11 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -280,7 +280,7 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
 		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
 
 	/* make sure above configuration is applied before we return */
-	mb();
+	ufshcd_readl(host->hba, REG_UFS_CFG1);
 }
 
 /*

-- 
2.43.0


