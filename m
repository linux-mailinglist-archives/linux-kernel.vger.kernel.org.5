Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFF27D26EF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 01:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJVXTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 19:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVXT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 19:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374B9E6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 16:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698016720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jX1G92KJ9HaLCLXW5bUq4SsuwL/Pf25kDHN6JaMRMeE=;
        b=XAGucvDs7TLzj3XmW5siQImBmVEjz+VgWSPE4s6sZ/+9QtMB9b5TqnPHoEL+QI9+04cfI3
        j2dqujlegNzBqZdq+re82hyCcVdQ2Y02/C7l4dspo4qtaRMmayB/48QOr3eshk2sP9u6rE
        +4F4smFb4fsGVFBuPL1Al14mOaOtZe4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-4n3qW8V3Pkmn-zUTc4khOg-1; Sun, 22 Oct 2023 19:18:35 -0400
X-MC-Unique: 4n3qW8V3Pkmn-zUTc4khOg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BB0529AA2EF;
        Sun, 22 Oct 2023 23:18:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 343C3503B;
        Sun, 22 Oct 2023 23:18:33 +0000 (UTC)
Date:   Mon, 23 Oct 2023 07:18:31 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Costa Shulyupin <costa.shul@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] kdump: fix reference to nonexistent file
Message-ID: <ZTWtxzSojtHMwrHu@MiWiFi-R3L-srv>
References: <20231022190424.919982-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231022190424.919982-1-vegard.nossum@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/23 at 09:04pm, Vegard Nossum wrote:
> All the s390 docs were moved from Documentation/s390/ to
> Documentation/arch/s390/ but this reference didn't get updated. Fix it.
> 
> Fixes: 37002bc6b603 ("docs: move s390 under arch")
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Costa Shulyupin <costa.shul@redhat.com>
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: kexec@lists.infradead.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  kernel/Kconfig.kexec | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 9bfe68fe9676..7aff28ded2f4 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -110,7 +110,7 @@ config CRASH_DUMP
>  	  For more details see Documentation/admin-guide/kdump/kdump.rst
>  
>  	  For s390, this option also enables zfcpdump.
> -	  See also <file:Documentation/s390/zfcpdump.rst>
> +	  See also <file:Documentation/arch/s390/zfcpdump.rst>
>  
>  config CRASH_HOTPLUG
>  	bool "Update the crash elfcorehdr on system configuration changes"
> -- 
> 2.34.1
> 

