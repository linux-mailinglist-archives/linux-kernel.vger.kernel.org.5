Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4EE7C4B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbjJKHPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjJKHPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:15:43 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1FB9B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:15:40 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-503f39d3236so7828450e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697008539; x=1697613339; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7z9KLR0xuq/1ZC7Hf1voQfsB0dArsVBPmdduY9bNHqw=;
        b=rRae+iakKC39ZVonYDqWL6Ab58+McuhvBoEKiW2VFyY/LDRQNfXhJigQrUMsNpN6RQ
         2+JXRwoCjPUYfDQ5+bcFzDnc5LOojw1Z3l36e+kh+Hi6B/xcnRlIJBpoKYyy2Fx3YxJ6
         RSxrlowkuJyzDoUrEQmBelm0hjMLs7CCnrabLdf/FOpO17N/vv0nYBFJe+Hggef29ojG
         HdDwzJAmABlv0/u+Z34BYxg8Zv3LxKdzD4lAIZW/HetXumFGWuz5J+eRFgHwr+U8Qyr5
         Ga7wEidH3JFF7knBOkOC8x3EXusGrbHiK26xazdH2InGDtLIgIisJF5DHr4uEk1RoWpu
         7fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697008539; x=1697613339;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7z9KLR0xuq/1ZC7Hf1voQfsB0dArsVBPmdduY9bNHqw=;
        b=a5iL1FjtNJ6vi1B4Y0MjfmslqQmxk2gBmXKvJOCqZ4l2C4aeJBD8OYu4VzxqkVFr/v
         nJ1YQRpPGRRa6C4mSTEqacR+s+qY3urk/LE1tEWwlbvWk3wvs7de1Ky1PiCKPk86jXmz
         EAJewI2jPiiX/Z3TCDOrSrn8nfoH/tUENBrltySsOwtYJIb2bFhO4EXyplsT1VXrDjsq
         kZ5esiu7VjMxrpZXBs7cv5N4KD5WQb2s/GKUDEfr+MhgTsZs0h3JRTYxn1iieCMW3kHl
         Ye+X8dKCtJW2PwvDQ4Xr16mdEhTaIkmwxlpI7+Ml4F9tHyX9mHmHMNx43GXioM9dMDxf
         Fn/A==
X-Gm-Message-State: AOJu0Yx7rT/2ziWWdSqjudalMAtippM8B45Ky1m3AbuAeclw1raC7p63
        XAW2QO8qfBLKEES/5txHrru1gQ==
X-Google-Smtp-Source: AGHT+IHCUyCYWUDhYINLZ0fvhP+DLvI0NF5T6HW+PjVvCQlqvJjfs+jNqYvC6D1NYmm7PN4JvpNC2w==
X-Received: by 2002:a19:771d:0:b0:505:6ede:20b0 with SMTP id s29-20020a19771d000000b005056ede20b0mr15469018lfc.58.1697008538536;
        Wed, 11 Oct 2023 00:15:38 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0acc00b00402f713c56esm15976765wmr.2.2023.10.11.00.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 00:15:38 -0700 (PDT)
Date:   Wed, 11 Oct 2023 10:15:35 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Steve French <stfrench@microsoft.com>
Subject: fs/smb/server/smb2pdu.c:6131 smb2_read_pipe() error: double free of
 'rpc_resp'
Message-ID: <2fd570a5-ceaf-4d9b-8aa2-16e8bd16dbd8@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c8b86a3799f7e5be903c3f49fcdaee29fd385b5
commit: e2b76ab8b5c9327ab2dae6da05d0752eb2f4771d ksmbd: add support for read compound
config: i386-randconfig-141-20231010 (https://download.01.org/0day-ci/archive/20231011/202310111236.IXH2OKfq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231011/202310111236.IXH2OKfq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202310111236.IXH2OKfq-lkp@intel.com/

New smatch warnings:
fs/smb/server/smb2pdu.c:6131 smb2_read_pipe() error: double free of 'rpc_resp'

vim +/rpc_resp +6131 fs/smb/server/smb2pdu.c

e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6076  static noinline int smb2_read_pipe(struct ksmbd_work *work)
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6077  {
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6078  	int nbytes = 0, err;
64b39f4a2fd293cf fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-30  6079  	u64 id;
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6080  	struct ksmbd_rpc_command *rpc_resp;
7b7d709ef7cf2853 fs/smb/server/smb2pdu.c Namjae Jeon     2023-06-24  6081  	struct smb2_read_req *req;
7b7d709ef7cf2853 fs/smb/server/smb2pdu.c Namjae Jeon     2023-06-24  6082  	struct smb2_read_rsp *rsp;
7b7d709ef7cf2853 fs/smb/server/smb2pdu.c Namjae Jeon     2023-06-24  6083  
7b7d709ef7cf2853 fs/smb/server/smb2pdu.c Namjae Jeon     2023-06-24  6084  	WORK_BUFFERS(work, req, rsp);
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6085  
2d004c6cae567e33 fs/ksmbd/smb2pdu.c      Paulo Alcantara 2022-03-21  6086  	id = req->VolatileFileId;
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6087  
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6088  	rpc_resp = ksmbd_rpc_read(work->sess, id);
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6089  	if (rpc_resp) {
e2b76ab8b5c9327a fs/smb/server/smb2pdu.c Namjae Jeon     2023-08-29  6090  		void *aux_payload_buf;
e2b76ab8b5c9327a fs/smb/server/smb2pdu.c Namjae Jeon     2023-08-29  6091  
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6092  		if (rpc_resp->flags != KSMBD_RPC_OK) {
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6093  			err = -EINVAL;
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6094  			goto out;
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6095  		}
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6096  
e2b76ab8b5c9327a fs/smb/server/smb2pdu.c Namjae Jeon     2023-08-29  6097  		aux_payload_buf =
81a94b27847f7d2e fs/smb/server/smb2pdu.c Namjae Jeon     2023-05-31  6098  			kvmalloc(rpc_resp->payload_sz, GFP_KERNEL);
e2b76ab8b5c9327a fs/smb/server/smb2pdu.c Namjae Jeon     2023-08-29  6099  		if (!aux_payload_buf) {
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6100  			err = -ENOMEM;
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6101  			goto out;
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6102  		}
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6103  
e2b76ab8b5c9327a fs/smb/server/smb2pdu.c Namjae Jeon     2023-08-29  6104  		memcpy(aux_payload_buf, rpc_resp->payload, rpc_resp->payload_sz);
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6105  
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6106  		nbytes = rpc_resp->payload_sz;
79f6b11a104f3a32 fs/cifsd/smb2pdu.c      Namjae Jeon     2021-04-02  6107  		kvfree(rpc_resp);

Freed

e2b76ab8b5c9327a fs/smb/server/smb2pdu.c Namjae Jeon     2023-08-29  6108  		err = ksmbd_iov_pin_rsp_read(work, (void *)rsp,
e2b76ab8b5c9327a fs/smb/server/smb2pdu.c Namjae Jeon     2023-08-29  6109  					     offsetof(struct smb2_read_rsp, Buffer),
e2b76ab8b5c9327a fs/smb/server/smb2pdu.c Namjae Jeon     2023-08-29  6110  					     aux_payload_buf, nbytes);
e2b76ab8b5c9327a fs/smb/server/smb2pdu.c Namjae Jeon     2023-08-29  6111  		if (err)
e2b76ab8b5c9327a fs/smb/server/smb2pdu.c Namjae Jeon     2023-08-29  6112  			goto out;

Goto out

e2b76ab8b5c9327a fs/smb/server/smb2pdu.c Namjae Jeon     2023-08-29  6113  	} else {
e2b76ab8b5c9327a fs/smb/server/smb2pdu.c Namjae Jeon     2023-08-29  6114  		err = ksmbd_iov_pin_rsp(work, (void *)rsp,
e2b76ab8b5c9327a fs/smb/server/smb2pdu.c Namjae Jeon     2023-08-29  6115  					offsetof(struct smb2_read_rsp, Buffer));
e2b76ab8b5c9327a fs/smb/server/smb2pdu.c Namjae Jeon     2023-08-29  6116  		if (err)
e2b76ab8b5c9327a fs/smb/server/smb2pdu.c Namjae Jeon     2023-08-29  6117  			goto out;
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6118  	}
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6119  
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6120  	rsp->StructureSize = cpu_to_le16(17);
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6121  	rsp->DataOffset = 80;
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6122  	rsp->Reserved = 0;
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6123  	rsp->DataLength = cpu_to_le32(nbytes);
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6124  	rsp->DataRemaining = 0;
699230f31bf55abc fs/ksmbd/smb2pdu.c      Ronnie Sahlberg 2021-09-09  6125  	rsp->Flags = 0;
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6126  	return 0;
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6127  
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6128  out:
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6129  	rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6130  	smb2_set_err_rsp(work);
79f6b11a104f3a32 fs/cifsd/smb2pdu.c      Namjae Jeon     2021-04-02 @6131  	kvfree(rpc_resp);

Double freed

e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6132  	return err;
e2f34481b24db2fd fs/cifsd/smb2pdu.c      Namjae Jeon     2021-03-16  6133  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

