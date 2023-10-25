Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7D57D68E7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343592AbjJYKhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbjJYKhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:37:02 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DAF1FF6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:35:52 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231025103550epoutp01ea5ba5b5b802757fec98d0d8239a4a4e~RU1MfOuPE0369503695epoutp01F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:35:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231025103550epoutp01ea5ba5b5b802757fec98d0d8239a4a4e~RU1MfOuPE0369503695epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698230151;
        bh=kUuKQ/GugZxCJUnbvhRG+iSpQR3fWRlMwpAYp/298R8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkE8unSubpsSyB9gokJlt+AvhFw5ErVt22Bzmde/UjzNZzK2CJWbdYY5Nt0sXXSco
         ipIDl2RaEgQgkfIfxp4eQQeclbVPVDK7a9IsZi9eaCc6XlWkMgCpDwkxUDjS+XVLlj
         wUw/3DxClTMOIOMvoXEbvJncSxD3sXvMsQWeeW6M=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231025103550epcas5p172204395447c4c904108cbccae25580a~RU1LvI37C3052130521epcas5p1x;
        Wed, 25 Oct 2023 10:35:50 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SFlh35t7Vz4x9Q0; Wed, 25 Oct
        2023 10:35:47 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.02.09634.38FE8356; Wed, 25 Oct 2023 19:35:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231025102257epcas5p4bf00a54078bf640dfb2e2e03e671453c~RUp74WI2X0070900709epcas5p4y;
        Wed, 25 Oct 2023 10:22:57 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231025102257epsmtrp11174059a9b1927fd1b178a32610a7baf~RUp73T33S2140421404epsmtrp1Q;
        Wed, 25 Oct 2023 10:22:57 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-13-6538ef8320b5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.D0.08817.18CE8356; Wed, 25 Oct 2023 19:22:57 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231025102253epsmtip17bf391533b2af85b7a60592b19201008~RUp43My9R0054300543epsmtip1F;
        Wed, 25 Oct 2023 10:22:53 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        linux-samsung-soc@vger.kernel.org, andi@etezian.org,
        gost.dev@samsung.com, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        ajaykumar.rs@samsung.com, aakarsh.jain@samsung.com,
        linux-fsd@tesla.com, Smitha T Murthy <smithatmurthy@gmail.com>
Subject: [Patch v4 08/11] media: s5p-mfc: Set context for valid case before
 calling try_run
Date:   Wed, 25 Oct 2023 15:52:13 +0530
Message-Id: <20231025102216.50480-9-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025102216.50480-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xbdRTHc1/tBam5Arqf4AbeuScpo9CyH+O1uU0vbouYLTHgTHdHbyij
        tE1vYUpGBFwZQwQZOh4CIhRNWKETxoAOXHkJLoJDccxIhdG5jSnBUGDs4aPQov99zu98T873
        nN/vR2Le4wI/MkWt53RqVkULPPHLfdu2it+fg1xIw0gQ/K2jgoDWuR4cTtVcFsD65bsonKx3
        4LC3tU0ITd0jKPxy0ErAz/pHCNjeM43Dn62dKBytsOGw6N4tDLbYbxDw1v034Y+WKgEsvNhG
        wPLvv0ZhU79NCBvGR1H4RcsTFNa1LQihobtfCE/nGIndgDHVmBBm3DiPMZ2VNiFT3zWDMi2N
        ZwXMxI0uAdNqfI8xDDzCmaJLjQjzd261kHG0bGCuLTqE8V6JqVFKjlVwukBOnaRRpKiTo+kD
        h+V75bLwEIlYEgF30oFqNo2LpvcdjBe/kqJyDk8HZrCqdOdRPMvz9I6YKJ0mXc8FKjW8Pprm
        tAqVVqoN5tk0Pl2dHKzm9LskISGhMqfwWKrSdK4O0w55vDM0N0tkI6VkAeJBAkoK6isbhQWI
        J+lNXUFAcZUNdQXzCKj9dphwBUsIaC7swtdK6syVAleiGwEDfwxhrsCAgusVBmeGJAWUGAy3
        q1YKfKkcBNjz9SsajCrDgb3ZIVxJ+FBvA1P9LLbCOLUJXPlpcbWDiIoG5bXFqKtbALhw0bqq
        8aBiQO1S7qpZQC2QoODXQcwl2gfOl+QLXewD7g9ecrMfmCnOc3MSsNfNuPUqYO762D1OLLCO
        VeErpjFqGzBbdriO14NPrjWvesCop8GHj2+7/YhAR80abwZVE8uEi18AfRcaEBczYODsGfeG
        ShBgNF3HPkI2VP7fohZBGpHnOS2flszxMq1EzZ3879qSNGktyOoL3x7Xgdim/gzuRVAS6UUA
        idG+ooSDkPMWKdh3MzmdRq5LV3F8LyJzLrAE83s2SeP8Imq9XCKNCJGGh4dLI8LCJfQ60e+G
        aoU3lczquVSO03K6tTqU9PDLRiO5amW1xbdoS9nLliPie7nzdf8oqz89NJXvm4B9UIorO32m
        PY3sqdTY/csyr6uPbmY9UUhfN8yt62vKG1/4pqFbrIncsyeRJu7s+s6we+yQ33TACVtOxIPX
        vPaGSuQ1An9r0ZlWY9ipMUeM/9X5WVvPTOn+rYXU3ch2fXPROUV27eYFWedLE0exTFCcduDh
        ctXkU1nDnQ5rd+h5dtFsdtw0HLXEnpSPHg+I+2spse1zGGe3lx3/5YegjEn29MNZPMHf+3Ce
        Jcj/ja+0JWFY1B2+R9NQvtEm3ZJrIVKa3nrm9qY50bEcUZ55p3k8Mzj7uYxXT4SGPdiYdWR9
        oc+LiozHvTTOK1nJdkzHs/8CEAtlG2oEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRfUyMcRwA8H7P89w9T3H2rDK/03Fzy8xZqVbrt6bCTM/ETsMQw9Gj6O46
        d+UwL4WoKMVs3qU7dDnKpai7uPKoZL0xJaudk4hYR2kR4br57/N92/e7fSncO5eYTu1QpbIa
        lVwh4XsRlY8lMwMyPiM2aNhIob4H53nINlhLoDdXKvlIP/oBQ3b9EIHqyitIZKppwdDNBhsP
        XeVaeOh+7VsCddmqMNR+vodAef0OHJl7O3jI8WktelF9iY9OllXw0LnWhxi6zfWQ6HpnO4Zu
        mH9hqKhimESZNRyJjmYYeAshY7piAkyn4RvOVF3oIRm99SPGmEuy+Ux3h5XPlBsOMZlPfhJM
        3r0SwIwfvkwyQ+aZTNP3IXLl5HivBQmsYsduVjM/aotXkul0Ea5u9NzTOPiFlw7OUDnAk4J0
        KCwqvcB32Zu2ANhXtcidF8E/x+pJt32gcfzDP3v96zmCwZsFdpADKIpPB8Dm+wpX3pfOBLDT
        mI25ApwuJSBXZpiY9qE3QKfBMmGCng0tL78TLgvoSHiu8BTm3iCGt8psuMuedBQsHDlMui+K
        hHb7KMgHUwqBRwkQsmqtMlGpDVaHqFhdoFau1KapEgO3pSjNYOJjUukDYC1xBtYBjAJ1AFK4
        xFewfjlivQUJ8r37WE3KZk2agtXWAT+KkEwTjAzkJnjTifJUNpll1azmfxWjPKenY1uW1KOu
        MV/I36WjIsKSO3Qd4mvPi6PXC3pNcZumJr1nK0VZBcKafN7c8GPCMP+Dmw4F+y4+PklUmieM
        U3LhWxujf4/VstxqIP4ab4hIiwJzZAs9BmWcjOwevSsrWsNd1Secla2K407ELi7XOJfZuS6B
        T2/u/hkef4yYdV0sXanOc8RH9GlDrJnSNU8W6YjTK3wi00debW9qLmiC0uLxSQFBBqy65ndo
        jOrlNUu0xuFvmfvueGtIc34Va7z7U9/WliWchYtaiw8sfQQM/hu6jww0ZKSK/H68Gk8aS372
        66Kt/3XY241+seninZbUWU8F6I5z3oGYCEeDjhHOkBDaJHmwFNdo5X8BZ1R+YCADAAA=
X-CMS-MailID: 20231025102257epcas5p4bf00a54078bf640dfb2e2e03e671453c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025102257epcas5p4bf00a54078bf640dfb2e2e03e671453c
References: <20231025102216.50480-1-aakarsh.jain@samsung.com>
        <CGME20231025102257epcas5p4bf00a54078bf640dfb2e2e03e671453c@epcas5p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Context bit is set for hardware execution if there is a buffer in
source and destination queue before calling try_run in the
init_buffers function. Now there will be a new context created and
hardware will be invoked for the buffer queued instead of waiting for
another buffer to be queued from userspace to set this context bit for
hw execution.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smithatmurthy@gmail.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index bd055dea827e..fbb047eadf5a 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -604,6 +604,8 @@ static void s5p_mfc_handle_init_buffers(struct s5p_mfc_ctx *ctx,
 		s5p_mfc_clock_off();
 
 		wake_up(&ctx->queue);
+		if (ctx->src_queue_cnt >= 1 && ctx->dst_queue_cnt >= 1)
+			set_work_bit_irqsave(ctx);
 		s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
 	} else {
 		WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
-- 
2.17.1

