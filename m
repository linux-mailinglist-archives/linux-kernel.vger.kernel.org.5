Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD94785092
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjHWGXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjHWGXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:23:40 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4057E50
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 23:23:37 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230823062334epoutp01e2d723bf5edfcb86397cf20a5ca8befa~97v8U_6lm2996329963epoutp01o
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:23:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230823062334epoutp01e2d723bf5edfcb86397cf20a5ca8befa~97v8U_6lm2996329963epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692771814;
        bh=oae8C16j6kRiezbBVYHuN1AsaLhdigYyXsBcbOjJJlQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UmuDNLJNYDRDQWXGZlsrNWF6n39rHmc6U4H9jpMQY8SP7YIkwCevxLtCLJMxiEmAl
         oJdJRntzFNOpfJ5nqhbXuFTxD1Yg3N7CI3VY7Az7lbOIItE13UF4sne90rw3QbeZ5D
         y/v3swGxmwZP+96YbrsTL/LMl3mwGcPBI+oH3aoQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230823062333epcas5p1370f686e36324ca51773f47df3ab62b4~97v78mf1N2579525795epcas5p15;
        Wed, 23 Aug 2023 06:23:33 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RVx441dljz4x9Pv; Wed, 23 Aug
        2023 06:23:32 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.B0.55173.4E5A5E46; Wed, 23 Aug 2023 15:23:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230822063335epcas5p330d79a9f3f88bf1bcdb849ee47b831ec~9oPZvdKLo2787427874epcas5p37;
        Tue, 22 Aug 2023 06:33:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230822063335epsmtrp13429d45f12ce49da961a9c1396ca638d~9oPZuq11L1793717937epsmtrp1K;
        Tue, 22 Aug 2023 06:33:35 +0000 (GMT)
X-AuditID: b6c32a50-df1ff7000001d785-d8-64e5a5e4cef0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.03.34491.FB654E46; Tue, 22 Aug 2023 15:33:35 +0900 (KST)
Received: from unvme-desktop (unknown [107.99.41.39]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230822063334epsmtip1afd02e2b288eedd6242afcfffc8c6f7e~9oPYu7rEl0074600746epsmtip1w;
        Tue, 22 Aug 2023 06:33:34 +0000 (GMT)
Date:   Tue, 22 Aug 2023 17:22:36 +0530
From:   Ankit Kumar <ankit.kumar@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH 0/2] Small fixes for block t10-pi
Message-ID: <20230822115236.GA183261@unvme-desktop>
MIME-Version: 1.0
In-Reply-To: <20230811153313.93786-1-ankit.kumar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdlhTS/fJ0qcpBmfOs1usvtvPZnHzwE4m
        i0mHrjFa7L2lbXF51xw2i+XH/zE5sHlcPlvqsWlVJ5vHx6e3WDz6tqxi9Pi8SS6ANSrbJiM1
        MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdov5JCWWJOKVAo
        ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO6PpxDX2
        gtXsFa1vfrM3MLaydTFyckgImEhsOXyKpYuRi0NIYA+jxNzVa6GcT4wSKy73sEI43xgllp5c
        zgTTMqfxNxtEYi+jxNlVh9ghnFeMEtNftrGAVLEIqErM/vYAzGYT0JZ49fYGM4gtIhAq0bjs
        LNgkZoEMidNrHrGD2MICphJnHp5lBbF5BYwldjybxQJhC0qcnPkEzOYUsJWY+uMNI8gyCYFH
        7BJ7ph5ihjjJReLjomlQ5wlLvDq+hR3ClpJ42d8GZWdLbHr4E6qmQOLIi16oXnuJ1lP9zDAH
        tb7fB1UvKzH11DqoQ/kken8/gerlldgxD8ZWlfh77zYLhC0tcfPdVSjbQ+LLuhPMkFCZwCgx
        e/8e1gmMcrOQPDQLyT4IW0diwe5PbLMYOYBsaYnl/zggTE2J9bv0FzCyrmKUSi0ozk1PTTYt
        MNTNSy2Hx3Nyfu4mRnCq1ArYwbh6w1+9Q4xMHIyHGCU4mJVEeKW/P0wR4k1JrKxKLcqPLyrN
        SS0+xGgKjKGJzFKiyfnAZJ1XEm9oYmlgYmZmZmJpbGaoJM77unVuipBAemJJanZqakFqEUwf
        EwenVAOTmcoy2YOem65eUw3UP7Qw5craWXOPXz9knXPbxiFyXn00193njTNE9fQDNGo/Se46
        fp1BtVZo+97wrJK6U+meS/mWsCz6Jmft5+LCVukvOXfXhtRs+3r3l39N1d8byk0ODrmZ3h76
        4XRd2ce+vMMcbxtF6vYc+Xj59kelYpXGpnNbNuxVFmVc+4GHvSMi8cNj898T11qmXw7yaTCW
        4xQ3Fr5+KMTSdMrD/wfTxEMnqDZX6E9IPMu+xUSt5XqotHKY+E5G05pPF+PP8mQK1LMZebG+
        arm/pyrrw8qFLzQEwyrey/54JPj0aST/HpHtacHX9tTuCRDWPecVsPeLqLBQ8iLbymnX237c
        jr4be0GJpTgj0VCLuag4EQDjH/R2HgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSnO7+sCcpBv/+sFmsvtvPZnHzwE4m
        i0mHrjFa7L2lbXF51xw2i+XH/zE5sHlcPlvqsWlVJ5vHx6e3WDz6tqxi9Pi8SS6ANYrLJiU1
        J7MstUjfLoErY+mWPpaC1ywV+1buZG1gvMfcxcjJISFgIjGn8TdbFyMXh5DAbkaJxT0PGbsY
        OYAS0hIL1ydC1AhLrPz3nB2i5gWjxPXfS1hAEiwCqhKzvz0As9kEtCVevb3BDNIrIhAq0fFc
        DCTMLJAhcXrNI3YQW1jAVOLMw7OsIDavgLHEjmezWCBmTmCUmHZpAVRCUOLkzCcsEM1aEjf+
        vWQCmckMdM/yfxwgYU4BW4mpP94wTmAUmIWkYxaSjlkIHQsYmVcxSqYWFOem5xYbFhjmpZbr
        FSfmFpfmpesl5+duYgSHtpbmDsbtqz7oHWJk4mA8xCjBwawkwiv9/WGKEG9KYmVValF+fFFp
        TmrxIUZpDhYlcV7xF70pQgLpiSWp2ampBalFMFkmDk6pBqarNSwrez8cdTrOf/NCcqHjimu/
        N8c+Ef//f94rtrn3xQzPqITOOWNb8PLa/7ZVkXqfnGvWTVi4pfzYSwuLFvE39nJRv/cUMLBP
        tOmeLRk972HjjJb+T+x9W/25rT2419m5J4jkrO2PEZlYk9Sp7pvlNse0LzKmTKXqlsvCgvpn
        Nv5JXrwuR46+mHi2KzVx3ySORJElSmxKLJnzbquGP0m7P7vDrsQ6J856QkZEwXdhs5pmyx/n
        nk/TYLlueLkjWGJJTIavzJRvV9ODFXm1FzbONetzPP1VvMflzuEPNYE32WaWrF6Qen/u/n0O
        e30FY0S599vtj9AsVBLgDZ5x0YnZcClPYpq3/Pbt5vP5lViKMxINtZiLihMBrKHy1NwCAAA=
X-CMS-MailID: 20230822063335epcas5p330d79a9f3f88bf1bcdb849ee47b831ec
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----gE6680ZNUinvX0c6ClraybDZwn8mhhmyVsG0uFNlX7QT91ZL=_7a094_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811101910epcas5p30f4711f8d7da7bcb716d3a4d71978859
References: <CGME20230811101910epcas5p30f4711f8d7da7bcb716d3a4d71978859@epcas5p3.samsung.com>
        <20230811153313.93786-1-ankit.kumar@samsung.com>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------gE6680ZNUinvX0c6ClraybDZwn8mhhmyVsG0uFNlX7QT91ZL=_7a094_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Aug 11, 2023 at 09:03:11PM +0530, Ankit Kumar wrote:
> This series has two patches that:
>  - Removes redundant T10_PI_TYPE2_PROTECTION condition check during
>    t10_pi_verify.
>  - Removes duplicate module license introduced in an earlier commit.
> 
> Ankit Kumar (2):
>   block:t10-pi: remove redundant Type2 check during t10 PI verify
>   block:t10-pi: remove duplicate module license
> 
>  block/t10-pi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> -- 
> 2.25.1
> 
>

Hi Jens,

These two patches have been reviewed by Martin.
Can you please take a look.

Ankit

------gE6680ZNUinvX0c6ClraybDZwn8mhhmyVsG0uFNlX7QT91ZL=_7a094_
Content-Type: text/plain; charset="utf-8"


------gE6680ZNUinvX0c6ClraybDZwn8mhhmyVsG0uFNlX7QT91ZL=_7a094_--
