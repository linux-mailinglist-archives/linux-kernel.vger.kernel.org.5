Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069957EB6E7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjKNTdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNTdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:33:18 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A172107;
        Tue, 14 Nov 2023 11:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1699990367; x=1700595167; i=wahrenst@gmx.net;
        bh=0l/qJoqBf6nReycMlif7uqnkpKDrwiJccsu4IcAzFIg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=uiDtIorLWt9MeDK9i9FBqPtdEr9rpszNS1jcd8TUfMLZjPjZ6DXZjlZYhboPzZ5Y
         klANs8AUmTqd7H5qGz7bdP307sW8LmtHyRAwVgnfVEcas2NYCbI4gpdjOczEfVzas
         VKiAU14rFEnDb/5LlBk/d1LSb+MGrXSlx6YCNL9T/S8h+WKE75u4q6H54ogXgFxa3
         vdFMisORqnD8QYN6wHYxpl7agbEyRd/GoaAOOkcZV2x/cLEep4Ei7nwv1C7BPQDDh
         NJKJAStAMRUDtPFOkt0MexHLjrGBfdFJw/mknG+lProOtcR+GmraN+BiSR4IJJ+h2
         xEWzqkzcamjht3imIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsnP-1qoKwd3iyj-00LE1x; Tue, 14
 Nov 2023 20:32:46 +0100
Message-ID: <856622a5-c636-4677-a218-12070afe960a@gmx.net>
Date:   Tue, 14 Nov 2023 20:32:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] staging: vc04_services: vchiq_arm: Register
 vcsm-cma driver
Content-Language: en-US
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
 <20231109210309.638594-3-umang.jain@ideasonboard.com>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20231109210309.638594-3-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tol0ZL1AgesNjpcIresGp3hLMBAjqiB9APiylxirondgLz/H3GA
 Ox2cspkyQZqx8xZSqYZVo1daKJRABXg12GI91ngnobscpztKeq9VTigmxx5g8HIgnPKBe9Y
 reHbcO8Y2mt3bucJLHMh3+TKVAGjmIMgoHf6O+pgo9imZi+JE2dDOFd40mhNJfSnMl1dFy+
 nsz+kSI/VS+HZAXfFkC2g==
UI-OutboundReport: notjunk:1;M01:P0:OgCA92FrxV0=;i6D1chp3+1ZPO9W8hP8BWP3elFY
 N3qXALD7LCzrTTHwInWhnPi23WzOVokqpc9XiLScMZQK9ZCgDwHTvDG7pgrzV0wfTeDOM8ERz
 7D87mLaJqMlmHgkgTWZTmbhAxsi056I93skw+y6/HM/QC+hqHPLXrwy5PsmlwRpDAMouAEG8j
 mQppNizNU/8Dut9jRXI84ZznOF7OMaav0H83CwWWljj/AD4j9MTx5uEj9nUUqkp6n2NvVjiIO
 Suav64mS14z1QposPi03TgAO+cSFLShoxd0EY9YbsSxp/eEZXRdA06bj6QqLCmfo/TQXKvw5D
 UuCbV7J5Cu6lbb3nSt/N7NZEGKtCw0uvxJPGvOq6FUKTRS0+6ukMAh98wzDKji7W8WibQIpSR
 B1EVCHWq6F1LHoMRbscRIkCseA6lGAdP+F3xIaCMPeX6ffZz0YMtSyjoxD10ytYantoAgA72b
 w812u6hf3SpJTUSY7DwUbHoH7q8KDB02cyF/0LVgKzLnS3wd7jbJMr9bWJmRwhLk4Kw1KTml3
 e6eGYCTL81jpJ6Yv/UTbnlAy+BQprw4+74FOYWn1dK8v9xMW7C/j5eum3I5600iQ1b3y9Yrmi
 le+BhjZzy7/PqUiyyFCJVbwGi6P52NROa58dtzjN2wDyPAIpXBrnF8h3lo/h7PjmasHNUT3ex
 YtlTvXeNa4E2oSpZi5z1iaQr34EDRswEU8S2f5mH1x1W7BtbQcYTxMPWCIdzBuwalg3p/tegJ
 XYlXm7iSTWH6Nxm9ipqe6OftPdWbFsFDbX5xCTEGMpTK9zvbyr0trFzh5AQ7b75Kg24IU6cSG
 MhXrI8L6Yo/3mgiQiBIV2tq8OKVNtauffeqXlibMXvHi/fir7wvUQGgaGYQodcifeq8oq23Eu
 1rYx47VpuRj3Y46iqKyIqACcJ4ZpsuSWwgRcaDBi6viGlIHooiNPghTtvWHXmCw7DUPbAjRCe
 nprlxDExZy/zHIwgnsul7ubJc6o=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 09.11.23 um 22:02 schrieb Umang Jain:
> Register the vcsm-cma driver with the vchiq_bus_type.

please squash into patch #1

>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm=
.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 9fb8f657cc78..5a9073480dd3 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -70,6 +70,7 @@ struct vchiq_state g_state;
>    */
>   static struct vchiq_device *bcm2835_audio;
>   static struct vchiq_device *bcm2835_camera;
> +static struct vchiq_device *vcsm_cma;
>
>   struct vchiq_drvdata {
>   	const unsigned int cache_line_size;
> @@ -1840,6 +1841,7 @@ static int vchiq_probe(struct platform_device *pde=
v)
>   		goto error_exit;
>   	}
>
> +	vcsm_cma =3D vchiq_device_register(&pdev->dev, "vcsm-cma");
>   	bcm2835_audio =3D vchiq_device_register(&pdev->dev, "bcm2835-audio");
>   	bcm2835_camera =3D vchiq_device_register(&pdev->dev, "bcm2835-camera"=
);
>
> @@ -1855,6 +1857,7 @@ static void vchiq_remove(struct platform_device *p=
dev)
>   {
>   	vchiq_device_unregister(bcm2835_audio);
>   	vchiq_device_unregister(bcm2835_camera);
> +	vchiq_device_unregister(vcsm_cma);
>   	vchiq_debugfs_deinit();
>   	vchiq_deregister_chrdev();
>   }
