Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253FE7BE3CA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376273AbjJIPDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344625AbjJIPDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:03:15 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641B2AF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:03:14 -0700 (PDT)
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
        by cmsmtp with ESMTP
        id pZ7TqdLDynGhUprmrqeM6S; Mon, 09 Oct 2023 15:03:14 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id prmqqHxKLevEjprmrqsic2; Mon, 09 Oct 2023 15:03:13 +0000
X-Authority-Analysis: v=2.4 cv=VZbkgXl9 c=1 sm=1 tr=0 ts=65241631
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=mK_AVkanAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=JpHVVEXmboDBK7eC_9wA:9
 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22 a=3gWm3jAn84ENXaBijsEo:22
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kwshnLMBhyxMuxeif4XuR1omG3UT2LUWqR6gAPw6dmc=; b=znvEX22WjX1jnbPoXogMVrmMO7
        N/kwpYLfNNQtNaU3yGtsaUjkSB67eUuw5TxzjXhReIXhyl7hPPI2lqcsVU5YLOwE0V7Mve0KqevYD
        ypJCZkTN+dOfUFVfec3O7q2bRn2Qdpg/NmGVDnLNMjNfGU1MbpBc6UTvL/H0cctYtEe6rh7oPUqX/
        LAYAiSkfvWxsNffMXW/QyWW53Nzbo8UfM7piMD80qMLmwvivSdPfL6Fn7IoYzOBbWoR76WeZwmzQ/
        lzk/+nCplL4h5w4FCd2mJBCi+7OjEiScT7f1yUAq658AHYKouSotVcRIcBcyVvAtpzJ11GlzPeu2Y
        zsk6dM0Q==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:46332 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qprmo-004OOb-24;
        Mon, 09 Oct 2023 10:03:10 -0500
Message-ID: <9477fcb5-1cca-435e-a1af-e02edff1551c@embeddedor.com>
Date:   Mon, 9 Oct 2023 09:03:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: p54: Annotate struct p54_cal_database with
 __counted_by
Content-Language: en-US
To:     Jason Andryuk <jandryuk@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Christian Lamparter <chunkeey@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20231006201719.work.356-kees@kernel.org>
 <CAKf6xptEEHJAsrwh_oebK1_AMb+_tvLtiY8sP-Qk=Z9jXhVf7Q@mail.gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CAKf6xptEEHJAsrwh_oebK1_AMb+_tvLtiY8sP-Qk=Z9jXhVf7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qprmo-004OOb-24
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:46332
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNd6oqvzdeGNP2PQmNEH/nOumtz9dyLahuJdIt8Mr8Xgf8TKH/SDZBKzt/fyegqBOm5pBzj+l59hJc21NuHd+kjCps5VyaE8ETTKqlnDL4kqW7qG58VX
 KXgYIj8h54stTUIfURfychmMjcJcDOEaYRyIan9rktrtFYHq2KPkPgi6q+OokdJIDo4YX9sNHN2ssaFm2oeFEW1LS2b8WbI3pdIRISvAEAiRX55QSIpBFdaV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/23 16:55, Jason Andryuk wrote:
> Hi,
> 
> I randomly peeked at this patch.  Unfortunately, I am not familiar
> with the actual p54 code.
> 
> On Fri, Oct 6, 2023 at 4:17 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> Prepare for the coming implementation by GCC and Clang of the __counted_by
>> attribute. Flexible array members annotated with __counted_by can have
>> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
>> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
>> functions).
>>
>> As found with Coccinelle[1], add __counted_by for struct p54_cal_database.
>>
>> Cc: Christian Lamparter <chunkeey@googlemail.com>
>> Cc: Kalle Valo <kvalo@kernel.org>
>> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
>> Cc: linux-wireless@vger.kernel.org
>> Cc: linux-hardening@vger.kernel.org
>> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>   drivers/net/wireless/intersil/p54/p54.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/intersil/p54/p54.h b/drivers/net/wireless/intersil/p54/p54.h
>> index 3356ea708d81..770e348d1f6c 100644
>> --- a/drivers/net/wireless/intersil/p54/p54.h
>> +++ b/drivers/net/wireless/intersil/p54/p54.h
>> @@ -126,7 +126,7 @@ struct p54_cal_database {
>>          size_t entry_size;
>>          size_t offset;
>>          size_t len;
>> -       u8 data[];
>> +       u8 data[] __counted_by(entries);
> 
> This looks incorrect - I think you want __counted_by(len)?  The

I think you're right. More comments below...

> presence of entry_size made me suspicious.
> 
>>   };
> 
> This is the function that creates struct p54_cal_database:
> 
> static struct p54_cal_database *p54_convert_db(struct pda_custom_wrapper *src,
>                                                 size_t total_len)
> {
>          struct p54_cal_database *dst;
>          size_t payload_len, entries, entry_size, offset;
> 
>          payload_len = le16_to_cpu(src->len);
>          entries = le16_to_cpu(src->entries);
>          entry_size = le16_to_cpu(src->entry_size);
>          offset = le16_to_cpu(src->offset);
>          if (((entries * entry_size + offset) != payload_len) ||
>               (payload_len + sizeof(*src) != total_len))
>                  return NULL;
> 
>          dst = kmalloc(sizeof(*dst) + payload_len, GFP_KERNEL);
>          if (!dst)
>                  return NULL;
> 
>          dst->entries = entries;
>          dst->entry_size = entry_size;
>          dst->offset = offset;
>          dst->len = payload_len;
> 
>          memcpy(dst->data, src->data, payload_len);
>          return dst;
> }
> 
> You can see that kmalloc is performed with `sizeof(*dst) +
> payload_len`, and payload_len is assigned to ->len.

This should be changed to:

-       dst = kmalloc(sizeof(*dst) + payload_len, GFP_KERNEL);
+       dst = kmalloc(struct_size(dst, data, payload_len), GFP_KERNEL);

> 
> I don't read Coccinelle, but, if this patch was auto-generated, I
> wonder if the script has an error.

With the struct_size() change, the Coccinelle script should be able to
generate a correct patch for this.

--
Gustavo
