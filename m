Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6817D7E0813
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbjKCS0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjKCS0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:26:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFFADB;
        Fri,  3 Nov 2023 11:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699035937; x=1699640737; i=w_armin@gmx.de;
        bh=hiCnCOOKWqIILjoanAScpgqs9mhmW2+u8CmTFsuuU28=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=coOIzkaskke9x2oOgAc4ojEArjK4zBTvrYLpVRlaVmBogTuiDw3K4kMW6blb45gR
         LfCnZ0WLVQIUA72FiS/cnw/P/BOtggQMEFj8lVL4VIRL+DG7mD4Mezhx7UALcw2T5
         fbemK1if9hdkuffXn/2LK9yJfgo+5UJ5JpeJsuRgVAUPxzuGAnWCh/z5BdPn8AnyT
         hbtP7w/prFWynPRuxAKxcgOEAY+vtQTPPZGS3zUKWjVMcbovdJrWc630vecvOSoQ2
         oi+xFFpEY3alCXfMhzQ1OpC+ifX+6jbrlYgwevFausjv9usRBtzEDiDw9Dl9QJiMQ
         9kTEHcmfN/3FHffFdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MRTNF-1qkSge0r6D-00NTe3; Fri, 03 Nov 2023 19:25:37 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jithu.joseph@intel.com, hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] platform/x86: wmi: Add to_wmi_device() helper macro
Date:   Fri,  3 Nov 2023 19:25:24 +0100
Message-Id: <20231103182526.3524-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103182526.3524-1-W_Armin@gmx.de>
References: <20231103182526.3524-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0S7BbTpeJT+4D3IwH/pRnPOjucHCYPH7RioZYdCtRxfEMPTGfhL
 NTg7O1A1UYY55pTlA5fXWLPE1jA+pMKTr/4GYWCmlxaxvfbyD14EBh2F7/JbcG1LCdAPtm1
 2n85OZlO/MFqk4f3RkK/S/VFml89lDCUcNTps0h0CJ2/yAwQ1rF6cPvgKcNmCczrCG7zyfK
 k+0Dk72aggCHZzLzMEY0g==
UI-OutboundReport: notjunk:1;M01:P0:Wu5YK0gbzBk=;KtHcJ2UYtV1bxLFTY5euXSbs/aV
 0M2DXBDjG89ALay+PagTJhggeKsAF9WyRKL8yQZ/13AKNOvixD+lnNF/TEulTqU5/D9votmJc
 R66PvgBw1onQtGXOsLusgxVuYC5/q3IhBrEgZcRKdPwfBmuYrZIodhJNGTBcNCyRx3VSooLnp
 4Rin2qba8F+8gxtF+D7Pc0R64bjgEuGm5cg9cnwLGeObXvQVgg6P35Q9EfN0M95d1mLMam6BI
 6pgAPdxosrdjueCyR5UiHwzqCg5/+Aa3CWgCuL3AMIbF7wR9Vb8EDryWmH2P0crHiGlRU3DOx
 rzsDWhsHyOHuMS7+Gp0AbossLPdnZbyyeli8S8upQurGaw3xbLj0efluGrHhRfckIdFGa4zHv
 aj3HeZ8+U85P3mssUjnz24L3IEB3LW2jc9kXcW6XM2EBa7se0cWbF1kxMVYgb9SmTNz5sT1er
 se9zimfqptibOzHEWSzZAvRqoR/aKgKyV11GRvsFAajQ5QbFJKorEyavPoSW+DEJtzbO3M8W0
 rzoHVyKyGQoVO6i6E4EwziqpsGVTDTTBIDqSFCGFeOOvyz5h33a/uUV8w56jp4QckasSuK4Rd
 mSHgZNON3kFpE0E+VmYvDPiO0g8o75reiO2UEhSxb8zHRolJIjECSQwexsKyynLYWW2lPWsOr
 tw8jlH4iAknbxlXmw+i8VFBg5NCQsBSaPtKKB2QL42FXpHeJoaiOQBtlqkDM+5JxAXp/rurSy
 +652ouP/YHcqGJnxQy1DVA/xwxsQSXDbDdQvX/BLAzJX5Co8Thye9Opp0K9IPtSWNENjGt2VC
 JPJc+G7Te9Rx7YlFI0hr146s3trsbFY60TyNq9MqFH0lfl0luCpemcRjYt/+FUbhQwuFGg4A3
 pLPum3QXyayhHhZTWR30I1rsd+OhIWstfdTlgAJqNzP1w9V1dKLDbzeFrP/xQtY3fDdftGsNC
 5/Trmkr2yqEfUE5Uqk961U/dwho=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper macro for WMI drivers to cast a device to
the corresponding WMI device. This should replace some
boilerplate code.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 include/linux/wmi.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 207544968268..8a643c39fcce 100644
=2D-- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -27,6 +27,14 @@ struct wmi_device {
 	bool setable;
 };

+/**
+ * to_wmi_device() - Helper macro to cast a device to a wmi_device
+ * @device: device struct
+ *
+ * Cast a struct device to a struct wmi_device.
+ */
+#define to_wmi_device(device)	container_of(device, struct wmi_device, dev=
)
+
 extern acpi_status wmidev_evaluate_method(struct wmi_device *wdev,
 					  u8 instance, u32 method_id,
 					  const struct acpi_buffer *in,
=2D-
2.39.2

