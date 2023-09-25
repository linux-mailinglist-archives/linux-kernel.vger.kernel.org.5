Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1471C7AD018
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjIYGXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjIYGXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:23:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFED226A0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:21:39 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40471c054f9so18560645e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695622897; x=1696227697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGoflC/MDGiByLKpoE4UCpKhG9wCXgC3jrpF9mnawmc=;
        b=ECMthtLkjF0hBBM6O/lZvvlfnDcHj5vR4Lxe+D45C7tZDbaykHERGtOEudoribQwOl
         Fte35//cCpWckzrS07O64yvry6jMO7VfOKtLeD/nXLDiv4Ysfkf+H89g1LNrj1z+yqOT
         2I18D6Y96LGQEkTX0YHq8CBhSFjxCwXQXdq3HR3fjFYO2ESM8TMMf2E8WFwpGpGwdPup
         XZLZmKwIZdtOhxGa5aszprHKFkSXUEiPr/yUWolFA3Ywh6qOHjxnGhu8WpG7cMtjaH2c
         2AkCOgUwfisfgx/0KcsWXaeaUjfgFWCRkxWW6LnHiDTfwMkT8kuRNTF18tyYP5NqQBI2
         LJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695622897; x=1696227697;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lGoflC/MDGiByLKpoE4UCpKhG9wCXgC3jrpF9mnawmc=;
        b=HBAT1djwmFrZLhAKp0bUfZ20k6k+WLIbR9mvxHHuozFTZLGJ5MrtPI1wqpRPd6VVz3
         9kpx3ghen5/yvZrCq31FzIGyJdM5kMhmXAejp+lxiUWTty6mo74O70dA0fpMHzZUJraz
         RXcKcoYIiTMbOYImbXnhbySj5BOmzKIfqQzqzsOLv+5HfyGX4XtOaDQXky46AOc/X6KU
         MlLHbEPvbribZ7HRmRQo2eKRTCgiyba94qEdjWLS/Wv9DvquGmC1ILS3Nsypg1dZ88kq
         Ap2wOiSBpPB8LlEvF3PsW1cEtW5TIWc+F1L6eY9rgW+pYMrlXLVVFNys5Wx9XkkeyKJi
         us2Q==
X-Gm-Message-State: AOJu0YxAViUFHrHMIoJHKPP8DdccOIJfJzFXrx5iJ2LYFCAjGUe3rrG1
        Bn3sppw0eTNQ9/bw5rTe/ruTSQ==
X-Google-Smtp-Source: AGHT+IHHKt7P8p/soHCBdqvFETlHa38Td/2/3ju/wDTL8KeMQizTMtjs/G1nKdI1QABkE1BOVrDTEw==
X-Received: by 2002:a05:600c:4e05:b0:405:3cc1:e115 with SMTP id b5-20020a05600c4e0500b004053cc1e115mr5041954wmq.3.1695622896458;
        Sun, 24 Sep 2023 23:21:36 -0700 (PDT)
Received: from [172.20.13.88] ([45.147.210.162])
        by smtp.gmail.com with ESMTPSA id u23-20020a05600c211700b004042dbb8925sm14054942wml.38.2023.09.24.23.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 23:21:35 -0700 (PDT)
Message-ID: <71897125-e570-46ce-946a-d4729725e28f@kernel.dk>
Date:   Mon, 25 Sep 2023 00:21:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] ovl: disable IOCB_DIO_CALLER_COMP
Cc:     Zorro Lang <zlang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

overlayfs copies the kiocb flags when it sets up a new kiocb to handle
a write, but it doesn't properly support dealing with the deferred
caller completions of the kiocb. This means it doesn't get the final
write completion value, and hence will complete the write with '0' as
the result.

We could support the caller completions in overlayfs, but for now let's
just disable them in the generated write kiocb.

Reported-by: Zorro Lang <zlang@redhat.com>
Link: https://lore.kernel.org/io-uring/20230924142754.ejwsjen5pvyc32l4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
Fixes: 8c052fb3002e ("iomap: support IOCB_DIO_CALLER_COMP")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 4193633c4c7a..693971d20280 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -391,6 +391,12 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (!ovl_should_sync(OVL_FS(inode->i_sb)))
 		ifl &= ~(IOCB_DSYNC | IOCB_SYNC);
 
+	/*
+	 * Overlayfs doesn't support deferred completions, don't copy
+	 * this property in case it is set by the issuer.
+	 */
+	ifl &= ~IOCB_DIO_CALLER_COMP;
+
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	if (is_sync_kiocb(iocb)) {
 		file_start_write(real.file);

-- 
Jens Axboe

	
