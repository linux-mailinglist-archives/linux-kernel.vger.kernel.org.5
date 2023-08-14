Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4FC77C130
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjHNUBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjHNUBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:01:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F7210C8;
        Mon, 14 Aug 2023 13:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=kdJnqWVzzrscwN4ereKbPQx9d2p7ritar4asPO6GM3Y=; b=Iq6vxRjUZj/TrUv1wAFWiCfQM+
        DbMTbBiOT92+Duh5wcIUZDDlstKiI8w3Gs/WRo0dxSo32Bam2B8MQDDy0AffD/NYihRq9mvC3bA9X
        xbH6Hc7nGRvZddZODkQBYk07YuEpowGas8jyytfdHjbApQN9tRLMWVm1GaOuDaWeLhS7qQTOLuZdK
        9Dpk0/NioDsAJMBYbW3nP4RSrA5mQA87fAQB2DWP7ixapK5eyO8tthvL1yt1PjJBBrZ6zudXRhgb+
        W72GsS7Qf0xOA3JV2A0Yu3kuC+uqtCyDnOtflGc+2LHqubE82B4F+1WM/VBc+AaKjCI9iBB3mkcMM
        XYUaOt2Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVdkI-000G69-1M;
        Mon, 14 Aug 2023 20:00:58 +0000
Message-ID: <155add9d-241c-0e15-cc3b-a2ea22e8cdd0@infradead.org>
Date:   Mon, 14 Aug 2023 13:00:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] tpm_tis: Revert "tpm_tis: Disable interrupts on ThinkPad
 T490s"
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Richard Cochran <richardcochran@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20230814164054.64280-1-jarkko@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230814164054.64280-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 8/14/23 09:40, Jarkko Sakkinen wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 722b6eca2e93..6354aa779178 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6340,6 +6340,13 @@
>  			This will guarantee that all the other pcrs
>  			are saved.
>  
> +	tpm_tis.interrupts= [HW,TPM]
> +			Enable interrupts for the MMIO based physical layer
> +			for the FIFO interface. By default it is set to false
> +			(0). For more information about TPM hardware interfaces
> +			defined by Trusted Computing Group (TCG) look up to

s/look up to/see/ would be much better IMO.

> +			https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
> +

-- 
~Randy
