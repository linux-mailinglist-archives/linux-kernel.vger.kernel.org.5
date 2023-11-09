Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B047E68A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjKIKsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjKIKsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:48:05 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7D22696
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:48:02 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231109104800euoutp0220b9f16c220627d1400a0c229034e65a~V7rFoqlkG0630506305euoutp02h
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:48:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231109104800euoutp0220b9f16c220627d1400a0c229034e65a~V7rFoqlkG0630506305euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699526880;
        bh=QcnjUhE7gQh9uk1LcSTbnLaNbz1wrxJZ4+wU5MZqD8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ExkYYcDYvuHdp6Aad51IPovmv4L2u1Akmb2HkMgnPCqvXEr9oXduarSm6NrTMxmnw
         WtdiTN7lwVjYYu2nK7plWcqDH6GQsMfYZjO06g3nmxDteJJrs/lvlhIeGmu/rmt/+W
         BCUc8gtvxnFpWkBco+05qtWw/L5FV4xx9QpGPFvU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231109104759eucas1p282a28328a01f006406aa886cea0a1a64~V7rFVxEFM2949229492eucas1p2A;
        Thu,  9 Nov 2023 10:47:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1D.5C.52736.FD8BC456; Thu,  9
        Nov 2023 10:47:59 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231109104759eucas1p1fc7343ea2b113abd18397833d70d6835~V7rFASj-y0650306503eucas1p1l;
        Thu,  9 Nov 2023 10:47:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231109104759eusmtrp2b1027aedbee6ab30b51ab2f2965689b2~V7rE-ekS82298322983eusmtrp22;
        Thu,  9 Nov 2023 10:47:59 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000ce00-1e-654cb8df7e7f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 78.13.10549.FD8BC456; Thu,  9
        Nov 2023 10:47:59 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231109104758eusmtip2560d51f8a9c5f8edb255037d50d620b8~V7rEbZZIu1346813468eusmtip2k;
        Thu,  9 Nov 2023 10:47:58 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] pwm: Clarify PWMF_* enums definition
Date:   Thu,  9 Nov 2023 11:47:48 +0100
Message-Id: <20231109104748.2746839-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109104748.2746839-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djPc7r3d/ikGvxZp2fxYN42Nou9r7ey
        W2x6fI3V4vKuOWwWd++uYrSYcX4fk8XaI3fZLX7umsdicXviZEYHTo+ds+6ye9y5tofNY/OS
        eo/+vwYefVtWMXp83iQXwBbFZZOSmpNZllqkb5fAlTFjVj9TwQO2imf3n7A2MG5l7WLk5JAQ
        MJG4d7SDpYuRi0NIYAWjRMvNF8wQzhdGiVmf9zKCVAkJfGaU6L8sB9Ox6c8ddoii5YwSP+Y+
        YoHr2Pz/MTNIFZuAoUTX2y42kISIQBujRNPlD2AOs0Azk0TT726w7cIClhITjlwE62ARUJWY
        Nb+bDcTmFbCXWLDjEhvEPnmJ/QfPgtVwCjhIXG15xQpRIyhxcuYTFhCbGaimeetssMMlBE5w
        SLxddp0dotlFYt33LcwQtrDEq+NboOIyEv93zmeCaGhnlFjw+z6UM4FRouH5LUaIKmuJO+d+
        AZ3BAbRCU2L9Ln2IsKPEtivzWEDCEgJ8EjfeCkIcwScxadt0Zogwr0RHmxBEtZrErOPr4NYe
        vHAJ6hwPiX2H5rJNYFScheSdWUjemYWwdwEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS95Pzc
        TYzAVHT63/GvOxhXvPqod4iRiYPxEKMEB7OSCO8FE59UId6UxMqq1KL8+KLSnNTiQ4zSHCxK
        4ryqKfKpQgLpiSWp2ampBalFMFkmDk6pBib2GGXtRd5mL5QfZtS4acRdttrVFRjm9ynj1aSw
        1W28m5Y0iovmtsWHZNyeXdpieebJBt9ZKn/WX1N/prU/WG572PwuhWW69/PeTI7huFIazv/q
        Y6L630cc3w/Pk+I4bM00Jf2v0bGYDSpdDhV/ZP6vcHYsPmHMbKx5WVHnr/81hrM53T9+sDC7
        nvHOXG13bK6MebF7pOqa7heOB2MumWpF9Xzcu7Ry02Pz7jlSdz6Xec3JnfSm+tH22ikVruEH
        O9fXzXF6bV7ExSyR9erV22+d7+PNZ8tV7GcosePLVj8ge1QxLSKR3axFJfGj/9N5QilzDq3Q
        /WV0cFnbZv5fFuedH2uf114VdPVdT0BUnRJLcUaioRZzUXEiAJtvCBe0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42I5/e/4Pd37O3xSDTafFLd4MG8bm8Xe11vZ
        LTY9vsZqcXnXHDaLu3dXMVrMOL+PyWLtkbvsFj93zWOxuD1xMqMDp8fOWXfZPe5c28PmsXlJ
        vUf/XwOPvi2rGD0+b5ILYIvSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
        s0lJzcksSy3St0vQy5gxq5+p4AFbxbP7T1gbGLeydjFyckgImEhs+nOHvYuRi0NIYCmjxO+Z
        x9ggEjISJ6c1QBUJS/y51sUGUfSJUeJvy0VmkASbgKFE11uIhIhAF1D3sbWMIA6zQCuTRMOJ
        VSwgVcIClhITjkB0sAioSsya3w22glfAXmLBjktQ6+Ql9h88C1bDKeAgcbXlFdBqDqB19hJ9
        u3MhygUlTs58AjaSGai8eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltsqFecmFtcmpeul5yf
        u4kRGDHbjv3cvINx3quPeocYmTgYDzFKcDArifBeMPFJFeJNSaysSi3Kjy8qzUktPsRoCnT2
        RGYp0eR8YMzmlcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUweRUJ
        Hzr1+MDJxMtbL7j1717zSPxsf5GxglLepbKQrdF32INda3W4eftc9oRfM5L5k15i3h1zYc7W
        ufYT5jXzmPr93Xp/VbLh2n8XJ2iVfksvP8Rj/X49g/Si7d7dic23dvJGWuRZRKzq9Oe12WrT
        7GVjYRXLszTM51jsiQO+NzL1bGU2OKfPsLGOeiOa/uHK/Uqv2HWbTmV/YsgyvGNm8TbaTehW
        1+F5G7WW5Zg0XPqct9n9VJHW4tjJcWuTbFbnq7NO1WFJ2y2eE15y6vKtHTN/i51apvX5xcGz
        J3sNTKOervmz6Vv1Jq9nDI3ZsyadWX43dI71QgH77QyaZ8uudgs7MWznOnhX7/Ka/IPTlViK
        MxINtZiLihMB4i5jEyEDAAA=
X-CMS-MailID: 20231109104759eucas1p1fc7343ea2b113abd18397833d70d6835
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231109104759eucas1p1fc7343ea2b113abd18397833d70d6835
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231109104759eucas1p1fc7343ea2b113abd18397833d70d6835
References: <20231109104748.2746839-1-m.szyprowski@samsung.com>
        <CGME20231109104759eucas1p1fc7343ea2b113abd18397833d70d6835@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PWMF_* enums are defined as flag values (like 1 << n), but then in the
code they are used as bit numbers via set/test/clear_bit() macros. Change
their values to sequential numbers to clearly show that they are bit
numbers, not the flag values.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/pwm.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e3b437587b32..95c895c63cf6 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -40,9 +40,12 @@ struct pwm_args {
 	enum pwm_polarity polarity;
 };
 
-enum {
-	PWMF_REQUESTED = 1 << 0,
-	PWMF_EXPORTED = 1 << 1,
+/**
+ * enum pwm_flags_bits - status bits for pwm->flags entry
+ */
+enum pwm_flags_bits {
+	PWMF_REQUESTED = 0,
+	PWMF_EXPORTED = 1,
 };
 
 /*
-- 
2.34.1

