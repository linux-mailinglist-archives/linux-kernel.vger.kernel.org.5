Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8AC767C76
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 08:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbjG2GOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 02:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjG2GOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 02:14:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77D049DE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 23:14:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31751d7d96eso2505830f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 23:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690611246; x=1691216046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mnM9ZAF5cE2AQMNNS5S+NXlmpKtqMm5oEbcXaptH02I=;
        b=OwkHIH/HuiSNNr7YspeK++Tfd+sxlRF4UcAl20GEvHyhDL3YBvilZ9ZQ6YKwXcDvKM
         gz2xRoM59JtzrsPeePJnZzN0H652+TzsbHJCriVokFrYJfmta9N0QyaDrPup8/4VN9xM
         EeROIBCsiBfeBeADmK2hZrM2n1J4oiEb0IT1GNgcANYvh8X4mHeoiu8c6UNsE4I4vDTF
         JfisNFwEBl9mJ3Spg+/RFWbCTKX2KAEdXflNrNGtGyNn5hYF7orHMbXIs6dq7dLiHfTx
         lwqT1Tk0Co1gN5EmZ5Y8qnd3TLCx+enI0di9ArpnVTfm/+8NLSCljhFPD10KDPqCt4VB
         YcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690611246; x=1691216046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnM9ZAF5cE2AQMNNS5S+NXlmpKtqMm5oEbcXaptH02I=;
        b=QipB3EmrnP062KzBf5+nlYsimHNhzaEUJw2JAelG+kkfjo42AYW0t01UR6DKq6W8Tt
         /KGmsQGwUv1ASbphvUuxIKh+EanheGdkmSxesZI8eInE15f+8tLp4eFgDJ7qJxurF/SS
         jXM3uVLIzxkYoKYtKu28b+fgCQtmgp0OZbELg516nblv1881sWLvXeCTGXj4DX2vPRgV
         09AtryoBHxHKm+l2vmW/kWogrANnsw42pFXs44azs3UwRwRMweN1/iyIW6ltbvnRLnE0
         LVImyjKhLUxNnT6gfkMDjVRrsCqoXravQqsUbOu2vGof0K3/YW73ic/ZlKoUsa0SSiPC
         Dn6w==
X-Gm-Message-State: ABy/qLagCi98uZmxxqxDs2HK/1zNMBc/D9a1d8eLE4bTWe1fGh5lN+KI
        p4jRrY1O8PKW3rFzNDTpN36GNdMcz6I=
X-Google-Smtp-Source: APBJJlHWfSdKkwLzVhAsXku330jDPU7WIaPags9PMFgGOX2fr3iv3zlnhaC/iGtU/B8/eEFxvSribQ==
X-Received: by 2002:a5d:530c:0:b0:314:49d2:aaab with SMTP id e12-20020a5d530c000000b0031449d2aaabmr3279012wrv.8.1690611245527;
        Fri, 28 Jul 2023 23:14:05 -0700 (PDT)
Received: from localhost.localdomain ([2a05:f480:1000:b09:5400:4ff:fe6f:7099])
        by smtp.gmail.com with ESMTPSA id f13-20020adfdb4d000000b003141e9e2f81sm6684416wrj.4.2023.07.28.23.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 23:14:05 -0700 (PDT)
From:   zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-kernel@vger.kernel.org, zhangshida@kylinos.cn,
        starzhangzsd@gmail.com
Subject: [PATCH] ext4: Fix rec_len verify error
Date:   Sat, 29 Jul 2023 14:13:57 +0800
Message-Id: <20230729061357.1702891-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shida Zhang <zhangshida@kylinos.cn>

with the configuration PAGE_SIZE 64k and filesystem blocksize 64k,
a problem occurred when more than 13 millon files were directly created
under a directory:

EXT4-fs error (device xx): ext4_dx_csum_set:492: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
EXT4-fs error (device xx): ext4_dx_csum_verify:463: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
EXT4-fs error (device xx): dx_probe:856: inode #xxxx: block 8188: comm xxxxx: Directory index failed checksum

when enough files are created, the fake_dirent->reclen will be 0xffff.
it doesn't equal to blocksize 65536, i.e. 0x10000.

But it is not the same condition when blocksize equals to 4k.
when enough files are created, the fake_dirent->reclen will be 0x1000.
it equals to blocksize 4k, i.e. 0x1000.

The problem seems to be related to the limitation of the 16-bit field
when the blocksize is set to 64k. To address this, a special condition
was introduced to handle it properly.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/ext4/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 0caf6c730ce3..a422cff25216 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -458,6 +458,9 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
 		    root->info_length != sizeof(struct dx_root_info))
 			return NULL;
 		count_offset = 32;
+	} else if ((EXT4_BLOCK_SIZE(inode->i_sb) == 65536)
+		&& (le16_to_cpu(dirent->rec_len) == 65535)) {
+		count_offset = 8;
 	} else
 		return NULL;
 
-- 
2.27.0

