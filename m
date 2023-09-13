Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2E979F4CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 00:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjIMWOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 18:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjIMWOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:14:05 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98505198B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 15:14:01 -0700 (PDT)
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
        by cmsmtp with ESMTP
        id gU3YqCmhCWU1cgY7Uq9GoM; Wed, 13 Sep 2023 22:14:00 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id gY7TqxXZHXfVegY7Tqb6mq; Wed, 13 Sep 2023 22:14:00 +0000
X-Authority-Analysis: v=2.4 cv=VrIwvs6n c=1 sm=1 tr=0 ts=65023428
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=jFRxq2wKO8WXaxfeKaYA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dZ4X6+zZMXjSOhvMDt4VTdB7ETyMBxc+LRS7AMiNx4o=; b=tPyPbdnZPEEKMvZ4zkMTNoUiA6
        pmMAqnXt1JqSfMxaJEoUls89aL+Q9OHRGIJg8W7ngxqTwDC8+XfJangsgN6WC6Hqu9lEZJLLNGTeC
        xSJ/sJVjl2Ci8svmjP/NAxuniAvYvXRTguaPhJ9v3NlAR7LnlFSOftzFCAUEzxMWeq+oAkTx4mtZO
        9et6bJI2KYs3R4RZ1+p4912wdKN1JaZ5p1FekNrI++5NbCBjLodauDyun9vjGdInSf5cuEPR0wJqi
        xS9npUqrp6V+mnhWoQE3b8PHaIofEbp7GM5O2cp2KcmwG5X0Z7/zP7R1Xne5IW3PhHZtmFLW3xZEn
        zFUOzWLA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:39334 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qgY7T-001lOu-0P;
        Wed, 13 Sep 2023 17:13:59 -0500
Message-ID: <968f8168-1a0f-c916-86fb-fe4d89bb6250@embeddedor.com>
Date:   Wed, 13 Sep 2023 16:14:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] checkpatch: Add a couple new alloc functions to alloc
 with multiplies check
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Gustavo Silva <gustavoars@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1694636817.git.joe@perches.com>
 <edb667e19211652a32ef6069159bb85dbc3bcdfc.1694636817.git.joe@perches.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <edb667e19211652a32ef6069159bb85dbc3bcdfc.1694636817.git.joe@perches.com>
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
X-Exim-ID: 1qgY7T-001lOu-0P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:39334
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfACw8y3edszWC6JoToOLqEK2bRo2eTk1je3gFShdX+smiNC0zPTzKSFGOLKLcgXvG0J25FPsyazVkzZnftAJERdrC8HkO//Ya6HEHpU+E7yk2V6Fq9Oj
 ehXIsqbIyieyOQKhhKgSzmV8bkRDbxIeQ859UoPJeIkEMa6RgGcDoadVCTBEHyIWz4VkGPNZEozevV7gTiR13zoHtiHTM11JJXK9eJ+myt0Pt8qssmFaiZiH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/23 14:37, Joe Perches wrote:
> vmalloc() and vzalloc() functions have now 2-factor multiplication
> argument forms vmalloc_array() and vcalloc(), correspondingly.
> 
> Add alloc-with-multiplies checks for these new functions.
> 
> Simplify the original codes repeated else to use a hash.
> 
> Link: https://github.com/KSPP/linux/issues/342
> 
> Original-patch-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Why don't you wait for a response or a v2 from the original
submitter?

--
Gustavo

