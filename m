Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144EB7AD2B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjIYIJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjIYIJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:09:18 -0400
Received: from out-204.mta1.migadu.com (out-204.mta1.migadu.com [IPv6:2001:41d0:203:375::cc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33435D3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:09:12 -0700 (PDT)
Message-ID: <0b1ffbb6-12a6-22eb-f197-4a8f3bd2074c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695629348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpERSZPjS9SrT5Ng4mvbYMcfsd18YPCixhw2nkYJN5A=;
        b=Cr7G2KZPREjX8KAiWDkKy34BZegPhMZdrvvsF6gSLOarVhqcJw7Ho8I+fSTsGESaQA1djE
        PuPJDaxJMideDR1SnIRsNcdE6bjDQCRARuo0mp6KfkR+CEVmKSmJn99pN5JwxP2TCohh+3
        bOhln84/0Pjgpdt/r0upAGQ2E8+UwoM=
Date:   Mon, 25 Sep 2023 09:09:01 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: adjust header file entry in DPLL SUBSYSTEM
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230925054305.16771-1-lukas.bulwahn@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230925054305.16771-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2023 06:43, Lukas Bulwahn wrote:
> Commit 9431063ad323 ("dpll: core: Add DPLL framework base functions") adds
> the section DPLL SUBSYSTEM in MAINTAINERS and includes a file entry to the
> non-existing file 'include/net/dpll.h'.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference. Looking at the file stat of the commit above, this entry
> clearly intended to refer to 'include/linux/dpll.h'.
> 
> Adjust this header file entry in DPLL SUBSYSTEM.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9aa84682ccb9..cfa82f0fe017 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6363,7 +6363,7 @@ L:	netdev@vger.kernel.org
>   S:	Supported
>   F:	Documentation/driver-api/dpll.rst
>   F:	drivers/dpll/*
> -F:	include/net/dpll.h
> +F:	include/linux/dpll.h
>   F:	include/uapi/linux/dpll.h
>   
>   DRBD DRIVER

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
