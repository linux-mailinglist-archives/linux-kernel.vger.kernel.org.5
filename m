Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFE07DBCD9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjJ3Pnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjJ3Pnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:43:49 -0400
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Oct 2023 08:43:46 PDT
Received: from p3plwbeout16-03.prod.phx3.secureserver.net (p3plsmtp16-03-2.prod.phx3.secureserver.net [173.201.193.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879A3C5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:43:46 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.145])
        by :WBEOUT: with ESMTP
        id xUNvqEcsEa122xUNwqv52s; Mon, 30 Oct 2023 08:41:00 -0700
X-CMAE-Analysis: v=2.4 cv=M96Ilw8s c=1 sm=1 tr=0 ts=653fce8c
 a=7e6w4QD8YWtpVJ/7+iiidw==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=AUd_NHdVAAAA:8
 a=FXvPX3liAAAA:8 a=sbCGcgdyxKFDu1RXnnQA:9 a=QEXdDO2ut3YA:10
 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  xUNvqEcsEa122
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.90])
        by smtp13.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1qxUNv-000365-7P; Mon, 30 Oct 2023 15:40:59 +0000
Message-ID: <46d308b2-5e59-862d-b429-e6ee418bc61e@squashfs.org.uk>
Date:   Mon, 30 Oct 2023 15:40:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] docs: filesystems: document the squashfs specific
 mount options
To:     Ariel Miculas <amiculas@cisco.com>
Cc:     linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, serge@hallyn.com,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <20231029161924.50648-1-amiculas@cisco.com>
 <bd039dc7-cfe5-c210-b65e-0cba3186ee0b@squashfs.org.uk>
 <qgwx4cjswrhzxqijsosix437xyw3ifglv6uz2d3nq7whkjqueo@c5pzoqtoqtgb>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <qgwx4cjswrhzxqijsosix437xyw3ifglv6uz2d3nq7whkjqueo@c5pzoqtoqtgb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfMeHZc0FBkxvO9LGjmWOEuppPia+lXkF5ccS+1CuDXuGy1obqdBSbw96wuG/B6E1W0LDjmj5t0vE6j6/wi55tk8NoEZcpHLX3jBjQmnRWAO8q1QSozeu
 +yfAy2I8gCFCCQ3zyuDv/5eUBpFYSI+0Rzsmf0j/5LftRGmrpOYoNVcV5a+TgRam8SekZ2alFnu1fXdCAbkcPZHjoVCdy20u+do4+ivqculcwBnzhxkSf3sZ
 WEvnfiZvvo3FU5Qh8nYTqw==
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2023 12:57, Ariel Miculas wrote:
> On 23/10/29 08:33PM, Phillip Lougher wrote:
>> On 29/10/2023 16:19, Ariel Miculas wrote:
>>> When SQUASHFS_CHOICE_DECOMP_BY_MOUNT is set, the "threads" mount option
>>> can be used to specify the decompression mode: single-threaded,
>>> multi-threaded, percpu or the number of threads used for decompression.
>>> When SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set and
>>> SQUASHFS_DECOMP_MULTI is set, the "threads" option can also be used to
>>> specify the number of threads used for decompression. This mount option
>>> is only mentioned in fs/squashfs/Kconfig, which makes it difficult to
>>> find.
>>>
>>> Another mount option available is "errors", which can be configured to
>>> panic the kernel when squashfs errors are encountered.
>>>
>>> Add both these options to the squashfs documentation, making them more
>>> noticeable.
>>>
>>> Signed-off-by: Ariel Miculas <amiculas@cisco.com>
>>
>> Looks good to me.
>>
>> Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>
> 
> Unfortunately, it seems this is not quite correct either:
> There is the config option SQUASHFS_MOUNT_DECOMP_THREADS:
> ```
> 	bool "Add the mount parameter 'threads=' for squashfs"
> 	depends on SQUASHFS
> 	depends on SQUASHFS_DECOMP_MULTI
> 	default n
> 	help
> 	  Use threads= to set the decompression parallel mode and the number of threads.
> 	  If SQUASHFS_CHOICE_DECOMP_BY_MOUNT=y
> 	      threads=<single|multi|percpu|1|2|3|...>
> 	  else
> 	      threads=<2|3|...>
> 	  The upper limit is num_online_cpus() * 2.
> ```
> that depends on SQUASHFS_DECOMP_MULTI.
> So I think I should take my v1 patch and specify that the "threads="
> mount option depends on SQUASHFS_MOUNT_DECOMP_THREADS. There's no need
> to specify SQUASHFS_DECOMP_MULTI, because SQUASHFS_MOUNT_DECOMP_THREADS
> already depends on it.

Sorry, you have to specify SQUASHFS_DECOMP_MULTI to be able to specify
SQUASHFS_MOUNT_DECOMP_THREADS if SQUASHFS_DECOMP_BY_MOUNT is unselected.

Just try it, do make menuconfig, ensure SQUASHFS_CHOICE_DECOMP_BY_MOUNT
is unselected, select Single threaded decompression and you won't be
able to specify SQUASHFS_MOUNT_DECOMP_THREADS.

That was the point of my review. What bit don't you understand?

Phillip

> What do you think?
> 
> Regards,
> Ariel
> 

