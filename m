Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB9D806761
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376797AbjLFGgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376749AbjLFGf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:35:59 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10901BD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 22:35:59 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231206063555epoutp04606d752970fac4215a4d43e8750fceb1~eKpsn1eEZ0550205502epoutp04F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:35:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231206063555epoutp04606d752970fac4215a4d43e8750fceb1~eKpsn1eEZ0550205502epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701844555;
        bh=eOtPRlkv0GpFVsKpaPi+IxIe9vCjHYKTWVJ1SPsLF98=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tw13r61rgtZErPRNssUXCcb7eBmIPq53qnFdtPR29S0Hr68rR/oZ40iuh5ovy0Exv
         yTG5Q4oi1PkVHlvSewDQ6t+A1govz/6AsvUF2KgK6LDxLHClXzMy3d0oOWavRclKxV
         avlx9sPbZrTMKbs0783kdSmStRBGjrleaHCWU7Z0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20231206063554epcas5p2f96c5c1476ef3e5d3fbeebd8b1433b29~eKpr1xLRb2808128081epcas5p2G;
        Wed,  6 Dec 2023 06:35:54 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SlSMr6vcfz4x9QC; Wed,  6 Dec
        2023 06:35:52 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.56.09634.84610756; Wed,  6 Dec 2023 15:35:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20231206063105epcas5p3034f89af2be6922ab04771de099a124a~eKlfV2vOw1077710777epcas5p3L;
        Wed,  6 Dec 2023 06:31:05 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231206063105epsmtrp2d3d99defbc4fd8f734532fa1e4682e41~eKlfUgH_01483414834epsmtrp22;
        Wed,  6 Dec 2023 06:31:05 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-0d-657016486f85
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.96.07368.92510756; Wed,  6 Dec 2023 15:31:05 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231206063103epsmtip21e1f680b29e1b75c4a90176398c73196~eKlczsc1t3080830808epsmtip2e;
        Wed,  6 Dec 2023 06:31:03 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
        andi@etezian.org, gost.dev@samsung.com, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        ajaykumar.rs@samsung.com, aakarsh.jain@samsung.com
Subject: [Patch v5 00/11] Add MFC V12 support
Date:   Wed,  6 Dec 2023 12:00:34 +0530
Message-Id: <20231206063045.97234-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSbUxbZRTee297ewHLroD6rqGOXDc7SApUSrkodd9LDVtCUpMtS5DdtDct
        0i/7MVfNsi6jycSxbAY3QbqxwYZSoNgCFigEOzLiInQ6AiKgIFuEMTq26sRIxH6h/57znOe8
        5znnPTia4sB4eLnOzBh1tIbEElndtzKzhLIXDUzuPz4J9cBby6YGH3/DomavdGNU4+pvCPVL
        Y4hF+T1dHKq1fxShrg6NsqnJwR6E+r52hkWdX5hDKff8OJu611uPUec6utjUZ4EBhGobmuFQ
        N91rCHW963cOZe8f4uxKlU00PUVljb5FROZu+QiTTY/7MJmn6ZTsfGcLkIXcL8vu/BHilOBH
        K4rUDK1kjBmMTqFXlutUUrJYXra3LF+SKxKKCqkCMkNHaxkpue9gifBAuSY8EJlxnNZYwlQJ
        bTKROW8WGfUWM5Oh1pvMUpIxKDUGsSHbRGtNFp0qW8eYXxfl5r6WHxYeq1A3rNehBt/WE07n
        E2ADXbwqkIBDQgyDj0bQKpCIpxB9ADavtyGx4CmA6+02LBY8A3B1pg/dKBlxdcZV/QC2D52J
        JlIIOwJP9wmrAI5jhBCOfK2J0GnEaQDnz5ojepSwo7CyJggiidSwJvDTXBSziO3QEWiMvsMl
        pDDY6QKxZluhs2Mw6g8SDhzah+1xF/ug60YDK4ZT4cPhTk4M82Ao2I/FsALOX1+M6zXQ5auJ
        63fCwbF6VsQoSmRCV29OjObDT++0IxGMEsmw+u/7SIznQu+VDfwqrJ9eZcdwOrzlvBH3KYN3
        n3hAbA+lsDHkAxcAv+7/Dg0AtIAtjMGkVTGmfINIx7z/30cp9Fo3iN5p1lteMDO7ku0HCA78
        AOIomcbVBPRMCldJWz9gjPoyo0XDmPwgP7yziyjvBYU+fOg6c5lIXJgrlkgk4sI8iYh8ibtk
        dyhTCBVtZioYxsAYN+oQPIFnQwQGbrrg3R83O/2XOw7bJpZrEscFhqMZzVt+vXBsUl57qPpa
        UmsofTda1LMwYHH/fO2HrKRJxRutD4fG0uQHLr7j3rT9ske5bbOaRu5/PiDl3z55CevYJQiM
        tfctPn9qYq9i9+Mdz8m3dR6+e0RRryzfmdeW7SD/CjxAp9aSL42U35bbVaxn77VZ1858W6BF
        J1yCnEMF4rqpD0P7VX9yk+Y8luXRcyuKvGWnpzJ5CW2vLsm0Nn2VxD25HLw6vcDGjs9+vMfK
        T+juduXxezaxraWlJ3qP3FuaxuWOL4NK+qxt5TuiZdK7h/xiSvFK1tvF+4d1xYHKT5xqr3SH
        iv2ouamOZJnUtCgLNZrofwHx/52DMAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvK6maEGqwdpr+hZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYv6Rc6wWNw/sZLK4OPMui0Xfi4fMFpseX2O1
        uLxrDptFz4atrBYzzu9jslh75C67xbJNf5gsFm39wm7RuvcIu4Owx/Uln5g9Fu95yeSxaVUn
        m8eda3vYPDYvqffo27KK0ePzJjmPU18/swdwRHHZpKTmZJalFunbJXBlLPg/i7lgj3zF6tUf
        GRsYt0p1MXJySAiYSJxdv4Wpi5GLQ0hgN6PEuZaJLBAJGYn/bcfYIWxhiZX/nrNDFDUzSRz6
        +Aqog4ODTUBX4uz2HJC4iEAro8T1lZ1gk5gFpjNLfH3ZCzZJGKjo/K2HjCA2i4CqxNzzi5lB
        bF4BW4l3W9YzQmyQl1i94QDzBEaeBYwMqxglUwuKc9Nzkw0LDPNSy/WKE3OLS/PS9ZLzczcx
        goNbS2MH4735//QOMTJxMB5ilOBgVhLhzTmfnyrEm5JYWZValB9fVJqTWnyIUZqDRUmc13DG
        7BQhgfTEktTs1NSC1CKYLBMHp1QDk9aN7PT3vnE+EiE3vHsCzu1a98iTe8u12U9nX2LIipL/
        UL7zZsbLS6HV0gzP/xiqS1hpCfsv+DUvvjbag1thvqnew22Xl+RuyUnf+vUkz0/L4py5P+4r
        3F8w84jVn4Wt1omTis48km9wZj3u6ylcm1Qj5vt53tuIVQcXS03do9rKu/9298vzfV5Xljtc
        /n4iepl0996u3RmvlWal6pyexjynOvaxzBPpaZoyJ9+UC+0PlfiQvmKjxAOmeBc5S/N/R5aF
        Pn3zbTXT5e+8Ez55GM852XhEKNNE/5iGbKrEz2WGcqsyamIyY8zP/HWpPuZcvFlnTbuHmriM
        4otjZTqvC9Z/t+N4zrN2jjATp8zKjUosxRmJhlrMRcWJACy7k+fdAgAA
X-CMS-MailID: 20231206063105epcas5p3034f89af2be6922ab04771de099a124a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206063105epcas5p3034f89af2be6922ab04771de099a124a
References: <CGME20231206063105epcas5p3034f89af2be6922ab04771de099a124a@epcas5p3.samsung.com>
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

This patch series adds MFC v12 support. MFC v12 is used in Tesla FSD SoC.

This adds support for following:

-Add support for YV12 and I420 format (3-plane)
-Add support for Rate Control, UHD and DMABUF for encoder
-Add support for DPB buffers allocation based on MFC requirement

Changes since v4:
-Addressed review comments by Krzysztof Kozlowski.
As per discussion included iommus property in dt-schema.
-Addressed review comments by Hans Verkuil.
Fixed checkpatch warnings with --strict flag enabled.
Upstreamed s5p-mfc-v12.fw to linux-firmware.
Added comment in the patch 9 regarding loading mfc firmware v12 
sequentially.
-Addressed review comments by Nicolas Dufresne
Made use of v4l2-common library to get number of planes needed for
particular format in patch 4.
v4 link:https://patchwork.kernel.org/project/linux-media/patch/20231025102216.50480-2-aakarsh.jain@samsung.com/

Changes since v3:
-Removed vp9 codec support for now and just keeping MFC v12 base
patches with necessary hardware controls, decoder, encoder and
structural changes. Also covers luma dbp, chroma dpb and mv sizes
for each codec as per the UM for MFCv12, along with appropriate
alignment.
v3 link: https://patchwork.kernel.org/project/linux-media/cover/20221011122516.32135-1-aakarsh.jain@samsung.com/

Changes since v2:
-Addressed review comments by Rob Herring.
This was regarding the errors found by Rob bot in yaml file. File
'samsung,s5p-mfc.yaml' is already converted into json schema and is
merged.

-Addressed review comments by Krzysztof Kozlowski.
This was regarding depricated properties mentioned in s5p-mfc.txt file.
Review comment was addressed and 'samsung,s5p-mfc.yaml' is already
merged now.

-Addressed review comments by Andi Shyti.
This was regarding addition of 'MFC_V10PLUS_BITS' macro in
's5p_mfc_common.h file.
v2 link: https://patchwork.kernel.org/project/linux-media/cover/20220907064715.55778-1-smitha.t@samsung.com/

Changes since v1:
-Addressed review comments by Krzysztof Kozlowski.
Separated bug fixes patches, resent again with fix tag
and those are merged now.
-Added SoC based compatible string.

-Addressed review comments by Andrzej Hajda
Assigned width64 and height32 variable with ALIGN(ctx->img_..)
used in the code in 's5p_mfc_opr_v6.c' file.
v1 link: https://patchwork.kernel.org/project/linux-media/patch/20220517125548.14746-2-smitha.t@samsung.com/

Aakarsh Jain (11):
  dt-bindings: media: s5p-mfc: Add mfcv12 variant
  media: s5p-mfc: Rename IS_MFCV10 macro
  media: s5p-mfc: Add initial support for MFCv12
  media: s5p-mfc: Add YV12 and I420 multiplanar format support
  media: s5p-mfc: Add support for rate controls in MFCv12
  media: s5p-mfc: Add support for UHD encoding.
  media: s5p-mfc: Add support for DMABUF for encoder
  media: s5p-mfc: Set context for valid case before calling try_run
  media: s5p-mfc: Load firmware for each run in MFCv12.
  media: s5p-mfc: DPB Count Independent of VIDIOC_REQBUF
  arm64: dts: fsd: Add MFC related DT enteries

 .../bindings/media/samsung,s5p-mfc.yaml       |  18 ++
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  21 ++
 .../platform/samsung/s5p-mfc/regs-mfc-v12.h   |  52 +++
 .../platform/samsung/s5p-mfc/regs-mfc-v7.h    |   1 +
 .../platform/samsung/s5p-mfc/regs-mfc-v8.h    |   3 +
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c  |  36 ++-
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h |  29 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  10 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    |  60 +++-
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    | 149 ++++++---
 .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |  14 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c |  12 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 300 ++++++++++++++----
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |   7 +-
 14 files changed, 563 insertions(+), 149 deletions(-)
 create mode 100644 drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h

-- 
2.17.1

