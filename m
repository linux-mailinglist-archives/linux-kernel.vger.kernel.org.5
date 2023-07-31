Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CBE769694
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGaMoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjGaMoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:44:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0622E46;
        Mon, 31 Jul 2023 05:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690807440; x=1691412240; i=deller@gmx.de;
 bh=Ett9X0jsrsgrwDS6JF0aUQXmEsbC9Ju+HRz8v9VHpf0=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=KCfoDEKpfrgYNK/oeCttNkSWKYY7PISouCDVFRlWfeUVj0U3EHTLp+0tvtKrWakTzHzgiUC
 V04xVf3WZyDn3dZYvoSsWDwcs7hymV6aLnG5CjZIVprSD5VDChVQ19ejIeS+obuKRb4RUkFOh
 IYAPY4dQCZ8cFVNJK3ddjjDjP0IrLQRc/7+I0JGKrg8WlczDSS3sUIGlb6QogHHD0fr8FF6XX
 LPQvc0KeMov0zxAHPUJLn/++Vf5TMnM/vukvB7uNY8d6CFZKBVhnmXtbBw4pWZ2XwAeuDs3tq
 2v5wOkzL8m7+evpZ5rm7H7UgQd5AQaO6a/U1QN6nX3itt+/YF0UQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.238]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdiZ-1qcG6M3fm9-00EhN6; Mon, 31
 Jul 2023 14:43:59 +0200
Message-ID: <f84bbc50-2cd1-833d-7e99-e669cfc17c74@gmx.de>
Date:   Mon, 31 Jul 2023 14:43:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] fbdev: mmp: fix value check in mmphw_probe()
Content-Language: en-US
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lisa Du <cldu@marvell.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230727170318.18412-1-ruc_gongyuanjun@163.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230727170318.18412-1-ruc_gongyuanjun@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EWktxHK2pXb/uzLePyiOujXAmpX7rdBW66Gt7Ig1/sEBnAwiEvx
 bzjDu49BhucQSZWleC2XQNoASGz1/grBLsB7TZqQ2kxKe/X5or1owGDTQGQmfikpK2dkqMC
 FRf0YIsZpY1fnwk3R8t13t9wFZYXD2g/bD8vkd86e6Yz2zvAjIzTzx6cqvwUpnPCTFYpQRi
 8VH4A7V541z4uVYdAHJTg==
UI-OutboundReport: notjunk:1;M01:P0:juz6mdP1klo=;LOJz6O8knWygtmqjGiIEI6XwyS1
 vi/+iNVpY57sgRndt7MHyb4s5I5O1MhTHRFvlchhO0LgVeav7bWsSHRXA+Gmc5lyog5MTf5Uo
 Ow4/G7POV3BL1jVSyJyCPOxJQ6PPyOUH8r1TiOIQE21GRy6D4uQC2egTrzbM27WVgAONBHY+q
 cbx762NkSJVn2kLA9FgVEHk19+rhXa8C8VBQVWaXI4xx1vqJS+lAU3GG15ZMsHIXNl8yk7Z7c
 3mHHiDTpI5vhW7Hpy1SvhUwPchS/vC3iAbniWP1uhd63ifuRIQDMjqOmjvo/9u5uX2QREwhTI
 mYeEzTjjn28NyVQsERmoZUFrkdhiNanmHa/ymvBeSw5lO2bhb5pJ7xqXSyni8VREayvR/Xv1a
 kbKACL8G7RMl6/Q/ymc4Z164eG1S2+8dpIkSgW4haMep1zSAtS3RvalxaN96zRrzWHthFi25N
 gRcGylWWL8vC257jnDajrGCfSVckN9UDgG8NNuvejJUFibbEm0WxMx5g+oEKFJRIH+j+2YqcP
 5xJj55n6epFIQmOCSgPKJY2Y0I2yIIazpMKvSRMzafGIEjROLeHHe28dw5i4UkwhVXSTuFl8L
 CS8X8tGeR0379mDqNM3/R1oMFKGA3JbyC4bfquDSY12dE0Uj5eoDBf+z+ZkJ6r0Dd3NfbfDQT
 5beTjO2kfoqGPCnJuEFIo0yoO6KEC4bX6/iuMfAJqYOJULwA4FRkL2AY1rAIJIM4ZgrGDW7hy
 rd/nN2LLnQu1grTvUnkwEQyEqtWHWfAHkJ8u9T8Lhxza5FZe9MpF0C7i503rmI8UuzpxdmYEM
 4ddCwY02xJ+q5ieJEIOXdB223saFD26KbRlB3NbHdelzjCpNWBH+/xzryKFo3ZG5c24pOz8SI
 6ctMYWNxUQoOd8Ttqo0ka58vugJ3RGycf6XA8nrVJiHrXXrdprS+p6UCjSUQrv1QzaelH2pBu
 SmGG9umZhcxtzvi0YifIbpQu2FQ=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 19:03, Yuanjun Gong wrote:
> in mmphw_probe(), check the return value of clk_prepare_enable()
> and return the error code if clk_prepare_enable() returns an
> unexpected value.
>
> Fixes: d63028c38905 ("video: mmp display controller support")
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>

applied.
Thanks!
Helge

> ---
>   drivers/video/fbdev/mmp/hw/mmp_ctrl.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev=
/mmp/hw/mmp_ctrl.c
> index 51fbf02a0343..76b50b6c98ad 100644
> --- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
> +++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
> @@ -519,7 +519,9 @@ static int mmphw_probe(struct platform_device *pdev)
>   			      "unable to get clk %s\n", mi->clk_name);
>   		goto failed;
>   	}
> -	clk_prepare_enable(ctrl->clk);
> +	ret =3D clk_prepare_enable(ctrl->clk);
> +	if (ret)
> +		goto failed;
>
>   	/* init global regs */
>   	ctrl_set_default(ctrl);

