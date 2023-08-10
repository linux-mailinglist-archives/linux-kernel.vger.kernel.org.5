Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0616F7782DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjHJVuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjHJVuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:50:50 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D2C30CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:50:35 -0700 (PDT)
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
        by cmsmtp with ESMTP
        id TojVqMMGQfaVXUDY9qNf6p; Thu, 10 Aug 2023 21:50:33 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id UDY8qttZBqqmzUDY9qplJz; Thu, 10 Aug 2023 21:50:33 +0000
X-Authority-Analysis: v=2.4 cv=b5ahX/Kx c=1 sm=1 tr=0 ts=64d55ba9
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=c7P8IOsjiO9zm4Xs_OAA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N4LwCmZmu8Qi0zP718AGZRcxN+/+SzgTW0w6lkTTTYk=; b=Hn1RBXsehMIa5WQqHhxt3DZ9KR
        wI/ZbhM9WFlcghBwguWxa3S6O7YL8pG9TqfCBoc9KI5P3CxX5o8czbQMVd9S7tng4lduHs8NakpRl
        OSKz+B3cnW4LhPURXxm/+LOwxuhZJFz25gZ2C8RgW38ntvoiHi4smFapEJmWnxyx9c92NnlbYC0h1
        znce0vhn5vGNuQTvg3M3I9Peff6kmmHGo1n9emL+JFx7P0C6oqF75daCJphSJ0msh1sBadtNf2Zeu
        nzMQev4Qlf1MeOFVb23y9SLd9e7QAk7ziTqqhr/O3isIeUCHP5jkORWNhfkf/pYDyV77VbGtvdXRS
        wHjTag8g==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:50906 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qUDY6-000TYv-2k;
        Thu, 10 Aug 2023 16:50:30 -0500
Message-ID: <f4caa3f6-66d2-db44-0e21-900fe663da48@embeddedor.com>
Date:   Thu, 10 Aug 2023 15:51:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Intel-wired-lan] [PATCH 2/4][next] i40e: Replace one-element
 array with flex-array member in struct i40e_profile_segment
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1690938732.git.gustavoars@kernel.org>
 <52da391229a45fe3dbd5c43167cdb0701a17a361.1690938732.git.gustavoars@kernel.org>
 <20230810173404.jjuvqo5tv57en7pg@google.com>
 <20230810204953.wwwvbl57m3cebf27@google.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230810204953.wwwvbl57m3cebf27@google.com>
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
X-Exim-ID: 1qUDY6-000TYv-2k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:50906
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHTlwyGdk0olE92c0F0ML+XdMks3Y420vsgwJOdj8+NXFD5+rEpIb6wXhEuvtNYXJHi+I9muLHEmsDXjn30ik/+Z5rE6EKWlc9S+B3t9Ft2CLiUlSQ5O
 vWcIcuAppn/IWv6Doc6SGOehJ9hZzDvMr+ufnnYUkmPZOQ/j+/C8qDNGchVC/w5XgaupZvJ3E67rjss/DB4tsZLIYFRE7uac5JHnLaHyNVSRwrfGYUmHRSAG
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/23 14:49, Justin Stitt wrote:
> On Thu, Aug 10, 2023 at 05:34:04PM +0000, Justin Stitt wrote:
>> On Tue, Aug 01, 2023 at 11:05:59PM -0600, Gustavo A. R. Silva wrote:
>>> One-element and zero-length arrays are deprecated. So, replace
>>> one-element array in struct i40e_profile_segment with flexible-array
>>> member.
>>>
>>> This results in no differences in binary output.
>>>
>>> Link: https://github.com/KSPP/linux/issues/335
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>>   drivers/net/ethernet/intel/i40e/i40e_type.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> Tested-by: Justin Stitt <justinstitt@google.com>
> Whoops, this should be:
> Reviewed-by: Justin Stitt <justinstitt@google.com>
> 
> I did not test, I just verified there are no binary differences produced
> by this patch.

In that case, `Build-tested-by` seems more appropriate.

Anyways, the series has been applied already.

--
Gustavo

