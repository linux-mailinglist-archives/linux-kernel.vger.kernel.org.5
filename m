Return-Path: <linux-kernel+bounces-8983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB4881BEE5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5001C23CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245B576DD2;
	Thu, 21 Dec 2023 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJrMMIj8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222A276DB3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703185859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFXXGAQMvAtKWxVkRcpFMTchD2fzgAOU8dNzT5bz2Wo=;
	b=HJrMMIj8ijjkAU0W3Fpl2KSU5GcoLJa5PBnosWzeqVj3hbiqWZKa+o6I7r0tR2xE8j77mB
	uRZvGfRcgA6OtIh+yRUX/ezKFYb5bLio+5XoXviA0hIf/k3OdMILPaNJ5pJE3jRKgF3gCO
	AsuNiIth/ku3sM4BFDz8Jd4mKGKayi0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-kxH2cFqRNRe48UumBXxBPQ-1; Thu, 21 Dec 2023 14:10:57 -0500
X-MC-Unique: kxH2cFqRNRe48UumBXxBPQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7812afaaed7so1079085a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703185855; x=1703790655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFXXGAQMvAtKWxVkRcpFMTchD2fzgAOU8dNzT5bz2Wo=;
        b=O6nuRadg+nGKnnSPvfRw9ZQ9aZHeNH+dbU5g/vz2LSngnwYnTpV+Z2ZCqrmvC6diCN
         RhMKEqzfTJBCoOkYh75iKkzQSrzHukdUM1a5PZ6YH3dtWaM0CPQB90/S/zYaGZMAAsTq
         nVX+RlVKhXx87Ivv2nqBEksP9mhmxqtk89Cy3kwB08HPgwyK8msa81+e64Q6Q3ZoeSsQ
         IHQJGGKI3XBZ3lzzr/uj/8mu1IGU73NpexKRmWKFi9nG0d4yl/Xz0VE3xkKRORrAazFN
         5ba4nphpaXjUA1O2VxGh33PW+os5364W51dS4QsZQpn+BMezh6byLeHwUkK9LjnySMbz
         CLJg==
X-Gm-Message-State: AOJu0Yw2ZeqvD3ZHsZXYc4IxWIG0Lkxq9eT8R0QV4BDoV5ZGyOjUMMd9
	thJ99gYgdL0ifD+u1B7a9SNYwkUMTffAB6bgoU0vr5kRih0Iw9vNPad6ezKQeKZbU0GvBzwsp0V
	Eb8m1hewfbFs6W6WUnGLncHyCCtyjDQSYbvT5cUKM
X-Received: by 2002:a37:c40c:0:b0:781:1c42:5d90 with SMTP id d12-20020a37c40c000000b007811c425d90mr241286qki.132.1703185854952;
        Thu, 21 Dec 2023 11:10:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH41P8+ouBveiK5K1CSO/CoPmnxClgg8ifdygVCzqdRtytdGED2eAZr0tztRiLQw8uOEhQXcA==
X-Received: by 2002:a37:c40c:0:b0:781:1c42:5d90 with SMTP id d12-20020a37c40c000000b007811c425d90mr241267qki.132.1703185854718;
        Thu, 21 Dec 2023 11:10:54 -0800 (PST)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id 25-20020a05620a04d900b0077f0a4bd3c6sm846370qks.77.2023.12.21.11.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 11:10:52 -0800 (PST)
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
Subject: [PATCH RFC v3 06/11] scsi: ufs: cdns-pltfrm: Perform read back after writing HCLKDIV
Date: Thu, 21 Dec 2023 13:09:52 -0600
Message-ID: <20231221-ufs-reset-ensure-effect-before-delay-v3-6-2195a1b66d2e@redhat.com>
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

Currently, HCLKDIV is written to and then completed with an mb().

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

Fixes: d90996dae8e4 ("scsi: ufs: Add UFS platform driver for Cadence UFS")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/ufs/host/cdns-pltfrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/cdns-pltfrm.c b/drivers/ufs/host/cdns-pltfrm.c
index bb30267da471..66811d8d1929 100644
--- a/drivers/ufs/host/cdns-pltfrm.c
+++ b/drivers/ufs/host/cdns-pltfrm.c
@@ -136,7 +136,7 @@ static int cdns_ufs_set_hclkdiv(struct ufs_hba *hba)
 	 * Make sure the register was updated,
 	 * UniPro layer will not work with an incorrect value.
 	 */
-	mb();
+	ufshcd_readl(hba, CDNS_UFS_REG_HCLKDIV);
 
 	return 0;
 }

-- 
2.43.0


