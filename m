Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E117D68A7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbjJYKeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbjJYKeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:34:13 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D6FB0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:34:09 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231025103405epoutp038fb46c3259bf14c4c80da16f10e3296f~RUzqpEowP0489704897epoutp03L
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:34:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231025103405epoutp038fb46c3259bf14c4c80da16f10e3296f~RUzqpEowP0489704897epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698230045;
        bh=isyn7njcauSMu4EFZHDTZ5HQHHyMnOVu6FNtfgDxVc0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=c9FhagVC9Nja1b/Hk3x8maBSYJE6yhsrZaZhOedrRmhHOq7RLuTTAAbII6535tz9/
         b7/iDtRu52GBpCRNuWIepW7pQ7cQ7yyVUqiWJZ3AphocyptuEi5XR6MGLs/O+tsSjb
         XD+UaeSNFcFIOPWl9TxYfX2UWJC3Zi3h/XROv/Ic=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20231025103405epcas5p2c7aa207c3e8c55c6b1d47430b531f378~RUzqDzDU02457324573epcas5p2P;
        Wed, 25 Oct 2023 10:34:05 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SFlf31lHjz4x9Pp; Wed, 25 Oct
        2023 10:34:03 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.A5.09672.B1FE8356; Wed, 25 Oct 2023 19:34:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231025102230epcas5p1558641a18fbf4f841c82b0ef4cf5a91f~RUpirJkwp1496314963epcas5p1e;
        Wed, 25 Oct 2023 10:22:30 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231025102230epsmtrp257980e7d3f915d1d750b9e5f88adfbee~RUpiqFDCW0922409224epsmtrp2w;
        Wed, 25 Oct 2023 10:22:30 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-1d-6538ef1b3dad
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.30.18939.56CE8356; Wed, 25 Oct 2023 19:22:30 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231025102226epsmtip12b72bdd7f9d22a564ba4d422e7b9beba~RUpfjjcKV0054300543epsmtip13;
        Wed, 25 Oct 2023 10:22:26 +0000 (GMT)
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
        ajaykumar.rs@samsung.com, aakarsh.jain@samsung.com
Subject: [Patch v4 00/11] Add MFC V12 support
Date:   Wed, 25 Oct 2023 15:52:05 +0530
Message-Id: <20231025102216.50480-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf1BUVRTHu++9ffsAn/MCpAuE4hZMMC3s5u52MSDHH/kMZyJrJLGkDd6w
        DMvutm/BwrG0QkQUsSlHaAEDyQQEWkVYgYB1HYkCUUBicAFZMYgGHZCgwGrXBfvvc875fuec
        e+69FO7ZSPpRKRoDp9co1SLSnbh0JeQFsf99xEnu5BBorKFAgFrvtxFopPgSicrmf8PQcNkM
        gSwX6oSoqrkLQ2evtQpQibVLgOrbRgk00GrG0I0CG4Hyxu/gyGS/JUA9l40kOlpbJ0Cnrv+I
        ofNWmxCV99/A0HemRQyV1j0Uoqxmq3CDD1tVXAXY/jPTOGsutAnZsqYJjDVV5JDs7VtNJHvh
        zKds1tW/CTbvYgVgZ0yr2Y7ZGWGsR3xqpIpTJnH6QE6TqE1K0SRHiWLeStiUIFdIpGJpBHpZ
        FKhRpnFRos3bY8WvpagdxxUFZijV6Y5UrJLnReHRkXptuoELVGl5Q5SI0yWpdTJdGK9M49M1
        yWEazrBeKpG8JHcI309VHT0xQOq6/T5qXGgjDgCjzxHgRkFGBv+qvi50sifTCGD9ed0R4O7g
        aQD/qbKCJ0FH6a/CZUflydMCV8EMYM+3NtIVZGFwyvK5o0JRJCOGnfVqp8GbOQig/bDBqcGZ
        Phzeq5/DnAUvh2Y2pww4mWCCoLXmX9LJNBMFv8wewVzd1sDK2lbcaYaMlYItk38ujbEZHu8Z
        xl3sBX+/dnEp7wdnpppJFydCe+nEkkYNa5q+Ilz8KmztNRLOQXEmBNZcDnelA+DXHdWP++LM
        Snhs4e7SDDRsKF7mYGi8PS9w8bPwSmU5cDEL+4aagWuP78G5+QfCfBBQ+H+H0wBUAF9Ox6cl
        c7xct07D7X1yUYnaNBN4/IpDYxrA6MiDMAvAKGABkMJF3vSu7YjzpJOUH2dyem2CPl3N8RYg
        d+zsBO63KlHr+AYaQ4JUFiGRKRQKWcQ6hVT0DD2ZVZTkySQrDVwqx+k4/bIPo9z8DmBD4yNm
        zrpv7p01gj/S6C0/UT7amLeDh86+TudvkPl+Er2xhTQ8HWJKF7jhwb03S7wmR+kde7vF+54K
        GbO9seMzd0NmgEdBiXogVO6mzvxwxVopFZ5bZO081LVN3LX/F1te5bzx4OLGHx7tjgzSGHzw
        WVtu9R5rb7t8rOH7UvfdjYOl/X2qllp7BreiZiudklOW/VwE3HpoUfaNrftUe6zpFX44oVPi
        bV8bd29w/wfTX7T506v9J5rH1ebofC9Zd3m574sPd930mcsNKjx3+M3jm+bi4+nehZ3zK6c8
        7hLv2n4uLlLFFawfzOcfBZ8ras/QCY3PW+hjHjuzV5ntDXtGrsaJCF6llIbiel75H260lsFO
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnG7aG4tUgzvNjBZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYvnxA6wW84+cY7XYfvARi8XNAzuZLC7OvMti
        0ffiIbPFpsfXWC0u75rDZtGzYSurxYzz+5gs1h65y26x9PpFJotlm/4wWSza+oXdonXvEXYH
        MY8189Ywelxf8onZY+esu+wei/e8ZPLYtKqTzePOtT1sHpuX1Hu0Hv3F4tG3ZRWjx+dNch6n
        vn5mD+CO4rJJSc3JLEst0rdL4MromXiTreCCVMXu3wdZGhjniHUxcnJICJhIrJ62gLWLkYtD
        SGA7o8T2txcYIRIyEv/bjrFD2MISK/89Z4coamaSaLs1A6iIg4NNQFfi7PYckLiIQCujxPWV
        nUwgDcwCr5klXn9NAbGFgWq+di4GG8oioCpxZP1/NhCbV8BWYlL7AyaIBfISqzccYJ7AyLOA
        kWEVo2hqQXFuem5ygaFecWJucWleul5yfu4mRnA8aAXtYFy2/q/eIUYmDsZDjBIczEoivJE+
        FqlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZVzOlOEBNITS1KzU1MLUotgskwcnFINTNU1P+9d
        vnA/89oVz39nkneUPsv5YWt+eOnjE7YrupSa+y3nsbU3FX+czM45b+pNo1nTGDrzV/TYepbw
        V8uHs154VTyBn+f7/SWqb2aapNoa9E3mEZW64yHEfeDuEmfTk+7pz99Fy0iZfQzOPpsq47G/
        9bOa/pGJB9STVbYfbXJb8JpXJi19xt8sYU5HZ18XQ5EzRfainpfqY47O8b205X3/u7fxxtcu
        NfAUMO8suf6jofm9b4r604NnrH5c5f12cHfypveqdyekBJYwr1rJ8TpiVR17YXp1ZHufHcdG
        e95DemeDLT9oyUfqzMvcwLI65s7F2Y43zqdK1s5cGfKXS2OViGcUV7SvRwy7/AVeJZbijERD
        Leai4kQA/ysaWfYCAAA=
X-CMS-MailID: 20231025102230epcas5p1558641a18fbf4f841c82b0ef4cf5a91f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025102230epcas5p1558641a18fbf4f841c82b0ef4cf5a91f
References: <CGME20231025102230epcas5p1558641a18fbf4f841c82b0ef4cf5a91f@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

 .../bindings/media/samsung,s5p-mfc.yaml       |  16 +
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  21 ++
 .../platform/samsung/s5p-mfc/regs-mfc-v12.h   |  52 +++
 .../platform/samsung/s5p-mfc/regs-mfc-v7.h    |   1 +
 .../platform/samsung/s5p-mfc/regs-mfc-v8.h    |   3 +
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c  |  36 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h |  29 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |   9 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    |  51 ++-
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    | 138 +++++---
 .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |  14 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c |  12 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 312 +++++++++++++++---
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |   7 +-
 14 files changed, 574 insertions(+), 127 deletions(-)
 create mode 100644 drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h

-- 
2.17.1

