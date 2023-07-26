Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56954763877
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjGZOIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjGZOHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:25 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59D62D5D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:05 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230726140704euoutp02786645ca45e9512efadf0fd3cc8bfa5c~1cApBt-Ft1608116081euoutp02J
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230726140704euoutp02786645ca45e9512efadf0fd3cc8bfa5c~1cApBt-Ft1608116081euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690380424;
        bh=Nj7Ghn+kSOTETzoJsaSu9wi1agkqgAyigWTwaRVhj0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HbnW/01MMcRCUhrsw3LYP6YjvDlXVP1MYApY5uoZdJmbfsrwN26OoN2OHYPgCiOBd
         0YucJmFEG67aChRlzsG8aquq5auZfYYNphVIxMK/01giXLTjURJ+6zxGk4TpO7tvCt
         6xZXQkBs3Kfs5pzrNM3yGS9pXvThzX9I2zh5pxks=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230726140704eucas1p100b74ffbb75f5a4cb26bcfdedf619471~1cAornRKb2261122611eucas1p1p;
        Wed, 26 Jul 2023 14:07:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8B.F6.11320.78821C46; Wed, 26
        Jul 2023 15:07:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230726140703eucas1p2786577bcc67d5ae434671dac11870c60~1cAn-_eJa0080000800eucas1p2s;
        Wed, 26 Jul 2023 14:07:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230726140703eusmtrp262155482faef2d00243300fa4bb51762~1cAn-O03L2063520635eusmtrp2F;
        Wed, 26 Jul 2023 14:07:03 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-43-64c128872c53
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 87.57.14344.78821C46; Wed, 26
        Jul 2023 15:07:03 +0100 (BST)
Received: from localhost (unknown [106.210.248.223]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230726140703eusmtip2325884d0d96c3ee20ec7922d060314b9~1cAn01PTT2007220072eusmtip2H;
        Wed, 26 Jul 2023 14:07:03 +0000 (GMT)
From:   Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org, Joerg Reuter <jreuter@yaina.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     willy@infradead.org, keescook@chromium.org, josh@joshtriplett.org,
        Joel Granados <j.granados@samsung.com>,
        linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] ax.25: Update to register_net_sysctl_sz
Date:   Wed, 26 Jul 2023 16:06:29 +0200
Message-Id: <20230726140635.2059334-10-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230726140635.2059334-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djP87odGgdTDM58ZbSYc76FxeLpsUfs
        Fkv3P2S0+L8g3+JnH7fFme5ciwvb+lgtrm2/y2RxedccNosbE54yWhxbIGbx7fQbRotLe1Qs
        fv+Yw+bA5zG74SKLx5aVN5k8Fmwq9di8Qsvj1mtbj02rOtk8jq5cy+Txft9VNo++LasYPT5v
        kvN4M+01UwB3FJdNSmpOZllqkb5dAlfG4buT2ArWsVf8+fmYvYFxJlsXIyeHhICJxPGJd9i7
        GLk4hARWMEr83PiEGcL5wigx6W8PI0iVkMBnRomN621gOs49OQtVtJxRYu3X14wQzktGiYm3
        Z4DNZRPQkTj/5g5YlYjAB0aJ9qcHwKqYBQ4zSnz92cUOUiUsYCfxaPlLsA4WAVWJpXfnsIDY
        vEDxnqutUBfKS7Rdnw52BydQfOXa76wQNYISJ2c+AatnBqpp3jobbJuEQDenxJ+fF1khml0k
        tsz9xw5hC0u8Or4FypaR+L9zPhNEw2RGif3/PrBDOKsZJZY1fmWCqLKWaLnyBCjBAbRCU2L9
        Ln2IsKPEmZ4drCBhCQE+iRtvBSGO4JOYtG06M0SYV6KjTQiiWkWib+kUFghbSuL65Z1Qf3lI
        PL55jXkCo+IsJO/MQvLOLIS9CxiZVzGKp5YW56anFhvlpZbrFSfmFpfmpesl5+duYgSmuNP/
        jn/Zwbj81Ue9Q4xMHIyHGCU4mJVEeA1j9qUI8aYkVlalFuXHF5XmpBYfYpTmYFES59W2PZks
        JJCeWJKanZpakFoEk2Xi4JRqYBL5U/1x+uHj86pZQ1YLRyxPyOfcuOfUvLVrBTTPbLpfeG2X
        ztITO26oL/L0qL114OoG9zJO1Umt/5782/66MVW1oEEs6dE+zdNf/0UYKRieY5uYqyLu8HFF
        kOLBep9Uq6V9vN4isZqn3D4/6d8RYvyhY+/v1oqWy1qTdxTe2XrnY5LJksq7b/02u/0W/j2r
        ZVqn7zqunRaCKTWXthzaoVD77uXHzAVv9W0Ct/7bt0rr1t6VOl9Lv7Js38u27pWX6a1Hzu/i
        dc6Kvuoz3HKd58YVr/4pU0UeH3I71rHww6f6x+9L9+VX18TUft55PCL954Fg7YkdV4rWnb6t
        NKH7bZHk1rC1n1vr4pdVvvnB/6/ynBJLcUaioRZzUXEiACR2UqXgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7rtGgdTDNbfFLaYc76FxeLpsUfs
        Fkv3P2S0+L8g3+JnH7fFme5ciwvb+lgtrm2/y2RxedccNosbE54yWhxbIGbx7fQbRotLe1Qs
        fv+Yw+bA5zG74SKLx5aVN5k8Fmwq9di8Qsvj1mtbj02rOtk8jq5cy+Txft9VNo++LasYPT5v
        kvN4M+01UwB3lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllq
        kb5dgl7G4buT2ArWsVf8+fmYvYFxJlsXIyeHhICJxLknZ5m7GLk4hASWMkpc6TjL2sXIAZSQ
        kvi+jBOiRljiz7UuNoia54wSF5bfB2tmE9CROP/mDliziMA3RokJVy8ygiSYBU4zSnQfkgCx
        hQXsJB4tfwnWwCKgKrH07hwWEJsXKN5ztRXqCnmJtuvTwXo5geIr135nBbGFBGwleqY+ZYeo
        F5Q4OfMJC8R8eYnmrbOZJzAKzEKSmoUktYCRaRWjSGppcW56brGRXnFibnFpXrpecn7uJkZg
        HG479nPLDsaVrz7qHWJk4mA8xCjBwawkwmsYsy9FiDclsbIqtSg/vqg0J7X4EKMp0N0TmaVE
        k/OBiSCvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoFpguO8pcn7
        ND9mlgbnxfP82Cv71J1d/6hr6n3eDnOPeIWdu3kaDkfeC5rXfJlTpKt8k5MK050p+zpXThJf
        ePvfDtYXU+IZTzR5xho/lsmTqVTOd1UO7Q9afnmKMkf8r1tfd1pk/Fm0NsVc1DhGlnPGEz4m
        970lzC9+n/Da0qlhFsjisue25PfVvs2m95YsZqiP/lUycduFM9knVspOfKQSJbiFtafzh7+3
        eC6XM/PEbz5TJ3oZ+bbNDl1/STXOdK5qq93e3tJyvpRN+ktXm809/VjL9ZWGi56/baiQ6sby
        BZf/q+rtu7wrcyWfhnawUeediN70p4d3ftSJ9Zx0s5H9nnbrvq6ELbzWRUaTZJVYijMSDbWY
        i4oTASZ3r8BMAwAA
X-CMS-MailID: 20230726140703eucas1p2786577bcc67d5ae434671dac11870c60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230726140703eucas1p2786577bcc67d5ae434671dac11870c60
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140703eucas1p2786577bcc67d5ae434671dac11870c60
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140703eucas1p2786577bcc67d5ae434671dac11870c60@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is part of the effort to remove the sentinel (last empty) element
from the ctl_table arrays. We update to the new function and pass it the
array size.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/ax25/sysctl_net_ax25.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
index 2154d004d3dc..db66e11e7fe8 100644
--- a/net/ax25/sysctl_net_ax25.c
+++ b/net/ax25/sysctl_net_ax25.c
@@ -159,7 +159,8 @@ int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
 		table[k].data = &ax25_dev->values[k];
 
 	snprintf(path, sizeof(path), "net/ax25/%s", ax25_dev->dev->name);
-	ax25_dev->sysheader = register_net_sysctl(&init_net, path, table);
+	ax25_dev->sysheader = register_net_sysctl_sz(&init_net, path, table,
+						     ARRAY_SIZE(ax25_param_table));
 	if (!ax25_dev->sysheader) {
 		kfree(table);
 		return -ENOMEM;
-- 
2.30.2

