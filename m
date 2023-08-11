Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C09778BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbjHKKVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbjHKKUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:20:51 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE1B30F0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:20:07 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230811102005epoutp03ce3b5a685cf83a09f1f0a599acf0496b~6TPCDJsr02110221102epoutp033
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:20:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230811102005epoutp03ce3b5a685cf83a09f1f0a599acf0496b~6TPCDJsr02110221102epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691749205;
        bh=eeT+jQ/kNlW40YkxXVMB6n8Vkix6XHLa7azqH76+Vhk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=JWBDFjfItTQgH32YMBVcIYMCQpPOGKs3DmGtEOkw5bh/CY01Js7AuH0FC+ItoG17u
         c6W4ndof67sZHunkq1DWySG3UJfeaPLkqjCG/gNBYvKetUhUWAY4igXQmv6pIZp1CA
         ojOGdqbM3aDizK2aje6xjz/xEkUl0IGNMN6n+ZIw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230811102005epcas5p3268dfa3fccf0f06ccb34d3beea7f3ed8~6TPB04PSY1952719527epcas5p3d;
        Fri, 11 Aug 2023 10:20:05 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RMftW64YZz4x9Ps; Fri, 11 Aug
        2023 10:20:03 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.97.06099.35B06D46; Fri, 11 Aug 2023 19:20:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230811101910epcas5p30f4711f8d7da7bcb716d3a4d71978859~6TOOCrASE1662816628epcas5p3-;
        Fri, 11 Aug 2023 10:19:10 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230811101910epsmtrp29b68c3e4bf304d16441b2003a61c96f8~6TOOCA3uX0365303653epsmtrp2i;
        Fri, 11 Aug 2023 10:19:10 +0000 (GMT)
X-AuditID: b6c32a4b-cafff700000017d3-f9-64d60b53206c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.FF.14748.D1B06D46; Fri, 11 Aug 2023 19:19:09 +0900 (KST)
Received: from unvme-desktop.sa.corp.samsungelectronics.net (unknown
        [107.99.41.39]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230811101908epsmtip1e6b328f7fe1ddc2cd2f0e6353f8edb9f~6TOMaLBHF1505715057epsmtip1A;
        Fri, 11 Aug 2023 10:19:08 +0000 (GMT)
From:   Ankit Kumar <ankit.kumar@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     gost.dev@samsung.com, Ankit Kumar <ankit.kumar@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Small fixes for block t10-pi
Date:   Fri, 11 Aug 2023 21:03:11 +0530
Message-Id: <20230811153313.93786-1-ankit.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTQzeY+1qKQediQ4s1V36zW6y+289m
        cfPATiaLSYeuMVrsvaVtcXnXHDaL5cf/MTmwe1w+W+qxaVUnm8fHp7dYPPq2rGL0+LxJLoA1
        KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gIJYWy
        xJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2
        xpzn91kLljNXvLtyiLGB8RJTFyMnh4SAicS5ljOsXYxcHEICuxklZn89xQzhfGKUmHrzDBOE
        841RYufhU0BlHGAt30+FQsT3Mkqsa1jCBuF0MkksmPuTBWQum4C2xKu3N5hBbBGBMokfE3ax
        gdjMAjUSnfdmge0WFjCUWPvvHSOIzSKgKtG4uwHM5hWwkTiw8y0LxH3yEjMvfWeHiAtKnJz5
        hAVijrxE89bZYKdKCJxjl1i89xU7RIOLxPr/86CeE5Z4dXwLVFxK4vO7vWwQdrbEpoc/oWoK
        JI686GWGsO0lWk/1M4N8ySygKbF+lz5EWFZi6ql1TBB7+SR6fz+BauWV2DEPxlaV+HvvNtTN
        0hI3312Fsj0kvqw7ATZeSCBW4tGFyewTGOVnIXlnFpJ3ZiFsXsDIvIpRMrWgODc9tdi0wDgv
        tRwescn5uZsYwWlRy3sH46MHH/QOMTJxMB5ilOBgVhLhtQ2+lCLEm5JYWZValB9fVJqTWnyI
        0RQYxhOZpUST84GJOa8k3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU7NTUgtQimD4mDk6p
        BqZQx7NGct+4GVr2vKlWZFqox7XCcYfmk73s+r7C96daHj/QHn//ztvbTzocK98LaF67WPOC
        t7rX9+muQz+fhOt1n5Xs2fTo1U1Z/TDvaD/T473iGr3bWa/v4nr05vf9GdUOnSrvvs3ta51U
        MCnzfIQdn3f/p7vZX89yPtndPGnSGY30es2FuY9bz6imfPxX8zNqu/Oh33O1NjBsti1k2Hng
        qdtzLUYX6VkiAjXNacacN9I+nO55Lj0zga+qmYlD2LSi0TXG7ZlKZO6t1G/FPnGvk667HrJp
        321RNvVm3OP8K7N8loo3ncz22zxjSlzg+upi7TdWjTIPDy+bxvd7W2FG2NpGTsk1WoKZ8+7f
        WKnEUpyRaKjFXFScCACQV0ODFAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsWy7bCSnK4s97UUgykfrSzWXPnNbrH6bj+b
        xc0DO5ksJh26xmix95a2xeVdc9gslh//x+TA7nH5bKnHplWdbB4fn95i8ejbsorR4/MmuQDW
        KC6blNSczLLUIn27BK6MOc/vsxYsZ654d+UQYwPjJaYuRg4OCQETie+nQrsYuTiEBHYzSrzo
        /MQIEZeWWLg+sYuRE8gUllj57zk7RE07k8SXmecZQRJsAtoSr97eYAaxRQQqJM58OcUKUsQs
        0MAoMeVzH1hCWMBQYu2/d2ANLAKqEo27G8BsXgEbiQM737JAbJCXmHnpOztEXFDi5MwnYHFm
        oHjz1tnMExj5ZiFJzUKSWsDItIpRMrWgODc9N9mwwDAvtVyvODG3uDQvXS85P3cTIzhAtTR2
        MN6b/0/vECMTB+MhRgkOZiURXtvgSylCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeQ1nzE4REkhP
        LEnNTk0tSC2CyTJxcEo1MNVPjyr+2LdlxrtDu9ifsif/uV/06u8mx0MZy6QfzFaNOq/OVFVc
        VyryefPh87nX7H88Udow2ZCp9PrsK/e11jq/ttdUeLpW7vbJp8tMuMIeP3TYOveijL7XaXYJ
        9jh91gNN0wuda7LZgwp2mB5sifsRaRd17ono84szxX/OCM8P/s44f9oN3evzpnjcc70cIS0Z
        cvOi3qzIFf5OD4Pi9PY/fvfr3M8Gzjeb981PmHL1Y4PoSTuB6o2lEhl1mb/Wab1Us5LJWtfH
        dM1f1Wl6yMP6oFWr50V0JUqwq8RduLGy4rfWGaErc794qecZXC/Il2xJPu/V2b2S70ZH3ppf
        ss1W5Sy1y1aUqZ1u5VpifEWJpTgj0VCLuag4EQAzbnP+vwIAAA==
X-CMS-MailID: 20230811101910epcas5p30f4711f8d7da7bcb716d3a4d71978859
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811101910epcas5p30f4711f8d7da7bcb716d3a4d71978859
References: <CGME20230811101910epcas5p30f4711f8d7da7bcb716d3a4d71978859@epcas5p3.samsung.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series has two patches that:
 - Removes redundant T10_PI_TYPE2_PROTECTION condition check during
   t10_pi_verify.
 - Removes duplicate module license introduced in an earlier commit.

Ankit Kumar (2):
  block:t10-pi: remove redundant Type2 check during t10 PI verify
  block:t10-pi: remove duplicate module license

 block/t10-pi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.25.1

