Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD377DDB6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243498AbjHPJsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243474AbjHPJsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:48:00 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A8526B5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:47:58 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230816094755epoutp03588fa5fee4e6114d2c950d80aa30b7d2~71BXudWkq2134721347epoutp03F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:47:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230816094755epoutp03588fa5fee4e6114d2c950d80aa30b7d2~71BXudWkq2134721347epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692179275;
        bh=ztXw7252kyYdNjmfspJfLRq8UnmOUR4Okc5ScKLSfy0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=IrIAXAoqUYPdmu84dHb6cwaEUaR7dQzcu37Nh746Z/GuQ7RxuYvHsMjn4bBcN3q0M
         zZe8lXYope317uvDkGKpAkLx4wLN9injCFWypSje33yRPt9BFHNvF168Cnep2mDbey
         eNEU5ZL5Zbx5YttwoECnuYvKBdhLxAkYdw2ULf3w=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230816094755epcas5p4534eb9e9c35bae0ade26c083e5d14935~71BXJn5ps1858618586epcas5p4n;
        Wed, 16 Aug 2023 09:47:55 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RQjx56SlVz4x9Ps; Wed, 16 Aug
        2023 09:47:53 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.5C.55173.94B9CD46; Wed, 16 Aug 2023 18:47:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230816094753epcas5p1d6582dfa28b11b8b06f33b41a37122bc~71BVpogyZ2744927449epcas5p1L;
        Wed, 16 Aug 2023 09:47:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230816094753epsmtrp2c00a8b1e18ea093a93a1387b4e18f884~71BVo5l9D3132931329epsmtrp27;
        Wed, 16 Aug 2023 09:47:53 +0000 (GMT)
X-AuditID: b6c32a50-df1ff7000001d785-15-64dc9b491f23
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.EF.34491.94B9CD46; Wed, 16 Aug 2023 18:47:53 +0900 (KST)
Received: from SRIB7IJ5F5BM8F (unknown [107.110.56.61]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230816094751epsmtip23a9014ee5942ff561c16d707c1218c4c~71BUEeOxl2076320763epsmtip25;
        Wed, 16 Aug 2023 09:47:51 +0000 (GMT)
From:   "sandeep.cs" <sandeep.cs@samsung.com>
To:     "'Benjamin Tissoires'" <bentiss@kernel.org>
Cc:     "'Jiri Kosina'" <jikos@kernel.org>,
        "'Benjamin Tissoires'" <benjamin.tissoires@redhat.com>,
        <junwan.cho@samsung.com>, <jitender.s21@samsung.com>,
        <suhyun_.kim@samsung.com>, <ih0923.kim@samsung.com>,
        <gaudium.lee@samsung.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: 
Subject: RE: [HID Patchsets v1 2/2] HID: Removed USB Validation check
Date:   Wed, 16 Aug 2023 15:16:52 +0530
Message-ID: <000001d9d026$b9f3d640$2ddb82c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIv11ZZQG/ebQ7+/qFwV1CefhF2UgFzzcNNAtOIyhABk5RVyK74uX1AgBkKSlA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmlq7n7DspBg8m61tcn7KZ1eLQx+Xs
        FrcXeFpsXTKX1eLW8VZGi5cPNrBbbJ78iMXi5qdvrBaXd81hs3i0YhOTA5fHplWdbB7v911l
        8+jbsorR4/MmuQCWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFsl
        F58AXbfMHKB7lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5
        qSVWhgYGRqZAhQnZGTNWXWYqeCtbcfD+cpYGxqcSXYycHBICJhI9lx4xdTFycQgJ7GGUWD13
        PQuE84lRYsKVCewQzjdGiUvb1rLBtLx7fJcdxBYS2Msoce6+DETRG0aJYy9vgCXYBLQlZvy9
        xtzFyMEhIqAv8eBLOEgNs8BqJomjRz4wgsQ5BXglJvyzBikXFnCVONe4mwXEZhFQlTi67wgb
        SAmvgKVEzzkrkDCvgKDEyZlPwEqYBeQltr+dwwxxjoLEz6fLWEFsEQE/iZaGpYwQNeISR3/2
        MIOslRBYyiGx8NolRogGF4ldR09ANQtLvDq+hR3ClpL4/G4vG0RDN6PE0tvH2CGcGYwSLTuv
        QnXYS/x8PQHsOmYBTYn1u/QhtvFJ9P5+wgQSlgD6q6NNCKJaReJp125WmPnfT2yEKvGQmHjH
        fwKj4iwkr81C8tosJC/MQti1gJFlFaNUakFxbnpqsmmBoW5eajk8vpPzczcxglOrVsAOxtUb
        /uodYmTiYDzEKMHBrCTC28N7K0WINyWxsiq1KD++qDQntfgQoykwvCcyS4km5wOTe15JvKGJ
        pYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxSDUx+RnPV17fsnLuwSstz6VJR
        x88rFR5syPldyVC21lDktnB2WouMVqro6sv/9U8Lq1ffZHIrWuO7MDF/axanUXrlXGf+2xbt
        C1XfyD1V2B3TuSX7jK9OWE3kR+cl35bluq97bWB5/2KhWv+8bVt2HdNpi9Hqf5P06Pi701ou
        z2dHmidrztz5dnWTWfbZJ4p3Z9tekQ58cM7woTXfh/yn6s/zUh/Hyfw5MFWlVFV7/e2jU5mK
        Fxg26c7ijfn4btmemyeubI6Uj64+1Zn5e1bz65QnejWTf/aJz/m4cP9K3+nar6WCOLRi1E98
        mXJo05OihdYZvxOnn7J5sfXU8sonJvmHnj7erby7ve0K43bfs8W/lFiKMxINtZiLihMBHJva
        CzYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJXtdz9p0Ug+X3BC2uT9nManHo43J2
        i9sLPC22LpnLanHreCujxcsHG9gtNk9+xGJx89M3VovLu+awWTxasYnJgctj06pONo/3+66y
        efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfGjFWXmQreylYcvL+cpYHxqUQXIyeHhICJxLvH
        d9m7GLk4hAR2M0p0r93OCpGQklh1/R4jhC0ssfLfc6iiV4wS8z79BitiE9CWmPH3GnMXIweH
        iIC+xIMv4SA1zAKbmSRWzlvOCNHQxCSx7fRhRpAiTgFeiQn/rEF6hQVcJc417mYBsVkEVCWO
        7jvCBlLCK2Ap0XPOCiTMKyAocXLmExaQMLOAnkTbRrBzmAXkJba/ncMMcZqCxM+ny8CuERHw
        k2hpWApVIy5x9GcP8wRG4VlIJs1CmDQLyaRZSDoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0u
        zUvXS87P3cQIji0tzR2M21d90DvEyMTBeIhRgoNZSYS3h/dWihBvSmJlVWpRfnxRaU5q8SFG
        aQ4WJXFe8Re9KUIC6YklqdmpqQWpRTBZJg5OqQYmybnbmXfKBx0wTtoQX2ysfvKvPaNnVtCt
        tlfq2hXVRkwveReJRXFxKz+e+emTecn7+uT8g1subfn+y0vhvAeL44/KmtSAKcwtEtzsT1Zf
        mrjZyKPU1DVCS2Li4+xvrvztAn7Kv9gWGTMnP95oqHu3+92sXSLWUY/OT+fvcC3cE3ZSs4aP
        ZU/TLt9lQQVJbNtnh3aXi/7N2WnKNXVZsMPbhbnduu1qG3+mFnc4b655wMp+9M/dldM19s65
        mbAiata85ldb2fjDdJ9ufNi0RtI6VOeVnnzzJtMb565pHvLTOnlUz8fpZKFBaeS+WY46bte9
        HaY35R9hW9H/VOZpkm+dspKKlshBDzGzqlOrGpRYijMSDbWYi4oTAdcCERocAwAA
X-CMS-MailID: 20230816094753epcas5p1d6582dfa28b11b8b06f33b41a37122bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230724084841epcas5p16f6df46aaffb860813412d19e2e8abb5
References: <20230724084752.371245-1-sandeep.cs@samsung.com>
        <CGME20230724084841epcas5p16f6df46aaffb860813412d19e2e8abb5@epcas5p1.samsung.com>
        <20230724084752.371245-3-sandeep.cs@samsung.com>
        <np2hnhy7jcc66rsfwym42qwteqda6slszinrjqb6jg7ie4qt3e@2fllxsza544p> 
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

Hi Benjamin,

I hope this email finds you well. 
I wanted to remind you about our last email where we discussed about moving
USB validation check.
Your thoughts and input are important to us.
Please guide!

Thanks & regards
Sandeep C S

-----Original Message-----
From: sandeep.cs <sandeep.cs@samsung.com> 
Sent: 31 July 2023 16:44
To: 'Benjamin Tissoires' <bentiss@kernel.org>
Cc: 'Jiri Kosina' <jikos@kernel.org>; 'Benjamin Tissoires'
<benjamin.tissoires@redhat.com>; 'junwan.cho@samsung.com'
<junwan.cho@samsung.com>; 'jitender.s21@samsung.com'
<jitender.s21@samsung.com>; 'suhyun_.kim@samsung.com'
<suhyun_.kim@samsung.com>; 'ih0923.kim@samsung.com'
<ih0923.kim@samsung.com>; 'gaudium.lee@samsung.com'
<gaudium.lee@samsung.com>; 'linux-input@vger.kernel.org'
<linux-input@vger.kernel.org>; 'linux-kernel@vger.kernel.org'
<linux-kernel@vger.kernel.org>
Subject: RE: [HID Patchsets v1 2/2] HID: Removed USB Validation check

Hi Benjamin,

Thanks for the quick review our changes

As suggested we will refactor as below and send you an update shortly.


1. USB check validation moving to appropriate function
(samsung_kbd_mouse_input_mapping())
2. fix the checkpatch complain
3+ Split the remaining changes one per device

Clarifying for the Point 1 , below is the pseudocode:

static int samsung_kbd_mouse_input_mapping(struct hid_device *hdev,
  struct hid_input *hi, struct hid_field *field, struct hid_usage *usage,
  unsigned long **bit, int *max)
{
 + if (!hid_is_usb(hdev))
   + return 0;
    ...
}   


Thanks & Regards
Sandeep C S

-----Original Message-----
From: Benjamin Tissoires <bentiss@kernel.org>
Sent: 24 July 2023 15:40
To: sandeep.cs <sandeep.cs@samsung.com>
Cc: Jiri Kosina <jikos@kernel.org>; Benjamin Tissoires
<benjamin.tissoires@redhat.com>; junwan.cho@samsung.com;
jitender.s21@samsung.com; suhyun_.kim@samsung.com; ih0923.kim@samsung.com;
gaudium.lee@samsung.com; linux-input@vger.kernel.org;
linux-kernel@vger.kernel.org
Subject: Re: [HID Patchsets v1 2/2] HID: Removed USB Validation check

Hi Sandeep,

On Jul 24 2023, sandeep.cs wrote:
> Earlier Samsung driver only handles USB HID devices and returns an error
if it encounters a Bluetooth type of HID device.
> By removing this USB validation check, we allow the driver to handle other
types of HID devices including Bluetooth HID devices, which were previously
excluded.

Please no, not with that patch at least.

hid_is_usb() protects the kernel from making an oops if the actual transport
layer is not USB, let's say an emulated uhid device. So by removing that
check you are just allowing anybody with root access to access random memory
in the kernel.

The correct fix is to move the check where it's needed, in
samsung_kbd_mouse_input_mapping().
I'll let you decide what need should be done if it's not a USB device
there: consider the interface to be 0 or just abort the function.

Cheers,
Benjamin

> 
> This change improves driver compatibility and extends its support for a
wide range of devices.
> 
> Signed-off-by: Sandeep C S<sandeep.cs@samsung.com>
> Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
> Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
> ---
>  drivers/hid/hid-samsung.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c 
> index 33e963303d11..3cafbf4d9dc6 100644
> --- a/drivers/hid/hid-samsung.c
> +++ b/drivers/hid/hid-samsung.c
> @@ -517,9 +517,6 @@ static int samsung_probe(struct hid_device *hdev,
>  	int ret;
>  	unsigned int cmask = HID_CONNECT_DEFAULT;
>  
> -	if (!hid_is_usb(hdev))
> -		return -EINVAL;
> -
>  	ret = hid_parse(hdev);
>  	if (ret) {
>  		hid_err(hdev, "parse failed\n");
> --
> 2.25.1
> 

