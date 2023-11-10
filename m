Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6CA7E82F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346174AbjKJTkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbjKJTjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:39:42 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EFF86AE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 23:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699602448; x=1700207248; i=deller@gmx.de;
        bh=BmA74qgCIQid/jegDw27u4dltKOa4emchuTy1vFkBg4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=XIfeHm1EMHAPTU469Gy2apXjhWdAckKbWoxlTc5+rnaDSPQ9N55u0LRU8q+mkOJt
         LKEeG/8bTxcqW+oH3ucHy4ydQHE1VbTMkhT+MzoBPO4IyHzlctX0PBeWCBRE20xLq
         CWQva2aIhSBgimiiWHSef7xtPEg+N1Q49GGGW4jAtpCCxvGhc1NkXM6XpP3fPmU+6
         +c1k4Ts+Yia98k0teuGXkLopd8VWd9HRSu31dSVqZEiKLd+fJe0iW9JGjya0X4mnb
         aAfRHNyi7SmUj30W9qcCdd0ECsVWvjbkYn3uwCu9yAKq+dqRu0s/DwUToiAJglniP
         yTtQaY82QaDF8atSTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.22]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQIv-1rmmc32uWd-00oWq9; Fri, 10
 Nov 2023 08:47:28 +0100
Message-ID: <c030e573-b350-4da3-9fc6-f62a00a53a25@gmx.de>
Date:   Fri, 10 Nov 2023 08:47:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] [RESEND] parport: gsc: mark init function static
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org
References: <20231108125843.3806765-1-arnd@kernel.org>
 <20231108125843.3806765-6-arnd@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20231108125843.3806765-6-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r28ZwbOxXS15w7HMfO9oswTD9vnf9nbMlucjVi7rXk5k8fr9O+9
 FnK0/wVGLW1ucScypDnVyNoCDUp1O9Q1hFcuFWBLuVPrVnRqXjLPoJx9Thd5bV0CvGLw+aD
 g4EcFQlBAsL+L5vnPeJy8Sqzao6eUB+u3zHf7TLib3Ooabrzq2Sw6us9dYJeTgeID2n5+Th
 q6UirN+C59BEH15gx7SPw==
UI-OutboundReport: notjunk:1;M01:P0:8NpxEmv4qtk=;QHYspWaxQgW5H+5JtbfnRRvRiFr
 hNjhLK4JpyulgGE8C3Sy0SUusCORzFVnmztwXF9YeVOhT6NZuMGjCtELNQFziBbiWiodFSZhH
 H5yjzT/5pbHtimgmOE4FAbQ7VtS6c/c/Wnl74OTZyg1c4ImxTtQ6w7q+ns0EXXURfdoCNl8SM
 MLmYTIZ23T8kI3c8K4jqNdEqLecN6Tik/GkZLehXqhNVzwydtFeeotkL+TZvnviU1AfSfNoVa
 +parQj1D4PD2Fz5xlSQm2nN9FceWeawguJxwp3dvBKkUvnzQoXqgfxX4gF0zZ/wWXbwkmlGLl
 4Bok9RWPnlu6gfu2OXWWRsDq/VHkC/uI85Sf8mNBZnwlUpXMaQq3OMsnEnA/ZGwdwASvxyAFf
 WEZfmJzpYk0PntmqjC2scg5QVXsCa47mqWQY1kjTUVNHi3tdGcLYYtC7VZl7JlLDE6PbakHt2
 r9EzAekHYzOFzYxWdEcK7xCAxoBAJTxxxwhOGZuRB8JtVY2QY/W4Oro1YnbC7IRAvShtbswuw
 1r0XbZyo6YqBG/oSLiFG1poUUJ2ugpxas6HZKbM6HkqrPIbaggzNF4Fym10S59kTVx3oseHuF
 x9TCOO4NMPrIlAc4Bj78uvl3DXM3Px9WjFnUGYwiHw0foel2CsPlGi9PFgQczB0Id2vXkCpE8
 iaZoquSInYO7NHKkcBHwrCi4paXL34oR03ae7MUp9FS0CM6kuQaj2fZM6vvQIjRRMfOThFzMV
 kuCEgjZTQStRHw0ZM8egErAnBsIcts1AmtvDaX/PFAjUZ1u9bETf+lGizR7S4TpXsCYSambpn
 nrrwqLhmN7S7V3/Fe2sBT+HPiiDdIMkqTKTlYyr029A7DNI9MJS74ECa9WeJ21dINIDyk0ghk
 72n1Hs8z4COHQm9TFAx1qD65BcPEE55SdiDvMy0liut4VKOaYU91IGa71Ba4cvgNVme/8J1bM
 lA7RSA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 13:58, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> This is only used locally, so mark it static to avoid a warning:
>
> drivers/parport/parport_gsc.c:395:5: error: no previous prototype for 'p=
arport_gsc_init' [-Werror=3Dmissing-prototypes]
>
> Acked-by: Helge Deller <deller@gmx.de>
> Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Since the parport_gsc driver is only used on parisc machines,
I've added this patch to the parisc git tree.

Thanks!
Helge


> ---
>   drivers/parport/parport_gsc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_gsc=
.c
> index 5e4475254bd0..c7e18382dc01 100644
> --- a/drivers/parport/parport_gsc.c
> +++ b/drivers/parport/parport_gsc.c
> @@ -392,7 +392,7 @@ static struct parisc_driver parport_driver __refdata=
 =3D {
>   	.remove		=3D __exit_p(parport_remove_chip),
>   };
>
> -int parport_gsc_init(void)
> +static int parport_gsc_init(void)
>   {
>   	return register_parisc_driver(&parport_driver);
>   }

