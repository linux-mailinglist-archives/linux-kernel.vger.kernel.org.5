Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE27776817
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjHITMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjHITLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835B010E0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=idN6k6wnvIRmPVarrYDUY5WM1/+zqey5Stp1+3/1nn8=;
        b=BZjmC1w7h5ZlvYjGvjo6vsVmYgJfRR6UHgGNKPaSyjdvA6cyuqUs0rKYULI2O6pwH79UWB
        r1mVHlXWe8pzyvR0I7nrjlAQ/B+At1t177tZnIhqXRrL3EWhbOQTGqePtEexkcw0ikDA6z
        0BKvoqseP7e7F5fLObf2OW//+G6LhyY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-P3MOPbOYPHCtSS_YI9Pmbg-1; Wed, 09 Aug 2023 15:11:06 -0400
X-MC-Unique: P3MOPbOYPHCtSS_YI9Pmbg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-586a5ac5c29so3026047b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 12:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608266; x=1692213066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idN6k6wnvIRmPVarrYDUY5WM1/+zqey5Stp1+3/1nn8=;
        b=l0lrW+iFVOOU4WlSXV8L3hNWVkgaBgHDN7z9dcK29Mh3FM34HIkmh3v2yMS8ICBcwe
         YmP1569Qcz7ElpmJUsWdDI6vY27XuD1vP8Ubv0OpfY1zxb7pOOlSTVG7feY9QjSbjjdW
         qchA+til5Wzsg0jcSM2jm5JmNZp/o9T335E4mS3qBT9grL/PSM4lAFNCRx45qGP4UlXv
         haVDvfHe/t2cQfd739zohkCcshiM494egXcJSvu5Nu78scNJrGU+Kyv8MZxKfS5TeE1h
         n4h3BOmf2Fgq6G0ctsilPJQnGa/m/0kPObwMnnvLUakBYqufbIEedmFR5mAP+mzXOEt2
         /5wQ==
X-Gm-Message-State: AOJu0YxB7zio9HCWOWvgE3HD3JCmOz3hh5SA2+NrwZxEyLhI9e9FUTYS
        scPwQJ9UrB5NPfrh8p3diOYAhf34IWDugfxPeB2w2r7U3TSr841WrY5XHuCk0mRQjO8J2AypGPk
        5ds2tffg2rEziDJWc/+x6znoP
X-Received: by 2002:a81:5213:0:b0:577:18a9:fde9 with SMTP id g19-20020a815213000000b0057718a9fde9mr203975ywb.43.1691608265902;
        Wed, 09 Aug 2023 12:11:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4bakAFmnDHXZCtm+vYnH/44zCXQwIHL3mdbk7E48nsMmoY5a7btEW/R6hRCA2pgPLsg/bFg==
X-Received: by 2002:a81:5213:0:b0:577:18a9:fde9 with SMTP id g19-20020a815213000000b0057718a9fde9mr203963ywb.43.1691608265662;
        Wed, 09 Aug 2023 12:11:05 -0700 (PDT)
Received: from brian-x1.. (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id s84-20020a817757000000b005774338d039sm4172969ywc.96.2023.08.09.12.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:11:04 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hugo@hugovil.com
Subject: [PATCH v2 0/2] scsi: ufs: convert probe to use dev_err_probe()
Date:   Wed,  9 Aug 2023 15:10:52 -0400
Message-ID: <20230809191054.2197963-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following two log messages are shown on bootup due to an
-EPROBE_DEFER when booting on a Qualcomm sa8775p development board:

    ufshcd-qcom 1d84000.ufs: ufshcd_variant_hba_init: variant qcom init
        failed err -517
    ufshcd-qcom 1d84000.ufs: Initialization failed

This patch series converts the relevant two probe functions over to use
dev_err_probe() so that these messages are not shown on bootup.

Changes since v1
https://lore.kernel.org/lkml/20230808142650.1713432-1-bmasney@redhat.com/
- Dropped code cleanup

Brian Masney (2):
  scsi: ufs: core: convert to dev_err_probe() in hba_init
  scsi: ufs: host: convert to dev_err_probe() in pltfrm_init

 drivers/ufs/core/ufshcd.c        | 5 +++--
 drivers/ufs/host/ufshcd-pltfrm.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.41.0

