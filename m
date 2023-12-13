Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B93810F06
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbjLMK53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbjLMK52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:57:28 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C2CBD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:57:32 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231213105730epoutp01804f6d6e004df89a5d89ed90d4bea6e5~gXvF0vDyu0621606216epoutp01b
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:57:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231213105730epoutp01804f6d6e004df89a5d89ed90d4bea6e5~gXvF0vDyu0621606216epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702465050;
        bh=BqiRaJ0NsfpiJ2sM4INLMQsVpV+uA7WmGveruRmpB48=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VdIeJ0VoIlR/Nwd87Iw1QUx+QDQBv0Na4IrUbBhhVGHwj2rBgv+lDDry2D3MrdYlb
         hVRadufiBJniQxgenIebafDoM6dSxoSBoqYAuyilIWb0k91kR2/JqYrsVcjirR+Fka
         HoCXRp+/HWmdHn4q87lmDxUvE+Y1EC72Ks0EL6Ao=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231213105729epcas5p145680c4dc6bb8eaefbff59b6f32158c0~gXvFQlk-B2144021440epcas5p12;
        Wed, 13 Dec 2023 10:57:29 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SqsrS2cY1z4x9Pq; Wed, 13 Dec
        2023 10:57:28 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.C4.10009.81E89756; Wed, 13 Dec 2023 19:57:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231213081112epcas5p171f1b69376bc4b1e8ced03f8b56efe35~gVd491gOh0249502495epcas5p1r;
        Wed, 13 Dec 2023 08:11:12 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231213081112epsmtrp10d31838d8f8b9870c9df96bf65b25882~gVd48784f2318723187epsmtrp1n;
        Wed, 13 Dec 2023 08:11:12 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-6d-65798e182176
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.E2.08817.F1769756; Wed, 13 Dec 2023 17:11:12 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231213081109epsmtip2f885480c8110cbba87fd0625514a47c8~gVd2a24WA1539415394epsmtip2i;
        Wed, 13 Dec 2023 08:11:09 +0000 (GMT)
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
Subject: [Patch v6 00/10] Add MFC v12 support
Date:   Wed, 13 Dec 2023 13:40:55 +0530
Message-Id: <20231213081105.25817-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmpq5EX2WqwaHFAhZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYv6Rc6wWNw/sZLK4OPMui0Xfi4fMFpseX2O1
        uLxrDptFz4atrBYzzu9jslh75C67xbJNf5gsFm39wm7RuvcIu4Owx/Uln5g9Fu95yeSxaVUn
        m8eda3vYPDYvqffo27KK0ePzJjmPU18/swdwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5ua
        GRjqGlpamCsp5CXmptoqufgE6Lpl5gA9pKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUot
        SMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzjjZNJe54IByReP6/YwNjJ1yXYycHBICJhKf
        Zl1g62Lk4hAS2M0o0XVmCxOE84lR4tzOvYwQzjdGidPNG1lgWnq3PYJK7GWU2DnjJ1R/K5PE
        tbmbmbsYOTjYBHQlzm7PAWkQEWhklHjcUQJSwyzQyizRMuUdI0hCGKjm493tYDaLgKrEjJtN
        bCA2r4CtxO8JZ1khtslLrN5wgBmkWUJgIYfEqTmnoBIuEh+3HGGGsIUlXh3fwg5hS0m87G+D
        spMlHi96CVWTI7F+zxSoF+wlDlyZwwJyKLOApsT6XfoQYVmJqafWMYHYzAJ8Er2/nzBBxHkl
        dsyDsdUk5tz5AXWCjMTh1UsZQcZICHhI3NqdDGIKCcRKrN9mOYFRdhbC/AWMjKsYJVMLinPT
        U4tNC4zyUsvh8ZScn7uJEZxMtbx2MD588EHvECMTB+MhRgkOZiUR3pM7ylOFeFMSK6tSi/Lj
        i0pzUosPMZoCQ2wis5Rocj4wneeVxBuaWBqYmJmZmVgamxkqifO+bp2bIiSQnliSmp2aWpBa
        BNPHxMEp1cDkscv0mmTTrWeCzNnyTb9qWmStTk5LP5hy0+xYeIbly3kiL56JXYiueV6d0uE3
        8ffJOjH7BskVLI9je1qPXj7cskGpdCO7XIb6rv512VMlr5jtL26x9em2CfkgsP/ZPNF9qmci
        NOUfL/LWnfSb9Y7d8wPPpudvTCvoLGf+wexwqmX38cUbQm8K939fxnxPpmLzT9fVWWnp/422
        Oj3aN1lcWFZ3xrVylbN7Du2yTm7JmpX48KvPXpNMlgPnlnOsF3h3hKHt4ir7t0kvCmrO/3u8
        7WR0xu5L8T4FhmWPd7Y/060tXK4tvetslTDHG8VjFldvsJ2M485SOGmxu/eKzbTgw41Lo3IO
        lHTu4P5ve/+9EktxRqKhFnNRcSIAmSFQGi8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvK5CemWqwZ8HjBZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYv6Rc6wWNw/sZLK4OPMui0Xfi4fMFpseX2O1
        uLxrDptFz4atrBYzzu9jslh75C67xbJNf5gsFm39wm7RuvcIu4Owx/Uln5g9Fu95yeSxaVUn
        m8eda3vYPDYvqffo27KK0ePzJjmPU18/swdwRHHZpKTmZJalFunbJXBlnGyay1xwQLmicf1+
        xgbGTrkuRk4OCQETid5tjxi7GLk4hAR2M0rs/36VFSIhI/G/7Rg7hC0ssfLfc3aIomYmiRVf
        9wJ1cHCwCehKnN2eAxIXEWhllLi+spMJxGEWmM4s8fVlLwtItzBQ0ce72xlBbBYBVYkZN5vY
        QGxeAVuJ3xPOQm2Tl1i94QDzBEaeBYwMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcx
        goNbS2sH455VH/QOMTJxMB5ilOBgVhLhPbmjPFWINyWxsiq1KD++qDQntfgQozQHi5I477fX
        vSlCAumJJanZqakFqUUwWSYOTqkGpqU/O+acnhylfeviXWaHdI690brx0qu8J8ws/Wpp8plh
        5cp3bbWHLzO2J63Y2bSZSW+W44qVJXeEKsWOzg//etfzo9uKRylymtyX8r/+Y1n1edaWpkO/
        L61bbTazsnFSksQdtW2Pd1zeKfrU77pok3tjh26KhYNm5PYzF9e/6ffgUF8dvyX4NXfjCobK
        q3cPxQT9OL/qcP3hzqU3J3Da3F3uEHpwv8tWkT21R289nWZr+pM9tTT/BH9f/PrM/1OOOopb
        +yYsdZld+vRdz+/Sa/WVFlcvz7Vcu/jg+YRPAT4+b/cuPLfioOVP9RkpvJ0bPDfVHlcpcFl9
        anF/VXCUzOYQw1iBJcHWVQ28Foui/lxXYinOSDTUYi4qTgQAzAA1P90CAAA=
X-CMS-MailID: 20231213081112epcas5p171f1b69376bc4b1e8ced03f8b56efe35
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213081112epcas5p171f1b69376bc4b1e8ced03f8b56efe35
References: <CGME20231213081112epcas5p171f1b69376bc4b1e8ced03f8b56efe35@epcas5p1.samsung.com>
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

changes since v5:
-As per Krzysztof, he will take MFC dt-entries patch via Samsung SoC
once dt-bindings patch gets accepted. Therefore, excluded MFC dt-entries
patch from v6.
-Addressed review comments by Hans Verkuil.
Resolved smatch warning from 'drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c'.
Resolved kernel doc warnings from 'drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h'.
Added explanation in the patch 9 as comment on why mfc v12 firmware loading is
needed for each run.
v5 link: https://patchwork.kernel.org/project/linux-media/cover/20231206063045.97234-1-aakarsh.jain@samsung.com/

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

Aakarsh Jain (10):
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

 .../bindings/media/samsung,s5p-mfc.yaml       |  18 ++
 .../platform/samsung/s5p-mfc/regs-mfc-v12.h   |  52 +++
 .../platform/samsung/s5p-mfc/regs-mfc-v7.h    |   1 +
 .../platform/samsung/s5p-mfc/regs-mfc-v8.h    |   3 +
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c  |  36 ++-
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h |  33 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  15 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    |  60 +++-
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    | 149 ++++++---
 .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |  14 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c |  12 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 299 ++++++++++++++----
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |   7 +-
 13 files changed, 550 insertions(+), 149 deletions(-)
 create mode 100644 drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h

-- 
2.17.1

