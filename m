Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724B97F002F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 15:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjKROns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 09:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKROnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 09:43:47 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1141C0;
        Sat, 18 Nov 2023 06:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1700318597; x=1700923397; i=wahrenst@gmx.net;
        bh=I55FSw1BmvsjYif7K0yxKJuRFN2szcFKJRArmYqf0EM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=uNjWasXDDS32haFTz1gRjCnQhPadxtZIvEJ6b01rLhBxbNYCA8z5xXtWwbBfdZb5
         5ff8Sd2F75YAbWdyC4lh9V0hQJ9ZEjmCIWEANelCsQzqJXou8gJW2LIrj5/S6Dxhz
         7yUNbEmhnFaxW71GFKsqjMprWQTh6bxpKJ5LBHzh1oRBZnxzNJCVMazmcUK6HDMGH
         hA5tYdkEEG8dnc2asWoaqxl4Cyrp3gwgezrL2VCkNAoWFSYgTEmtSI5vWN7IqK6s1
         8svnqHV231zB+SduEGNR5/sNJbTU08+SM/+vDa65ugJx4zPnKiFnobqwR/6vT+lZb
         znrhfffLMsxbzY9iEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE27-1qlJSJ3xUp-00Khzp; Sat, 18
 Nov 2023 15:43:17 +0100
Message-ID: <5a51d89c-a1d5-4d70-a578-8e8be39152f1@gmx.net>
Date:   Sat, 18 Nov 2023 15:43:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] staging: vc04_services: Add helpers for vchiq
 driver data
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
 <20231109210309.638594-10-umang.jain@ideasonboard.com>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20231109210309.638594-10-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BP2bhsuxoeOywqHABcg5IF5JMGovXeW98X8ses7HkRcZErxfOYM
 dytDlgewRBd1YtdPeEtk9O+nZgfjcKJem7D+3v+HSDjdUMiRzUtDpL2LB6HeBn5Dva47nQE
 /DrieKjxsaVr0B+eo5MJpe82X3akx37QPGh7uViml8i9mNqEqja1W/N218iEYBrZazHyvEq
 mlc+F/Tspsp2gVLfm0ztw==
UI-OutboundReport: notjunk:1;M01:P0:9/urxu4z5zQ=;qUeComnGWgCkcn6OgtcBu+S9hZk
 npwHY37HMLFfLMgRQQ8sQBTpSVUMP17z+gGikTDBwfKuUB33NQTo6gaDFoCb/BBVEaTiY49ra
 Qa5OJ5IBbI0gVt+CKv81H73qqi1MWoi0yW31LrGOn6cHMCW8orsNMJdoEJpXum6JfGIquoTVa
 nJnyXrE3axiBIv9yxAWSX1Hn7BTcZAWpOTqme8/1Jn6z+ZOdAQE9zWhKUwaokxaSIHhZSX22x
 HNE4MnggB+zW6TsuzZ4xYtN6DCzViDWhHBxepS7k2+HAhCQ+kO39mFepBOM7w8ZKsPv8zspdC
 I7uCLe8ZFuCnBPDFIAVKm8YDOu4ECgkmsbs58gsCHqBUF8Z5GvpSogENWC8zNp9ppD5A5Oee/
 vnzuyVlAYot+5BKbiB+/xewEK2LbuqcSPhIKezUThBqk+LxpwsxB2houdIXq4thQMKTTEu35v
 c1f8LwniprkUlxYvyiKGC4LcHnsoeDsJGa/jD1QutmOF5iAkjisKNODFxVNsZBaamvkhr3rq5
 uwuvtOVd1Dtya2kR+hN71Vs96nFpm5CEpbNLo5KcfitwKomBawsE5LaA3D9hNnSxJRJFdTJRL
 gTYVXCg65lesTIlOgieoUXoIyv/qD145MH8NQzomT2EUNiG4dKVMGz73N5FYC3zhhK2yHPLER
 xBCu3Y3j5NvGMB3vogo1IzeMqVrUAHUOmoLG5FpsvDSV7nMNwNA2ngI2akFDBr73mNlSudGFj
 JsEUoXCjuKuLKVx5qT+QrINB22fxBDTf9ZPqLrrOFbCvu5z09nxazyEOgnSktoi/W2T/PfySr
 PAaSJH11Ix61sqrnpzSxCxkF08HzT3lxhlv2b0idKQYdwN9ZibgvoiHoD5Z8PNdqlOcOPwc/2
 qvkG09k99i8UiVSnsal07e10KkxzFdemFX2LgfOSFgBP2vWKE3HFfdk8tnxT2tD2HZzyN0Bl7
 H8gryA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 09.11.23 um 22:03 schrieb Umang Jain:
> Add helpers to set and get vchiq driver data.
> vchiq_set_drvdata() and vchiq_get_drvdata() wraps
> dev_set_drvdata() and dev_get_drvdata() respectively.

no strong opinion here, but is this change a real benefit?

Except of this such a change should make use of it.

>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   .../vc04_services/interface/vchiq_arm/vchiq_bus.h      | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus=
.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h
> index caa6fdf25bb1..800f53bb48c2 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h
> @@ -34,6 +34,16 @@ static inline struct vchiq_driver *to_vchiq_driver(st=
ruct device_driver *d)
>   	return container_of(d, struct vchiq_driver, driver);
>   }
>
> +static inline void *vchiq_get_drvdata(const struct vchiq_device *device=
)
> +{
> +        return dev_get_drvdata(&device->dev);
> +}
> +
> +static inline void vchiq_set_drvdata(struct vchiq_device *device, void =
*data)
> +{
> +        dev_set_drvdata(&device->dev, data);
> +}
> +
>   extern struct bus_type vchiq_bus_type;
>
>   struct vchiq_device *
