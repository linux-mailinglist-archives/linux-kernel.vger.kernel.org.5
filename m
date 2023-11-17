Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984C67EF4BC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjKQOsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKQOse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:48:34 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A31A93;
        Fri, 17 Nov 2023 06:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700232504; x=1700837304; i=deller@gmx.de;
        bh=Rhzr/tXislpaEcjUqBvx/o590da//8yYsjL1uA8Urh0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=QuXEvFwSt4rzdi/fXlKMesz96+8DL21zBrJu8qBlX2z1772pZa5h9U1OXeClaVBF
         qjZetUZogJ/RW5CNY46WEzR2kWJWakcXZ5zeGWlKHr8CldNQX8k7cm/YG8TxcAWY8
         1MUkRkhfK6N1xWbYsb9R5NsCDspW4DnMyzKegYqd+DwVDMapMf0dCmWsPCTSo3tBn
         dyCI+8fSzzak47OBQhIMc+sm5AMABTmSTNEUFMai8+ozmFrWFciX2w7fMEFReWoQp
         gKmx9R0GjE9PaW89j8/5nkNKzrf2gy9YIRRtujr5RS5yLukHuHPuFdt/2MTzvOM5h
         tFdGOcdu67ArpIUFGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.147.146]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ykW-1qxvri2BfC-0068y0; Fri, 17
 Nov 2023 15:48:24 +0100
Message-ID: <cbfda101-9ba6-4130-88e8-be49e15df642@gmx.de>
Date:   Fri, 17 Nov 2023 15:48:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: Replace strlcpy() with strscpy()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20231116191336.work.986-kees@kernel.org>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20231116191336.work.986-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r3Rwf/595U6LU+stnCdyFJu9RcB2mdBe2iKZMzKmyliSUm2uqVl
 meG/8Q5gWsvKQaayqV2ZZIDJj40x5i/wq4aHy/0vpG89QvJ7vLT9XvsKYNYh4Ohtzv93iOV
 OTpWcJlv7reBLBQ23k9CxVj4Tl1bln27eqg8ko6I0rghoETc4tN1cEQviKdcG9KO6moesQO
 +J38gTi4FvC8sAypm2goQ==
UI-OutboundReport: notjunk:1;M01:P0:cbNoU/VWvvE=;xqXuioAPBeoc5hSy71OfIm6IQ2Q
 o6ZMvUCKs/4BYoZuVa1ju8E5EIhKL1ztUOfYJVBPPEaB53hDFirgkrLyS3+BvE9iHdJAmnSh3
 Rdb6Xi+9BkeFrONpzHmACUUpdruccX52msOa7UNlm64nem6My0wMeJGr1lLE7Ybn77CX7l8bg
 gxzamyammX8udf1nGy9jCjpzkrSQKq1yCaX3lEI+ZYJ3UuMLjIHzM2ynNyySR3MorNj1aRJRg
 WxjzHY4a8EnAXdwtK7verWVgyC64N2yjAlKQSUfDbNmAi+6uT5SOO3Uem7Q24APxilKSt1tvD
 wLOyB/yGMOPib1UgvPTia5Xpb5IT+Z80SH5DKq1axEHafTF7ou2OapjGzukUZ7i6tw6hG8JTf
 j46qq3vfhvifzzMioBzfKpZZQCY9f+ZwWBGmiwk6fxHkQoFWQavZ1lxeJVCwWn2KvV2T3Nt1U
 F0ZLZuJ0ZqSdTi09P/c5GjZAP4K0dMZFdSKyxaXVG21m5IDpfkG8BVkT5xA6EwbC2gzXkmURJ
 sg4/Pka06LrAaNEFCr6VzB72jkqeAsxeHKlZkRJih/wQbPMxQGSivq1/rgcMao6RQ/T3lSyE8
 OlwtMTNREb3ikqQYFZDKizWr05ojc/9G3nP+kbOlpYYYDi/oavqb4UORGDYDnxfpePKDmeIfo
 fIAiEl1XtUbnJAvRXRR5aabQf9gGRsxNgherpcElLIfqYZmAVHJYkcMAm0OV2r1b75RflGOFy
 Q/XTsw8E+qp/3PD+rzHOhJWDz8WGEaVKFPG3piEcVaFf49uIahc9toGLf3X2myTTKJ4ydNa3a
 Yvy8QdZnRK85u6SpLqB7EtF2go+lQmTdsrk/dpBYstAXnTT8PU+c0X/3kPn/ciJrUktmtelCV
 /n20uFGuDmL4URtcvOyMJkdUAdp60vF3ajEoXSIBggo1Vmq3R9xGUUkQV9ULOzhuMRxBc9vJq
 hS8rcQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 20:13, Kees Cook wrote:
> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead
> to linear read overflows if a source string is not NUL-terminated[1].
> Additionally, it returns the size of the source string, not the
> resulting size of the destination string. In an effort to remove strlcpy=
()
> completely[2], replace strlcpy() here with strscpy().
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#str=
lcpy [1]
> Link: https://github.com/KSPP/linux/issues/89 [2]
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
> Cc: linux-parisc@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

applied.

Thanks!
Helge

> ---
>   arch/parisc/kernel/processor.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/parisc/kernel/processor.c b/arch/parisc/kernel/process=
or.c
> index 29e2750f86a4..e95a977ba5f3 100644
> --- a/arch/parisc/kernel/processor.c
> +++ b/arch/parisc/kernel/processor.c
> @@ -383,7 +383,7 @@ show_cpuinfo (struct seq_file *m, void *v)
>   	char cpu_name[60], *p;
>
>   	/* strip PA path from CPU name to not confuse lscpu */
> -	strlcpy(cpu_name, per_cpu(cpu_data, 0).dev->name, sizeof(cpu_name));
> +	strscpy(cpu_name, per_cpu(cpu_data, 0).dev->name, sizeof(cpu_name));
>   	p =3D strrchr(cpu_name, '[');
>   	if (p)
>   		*(--p) =3D 0;

