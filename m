Return-Path: <linux-kernel+bounces-127675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5025D894F48
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD7028253E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0585A106;
	Tue,  2 Apr 2024 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SkHkeqkj"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647DD5B699
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051822; cv=none; b=F+lpkgpg6+6XFBKgeSF0cKOTZkXMgwNi7Ph3FUbuFJ6oO+dUtvQE0rYDrh0KYh1D/Qz2jBgmsSclyW8vtYwcDJjkGy7BqBn+jz3rMG2Li5wNiXamDJcxEQ7lMi6gIxMHP6wbnRjxF9wickbZErvHPvQowfizG9wvVLrcz5cxxN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051822; c=relaxed/simple;
	bh=iP61wYLmnnQVWQX/vBTSXN9AMov1jT600DiQQbSBwlI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aTOqZJKTlB6QwjepQtNKyyE78AUzXKBHIfCPfSj8ueQNoBEJTaMLD6Ii0L+a/zKCVHAbwrWsAZxFrNtyY665qaHXcra1qLF/aSfs+ws8ZFjxeGHM+XGaYYILCobAp3u6BRaVWdQ27N9KJatYnHs4jbxKfaxze1DVgOKAaS3PWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SkHkeqkj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso3463830a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712051818; x=1712656618; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwgQXgoUW3ptEVLp+FHIBGiwI73MMNowi6SZaD84hB0=;
        b=SkHkeqkj6Y9XZxGuEhACJ7noJvDVA49Zup3UxNSleXZBmN2cLL1xp/0RjmvJyvkC6d
         vxcmuwrR1GJHRqjlxnbPhbzV4jAESXRE3m/Qbkl0ezYZGQkCi49XYs1ctwry2ukUQLnB
         nuYXjbd+L+TxHM3bkry+m4jAanAwPpmedZNvUYN9QTGnENqGk/slYD3s/PSuNTf4iAGq
         76Hgr5bOcmNAi3984+WL1snjjEh/PFbMTA/XOKeO8QF+3dA7yywkCHD/UkHL2npaijGt
         mAQed/iDZmfWw3MXsyUPSx6OUKYuU3QHsS2Ls2Xox0lP0fpXEm2dCd6B4SB9Kd0kGeIB
         xVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712051818; x=1712656618;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwgQXgoUW3ptEVLp+FHIBGiwI73MMNowi6SZaD84hB0=;
        b=onz3zNSKYQ+4cFXu8v9QtX4L1jg/MGEpTcQWLsDcYJy5ohnQ8RSSiNJQrM5JkS8Ibr
         +pp6UC3Xx7N3pY8hTXaukJgcVJSYx0ILldB2+3SVE8gV2jqkJ5BrsoGU+AZXaHSjsYt+
         wlOrFdpMTNCGoKB7WHN88zHw5yWduNsFP8hCgWuRzRr462pcdwy+6myL/9MXWmSW5VpA
         qVI74VnWp1sPXivqmkG2H6qM29keM7t1Zc+zCd9BNLMzw0OXNxhfakorjXZAHivkoEz/
         4fIjhHeqRGfkYqZcfPhS0mclOaUk22T3odn1ejBceIoi3e+HfZADJ5ob9KlbqLFjOX90
         SDUw==
X-Forwarded-Encrypted: i=1; AJvYcCVMN/4MjaxmvxJbEwv8zltDpOfmtTUe2dNMlNMkWg5bvXGIPKl0zwHwDFY/nfjWwlWpwz3Z/kA2fEdJFcQAQgxYOWGKTRPTmIVpeXvX
X-Gm-Message-State: AOJu0Yysx6iT7H5k/o7hKGns5L1T8UDAhj/YFS4u/DQyjEtEEmHL0pUt
	krAKclvzESajgSyw7xDRSuiwCSzkx8qnu15wF9heEl8dmSMFAzETj2Hk3bJgGE8=
X-Google-Smtp-Source: AGHT+IGY/ckv5IDWBeqA+lu7NK4+cJGbNGKIoaQ4W6h+blnbepjFmGXMUHAOqLWzHMLmnsm5NYCPaw==
X-Received: by 2002:a05:6402:27ce:b0:56d:b687:5a57 with SMTP id c14-20020a05640227ce00b0056db6875a57mr8537324ede.20.1712051818415;
        Tue, 02 Apr 2024 02:56:58 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id eg14-20020a056402288e00b0056df6ed8f4csm119336edb.37.2024.04.02.02.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 02:56:58 -0700 (PDT)
Date: Tue, 2 Apr 2024 12:56:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Quinn Tran <qutran@marvell.com>
Cc: Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Larry Wisneski <Larry.Wisneski@marvell.com>,
	Duane Grigsby <duane.grigsby@marvell.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: Fix off by one in qla_edif_app_getstats()
Message-ID: <5c125b2f-92dd-412b-9b6f-fc3a3207bd60@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The app_reply->elem[] array is allocated earlier in this function and it
has app_req.num_ports elements.  Thus this > comparison needs to be >=
to prevent memory corruption.

Fixes: 7878f22a2e03 ("scsi: qla2xxx: edif: Add getfcinfo and statistic bsgs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/scsi/qla2xxx/qla_edif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index 26e6b3e3af43..dcde55c8ee5d 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -1100,7 +1100,7 @@ qla_edif_app_getstats(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
 
 		list_for_each_entry_safe(fcport, tf, &vha->vp_fcports, list) {
 			if (fcport->edif.enable) {
-				if (pcnt > app_req.num_ports)
+				if (pcnt >= app_req.num_ports)
 					break;
 
 				app_reply->elem[pcnt].rekey_count =
-- 
2.43.0


