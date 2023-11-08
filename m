Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B807E5078
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjKHGsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHGss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:48:48 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029A31A4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 22:48:46 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5441ba3e53cso8461952a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 22:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699426124; x=1700030924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jb2O/lBBk955CKNe/gEpV8g9kuAg3iF6vieIJ3Ps/0o=;
        b=cITdGJlPC/wrO5VALa7URsvLV6hQnlCrzaBc5G0GlCew/J7yka8D4gBz53yOpTWawY
         B+ZaNSFmFPkOO+SNzHresywUB/LKDJd2gumbQivQoip3FD06AKrBzeXniFq/B2YHQMvo
         xsZ4i2tPoFYoWxjX9DsUcq8vrOSrmvxYxnZ7jV8u/37KjEVZ8IgvWFhhEvZgGr7Oa1aG
         ONTMZAMR425vd8PEpRmLqiic8qoh5uVOElyveXWAJevJfJruF96VhmFagyOq+FbUHjU+
         zcqcs3VRlAEZSTd2y/1H7tuSIv/ubBTCabqzTroJkWjAulamGsu6kKwfbPeZPELEtdFd
         J5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699426124; x=1700030924;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jb2O/lBBk955CKNe/gEpV8g9kuAg3iF6vieIJ3Ps/0o=;
        b=r0rYUBdlEV7UNnfNOtBhoNo4lxHCB5EBYffBRL4cvoST6EOi40M7HtbEGyvqQ3g/oT
         5dUNM3TpsshsUcfXZcDcZ1NfEB4+WU3d81NuFM3mKA7DtBAY0WvXYl7troAL35GDnax/
         vprU4ZoIx3PO7P74M/HUrYm56DK0rgRZ47Ce4m56bhIPvTWoSpJCtk7SyOOQVYobzYw9
         HDhei4gUtWp/Q0dGX5pCAp/85LBYF7xx5V6UAbLgeu86J+qO+HJcPECu7tgLFLPS/Wx4
         EjcBDg17sf5BEym8YD3AKf2vtOMpWydZNyHmyOlzNm2rcjfzzZh3jiWv78j4W9jM9TIJ
         HjqA==
X-Gm-Message-State: AOJu0YwAuJ8xn28aqIjInpOCkMoCQPOiMcCjtPPQyCG0gP2FmJVs/9yY
        yd9NATvnimm7WG3PnoiAcPPHyg==
X-Google-Smtp-Source: AGHT+IHaXbdMnQkxeSuF6krmzXyFXkV0AOojjJ7bqHnUMTGc1KreBH+zRVv3VtilSbX9ZkVZYkTbNQ==
X-Received: by 2002:a50:c352:0:b0:53e:782f:cfa6 with SMTP id q18-20020a50c352000000b0053e782fcfa6mr575642edb.37.1699426124137;
        Tue, 07 Nov 2023 22:48:44 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v19-20020a50d093000000b005434095b179sm6326163edd.92.2023.11.07.22.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 22:48:43 -0800 (PST)
Date:   Wed, 8 Nov 2023 09:48:41 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Qiang Yu <quic_qianyu@quicinc.com>,
        mani@kernel.org, quic_jhugo@quicinc.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_mrana@quicinc.com,
        Qiang Yu <quic_qianyu@quicinc.com>
Subject: Re: [PATCH v3 3/4] bus: mhi: host: Avoid processing buffer and event
 of a disable channel
Message-ID: <12ceff53-bbd0-4e12-9597-f6a4bfd0f87f@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699341365-47737-4-git-send-email-quic_qianyu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiang,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qiang-Yu/bus-mhi-host-Add-spinlock-to-protect-WP-access-when-queueing-TREs/20231107-151918
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git mhi-next
patch link:    https://lore.kernel.org/r/1699341365-47737-4-git-send-email-quic_qianyu%40quicinc.com
patch subject: [PATCH v3 3/4] bus: mhi: host: Avoid processing buffer and event of a disable channel
config: x86_64-randconfig-161-20231107 (https://download.01.org/0day-ci/archive/20231108/202311080155.MiyREgoQ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231108/202311080155.MiyREgoQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202311080155.MiyREgoQ-lkp@intel.com/

smatch warnings:
drivers/bus/mhi/host/main.c:1257 mhi_gen_tre() warn: inconsistent returns '&mhi_chan->lock'.

vim +1257 drivers/bus/mhi/host/main.c

189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1204  int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1205  			struct mhi_buf_info *info, enum mhi_flags flags)
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1206  {
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1207  	struct mhi_ring *buf_ring, *tre_ring;
84f5f31f110e5e drivers/bus/mhi/host/main.c Manivannan Sadhasivam 2022-03-01  1208  	struct mhi_ring_element *mhi_tre;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1209  	struct mhi_buf_info *buf_info;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1210  	int eot, eob, chain, bei;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1211  	int ret;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1212  
da05b5d43f483c drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-11-07  1213  	/* Protect accesses for reading and incrementing WP */
da05b5d43f483c drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-11-07  1214  	write_lock_bh(&mhi_chan->lock);
6025cde6ecb13c drivers/bus/mhi/host/main.c Qiang Yu              2023-11-07  1215  	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
6025cde6ecb13c drivers/bus/mhi/host/main.c Qiang Yu              2023-11-07  1216  		return -EINVAL;

This looks like two people submitted patches on the same day?
We should unlock before returning?

da05b5d43f483c drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-11-07  1217  
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1218  	buf_ring = &mhi_chan->buf_ring;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1219  	tre_ring = &mhi_chan->tre_ring;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1220  
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1221  	buf_info = buf_ring->wp;
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1222  	WARN_ON(buf_info->used);
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1223  	buf_info->pre_mapped = info->pre_mapped;
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1224  	if (info->pre_mapped)
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1225  		buf_info->p_addr = info->p_addr;
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1226  	else
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1227  		buf_info->v_addr = info->v_addr;
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1228  	buf_info->cb_buf = info->cb_buf;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1229  	buf_info->wp = tre_ring->wp;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1230  	buf_info->dir = mhi_chan->dir;
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1231  	buf_info->len = info->len;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1232  
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1233  	if (!info->pre_mapped) {
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1234  		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
da05b5d43f483c drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-11-07  1235  		if (ret) {
da05b5d43f483c drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-11-07  1236  			write_unlock_bh(&mhi_chan->lock);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1237  			return ret;
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1238  		}
da05b5d43f483c drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-11-07  1239  	}
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1240  
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1241  	eob = !!(flags & MHI_EOB);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1242  	eot = !!(flags & MHI_EOT);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1243  	chain = !!(flags & MHI_CHAIN);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1244  	bei = !!(mhi_chan->intmod);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1245  
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1246  	mhi_tre = tre_ring->wp;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1247  	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
cd116318803f5e drivers/bus/mhi/core/main.c Hemant Kumar          2020-05-21  1248  	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(info->len);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1249  	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, eot, eob, chain);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1250  
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1251  	/* increment WP */
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1252  	mhi_add_ring_element(mhi_cntrl, tre_ring);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1253  	mhi_add_ring_element(mhi_cntrl, buf_ring);
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1254  
da05b5d43f483c drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-11-07  1255  	write_unlock_bh(&mhi_chan->lock);
da05b5d43f483c drivers/bus/mhi/host/main.c Bhaumik Bhatt         2023-11-07  1256  
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20 @1257  	return 0;
189ff97cca53e3 drivers/bus/mhi/core/main.c Manivannan Sadhasivam 2020-02-20  1258  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

