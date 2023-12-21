Return-Path: <linux-kernel+bounces-8978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E9A81BED4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026F61F24B74
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37E0745D4;
	Thu, 21 Dec 2023 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDntXmPZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89AE745C9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703185821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hZHuvhwToeaoaoZVXmPZHHVtGh/nwSUb0e8gt0f15YM=;
	b=UDntXmPZDZoeHtpfAor4xnAscR32bLE8qLbx6m/NFuRypTO/mnyJquaEqcm7GpjMM5A4yU
	1q/0mGMB7vdqOFSddDxHup2WYF6cA6Gd6LezZwaXqBbPy2sG6F4Hi4amSZ2MrJ2Scm30xm
	VXhpH/EvEdrPklguUSnydihXAUxd6ig=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-UXD6mRS3Ore1nbr_PG-5mA-1; Thu, 21 Dec 2023 14:10:20 -0500
X-MC-Unique: UXD6mRS3Ore1nbr_PG-5mA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4279625273cso15949171cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703185820; x=1703790620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZHuvhwToeaoaoZVXmPZHHVtGh/nwSUb0e8gt0f15YM=;
        b=Ns+bYmn+Qx7cqzhVSNL6t6xbCtQ0QQepvmuoW/cbnCeeHXDB6wA+ekhEwPJjKNaARE
         L05r28iulF5/ye7nOnySyLqdIuU9XyVTMbNSYGtUTHJEThCQbPxBzFOJi8KxU//aV0B4
         FcIh2fBp8Y/8MzLfk040D/Ib03ISXHIgBK4L3TMyYQ+XNjkLkGN7b+AbwMIb9J61UQeR
         HjS0B8bMW2Eijln5iHNEZ4Yc/aa3p9H0lQMBpdvG8ISVPCjJnN4/wPn1yIos2JBQE6tw
         FscLRqnPHeS26IupCvgq6pZBnMrM8JcHtqfv2kC2M1jQ0Hv8t8L5dnQ6/j+OLEPMmUaG
         REBg==
X-Gm-Message-State: AOJu0YyXhP+e5brXkWS2TR6bixll+TNj43lR9thl+qHmbR6BHYqtH5fy
	YGGBozIFe64qg8esxXCg68WmE+oMfJ71L1l465BGzuChbwnoi3/dtciEmZbYFEGu9zqUumcqdHK
	ZMy8EB3Gs9X77M7MPY6HbGXMDUR+IcNjz
X-Received: by 2002:a05:6214:f27:b0:67f:f92:29ff with SMTP id iw7-20020a0562140f2700b0067f0f9229ffmr171534qvb.123.1703185819866;
        Thu, 21 Dec 2023 11:10:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGx2O2/q9nQgS6+PqwWNkUib41xKh58crZQWBXyWSQ3d0w0skt4cmacBiYQUg7/dkT6UrakvQ==
X-Received: by 2002:a05:6214:f27:b0:67f:f92:29ff with SMTP id iw7-20020a0562140f2700b0067f0f9229ffmr171513qvb.123.1703185819605;
        Thu, 21 Dec 2023 11:10:19 -0800 (PST)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id 25-20020a05620a04d900b0077f0a4bd3c6sm846370qks.77.2023.12.21.11.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 11:10:19 -0800 (PST)
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
Subject: [PATCH RFC v3 00/11] scsi: ufs: Remove overzealous memory barriers
Date: Thu, 21 Dec 2023 13:09:46 -0600
Message-ID: <20231221-ufs-reset-ensure-effect-before-delay-v3-0-2195a1b66d2e@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit

This is an RFC because I'm not all the confident in this topic. UFS has
a lot of mb() variants used, most with comments saying "ensure this
takes effect before continuing". mb()'s aren't really the way to
guarantee that, a read back is the best method.

Some of these though I think could go a step further and remove the mb()
variant without a read back. As far as I can tell there's no real reason
to ensure it takes effect in most cases (there's no delay() or anything
afterwards, and eventually another readl()/writel() happens which is by
definition ordered).

In this current series I don't do that as I wasn't totally convinced,
but it should be considered when reviewing.

Hopefully this series gets enough interest where we can confidently
merge the final result after review helps improve it.

I'll be travelling a good bit the next 2ish weeks, so expect little
response until my return.

Thanks in advance for the help,
Andrew

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
Changes in v3:
- Nothing changed, I just failed to send with b4 (resulting in 2 half
  sent v2 series on list)
- Link to v2: https://lore.kernel.org/r/pnwsdz3i2liivjxvtfwq6tijotgh5adyqipjjb5wdvo4jpu7yv@j6fkshm5ipue

Changes in v2:
- Added review tags for original patch
- Added new patches to address all other memory barriers used

- Link to v1: https://lore.kernel.org/r/20231208-ufs-reset-ensure-effect-before-delay-v1-1-8a0f82d7a09e@redhat.com

---
Andrew Halaney (11):
      scsi: ufs: qcom: Perform read back after writing reset bit
      scsi: ufs: qcom: Perform read back after writing REG_UFS_SYS1CLK_1US
      scsi: ufs: qcom: Perform read back after writing testbus config
      scsi: ufs: qcom: Perform read back after writing unipro mode
      scsi: ufs: qcom: Perform read back after writing CGC enable
      scsi: ufs: cdns-pltfrm: Perform read back after writing HCLKDIV
      scsi: ufs: core: Perform read back after writing UTP_TASK_REQ_LIST_BASE_H
      scsi: ufs: core: Perform read back after disabling interrupts
      scsi: ufs: core: Perform read back after disabling UIC_COMMAND_COMPL
      scsi: ufs: core: Perform read back to commit doorbell
      scsi: ufs: core: Perform read back before writing run/stop regs

 drivers/ufs/core/ufshcd.c      | 10 +++++-----
 drivers/ufs/host/cdns-pltfrm.c |  2 +-
 drivers/ufs/host/ufs-qcom.c    | 14 ++++++--------
 drivers/ufs/host/ufs-qcom.h    | 12 ++++++------
 4 files changed, 18 insertions(+), 20 deletions(-)
---
base-commit: 20d857259d7d10cd0d5e8b60608455986167cfad
change-id: 20231208-ufs-reset-ensure-effect-before-delay-6e06899d5419

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>


