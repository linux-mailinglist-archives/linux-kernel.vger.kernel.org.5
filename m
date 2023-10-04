Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0F87B785B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241482AbjJDHGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbjJDHGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:06:31 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5E4AB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 00:06:27 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231004070623epoutp014ad5aadde42d80bf30e7b4fcca3ffa84~K1bU3jIkc1624616246epoutp01x
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:06:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231004070623epoutp014ad5aadde42d80bf30e7b4fcca3ffa84~K1bU3jIkc1624616246epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696403183;
        bh=e8BOPtE3ePI3lfQ4kT8tCmWndNBXP8SQG8TbeYtNBRc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=j4qlf3iVtmEQkdHA0oVC2xLJGxlrPvOGe5lwtW9Z7+ShJORXeLXOUyrJaPjVOGSkx
         GNEyGTZnEqQHBTlBncJkWCW1G6zZtx6bnJzPxPV/r7zEC+wk0yronXAgPxvAGhQXAh
         1ciF5QloEBl2IKeQDxCfl6GvtssB24aeE7Yf7HqU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231004070623epcas1p157e9d101bf1b897d088e7bba88e2666e~K1bUlUbqC0483904839epcas1p1w;
        Wed,  4 Oct 2023 07:06:23 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.227]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4S0m2729d4z4x9QJ; Wed,  4 Oct
        2023 07:06:23 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.E8.08657.9EE0D156; Wed,  4 Oct 2023 16:06:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231004070617epcas1p259d92fcc0d53c52278c8886d6b2b6e8a~K1bOu_HUG2396623966epcas1p2q;
        Wed,  4 Oct 2023 07:06:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231004070617epsmtrp29a54e7b826b70e6317a870128a02d2ff~K1bOuNei51607716077epsmtrp2f;
        Wed,  4 Oct 2023 07:06:17 +0000 (GMT)
X-AuditID: b6c32a33-4e9ff700000021d1-f2-651d0ee9d5db
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.70.08742.9EE0D156; Wed,  4 Oct 2023 16:06:17 +0900 (KST)
Received: from wookwanglee02 (unknown [10.253.100.52]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231004070617epsmtip26db7e5c26a365fc76e03603a8277f9fe~K1bOi02zt3126431264epsmtip2A;
        Wed,  4 Oct 2023 07:06:17 +0000 (GMT)
From:   "Woo-kwang Lee" <wookwang.lee@samsung.com>
To:     "'Greg KH'" <gregkh@linuxfoundation.org>
Cc:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <sj1557.seo@samsung.com>
In-Reply-To: <2023100439-king-salute-5cd5@gregkh>
Subject: RE: [PATCH] usb: core: add bos NULL pointer checking condition
Date:   Wed, 4 Oct 2023 16:06:17 +0900
Message-ID: <000101d9f691$4513da00$cf3b8e00$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL4ktvx1bQoFTuKvuL3rpp4W8lh6wDTwCDRAk7sf+Kt4uZggA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmvu5LPtlUgw0vVSyaF69ns7i8aw6b
        xaJlrcwWW/4dYbVYsPERowOrx/65a9g9+rasYvT4vEkugDmqgdEmsSg5I7MsVSE1Lzk/JTMv
        3VYpNMRN10JJISO/uMRWKdrQ0EjP0MBcz8jISM/UKNbKyFRJIS8xN9VWqUIXqldJoSi5AKg2
        t7IYaEBOqh5UXK84NS/FISu/FOROveLE3OLSvHS95PxcJYWyxJxSoBFK+gnfGDOWPT/JXjCJ
        r+Lk6fssDYzzuLsYOTkkBEwklp/awNLFyMUhJLCDUeLCrEVsIAkhgU+MElvfc0AkvjFKnJ5/
        jBmmY8eLF8wQib2MEpcOnIZyXjNKzN9/ixWkik3AQGJT+xWwUSICOhIdZ06wgNjMAqUSv+/0
        gdVwChhKPJ/7FcwWFnCXWP/yOtgGFgEVia1bDwLFOTh4BSwlDkyIAQnzCghKnJz5BGqMvMT2
        t3OgDlKQ+Pl0GSvEKieJ14s+QNWISMzubAO7TUJgIofE128Qr0kIuEgcev+MBcIWlnh1fAs7
        hC0l8fndXjaIhmZGiZc3P7FAOD2MEscfbmKCqDKW+PT5MyPIdcwCmhLrd+lDhBUldv6eywix
        mU/i3dceVoi4oMTpa93MIOUSArwSHW1CEGE1idVnF7FNYFSeheS3WUh+m4Xkh1kIyxYwsqxi
        FEstKM5NT002LDBEjvBNjOBUqmW8g/Hy/H96hxiZOBgPMUpwMCuJ8KY3yKQK8aYkVlalFuXH
        F5XmpBYfYkwGBvZEZinR5HxgMs8riTc0M7O0sDQyMTQ2MzQkLGxiaWBiZmRiYWxpbKYkzqs4
        YXaKkEB6YklqdmpqQWoRzBYmDk6pBibO7Ss/pV6RZPzFXnJAwfx+M8+zdwV/lwbOaP75ec43
        a3l+v5iVHUe2rp0up8YZ+zE45btLZdLe64/0ZvN7SrBtvM4VUZLLdDLw413vpxc2vzfnO7OZ
        9Zng8bLDPMYNcx3mWO+Y2ayV/ypIXiqq/FvifP89b+Z6ivy9cbS20mvdzy36KqsTFnP53Liw
        eybHYYsp0v6ljgd3HD3qavByKfcapZNJP414pz++4PpApj2f28Rz9Z+fzv1l5V41B55/ap6p
        1iqwelLjstBn1k/WMT6zknZK+NGiPkddoVVh0kI13kXnXDVdL3Bu+T2F82CoTO+2+Z1ydaF1
        BjcjLy8quJB0Y+2Zf0fWHF7tZZCmK1OuxFKckWioxVxUnAgAubaH71wEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXvcln2yqweVl/BbNi9ezWVzeNYfN
        YtGyVmaLLf+OsFos2PiI0YHVY//cNewefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlbHs+Un2
        gkl8FSdP32dpYJzH3cXIySEhYCKx48UL5i5GLg4hgd2MEvvPLGKDSMhI7F7+B8jmALKFJQ4f
        Loaoecko8eP4cyaQGjYBA4lN7VfA6kUEdCQ6zpxgAbGZBSol7n7/wgrRsIVR4lX3VVaQBKeA
        ocTzuV/BbGEBd4n1L68zg9gsAioSW7ceZAVZxitgKXFgQgxImFdAUOLkzCcsIGFmAT2Jto2M
        EOPlJba/ncMMcaaCxM+ny1ghbGGJV8e3sEPYZhJ/9nWzQJzmJPF60Qeo00QkZne2MU9gFJ2F
        ZMMshA2zkGyYhaRjASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4IjS0tzBuH3V
        B71DjEwcjIcYJTiYlUR40xtkUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzir/oTRESSE8sSc1O
        TS1ILYLJMnFwSjUwXfFb7aEZ3mp+3VG7v7Mr58Iu8ZiUoh2bPPKmrrcN9pXyaa3akpC4ck6K
        kbwqm5DcxcCTz/87d+jIG073mfAy7NkKrp0nBD5+PtdXUN0cMaPJfl/TwoWp6WwdGb1auz+L
        Oap6Pd/yx9Hm47RJlVPYw796HNsek/CUufi3q7hyQJ1HqdHFa1rPnjBn/N4qviB2d3PpTYnp
        hWpn5gny1TOd03eKPNw+V+fGvJd7NUXXWrmofplsfO/Qc7Elqfs7T3T8rfmgZ6p+w2rpnh+F
        DEfLfzU7d6wTaWE1PrjZ55V/+/zkxyoy7nMrLNeYPbz494aAYkGO//KQO1vnL5wpcHBvl+Ck
        7jNufyIs58212pWvxFKckWioxVxUnAgA0uguKhcDAAA=
X-CMS-MailID: 20231004070617epcas1p259d92fcc0d53c52278c8886d6b2b6e8a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231004062700epcas1p16fe36bf6b6a6e5d9d4adeaef32937480
References: <CGME20231004062700epcas1p16fe36bf6b6a6e5d9d4adeaef32937480@epcas1p1.samsung.com>
        <20231004062642.16431-1-wookwang.lee@samsung.com>
        <2023100439-king-salute-5cd5@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. I think I missed the patch.
Thank you for your quick feedback.

Woo-kwang Lee

> On Wed, Oct 04, 2023 at 03:26:42PM +0900, Woo-kwang Lee wrote:
> > This issue occurs when connecting Galaxy S22 and abnormal SEC Dex
> Adapter.
> > When the abnormal adapter is connected, kernel panic always occurs
> > after a few seconds.
> > This occurs due to unable to get BOS descriptor,
> > usb_release_bos_descriptor set dev->bos = NULL.
> >
> > - usb_reset_and_verify_device
> >   - hub_port_init
> >   - usb_release_bos_descriptor
> >     - dev->bos = NULL;
> >
> > hub_port_connect_change() calls portspeed(), and portspeed() calls
> > hub_is_s uperspeedplus().
> > Finally, hub_is_superspeedplus() calls hdev->bos->ssp_cap.
> > It needs to check hdev->bos is NULL to prevent a kernel panic.
> >
> > usb 3-1: new SuperSpeed Gen 1 USB device number 16 using
> > xhci-hcd-exynos usb 3-1: unable to get BOS descriptor set usb 3-1:
> > Product: USB3.0 Hub Unable to handle kernel NULL pointer dereference
> > at virtual address 0000018
> >
> > Call trace:
> >  hub_port_connect_change+0x8c/0x538
> >  port_event+0x244/0x764
> >  hub_event+0x158/0x474
> >  process_one_work+0x204/0x550
> >  worker_thread+0x28c/0x580
> >  kthread+0x13c/0x178
> >  ret_from_fork+0x10/0x30
> >
> > - hub_port_connect_change
> >   - portspeed
> >     - hub_is_superspeedplus
> >
> > Fixes: 0cdd49a1d1a4 ("usb: Support USB 3.1 extended port status
> > request")
> > Signed-off-by: Woo-kwang Lee <wookwang.lee@samsung.com>
> > ---
> >  drivers/usb/core/hub.h | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Are you sure this isn't already fixed by commit f74a7afc224a ("usb: hub:
> Guard against accesses to uninitialized BOS descriptors") in linux-next?
> 
> thanks,
> 
> greg k-h

