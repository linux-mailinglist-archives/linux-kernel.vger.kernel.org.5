Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B2F8062AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346568AbjLEXFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346557AbjLEXFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:05:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C581B2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 15:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701817515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KjWIyI6YjcRFSiBIKVaUrOztwgBb5qiQH2MALmZ63dY=;
        b=U9+vWjFXcIx3ooRCmGyRcTUiF7Zi+BWQC6Nt34eJ3GjYsMHMEPM5NoFXLKN0Ujn0eFISON
        PSBZfLmE9RHD/A2jEMkX1cA5QQjgpxE/szmlOMT6x1wBTk2ogm9agwNfJfWNYDnTcNh7e6
        xcrI3jUspttl7FiWLME6H9ZBCyB8jHs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-gWah12IzMsCOayjoTjm_nw-1; Tue, 05 Dec 2023 18:05:11 -0500
X-MC-Unique: gWah12IzMsCOayjoTjm_nw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-423e684dc6eso2085761cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 15:05:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701817511; x=1702422311;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KjWIyI6YjcRFSiBIKVaUrOztwgBb5qiQH2MALmZ63dY=;
        b=A45x8lUZyzmg+OJIiK2vkP/lxDzQ8wfSLS6sD1WWhY/iu9wrp/KJtet8T9ghTDJIMw
         pcfIb5032dyrmUI38XVLoW8pdzkm42r6Cv/DRmdW0jEYmtdXN+biYwORnYYBp/Vn0ySO
         BLGqFRAszoQwc5q4e8K2bI5/t9rlg1ovgVSYIChng0Q6ZwiPhIik5cw4RKR/Ujd1jaLA
         nqIB9nY706Gmg1TbinApjYwkDBrkWqqYCZtnJlT9HlHqV8icduy7qsb5EBq/FBKWxF+u
         lnclg5mtuhovBUX0I2f7NKOAfVeG3zojeKctjFy+VJxNsdc/4OL9j6vpayDv57/+G4SR
         GlSQ==
X-Gm-Message-State: AOJu0Yw1hj0jdjJnmidGovkra+KVzs3UGofZ1ggtuus6SzMLZT8LHBI1
        ABbHktLReNTdKpUlB6gxUciIEwUh7N8Yr5aiGLPChwQsNvhhSXgjLM0gCAcrsoSqnui3hHxIrNj
        S8C2JJ0HrH2+yW0jEuONNHGFb
X-Received: by 2002:a05:622a:1a09:b0:425:4043:18a9 with SMTP id f9-20020a05622a1a0900b00425404318a9mr2407848qtb.92.1701817511399;
        Tue, 05 Dec 2023 15:05:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKEPs8ln58pkSxo7JdGiLTDZJzbF0Cn3n/cOeY6nbEFjytcYsjLySU6gzAJL3g6Di3uG7EtQ==
X-Received: by 2002:a05:622a:1a09:b0:425:4043:18a9 with SMTP id f9-20020a05622a1a0900b00425404318a9mr2407836qtb.92.1701817511184;
        Tue, 05 Dec 2023 15:05:11 -0800 (PST)
Received: from [192.168.1.164] ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id df15-20020a05622a0ecf00b00423da75b0f4sm5504430qtb.71.2023.12.05.15.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 15:05:10 -0800 (PST)
From:   Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 0/3] soc: qcom: pmic_pdcharger_ulog: Fix compilation
Date:   Tue, 05 Dec 2023 17:05:08 -0600
Message-Id: <20231205-pmicpdcharger-ulog-fixups-v1-0-71c95162cb84@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKSsb2UC/x2MSQqAMAwAvyI5G6g1HvQr4sEl1oBLSVEE8e8Gj
 8Mw80BiFU7QZA8oX5Lk2A2KPINx6ffAKJMxeOfLwrsK4yZjnMxpYMVzPQLOcp8xYU2Dm8nVTER
 gfVQ287/b7n0/Qopw/GsAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>,
        kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into a compilation error on -next today, and while at it I ran
into a few other little things I wanted to squash.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
Andrew Halaney (3):
      soc: qcom: pmic_pdcharger_ulog: Search current directory for headers
      soc: qcom: pmic_pdcharger_ulog: Move TRACE_SYSTEM out of #if protection
      soc: qcom: pmic_pdcharger_ulog: Fix hypothetical ulog request message endianess

 drivers/soc/qcom/Makefile              | 1 +
 drivers/soc/qcom/pmic_pdcharger_ulog.c | 6 +++---
 drivers/soc/qcom/pmic_pdcharger_ulog.h | 6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)
---
base-commit: 0f5f12ac05f36f117e793656c3f560625e927f1b
change-id: 20231205-pmicpdcharger-ulog-fixups-94b0f409e444

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>

