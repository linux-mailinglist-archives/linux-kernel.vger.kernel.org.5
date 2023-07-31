Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAF8769462
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjGaLNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjGaLNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:13:50 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C951E6C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:13:47 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230731111345epoutp049a99f407dcd0f54eb019d50dd99ab57d~273vWgj5Q3079430794epoutp04M
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:13:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230731111345epoutp049a99f407dcd0f54eb019d50dd99ab57d~273vWgj5Q3079430794epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690802025;
        bh=DGdRXpjTnE71s7pZXQA2exuWrFhvwMt1YPxynJKVGvk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=lVHtgMxW6dvUhaHCNgJNYGj3OmJs1t7pCRkLnZQ9hUX0mFseMwNTkm4Q+YYG/1bHB
         SZkIxYaonu53BN+hTu7vcuEt6p11BBvwxxVyvCPdUBnIBMb8kzmGeKHFOjZIIHJ4UW
         Xaytjq2IRiNaYT08v8g54ab5bVLyqVS17dTRfmOw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230731111344epcas5p170f0d193842c8509ab4a5282f52e9114~273u2uTlb2954329543epcas5p1r;
        Mon, 31 Jul 2023 11:13:44 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RDwbW2dzqz4x9Pp; Mon, 31 Jul
        2023 11:13:43 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.5E.06099.76797C46; Mon, 31 Jul 2023 20:13:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230731111342epcas5p319bc3a811ec63cd5e15abedea8dd21b4~273s-JmA11690716907epcas5p3b;
        Mon, 31 Jul 2023 11:13:42 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230731111342epsmtrp117a13360c0e4c5aec4f299b120ac37f8~273s_aXWU3034030340epsmtrp1F;
        Mon, 31 Jul 2023 11:13:42 +0000 (GMT)
X-AuditID: b6c32a4b-cafff700000017d3-0a-64c797678f31
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.34.14748.66797C46; Mon, 31 Jul 2023 20:13:42 +0900 (KST)
Received: from SRIB7IJ5F5BM8F (unknown [107.110.56.61]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230731111341epsmtip14a86a4a54686b46dadd65868f54a41e7~273rZmz841950719507epsmtip1A;
        Mon, 31 Jul 2023 11:13:40 +0000 (GMT)
From:   "sandeep.cs" <sandeep.cs@samsung.com>
To:     "'Benjamin Tissoires'" <bentiss@kernel.org>
Cc:     "'Jiri Kosina'" <jikos@kernel.org>,
        "'Benjamin Tissoires'" <benjamin.tissoires@redhat.com>,
        <junwan.cho@samsung.com>, <jitender.s21@samsung.com>,
        <suhyun_.kim@samsung.com>, <ih0923.kim@samsung.com>,
        <gaudium.lee@samsung.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <np2hnhy7jcc66rsfwym42qwteqda6slszinrjqb6jg7ie4qt3e@2fllxsza544p>
Subject: RE: [HID Patchsets v1 2/2] HID: Removed USB Validation check
Date:   Mon, 31 Jul 2023 16:43:39 +0530
Message-ID: <03aa01d9c3a0$109675e0$31c361a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIv11ZZQG/ebQ7+/qFwV1CefhF2UgFzzcNNAtOIyhABk5RVyK74uX1A
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmpm769OMpBtcnClhcn7KZ1eLQx+Xs
        FrcXeFpsXTKX1eLW8VZGi5cPNrBbbJ78iMXi5qdvrBaXd81hs3i0YhOTA5fHplWdbB7v911l
        8+jbsorR4/MmuQCWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFsl
        F58AXbfMHKB7lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5
        qSVWhgYGRqZAhQnZGevub2Ep2CpW0TnpGHMD4xKhLkYODgkBE4kb11y6GLk4hAR2M0psaXnE
        2MXICeR8YpR40skIkfjGKDF15X6wBEjD72sfmCASexkl2r8cZoFw3jBKfHr6ixmkik1AW2LG
        32vMICtEBPQlHnwJB6lhFljNJHH0yAewSZwCfhIz+xazgNjCAq4S5xp3g9ksAqoSyxetZwOx
        eQUsJb4uWMcOYQtKnJz5BKyGWUBeYvvbOcwQFylI/Hy6jBXEFhFwk7i/+zNUjbjE0Z89zCCL
        JQRWckj0rn7OAtHgIrH3+wE2CFtY4tXxLewQtpTEy/42doiGbkaJpbePQTkzGCVadl6FWmcv
        8fP1BDaQ15gFNCXW79KH2MYn0fv7CRMkUHklOtqEIKpVJJ527WaFmf/9xEaoEg+JiXf8JzAq
        zkLy2iwkr81C8sIshF0LGFlWMUqmFhTnpqcWmxYY56WWw+M7OT93EyM4tWp572B89OCD3iFG
        Jg7GQ4wSHMxKIrynAg6lCPGmJFZWpRblxxeV5qQWH2I0BYb3RGYp0eR8YHLPK4k3NLE0MDEz
        MzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qBaZX0Z3nnxQx7uu5c52eteWrt8rta
        qcZ84TOFlg1vvuRwJ79PvLs68slVXW/lVTK3wp/9fP48L9/n0163oISEvMdVNdXvol4wOa3e
        cX99xomKz2e/7P646/kjjwcmm1R3Jq89v2v+Dp5Hzv56rpO2RF+WPHtBoWb3rHjPnzYhE94k
        5WXlbw94cCBALdY6/uhPtvKcBcHvv7+y6Jus2tL067vqX42Jb/lep07dUVd6M6nNe6Z6W8DW
        zVGV4X6bdj34c8V1ctn8zDR1Ru7D26RWTza30Z4y4UZK/lde5kfyauFT9T3F9CZOYI/6WHHi
        8a7jXA03zmz9dvyj7+/EiEgv9fzJJXx90/0mzY8Wt8oOWKPEUpyRaKjFXFScCAAjNqZCNgQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJTjdt+vEUg01H1S2uT9nManHo43J2
        i9sLPC22LpnLanHreCujxcsHG9gtNk9+xGJx89M3VovLu+awWTxasYnJgctj06pONo/3+66y
        efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfGuvtbWAq2ilV0TjrG3MC4RKiLkZNDQsBE4ve1
        D0xdjFwcQgK7GSX+v5zODJGQklh1/R4jhC0ssfLfc3aIoleMEqvnfWQBSbAJaEvM+HsNqIGD
        Q0RAX+LBl3CQGmaBzUwSK+ctZ4RoaGSSuHrxJCtIA6eAn8TMvsVgzcICrhLnGneD2SwCqhLL
        F61nA7F5BSwlvi5Yxw5hC0qcnPmEBWQBs4CeRNtGsIOYBeQltr+dA3WogsTPp8vAxosIuEnc
        3/2ZBaJGXOLozx7mCYzCs5BMmoUwaRaSSbOQdCxgZFnFKJlaUJybnptsWGCYl1quV5yYW1ya
        l66XnJ+7iREcX1oaOxjvzf+nd4iRiYPxEKMEB7OSCO+pgEMpQrwpiZVVqUX58UWlOanFhxil
        OViUxHkNZ8xOERJITyxJzU5NLUgtgskycXBKNTAdSmasPs56xTvz0an8kIUin7u5zjz0tWJ0
        XryUcXrsff5GrW1iG1fOvVK54GZUtXuWt2Tl0iSmL3ZsahG3d3yLcbo9Wzl87tpNi6R26KqL
        uO+9KsWe2Sum+bn/3cewgJDFxxyPpn1hs77SJqL6lCky1nnt7qdHbi7dtnGnUmH8k0+zN247
        pnZo0xbz2z/a5llozVYKe++slhaz22jmls07fXZKWTK0eed4tbm85PLovhAsoLnCgvOH20z/
        j4wRhVeepLip60/691hplcDzPE+T6ScrrdXOdZnp+SiJvgl8adz6x+6qfsLCo9NkXxrVT9oY
        /SLZace1U7s7NR2qmM9lr59U2X0q9Of5mV1bD8kqsRRnJBpqMRcVJwIAnMoYKB4DAAA=
X-CMS-MailID: 20230731111342epcas5p319bc3a811ec63cd5e15abedea8dd21b4
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
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

