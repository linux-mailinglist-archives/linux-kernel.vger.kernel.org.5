Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1AD7AC1FE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjIWMXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjIWMWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:22:50 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F548E61;
        Sat, 23 Sep 2023 05:22:14 -0700 (PDT)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
        by cmsmtp with ESMTP
        id k0HiqAx7oyYOwk1eIq0htS; Sat, 23 Sep 2023 12:22:14 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id k1eHqtmnAHLNfk1eHqjbxb; Sat, 23 Sep 2023 12:22:13 +0000
X-Authority-Analysis: v=2.4 cv=Vp0wvs6n c=1 sm=1 tr=0 ts=650ed875
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=iox4zFpeAAAA:8 a=QyXUC8HyAAAA:8 a=foHCeV_ZAAAA:8 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=h8a9FgHX5U4dIE3jaWyr:22 a=xmb-EsYY8bH0VWELuYED:22
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WPSdLZnPg0Xa+53dl/XdXFwCV7Ecr3f4T970hU8aPKw=; b=Z3jEnZQq53K5tmRETOr6lUQXLV
        GxGRCgRrcAzMAe2v1b2jeEEzjTjYaAdI1G+zBh8Wp22m3D4wvZWFZuwF7KNF9rdszsiwGGeBtvzti
        hk0JOwUDnbu+Ph3vrDel7rstwGAiI5to7zIbuzFuidzdoRaNFkgu03zyLupWRJB2MTIQKW+N1fl2Q
        r5i/e3FEBOdFjVeOZv5MCPH30JaloYdfplRGbnzziJPmtiRkfU1p/cYaiS4F+bC+s2xRww1q4Dbwz
        UAuZe51+H3okQggzMJwTLMFQAbDXNwAa683TEGZ9H6Uf2/ec9KYKkTuANB2VI1CVQXNiHNPFJDT+w
        gHxQ6hxA==;
Received: from [94.239.20.48] (port=46926 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy0q-003YA9-1Y;
        Sat, 23 Sep 2023 03:29:17 -0500
Message-ID: <9838a857-9752-5c06-0b00-3cd279f665d0@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:30:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ALSA: hda: Annotate struct hda_conn_list with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Jaroslav Kysela <perex@perex.cz>
Cc:     Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jason Montleon <jmontleo@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20230922175042.work.547-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175042.work.547-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qjy0q-003YA9-1Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:46926
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFIX8y0TXXMbFw1WobXM9gEnT6ItVvtk1uhepJXqEwyXegCZj5K4jyJjiVXLhAdEf5nL7/E359ob2PMM22H61Hutc/J6BzDosEycfgpErAIlN4xp4JUK
 7u65dNK3ATuXxcB51CcbjIcW7TcMUojCb52Ac5Pxs98+2SeNJ3npoKSSqtyXKqGAC+MMqPnkJyoTcJ9OpzC5IxDtPC5Bcbqqs4aXzUGbG9RS4hwxlyYZrWBj
 yBz+BesgxwJ/wgR6EFUTljg2jWfcwjOwShgMJHZWnu0=
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:50, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct hda_conn_list.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   sound/pci/hda/hda_codec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> index 33af707a65ab..01718b1fc9a7 100644
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -88,7 +88,7 @@ struct hda_conn_list {
>   	struct list_head list;
>   	int len;
>   	hda_nid_t nid;
> -	hda_nid_t conns[];
> +	hda_nid_t conns[] __counted_by(len);
>   };
>   
>   /* look up the cached results */
