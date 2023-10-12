Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB747C75C7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441945AbjJLSVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379624AbjJLSVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:21:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6635ACA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:21:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a645e54806so199207166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697134891; x=1697739691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JcB95Amibgw0phr7xM38p2RHGuYQp8QNhqrDp7sB1Mc=;
        b=Jig4igLWh0cJ/gcNOGTdD1TIH9Rqq/xTA1z4zi8nFQ9g9MIR6nHRt6CTaraB+C0NsM
         LW9mklXOiMTJn+xfwLtgBGXp+LPjEXLQ5+IN9IXamEKjF3uWjCc5BIMtSgiukYeLqxMK
         Jf7ruHza8IBVHBZb9NrcvefPGZIWCwXiDwhEI4UHrPdE3i9qKvRtUdlEJxE1dLTRIILK
         UoY6pez8rqPNC9oAhc94ItEeO62C9AWJurlw3mbslLZLiWVWqoDV86ugDwqn43xX+TMA
         riJSJ57rzUFgS9TMvBQvNuWE8f1wp5X+ykbMaYOi1FbCw+QKuxk62thhvPpfzmIYmN7n
         AbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697134891; x=1697739691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcB95Amibgw0phr7xM38p2RHGuYQp8QNhqrDp7sB1Mc=;
        b=BhyT0fLzMiuk2JZxcg9jA9FzbaagudCltlK0ZdHQRZTiw0BQpbzstrQ3+PHfq12Kyw
         48HwWp7kVPzET2iiG9tenasJI4t/EIekRlkfTXGB5eyjXhZ3gSja+heBURDiSXENqjem
         m/em1boAvsKhvvqm2/3lG8OJdKt2Ny+1uPPgHz5vddfJHy3+STnfRfRMvXfAR48iqhjJ
         VF1DZ0qrlDFjIWU3A7F3pIVcrm1pPTKBrn5m2hYbEAXUfwBJvYhj5iPPQiOlzG1GGQaT
         pIfaRjcdgi1rUQyQPBUcDKotixEY9J7qArmkV96ge4Zr6rDgQBe6K6KQcRwWF03PDSX6
         nIBQ==
X-Gm-Message-State: AOJu0Yx7Rk1setpcp35f13XlVi6LbfNoELpGE5PBGW+bqee2+JHYfdVF
        A8gC2Uu3RK7DAQPOL93Yvlg=
X-Google-Smtp-Source: AGHT+IFNB1MjV6mY5/xScvMdbZ8ZimtMwpBA/yPbpXIM6+xyPuWifWg6z3oV7Hi1JFejqEqBdm/qww==
X-Received: by 2002:a17:906:2921:b0:9b9:faee:4228 with SMTP id v1-20020a170906292100b009b9faee4228mr16098461ejd.56.1697134890672;
        Thu, 12 Oct 2023 11:21:30 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id kf24-20020a17090776d800b009b95787eb6dsm11287391ejc.48.2023.10.12.11.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 11:21:30 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Oct 2023 20:21:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexey Gladkov <legion@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/2] seqlock: change __seqprop() to return the
 function pointer
Message-ID: <ZSg5KAFxVzKoFlhZ@gmail.com>
References: <20231012143158.GA16133@redhat.com>
 <20231012143227.GA16143@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012143227.GA16143@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@redhat.com> wrote:

> This simplifies the macro and makes it easy to add the new seqprop's
> with 2 or more args.
> 
> Plus this way we do not lose the type info, the (void*) type cast is
> no longer needed.
> 
> And the latter reveals the problem: a lot of seqcount_t helpers pass
> the "const seqcount_t *s" argument to __seqprop_ptr(seqcount_t *s)
> but (before this patch) "(void *)(s)" masked the problem.
> 
> So this patch changes __seqprop_ptr() and __seqprop_##lockname##_ptr()
> to accept the "const LOCKNAME *s" argument. This is not nice either,
> they need to drop the constness on return because these helpers are used
> by both the readers and writers, but at least it is clear what's going on.

> +__seqprop_##lockname##_ptr(const seqcount_##lockname##_t *s)		\
>  {									\
> +	return (void *)&s->seqcount; /* drop const */			\
>  }									\

> +static inline seqcount_t *__seqprop_ptr(const seqcount_t *s)
>  {
> +	return (void *)s; /* drop const */
>  }

Okay, so dropping 'const' makes sense in terms of staying bug-compatible
with the  previous API and not build-breaking the world - but could we
perhaps follow this up with fixups of the type misuse and then a removal
of the forced type casts from these APIs?

Meanwhile I'm applying your patches to tip:locking/core, unless someone objects.

Thanks,

	Ingo
