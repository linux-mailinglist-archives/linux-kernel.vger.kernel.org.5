Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0774F81303F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573057AbjLNMff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573035AbjLNMfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:35:33 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0AD113;
        Thu, 14 Dec 2023 04:35:39 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6685322186;
        Thu, 14 Dec 2023 12:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702557337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYirUAC6N29fDSAllwGdxO1Cp96hi+jPjLKPL8qjsww=;
        b=jLeMy55drn0apwJhysUssEJko4fUz99Wqon+9cBC/NbwIHNgdSsw/47Asose1zLkmdhSFO
        e/ONvSchmdane62kHzdk9majyh0FXnpWzhdAmsQqxwwWDyvrL1xZafr9R3h7meDulJxvNE
        PwLaPU8M/HwtwDUAg+UqZgvADorvvng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702557337;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYirUAC6N29fDSAllwGdxO1Cp96hi+jPjLKPL8qjsww=;
        b=h7p8PaMbQYFVCTn+tBJi9d2azbewHW5gpEKL7n6g5NaxtLrQRhxsEvG64ks6sPBGaCVa54
        dcXjrqxDUo9SjnDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702557337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYirUAC6N29fDSAllwGdxO1Cp96hi+jPjLKPL8qjsww=;
        b=jLeMy55drn0apwJhysUssEJko4fUz99Wqon+9cBC/NbwIHNgdSsw/47Asose1zLkmdhSFO
        e/ONvSchmdane62kHzdk9majyh0FXnpWzhdAmsQqxwwWDyvrL1xZafr9R3h7meDulJxvNE
        PwLaPU8M/HwtwDUAg+UqZgvADorvvng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702557337;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYirUAC6N29fDSAllwGdxO1Cp96hi+jPjLKPL8qjsww=;
        b=h7p8PaMbQYFVCTn+tBJi9d2azbewHW5gpEKL7n6g5NaxtLrQRhxsEvG64ks6sPBGaCVa54
        dcXjrqxDUo9SjnDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F06CD1379A;
        Thu, 14 Dec 2023 12:35:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id bqEcN5j2emU8AgAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Thu, 14 Dec 2023 12:35:36 +0000
Message-ID: <f38ee1c0-a68e-b97b-ef92-038c949ee706@suse.cz>
Date:   Thu, 14 Dec 2023 13:35:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] Documentation, mm/unaccepted: document accept_memory
 kernel parameter
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>
References: <20231214-accept_memory_param-v2-1-f38cd20a0247@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231214-accept_memory_param-v2-1-f38cd20a0247@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ++++
Authentication-Results: smtp-out1.suse.de;
        dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jLeMy55d;
        dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=h7p8PaMb;
        dmarc=none;
        spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of vbabka@suse.cz) smtp.mailfrom=vbabka@suse.cz
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [4.29 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         BAYES_HAM(-0.00)[35.44%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         R_SPF_SOFTFAIL(4.60)[~all:c];
         RCPT_COUNT_FIVE(0.00)[6];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         DKIM_TRACE(0.00)[suse.cz:+];
         MX_GOOD(-0.01)[];
         DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         NEURAL_HAM_SHORT(-0.20)[-0.996];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: 4.29
X-Rspamd-Queue-Id: 6685322186
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC linux-mm

On 12/14/23 13:22, Vlastimil Babka wrote:
> The accept_memory kernel parameter was added in commit dcdfdd40fa82
> ("mm: Add support for unaccepted memory") but not listed in the
> kernel-parameters doc. Add it there.
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> changes since v1:
> - use shorter sentences (Tim Chen)
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65731b060e3f..91bd74b2e203 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1,3 +1,14 @@
> +	accept_memory=  [MM]
> +			Format: { eager | lazy }
> +			default: lazy
> +			By default, unaccepted memory is accepted lazily to
> +			avoid prolonged boot times. The lazy option will add
> +			some runtime overhead until all memory is eventually
> +			accepted. In most cases the overhead is negligible.
> +			For some workloads or for debugging purposes
> +			accept_memory=eager can be used to accept all memory
> +			at once during boot.
> +
>  	acpi=		[HW,ACPI,X86,ARM64,RISCV64]
>  			Advanced Configuration and Power Interface
>  			Format: { force | on | off | strict | noirq | rsdt |
> 
> ---
> base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
> change-id: 20231214-accept_memory_param-af395e3a2d45
> 
> Best regards,
