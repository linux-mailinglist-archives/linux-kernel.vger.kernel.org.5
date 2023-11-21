Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66777F2478
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 04:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjKUDEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 22:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKUDEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 22:04:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89042BA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 19:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700535870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2grcs2rWzHb9qBsJYwUc4VAquVR8IwPBKlprjizeaOU=;
        b=K4eYr0LTCT2tvXWBPaM8sOKCvannABm4y+VIs1UFkY61p42ajFnRQ7Pw4g8/oU+sn2xsnw
        3N+Q0dZqxcOMpBus4/PZSJRs4KYTvowqiOK+CrMYhfc7BkYaEYE+CO6l/lzxGxDrM8ncdh
        Cawxu7gWq4XWfuqMHH493rLma1ij840=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-xIZaviGINzC9ovKbejFUAw-1; Mon, 20 Nov 2023 22:04:24 -0500
X-MC-Unique: xIZaviGINzC9ovKbejFUAw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E22D185A780;
        Tue, 21 Nov 2023 03:04:24 +0000 (UTC)
Received: from [10.22.8.109] (unknown [10.22.8.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4450BC1596F;
        Tue, 21 Nov 2023 03:04:24 +0000 (UTC)
Message-ID: <569119a8-f6f2-4e00-bfcc-5b804447320f@redhat.com>
Date:   Mon, 20 Nov 2023 22:04:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel/cgroup/debug.c:1: warning: no structured comments found
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
References: <202311211005.Qwt1FHrO-lkp@intel.com>
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <202311211005.Qwt1FHrO-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/20/23 21:32, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
> commit: a28f8f5e995fe5964ae304444913536058f26e37 cgroup: Move debug cgroup to its own file
> date:   6 years ago
> config: i386-buildonly-randconfig-005-20231120 (https://download.01.org/0day-ci/archive/20231121/202311211005.Qwt1FHrO-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211005.Qwt1FHrO-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311211005.Qwt1FHrO-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> kernel/cgroup/debug.c:1: warning: no structured comments found
>
> vim +1 kernel/cgroup/debug.c
>
>     > 1	#include <linux/ctype.h>
>       2	#include <linux/mm.h>
>       3	#include <linux/slab.h>
>       4	

Yes, there is no function in this file with structure comments. This 
debug controller is used for debugging only and is not supposed to be 
used on production systems anyway. Its interface is unstable and so I 
don't see a need to properly document its interface.

I will leave this file as it is for now.

Cheers,
Longman

