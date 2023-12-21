Return-Path: <linux-kernel+bounces-8984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3816681BEE9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8CE1C24228
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0C876DDC;
	Thu, 21 Dec 2023 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhwbzY80"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E71697A6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703185865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUUJuT608SRhCl6+0/SpXWAx7Kuk//nvBAACeA7YhJo=;
	b=YhwbzY80QbppRP6SpROhl81wCQTtvg8UhuB0sbOJC3nlUa6KwfW+XPYsP6jQDeLHr8Rgsa
	u9KWjf2xTmRF7ol3kazrGgkuvveQYuuiz9OQy9i5UbMc+ATYLWpgVFYm9sltyt9WnTtsfs
	17Qe9pI+Gy0/sYnRwDSeoeFYg718mDg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-t7WcWc0bPM2BErT_4bApMw-1; Thu, 21 Dec 2023 14:11:03 -0500
X-MC-Unique: t7WcWc0bPM2BErT_4bApMw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78118a0bf69so137140585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703185859; x=1703790659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUUJuT608SRhCl6+0/SpXWAx7Kuk//nvBAACeA7YhJo=;
        b=PN8HQOvY5sPlqkdzYicq9Cl8tZuyXqE64Gq2ctLyoANvzDGfv5/tTX8BowrwaG9RPS
         T3nHMRYbyZ+yReq0+BJwcQ4L6PADZ34vszL7sEfNFMx3M5JTndZhdgTCO1UouAJSPKzs
         +WckXC14zZQ4zCaShTA8oXyqaJZyT0TfzzaGaXcCtZOQrfzi2T7lmaG3MQwWxKDGNUdk
         0tz2QsByTZZTJxZeVol/0n76kyd9QW4TOk0yhXeh+GGc4yeCFyqTiNYJvUqC0EV7Ogn+
         xo+PtSv6BlFL7sn+S65V3eyGT4vxQagDXob/54JAIAc3L0vYdcgsWl+6NVnlcGQwXH7A
         xL0Q==
X-Gm-Message-State: AOJu0YyudVQB3m93Xt2eSPHmOC7QiRMux7d9anNz6ORATJ2CCL7hNYrL
	gHyEmtLSzpGvUXGg07xIOr9XJE9z17B3jefNgrWsfJvr8ud/vwFGyr7FgqKprBm9rdFWahS2mkH
	xD8zau+CdlsbULwJSy6sDEPWMrgaFDHvQ
X-Received: by 2002:ae9:e00e:0:b0:781:1a4a:584f with SMTP id m14-20020ae9e00e000000b007811a4a584fmr318117qkk.120.1703185859664;
        Thu, 21 Dec 2023 11:10:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiXPBhS4kKMnaigM0VOu3Xfp4mKtcc2Em3gQUXqUh7Nc2UYXmSf9LOeMTOGyICyCpbM5rz5g==
X-Received: by 2002:ae9:e00e:0:b0:781:1a4a:584f with SMTP id m14-20020ae9e00e000000b007811a4a584fmr318097qkk.120.1703185859419;
        Thu, 21 Dec 2023 11:10:59 -0800 (PST)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id 25-20020a05620a04d900b0077f0a4bd3c6sm846370qks.77.2023.12.21.11.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 11:10:56 -0800 (PST)
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
Subject: [PATCH RFC v3 07/11] scsi: ufs: core: Perform read back after writing UTP_TASK_REQ_LIST_BASE_H
Date: Thu, 21 Dec 2023 13:09:53 -0600
Message-ID: <20231221-ufs-reset-ensure-effect-before-delay-v3-7-2195a1b66d2e@redhat.com>
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


