Return-Path: <linux-kernel+bounces-156361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372068B01C6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EC6285168
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC3156F38;
	Wed, 24 Apr 2024 06:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3hwG3H4"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA8A156C6F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940103; cv=none; b=BJoyw8ea4/FqF2krDrqhhFoDC9uRUglZxbINsDRF8+K5+P3YPhX4qip8bjTUGBe64xVH6EB9J1Z5+1rhLmUhjvE6S8D5V3efyeViJJoy/2i/ki+u1pei4V28BtsOA2rSUNkXtgMWBh7M59ytqBX7Ozsnj8Omhg/KEall0uUgdbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940103; c=relaxed/simple;
	bh=RjJ/ynGTB0AOtlxqX8QKWNLmIIpoEyLSgAJn+OvJws8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Rd54tlihbjQ3JGXmrJsou6bklB3P9t380luv5tKitlXV40vvuL59COgJfrPfoLn2SMArtzObWvl303kENoBCjxnbJolU6qeUtYe4CPdE6/uwNfNwZTjSOzDy6o4etLjVteudu4I04za/pgRPXGgu5cCqAYZFONlJY7NUqmW7lVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e3hwG3H4; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34a4772d5easo5271144f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713940100; x=1714544900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkVAcaBjqkDWZAIL4vc+SZ6sTNCsVsKfK7+mih+QGWU=;
        b=e3hwG3H4rYEx9ctTkjAzq0cu2o+/HeMRPlptWtD7EYI4nOrtBrXZxCz328eQykWQQr
         FWaPb1IsoY7MKQ4R/mMkY43rWrKLmGcU4P83XwKL9cmWf8R+ECjbJpCuSJfRTKp8SAq2
         4RJtTgbGOYykBuuk+D/BDD1XPjeW+EOeZgl5h0wHaNIeqN/CGl7+OfJuEFO8Hxd32vTR
         gW7ApGeM7gpAs99Nl4CgZp3EPsjIIBVgJChcJLrrWWIKtRE+yEqxaATcMnLMpS0CIWMF
         QFW9q0+Dr8HnQwolSv3FeMn71QnY3xanVmB7uIAt6SIlR6fshyT+eGdFWnKfQ5y0dek3
         ogNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713940100; x=1714544900;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkVAcaBjqkDWZAIL4vc+SZ6sTNCsVsKfK7+mih+QGWU=;
        b=nG8GiqCt4nHPPWiY7kvT+0RT9JFRY04oNRB8hRePplNFamRnQkrqStM67SuDqJadtr
         1uHQHe9AhndNHV7Gwb1nOuDFHunaPb7w8aFDIltiiYQCe1yr9JCHUS4PYi69YZbyxios
         fVNL4kM3p6BSzCP2wEcnfMowZkKW4b4lp5G8zB5Pys3aLSjs503GmQFi5Ai0QRORYFAS
         cVRUxGNUwGG8tL9Q6lOL3zPCaNeGg4CI42U3xlGlFf5gwR/ICGl1iL9BToFQOnzPQDSh
         t8m9W8RjC8zv4v4NFx/e36QR6oJyCd/gv75tIzZ5xpjEb0CgVbiQcZnySZmyY5F7eo8s
         z+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXHOTydfL90rqu2UAoTVhSzwDKeWs/JGHC2+T4044/Wo5vWguC1kAu+EXxljqr0DFWTPcrJY5r4kItQnFP3E9lcm0EpX20/jraI7030
X-Gm-Message-State: AOJu0YyekdlqNzAEVdjWK9exJ6ze8sKI8Ug6xB+r0+yU3Cb+6Pz/Z25f
	m8z3Aks5luMUpB87GdyMePp5LDqcXVeV8ld8SoZEx+6aouc32wHkRCIi4wCe60Q=
X-Google-Smtp-Source: AGHT+IFG2RK/ltTFm8U7OE3v060eusfCPLzMCGGAoNZGAXimI5J53LJYa0QgynM9AnKLVkklNsCPtw==
X-Received: by 2002:adf:f351:0:b0:347:a286:c136 with SMTP id e17-20020adff351000000b00347a286c136mr978357wrp.15.1713940099997;
        Tue, 23 Apr 2024 23:28:19 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id j6-20020adff006000000b00349856b640bsm16304622wro.67.2024.04.23.23.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 23:28:19 -0700 (PDT)
Date: Wed, 24 Apr 2024 09:28:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Steve French <stfrench@microsoft.com>
Subject: fs/smb/server/smb2pdu.c:1992 smb2_tree_connect() error:
 uninitialized symbol 'share'.
Message-ID: <e9ead449-6ea6-4017-b26a-3a80ea6d4018@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d1ddab261f3e2af7c384dc02238784ce0cf9f98
commit: e9d8c2f95ab8acaf3f4d4a53682a4afa3c263692 ksmbd: add continuous availability share parameter
config: x86_64-randconfig-161-20240424 (https://download.01.org/0day-ci/archive/20240424/202404241435.Yxr6Wapq-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202404241435.Yxr6Wapq-lkp@intel.com/

New smatch warnings:
fs/smb/server/smb2pdu.c:1992 smb2_tree_connect() error: uninitialized symbol 'share'.

vim +/share +1992 fs/smb/server/smb2pdu.c

e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1921  int smb2_tree_connect(struct ksmbd_work *work)
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1922  {
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1923  	struct ksmbd_conn *conn = work->conn;
7b7d709ef7cf28 fs/smb/server/smb2pdu.c Namjae Jeon       2023-06-24  1924  	struct smb2_tree_connect_req *req;
7b7d709ef7cf28 fs/smb/server/smb2pdu.c Namjae Jeon       2023-06-24  1925  	struct smb2_tree_connect_rsp *rsp;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1926  	struct ksmbd_session *sess = work->sess;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1927  	char *treename = NULL, *name = NULL;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1928  	struct ksmbd_tree_conn_status status;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1929  	struct ksmbd_share_config *share;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1930  	int rc = -EINVAL;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1931  
7b7d709ef7cf28 fs/smb/server/smb2pdu.c Namjae Jeon       2023-06-24  1932  	WORK_BUFFERS(work, req, rsp);
7b7d709ef7cf28 fs/smb/server/smb2pdu.c Namjae Jeon       2023-06-24  1933  
c6cd2e8d2d9aa7 fs/smb/server/smb2pdu.c Namjae Jeon       2024-03-19  1934  	treename = smb_strndup_from_utf16((char *)req + le16_to_cpu(req->PathOffset),
070fb21e5912b6 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-05-26  1935  					  le16_to_cpu(req->PathLength), true,
070fb21e5912b6 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-05-26  1936  					  conn->local_nls);
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1937  	if (IS_ERR(treename)) {
bde1694aecdb53 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-06-28  1938  		pr_err("treename is NULL\n");
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1939  		status.ret = KSMBD_TREE_CONN_STATUS_ERROR;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1940  		goto out_err1;
                                                                                        ^^^^^^^^^^^^^

e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1941  	}
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1942  
16b5f54e30c1dd fs/ksmbd/smb2pdu.c      Atte Heikkilä     2022-09-15  1943  	name = ksmbd_extract_sharename(conn->um, treename);
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1944  	if (IS_ERR(name)) {
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1945  		status.ret = KSMBD_TREE_CONN_STATUS_ERROR;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1946  		goto out_err1;
                                                                                        ^^^^^^^^^^^^^
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1947  	}
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1948  
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1949  	ksmbd_debug(SMB, "tree connect request for tree %s treename %s\n",
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1950  		    name, treename);
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1951  
af7c39d971e43c fs/ksmbd/smb2pdu.c      Namjae Jeon       2022-07-25  1952  	status = ksmbd_tree_conn_connect(conn, sess, name);
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1953  	if (status.ret == KSMBD_TREE_CONN_STATUS_OK)
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1954  		rsp->hdr.Id.SyncId.TreeId = cpu_to_le32(status.tree_conn->id);
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1955  	else
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1956  		goto out_err1;

share is unitialized

e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1957  
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1958  	share = status.tree_conn->share_conf;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1959  	if (test_share_config_flag(share, KSMBD_SHARE_FLAG_PIPE)) {
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1960  		ksmbd_debug(SMB, "IPC share path request\n");
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1961  		rsp->ShareType = SMB2_SHARE_TYPE_PIPE;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1962  		rsp->MaximalAccess = FILE_READ_DATA_LE | FILE_READ_EA_LE |
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1963  			FILE_EXECUTE_LE | FILE_READ_ATTRIBUTES_LE |
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1964  			FILE_DELETE_LE | FILE_READ_CONTROL_LE |
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1965  			FILE_WRITE_DAC_LE | FILE_WRITE_OWNER_LE |
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1966  			FILE_SYNCHRONIZE_LE;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1967  	} else {
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1968  		rsp->ShareType = SMB2_SHARE_TYPE_DISK;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1969  		rsp->MaximalAccess = FILE_READ_DATA_LE | FILE_READ_EA_LE |
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1970  			FILE_EXECUTE_LE | FILE_READ_ATTRIBUTES_LE;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1971  		if (test_tree_conn_flag(status.tree_conn,
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1972  					KSMBD_TREE_CONN_FLAG_WRITABLE)) {
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1973  			rsp->MaximalAccess |= FILE_WRITE_DATA_LE |
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1974  				FILE_APPEND_DATA_LE | FILE_WRITE_EA_LE |
3aefd54da5ec6e fs/cifsd/smb2pdu.c      Wan Jiabing       2021-06-07  1975  				FILE_DELETE_LE | FILE_WRITE_ATTRIBUTES_LE |
3aefd54da5ec6e fs/cifsd/smb2pdu.c      Wan Jiabing       2021-06-07  1976  				FILE_DELETE_CHILD_LE | FILE_READ_CONTROL_LE |
3aefd54da5ec6e fs/cifsd/smb2pdu.c      Wan Jiabing       2021-06-07  1977  				FILE_WRITE_DAC_LE | FILE_WRITE_OWNER_LE |
3aefd54da5ec6e fs/cifsd/smb2pdu.c      Wan Jiabing       2021-06-07  1978  				FILE_SYNCHRONIZE_LE;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1979  		}
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1980  	}
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1981  
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1982  	status.tree_conn->maximal_access = le32_to_cpu(rsp->MaximalAccess);
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1983  	if (conn->posix_ext_supported)
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1984  		status.tree_conn->posix_extensions = true;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1985  
33b235a6e6ebe0 fs/smb/server/smb2pdu.c Namjae Jeon       2023-10-05  1986  	write_lock(&sess->tree_conns_lock);
33b235a6e6ebe0 fs/smb/server/smb2pdu.c Namjae Jeon       2023-10-05  1987  	status.tree_conn->t_state = TREE_CONNECTED;
33b235a6e6ebe0 fs/smb/server/smb2pdu.c Namjae Jeon       2023-10-05  1988  	write_unlock(&sess->tree_conns_lock);
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1989  	rsp->StructureSize = cpu_to_le16(16);
cdfb2fef522d0c fs/ksmbd/smb2pdu.c      Marios Makassikis 2022-12-23  1990  out_err1:
e9d8c2f95ab8ac fs/smb/server/smb2pdu.c Namjae Jeon       2024-04-20  1991  	if (server_conf.flags & KSMBD_GLOBAL_FLAG_DURABLE_HANDLE &&
e9d8c2f95ab8ac fs/smb/server/smb2pdu.c Namjae Jeon       2024-04-20 @1992  	    test_share_config_flag(share,
                                                                                                           ^^^^^

e9d8c2f95ab8ac fs/smb/server/smb2pdu.c Namjae Jeon       2024-04-20  1993  				   KSMBD_SHARE_FLAG_CONTINUOUS_AVAILABILITY))
e9d8c2f95ab8ac fs/smb/server/smb2pdu.c Namjae Jeon       2024-04-20  1994  		rsp->Capabilities = SMB2_SHARE_CAP_CONTINUOUS_AVAILABILITY;
e9d8c2f95ab8ac fs/smb/server/smb2pdu.c Namjae Jeon       2024-04-20  1995  	else
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1996  		rsp->Capabilities = 0;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1997  	rsp->Reserved = 0;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1998  	/* default manual caching */
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  1999  	rsp->ShareFlags = SMB2_SHAREFLAG_MANUAL_CACHING;
e2f34481b24db2 fs/cifsd/smb2pdu.c      Namjae Jeon       2021-03-16  2000  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


