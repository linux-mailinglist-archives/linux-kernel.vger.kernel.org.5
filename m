Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E0E75EE44
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjGXIsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjGXIsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:48:40 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6898FE41
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:48:35 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230724084832epoutp0434e49c7a6ef94fc9a8770e7c2b4d9f4d~0wX9ZZnKK1679216792epoutp04x
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:48:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230724084832epoutp0434e49c7a6ef94fc9a8770e7c2b4d9f4d~0wX9ZZnKK1679216792epoutp04x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690188512;
        bh=qmxs6s2hs7m+YF3D3FlFwqmooYr2H1szpp1txKX+OH8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=WK0RVtmT+uZrvnWr9rCFUxwyTmx4ZaxlsxkHyde4MgCKxZGjqmkUFMAhrkwpgTLua
         DAG18OFuM6vXj/NSZPrZfiiju9wb78s0MLKco43h0wE+PPi6UMK/eYzkJwxyDnSgiP
         VBMMjdgZRo6aocWyQFuWIV3Nyhymv6GL+9iJlqcs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230724084832epcas5p3e2b9b28d5fd86ac5f911f88684673164~0wX8rx6Ev1773117731epcas5p3I;
        Mon, 24 Jul 2023 08:48:32 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4R8Yj975Knz4x9Q1; Mon, 24 Jul
        2023 08:48:29 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.99.55522.DDA3EB46; Mon, 24 Jul 2023 17:48:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230724084829epcas5p1686507367b11db0ff5d17c3e6cb1ff7c~0wX6PzXHV2341023410epcas5p1a;
        Mon, 24 Jul 2023 08:48:29 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230724084829epsmtrp1886f1e6e97cf7b03c55ad33af8c2a5e6~0wX6PEnz12812828128epsmtrp1K;
        Mon, 24 Jul 2023 08:48:29 +0000 (GMT)
X-AuditID: b6c32a49-67ffa7000000d8e2-b1-64be3add6ede
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.47.64355.DDA3EB46; Mon, 24 Jul 2023 17:48:29 +0900 (KST)
Received: from ws2030077039.sa.corp.samsungelectronics.net (unknown
        [107.99.235.14]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230724084827epsmtip156068066ca8787e72553b4e845a80a08~0wX4t2hzj2887728877epsmtip1t;
        Mon, 24 Jul 2023 08:48:27 +0000 (GMT)
From:   "sandeep.cs" <sandeep.cs@samsung.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     junwan.cho@samsung.com, jitender.s21@samsung.com,
        suhyun_.kim@samsung.com, ih0923.kim@samsung.com,
        gaudium.lee@samsung.com, sandeep.cs@samsung.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [HID Patchsets v1 0/2] HID Patchsets for Samsung driver
Date:   Mon, 24 Jul 2023 14:17:49 +0530
Message-Id: <20230724084752.371245-1-sandeep.cs@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTS/eu1b4UgyWzLCyuT9nManF7gafF
        1iVzWS1uHW9ltHj5YAO7xebJj1gsbn76xmpxedccNov22c8YLR6t2MTkwOWxaVUnm8f7fVfZ
        PPq2rGL0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
        xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
        aomVoYGBkSlQYUJ2xvvmG0wF73kqVr86xd7AuIqri5GTQ0LARKL90XT2LkYuDiGB3YwS9ydd
        YIFwPjFK7PtwkxXOaTm1gA2mpffJZ1YQW0hgJ6PEh4M1EEWdTBL7LnxhB0mwCWhLzPh7jRnE
        FhGIkHi3YBMjSBGzwHVGiecz5jB1MXJwCAs4SFxeqwJSwyKgKjHzzFGwel4BG4l9h5dDLZOX
        mHnpOztEXFDi5MwnLCA2M1C8eetsZpCZEgK32CVm7f7MDNHgIrF98yt2CFtY4tXxLVC2lMTL
        /jZ2iIZuRomlt49BOTOAftt5FarbXuLn6wlsINcxC2hKrN+lD7GNT6L39xOwoyUEeCU62oQg
        qlUknnbtZoWZ//3ERiYI20Pi4Z0WaAjFAtnbGCcwys1C8sMsJD/MQli2gJF5FaNkakFxbnpq
        sWmBYV5qOTw2k/NzNzGC06KW5w7Guw8+6B1iZOJgPMQowcGsJMKbnr4rRYg3JbGyKrUoP76o
        NCe1+BCjKTBgJzJLiSbnAxNzXkm8oYmlgYmZmZmJpbGZoZI47+vWuSlCAumJJanZqakFqUUw
        fUwcnFINTB7Fv/m4AnN5pQRjdofv0t+j9ubg/CkliyX/yFhO8j/sqMLG8W9ZQc7DybVbq1Ye
        cdmlZ++1cdvkZYwpX/LFa6pKvuaKMiSWs3ktUD2nvn7L4mLzv8HSHJIBbhLODtxJ6y7+vFf6
        wszJxXm7+Z/4m/ceTWbvXfHtj2fNh4VT4w78P2ivWWxbzN8uMcPCclbf7FUFN/d6PnJskZ38
        M8/X48RH9x0XFy+1Z//QYx590KjIY9E7Vj3TuoCFCcn1u7camB0RypvLJl11u/juS9Ulxyou
        cMbaiHdyHmu59bo5MWzir29ijxaUO/T1VeUYlAfzMijuOlVS0PuurXGCpp7BYo4J1U9jfNlt
        mNyXqh9WYinOSDTUYi4qTgQAo1TfGhQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSnO5dq30pBg82S1pcn7KZ1eL2Ak+L
        rUvmslrcOt7KaPHywQZ2i82TH7FY3Pz0jdXi8q45bBbts58xWjxasYnJgctj06pONo/3+66y
        efRtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfG++YbTAXveSpWvzrF3sC4iquLkZNDQsBEovfJ
        Z1YQW0hgO6PE9EsVEHEpiVXX7zFC2MISK/89Z+9i5AKqaWeSmPL7DwtIgk1AW2LG32vMILaI
        QITEtH9rwRqYBe4zSpxcadTFyMEhLOAgcXmtCkiYRUBVYuaZo2DlvAI2EvsOL2eDmC8vMfPS
        d3aIuKDEyZlPWCDGyEs0b53NPIGRbxaS1CwkqQWMTKsYRVMLinPTc5MLDPWKE3OLS/PS9ZLz
        czcxgoNVK2gH47L1f/UOMTJxMB5ilOBgVhLhTU/flSLEm5JYWZValB9fVJqTWnyIUZqDRUmc
        VzmnM0VIID2xJDU7NbUgtQgmy8TBKdXAVJ6z7mOUmPmF9Rul1y3Ym/uE5anLiSULWti/fUzf
        brx046cbdn6MooyS2mfb+UJrvjYs/iEvvp9vj4XLa9/ZX779vS5158ebc5obt1xbtnASb9Ok
        W1HKfcle9ic9Q6U//+jfo/tfNWEHz6GUN/u28b57Oi1lemTgLuEG6+3fmPaVr+NorV1ce4Ap
        JmNS/Z5kji9vnjPbBO/6eL7/Vfo8Nge/q9vMZiw/n2mWx3/yqkez6qFjK1U5UwQNtZkWCWck
        PL+/LCNfbs0aAdWFMfciPPbPOx8myO6WnXDnrfyHvM7LSbnms+9s23SskOnSqaDdi80FPSfl
        iAc8XlcnciwzK7+hJP+Y9tFT3qvq393eqKDEUpyRaKjFXFScCAA1WspmxQIAAA==
X-CMS-MailID: 20230724084829epcas5p1686507367b11db0ff5d17c3e6cb1ff7c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230724084829epcas5p1686507367b11db0ff5d17c3e6cb1ff7c
References: <CGME20230724084829epcas5p1686507367b11db0ff5d17c3e6cb1ff7c@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I hope this email finds you well. I am writing to submit a series of two patches for review and consideration.

As of today, Opensource kernel Samsung driver only supports USB HID devices and do not have support for Bluetooth HID devices. 
Samsung would like to improve the samsung driver and extend it's support for bluetooth devices as well.


Patch Series Overview:

--------------------------------------

[Patch 1/2]

Added Support for Samsung Bluetooth devices like

Samsung wireless Keyboard
Samsung wireless GamePad
Samsung Wireless Action Mouse
Samsung Wireless Book Cover
Samsung Wireless Universal Keyboard
Samsung Wireless HOGP Keyboard

And also added Special key processing on each of the devices in Samsung driver.

[Patch 2/2]

Earlier Samsung driver only handles USB HID devices and returns an error if it encounters a different type of HID device.
By removing this USB validation check, we allow the driver to handle other types of HID devices, including Bluetooth HID devices, which were previously excluded.
This change improves driver compatibility and extends its support for a wide range of devices.


All these changes have been verified and tested thoroughly in android devices.

Please accept our changes.


Thanks for your time and consideration

Best regards
Sandeep C S



sandeep.cs (2):
  HID: Add support for Samsung Bluetooth hid devices
  HID: Removed USB Validation check

 drivers/hid/hid-ids.h     |   8 +
 drivers/hid/hid-samsung.c | 415 +++++++++++++++++++++++++++++++++++---
 2 files changed, 399 insertions(+), 24 deletions(-)

-- 
2.25.1

