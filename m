Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E75787E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbjHYDRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbjHYDRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:17:02 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40E9210B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 20:16:28 -0700 (PDT)
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
        by cmsmtp with ESMTP
        id ZEq3qqTpCyYOwZNIkqBFw4; Fri, 25 Aug 2023 03:15:58 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id ZNIjqRHbcUQLnZNIjq5nuD; Fri, 25 Aug 2023 03:15:57 +0000
X-Authority-Analysis: v=2.4 cv=aqOhtAVV c=1 sm=1 tr=0 ts=64e81ced
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=CGo6wCm4IADRok0f:21 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10
 a=VwQbUJbxAAAA:8 a=rBWVdRCEoVSWMRuK3c8A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=tNK2v2ls7fuFGmW9SST8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=r7reQxyz3ksflfd/iSGFdMwfQPU24M66IYQoOYv0eUI=; b=Lds0zeFshaxWEbSK2uHaRLRFZA
        bOe0acyvaHjorj9dPxHaEAeMneDC/yURVVMAXEMlAmA5sN+Y+NOOkeldLp2pvICtEn+KpM+80v2Iq
        kmg5rDlDnKRRro4wcw/W4qSmxjSoJh676Q4EYX0HzxOmxzqWPbmJnwxw6kTHqoTBlXixRdkT5fcY2
        kIouLvLDvo3mVWtLEvg+R0kB6DhP7g7HVkAZvojz4jpz7PpOCS4uR56ivR1JR5F8itPthdhIrMRS1
        DsdTPiJnQC1bewiMf4Tyl8eMF4M6Huj26pHrfFckomMN0FUJnJC4CLBRXAqRcJlIiDqKnePHkGwv4
        nq16RbPg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:42040 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qZNIi-003pg7-2g;
        Thu, 24 Aug 2023 22:15:56 -0500
Message-ID: <fd700d21-aed7-ded0-1841-732aca570ef0@embeddedor.com>
Date:   Thu, 24 Aug 2023 21:16:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] wifi: mwifiex: Asking for some light on this, please :)
Content-Language: en-US
To:     Dan Williams <dcbw@redhat.com>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
References: <6e3fddfe-2d31-72fa-ac2b-3b7fa4e6fe08@embeddedor.com>
 <abc9d7abface4b9f651fc354ebaaf30ecf6e2783.camel@redhat.com>
 <3837e9ad-4d3b-40ae-a2f8-a051973ca3e5@embeddedor.com>
 <8e54e07eb0505302d601fd923e6cf0af0d60ff82.camel@redhat.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <8e54e07eb0505302d601fd923e6cf0af0d60ff82.camel@redhat.com>
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
X-Exim-ID: 1qZNIi-003pg7-2g
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:42040
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDyu8ffjhTMPJxklj32BwOi3OI8HiZAonXVoMbxY0Ax2wakdy110wkUqcKMb7E+BQ+bOnSKrui+B6g/79THk4kcs6MxHMm2udkqPjsp7WwbSq/T2fJIX
 uGevxB4WjrlTygiQFDdm9BPxUl58s4MD/KV/ghdvn7JQPx4vXr4+OBhf+gGVzuDYIZFRp6RaB7PeZlJjkvD/ggX88xZR+YdQ1cztyHARGUeNGCDIDcHylpdx
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Make the mwifiex_dbg() into a warning though. This is an error
> condition and shouldn't be hidden.
> 
>>                   mwifiex_dbg(priv->adapter, INFO,
>>                               "%pM tid=%d seq_num=%d bitmap_len=%d\n",
>>                               tlv_rxba->mac, tlv_rxba->tid, tlv_seq_num,
>>
>> I wanted to used `sizeof(*tlv_rxba) + tlv_bitmap_len` here instead of
>> `sizeof(tlv_rxba->header) + tlv_len` to avoid any issues in case there
>> is any (buggy) discrepancy between `tlv_len` and `tlv_bitmap_len`.
>> This is when for some (weird) reason
>>          `tlv_len - (sizeof(*tlv_rxba) - sizeof(tlv_rxba->header)) != tlv_bitmap_len`
> 
> tlv_len absolutely should also be checked. But you don't need that
> condition, just do the same thing right after tlv_len is retrieved from
> the header:
> 
> if (sizeof(tlv_rxba->header) + tlv_len > tlv_buf_left) {
>      <warn>
>      return;
> }
> 

Thanks for all the feedback, Dan:

https://lore.kernel.org/linux-hardening/cover.1692931954.git.gustavoars@kernel.org/

--
Gustavo
