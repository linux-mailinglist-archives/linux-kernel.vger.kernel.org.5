Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6838D810BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378751AbjLMIHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378737AbjLMIHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:07:13 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AEAEB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:07:14 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231213080710epoutp01b5eca15dc1dc1d2f21b61b6f40c1ad6f~gVaXoJlj81956219562epoutp01Z
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:07:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231213080710epoutp01b5eca15dc1dc1d2f21b61b6f40c1ad6f~gVaXoJlj81956219562epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702454830;
        bh=AfAJaSfQnEOXWcUP4kLMVd1XUT4Tt8OQIoNwHuvmudU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ox1EE1juQcPoZQZBQ1+Z7GJiGdCqmK9ofTswmRVsqySi7h2wp+nvhkb290Oe4l6/U
         5xNAWkIZZvOWGN/GV14PIYnYBJuiLD5U6Cf3y2366zd//m0l0ZdeZqsBuLT2kRzX4Y
         nkLGAqyQCB9JslvEVMCd+Y4ufjCMwMkOhz507bkQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231213080709epcas5p396e461d45554d24f489a515cb96e7135~gVaW83GRi1050110501epcas5p3x;
        Wed, 13 Dec 2023 08:07:09 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Sqp3w0c6Vz4x9Q1; Wed, 13 Dec
        2023 08:07:08 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.47.10009.B2669756; Wed, 13 Dec 2023 17:07:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231213075816epcas5p4c35196cf7fc191a4c1d25d4c8408efeb~gVSmvt0-C1712417124epcas5p4D;
        Wed, 13 Dec 2023 07:58:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231213075816epsmtrp2747f61231760972d6642a88be99be978~gVSmubvdO1376113761epsmtrp2O;
        Wed, 13 Dec 2023 07:58:16 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-35-6579662beee4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.5A.08755.81469756; Wed, 13 Dec 2023 16:58:16 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231213075812epsmtip23b19dc074e0248789afcff897f5a1c44~gVSjD5Vs40794807948epsmtip2-;
        Wed, 13 Dec 2023 07:58:12 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Hans Verkuil'" <hverkuil-cisco@xs4all.nl>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <andi@etezian.org>,
        <gost.dev@samsung.com>, <alim.akhtar@samsung.com>,
        <aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>,
        <ajaykumar.rs@samsung.com>
In-Reply-To: <d00fa740-bcf8-47af-b70a-cabbb7237d99@xs4all.nl>
Subject: RE: [Patch v5 00/11] Add MFC V12 support
Date:   Wed, 13 Dec 2023 13:28:11 +0530
Message-ID: <108d01da2d9a$20eda670$62c8f350$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJl1+V1XR3+CIvjnElNbj3OPe0yngGxC9E1Absheu2vdCK6EA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1DTZRzHfb7f/fjOmvdtrnycFbtv+YN1/Bht+EBglJ7sKGzZnXbWRYs9
        Do79ahsK/mEcHGQTEUs4WIAgaB2aCMpYBEJjC8ULUxAOj19LOkRjcCAcZHfF+GLx3+v9eT4/
        7v15nociRSM8CZVqtGGLUaNneGs5zo7g4JDXDmbi8M6iGNQ+9TMHjVY4eah6YZxAI9WzHOS+
        0shHF1u7CXTG081FA+0/Euh26RAHFTzwkajhfh8X9TSX8VD+5UYuKrl1jUA/eIb46HzD3wQ6
        2/iYj3JbPfw4kaq/ZoZUVbdMEKqG2q94qsG+Fp7qSs0XqoKrtUA12/Cyqmtulq+mDqTFpGCN
        Fluk2Jhs0qYadbHMOx8k7UxSRobLQ+RRaDsjNWoMOJbZ9a46ZHeqfskLIz2k0acvhdQaq5UJ
        2xFjMaXbsDTFZLXFMtis1ZsV5lCrxmBNN+pCjdgWLQ8Pj1AuJX6alvL45AXC3BmWcWpgRxYo
        22oHAgrSCujK9gI7WEuJ6J8AtI/3kayYAfBWXi+fFfMA+tvuceyAWi7Js+vZeCuAub0zPFaM
        A9h6JyAEFI8OgyNd+dzAgZh2AVjl+5UICJKeJGDVxRFeoJWAjoW+LF2gYD0th67BO0SAOfRm
        2JPt4wZYSEfBr+89IVh+Dt4oHeMEmKSDYNNkGcmakMLFP85zAy3F9Nuwc0rGpmyA3sX8ZTuQ
        zhHAwuFzHDZ/F+xvGyFYXg8fdl7lsyyBs/5WHsvJ8P7ZiZX+eljXcnql9k3Y3lu2vAmSDoZ1
        zWFs+CVY1HWJYOeugyeejK20F0JXxVPeAssGF7gsvwg7LpwDhYBxrHLmWOXMscqC4/9plYBT
        CzZis9Wgw1alOcKID/9338kmQwNYfumyBBfwjU6HugFBATeAFMmIhTdch7FIqNVkHsEWU5Il
        XY+tbqBcWvcpUvJ8smnpqxhtSXJFVLgiMjJSEfV6pJzZIHyUW64V0TqNDadhbMaWp3UEJZBk
        EQ7GKxwr9Rum7TCTq+8VTGt10qY38Csl264x60YTj048AMcWEz93qJHE4c1LfPb74A7L/u6b
        sjZFqqGKKPdMGRJux43ZfLK7a+566o4XtNi/o3rii7fs/aw42un0Nx+o3/9LvB8zA3+Wx1UU
        N3up+orZYqc7/cyk7iGKL8modDz6vXOb1tX0vij60lxaf9umb7cPDyS81dWVfTBmn+qTnTBx
        fit3z0dBkirbC6P2tjiXeqz2WOPpOcWX+7RFQczG487KuoUTvf3XnwltL6w8+tfHOX0y8ZGh
        HPGafzYlHvptd4e3Xnl5r/o9reWbxf7hmsoPo21Bm+ev06/elOyJyNAzHGuKRi4jLVbNv1Ak
        rkpyBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7bCSvK5ESmWqwa05MhYH3h9ksXgwbxub
        xeIfz5ks7i/+zGJxaPNWdos1e88xWcw/co7V4uaBnUwWF2feZbHoe/GQ2WLT42usFpd3zWGz
        6NmwldVixvl9TBZrj9xlt1i26Q+TxaKtX9gtWvceYXcQ8ri+5BOzx+I9L5k8Nq3qZPO4c20P
        m8fmJfUefVtWMXp83iTncerrZ/YAjigum5TUnMyy1CJ9uwSujC/9q5kKjutXTLxp18A4R72L
        kYNDQsBEoq0rp4uRi0NIYDejxP7DR5i7GDmB4jIS/9uOsUPYwhIr/z1nhyh6yijx4f1nsCI2
        AX2J+6d6WEESIgJ7GCWO7l4DVsUs8JNJYvOV5SwQLQcYJQ62vGMD2ccpYCvxsCEdpFtYwFBi
        x51LTCA2i4CqxOWmh6wgNq+ApcSkW7+ZIGxBiZMzn7CA2MwC2hK9D1sZIWx5ie1v50CdqiDx
        8+kyVpDxIgJOEsffa0GUiEsc/dnDPIFReBaSSbOQTJqFZNIsJC0LGFlWMUqmFhTnpucWGxYY
        5qWW6xUn5haX5qXrJefnbmIEx7WW5g7G7as+6B1iZOJgPMQowcGsJMJ7ckd5qhBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXFe8Re9KUIC6YklqdmpqQWpRTBZJg5OqQamxgdv/8x9Ny/5Uk+3zxXL
        BBOBFfmVEXnsiW4hzY17Pv/Mbvh38wN7Xsunz8Xbm7sfnP79ZckixY39GROOpfQ8zYiSV9oy
        e25dd98BFSu15/GthWH5HNu25YrOkfn7LOCgYPSSxSLf7q5bYXvFqEHu+v91/K3RpqoTo+cF
        3/LNWPHjyKvvUxkmv1j62C606k7vv7K8BcrPjb7XbnnPJuI6U/tquk8SwxSz6d8kbx66tUqJ
        u4Pj32PxB+YfGI/Kry7T+FCSuPRWQNCZabvTuRLS/FKbnzh5p3lp3/hm4HBc/vSH8skOotbO
        9k+f/+vQnTbd/gjfjs8TzXvTOyuSxY86Oufsck8ukXtUqvOpI8dEiaU4I9FQi7moOBEA87/T
        Q1oDAAA=
X-CMS-MailID: 20231213075816epcas5p4c35196cf7fc191a4c1d25d4c8408efeb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206063105epcas5p3034f89af2be6922ab04771de099a124a
References: <CGME20231206063105epcas5p3034f89af2be6922ab04771de099a124a@epcas5p3.samsung.com>
        <20231206063045.97234-1-aakarsh.jain@samsung.com>
        <d00fa740-bcf8-47af-b70a-cabbb7237d99@xs4all.nl>
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



> -----Original Message-----
> From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Sent: 06 December 2023 18:29
> To: Aakarsh Jain <aakarsh.jain@samsung.com>; linux-arm-
> kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
> mchehab@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> robh+dt@kernel.org; conor+dt@kernel.org; linux-samsung-
> soc@vger.kernel.org; andi@etezian.org; gost.dev@samsung.com;
> alim.akhtar@samsung.com; aswani.reddy@samsung.com;
> pankaj.dubey@samsung.com; ajaykumar.rs@samsung.com
> Subject: Re: [Patch v5 00/11] Add MFC V12 support
> 
> On 06/12/2023 07:30, Aakarsh Jain wrote:
> > This patch series adds MFC v12 support. MFC v12 is used in Tesla FSD SoC.
> >
> > This adds support for following:
> >
> > -Add support for YV12 and I420 format (3-plane) -Add support for Rate
> > Control, UHD and DMABUF for encoder -Add support for DPB buffers
> > allocation based on MFC requirement
> 
> I'm getting one smatch warning:
> 
> drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c:2453
> s5p_mfc_queue_setup() error: we previously assumed 'ctx->src_fmt' could
> be null (see line 2441)
> 
> And a few kerneldoc warnings:
> 
> drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h:729:
> warning: Function parameter or member 'chroma_size_1' not described in
> 's5p_mfc_ctx'
> drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h:729:
> warning: Function parameter or member 'is_10bit' not described in
> 's5p_mfc_ctx'
> drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h:729:
> warning: Function parameter or member 'is_422' not described in
> 's5p_mfc_ctx'
> drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h:729:
> warning: Function parameter or member 'stride' not described in
> 's5p_mfc_ctx'
> 
> Something for v6.
> 

Sure. Will fix in v6.

Thanks for review!

> Regards,
> 
> 	Hans
> 
> >
> > Changes since v4:
> > -Addressed review comments by Krzysztof Kozlowski.
> > As per discussion included iommus property in dt-schema.
> > -Addressed review comments by Hans Verkuil.
> > Fixed checkpatch warnings with --strict flag enabled.
> > Upstreamed s5p-mfc-v12.fw to linux-firmware.
> > Added comment in the patch 9 regarding loading mfc firmware v12
> > sequentially.
> > -Addressed review comments by Nicolas Dufresne Made use of v4l2-
> common
> > library to get number of planes needed for particular format in patch
> > 4.
> > v4
> > link:https://patchwork.kernel.org/project/linux-media/patch/2023102510
> > 2216.50480-2-aakarsh.jain@samsung.com/
> >
> > Changes since v3:
> > -Removed vp9 codec support for now and just keeping MFC v12 base
> > patches with necessary hardware controls, decoder, encoder and
> > structural changes. Also covers luma dbp, chroma dpb and mv sizes for
> > each codec as per the UM for MFCv12, along with appropriate alignment.
> > v3 link:
> > https://patchwork.kernel.org/project/linux-media/cover/20221011122516.
> > 32135-1-aakarsh.jain@samsung.com/
> >
> > Changes since v2:
> > -Addressed review comments by Rob Herring.
> > This was regarding the errors found by Rob bot in yaml file. File
> > 'samsung,s5p-mfc.yaml' is already converted into json schema and is
> > merged.
> >
> > -Addressed review comments by Krzysztof Kozlowski.
> > This was regarding depricated properties mentioned in s5p-mfc.txt file.
> > Review comment was addressed and 'samsung,s5p-mfc.yaml' is already
> > merged now.
> >
> > -Addressed review comments by Andi Shyti.
> > This was regarding addition of 'MFC_V10PLUS_BITS' macro in
> > 's5p_mfc_common.h file.
> > v2 link:
> > https://patchwork.kernel.org/project/linux-media/cover/20220907064715.
> > 55778-1-smitha.t@samsung.com/
> >
> > Changes since v1:
> > -Addressed review comments by Krzysztof Kozlowski.
> > Separated bug fixes patches, resent again with fix tag and those are
> > merged now.
> > -Added SoC based compatible string.
> >
> > -Addressed review comments by Andrzej Hajda Assigned width64 and
> > height32 variable with ALIGN(ctx->img_..) used in the code in
> > 's5p_mfc_opr_v6.c' file.
> > v1 link:
> > https://patchwork.kernel.org/project/linux-media/patch/20220517125548.
> > 14746-2-smitha.t@samsung.com/
> >
> > Aakarsh Jain (11):
> >   dt-bindings: media: s5p-mfc: Add mfcv12 variant
> >   media: s5p-mfc: Rename IS_MFCV10 macro
> >   media: s5p-mfc: Add initial support for MFCv12
> >   media: s5p-mfc: Add YV12 and I420 multiplanar format support
> >   media: s5p-mfc: Add support for rate controls in MFCv12
> >   media: s5p-mfc: Add support for UHD encoding.
> >   media: s5p-mfc: Add support for DMABUF for encoder
> >   media: s5p-mfc: Set context for valid case before calling try_run
> >   media: s5p-mfc: Load firmware for each run in MFCv12.
> >   media: s5p-mfc: DPB Count Independent of VIDIOC_REQBUF
> >   arm64: dts: fsd: Add MFC related DT enteries
> >
> >  .../bindings/media/samsung,s5p-mfc.yaml       |  18 ++
> >  arch/arm64/boot/dts/tesla/fsd.dtsi            |  21 ++
> >  .../platform/samsung/s5p-mfc/regs-mfc-v12.h   |  52 +++
> >  .../platform/samsung/s5p-mfc/regs-mfc-v7.h    |   1 +
> >  .../platform/samsung/s5p-mfc/regs-mfc-v8.h    |   3 +
> >  .../media/platform/samsung/s5p-mfc/s5p_mfc.c  |  36 ++-
> > .../platform/samsung/s5p-mfc/s5p_mfc_common.h |  29 +-
> >  .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  10 +-
> >  .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    |  60 +++-
> >  .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    | 149 ++++++---
> >  .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |  14 +-
> >  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c |  12 +-
> > .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 300 ++++++++++++++-
> ---
> >  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |   7 +-
> >  14 files changed, 563 insertions(+), 149 deletions(-)  create mode
> > 100644 drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
> >


