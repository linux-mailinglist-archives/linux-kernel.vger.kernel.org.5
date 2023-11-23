Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61FC7F5D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbjKWK6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbjKWK6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:58:18 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2314BD5A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:58:24 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b36b9d9faso25485e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700737102; x=1701341902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tbD+CZLI2OJnj2XtkqlWGnXInTbmUcqYNyaWG++MW1o=;
        b=HiCbmO1BCtoKlVmh18VYckeBAc5s9WLFAyvriomLKnssA+fkK10s+kuXB7ezYpIP3+
         2V+SajP1cU0De+rGG9wS6QlfJDJC5gOkJ1uJCS6z7chJKc+jE1rOg4FAA8xiEjHgTTN4
         TQs1qwRT3o0oIs7xuTiUdCddU4q712zXF9r6oEi40DBB7nrE3TOSfIQB7nx32+n2cEjW
         Pb8Zsc92s/U5XmbkktMs1FKtqlumC2e7ifoXgmEhvTFqehNIJoQmCyIdMq6uzf1yYUY5
         wjzEm3K8Dhd84efV+bmIor0+DkSKy/Ksj7ga1g7bP3Q67F1XQiFWzr40S30t4+Qy7YnH
         vy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700737102; x=1701341902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbD+CZLI2OJnj2XtkqlWGnXInTbmUcqYNyaWG++MW1o=;
        b=pk1RUF+4t719C4GHNfGQbC6Zf9dzwqi8/9dEgqh3NaCmh5GMPCHnL0l1YFabII4J43
         YBKSY7G3Zqsl7AyBfh5f6l/S1rR+XTS5ZUNbX7E+BTiOkiu0X48OoR12515eEEBPP0Vx
         SfSlBK1oA184MsOegt7SPOuYxROrYmuNuphlGw0Nc47dMEAVV/rlI9LXZ3A4GBbEA/l2
         1pIrkxbBfElafZYluxtRPUFoxOET9rUrm2AtFgwGZEEnX+3qYLPWRuk01OyrbdIYR8HU
         59vzLv+ne1Heoi0GEKpG22yDeNuoIOdZAio+Kgjq9W2lmbjOztpXFzJwXcUl52UdYYZQ
         f09g==
X-Gm-Message-State: AOJu0YywNGxoRo5RXm8YGcPiCU2eKu5Qjn9HAUgq8LXnaTrVz3WQkJyM
        aRms3mbqRk5VF29N4PEdm8RACg==
X-Google-Smtp-Source: AGHT+IECpNi7V/qSvW7pVQ/CJFY4C0ksNj+vFUmeqFagu+qFkUWQoOPShJMnthXGa96ey5y1uPJSiw==
X-Received: by 2002:a05:600c:3b13:b0:40a:483f:f828 with SMTP id m19-20020a05600c3b1300b0040a483ff828mr251605wms.4.1700737102403;
        Thu, 23 Nov 2023 02:58:22 -0800 (PST)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id k11-20020adfe3cb000000b00332d3c78e11sm1305204wrm.85.2023.11.23.02.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:58:21 -0800 (PST)
Date:   Thu, 23 Nov 2023 10:58:20 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     will@kernel.org, James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
        mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vdonnefort@google.com, qperret@google.com, smostafa@google.com
Subject: Re: [PATCH v3 10/10] arm64: ptdump: Add support for guest stage-2
 pagetables dumping
Message-ID: <ZV8wTMtuztSdzPaI@google.com>
References: <20231115171639.2852644-2-sebastianene@google.com>
 <20231115171639.2852644-12-sebastianene@google.com>
 <ZV6QXSV_SrYjjoE_@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV6QXSV_SrYjjoE_@linux.dev>
X-Spam-Status: No, score=-16.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:35:57PM +0000, Oliver Upton wrote:
> On Wed, Nov 15, 2023 at 05:16:40PM +0000, Sebastian Ene wrote:
> > +struct ptdump_registered_guest {
> > +	struct list_head		reg_list;
> > +	struct ptdump_info		info;
> > +	struct kvm_pgtable_snapshot	snapshot;
> > +	rwlock_t			*lock;
> > +};
> 
> Why can't we just store a pointer directly to struct kvm in ::private?

I don't think it will work unless we expect a struct kvm_pgtable
in stage2_ptdump_walk file_priv field. I think it is a good ideea and will
simplify things a little bit dropping kvm_pgtable_snapshot from here.

The current code has some fileds that are reduntant (the priv pointers)
because I also made this to work with protected guests where we can't
access their pagetables directly.

> Also, shouldn't you take a reference on struct kvm when the file is
> opened to protect against VM teardown?
>

I am not sure about the need could you please elaborate a bit ? On VM
teardown we expect ptdump_unregister_guest_stage2 to be invoked.

> > +static LIST_HEAD(ptdump_guest_list);
> > +static DEFINE_MUTEX(ptdump_list_lock);
> 
> What is the list for?
> 

I am keeping a list of registered guests with ptdump and the lock should
protect the list against concurent VM teardowns.

> >  static phys_addr_t ptdump_host_pa(void *addr)
> >  {
> >  	return __pa(addr);
> > @@ -757,6 +768,63 @@ static void stage2_ptdump_walk(struct seq_file *s, struct ptdump_info *info)
> >  	kvm_pgtable_walk(pgtable, start_ipa, end_ipa, &walker);
> >  }
> >  
> > +static void guest_stage2_ptdump_walk(struct seq_file *s,
> > +				     struct ptdump_info *info)
> > +{
> > +	struct ptdump_info_file_priv *f_priv =
> > +		container_of(info, struct ptdump_info_file_priv, info);
> > +	struct ptdump_registered_guest *guest = info->priv;
> > +
> > +	f_priv->file_priv = &guest->snapshot;
> > +
> > +	read_lock(guest->lock);
> > +	stage2_ptdump_walk(s, info);
> > +	read_unlock(guest->lock);
> 
> Taking the mmu lock for read allows other table walkers to add new
> mappings and adjust the granularity of existing ones. Should this
> instead take the mmu lock for write?
>

Thanks for pointing our, this is exactly what I was trying to avoid,
so yes I should use the write mmu lock in this case.

> > +}
> > +
> > +int ptdump_register_guest_stage2(struct kvm *kvm)
> > +{
> > +	struct ptdump_registered_guest *guest;
> > +	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
> > +	struct kvm_pgtable *pgt = mmu->pgt;
> > +
> > +	guest = kzalloc(sizeof(struct ptdump_registered_guest), GFP_KERNEL);
> 
> You want GFP_KERNEL_ACCOUNT here.
> 

Right, thanks this is because it is an untrusted allocation triggered from
userspace.

> -- 
> Thanks,
> Oliver

Thank you,
Seb
