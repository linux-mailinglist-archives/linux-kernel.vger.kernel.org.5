Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6F479A5E7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjIKIVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIKIVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:21:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7265D99
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:21:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso44373965e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694420476; x=1695025276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/BDrwWCwQweCJpnOjMvyDpdv3oCDm8reO9zhEoTmqPY=;
        b=eJgYzFFD787nFqWHQjRc9Lj0MiJOjZ3gQa5Ntg1jK5NuXsIEFDyEnpuXsyLcx9F3nO
         x/waxv9DsCRWuGiCIB7MDDeSfB8FbAcXhkay/q9qMSObuZUcX+eR+Uk00g9WqEsrUk2E
         jvJDNg2OiqlIB0N3EZIH31lIKJJBfMuEGbJ2zNlmQzEQS6tTewqZdLMGP2Qmo72pdQf9
         eMgngNQzAUtdhMRcZFZihfjfC9DOQIrC7lvZ5U4Q5UThtX0oG6hYMAE5JNBk9XEU/iG6
         ViFhYXT9+BvQ6GUeNzL3dTiO/CYFQmJP2t8Okqwm3Prd+2QFTl4uEkdiLPtkRKpO6fJo
         peVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694420476; x=1695025276;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BDrwWCwQweCJpnOjMvyDpdv3oCDm8reO9zhEoTmqPY=;
        b=xCfve5dhhRRBTvOLwIk2RIdQQrgDOkNd0FkvY5nynsj9csPxrYNApmtlMSxqnr8P3d
         7IlkcDIDPQFqJGWAKz42dnw/kh7OkuBqR3Vy+iM/+EDklkuL84mP/HR/77igYn0fy/rn
         C80f3HgKiBNlHXx1i6XN1Z1cM4fdgLnfbG/2mJX5pxZgr0RN6Cmoe5ci/wxkYOpEGRoe
         Qk8MnzfEUhTbnMy6juomMwgz63OdzKsv4WSgDxFO9clGcsHex0gJkD52AAn980GZKvCk
         JMtj9yVG/DHk+LeUBlYN7pTS+ulX9XPUAW0/Gwc6U9qOr8ho7oK0lFyiM7wzhqyOsbjX
         Yqzw==
X-Gm-Message-State: AOJu0Yyu3ysqyz40yVxk4j5j4RA/KX/ySgK2FtNhD197xl6xDQjmt2SM
        TuGXpjDfvNI1SowCzzdUFm8cJQ==
X-Google-Smtp-Source: AGHT+IE6CSFqIInSaAKyMklQvvbm7xvtW2aQnxdjnlwEcRBBouP3ODBqMLatWe+GphUOQdu3rhSxBA==
X-Received: by 2002:a05:600c:2307:b0:401:38dc:891c with SMTP id 7-20020a05600c230700b0040138dc891cmr7425353wmo.5.1694420475694;
        Mon, 11 Sep 2023 01:21:15 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s12-20020a05600c45cc00b00403b63e87f2sm557670wmo.32.2023.09.11.01.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 01:21:15 -0700 (PDT)
Date:   Mon, 11 Sep 2023 11:21:12 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Lu Hongfei <luhongfei@vivo.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Can Guo <quic_cang@quicinc.com>, Bean Huo <beanhuo@micron.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        zhanghui <zhanghui31@xiaomi.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Eric Biggers <ebiggers@google.com>,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2 2/3] scsi: ufs: core: Add ufshcd_wb_buf_resize
 function to enable WB buffer resize
Message-ID: <172b2898-29bd-4bf5-9842-16c9105b25fc@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908102113.547-3-luhongfei@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lu-Hongfei/scsi-ufs-core-add-wb-buffer-resize-related-attr_idn/20230908-182656
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230908102113.547-3-luhongfei%40vivo.com
patch subject: [PATCH v2 2/3] scsi: ufs: core: Add ufshcd_wb_buf_resize function to enable WB buffer resize
config: i386-randconfig-141-20230909 (https://download.01.org/0day-ci/archive/20230909/202309091536.TRk3mftu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230909/202309091536.TRk3mftu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202309091536.TRk3mftu-lkp@intel.com/

New smatch warnings:
drivers/ufs/core/ufshcd.c:6067 ufshcd_wb_buf_resize() error: uninitialized symbol 'ret'.

Old smatch warnings:
drivers/ufs/core/ufshcd.c:5353 ufshcd_uic_cmd_compl() error: we previously assumed 'hba->active_uic_cmd' could be null (see line 5341)

vim +/ret +6067 drivers/ufs/core/ufshcd.c

7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6049  int ufshcd_wb_buf_resize(struct ufs_hba *hba, u32 resize_op)
7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6050  {
7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6051  	int ret;
7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6052  	u8 index;
7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6053  
7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6054  	ufshcd_scsi_block_requests(hba);
7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6055  	if (ufshcd_wait_for_doorbell_clr(hba, 1 * USEC_PER_SEC))
7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6056  		goto out;

ret is unitialized.

7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6057  
7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6058  	index = ufshcd_wb_get_query_index(hba);
7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6059  	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6060  		QUERY_ATTR_IDN_WB_BUF_RESIZE_EN, index, 0, &resize_op);
7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6061  	if (ret)
7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6062  		dev_err(hba->dev,
7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6063  			"%s: Enable WB buf resize operation failed %d\n",
7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6064  			__func__, ret);
7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6065  out:
7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6066  	ufshcd_scsi_unblock_requests(hba);
7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08 @6067  	return ret;
                                                                               ^^^

7b70b34c503067 drivers/ufs/core/ufshcd.c Lu Hongfei  2023-09-08  6068  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

