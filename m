Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69A47FED3A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjK3KqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjK3KqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:46:11 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763D110D0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:46:16 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231130104615epoutp0437889d744a7f30578f847d927092d2de~cYMjayUJx1515515155epoutp04B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:46:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231130104615epoutp0437889d744a7f30578f847d927092d2de~cYMjayUJx1515515155epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701341175;
        bh=lpgEsMM2Swvg3aWvWDgBIjROc0YAnhJPoTFrtHmNBas=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aX/mTHd52yazZ0fVOGdAMHrHMzV1sOBUPEJ39XncxAk+DD/A6ZOcHNal5N5V5CuiV
         R9sEpHijEI3xf5h+YAG+OpgNaYFUDJg8MzyWBHS3ep7EORxjDDYTltqadAdeYdk0b9
         LCXHXuNrjgsu1kVK0THsgmaytNOr+F+NY+TLk9Rg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231130104614epcas5p4066dfac30dd7d7f508c37a82fe514f22~cYMi9C1Wv0879608796epcas5p4N;
        Thu, 30 Nov 2023 10:46:14 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SgtCT2Vs2z4x9Q0; Thu, 30 Nov
        2023 10:46:13 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.86.09634.5F768656; Thu, 30 Nov 2023 19:46:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20231130100343epcas5p2cf91a2057fb56503ed604d431b9706e7~cXnbQcdDd3068030680epcas5p2M;
        Thu, 30 Nov 2023 10:03:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231130100343epsmtrp1b7576c37b0bacd63c50947fe06e6cbc5~cXnbPjBlG2224222242epsmtrp1g;
        Thu, 30 Nov 2023 10:03:43 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-25-656867f5934d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.12.08755.FFD58656; Thu, 30 Nov 2023 19:03:43 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231130100341epsmtip26face0ab34efd61492c11e79007cb557~cXnZcgsEv0093700937epsmtip2E;
        Thu, 30 Nov 2023 10:03:41 +0000 (GMT)
Date:   Thu, 30 Nov 2023 15:27:17 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, error27@gmail.com,
        gost.dev@samsung.com, nitheshshetty@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: Update type from size_t to u16 for
 opts->queue_size
Message-ID: <20231130095717.f2pcf6op3mjd3vtk@green245>
MIME-Version: 1.0
In-Reply-To: <74306015-9e99-4703-b578-1d235dc725d5@suswa.mountain>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmlu7X9IxUg7MrBC1W3+1ns/gwr5Xd
        4tEyP4ubB3YyWaxcfZTJYvfCj0wWkw5dY7R4enUWk8XlXXPYLOYve8puseNJI6PFutfvWRx4
        PGbdP8vmsXPWXXaP8/c2snhcPlvqsWlVJ5vHnWt72Dw2L6n32H2zgc2jt/kdm0ffllWMHp83
        yQVwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCd
        rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIF
        KkzIzjh9XLTgA3vF9aUxDYyX2LoYOTkkBEwkOr6dYe9i5OIQEtjNKPF84RUmkISQwCdGiZk3
        gyAS3xglTl1oY4fp+PDxHzNEYi+jxM+VB6DanzFKnH92Aqidg4NFQFXiRFMQiMkmoC1x+j8H
        SK+IgI7Ev7+TWUDKmQVuMEnsP/ODFSQhLBAiMev5RDaQel4BM4llJ9VAwrwCghInZz5hAbE5
        BZwkWhqvMYLYogIyEjOWfgW7QULgDIfE9o1PWCGOc5HYvPQ6C4QtLPHq+Baoo6UkXvbDPFAu
        sXLKCjaI5hZGiVnXZzFCJOwlWk/1M4PYzAIZEtN/L4caKisx9dQ6Jog4n0Tv7ydMEHFeiR3z
        YGxliTXrF0DDVFLi2vdGKNtD4v7Xi0yQAFrFJLFp3jHGCYzys5B8NwvJPgjbSqLzQxOQzQFk
        S0ss/8cBYWpKrN+lv4CRdRWjZGpBcW56arFpgWFeajk8upPzczcxgtO1lucOxrsPPugdYmTi
        YDzEKMHBrCTCe/1peqoQb0piZVVqUX58UWlOavEhRlNgXE1klhJNzgdmjLySeEMTSwMTMzMz
        E0tjM0Mlcd7XrXNThATSE0tSs1NTC1KLYPqYODilGpiMXj+2WCwTfaUom8/shuwpl5NSJQon
        p9r85RN+y32tozaKS0B7u4tbk/iWk/Ghbjye4nNLujadLoyO5766QCDIjdvgsbb2Y8etx53P
        Sh185pGffLDok+WUzww6TSGnmJSmPdi/KK5K/WIfl5fAjTlH6y7flnVef5p9bVvTerWrzT4L
        +0vdwn0OJh30nsIdM29py+PJbX6ii8JVz7Yc7Db4ZnZz/ykvhyQJxcerkl2LjbgaROrrrj2S
        yHuWb8U3Z8M3jxvH4rZJ/yzi3cj44MIMhufMbvnBp169by95pDDF1OpZwrdSo1J/ITNx/SXT
        ZM9xvPjFMMVJjkehT+bjI8vFU31itNP/pIvKsTFUKbEUZyQaajEXFScCAAQJA+dgBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXvd/bEaqwZqfMhar7/azWXyY18pu
        8WiZn8XNAzuZLFauPspksXvhRyaLSYeuMVo8vTqLyeLyrjlsFvOXPWW32PGkkdFi3ev3LA48
        HrPun2Xz2DnrLrvH+XsbWTwuny312LSqk83jzrU9bB6bl9R77L7ZwObR2/yOzaNvyypGj8+b
        5AK4o7hsUlJzMstSi/TtErgyts/4yVSwiLVi+bLrbA2M81i6GDk5JARMJD58/MfcxcjFISSw
        m1Hi+JdmJoiEpMSyv0eYIWxhiZX/nrNDFD1hlDj/uRXI4eBgEVCVONEUBGKyCWhLnP7PAVIu
        IqAj8e/vZLD5zAK3mCTmPlEDsYUFQiRmPZ/IBlLOK2AmseykGsTEVUwSO05fYQWp4RUQlDg5
        8wlUr5nEvM0PmUHqmQWkJZb/AxvPKeAk0dJ4jRHEFhWQkZix9CvzBEbBWUi6ZyHpnoXQvYCR
        eRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnCcaWnuYNy+6oPeIUYmDsZDjBIczEoi
        vNefpqcK8aYkVlalFuXHF5XmpBYfYpTmYFES5xV/0ZsiJJCeWJKanZpakFoEk2Xi4JRqYGr9
        nB7r+vTllRzvgjz2vrOfF204VbbjmJcQ/8mnzAcKOgvNmHdfuTUr0P2jzEajs39/OoSnZpkK
        HD2XKZbu6SZSdtzxzs+MM/LZgaa8Xb1RBmqNRznWTHu6mIHdcZL1Qxe3pN9vJ/geOjj/R9aN
        s7a7GNNbXwjvZsmYVXdlr9jy65NknmTf0a18WVDRf3PHzhfBPVv8dZ2vn8kRbVB2PP5359ql
        Sz2z7SyvaphUmfTb75A99mz+H/sd5aFHH3zZ0u3ZLcLWaLP42KT1ZZN5l4rO3CTg8bggadLV
        R46ep+Y7+4Rcl99xd63H4z8Bch1mPv+EC/qzZNp4DFv3m6oem1lVdPzHQ9uLEzgm/wvaHK7E
        UpyRaKjFXFScCADHkMh4IgMAAA==
X-CMS-MailID: 20231130100343epcas5p2cf91a2057fb56503ed604d431b9706e7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="-----X5GTQUX7iz43IUoMshLy-onBunNFM-CI2iAV9v.t35zL_Zv=_1fcc9_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231128123622epcas5p4940679fbbafdf0da802deea3e531f850
References: <CGME20231128123622epcas5p4940679fbbafdf0da802deea3e531f850@epcas5p4.samsung.com>
        <20231128122958.2235-1-nj.shetty@samsung.com>
        <0cd6862e-8037-40b3-9fde-b7f10d66e31c@suswa.mountain>
        <20231129104837.arls2gn3wttiqiff@green245>
        <74306015-9e99-4703-b578-1d235dc725d5@suswa.mountain>
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

-------X5GTQUX7iz43IUoMshLy-onBunNFM-CI2iAV9v.t35zL_Zv=_1fcc9_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 30/11/23 10:07AM, Dan Carpenter wrote:
>On Wed, Nov 29, 2023 at 04:18:37PM +0530, Nitesh Shetty wrote:
>> Thank you for this insight.
>> I ran smatch on complete kernel using smatch's test_kernel.sh
>> I was unaware of this smbd.py option. I will explore this.
>
>The ./smatch_scripts/build_kernel_data.sh command creates the cross
>function db.  It takes a while though.  And it's probably better to
>run it a few times because every time you run it the call tree chains
>get one call longer.  I run it every night against the latest
>linux-next.
>
I was not aware of repeated runs and chaining, will use repeat runs next time.

Thank you,
Nitesh Shetty

-------X5GTQUX7iz43IUoMshLy-onBunNFM-CI2iAV9v.t35zL_Zv=_1fcc9_
Content-Type: text/plain; charset="utf-8"


-------X5GTQUX7iz43IUoMshLy-onBunNFM-CI2iAV9v.t35zL_Zv=_1fcc9_--
