Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84327C938D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 10:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjJNIr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 04:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjJNIr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 04:47:56 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72881BB
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 01:47:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so4794335a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 01:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697273273; x=1697878073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/ZB1Xuba67ZGL+J/Ky5G/n0+9BlaRr5Ghf3uJthUKY=;
        b=SwC+5AC6ddIwBowSawOLD6mbAOjiRohzK7/c7W7oQ/1fw+YKcIdEiw7a+ybt+Llw3d
         YYSu97ygqoN5bWwZ1Og0VHT5RI/++qhDtJDp2M8n4rzIRTThJuE8QxwuJ/j1bGJXFmlE
         TrLx7IkUqo+0YA6/UDoLM1BITZe22yarKzTc1gmfi1WNm/MO50hHYz9LL8e58mNSZb2m
         qEpb88mpyiRni7XgGlESvC5FkvNcqoWAACqYxjldXzuoNClzRDbfoAchdf8cCvK8OaHR
         11XYbcuYqK6Mnv8zyu04UqWedEq0sa6M6cV7soCYaLeLsqg2ePsOoqTzt7dbmsvEXFWS
         DpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697273273; x=1697878073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/ZB1Xuba67ZGL+J/Ky5G/n0+9BlaRr5Ghf3uJthUKY=;
        b=Y3EJkuPof6s1pQcQme77MySMxqV3sGGk5xq/MgiPpOKSH4+QKY+LW3oLBgr0V+pB2X
         fNRNvUQ8nkngd34GKhsGJmKRtivM3gX0ztvwkqL20bUCsSTMwVpDyCfNgCS4vJoptEZN
         ALuoIIVJD0Q+HIPWBOSXo0+TjKFhhNpXgwZokmt9TDF7AY2B7xMEBuWjrW5EBjGT/ted
         jX4gfIfIChSCin1Kt1PnCui19uizcLaTtbOG7K63+NNNbCziNw2DUSPRCNOytQJ3j+TG
         YiqdBXwwr3LDNL3EAjAtO2IddtOo58eUP9Vqz39PF0OgLxnDl0DjccP336iX368ko8WP
         hBaw==
X-Gm-Message-State: AOJu0YxFwiZQ3FLjJK/zBlkS1cf55rWHLBn7b2iEgd71yuLqKBMmwpBD
        q8vnAkcX3YLtVNHarweQKlKJ6MZ73XE=
X-Google-Smtp-Source: AGHT+IH/J4DZUIZSI1zbYyxxR72NuE/vcCpASs4+u25uAqK8Y6bzH8mxI2qr8h/eOAJCe0xVmH77DA==
X-Received: by 2002:aa7:c549:0:b0:525:6e47:10f6 with SMTP id s9-20020aa7c549000000b005256e4710f6mr25869905edr.22.1697273272652;
        Sat, 14 Oct 2023 01:47:52 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id p22-20020a05640210d600b00530a9488623sm12441690edu.46.2023.10.14.01.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 01:47:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 14 Oct 2023 10:47:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH] x86/mm: fix pg_level_to_pfn for 5-level paging mode.
Message-ID: <ZSpVtZhks7Wm5Upc@gmail.com>
References: <20231013191703.422085-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013191703.422085-1-Ashish.Kalra@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ashish Kalra <Ashish.Kalra@amd.com> wrote:

> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Add support for 5-level paging in pg_level_to_pfn().
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/mm/mem_encrypt_amd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
> index 6faea41e99b6..45914568596a 100644
> --- a/arch/x86/mm/mem_encrypt_amd.c
> +++ b/arch/x86/mm/mem_encrypt_amd.c
> @@ -267,6 +267,10 @@ static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
>  		pfn = pud_pfn(*(pud_t *)kpte);
>  		prot = pud_pgprot(*(pud_t *)kpte);
>  		break;
> +	case PG_LEVEL_512G:
> +		pfn = p4d_pfn(*(p4d_t *)kpte);
> +		prot = p4d_pgprot(*(p4d_t *)kpte);
> +		break;

Mind explaining what happens if we don't have this fix, how you found it, 
which users are expected to be affected by it, whether that's the full 
known extent of 5-level paging support deficiencies in mem_encrypt_amd.c, 
etc?

In addition to such patches being much easier on the eyes, it also helps 
maintainers prioritize patches.

Thanks,

	Ingo
