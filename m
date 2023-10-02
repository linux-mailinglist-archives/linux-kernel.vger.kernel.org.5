Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FCA7B4F1E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbjJBJft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjJBJfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:35:47 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7515A91
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:35:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690bd59322dso12653530b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 02:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20230601.gappssmtp.com; s=20230601; t=1696239342; x=1696844142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:cc:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DSomhkdtUP7F+02/nCh3Eh/+Tdns1WIxU3dMozvIOWY=;
        b=JKojgjMHUOnOLSFlqyYH4UIQuiDMer+l37yKpZcyx7qNfDIWZbGETYXnx5t+ZZkXT+
         8yVllmAXt02oTFN8y0AzgEYW3J7ExbEPed2Miwogbj1t4GWZR2D7JXKOS2ylnl/GgHXQ
         LnonoLTG2xhjxBuYeZA6DRspb1cpcsP4VXSqt5IgKqOMFz3gJmaPBguzNCwtGfCej3sq
         PmxtPYcnSCCHLsrYsJvcemFS0A0Q4u30bL10qkXFVNYh68NXwoTKkhQ4ImV6krVcQY+Y
         kNszN9mx9mD0Vi3p73ixIzKQoz2D2Cmbvblt4op1V5d9q5rfPWPznRe+gtThCPvrxU9e
         OBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696239342; x=1696844142;
        h=content-transfer-encoding:mime-version:date:cc:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSomhkdtUP7F+02/nCh3Eh/+Tdns1WIxU3dMozvIOWY=;
        b=maj2us9Xw+gCpI5dd6cS6pYGfgDsznpmWZPGbNb3NTgOqc3WkqmlUOBItcbng610IJ
         V3n0qwbiTUrfc9sk3dNqtLvFU2ttiuL7bVM2kMYlopyGjeDUQxtMy5Sw4eL3Qe1rIwto
         LRXPqHAMU6fe6/aZ8j/m2ahslLH0XALtiYVHbDRTv0EpcD66nqCzAbmr7a79fG5TsRwB
         NcYapFhjYOiXbbGpyg9UzNlo323So1qHzAfuSB6vqYL079JqJyhYXrhwBnfyJ3lnIPZK
         mbqNWgjQsy9dQCHCK/K2N6WnoUtsgZUyndULdv0WHoXNFF8+rOB8Rid3dWriPNEIT94B
         ne4A==
X-Gm-Message-State: AOJu0YzDG2Ohw9BgnqWB6wQQA8MZ1mAAR2JOX0aCZJBlnhhKGGs6Oldz
        D7fVdV3oapw+m4QzK3RBbcxTkw==
X-Google-Smtp-Source: AGHT+IGT75k9aPQu4D+LrRUl2l806picCBMRseS1HAFAQX5xJYALwIizFzIqsfwtIpMmySCtvtEp/A==
X-Received: by 2002:a05:6a20:3d90:b0:15e:10e:12f3 with SMTP id s16-20020a056a203d9000b0015e010e12f3mr11697085pzi.0.1696239341920;
        Mon, 02 Oct 2023 02:35:41 -0700 (PDT)
Received: from centos78 (60-248-88-209.hinet-ip.hinet.net. [60.248.88.209])
        by smtp.googlemail.com with ESMTPSA id a17-20020aa780d1000000b00690d4464b94sm8294693pfn.7.2023.10.02.02.35.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2023 02:35:40 -0700 (PDT)
Message-ID: <ca21468a8a5de0fa19397232ac409c1015f8e29f.camel@areca.com.tw>
Subject: [PATCH v3 0/3] scsi: arcmsr: support Areca ARC-1688 Raid controller
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     bvanassche@acm.org, kbuild test robot <lkp@intel.com>
Date:   Mon, 02 Oct 2023 17:35:49 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch bases on git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next

Changes from v3:
- fix warning of cast from pointer to integer of different size

Changes from v2:
- remove mangled whitespace
- fix wrapped lines

ching Huang (3):
  support new Raid controller ARC-1688
  support new PCI device ID 1883 and 1886
  update driver's version to v1.51.00.14-20230915

 drivers/scsi/arcmsr/arcmsr.h     | 29 +++++++++-
 drivers/scsi/arcmsr/arcmsr_hba.c | 96 +++++++++++++++++++++++++++++++-
 2 files changed, 123 insertions(+), 2 deletions(-)

-- 
2.39.3


