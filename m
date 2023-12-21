Return-Path: <linux-kernel+bounces-8988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E83A481BEF4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE9D1F255D2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C33B78E81;
	Thu, 21 Dec 2023 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S02uqQID"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E3760B6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703185883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myeBTw3HbDC/jUy61nVcNVpXoHTTT3lUStj2mtls9rs=;
	b=S02uqQIDrt/dddxLyN9GyNpSXDCuGK0NOLVCiKrrVVD+ulJ1mQaBS7N8OJsjJUklLiF0QN
	OIiQDsA6C9yGMPNPTUOUv7Y0vGjuSFtfHR+6Nl4iz0EfGwzSCgcUhapH1vWhhGh6amyjM1
	Dyjd3mPNNSOSAfiKSnFLLUM1YVVJlpc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-hpzSQWo-N2WLoyoMvtmc6A-1; Thu, 21 Dec 2023 14:11:20 -0500
X-MC-Unique: hpzSQWo-N2WLoyoMvtmc6A-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-781293a471fso24577285a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:11:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703185877; x=1703790677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myeBTw3HbDC/jUy61nVcNVpXoHTTT3lUStj2mtls9rs=;
        b=HEEcBtRCg/TzQxXMJE+c47AnLqkof1HDGP65F81IWbb40y8JpLU6RlIzPELgTKjsf1
         /hAkBYUXk+sZyDieIpYQ8O9Pe91/kt97tvO1Qs6dLrnMjfupfecON9IFGrYyXVx31TuZ
         pXJ9jJPNktPmqB4aF3yr6cyjpzisFQd5KE0lFl2J+kwezguDjS9TgbNtjoT65u6ure8m
         9BBhsSjkUupgWOVLYr+JlIYEGJIMCMPBQe+4P0A21MrbkXiZ9nPMcawWEnRKFTvmcS8j
         76hDJ1PR4iIo6sWMB7K2rdiMuqAB1Kid6DBu0sTw+bd6vsCfgX8tMGQcE8+5rSfEuJN+
         joIw==
X-Gm-Message-State: AOJu0YwNX7rZOExeXOpA3FJI6T/QHljvkpvX2p/a6YJgPopOfZys95oG
	KAGkUpsa/mMbXYN1YXzsjs2DTF9p6o2Q55pmzFkw3XDFvq1nliA67Awq99E/b1k9Vki4h50Q20Q
	p3c+mokgr5o62KoI8odoU1YaDQw/AFbW6
X-Received: by 2002:a05:620a:2101:b0:771:31c:adcb with SMTP id l1-20020a05620a210100b00771031cadcbmr301247qkl.7.1703185876789;
        Thu, 21 Dec 2023 11:11:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIo9rP/exgPUX1MrFBn+AOlJuIaIUzWQyH80yOwSzRQUWXH5SWjG9NIk+MB93joiIr8Pn1SQ==
X-Received: by 2002:a05:620a:2101:b0:771:31c:adcb with SMTP id l1-20020a05620a210100b00771031cadcbmr301230qkl.7.1703185876561;
        Thu, 21 Dec 2023 11:11:16 -0800 (PST)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id 25-20020a05620a04d900b0077f0a4bd3c6sm846370qks.77.2023.12.21.11.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 11:11:15 -0800 (PST)
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
Subject: [PATCH RFC v3 10/11] scsi: ufs: core: Perform read back to commit doorbell
Date: Thu, 21 Dec 2023 13:09:56 -0600
Message-ID: <20231221-ufs-reset-ensure-effect-before-delay-v3-10-2195a1b66d2e@redhat.com>
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

Currently, the doorbell is written to and a wmb() is used to commit it
immediately.

wmb() ensures that the write completes before following writes occur,
but completion doesn't mean that it isn't stored in a buffer somewhere.
The recommendation for ensuring this bit has taken effect on the device
is to perform a read back to force it to make it all the way to the
device. This is documented in device-io.rst and a talk by Will Deacon on
this can be seen over here:

    https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678

Let's do that to ensure the bit hits the device. Because the wmb()'s
purpose wasn't to add extra ordering (on top of the ordering guaranteed
by writel()/readl()), it can safely be removed.

Fixes: ad1a1b9cd67a ("scsi: ufs: commit descriptors before setting the doorbell")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 75a03ee9a1ba..caebd589e08c 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7050,7 +7050,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 
 	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TASK_REQ_DOOR_BELL);
 	/* Make sure that doorbell is committed immediately */
-	wmb();
+	ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
 
 	spin_unlock_irqrestore(host->host_lock, flags);
 

-- 
2.43.0


