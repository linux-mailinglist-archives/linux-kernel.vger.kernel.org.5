Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F99A77680B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjHITLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjHITLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BED10DC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqOZf2iFH1wW1M9KxBnD+04A0QPe8+T9kONfr/09M2E=;
        b=c8NEOwqAJqMDohW44fNWXJ6FfJR1aFtu7j8QNHQqQsEjsl5WaN0pDxrFXqibB3uEtkBBVl
        U1RHFYmrcm9PyqhGksOTMmv28u8AVMVtVReuiamkbwgHRJPEWUE4xbvw1XjRM6Ll+vC7St
        IvIlcwwY++uvX4m4gmXFZyKQuN5FLL4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-Q44OmUZ4MjGq7WlNb_-sZA-1; Wed, 09 Aug 2023 15:11:08 -0400
X-MC-Unique: Q44OmUZ4MjGq7WlNb_-sZA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-586b0ef17daso24329307b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 12:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608267; x=1692213067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqOZf2iFH1wW1M9KxBnD+04A0QPe8+T9kONfr/09M2E=;
        b=c0YiL3pxdydeGXcElcgeK053DDDgUYZ1eKZS3luARuOruc+/cKDDwmc16jgFSzWgGI
         piTJb2y7QvN/EEQEO2S7TDx9Zwi2KwFQr8zMT+SecRN864PKI+TzY7+PmUemQgiQhuXl
         t79BJkv2y2V2XBKjB60PSA/2WsbNsfW5xKkzkvsYPyU+wvqjeI4kaeVU29uM5Il/O2VE
         gyyJf2wt5Ke2ruyDO/uYIwZusI6JSaprDvcMsB5RVFcN1SjoqrSOA/jpiLwbDM4vYVaM
         jYSaK+/KIqer73lsKJn4kbXvNdOi1/b4qGRpk1FnWGbqpd5LsfKrlfcVnECef6wqFt7j
         bpVg==
X-Gm-Message-State: AOJu0Yw8f2SZeoJKMviwbkOddC1UclIIm81nighBotEv2fLzTeO3puRa
        UmOBhKuNHZdID565fXxjuRgiVzSKk0ckKp7oa0lZelvZhjxZktSAxSVywoBw8VThIh0VjSgGzG8
        H+4VeB8/9PsS5yQuwvHfJkqeXVySDr0io
X-Received: by 2002:a81:4e15:0:b0:56c:fbd2:edec with SMTP id c21-20020a814e15000000b0056cfbd2edecmr353511ywb.6.1691608267747;
        Wed, 09 Aug 2023 12:11:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrUvyUDWYgbKDLJ+F88DgRoZ8/wkyOFL1jZVSaFwSOza8QAXk8SrF2iz2ktrQ9TdkoXwcLSw==
X-Received: by 2002:a81:4e15:0:b0:56c:fbd2:edec with SMTP id c21-20020a814e15000000b0056cfbd2edecmr353498ywb.6.1691608267498;
        Wed, 09 Aug 2023 12:11:07 -0700 (PDT)
Received: from brian-x1.. (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id s84-20020a817757000000b005774338d039sm4172969ywc.96.2023.08.09.12.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:11:06 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hugo@hugovil.com
Subject: [PATCH v2 1/2] scsi: ufs: core: convert to dev_err_probe() in hba_init
Date:   Wed,  9 Aug 2023 15:10:53 -0400
Message-ID: <20230809191054.2197963-2-bmasney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809191054.2197963-1-bmasney@redhat.com>
References: <20230809191054.2197963-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ufshcd_variant_hba_init() over to use dev_err_probe() to avoid
log messages like the following on bootup:

    ufshcd-qcom 1d84000.ufs: ufshcd_variant_hba_init: variant qcom init
        failed err -517

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Changes since v1
- Dropped code cleanup

 drivers/ufs/core/ufshcd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 129446775796..409d176542e1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9235,8 +9235,9 @@ static int ufshcd_variant_hba_init(struct ufs_hba *hba)
 
 	err = ufshcd_vops_init(hba);
 	if (err)
-		dev_err(hba->dev, "%s: variant %s init failed err %d\n",
-			__func__, ufshcd_get_var_name(hba), err);
+		dev_err_probe(hba->dev, err,
+			      "%s: variant %s init failed err %d\n",
+			      __func__, ufshcd_get_var_name(hba), err);
 out:
 	return err;
 }
-- 
2.41.0

