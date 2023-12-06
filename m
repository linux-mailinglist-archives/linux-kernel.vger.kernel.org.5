Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706D180678F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376812AbjLFGhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376857AbjLFGhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:37:38 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A521994
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 22:37:08 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231206063706epoutp041c8fc71c0e7b97b2789820c201ef9768~eKqvmum0H0550205502epoutp04k
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:37:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231206063706epoutp041c8fc71c0e7b97b2789820c201ef9768~eKqvmum0H0550205502epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701844627;
        bh=kUuKQ/GugZxCJUnbvhRG+iSpQR3fWRlMwpAYp/298R8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/uWl6sfSHpa+NeYZZ38mS/jRb7C4VFoxJ0fz9KTSVNfVg6hVmtQlqwCx6FJndV05
         l1JOP0XP3M2zNacWjsadQYCfv96GjbAiIRHAJHDA1nzSMvofJVK1nMOBRyP2RRWAA4
         9MEQ/o7eExIULi97pfnLq+3w6sroJiJuMmx5EO60=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231206063706epcas5p3251c420bc19b06ea13f333fbcdfed9fb~eKqvICDx40641606416epcas5p3w;
        Wed,  6 Dec 2023 06:37:06 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SlSPC6TgTz4x9QB; Wed,  6 Dec
        2023 06:37:03 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.16.09672.F8610756; Wed,  6 Dec 2023 15:37:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20231206063131epcas5p2e0fc772f8f8ac35897920d24a0193d71~eKl3JRzOb0993309933epcas5p2e;
        Wed,  6 Dec 2023 06:31:31 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231206063131epsmtrp2af512438d4317a9afd67811ba018b885~eKl3ITUw51483514835epsmtrp2Z;
        Wed,  6 Dec 2023 06:31:31 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-98-6570168f959d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.96.07368.34510756; Wed,  6 Dec 2023 15:31:31 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231206063128epsmtip26681e47b6423c2d6319c1d46f9f5e9a1~eKl0UQNOE0503705037epsmtip2g;
        Wed,  6 Dec 2023 06:31:28 +0000 (GMT)
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
Subject: [Patch v5 08/11] media: s5p-mfc: Set context for valid case before
 calling try_run
Date:   Wed,  6 Dec 2023 12:00:42 +0530
Message-Id: <20231206063045.97234-9-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231206063045.97234-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTe0xbVRzeuff23hYtXIHNY9VJrkOBCbQC5bDAAEfINRAldhF1mazAFZDS
        dr3FzUWzFxhkyGuT8BoyQI0UBAplvMsKG5NENhHZiIMV0QAlgwlsI+rUljL97/t9v+/3PkeI
        u/eSEmGGWs/p1EoVQ7oQnUO+fv5FO7ScdHzOB/3WVSFAgyuXCGSt6SRR/cY8hm7XrxHI0m6i
        UFP/GIa+GB4ToKnBbgz9UDFNoMKFWRwZ5yYFaNaWiH7sqSZRQatJgMqvDWCoeXiaQl8Z/8JQ
        nWmdQrn9wxTKOdkgiNrO3mhYxdnuymmKre9bxFhj46cke2uyj2TbG46zhR2NgP371HmKXTPu
        ZEfvrVEJLu9khqdzylRO58WpUzSpGeq0CCZOkbQvKUQulfnLwlAo46VWZnERTEx8gn9shso+
        I+P1gVKVbacSlDzPBO4N12my9ZxXuobXRzCcNlWlDdYG8MosPludFqDm9HtkUunLIXbhocz0
        ptI6XHtVdPTqyh3BCXBWmA+EQkgHw39yPsoHLkJ3uhfA09YNwmmsAlhTfpF0GvcBvHw73+4R
        bUbcLCnbcvQDWDJnoxwOdzoXg9/ZdjnSkrQ//P6iykF70icBnMvTO/Q4PYLD2uIKwqHxoA/C
        jZubOQnaGy79VIQ5sJiOgB3mWYGz1nPQ0DqIO7CI3gvPNdUKHHkgPSGEEzmjpFMUA2vK8ikn
        9oC2kY4tLIFry/1bmhQ4V7eIO7EKtvSd2xomEg5OVG/2g9O+sKUn0Ek/Cz8f/XazH5x2hZ/9
        +Svm5MWwq+YRfgFW39rY6vMZOGT4EjgxC2faZijnfkoAXDdfJ4rBzsr/S9QC0Aie4rR8VhrH
        h2iD1NyR/26Woskygs1X7BfXBX6x3g2wAEwILAAKccZTrLqm4dzFqcoPj3E6TZIuW8XxFhBi
        X2AJLtmeorF/A7U+SRYcJg2Wy+XBYUFyGfOkeCn3fKo7nabUc5kcp+V0j+IwoUhyAhvh80rZ
        uwcNWd2hvUc69lSterzr1jrzMD+wtrPgQtiyeVkcu27etl/T7I27aVuqqqyKHQsvDnmOHi1K
        LGbe6ntcr3YtnfWowpYrXVuiRl/bH7p4XSN6o9fc9eYr0Z/cm4wqPPONm/fb8wUwLlaS6Hsn
        Gf/Zlm28kXzpjws1V/JOD08bHwQt3de2j8eAwwM+kTGXHxLWx9RLT4crWqZgGHJtqyy3Sa2n
        VKXRiz7LUwmvh1u+PvQg/qzRZJIkj79veO9ji6+NVLQd58j1tcjnsQP7BsYqTa/mmKfcFjwk
        PYrusgB5PLZS/oQoJ3rXgQjFpPWl3ceat+2+4hVy2PD7PEUkMQSfrpT54Tpe+S92YXl9TgQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvK6zaEGqQctbEYunO2ayWhx4f5DF
        4sG8bWwWi388Z7K4v/gzi8WhzVvZLdbsPcdkMf/IOVaLmwd2MllcnHmXxaLvxUNmi02Pr7Fa
        PHwVbnF51xw2i54NW1ktZpzfx2Sx9shddotlm/4wWSza+oXdonXvEXaLlsYlrA6iHteXfGL2
        2DnrLrvH4j0vmTw2repk87hzbQ+bx+Yl9R59W1Yxevxrmsvu8XmTnMepr5/ZA7iiuGxSUnMy
        y1KL9O0SuDLWTFrEXHCCs+LE+7esDYyTOboYOTkkBEwkbkycxtbFyMUhJLCbUeLb+9ksEAkZ
        if9tx9ghbGGJlf+es0MUNTNJPDlwFqiIg4NNQFfi7PYckLiIQCujxPWVnUwgDrPAbWaJTRMe
        gnULC0RLXFj5kxnEZhFQlXh9tZ8JxOYVsJXYsv8hK8QGeYnVGw6A1XAK2ElMWbOAFWSBEFDN
        ypOOExj5FjAyrGKUTC0ozk3PTTYsMMxLLdcrTswtLs1L10vOz93ECI4YLY0djPfm/9M7xMjE
        wXiIUYKDWUmEN+d8fqoQb0piZVVqUX58UWlOavEhRmkOFiVxXsMZs1OEBNITS1KzU1MLUotg
        skwcnFINTEdrhb8Zla9/vG+LivvcbCfbpZnuZxyD1jLrxKx4yKAnuPjHIcZ5PpaOtfdyrjka
        CbNffJl3VCBPcuO3W9sKg+9KzuDi85ket85g55R8W85bZ0XStiQ7R73fwbO37YTjBJ+iTxq9
        r1ebK+t8fin672zY+qgbm7JnJEk/ufvt4N0Q7Qknufn3Pf51ct2td7Lxh6Is9Pddz+BbFrIz
        g/fKhV8PhaNfV8zv6mXQWHZhxhRL8aLk7rWd7KZnt+/YvjDiRdWu2PcMK88qsPMkSvD5Z5l6
        SJhZ7t+6fLZ/yqaXV2vyeKYb3Ajw33aQ1etXbuFdD8UG1uUF14Mm8Bvlaqxs0ay2c11dZyMn
        PEu4689RZiWW4oxEQy3mouJEANL5cmYHAwAA
X-CMS-MailID: 20231206063131epcas5p2e0fc772f8f8ac35897920d24a0193d71
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206063131epcas5p2e0fc772f8f8ac35897920d24a0193d71
References: <20231206063045.97234-1-aakarsh.jain@samsung.com>
        <CGME20231206063131epcas5p2e0fc772f8f8ac35897920d24a0193d71@epcas5p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

