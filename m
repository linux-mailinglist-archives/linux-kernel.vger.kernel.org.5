Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E997C7F4182
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjKVJXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjKVJXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:23:21 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1E79E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:23:17 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c878e228b4so46355851fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700644995; x=1701249795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rhC1asTv/RX7QF9kMol6kJpFTRWUtwkcm7USZ02jYEQ=;
        b=hMFYIX/pMxKBRELz+4Cz7CHnF0Epx2S3JLcDnvr2tEYlI25mVOp4prfsvLcbPtYiNE
         MsSk6UeLp0J3g/BGxt8a1JiYoP+6WrBrR+n3XAwVZZSfezfRq6ekVAeStYcmCIaFBeLA
         kMGRxSodQTGeQJ9o4fy/6M+Cvil+azj8006kr/6GB+KpYAqgc/byxiY0Wk6Y66+zRU4Q
         0k8kDtoaGUWhTkRd6iY3KVtTRoC/lCFmWM+4qWaHb7HiNrH8UYg6dwKqGhB4V6ve4Ege
         01anrwtlc07Ggr5FqnoWDpOxFFU37FcRzYbi3H2FGw/xVLgZzW+OPp1CqQlYTSwHM22m
         hY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700644995; x=1701249795;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhC1asTv/RX7QF9kMol6kJpFTRWUtwkcm7USZ02jYEQ=;
        b=op+xpvFriW7UsEAK7pslOPL3SwYB8MXfRk9bImIY+xAiYN3tA6gc0itu76xwKlqor8
         b5sIhfPAZGfsD5u1o+R+lCf4kBE9yYtNLp6tpov3lHwiRZls0cHpbsXQVGRKmECF2r48
         1YC8h8IKbGsH4O0YSnfPQE8AcZdhfY0ucCMQmmO8n316ERv2ILMB9NGUfwhlj827hBP9
         KIsvvVn2eLUJMUmmdFtdN+6JK7BVUzxZwBEEt604Ulc+MBV+Y/C1Fh3I+1imTijXWbx6
         rvRMUNCG33tRBjmoRA56ZmRsrmEXOXlPbxXPwWQb+6n7mYiuAlWfruD+XAi/R/coXGs9
         FIew==
X-Gm-Message-State: AOJu0YyRFpfxj36PITVhjxWex0V9zFxJAobGRo0Jhi8wgTHudqzEib/f
        ugrsRBCRni9ssor+P7zMtiYajQ==
X-Google-Smtp-Source: AGHT+IFC9A4xkbgVPJSLpWSTZPDF0VLLciqEZwb/ASpE58NNXzwVw56OuwAKDW2H2DK7/NKV8m71bQ==
X-Received: by 2002:a05:651c:50c:b0:2c5:19ab:7270 with SMTP id o12-20020a05651c050c00b002c519ab7270mr1295603ljp.35.1700644995201;
        Wed, 22 Nov 2023 01:23:15 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c19c900b0040a4751efaasm1518204wmq.17.2023.11.22.01.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 01:23:14 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Wed, 22 Nov 2023 04:23:11 -0500
To:     oe-kbuild@lists.linux.dev, SEO HOYOUNG <hy50.seo@samsung.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        kwangwon.min@samsung.com, kwmad.kim@samsung.com,
        sh425.lee@samsung.com, sc.suh@samsung.com,
        quic_nguyenb@quicinc.com, cpgs@samsung.com, grant.jung@samsung.com,
        junwoo80.lee@samsung.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        SEO HOYOUNG <hy50.seo@samsung.com>
Subject: Re: [PATCH v3] scsi: ufs: core: fix racing issue during
 ufshcd_mcq_abort
Message-ID: <5cd4171c-d992-4e3c-96c7-91bb0ae9feb6@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121071128.7743-1-hy50.seo@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SEO,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/SEO-HOYOUNG/scsi-ufs-core-fix-racing-issue-during-ufshcd_mcq_abort/20231121-151923
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
patch link:    https://lore.kernel.org/r/20231121071128.7743-1-hy50.seo%40samsung.com
patch subject: [PATCH v3] scsi: ufs: core: fix racing issue during ufshcd_mcq_abort
config: powerpc-randconfig-r071-20231122 (https://download.01.org/0day-ci/archive/20231122/202311220618.OnEhSic6-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311220618.OnEhSic6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311220618.OnEhSic6-lkp@intel.com/

smatch warnings:
drivers/ufs/core/ufs-mcq.c:515 ufshcd_mcq_sq_cleanup() warn: variable dereferenced before check 'cmd' (see line 511)

vim +/cmd +515 drivers/ufs/core/ufs-mcq.c

8d7290348992f2 Bao D. Nguyen   2023-05-29  498  int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag)
8d7290348992f2 Bao D. Nguyen   2023-05-29  499  {
8d7290348992f2 Bao D. Nguyen   2023-05-29  500  	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
8d7290348992f2 Bao D. Nguyen   2023-05-29  501  	struct scsi_cmnd *cmd = lrbp->cmd;
8d7290348992f2 Bao D. Nguyen   2023-05-29  502  	struct ufs_hw_queue *hwq;
8d7290348992f2 Bao D. Nguyen   2023-05-29  503  	void __iomem *reg, *opr_sqd_base;
8d7290348992f2 Bao D. Nguyen   2023-05-29  504  	u32 nexus, id, val;
8d7290348992f2 Bao D. Nguyen   2023-05-29  505  	int err;
8d7290348992f2 Bao D. Nguyen   2023-05-29  506  
aa9d5d0015a8b7 Po-Wen Kao      2023-06-12  507  	if (hba->quirks & UFSHCD_QUIRK_MCQ_BROKEN_RTC)
aa9d5d0015a8b7 Po-Wen Kao      2023-06-12  508  		return -ETIMEDOUT;
aa9d5d0015a8b7 Po-Wen Kao      2023-06-12  509  
5363c9d813101c SEO HOYOUNG     2023-11-21  510  	if (!ufshcd_cmd_inflight(cmd) ||
5363c9d813101c SEO HOYOUNG     2023-11-21 @511  	    test_bit(SCMD_STATE_COMPLETE, &cmd->state))
                                                                                          ^^^^^^^^^^^
The patch adds a new unchecked dereference

5363c9d813101c SEO HOYOUNG     2023-11-21  512  		return 0;
5363c9d813101c SEO HOYOUNG     2023-11-21  513  
8d7290348992f2 Bao D. Nguyen   2023-05-29  514  	if (task_tag != hba->nutrs - UFSHCD_NUM_RESERVED) {
8d7290348992f2 Bao D. Nguyen   2023-05-29 @515  		if (!cmd)
                                                                     ^^^
But the old code assumed "cmd" could be NULL

8d7290348992f2 Bao D. Nguyen   2023-05-29  516  			return -EINVAL;
8d7290348992f2 Bao D. Nguyen   2023-05-29  517  		hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
8d7290348992f2 Bao D. Nguyen   2023-05-29  518  	} else {
8d7290348992f2 Bao D. Nguyen   2023-05-29  519  		hwq = hba->dev_cmd_queue;
8d7290348992f2 Bao D. Nguyen   2023-05-29  520  	}

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

