Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20594810F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378336AbjLMLBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378325AbjLMLBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:01:50 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C351EB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:01:55 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231213110153epoutp0165c5a77b88d200f70c578288850c1268~gXy7LpUge1398613986epoutp01w
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:01:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231213110153epoutp0165c5a77b88d200f70c578288850c1268~gXy7LpUge1398613986epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702465313;
        bh=kUuKQ/GugZxCJUnbvhRG+iSpQR3fWRlMwpAYp/298R8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FiwTrArCsrLOTQHzmJtePve++wzQeLPNgwWKxfsFbfhcrIFkoxA27J9LU/U36Y5Jy
         4kF97/vmxm1cph3Yn9VTkoa4zwPqFxFzDhZPZWcdUsS/06Ys1soWRbh8L1fj78qJVZ
         PZjqLAf4uR5l6HUuWlEfwoI2k4FLOEV4GrA7mGqQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231213110153epcas5p301df61e33c3c0db7fa9cd28325c57342~gXy6l8XSe0879108791epcas5p38;
        Wed, 13 Dec 2023 11:01:53 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SqsxV14mGz4x9Q1; Wed, 13 Dec
        2023 11:01:50 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.40.19369.D1F89756; Wed, 13 Dec 2023 20:01:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20231213081140epcas5p2bf0e2edea2d24224d775b348b1d5ca50~gVeTgz4fW1902319023epcas5p2c;
        Wed, 13 Dec 2023 08:11:40 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231213081140epsmtrp24b96d6c14f801dfb74005a5bf747588e~gVeTfugeq2150821508epsmtrp2f;
        Wed, 13 Dec 2023 08:11:40 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-61-65798f1da40f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.96.18939.C3769756; Wed, 13 Dec 2023 17:11:40 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231213081137epsmtip2470d0607b940186ae57a923ef5884fb8~gVeQtmtcD1293312933epsmtip2d;
        Wed, 13 Dec 2023 08:11:37 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
        andi@etezian.org, gost.dev@samsung.com, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        ajaykumar.rs@samsung.com, aakarsh.jain@samsung.com,
        linux-fsd@tesla.com, Smitha T Murthy <smithatmurthy@gmail.com>
Subject: [Patch v6 08/10] media: s5p-mfc: Set context for valid case before
 calling try_run
Date:   Wed, 13 Dec 2023 13:41:03 +0530
Message-Id: <20231213081105.25817-9-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213081105.25817-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xTVxTH895r+16JNS9V4l03WPeMbrAUKZRymRa2qeQlc4TFbEtcFLv2
        jSKlrW0RxGWCk03IwB/gRrG0jB9b+N1VYEXLYG0N/prTyJibJdDhkB8CTrYJMtkoT9x/n3Pv
        95zzvefeS2DCbp6IyNCZGaNOqaV4IZxOb8RLkrDjB5noe9Wb4e8uCxf2znzPgcO2Th6snbuL
        wqHaWQ70nO3AYXP3NRTafde48JfeLhTesAxyYOlYAIPOkQEuDEy8C2+es/LgZ44OLqz48TsU
        tvgGcfiV8x8U1nT8icPCbh8OjxbUcV8NpX+ue4DRXZWDOF3rHkdpZ2MRj/YPuHn02brDdGl7
        I0IvHqnC6VlnOH35r1k8NWRX5hYNo1QzRjGjU+nVGbp0BfXGzrStaXHyaKlEmgDjKbFOmcUo
        qG07UiXJGdqlM1LiA0pt9tJSqtJkojYlbjHqs82MWKM3mRUUY1BrDTJDlEmZZcrWpUfpGPMr
        0ujomLgl4d5MTfOpGsxwkZ97cWaKm4+UEcUInwCkDFzv7+cUIyGEkHQj4Ov7NowNHiCgZKoB
        eRpcuWXnraRYb/qWWUh2IaA0sI8VFaJgYNGBFyMEwSMl4IdvtUHNWrIAASPHzEENRvZhoPqE
        hRPcWEPuBgtF3uVCHHIDKB/vRIMsIBXAl38PZZs9D5ocvViQ+WQimD7Ss+wIkFcJULtYgQWb
        AXIbGPsmmdWvARN97TjLIjA73f3EtAqM1IxjLGtBm7ucw3IS6O23coJlMDICtJ3bxC6HgdOX
        W5ctYORqULJw54kdAXDZVngjsPrnuCw/B7xN9QjLNPC2nueyMzmJgBnfHHYCCa/8v0U1gjQi
        IsZgykpnVHEGqUTH5Dy9NZU+y4ksv+PIVBfS5Hgc5UFQAvEggMCotYJLrhxGKFArD+YxRn2a
        MVvLmDxI3NIAT2KiUJV+6SPozGlSWUK0TC6XyxJi5VJqnWCysEotJNOVZiaTYQyMcSUPJfii
        fNQx52vAk7oKYkaYXcXutz6aupr7a4nldrL38+zTd6xv7glcOP6eazFl93w9jM3c4V//Yopk
        mn9qu1A1ecE53HDA4llXIG2PeSRvxRNt+4vzyl4wvKOSzR/68NaVqb1/hLkf3ehxRHxpu6R6
        eHh0YwUfHk1YeNkj83nmW+zbv/ipqo6pD98zNBr7elq5JZ78AEtxafxJov7ptxv/LRKdCbSU
        tz0z1OOltPcnbt8Vf/KxWFN2bL09KWZMHRir+hu074s/r9BHNpc57NJVkw2B9/Me+mMH/ZMJ
        gp2NA+nXh3NWS0N5lc/On2kqyt3aZ43frxg9lBhYtbnp8W+lmk8NhF35WhzFMWmU0kjMaFL+
        B9OTugRQBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvK5NemWqwaHPshZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYv6Rc6wWNw/sZLK4OPMui0Xfi4fMFpseX2O1
        ePgq3OLyrjlsFj0btrJazDi/j8li7ZG77BbLNv1hsli09Qu7ReveI+wWLY1LWB1EPa4v+cTs
        sXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j36tqxi9PjXNJfd4/MmOY9TXz+zB3BFcdmkpOZk
        lqUW6dslcGWsmbSIueAEZ8WJ929ZGxgnc3QxcnJICJhIzLl8hK2LkYtDSGA7o0Tv3FuMEAkZ
        if9tx9ghbGGJlf+es0MUNTNJPHq/BqiIg4NNQFfi7PYckLiIQCujxPWVnUwgDrPAbWaJTRMe
        gnULC0RLzJxwkgnEZhFQlZjychuYzStgK3Gk4Q0TxAZ5idUbDjCD2JwCdhLvmvaDXSEEVLN8
        923mCYx8CxgZVjGKphYU56bnJhcY6hUn5haX5qXrJefnbmIEx4pW0A7GZev/6h1iZOJgPMQo
        wcGsJMJ7ckd5qhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe5ZzOFCGB9MSS1OzU1ILUIpgsEwen
        VAOT9JcPaov6TqRkXp+0YElQbGN22v0nZcYfP65hSvdwP/H4UAHbY7Hsqst+t7QPeMpOeT+P
        z/a1kp+xxvx8r5nFTx364q7a1fv/3iomqBxTfVibr6viZfWul72+9wKmdl4QNH6rv5nrqeb/
        yWme/FMMfq9i2/XfaKGLwrTo78Lr2ItlNwe8O+ygtiLtyMFqU2/nQu9DuZ5xk+6sC7dtETn5
        TDHmD6PqvfoVc2JZlTNYG3MYpkaFci+v4eip627LlPvrk5cs0aX1UfSfXfHNTfKiWXs2pv6b
        fHHnGbn0Jx+Top3qjzNvK/thZH73VYJTyg1hJoZrhiZzhLIbRWfqzf19hUGK77cLD2tt9brJ
        OkosxRmJhlrMRcWJAOnczgQEAwAA
X-CMS-MailID: 20231213081140epcas5p2bf0e2edea2d24224d775b348b1d5ca50
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213081140epcas5p2bf0e2edea2d24224d775b348b1d5ca50
References: <20231213081105.25817-1-aakarsh.jain@samsung.com>
        <CGME20231213081140epcas5p2bf0e2edea2d24224d775b348b1d5ca50@epcas5p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

