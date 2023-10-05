Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8906A7BA0A9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbjJEOk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbjJEOhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:37:03 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4050B47885
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:02:59 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231005080537epoutp0115a6ec7f947925c9d59d0aff2715e846~LJ4Uz-YKu1379913799epoutp01D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 08:05:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231005080537epoutp0115a6ec7f947925c9d59d0aff2715e846~LJ4Uz-YKu1379913799epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696493137;
        bh=HCaPv8vnab2WsCcpJQSxA5m17wuV3wZsDl03fye1R40=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MoiTIS0TOdLbnn2uIxHNUc4WYZUHBgJVruHELMSjU7sq3W7BbzvAOpVMCdRfeUQCc
         BIr6/nZI8sJYd5geR/7ZLWDfsfC5glLqp91gVHx1fSpCq5420/b5ZWGG08pc0fQsoZ
         2tw50lPPHXR+9OvQEbjIalEAz6DfWz+rv7+4OSG0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231005080536epcas2p17f0ad039a4013cc17f41c135694fda51~LJ4UGLCsf0805808058epcas2p1x;
        Thu,  5 Oct 2023 08:05:36 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4S1PJ02Khhz4x9Q7; Thu,  5 Oct
        2023 08:05:36 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.42.09649.05E6E156; Thu,  5 Oct 2023 17:05:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231005080535epcas2p277cd4296cc3ce911e4e413b684ed7acf~LJ4TEHo1D2605926059epcas2p2E;
        Thu,  5 Oct 2023 08:05:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231005080535epsmtrp2a1f570b342982271d9c16756d5ce29d6~LJ4TDK2KU2359823598epsmtrp2-;
        Thu,  5 Oct 2023 08:05:35 +0000 (GMT)
X-AuditID: b6c32a46-b9ffa700000025b1-2b-651e6e50bf5d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.BA.08742.F4E6E156; Thu,  5 Oct 2023 17:05:35 +0900 (KST)
Received: from jtpark-7920 (unknown [10.229.83.56]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231005080535epsmtip202bf93ccd5fb586e0f789e09d7b2d0af~LJ4SzgdHl2366523665epsmtip2A;
        Thu,  5 Oct 2023 08:05:35 +0000 (GMT)
Date:   Thu, 5 Oct 2023 17:08:34 +0900
From:   Jeongtae Park <jtp.park@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jeongtae.park@gmail.com>
Subject: Re: [PATCH v2 2/7] cxl/region: Fix a checkpatch warning
Message-ID: <ZR5vAgpn9ZfTaKFt@jtpark-7920>
MIME-Version: 1.0
In-Reply-To: <20230925110745.00001127@Huawei.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmhW5AnlyqwdlDfBZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmsfjoDGaL
        o3s4LM7POsVicXnXHDaLWxOOMVlsvP+OzUHQY+esu+weLUfesnos3vOSyWPTqk42j/1z17B7
        9G1ZxegxdXa9x+dNcgEcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5
        qbZKLj4Bum6ZOUBfKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz
        0vXyUkusDA0MjEyBChOyM/692sFWcEG04lTDBdYGxs8CXYycHBICJhI7rjxg6WLk4hAS2MEo
        0Xz/NBuE84lRoq+tkQnC+cYosbJlGmsXIwdYy7P58RDxvYwSu2f+YAEZJSTwglHi06UMEJtF
        QEXi06SzYHE2AS2J6TMbWEFsEQEjiXc3JjGCNDMLvGSRWN54mw0kISzgIHF3+XFmEJsXqGHr
        2mmMELagxMmZT8AGcQoYSry9OgPsPAmBCxwSmze9ZYV4wkVizuM/LBC2sMSr41vYIWwpic/v
        9kI1NDNKvH5+hQXCaWGUWHd7B1SVscS7m8/BJjELZEg8P/aCBeJPZYkjt1ggwnwSHYf/skOE
        eSU62oQgOpUk5i2dxwxhS0hcmrsFyvaQuL3uNDskiLYxSpzZ1Ms2gVFuFpKHZiHZBmHrSCzY
        /YltFtAKZgFpieX/OCBMTYn1u/QXMLKuYhRLLSjOTU8tNiowgkdxcn7uJkZwstZy28E45e0H
        vUOMTByMhxglOJiVRHjTG2RShXhTEiurUovy44tKc1KLDzGaAqNnIrOUaHI+MF/klcQbmlga
        mJiZGZobmRqYK4nz3mudmyIkkJ5YkpqdmlqQWgTTx8TBKdXA5HiSZUu5+NRoyyc8HBrHH3fs
        3Mvs4TFry2G2feuuLfiu8FL1h3uXUM/vDW0JF35XqMSG/2jbf861uvqy2J1za+oT67XV9igo
        hv6aXXzh9361XQf9Ntm941sUIpRl/d61P2R2w6WAAEHn12u+yC6SCl09M5Utwm095/Vav7jU
        Hd01J6y0zNPqevZ5MUrW5QpVSVyxfVyrvlelteiiw8Hdfz64mr0x6xIKzF9kxOL3Wc6jN+2N
        wX5zpV8/3kcv1LSaxPt3XqdALpea/XS5pnvT1eZZhd095+5/J5NH/4f4vQed2xrsQ7OjZSrT
        +liDSkS7s97f/J4WPE90q3m3rFxYs+e/TS8uWQfyLjkfuFGJpTgj0VCLuag4EQC2/1o4XwQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvK5/nlyqwctlmhZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmsfjoDGaL
        o3s4LM7POsVicXnXHDaLWxOOMVlsvP+OzUHQY+esu+weLUfesnos3vOSyWPTqk42j/1z17B7
        9G1ZxegxdXa9x+dNcgEcUVw2Kak5mWWpRfp2CVwZO18cYiyYIFxx+P52xgbGM3xdjBwcEgIm
        Es/mx3cxcnEICexmlPj7ZR97FyMnUFxCYvmGF0wQtrDE/ZYjrBBFzxglNvfMYARJsAioSHya
        dJYFxGYT0JKYPrOBFcQWETCSeHdjEiNIA7PARxaJX/PnghUJCzhI3F1+nBnE5gVq2Lp2GiPE
        1G2MEhevnGaBSAhKnJz5BMxmBiq68e8lE8ipzALSEsv/cYCEOQUMJd5encE2gVFgFpKOWUg6
        ZiF0LGBkXsUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERxrWpo7GLev+qB3iJGJg/EQ
        owQHs5IIb3qDTKoQb0piZVVqUX58UWlOavEhRmkOFiVxXvEXvSlCAumJJanZqakFqUUwWSYO
        TqkGpnV/Lf75qjNFfcvT+phTNiPtUijLGeZyuY+udw7oenjUGkk7t52xvbqgcs4Boc/3XkaH
        JJzI9j6wd0acaKrR96cLTnV2Rd8Rjp4XcK1Y+KPHGtO9y6V/FqeuiLngJ9a/LuyRcImtptyK
        Rlubr3yvmkz/Tu6f2WoTvbVsmdGRfj4v7daQv7cCwuXmCy6r9f4ftChbW/ZByrG+j54dyete
        5PiLGydXV5/vnpYawBRYkqyjPf/YfrXwl7nXeTQrmaWfRrsLs5iGBVee1LP5Vjit97dzs+Ld
        O1IHbB+HTTrFMPfUFfXPy3N/Wz2+vvvnrwuHM6XqnJ+vkRR6pmK14RuL6YwMnXVTzKamxOkp
        NCxVYinOSDTUYi4qTgQA1EGPHSQDAAA=
X-CMS-MailID: 20231005080535epcas2p277cd4296cc3ce911e4e413b684ed7acf
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----E9vxk1eHFJMo0Hi_Q_rTTD2vXp5VKj0nvvVRz8vbSgBSYVSL=_9a285_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922113233epcas2p2cd57df10dde36b0da3b2fc5a916132e8
References: <CGME20230922113233epcas2p2cd57df10dde36b0da3b2fc5a916132e8@epcas2p2.samsung.com>
        <20230922113520.3298976-1-jtp.park@samsung.com>
        <20230925110745.00001127@Huawei.com>
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

------E9vxk1eHFJMo0Hi_Q_rTTD2vXp5VKj0nvvVRz8vbSgBSYVSL=_9a285_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Sep 25, 2023 at 11:07:45AM +0100, Jonathan Cameron wrote:
> On Fri, 22 Sep 2023 20:35:20 +0900
> Jeongtae Park <jtp.park@samsung.com> wrote:
> 
> > WARNING: else is not generally useful after a break or return
> > 
> > Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> This one is a little ugly. I'd prefer to see the error
> condition remain out of line (vs the warning one)
> 
> 		if (!IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
> 			dev_err(&cxlr->dev,
> 				"Failed ...");
> 			return -ENOXIO
> 		}
> 
> 		dev_warn_once(...
> 
> 		return 0;
> 
> Or keep the else.

I think I changed it too mechanically ignoring the meanings.
Your comment made me think about it a bit more. If we don't
really need the error message to be printed every calling,
how about remove it and modify the condition statements like
below. It would make more efficient or small codes
when 'CONFIG_CXL_REGION_INVALIDATION_TEST' is not set.

static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
{
        if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)
                        && cpu_cache_has_invalidate_memregion()) {
                dev_warn_once(&cxlr->dev,
                        "Bypassing cpu_cache_invalidate_memregion() for testing!\n");
                return 0;
        }

        return cpu_cache_invalidate_memregion(IORES_DESC_CXL);
}

> 
> Not that important though as code is small enough that less
> than ideal in / out of line doesn't matter that much to readability.
> 
> Jonathan
> 
> 
> > ---
> >  drivers/cxl/core/region.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index e115ba382e04..1fc9d01c1ac0 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -133,11 +133,10 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
> >  				&cxlr->dev,
> >  				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
> >  			return 0;
> > -		} else {
> > -			dev_err(&cxlr->dev,
> > -				"Failed to synchronize CPU cache state\n");
> > -			return -ENXIO;
> >  		}
> > +
> > +		dev_err(&cxlr->dev, "Failed to synchronize CPU cache state\n");
> > +		return -ENXIO;
> >  	}
> >  
> >  	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> 

------E9vxk1eHFJMo0Hi_Q_rTTD2vXp5VKj0nvvVRz8vbSgBSYVSL=_9a285_
Content-Type: text/plain; charset="utf-8"


------E9vxk1eHFJMo0Hi_Q_rTTD2vXp5VKj0nvvVRz8vbSgBSYVSL=_9a285_--
