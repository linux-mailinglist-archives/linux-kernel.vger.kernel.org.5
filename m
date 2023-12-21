Return-Path: <linux-kernel+bounces-8921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF96781BE30
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6761C247CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8057762C;
	Thu, 21 Dec 2023 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+yvJMF3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371876DAC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703183153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUUJuT608SRhCl6+0/SpXWAx7Kuk//nvBAACeA7YhJo=;
	b=P+yvJMF31so6khUbP0rICAsBhmtOk5w6hJGSDjer2JThsrko+1vlaIZ5If9xSPfgXKv39E
	WZStGq3FtaoXbh294XuJtCT5muHd6xtdwBcW+vNdRale5hTZsPH7+FZSFOVV1tiAOcJLcI
	+kld6Q68OT4r2LZ3t0VNKqwVPcOE0GI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-M5NzNAODNped4jp-bbGllQ-1; Thu, 21 Dec 2023 13:25:51 -0500
X-MC-Unique: M5NzNAODNped4jp-bbGllQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-67f92d392d4so722626d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703183150; x=1703787950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUUJuT608SRhCl6+0/SpXWAx7Kuk//nvBAACeA7YhJo=;
        b=tTjXug/oMe9nCo4aiszYOKdONtBhnFLGYSUnm3J6a9asyLhl1bc8w38uT8KjS3/v93
         EDYwZriCYhI3ivG7TNPOledcPr8Cb8GnSHm+KjNQ7IDyKPTEU7TqxlzurL7OPEvP7aZZ
         2qTxRK03AFrxwcbVCnfDSOe37H9konSz69VbKeuoYazlPVXXTLFq4UuvF2LVPkUsBQi6
         +YJaYjXmdIlucqMEaT2Kkh1e2PSrVYGMYP6U6Djv984c6T1oTWVDDrjO/A9AY4OGHqJa
         HykzCwCWk5AwRhUR8xbWKbQgBnCaTMj4lTOxlUSUj3GacoptU+aQQz9zj4fgWlc+W64W
         Bs/w==
X-Gm-Message-State: AOJu0YzS3klQcDUj7/AMNMBEja1v/c8bok9/sXlIbyTVhax1srk3+fA4
	ZbM92NUF99tWQ8rtqLlMgE4N0EuCqxfSBX6yXYG8Exs+vfimkuglL/ix4T5XLo5lRHg5L78RKUU
	2ib43bii0YAaczn15RkLnBG7jvTzRtpK1
X-Received: by 2002:a05:6214:23cf:b0:67a:a721:f313 with SMTP id hr15-20020a05621423cf00b0067aa721f313mr119294qvb.83.1703183150053;
        Thu, 21 Dec 2023 10:25:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ9Kju9IqTA5EEJRzv9VHVG6omJS9ICt+kO57nwljfFPxGim4CiNb9HpK10WnlhSNr539//w==
X-Received: by 2002:a05:6214:23cf:b0:67a:a721:f313 with SMTP id hr15-20020a05621423cf00b0067aa721f313mr119290qvb.83.1703183149828;
        Thu, 21 Dec 2023 10:25:49 -0800 (PST)
Received: from [192.168.1.163] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id da7-20020a05621408c700b0067f2c03d4adsm779605qvb.100.2023.12.21.10.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:25:46 -0800 (PST)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Thu, 21 Dec 2023 12:25:24 -0600
Subject: [PATCH RFC v2 07/11] scsi: ufs: core: Perform read back after
 writing UTP_TASK_REQ_LIST_BASE_H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231221-ufs-reset-ensure-effect-before-delay-v2-7-75af2a9bae51@redhat.com>
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

Currently, the UTP_TASK_REQ_LIST_BASE_L/UTP_TASK_REQ_LIST_BASE_H regs
are written to and then completed with an mb().

mb() ensure that the write completes, but completion doesn't mean that
it isn't stored in a buffer somewhere. The recommendation for
ensuring these bits have taken effect on the device is to perform a read
back to force it to make it all the way to the device. This is
documented in device-io.rst and a talk by Will Deacon on this can
be seen over here:

    https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678

Let's do that to ensure the bits hit the device. Because the mb()'s
purpose wasn't to add extra ordering (on top of the ordering guaranteed
by writel()/readl()), it can safely be removed.

Fixes: 88441a8d355d ("scsi: ufs: core: Add hibernation callbacks")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index d1e33328ff3f..7bfb556e5b8e 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -10351,7 +10351,7 @@ int ufshcd_system_restore(struct device *dev)
 	 * are updated with the latest queue addresses. Only after
 	 * updating these addresses, we can queue the new commands.
 	 */
-	mb();
+	ufshcd_readl(hba, REG_UTP_TASK_REQ_LIST_BASE_H);
 
 	/* Resuming from hibernate, assume that link was OFF */
 	ufshcd_set_link_off(hba);

-- 
2.43.0


