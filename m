Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D05D7AADC7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjIVJXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjIVJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:23:30 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CECB1A3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:23:22 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230922092320epoutp0288d449f3a24bb7637723f65eac780557~HLjeAeNTa1199811998epoutp02s
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:23:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230922092320epoutp0288d449f3a24bb7637723f65eac780557~HLjeAeNTa1199811998epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695374600;
        bh=2IW3rb56zGCm9qAsFG7v2B5AHJ/3o8wCuaDSV4ASVdE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OkeXowYESVyQi3nOVODV//x4gj1Kgq1zV1J62YrAFlXUkF+/RPRVVn76BcMkw98eR
         8G7+FPzCcKCkMb4psRWet3CepM8/MR6xd7hfe5ZwxYLYtWENxCn5uVX+GcquuZVz9t
         pcZMziDK31Ceq42qNLVorNea6Uai184BIe8oQD80=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230922092320epcas2p38ce2047acb11c56e5f3f5858a5c6f6ba~HLjddzXMV2322323223epcas2p3Q;
        Fri, 22 Sep 2023 09:23:20 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.69]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RsRdg58h9z4x9Ps; Fri, 22 Sep
        2023 09:23:19 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.78.19471.70D5D056; Fri, 22 Sep 2023 18:23:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230922092319epcas2p4ac5bd93520bf6e893f431764e0454079~HLjciHmAn0401904019epcas2p4j;
        Fri, 22 Sep 2023 09:23:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230922092319epsmtrp238efc3506efaac00b4113b362a5fda86~HLjchJJg32075720757epsmtrp2L;
        Fri, 22 Sep 2023 09:23:19 +0000 (GMT)
X-AuditID: b6c32a4d-b07ff70000004c0f-a9-650d5d079649
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.81.08788.60D5D056; Fri, 22 Sep 2023 18:23:18 +0900 (KST)
Received: from jtpark-7920 (unknown [10.229.83.56]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230922092318epsmtip2444d74bfaddc3e10ef460be297112e78~HLjcUk2R82041020410epsmtip2a;
        Fri, 22 Sep 2023 09:23:18 +0000 (GMT)
Date:   Fri, 22 Sep 2023 18:26:08 +0900
From:   Jeongtae Park <jtp.park@samsung.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
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
Subject: Re: [PATCH 7/7] cxl/trace: Enclose a multiple statements macro in a
 do while loop
Message-ID: <ZQ1dsMjS4RBJxi1X@jtpark-7920>
MIME-Version: 1.0
In-Reply-To: <de20c603-6521-1ab7-3bab-67e6a278bd1e@intel.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwbZRzH87TX60HsdrxsPFY38BQyiECLvBwbTJeBO4djEBc1BoO39kKb
        lmvTF3VL5hiUwWAyBkzWMnAGEGUorCMLMlAoMFGYYwwwMAtRVDaY6ICNhqTolevM/vv8vs/3
        m9/vecOE/qOoFFOzJsbA0loC9UWu9oWTkeJ3JYysvoEgnbMjKFlQWQ/I6nMjgBycPIGSlyZb
        AJl/ySkiC+pbUfKf++sI2bOQJyaHb9wTkc2fTaBk/cB5ITnQhZE3bT8i5O3OCyg5VX5dQF6e
        WURf8aO+sTnFlKX/LxFV33VPQNmbT6HUd7UtYqqsvRlQ52qOU8v27RnYO5okFUMrGUMIwyp0
        SjWbk0ykvZG9NzsuXiaPlCeSCUQIS+cyyUTK6xmRr6q13C6IkPdprZmTMmijkYjenWTQmU1M
        iEpnNCUTjF6p1Sfoo4x0rtHM5kSxjGmnXCaLieOM72lUD0faRPovt3xYVFcsyANf+JUAHwzi
        sbDK+TdSAnwxf7wLwFpnB+CLJQAbPq3xrjwC8JG7AX0cKW2xeV3dADpWTwv54i7nWl4VeFwI
        Hgq7pq4CD6N4BKy25ok8HMjpM62zqCcgxF0IrJ5wIZ6FADwL5vdWbLCEC1hdhSjPfvAH6+8b
        ug+eDC1X1sSeMMSHMXilbFrMz5QCB1bbhDwHwPnv2726FC4vdqN8oADAhbkxhC8sAH59p8Pr
        egkuTs5tzCfEVXDKfo0zYZz+POyfQnh5Eyzuc4t5WQKLT/rzSQLWNdZ5+0I4WtvuZQr+4ppA
        +WNZAXDAOi4uB9ttT2zI9kQ3nl+EF68toTauhRB/BjatYzyGw9bO6ItA1AykjN6Ym8MoYvTy
        SJb54P+LVuhy7WDjcUcc6AALre4oBxBgwAEgJiQCJYolX8ZfoqSPHGUMumyDWcsYHSCOu6Kz
        QukWhY77HawpWx6bKIuNj5cnxMTJEoggyXRhrdIfz6FNjIZh9IzhcU6A+UjzBMFOquBWS657
        yNjb8fbgrsr9d8PTDsarqhzBe356LijgdNlHvynQyps7KnoOnqy6MN777NiRrTvD1MfS+ysK
        qPLrc1nyM4n7tx4+VrQaLV85PFuZuq98oWozsZ5Uao6N+cSHVv95dqU9NPzX4YYXErPC6pK/
        fXDi1Ni2pbWUP/ouL2iSBtM19yML+0dlLktCpvXfJPpBmyS4dvcMbjH1A3a6CDwE+8bpPYfu
        bA4c2nbjKUtRxtPkWz/HtVlf7p5PD0WChtKaJstu6TIbX3PM22+rHGtsT+CmTEvYoc/Pl43P
        RaTukLXWKPe++dXR0hKXW5va2G3Kzu+0s2vFiqqmLsX0xwcIxKii5RFCg5H+DyzssellBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvC5bLG+qwbTL1hZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmsfjoDGaL
        o3s4LM7POsVicXnXHDaLWxOOMVlsvP+OzUHQY+esu+weLUfesnos3vOSyWPTqk42j/1z17B7
        9G1ZxegxdXa9x+dNcgEcUVw2Kak5mWWpRfp2CVwZq2+eYS14KVSxbcZftgbGRv4uRk4OCQET
        ie41sxi7GLk4hAR2M0r0b33IBJGQkFi+4QWULSxxv+UIK0TRM0aJ7vW/2EESLAKqEntubWME
        sdkEtCSmz2xgBbFFgOL31z9mA2lgFvjHIjHx4gqwScICMRJNByexgNi8QA0zf7SygdhCAl8Y
        Jc7eY4WIC0qcnPkErIYZqObGv5dAvRxAtrTE8n8cIGFOAVuJls2/2CcwCsxC0jELSccshI4F
        jMyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCY01LawfjnlUf9A4xMnEwHmKU4GBW
        EuFN/sSVKsSbklhZlVqUH19UmpNafIhRmoNFSZz32+veFCGB9MSS1OzU1ILUIpgsEwenVAMT
        c8Xm2KDJC54uLxTn5F2QENzlxlq44U2R5pSVuxlPe7k7zDukXPjs072MCUdKXXc7VmXyn/v8
        h085OFlWV2pW4Ldsxshit9cXhXj4asMYIm2vZfVMPbs30y/DM/oe99H/F9im211W9pXcl/6X
        zVj/7UvPayd1XRftENfduG27uPHhwJnvLdbpXTNN/P/LvkdT4xs34zzD2gQut6JrUr0fP3mF
        rek5931imKfH+6vWLM2LlpqdfXf3pUqMzYWb78OTdiYfiVl1PGhO1QTXYw9rdt2rUYzlmxLf
        bbK7W6vjbd8tDrXNZV2Wotp+Omdf71aIjecpns77gS2Kuz06+XxSzLZ2m7PLy/TmBXw4vFyJ
        pTgj0VCLuag4EQAENXXIJAMAAA==
X-CMS-MailID: 20230922092319epcas2p4ac5bd93520bf6e893f431764e0454079
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----P5duZL37EoFqXMqfBraval5XGtOxqTbc-oIX9L1P8Ie5rEk1=_234a6_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230921024832epcas2p35c4d3c20f7a70b023db64cd0db823eb8
References: <20230921025110.3717583-1-jtp.park@samsung.com>
        <CGME20230921024832epcas2p35c4d3c20f7a70b023db64cd0db823eb8@epcas2p3.samsung.com>
        <20230921025110.3717583-8-jtp.park@samsung.com>
        <de20c603-6521-1ab7-3bab-67e6a278bd1e@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------P5duZL37EoFqXMqfBraval5XGtOxqTbc-oIX9L1P8Ie5rEk1=_234a6_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Sep 21, 2023 at 03:58:26PM -0700, Dave Jiang wrote:
> 
> 
> On 9/20/23 19:51, Jeongtae Park wrote:
> > ERROR: Macros with complex values should be enclosed in parentheses
> > 
> > Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
> 
> I think that goes against typical traceevent macros layout. I would ignore checkpatch warnings on traceevent stuff. 
> 
>

Ok, I see, I will drop this change.

> > ---
> >  drivers/cxl/core/trace.h | 24 +++++++++++++-----------
> >  1 file changed, 13 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index 7aee7fb008a5..e2338773dcd6 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -199,17 +199,19 @@ TRACE_EVENT(cxl_overflow,
> >  	__field(u8, hdr_maint_op_class)
> >  
> >  #define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
> > -	__assign_str(memdev, dev_name(&(cxlmd)->dev));				\
> > -	__assign_str(host, dev_name((cxlmd)->dev.parent));			\
> > -	__entry->log = (l);							\
> > -	__entry->serial = (cxlmd)->cxlds->serial;				\
> > -	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
> > -	__entry->hdr_length = (hdr).length;					\
> > -	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
> > -	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
> > -	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
> > -	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
> > -	__entry->hdr_maint_op_class = (hdr).maint_op_class
> > +	do {									\
> > +	    __assign_str(memdev, dev_name(&(cxlmd)->dev));			\
> > +	    __assign_str(host, dev_name((cxlmd)->dev.parent));			\
> > +	    __entry->log = (l);							\
> > +	    __entry->serial = (cxlmd)->cxlds->serial;				\
> > +	    memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));		\
> > +	    __entry->hdr_length = (hdr).length;					\
> > +	    __entry->hdr_flags = get_unaligned_le24((hdr).flags);		\
> > +	    __entry->hdr_handle = le16_to_cpu((hdr).handle);			\
> > +	    __entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
> > +	    __entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);		\
> > +	    __entry->hdr_maint_op_class = (hdr).maint_op_class;			\
> > +	} while (0)
> >  
> >  #define CXL_EVT_TP_printk(fmt, ...) \
> >  	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb "	\

------P5duZL37EoFqXMqfBraval5XGtOxqTbc-oIX9L1P8Ie5rEk1=_234a6_
Content-Type: text/plain; charset="utf-8"


------P5duZL37EoFqXMqfBraval5XGtOxqTbc-oIX9L1P8Ie5rEk1=_234a6_--
