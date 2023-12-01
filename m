Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B101B80043B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377629AbjLAHBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjLAHBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:01:17 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85110F9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:01:23 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d04dba2781so1951785ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701414083; x=1702018883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wLkcAdJ+2CsAW3aJ8yXqdMwiV/NfPGMVK63PMTslRyw=;
        b=2Elw92WzGfu65Y/N4KlozgnPOdR3QypYed6S3SCTR/40xb4jSGyozOol8Whbx9qdFh
         D5m1Vo88rxhpl+iS/BSxDh9LdkgNAYTWutzPQrRnX9M0THVrjaaU+Zr+0haTIHzQP3BL
         ummMEL00UnZHhs6yzXL9ypZcTYFCfymkjv9Hxas733IwzjwDspJl9cBeods8palyI0lf
         FfxtR0loliXtCZxZteupike6eb725sR6JQ7sEGpsmG8LHWiKtNk6P/jA2j+Ggpkmt+iF
         c5j2fSuU5XEVk0c4n/sHMXDAlocvnHIJN1JxpzQKGYnkeWvKOrWprfZsM8elp+3loVnR
         chLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701414083; x=1702018883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLkcAdJ+2CsAW3aJ8yXqdMwiV/NfPGMVK63PMTslRyw=;
        b=un1+1KuenbCZnj8Im3L1Ob7Hi0Ae21u/cMXiLS+fl/1rKIYoxOv8So86xsybw99yIU
         2H0Ue3MssUKoUu4jJTCUoypA8rG68KL/u1GqOqbMJaTUHJ8+/Dg/YYTp/MDnWe+nCoO3
         2GtZF6XyH1EMJpBi+K4p8AU75iZuUjaT/0SwMHmZlBDhpzK2SfHLwh2GkBArmXNiSxug
         fIBfG08JX/xhdC4XXD5L+meKtr7YGV7JHHxe/XGUtOdGCoPNcr2hBrmALBs+MLXuuPeN
         0ngYOKYgcbSvhbhgT0xueSc4/x8vFC3pkiPE2WUJoG9v52GGhB7C4KA48PltGSnqmnCG
         wBgQ==
X-Gm-Message-State: AOJu0Yy4XiZBMzNAWAELM7f6z/Z64oAoG5SsOIsvBj3sTpCRWeY4JiFX
        OwYi2urDTnstyfAgtC4a2mnwBQ==
X-Google-Smtp-Source: AGHT+IEJyFl/zGoptMCuEmKLI+dp8/8ucU2kEAd9blMdC49VG68hF4LLbtnlJ3Y8PFP7TIeaauolvw==
X-Received: by 2002:a17:903:2696:b0:1d0:551e:9388 with SMTP id jf22-20020a170903269600b001d0551e9388mr852110plb.7.1701414083278;
        Thu, 30 Nov 2023 23:01:23 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902f68600b001c72d5e16acsm2551032plg.57.2023.11.30.23.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:01:22 -0800 (PST)
Date:   Fri, 1 Dec 2023 07:01:19 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>
Subject: Re: [PATCH 08/21] binder: keep vma addresses type as unsigned long
Message-ID: <ZWmEv6-OBEZ08vy5@google.com>
References: <20231102185934.773885-9-cmllamas@google.com>
 <20231107090813.258015-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107090813.258015-1-aliceryhl@google.com>
X-Spam-Status: No, score=-13.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 09:08:13AM +0000, Alice Ryhl wrote:
> Carlos Llamas <cmllamas@google.com> writes:
> > -	seq_printf(m, " size %zd:%zd data %pK\n",
> > +	seq_printf(m, " size %zd:%zd data %lx\n",
> >  		   buffer->data_size, buffer->offsets_size,
> >  		   buffer->user_data);
> 
> This changes all of the print operations to use %lx instead of %pK,
> which means that the addresses are no longer being hidden when using
> kptr_restrict.
> 
> Since the pointers are all userspace pointers, it's not clear to me what
> the consequences of this are. However, I'd like to confirm whether this
> is an intentional change?

I confirm the change was intentional, we are giving the impression that
these are kernel pointers when they are not. However, I do think your
concern is valid. I've added a patch to v2 to deal with this.

I can tell you we are already logging the unhashed userspace addresses
in other places and we should probably fix those too.

--
Carlos Llamas
