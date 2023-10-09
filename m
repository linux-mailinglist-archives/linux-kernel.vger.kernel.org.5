Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547B37BEE21
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378891AbjJIWKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjJIWKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:10:51 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33159D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:10:46 -0700 (PDT)
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
        by cmsmtp with ESMTP
        id pvyaqT9LQaLCxpyScq7UXl; Mon, 09 Oct 2023 22:10:46 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id pySbqEDL1xOR4pySbqAELK; Mon, 09 Oct 2023 22:10:45 +0000
X-Authority-Analysis: v=2.4 cv=faK+dmcF c=1 sm=1 tr=0 ts=65247a65
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=TiVRK5GloQ2tXinOWEgA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=z00a85cxpePpAkmDwxgedq3waCKHZ8B80JhlZHQ33mo=; b=tiuwuZN9V3RBFMGVrh2Cxj1kQq
        mdUI/UvLH2QvS96EQV2M0bdCHlELBmBS0OpPwE2WTL5nOfNv/NNd5IHux+NedAccZ6iHLfig8yjyd
        OZ6NTrJiNyHhJ7XOLHijROQEOz4zkzvyzbC6r7KH6ZQIfJs9SCBrg712wzhlcE+dTcbbuUhrdSejS
        mak7oYF0O6vhkXds87qLhAmNvfQWRKAIMzR0TGbYwV6Wa/idhnPejqqDhqkmy2CScBRZwfrS9LI28
        3puZuNXrqlm+uCj+UAVdBqIEPDLYR7ADiB83I/TZqK719k3Vfk89dafuk5Eo6APe7RmOS5QdKQf5W
        SvSS1+dA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:56696 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qpySa-0029nO-1P;
        Mon, 09 Oct 2023 17:10:44 -0500
Message-ID: <f30b0784-de06-4e53-9405-69aa2f86df28@embeddedor.com>
Date:   Mon, 9 Oct 2023 16:10:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ASoC: sigmadsp: Add __counted_by for struct
 sigmadsp_data and use struct_size()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZSRvh1j2MVVhuOUv@work> <202310091503.E59363D14@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202310091503.E59363D14@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qpySa-0029nO-1P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:56696
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfA/wvb9ax7ZjR1oPowvP3mI+dcn3trDeJ/aDgzZcmu+G4TodSppXXXAGG7YnsQVwWb4XSDBHHJzpQtPpyCeXLEwM66Lb707+xANVdlepOJPsUMt1rgE/
 JKGr2Sx5JaVhoOW32tc0/G5IE5OV5Az2t4T3BdzrRbzCs3sqC3jtt/N+SxRA9Fzy2C873RWQfkFx8yA1poHSbldJPbogYp0MEqryKwwAYvuiQ+ecDeSDp7rc
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/23 00:03, Kees Cook wrote:
> On Mon, Oct 09, 2023 at 03:24:23PM -0600, Gustavo A. R. Silva wrote:
>> Prepare for the coming implementation by GCC and Clang of the __counted_by
>> attribute. Flexible array members annotated with __counted_by can have
>> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
>> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
>> functions).
>>
>> While there, use struct_size() and size_sub() helpers, instead of the
>> open-coded version, to calculate the size for the allocation of the
>> whole flexible structure, including of course, the flexible-array
>> member.
>>
>> This code was found with the help of Coccinelle, and audited and
>> fixed manually.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   sound/soc/codecs/sigmadsp.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
>> index b93c078a8040..56546e2394ab 100644
>> --- a/sound/soc/codecs/sigmadsp.c
>> +++ b/sound/soc/codecs/sigmadsp.c
>> @@ -43,7 +43,7 @@ struct sigmadsp_data {
>>   	uint32_t samplerates;
>>   	unsigned int addr;
>>   	unsigned int length;
>> -	uint8_t data[];
>> +	uint8_t data[] __counted_by(length);
>>   };
>>   
>>   struct sigma_fw_chunk {
>> @@ -270,7 +270,7 @@ static int sigma_fw_load_data(struct sigmadsp *sigmadsp,
>>   
>>   	length -= sizeof(*data_chunk);
>>   
>> -	data = kzalloc(sizeof(*data) + length, GFP_KERNEL);
>> +	data = kzalloc(struct_size(data, data, length), GFP_KERNEL);
>>   	if (!data)
>>   		return -ENOMEM;
>>   
>> @@ -413,7 +413,8 @@ static int process_sigma_action(struct sigmadsp *sigmadsp,
>>   		if (len < 3)
>>   			return -EINVAL;
>>   
>> -		data = kzalloc(sizeof(*data) + len - 2, GFP_KERNEL);
>> +		data = kzalloc(struct_size(data, data, size_sub(len, 2)),
>> +			       GFP_KERNEL);
> 
> Since len was just size-checked before the alloc, size_sub() is a bit of
> overkill, but it's not technically wrong. :P

Oops.. yep, you're right, I totally overlooked that check.

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thanks!
--
Gustavo
