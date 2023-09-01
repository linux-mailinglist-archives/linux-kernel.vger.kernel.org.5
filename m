Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD7678F9EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245323AbjIAIWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjIAIWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:22:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB20193;
        Fri,  1 Sep 2023 01:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693556526; x=1694161326; i=deller@gmx.de;
 bh=MwQErYC2WyUnqBkZ1OHIzcRkFv5RC+6+03ppvFQMhrk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fTK56NUD7/nlYlhuGfkQIZVcV+rk8+mKAsIFZycbieI9mcTggQA4VfdacY3a9u8EFAOBpvH
 hmZcSm5Tj/WFVhaoL98r4l0FXk5n+zYPw6AtvrcJjRdu5YBLm4iB62eAr/FfCTKhC/B07lDpx
 bVkeNJmRNxnadgQWwUYs7BoQA0NzBmhgQN6IWt+EJ8hI71y7wSt3+M34dUabzFeoei/fgIPep
 L68M/PJJgsTwiP2bT8CzWL9cNIU3M4lmDuMw+4CihV10gBi69jVV5iz72ABltWAnDN4lMH47h
 /uBTAvCbTYwMHtv/OoqZYIN9ujctUV9wEwlgGNU2V7Sx1zhNPw6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.187]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEFvj-1qU2mp25H3-00ACnX; Fri, 01
 Sep 2023 10:22:06 +0200
Message-ID: <bf8e8402-2def-a365-18be-3b426cb1830a@gmx.de>
Date:   Fri, 1 Sep 2023 10:22:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/7] fbdev/core: Build fb_logo iff CONFIG_LOGO has been
 selected
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        javierm@redhat.com, sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
References: <20230829142109.4521-1-tzimmermann@suse.de>
 <20230829142109.4521-6-tzimmermann@suse.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230829142109.4521-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vuU05QJT6IlWwo4Mi3+L1LzYABiF5ykbqlHFcYulGYtDh4+YQmD
 NiJ41y51505V3tq6TsqpIMJVUdUzMflX32opvKoFSKfSb4llLjqi5VlheVhZXDOnaZJeIuG
 U4DvyPxX6F9/UNCrvUSFj8J2ym+i/ODRz8+YUQj6lXqjeSxtfvYjPDyHzfeaKayJUVpUFX/
 Y8wuqXjBOk5P/8g0tAxHQ==
UI-OutboundReport: notjunk:1;M01:P0:LnujzmPgv/8=;1ax9GF5eQQESMwk4R/s5sXECxOf
 ZYexDqZJ8RXgI6/CyF4ZLCXxn/QhXzVQhEy4EbnnSR3Bdoj2LIluW140fn0Uh3oQXAYrwukQP
 JvMX38J0+oBkK0P3mJo7hag3tp/SphTkN3rzdnW7Mf1N5VEGTrfceXMWbJVAHou9H0FrovZVL
 8SngG9wzpZXJSuP/Y4kGPFyZhI5MHJOmuzcSnMYgOp7C02WBFW7p2oRxu08Ntwpj2Xpp6+mbW
 ejI7cDZqpHhcou7ydwj00YRP2miOLDwY0BpbCAzCrWM/OWjtkOAnlb0flWgyfYzOQP/dqfkeb
 eXz52q1JA2WQyLnFZ+0p5C8ySH7PMOPAGtkh51kJGctxthzkOuaAvWh8RP1WMMXVunbahcH8X
 gB9GAD374qWiGGp14DZeejQoOf/mGul0McEHjS31csm2lXfLeQdYfTog13xa/rTBsENLtdu46
 54qJeLhhUpZdgJZk5IF9v1cxbY+/ZVywXf4NqlXkUgH307aXcPsXakL2Eibe0EQFUYaSrdvT/
 4dR7xcEerfQ4T6qAPtAPNedfD3Fk3LgBQFOJtbW58x44dNyScMMvuunax0v6ksE7MtKvgD4gS
 FUnslvc8NeX3KBP0MasMtD/lPi23JTh7sYhy56lLs7lXoBG1G6GAHbQYTVfufBDYi7oG7A0hv
 EYwmzkJ45Hpa2eIXy/HO2NuHSrHk+D1YyHr17CU6Xgv4xYe3qHVUQ/su9cS2vJNKZjk2oUaGW
 KK74WwvNJyra98VQoMdCGJEspdXtHO9BUinHBK1GbEkyAMiEIQON7NaylFLyVBka2laf93+AY
 J72Sr4pq/c5+I/EGMH+f1dK7s5nM8o5iQyVcLkGBmwUrH49HOemOeFLLHKNgHqJtGnl/Sqs+P
 fh+0W2JbOa68g45aAqPa/NIySdkFjFmb+041DaeN+fRoBsBje4ph8RrudXVA/u9TP+zKqOsTI
 fLnItZXdGrlgY6RUCx0WQ6jsZvA=
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 16:15, Thomas Zimmermann wrote:
> Only build fb_logo.c if CONFIG_LOGO has been selected. Otherwise
> provide empty implementations of the contained interfaces and avoid
> using the exported variables.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
...
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core=
/fbcon.c
> index f157a5a1dffc..24b038510a71 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -474,15 +474,19 @@ static int __init fb_console_setup(char *this_opt)
>
>   		if (!strncmp(options, "logo-pos:", 9)) {
>   			options +=3D 9;
> +#ifdef CONFIG_LOGO
>   			if (!strcmp(options, "center"))
>   				fb_center_logo =3D true;
> +#endif

IMHO, *sometimes* it makes sense to not use #ifdef and code it instead lik=
e this:
   			if (IS_ENABLED(CONFIG_LOGO) &&
			    !strcmp(options, "center"))
...
That way the compiler will optimize that code away as well, but in
addition it will compile-check that you have correct coding independend
if CONFIG_LOGO is set or not.

>   			continue;
>   		}
>
>   		if (!strncmp(options, "logo-count:", 11)) {
>   			options +=3D 11;
> +#ifdef CONFIG_LOGO
>   			if (*options)
>   				fb_logo_count =3D simple_strtol(options, &options, 0);
> +#endif

same here.

Helge
