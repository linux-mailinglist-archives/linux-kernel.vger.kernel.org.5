Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC87B7A910D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjIUCs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjIUCsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:48:47 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810D4E9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:48:36 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230921024833epoutp04e2cd5814d83143c25a61155f60b121f5~GyhfNN5Mm0282402824epoutp04D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 02:48:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230921024833epoutp04e2cd5814d83143c25a61155f60b121f5~GyhfNN5Mm0282402824epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695264513;
        bh=Ye8fW4HB7wJE1e9ls41gQoLkMu8/BJiYJk+ZmCk74qk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=CbPpcfA3E+bF/YgHnGXr3cYW3HvDYe/s2roEppDIiKi+KClXmYct6ZnqDNL8mTB0l
         rKqgqBJjWhnjVf3WOp5GZaJglrNEMUqi//lCXZL5aS7fy5z8rUBjckkCeqN7i4QjRT
         w0RoSIywn/NvHw690xGsF8Sus7CmK5ktfKQdHrd4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230921024832epcas2p3ca37aba86a0f67bd73a4f13af4db7220~Gyhehjx4e2379423794epcas2p3x;
        Thu, 21 Sep 2023 02:48:32 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.68]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Rrfwc1mHVz4x9Q5; Thu, 21 Sep
        2023 02:48:32 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.19.08583.00FAB056; Thu, 21 Sep 2023 11:48:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230921024831epcas2p337d3d41f95bee75d2e2f3350bc48e70d~Gyhdr4jjU2379423794epcas2p3t;
        Thu, 21 Sep 2023 02:48:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230921024831epsmtrp207e008287b0e2ad29f08adf75710041e~Gyhdqvfhx1801818018epsmtrp2B;
        Thu, 21 Sep 2023 02:48:31 +0000 (GMT)
X-AuditID: b6c32a43-96bfd70000002187-54-650baf009476
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.A6.08742.FFEAB056; Thu, 21 Sep 2023 11:48:31 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230921024831epsmtip2cb96f507b0b84c6282be4c57508cb8e5~GyhdUAg9G1644616446epsmtip25;
        Thu, 21 Sep 2023 02:48:31 +0000 (GMT)
From:   Jeongtae Park <jtp.park@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jeongtae.park@gmail.com>,
        Jeongtae Park <jtp.park@samsung.com>
Subject: [PATCH 0/7] cxl: Fix checkpatch issues
Date:   Thu, 21 Sep 2023 11:51:03 +0900
Message-Id: <20230921025110.3717583-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmqS7Deu5Ug+czOS3uPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFs2L17NZfHjzj8XiwOsGdoszZ1+yWqxaeI3N4sjaq0wW
        i4/OYLY4uofD4vysUywWl3fNYbO4NeEYk8XG++/YHIQ8ds66y+7RcuQtq8fiPS+ZPDat6mTz
        2D93DbtH35ZVjB5TZ9d7fN4kF8ARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlh
        rqSQl5ibaqvk4hOg65aZA/SKkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECv
        ODG3uDQvXS8vtcTK0MDAyBSoMCE7Y9vuZUwFk9gr/nz6wNrAeJu1i5GTQ0LAROL4xI9ANheH
        kMAORonjO3czQTifGCWunHkGlfnGKNG6sIcdpuXfkk2MEIm9jBITW3ugnD+MEuuXrgUbzCag
        JTF9ZgNYu4jAQyaJna/6wAYzCzxikvh44hUzSJWwgL7E/n0HmEBsFgFVicdLz4N18wpYS3yd
        /BLqRHmJ/QfPMkPEBSVOznzCAmIzA8Wbt84GinMA1WzhkFggBVHuInFs3mSoU4UlXh3fAmVL
        SXx+t5cN5AYJgWZGidfPr7BAOC2MEutu74CqMpZ4d/M5K8hQZgFNifW79CHmK0scuQW1lk+i
        4/Bfdogwr0RHmxBEo5LEvKXzmCFsCYlLc7dA2R4SPd9WgH0iJBAr8fj0bLYJjPKzkDwzC8kz
        sxD2LmBkXsUollpQnJuemmxUYAiP1uT83E2M4PSs5byD8cr8f3qHGJk4GA8xSnAwK4nwJn/i
        ShXiTUmsrEotyo8vKs1JLT7EaAoM3onMUqLJ+cAMkVcSb2hiaWBiZmZobmRqYK4kznuvdW6K
        kEB6YklqdmpqQWoRTB8TB6dUA1Ns68q7vHJ7AoO2P4zzrWGuYJ+bqdzQunVd/JxXZf4bqn93
        T5687Vnn8a/dzWt7Ivya7WWSzX4eOxXWqJc0/8kcO265klqOitQz6rZFBz5OEH/U/OC9xWu+
        6VvEc6pTRBR7xaerfZ2UcjrgheZ6Xy1m28rQXxNv5HHs3XGH40LGIbHER9XmE95EmfdfmVx/
        WvzDzoM1rwTVF22rmFd96uFC1fY8FX6Wf/L8e6QD3DcIJwZqerNY2luteXihlXX5d4sHAnbH
        NgvPk1qX0czeLXxQcY+AzJv7j587zHW58WTTpmsrnsivjb3zlFGaJ+FQ7jH7M54Njdb/zvUu
        N8+8/khca677Sfucis+PI15v61ZiKc5INNRiLipOBABH6lBRWAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSvO7/ddypBn+WyVrcfXyBzaJ58mJG
        i+lTLzBanLjZyGax+uYaRoum1XdZLZoXr2ez+PDmH4vFgdcN7BZnzr5ktVi18BqbxZG1V5ks
        Fh+dwWxxdA+HxflZp1gsLu+aw2Zxa8IxJouN99+xOQh57Jx1l92j5chbVo/Fe14yeWxa1cnm
        sX/uGnaPvi2rGD2mzq73+LxJLoAjissmJTUnsyy1SN8ugStj2+5lTAWT2Cv+fPrA2sB4m7WL
        kZNDQsBE4t+STYxdjFwcQgK7GSV2tXWxQCQkJJZveMEEYQtL3G85wgpR9ItRYt7UfWBFbAJa
        EtNnNoAlRASeM0mcfHMKbBSzwCsmid7/15lBqoQF9CX27zsANopFQFXi8dLzYLt5Bawlvk5+
        CXWHvMT+g2eZIeKCEidnPgHbwAwUb946m3kCI98sJKlZSFILGJlWMUqmFhTnpucWGxYY5qWW
        6xUn5haX5qXrJefnbmIEx4yW5g7G7as+6B1iZOJgPMQowcGsJMKb/IkrVYg3JbGyKrUoP76o
        NCe1+BCjNAeLkjiv+IveFCGB9MSS1OzU1ILUIpgsEwenVANTgovVxN2a6tL2KgndRUG/Jwh7
        rMoS8XtUHVu+5b/dr5rWVfNKeUw+5WeHz5oXxT2B54OZZkavi8yav9K388QKT73Xqv/U8JbB
        ZfFrp3DVYMWqf4qbo44u3Sx59tuWDcLuGa9n8C2eO63it+W0GS1Mn3+Idhk1lzEGrVC/afPA
        +svqRzKKV6IXFh1y1jM31rSwsmSx7FX44tzxyLwj3SvWxXKlss2F9P+FJzJPZ95/+CVAI75K
        pvye6pOI5ylbhFt7poSUbAtQ7dzwUe3w5r5wLznhlkfndwp8ac4Ly08Xls79OTV0ReHHPFmh
        1VxTj/97/nD3qWszFtgZzztt2+b0kXFeu8K8Mwsa3fmeflBiKc5INNRiLipOBADA1DgNCAMA
        AA==
X-CMS-MailID: 20230921024831epcas2p337d3d41f95bee75d2e2f3350bc48e70d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230921024831epcas2p337d3d41f95bee75d2e2f3350bc48e70d
References: <CGME20230921024831epcas2p337d3d41f95bee75d2e2f3350bc48e70d@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes various checkpatch errors and warnings.
I've been looking at the CXL driver recently and noticed that there are
trivial mistake codes, so I checked all files with the script and fixed
some warnings/errors.

Jeongtae Park (7):
  cxl/trace: Fix improper SPDX comment style for header file
  cxl/region: Fix a checkpatch warning
  cxl/mem: Fix a checkpatch error
  cxl: Fix a checkpatch error
  cxl: Fix block comment style
  cxl/memdev: Fix whitespace error/warnings
  cxl/trace: Enclose a multiple statements macro in a do while loop

 drivers/cxl/core/memdev.c | 12 ++++++------
 drivers/cxl/core/region.c |  7 +++----
 drivers/cxl/core/trace.h  | 26 ++++++++++++++------------
 drivers/cxl/cxl.h         |  4 ++--
 drivers/cxl/cxlmem.h      |  2 +-
 5 files changed, 26 insertions(+), 25 deletions(-)


base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
-- 
2.34.1

