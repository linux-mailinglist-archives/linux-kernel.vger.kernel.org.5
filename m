Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0482D7B765F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 03:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbjJDBq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 21:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240261AbjJDBqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:46:25 -0400
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D68EAF;
        Tue,  3 Oct 2023 18:46:21 -0700 (PDT)
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
        by cmsmtp with ESMTP
        id nn1gqEITbQUgRnqxxq06Ja; Wed, 04 Oct 2023 01:46:21 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id nqxwqmFPtmWDSnqxwqBPQS; Wed, 04 Oct 2023 01:46:21 +0000
X-Authority-Analysis: v=2.4 cv=HY0H8wI8 c=1 sm=1 tr=0 ts=651cc3ed
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=foHCeV_ZAAAA:8 a=NEAV23lmAAAA:8
 a=cm27Pg_UAAAA:8 a=IaUvMuFcDdv1ADpriA4A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=h8a9FgHX5U4dIE3jaWyr:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aQi0SGsm4QcdWyVW84ENcOXnkIwO2ZFqykwHJAizI1E=; b=XuCfZVCHbScmtR2kQ4l5F7QEDn
        1b9GaD3yZIMP5D0CMaFKITWP0XiYORZxwgp/8Jxv35THpGlLIZcGjnCmiaPXGaWP2v+3MnGUaYPBM
        CZrXxEc0MJEkvZXo0RlKsyOEnSJVZsgg0qIfr5FcyfY3QQmWkSgnn/xJszygyvzY1PLioQsXtZPP2
        ih0r21z9/IKDJSoZMipJLMrqnBaLQJ/SQXh5axKVRgWnDn1PByJl7fOuB8KAH6qY9bvmJ20E7F3kN
        O0R+BULFU6YlGEo7aTpmv1JVfzqD979j6GvbIauu5+44+Aey0xPeDcxerCkeBtsB12AHwTVc4pgVP
        KoxDlzoQ==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:48880 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qnp2w-001ZYs-1Y;
        Tue, 03 Oct 2023 18:43:22 -0500
Message-ID: <509b7545-ca05-b806-2874-a38cbdbfe732@embeddedor.com>
Date:   Wed, 4 Oct 2023 01:43:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ASoC: soc-dapm: Annotate struct snd_soc_dapm_widget_list
 with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20231003232852.work.257-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231003232852.work.257-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.238.9.39
X-Source-L: No
X-Exim-ID: 1qnp2w-001ZYs-1Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:48880
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDURYyS3O0Q+b8EUMp6b97ao0u1POcswz2QTnDQv0/4wWrZLJyTtF4Ecwyax9n7mW6rhUJJSMtjaF5xDGM+g9CwBTX7T5mLCb4rkKfctWKoTil9L32tQ
 ROFT4nNFwcnFaZcWL0CZaRevRhGp3k+l0dq4hEaJjZHCo5fJNpvGuvcNsM3XCSLYM9+Mh1Iz1k/Of+Gwx5sre4NKkoV61W5H8sTL3O+gtrLclmZ0i3sv4tbU
 Mf4ZyMvkQlcA9TdDkJVabrg6TEcojsBZ+l8AkC/CRws=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/23 01:28, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct snd_soc_dapm_widget_list.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-hardening@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   include/sound/soc-dapm.h | 2 +-
>   sound/soc/soc-dapm.c     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
> index d2faec9a323e..51516c93916e 100644
> --- a/include/sound/soc-dapm.h
> +++ b/include/sound/soc-dapm.h
> @@ -717,7 +717,7 @@ struct snd_soc_dapm_context {
>   /* A list of widgets associated with an object, typically a snd_kcontrol */
>   struct snd_soc_dapm_widget_list {
>   	int num_widgets;
> -	struct snd_soc_dapm_widget *widgets[];
> +	struct snd_soc_dapm_widget *widgets[] __counted_by(num_widgets);
>   };
>   
>   #define for_each_dapm_widgets(list, i, widget)				\
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 2512aadf95f7..2e3df47c9cf3 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -497,8 +497,8 @@ static int dapm_kcontrol_add_widget(struct snd_kcontrol *kcontrol,
>   	if (!new_wlist)
>   		return -ENOMEM;
>   
> -	new_wlist->widgets[n - 1] = widget;
>   	new_wlist->num_widgets = n;
> +	new_wlist->widgets[n - 1] = widget;
>   
>   	data->wlist = new_wlist;
>   
