Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25707A2324
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbjIOP7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbjIOP7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:59:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B85D273D;
        Fri, 15 Sep 2023 08:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=SgsTNp3aBQfli6YIFCFMhJWlwcdQKsSE9wrATDvvIN8=; b=ZVMSwci4C8wywN9ZDPExFz2FO7
        LcPpHRMfW1ni3545nsbTpOeec5tgsLoYedy2ACetkzOPdktuzCoWU2lVxUN3fCaICXsREVYmnkGU8
        20qg0ZwsHZMU4gtZ6NWw6bzQ8/+tksTS4o9dV42v9QzZShPCcGfUFnhlPMvK/vKKus2ClzV6n//Vp
        yEl8V0DgSXCNgFNvl3kVpSI74AdDOPGv9teNcVofjmRUu9SFBjQFdIuFuNSCM936gCsPeN7nSZcgr
        StdpAZGC8StrLZqkqDNRH1obtHQ2I6i8xt2wNAkngv1WeKy/PaMIeZ7psHsCSuTlBtF6IPkHVyZYI
        XNAAaG+Q==;
Received: from [2601:1c2:980:9ec0:e65e:37ff:febd:ee53]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qhBDw-00B1cZ-2y;
        Fri, 15 Sep 2023 15:59:16 +0000
Message-ID: <287b3755-59a6-40e9-b6cc-f6336f69dd57@infradead.org>
Date:   Fri, 15 Sep 2023 08:59:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] docs: Update kernel-parameters.txt for signature
 verification enhancement
Content-Language: en-US
To:     "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>,
        linux-modules@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20230914112739.112729-1-alessandro.carminati@gmail.com>
 <20230914112739.112729-3-alessandro.carminati@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230914112739.112729-3-alessandro.carminati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/23 04:27, Alessandro Carminati (Red Hat) wrote:
> Update kernel-parameters.txt to reflect new deferred signature
> verification.
> Enhances boot speed by allowing unsigned modules in initrd after
> bootloader check.
> 
> Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0c38a8af95ce..beec86f0dd05 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3410,6 +3410,15 @@
>  			Note that if CONFIG_MODULE_SIG_FORCE is set, that
>  			is always true, so this option does nothing.
>  
> +	module_sig_check_wait=
> +			This parameter enables delayed activation of module
> +			signature checks, deferring the process until userspace
> +			triggers it. Once activated, this setting becomes
> +			permanent and cannot be reversed. This feature proves
> +			valuable for incorporating unsigned modules within
> +			initrd, especially after bootloader verification.
> +			By employing this option, boot times can be quicker.
> +

Please keep the entries here in alphabetical order.
This new entry should be after module_blacklist, not before it.
Thanks.

>  	module_blacklist=  [KNL] Do not load a comma-separated list of
>  			modules.  Useful for debugging problem modules.
>  

-- 
~Randy
