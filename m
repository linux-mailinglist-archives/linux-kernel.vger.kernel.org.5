Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9921077C3A8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjHNWww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjHNWws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:52:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B3E12D;
        Mon, 14 Aug 2023 15:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=N+FDtRfvMDT6hVxzXu0XfcRPzq1+yZ03REJLjq8HX4g=; b=R+MiMl2LJBYZulPd4n0uNnZqli
        8lTwRuKFU2IYuIXXGSNLbGX0/l0x5+0iuJh8w2SCySZqGy+nrrVzIIhQqS05HVp0KXP/k/1m558YZ
        yXTGLM7Cq6P6FjL2IdmgmAMyxwg3nKy0ODuYOorEv5DXC4bsPKUxBNgVb5eiIPcsY8e6pyASOd+Hm
        VHyosJARJ1SlyYmWjrScsGZbfUuT9/VLxWLXxvE6w18NgXtVwQ2uYCfLjs4kMd82L/f5QScUMJPU4
        h4g2sP64xqPOh6SYEXS/hOh/omtyiRg1Zk5sY+LTIF8AgX7pyqAGP+/SFRZUvNHoIFAzk2XOGcrXc
        POGqiiRQ==;
Received: from [2601:1c2:980:9ec0::577]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVgQS-004h23-MP; Mon, 14 Aug 2023 22:52:41 +0000
Message-ID: <af8f2613-5a74-3c2e-f076-345f725aaa5a@infradead.org>
Date:   Mon, 14 Aug 2023 15:52:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] Documentation: devices.txt: Fix minors for ttyCPM*
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <b5deb1222eb92017f0efe5b5cae127ac11983b3d.1691992627.git.christophe.leroy@csgroup.eu>
 <27d7124cf86157e2a27c2b039e769041994d3f22.1691992627.git.christophe.leroy@csgroup.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <27d7124cf86157e2a27c2b039e769041994d3f22.1691992627.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/13/23 23:02, Christophe Leroy wrote:
> ttyCPM* devices belong to CPM_UART driver at the first place
> and that driver provides 6 ports.
> 
> Fixes: e29c3f81eb89 ("Documentation: devices.txt: reconcile serial/ucc_uart minor numers")
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

I had this on my todo list. Thanks for getting to it before I did.

> ---
>   Documentation/admin-guide/devices.txt | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
> index 1ba5b7c4973c..839054923530 100644
> --- a/Documentation/admin-guide/devices.txt
> +++ b/Documentation/admin-guide/devices.txt
> @@ -2691,7 +2691,7 @@
>   		 45 = /dev/ttyMM1		Marvell MPSC - port 1 (obsolete unused)
>   		 46 = /dev/ttyCPM0		PPC CPM (SCC or SMC) - port 0
>   		    ...
> -		 49 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 3
> +		 51 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 5
>   		 82 = /dev/ttyVR0		NEC VR4100 series SIU
>   		 83 = /dev/ttyVR1		NEC VR4100 series DSIU
>   		 148 = /dev/ttyPSC0		PPC PSC - port 0
> @@ -2752,7 +2752,7 @@
>   		 43 = /dev/ttycusmx2		Callout device for ttySMX2
>   		 46 = /dev/cucpm0		Callout device for ttyCPM0
>   		    ...
> -		 49 = /dev/cucpm5		Callout device for ttyCPM5
> +		 51 = /dev/cucpm5		Callout device for ttyCPM5
>   		 82 = /dev/cuvr0		Callout device for ttyVR0
>   		 83 = /dev/cuvr1		Callout device for ttyVR1
>   
