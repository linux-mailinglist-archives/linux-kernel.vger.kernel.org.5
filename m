Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDF68032AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344013AbjLDMaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344005AbjLDMaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:30:05 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5025DDF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:30:11 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b27726369so44794495e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701693010; x=1702297810; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKvSKITUcl+fN4QbSnsBMTLDMl3HA5xQPt9QvlGXEbI=;
        b=iidQi2oEZuoBshT399Uzx8Izs0wKDb026uVoEHZDKjFt7urmkr/zbOR0NCH5+jQQVI
         HznfLEFwTl+OpY6J3gHQkQBwaSrNYChAC1mJPq59pU76aOZnnf+9XQ4jmBaBgNRuneFG
         4EFLAEbk9qZfACPXqi/XTzLa7GmSuV5+ERaT/MDTCNOKZfvgrFO69VMLmLtqt8UXPz/7
         wmP3e0zLK0bkG9KDDQM0Xb6A6XXXaOQkTP0VnTIOStAsV+QX8xNIOOLY5em/mssQYVBk
         xht8L2ZfQ/2gPCCwTtG0RuokVmeVAVH0nEbB33yAPNa3BhP1kcN6Gc6JJ+tQMf0J+KSP
         N/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693010; x=1702297810;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKvSKITUcl+fN4QbSnsBMTLDMl3HA5xQPt9QvlGXEbI=;
        b=RhqEygXBOZmhNX0QMZo6o/CGT26wQucLAdSbRszMmsRcsX05iFP0nF+qrVwCqhUKir
         Q3dCzWUk6hShVO8wauub0n+kWE5DUicPElxLr8pl9z29S6CzQ6mCiIUY0Jl83gaBamsX
         wOKJ34PxZYa5lp/mNVedfaSZPGLlK0EyBi0cDMuse3rYOgKCiE1HZo922ibgin1o8uEM
         K+J8N55uVybjC/fzmUBSfZFFNbMiNeJ9YtNnqOfs7QGcWA1jzDRTD+gZWlVSv3GIefev
         2Nff3x06yW5kQ7YRspBaEnptDgVo9TInsgm/wMlVRFVzr5tJj0GP5zWOkVDwuCn8mkaN
         9cBw==
X-Gm-Message-State: AOJu0YyuFfz+cNetTYgcqQd3v3/FMMvBbvDnK++LwxDGuAvVXcg/R6RB
        bduXO2HrTubJm4ECq3gd1yArtg==
X-Google-Smtp-Source: AGHT+IEnpV3/O9/8ri5kU9IVDoewSq6OVRcJS3PmnCJaHELXOk53y0yosvmsMWPxzvXqFzDfVsT3QA==
X-Received: by 2002:a05:600c:3417:b0:40b:5e59:da7a with SMTP id y23-20020a05600c341700b0040b5e59da7amr2376583wmp.141.1701693009855;
        Mon, 04 Dec 2023 04:30:09 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c511200b004064e3b94afsm18454841wms.4.2023.12.04.04.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:30:09 -0800 (PST)
Date:   Mon, 4 Dec 2023 15:30:06 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] nfsd: remove unnecessary NULL check
Message-ID: <0cce4257-6c22-4c0a-b769-b946990413fe@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We check "state" for NULL on the previous line so it can't be NULL here.
No need to check again.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202312031425.LffZTarR-lkp@intel.com/
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 40415929e2ae..fb551a3db1dc 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6639,7 +6639,7 @@ __be32 manage_cpntf_state(struct nfsd_net *nn, stateid_t *st,
 	spin_unlock(&nn->s2s_cp_lock);
 	if (!state)
 		return nfserr_bad_stateid;
-	if (!clp && state)
+	if (!clp)
 		*cps = state;
 	return 0;
 }
-- 
2.42.0

