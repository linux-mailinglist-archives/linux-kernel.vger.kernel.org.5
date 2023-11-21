Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601EC7F3A38
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjKUXXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjKUXXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:23:22 -0500
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABB1112
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:23:19 -0800 (PST)
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
        by cmsmtp with ESMTPS
        id 5Bpmr7yiBKOkL5a5Orcjpy; Tue, 21 Nov 2023 23:23:19 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 5a5NrNwaakUbt5a5Orcx8n; Tue, 21 Nov 2023 23:23:18 +0000
X-Authority-Analysis: v=2.4 cv=WpU4jPTv c=1 sm=1 tr=0 ts=655d3be6
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=_Wotqz80AAAA:8
 a=VwQbUJbxAAAA:8 a=ZDCJzDVboqx1uGGEYfQA:9 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9TTVj2r9ym3H/3Y5iMg4QwMLFGalkbg7SD2uX0LagwM=; b=PHQ2S9kS1qGOr037HiUuQzx1UD
        pynpFI9nXM/kkynVNGdYCjMcFSRDK9Z4Ji+qobkRVM/qzmLxjq/aXeLlpaYgLhqkj/eNY/PRkzGZD
        5lr3XrDMSU6v6GRsnR7AcIoqnACaQJDUaQgoD3E1yHwCrWuOm9lwRenl+pueOPYVhteJtFyAJs41c
        nsPCZpY5F1NzRECyS69g3CWo0/6iSgiqIMGij71D5RCQbrGSaZInqgkIGOnxBTdFPe1UsqmB8JCzn
        3nVRc3IANVaO6LX+ZvHD7rVt1MDvOk/mKqpmOcfk05Ugy4wzuarf4VDGEtSQEJlWeHExRvykJvFR/
        aGNe4d9Q==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:39860 helo=[192.168.15.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r5a5N-000AhK-1E;
        Tue, 21 Nov 2023 17:23:17 -0600
Message-ID: <37ad0c83-4ea7-4707-bd90-3a0c08cc028b@embeddedor.com>
Date:   Tue, 21 Nov 2023 17:23:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the kspp-gustavo tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231122094739.38465ed3@canb.auug.org.au>
 <9d3b74ec-4a92-4304-b8ee-5f70711666bc@embeddedor.com>
 <20231122101928.55737aac@canb.auug.org.au>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231122101928.55737aac@canb.auug.org.au>
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
X-Exim-ID: 1r5a5N-000AhK-1E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:39860
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKptyCPHjfr5KaBOmV+0KQrO6KdC+zXzjjv5DhzkPLT7A5UJnZFsGtvVxTOyBtmha3H7h2pGCYpkZycDlkWGubsRpKOB0v3mwHuDelwSXCypssOmp8iw
 ank7K5jSNcch5bBnBLZu47CErSB+urZ6QLgVqv2ILsSY5h89y4nZAyK1iq9+x66RRdkCAbyyS+8WIs4OCnhmuqpvHvRJzXadPCYGpdXvspyPQu/B8QJL8ulr
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/23 17:19, Stephen Rothwell wrote:
> Hi Gustavo,
> 
> On Tue, 21 Nov 2023 17:07:32 -0600 "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>>
>> The fix for that shows up in linux-next already:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ca76817f4c4bbf8f98268772f4eeea8382a34bcd
> 
> OK, so if maintainers are putting fixes exposed by this change into
> their own trees, I need to merge your tree last then ...
> 

Yep; that seems to be the right way to go. :)

Thank you!
--
Gustavo
