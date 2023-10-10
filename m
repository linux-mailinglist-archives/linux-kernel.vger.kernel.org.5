Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33D47C4568
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbjJJXYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjJJXYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:24:37 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8A99D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 16:24:35 -0700 (PDT)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
        by cmsmtp with ESMTP
        id qHWHquqwFqBU3qM5ZqzeZI; Tue, 10 Oct 2023 23:24:34 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id qM5YqFFHlXnmZqM5ZqxmOi; Tue, 10 Oct 2023 23:24:33 +0000
X-Authority-Analysis: v=2.4 cv=RtHWkQqK c=1 sm=1 tr=0 ts=6525dd31
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=G-lt6N7Yx29dGf9IkNAA:9 a=QEXdDO2ut3YA:10 a=t_Z6pCN3e-wA:10
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sYBsanTMELU9eC2s0PIPTCW6urGWz8biLYZfCgY3QAM=; b=utjopGZ7CaIL1u6/a/GzwVrjg2
        DNDLoVvXCP9CmpaETVFerGq4v6W/BBP57Jq0gUco7gI30b24KOy9nbw4iiT3SfG2F/mvSh/r1FoVD
        OWEyoYJZ3eGY0QyFpwdmDSkKWKyJQMkGGCfJSAgEjjkMtlYN+tgOyQipb9ed778NWRKs80AvfDPQ/
        ozPlUPwp/XE+ISXPoCGUD/DDhGH//GNPh+5MLVl41t53LxBWN+tvVN3LjxJlXod3wgmjOKBRusP87
        ZHLDdOagkWPK4mDea/9ZLXObhhSb/1q7e6opW40AmzkpnXmHINLXQgU+NZKwJJ2JDrS3PTR50/Ngy
        0YiiFq3A==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:48998 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qqM5Y-003zTy-0x;
        Tue, 10 Oct 2023 18:24:32 -0500
Message-ID: <a3336eae-a24d-48c8-9c91-e9c989ec89db@embeddedor.com>
Date:   Tue, 10 Oct 2023 17:24:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] hostap: Add __counted_by for struct
 prism2_download_data and use struct_size()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZSRXXvWMMkm7qqRW@work> <202310101549.E09DE6F@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202310101549.E09DE6F@keescook>
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
X-Exim-ID: 1qqM5Y-003zTy-0x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:48998
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBQsFlnEP+lmaH4eAOWE5v2u6TjcUFpog/GaGJK8j6Bg7pc8nxr9njWI/Wg19EWVB9p1lkdCrcDhnn5iZw+tNmbQshKHJy2JY0g9CYvocMd0ouacTJXH
 ZRm9McjQmNfYt7zozc9kbpFGHLRqBLy4xGQu9EjDgZ8/QzOIjJlnmTej9t4iJ8qDgy9D92V0ol4dP7a/k5+Sx9WmD5fVvesHRca/QdUCm4M1jC94PVwgFqi5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I realize I didn't actually send my R-b for this thread, so here it is:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> :)
> 

Thanks! :)

--
Gustavo
