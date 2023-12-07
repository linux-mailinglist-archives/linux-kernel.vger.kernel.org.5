Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A660980803E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjLGFgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGFgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:36:32 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350C4DE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 21:36:34 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-333630e9e43so554122f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 21:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701927393; x=1702532193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKKdA0pKK+DStB7nNq/u7uQgrp7qgpRk20DuhU/uuFw=;
        b=XsLPNmD/Z+R+MIgdM4qwZjk/tqwCzPMwR5uAmsXn3urQyX1a9PxtymjJWcTXxa1JXu
         dXs9l2tZy8Q108xTc7p40GrVgRdb5ffAJqKkHT1L5syOoJEbHe0jAaKvVYfdh+CMGLux
         u7XfGroKzYHotsYzY/qG+3IdLCXHdgODbbGEzV/MEI3cEcswwAnMrY2PiYxZxwc0WY3V
         3SWSM0K4N30al8Y2XRGQ8Kq7GJkum1S6H8XzJKhTA9eivVPCrhk7CfRIvhsE6EDQl2ZM
         ns/UPINhPumoXxb2wEaeTBhcJpVBmaE3ztlzNMjpBH2QJpQTKL1Em2k3jzrisbIPR0II
         pyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701927393; x=1702532193;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKKdA0pKK+DStB7nNq/u7uQgrp7qgpRk20DuhU/uuFw=;
        b=U+/dBXZnIecy2FY80FgHZPL0wrQ/6dYZBpaSvJpN+F/znQ+rNCin3kDUTSWhrQbyjq
         2aC8bhIdFn7EdZVGB0a/jiUdGV+n2ISHrGg4Y9MKkpUrFGOFwp0Aou70m33QDXx5ABJl
         cacFcTM6uosCH2t2IBckcykqFemGurnKHTRPj+cZp0ga9pZVUqah2G/OJF6NcIe7XrBB
         2rEk4taZI1MgI9ImSHgluv8SGeFqitTwOsQGu4R9mjawYAL5otnc7LxmBSpKt4WgGvq5
         6iQltwFVw4rMNeGRP+BLh6U9nQIWZbrhmmuwrZy+DNMBLzqWUNU+/fSIKnJWyxxtJOFk
         2dvQ==
X-Gm-Message-State: AOJu0YwEmDLO98LdVHcL2kZ+FfyWFFGbIYOmIC/I/MgzkBadhWfsH9eE
        vFbmzVj992krcsqIs4MHdsNOlg==
X-Google-Smtp-Source: AGHT+IFi4HIRN2UiPOlet45ZbrWakGrgFmno6Br4elP7b/KXXWCQQutIbrMJ218FpN9charPtkQYMQ==
X-Received: by 2002:a05:600c:458d:b0:40a:45ff:fd69 with SMTP id r13-20020a05600c458d00b0040a45fffd69mr856572wmo.19.1701927393055;
        Wed, 06 Dec 2023 21:36:33 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c458800b0040b3867a297sm617806wmo.36.2023.12.06.21.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 21:36:32 -0800 (PST)
Date:   Thu, 7 Dec 2023 08:36:29 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Daniel Wagner <dwagner@suse.de>,
        linux-nvme@lists.infradead.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v3 3/4] nvme: move ns id info to struct nvme_ns_head
Message-ID: <9877974d-3943-42e6-b89b-cd2704cdf20d@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206081244.32733-4-dwagner@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvme-lookup-ctrl-from-request-instead-from-namespace/20231206-161455
base:   v6.7-rc4
patch link:    https://lore.kernel.org/r/20231206081244.32733-4-dwagner%40suse.de
patch subject: [PATCH v3 3/4] nvme: move ns id info to struct nvme_ns_head
config: i386-randconfig-141-20231207 (https://download.01.org/0day-ci/archive/20231207/202312071105.jkXzp8v9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231207/202312071105.jkXzp8v9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312071105.jkXzp8v9-lkp@intel.com/

smatch warnings:
drivers/nvme/target/passthru.c:354 nvmet_passthru_execute_cmd() warn: variable dereferenced before check 'ns' (see line 342)

vim +/ns +354 drivers/nvme/target/passthru.c

c1fef73f793b7f Logan Gunthorpe    2020-07-24  292  static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
c1fef73f793b7f Logan Gunthorpe    2020-07-24  293  {
ab7a2737ac5acd Christoph Hellwig  2021-08-27  294  	struct nvme_ctrl *ctrl = nvmet_req_subsys(req)->passthru_ctrl;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  295  	struct request_queue *q = ctrl->admin_q;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  296  	struct nvme_ns *ns = NULL;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  297  	struct request *rq = NULL;
47e9730c26a4a5 Chaitanya Kulkarni 2020-11-09  298  	unsigned int timeout;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  299  	u32 effects;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  300  	u16 status;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  301  	int ret;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  302  
c1fef73f793b7f Logan Gunthorpe    2020-07-24  303  	if (likely(req->sq->qid != 0)) {
c1fef73f793b7f Logan Gunthorpe    2020-07-24  304  		u32 nsid = le32_to_cpu(req->cmd->common.nsid);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  305  
c1fef73f793b7f Logan Gunthorpe    2020-07-24  306  		ns = nvme_find_get_ns(ctrl, nsid);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  307  		if (unlikely(!ns)) {
c1fef73f793b7f Logan Gunthorpe    2020-07-24  308  			pr_err("failed to get passthru ns nsid:%u\n", nsid);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  309  			status = NVME_SC_INVALID_NS | NVME_SC_DNR;
4db69a3d7cfe31 Chaitanya Kulkarni 2020-08-06  310  			goto out;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  311  		}
c1fef73f793b7f Logan Gunthorpe    2020-07-24  312  
c1fef73f793b7f Logan Gunthorpe    2020-07-24  313  		q = ns->queue;
20c2c3bb83f26c Chaitanya Kulkarni 2021-02-09  314  		timeout = nvmet_req_subsys(req)->io_timeout;
a2f6a2b8ce43db Chaitanya Kulkarni 2020-11-09  315  	} else {
20c2c3bb83f26c Chaitanya Kulkarni 2021-02-09  316  		timeout = nvmet_req_subsys(req)->admin_timeout;

ns is NULL here

c1fef73f793b7f Logan Gunthorpe    2020-07-24  317  	}
c1fef73f793b7f Logan Gunthorpe    2020-07-24  318  
e559398f47e090 Christoph Hellwig  2022-03-15  319  	rq = blk_mq_alloc_request(q, nvme_req_op(req->cmd), 0);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  320  	if (IS_ERR(rq)) {
c1fef73f793b7f Logan Gunthorpe    2020-07-24  321  		status = NVME_SC_INTERNAL;
4db69a3d7cfe31 Chaitanya Kulkarni 2020-08-06  322  		goto out_put_ns;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  323  	}
e559398f47e090 Christoph Hellwig  2022-03-15  324  	nvme_init_request(rq, req->cmd);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  325  
a2f6a2b8ce43db Chaitanya Kulkarni 2020-11-09  326  	if (timeout)
a2f6a2b8ce43db Chaitanya Kulkarni 2020-11-09  327  		rq->timeout = timeout;
a2f6a2b8ce43db Chaitanya Kulkarni 2020-11-09  328  
c1fef73f793b7f Logan Gunthorpe    2020-07-24  329  	if (req->sg_cnt) {
c1fef73f793b7f Logan Gunthorpe    2020-07-24  330  		ret = nvmet_passthru_map_sg(req, rq);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  331  		if (unlikely(ret)) {
c1fef73f793b7f Logan Gunthorpe    2020-07-24  332  			status = NVME_SC_INTERNAL;
a2138fd49467d0 Chaitanya Kulkarni 2020-08-06  333  			goto out_put_req;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  334  		}
c1fef73f793b7f Logan Gunthorpe    2020-07-24  335  	}
c1fef73f793b7f Logan Gunthorpe    2020-07-24  336  
c1fef73f793b7f Logan Gunthorpe    2020-07-24  337  	/*
2a459f6933e1c4 Christoph Hellwig  2022-12-21  338  	 * If a command needs post-execution fixups, or there are any
2a459f6933e1c4 Christoph Hellwig  2022-12-21  339  	 * non-trivial effects, make sure to execute the command synchronously
2a459f6933e1c4 Christoph Hellwig  2022-12-21  340  	 * in a workqueue so that nvme_passthru_end gets called.
c1fef73f793b7f Logan Gunthorpe    2020-07-24  341  	 */
a754bb00c0d393 Daniel Wagner      2023-12-06 @342  	effects = nvme_command_effects(ctrl, ns->head, req->cmd->common.opcode);
                                                                                             ^^^^^^^^
Unchecked dereference

2a459f6933e1c4 Christoph Hellwig  2022-12-21  343  	if (req->p.use_workqueue ||
2a459f6933e1c4 Christoph Hellwig  2022-12-21  344  	    (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))) {
c1fef73f793b7f Logan Gunthorpe    2020-07-24  345  		INIT_WORK(&req->p.work, nvmet_passthru_execute_cmd_work);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  346  		req->p.rq = rq;
8832cf922151e9 Sagi Grimberg      2022-03-21  347  		queue_work(nvmet_wq, &req->p.work);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  348  	} else {
e2e530867245d0 Christoph Hellwig  2022-05-24  349  		rq->end_io = nvmet_passthru_req_done;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  350  		rq->end_io_data = req;
e2e530867245d0 Christoph Hellwig  2022-05-24  351  		blk_execute_rq_nowait(rq, false);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  352  	}
c1fef73f793b7f Logan Gunthorpe    2020-07-24  353  
c1fef73f793b7f Logan Gunthorpe    2020-07-24 @354  	if (ns)

The rest of the code checks

c1fef73f793b7f Logan Gunthorpe    2020-07-24  355  		nvme_put_ns(ns);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  356  
c1fef73f793b7f Logan Gunthorpe    2020-07-24  357  	return;
c1fef73f793b7f Logan Gunthorpe    2020-07-24  358  
a2138fd49467d0 Chaitanya Kulkarni 2020-08-06  359  out_put_req:
7ee51cf60a90c2 Chaitanya Kulkarni 2020-08-06  360  	blk_mq_free_request(rq);
4db69a3d7cfe31 Chaitanya Kulkarni 2020-08-06  361  out_put_ns:
c1fef73f793b7f Logan Gunthorpe    2020-07-24  362  	if (ns)
c1fef73f793b7f Logan Gunthorpe    2020-07-24  363  		nvme_put_ns(ns);
4db69a3d7cfe31 Chaitanya Kulkarni 2020-08-06  364  out:
c1fef73f793b7f Logan Gunthorpe    2020-07-24  365  	nvmet_req_complete(req, status);
c1fef73f793b7f Logan Gunthorpe    2020-07-24  366  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

