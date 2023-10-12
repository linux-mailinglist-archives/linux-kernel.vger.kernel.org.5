Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0BB7C6B59
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377879AbjJLKmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbjJLKm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:42:29 -0400
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E9F90
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:42:27 -0700 (PDT)
X-KPN-MessageId: 07d0f0e1-68ec-11ee-91e6-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 07d0f0e1-68ec-11ee-91e6-005056994fde;
        Thu, 12 Oct 2023 12:42:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=xJ2VZjbyRRo/9Xc9+PzqHozw9ZgL0m4qDsRrGQFquIM=;
        b=afU9gTeEjgwKRZdV2qISx9oU6BI6/N4/ud23NoQAPH+8UVZOkVtC/TN06IPksstQK7F+LC+xJVYI2
         O6RrNgrzF6S91nQJbezf83/fw1SQnj3IQsfB6OgPhl7c8VHHG+rTIZa/GJriZKlEqdm8yXwa57k8Bp
         EX19ctbLG86IaHBhMFjoJQv7J7zVQtvcTbb/1GFdfHPaHUNj631FjY/i4BOOw8wwyjWF+AKJcGYk/r
         9CFRjPoUMsVY/coyAKNb5rL8cQ4stRbqInsu6P2R5kXuuP9O/nv9Ma0djrCa+OEpYCuV2DsHw3C13v
         vntAVbCjy2r28gCfoCFvV8R09fSGCLg==
X-KPN-MID: 33|3aLzn2ZM7BUaBuoHlspM8oOZDFyTq5riljZ1CiqDVCYnzPCR+V1NL8YQZwJMU7y
 MwTFc1IkLaJRPrwCn0vOhd0maKj6Qfkq5J7zgfHB3NF4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|bhQQ12pbBiL8NqqBsbTz5Zd1i9m1lZqVCs8MlDlVYzWjFXn+wKGL7yFVpnUvtmM
 zXtsD3u9M7Mjj22Cl5Qcwbw==
X-Originating-IP: 173.38.220.40
Received: from [10.47.78.242] (unknown [173.38.220.40])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 07521cae-68ec-11ee-ad2d-005056998788;
        Thu, 12 Oct 2023 12:42:24 +0200 (CEST)
Message-ID: <788e7ae5-1560-4f6f-b6b8-930ce6a9cedb@xs4all.nl>
Date:   Thu, 12 Oct 2023 12:42:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: cec: meson: always include meson sub-directory in
 Makefile
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>
References: <CGME20231012103531eucas1p1f370bddcb690aa421498e961f4081f2b@eucas1p1.samsung.com>
 <20231012103525.3381314-1-m.szyprowski@samsung.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231012103525.3381314-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 12:35, Marek Szyprowski wrote:
> 'meson' directory contains two separate drivers, so it should be added
> to Makefile compilation hierarchy unconditionally, because otherwise the
> meson-ao-cec-g12a won't be compiled if meson-ao-cec is not selected.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Does this need a Fixes tag?

Regards,

	Hans

> ---
>  drivers/media/cec/platform/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/cec/platform/Makefile b/drivers/media/cec/platform/Makefile
> index 26d2bc778394..a51e98ab4958 100644
> --- a/drivers/media/cec/platform/Makefile
> +++ b/drivers/media/cec/platform/Makefile
> @@ -6,7 +6,7 @@
>  # Please keep it in alphabetic order
>  obj-$(CONFIG_CEC_CROS_EC) += cros-ec/
>  obj-$(CONFIG_CEC_GPIO) += cec-gpio/
> -obj-$(CONFIG_CEC_MESON_AO) += meson/
> +obj-y += meson/
>  obj-$(CONFIG_CEC_SAMSUNG_S5P) += s5p/
>  obj-$(CONFIG_CEC_SECO) += seco/
>  obj-$(CONFIG_CEC_STI) += sti/

