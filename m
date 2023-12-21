Return-Path: <linux-kernel+bounces-8919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A05B81BE2A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4C41F22657
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7D3768FF;
	Thu, 21 Dec 2023 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3VjT6LK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FCA64A9C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703183150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFXXGAQMvAtKWxVkRcpFMTchD2fzgAOU8dNzT5bz2Wo=;
	b=M3VjT6LKNaZ2dghsR40WOMnvGE3IbNJoHhBjWhzSwWQNFxzQoiZgZwL+rG4dIC1sFXdgRz
	4TwWtGkrQUmZDxIWnqvzLZIRviYtpE67/s5uh22rxhcEGrksV/L/ptIt9H2tw2AFu1N/dv
	/LySG/p01J/Z2C9G7f6RpmQlkzSkVzA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-PW-9Qr6SO0q7_ZXIn_CE0w-1; Thu, 21 Dec 2023 13:25:49 -0500
X-MC-Unique: PW-9Qr6SO0q7_ZXIn_CE0w-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67f7b69433dso16492066d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703183145; x=1703787945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFXXGAQMvAtKWxVkRcpFMTchD2fzgAOU8dNzT5bz2Wo=;
        b=p/p0OjgQJORcLuhfbIBSsYfv78kz0BBoztqaIOWj3rZKCNnM9losJePOnH7FBsTS+E
         7whhVzwdcKWhUUGGjl+j+Jj262WRF2jjAmmZx3ukGgCirUmP1vXdc6PSj3hTAqC5zJ+n
         N5IynpH8vmzhuGiLp5vYcOFNqvRlMC+Um1uKYjoAnMjzEyaJgopOx+xtsn1ofMdN7cPw
         oKzgK9KkyP8OLJEFav8Hp/hj2cHXxJdXURQgta6YX9w2OKsezwAgtcn5LTc98z6MkXqh
         IQ3PU+QXbDA4tGZrsDEHvTgczITuqXKA2WJKaXjvT1Uo5OMyfS26Kmm4zbelojs1E8Ha
         u//Q==
X-Gm-Message-State: AOJu0YwWXqtgYOVn6q9b+Mx22qu/zMTi3bzLNkE0/oNRaQT1ebV5UW0L
	yXZnwzF+NoRea9TF0pzQkZyKMlhn7ieKFbnSnLM5T8urIfWpj9mpy5zyGSBWLmonTg2/krwkRt+
	vIZzNhD2xf8Gd2+TEcpNaM8wmX39J3vO7
X-Received: by 2002:a05:6214:20e6:b0:67a:a721:caf4 with SMTP id 6-20020a05621420e600b0067aa721caf4mr120993qvk.85.1703183144895;
        Thu, 21 Dec 2023 10:25:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIzHIP8IP+Btntq31oA+NJrP8wQlY6ZrjfmYei4CjrYTO1lr59Bq4x9PrGSfUb4jsXlwQcHw==
X-Received: by 2002:a05:6214:20e6:b0:67a:a721:caf4 with SMTP id 6-20020a05621420e600b0067aa721caf4mr120983qvk.85.1703183144634;
        Thu, 21 Dec 2023 10:25:44 -0800 (PST)
Received: from [192.168.1.163] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id da7-20020a05621408c700b0067f2c03d4adsm779605qvb.100.2023.12.21.10.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:25:44 -0800 (PST)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Thu, 21 Dec 2023 12:25:23 -0600
Subject: [PATCH RFC v2 06/11] scsi: ufs: cdns-pltfrm: Perform read back
 after writing HCLKDIV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231221-ufs-reset-ensure-effect-before-delay-v2-6-75af2a9bae51@redhat.com>
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


