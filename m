Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4477F6A17
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjKXBXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKXBXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:23:30 -0500
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79197D68
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:23:37 -0800 (PST)
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
        by cmsmtp with ESMTPS
        id 68NHrmLKeL9Ag6KuurAR1z; Fri, 24 Nov 2023 01:23:36 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 6Kutrwdbv11XZ6KutrfP1b; Fri, 24 Nov 2023 01:23:36 +0000
X-Authority-Analysis: v=2.4 cv=Z+v/oVdA c=1 sm=1 tr=0 ts=655ffb18
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=yGeM7+xMb5a5VK1DGQx1ew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10
 a=hy65s6PCVsRWhxaC_Y0A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Xce5fXDshzVqJJD4AIumwGg26b48GuDNWNLxAdAWO74=; b=LMKE00oIG3u2KsxJv+PLCD9Yv2
        TI+u3cUJvVXVATHU2mXt26gL1aCjCT/9TGQZqHN9yxSQ9gmb1zoIW6AhHKNbfKdFbKvZE/DHn7dQO
        UicQOTYc+oqzwCvfM62Jktp/7Hzj66ZbIralhoP5V5ezgrq4RRnn2UuTGbBpjHe9ym2w+Zwpy6pjl
        9BzSK4uBLzyfNUi5XEqTk+x6z9rVjM1v2YNgt8GNFc79s2WPfHdo4oe+HtfP1DUOczQLFbbt7YaIH
        x9zCy59JJfig21czpfmh0XaBYL2ikB4hZ2jU2CTjfMv5ia4NTRnbOi2lXnXDuD5iWzorhjIEJRcAE
        fW4OLnfw==;
Received: from 187.184.157.122.cable.dyn.cableonline.com.mx ([187.184.157.122]:58578 helo=[192.168.0.25])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r6Kut-001U4W-0D;
        Thu, 23 Nov 2023 19:23:35 -0600
Message-ID: <17b92a96-f197-49f5-a040-35b65adae70a@embeddedor.com>
Date:   Thu, 23 Nov 2023 19:23:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the kspp-gustavo tree
To:     "Aithal, Srikanth" <sraithal@amd.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231122144814.649823ac@canb.auug.org.au>
 <813f3aa2-3449-7264-fa54-eaafd9981add@amd.com>
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <813f3aa2-3449-7264-fa54-eaafd9981add@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.122
X-Source-L: No
X-Exim-ID: 1r6Kut-001U4W-0D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.122.cable.dyn.cableonline.com.mx ([192.168.0.25]) [187.184.157.122]:58578
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE/n/9t5upwr2sksrBzhRawnMglhbbtk3muzKJKBGWZ7iMb5MwEa4QiiaixeG316xemZrmeMC0IPhCLgJ6AbpnxfZHby2iXqLjzm6gW/QwoMUP+u/Xb8
 LJppPDZEziHjoONwFpE0gwyiIfGFF0v8NAyQ1sZXVsv/mMFgKmOmP/gsJCsOcEShK+7EKdGzD8az4ynAsSSFYsK2zs8ldDEOSrAYgRdXjE5Y0MQHQ+LKZT9D
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> which version of gcc resolves this issue?

GCC 12.1.0

--
Gustavo
