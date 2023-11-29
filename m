Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DC67FE0F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjK2UZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjK2UZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:25:34 -0500
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72A2D68
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:25:40 -0800 (PST)
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
        by cmsmtp with ESMTPS
        id 8PAjrK3uAL9Ag8R7sr2CSh; Wed, 29 Nov 2023 20:25:40 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 8R7rrAhMbqmEo8R7rrEo8r; Wed, 29 Nov 2023 20:25:39 +0000
X-Authority-Analysis: v=2.4 cv=P+8pOwMu c=1 sm=1 tr=0 ts=65679e43
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=7m0pAUNwt3ppyxJkgzeoew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=cm27Pg_UAAAA:8 a=OF05aalTVPlpCPcANIMA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X9PfSXn7t68Xlz7c+nvYbrRm7E2SUhd1bYPLGI3AcUY=; b=zd/RjNXClZW/9iU4JNIKXpXvVS
        SxEFr7kciKd2cTEIOajoIsZ+JzFyJjF5jpLqyCWRb/lE3FIvCE1385Ctj3s9kGVkXvqGuLWchSUmC
        yEXT6FuiJjBMyScyf+AEMaZMQ5LPupcq+d+Q3ct7RWDAp4sZiffJrMBq1NRQz1t0jJGDH0Ta50Ek7
        GODzdqXjRiETgDlx4g/6aCHR1o0zZvfKYF5ZS7uDsdNFDNa8zMEu2EwVGpfkQ6AWJb6+YRPOU2NTz
        CHtBE0V8mv5Ss/widskIPGwqI7Ba2kEW72z1V0vKgHp4tM1xxnfB6lPsMp8UU1b7gxwLq2HPZhdmR
        T27c4pww==;
Received: from 187.184.156.122.cable.dyn.cableonline.com.mx ([187.184.156.122]:36057 helo=[192.168.0.28])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r8R7q-003RPp-2V;
        Wed, 29 Nov 2023 14:25:38 -0600
Message-ID: <d63db040-1635-426a-8d3c-0b755187ba2e@embeddedor.com>
Date:   Wed, 29 Nov 2023 14:25:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] bcachefs: Replace zero-length arrays with
 flexible-array members
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZWYv/ywR/qxUhVSU@work> <202311291215.9BBCD8E@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202311291215.9BBCD8E@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.156.122
X-Source-L: No
X-Exim-ID: 1r8R7q-003RPp-2V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.156.122.cable.dyn.cableonline.com.mx ([192.168.0.28]) [187.184.156.122]:36057
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfO8Fs10z/L/PmoVBkrEKPVXZuNbGbqiDstinw40Ma05XdGZwr3HbHsmGnVNOKVgYlARphOWMaH5tzZ3Z3gthVQ8+OZUyvUyAKm5gLZkc5hX9ZT4T6zaf
 zFhOXw1cyh+z6UodWsv1UlmDn90/ZM3m7jpOdSXY6nUVjlLvm6BV1I2Qx7wxys4uo9YKSDuw3G+LjJ6nIEoXWOOdXa4IaViNNM3jb5MZekY6vGymO8NCl+3i
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/23 14:15, Kees Cook wrote:
> On Tue, Nov 28, 2023 at 12:22:55PM -0600, Gustavo A. R. Silva wrote:
>> Fake flexible arrays (zero-length and one-element arrays) are
>> deprecated, and should be replaced by flexible-array members.
>>
>> So, replace zero-length arrays with flexible-array members
>> in multiple structures.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> These look like straight-forward conversions. Thanks!

Yep, these also fix a buch of -Warray-bounds warnings reported
by 0-day:

https://lore.kernel.org/lkml/202311290720.TzNYq81c-lkp@intel.com/

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thanks!
--
Gustavo
