Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3089798351
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbjIHHlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjIHHl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:41:28 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A371BDD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 00:41:23 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230908074119epoutp01d3313efc98990b99ff1f3e27f187dc9a~C3IZLDtX62481524815epoutp01l
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:41:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230908074119epoutp01d3313efc98990b99ff1f3e27f187dc9a~C3IZLDtX62481524815epoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694158879;
        bh=PmnCxtpwzHL76HZFUJr+h59YZmwECCxC7pSSKjUgycw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=GalYE5DcKTBscYiJ5Omxvek5745yyCQxXnh9cfiXjz/gEwt1jC9OYH/7bIKts0HmR
         b4zO/gCoKFNDNsnI5MRzyv3ylSkNsqoph7w9a7qrG4d0nRQKk6EfltDRJed7/aKA6q
         eqApxQOCn60LUVulR8OPSZ+pksDmFR2ro6Abzh5Y=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230908074118epcas5p31d513d96fd3d68a4000f7e1fd82c7c8b~C3IYo6qHS1398913989epcas5p3S;
        Fri,  8 Sep 2023 07:41:18 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Rhp2P06jWz4x9Q8; Fri,  8 Sep
        2023 07:41:17 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.E9.09635.C10DAF46; Fri,  8 Sep 2023 16:41:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230908063508epcas5p12fbca2a5723fa518489cb223ba24ccae~C2Onk-KSC0876308763epcas5p1q;
        Fri,  8 Sep 2023 06:35:08 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230908063508epsmtrp14fc47b3e3f0e5cd1478f590178cea45e~C2OnkTaKx2348123481epsmtrp1-;
        Fri,  8 Sep 2023 06:35:08 +0000 (GMT)
X-AuditID: b6c32a4b-563fd700000025a3-b5-64fad01c7541
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.1E.08788.C90CAF46; Fri,  8 Sep 2023 15:35:08 +0900 (KST)
Received: from unvme-desktop.sa.corp.samsungelectronics.net (unknown
        [107.99.41.39]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230908063507epsmtip1c7411dda9448452d63cc64d524b2031a~C2OmflYaM3148031480epsmtip1a;
        Fri,  8 Sep 2023 06:35:07 +0000 (GMT)
From:   Ankit Kumar <ankit.kumar@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     gost.dev@samsung.com, Ankit Kumar <ankit.kumar@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Small fixes for block t10-pi
Date:   Fri,  8 Sep 2023 17:22:29 +0530
Message-Id: <20230908115233.261195-1-ankit.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdlhTS1fmwq8Ug99brC3WXPnNbrH6bj+b
        xc0DO5ksJh26xmix95a2xeVdc9gslh//x+TA7nH5bKnHplWdbB4fn95i8ejbsorR4/MmuQDW
        qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAjlBTK
        EnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZ
        GY+WPWcteMBcMf0NbwPjX6YuRk4OCQETie+PPgPZXBxCArsZJY41v2aHcD4xSny49Q8q841R
        4tXPM+wwLUvvb2GESOxllPi28yuU08kksW/XIjaQKjYBbYlXb28wg9giAmUSPybsAoszC9RI
        dN6bBbZcGGjS+6fNQHEODhYBVYnZf4VAwrwCthKPFh+Huk9eYual7+wQcUGJkzOfsECMkZdo
        3jqbGWSvhMA5domJO/axQTS4SDx58BKqWVji1fEtUFdLSbzsb4OysyU2PfwJVVMgceRFLzOE
        bS/ReqqfGeQeZgFNifW79CHCshJTT61jgtjLJ9H7+wlUK6/EjnkwtqrE33u3WSBsaYmb765C
        2R4SN2ZOZQSxhQRiJfYfu8c2gVF+FpJ3ZiF5ZxbC5gWMzKsYJVMLinPTU4tNC4zzUsvh8Zqc
        n7uJEZwUtbx3MD568EHvECMTB+MhRgkOZiUR3tUiv1KEeFMSK6tSi/Lji0pzUosPMZoCg3gi
        s5Rocj4wLeeVxBuaWBqYmJmZmVgamxkqifO+bp2bIiSQnliSmp2aWpBaBNPHxMEp1cDEtbJb
        ccH9DmmjY2dqNwYcDBCavTgmd6H2mr+ah1JSTnG0rL82N2dCmp1lu+8cazbJz3nyIdcD50mt
        fXarOuPBdU6xb+pPJ/LuPfl+gVSco/fJnt8iDCsfOFkdNGqPncbRouQWU3MzXU6kjses437H
        qiV3r7+o/vOE+aLuxa6ADd/51r7OchKZ+9eputf3Cbuz/ANW/qfswYvuqshUuB97rLHz65pV
        nkcDn3dflI3karj91E0xd22J2qn2eHXrM9YXrqf21q/sUO1rNjT8EMP71/Bh3o4JMxsXf6uY
        v6VAjuHeJ+6QGy8FxLPvbf7UOrNnT+6nvRqWk35cyz72wqD03q/3ITO2dyp0qt9L/b9IiaU4
        I9FQi7moOBEAFrFM/BMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnO6cA79SDLZ9MLRYc+U3u8Xqu/1s
        FjcP7GSymHToGqPF3lvaFpd3zWGzWH78H5MDu8fls6Uem1Z1snl8fHqLxaNvyypGj8+b5AJY
        o7hsUlJzMstSi/TtErgyHi17zlrwgLli+hveBsa/TF2MnBwSAiYSS+9vYexi5OIQEtjNKDHv
        0V3mLkYOoIS0xML1iRA1whIr/z1nh6hpZ5JomLGNESTBJqAt8ertDWYQW0SgQuLMl1OsIEXM
        Ag2MElM+94ElhIE2vH/azAYylEVAVWL2XyGQMK+ArcSjxcehjpCXmHnpOztEXFDi5MwnLCA2
        M1C8eets5gmMfLOQpGYhSS1gZFrFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcnlpa
        Oxj3rPqgd4iRiYPxEKMEB7OSCO9qkV8pQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJI
        TyxJzU5NLUgtgskycXBKNTBtrfh1sf/Oxq+KmtcmXOfew7rOi8Vz+lIrC6aSHTniH48sv3ih
        uMzd4F3IGYeNBVXXFCYGNYiaHp3z5Ejc1u4jzis0lJktqk8zbgh4mRUxtfu0Sli9ZLrPqTPK
        DDI3GY4IcEXNTNn8SPnS7LfvlvZPuCT61eT8oQDbp+lftqTcX8q6zevF/MpvscnctxU4bvDm
        +C69eHDVmtk3HFYXtSlZdlj5VtcvnCBT8fPTI57K6AmfN8X8X+ARs/Kc3anYJT3lC8qmPjhf
        5zxn46J3S/wKldIFnl7bPVemYKfzoe0WBY0BkT077vzSlLD9IP93o+lii3/TG7uvpC4J5Qsy
        O/2tl6FRfN2R1boX3JepBqrIK7EUZyQaajEXFScCAIJp9rW+AgAA
X-CMS-MailID: 20230908063508epcas5p12fbca2a5723fa518489cb223ba24ccae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230908063508epcas5p12fbca2a5723fa518489cb223ba24ccae
References: <CGME20230908063508epcas5p12fbca2a5723fa518489cb223ba24ccae@epcas5p1.samsung.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series has two patches that:
 - Removes redundant T10_PI_TYPE2_PROTECTION condition check during
   t10_pi_verify.
 - Removes duplicate module license introduced in an earlier commit.

v2:
 - Added Reviewed-by tag for Martin K. Petersen.

Ankit Kumar (2):
  block:t10-pi: remove redundant Type2 check during t10 PI verify
  block:t10-pi: remove duplicate module license

 block/t10-pi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.25.1

