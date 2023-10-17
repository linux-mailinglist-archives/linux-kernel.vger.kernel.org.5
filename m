Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D957CC817
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbjJQPxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjJQPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:53:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3032F2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697557964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RJCFeyH99wewsxYRk1lLnjPIdN1WhsmhUxQEUY5pO/k=;
        b=SMNTEeUZcePqdajsYwY4mcGEWZ1mORTDWk2BOBvtYMp41oWtHS/UsM+ZohzVyFvADHhO3q
        VtTjW8hU+5VMyqDu8IlU1ktntK6LrdIIWKSIKkgb/5CjdGUVQWO0VbCYrGqOXbOTpm0cLd
        eiEIWK6A9FOI2AOyPPRKhmRUiD8SJiM=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-giUGNwkEPtiGk2ocJ0HEFA-1; Tue, 17 Oct 2023 11:52:42 -0400
X-MC-Unique: giUGNwkEPtiGk2ocJ0HEFA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5a818c1d2c7so72723417b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697557962; x=1698162762;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJCFeyH99wewsxYRk1lLnjPIdN1WhsmhUxQEUY5pO/k=;
        b=bsW5fvUW8e6iGrQiIo6uU/0k3swYnr9yvhO8alVvic4mRqIVlWdtjvXZo5D17fKSUv
         /JWtWb5N4y+hD2bEHYcpPjj3GJJcDTmkzGqmS09v9My5d9+nBqrAOP63DftB10EtS3eF
         bM0MJ+i/s6wAa8rcv85xBi2lpIi5zr7DynLZocFs4aJbaPYzoA1PhRuDvAnkgcoP68lB
         I4m9QafDM77ZDVB55aT3ZkqkA8obVIfjOmF2JdlSIUkP6RUEdivZy32R2FMcKEJed+sF
         DR2qd3xku6u0pEqtn7jahtwH9EqRKDWi3spUvljC7z+0bHFB2Hr5l2W7N6xBqhVOL0RM
         RcAA==
X-Gm-Message-State: AOJu0Yy/k9ccMefOrEwl8q9o/9tLT1XQd77lRnLykqEGtUnF4cyz8M0a
        N1BkKZyzAzGw3nBfav1u5SfND83pHsk/4g+HzZFrA/8v5ABPSWpX66NMwKJcyIaux4KyZ8qRtxA
        Xrk6deuNIK9rhkTywzjrcOUC1
X-Received: by 2002:a81:8586:0:b0:570:2568:15e with SMTP id v128-20020a818586000000b005702568015emr2742453ywf.43.1697557961991;
        Tue, 17 Oct 2023 08:52:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6HOkqm7LrAZb56MJgs6JiaTCoAldeZtr1QWk1SvAvnpO0F4NFw1Cui2NnZEFeX0hOVtxaLg==
X-Received: by 2002:a81:8586:0:b0:570:2568:15e with SMTP id v128-20020a818586000000b005702568015emr2742428ywf.43.1697557961784;
        Tue, 17 Oct 2023 08:52:41 -0700 (PDT)
Received: from rh (p200300c93f0047001ec25c15da4a4a7b.dip0.t-ipconnect.de. [2003:c9:3f00:4700:1ec2:5c15:da4a:4a7b])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a0cc800b00772662b7804sm759453qkj.100.2023.10.17.08.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 08:52:41 -0700 (PDT)
Date:   Tue, 17 Oct 2023 17:52:37 +0200 (CEST)
From:   Sebastian Ott <sebott@redhat.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shaoqin Huang <shahuang@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v7 08/12] KVM: arm64: PMU: Allow userspace to limit
 PMCR_EL0.N for the guest
In-Reply-To: <20231009230858.3444834-9-rananta@google.com>
Message-ID: <5d35c9f3-455e-6aa9-fd6a-4433cf70803a@redhat.com>
References: <20231009230858.3444834-1-rananta@google.com> <20231009230858.3444834-9-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Mon, 9 Oct 2023, Raghavendra Rao Ananta wrote:
> +static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
> +		    u64 val)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	u64 new_n, mutable_mask;
> +
> +	mutex_lock(&kvm->arch.config_lock);
> +
> +	/*
> +	 * Make PMCR immutable once the VM has started running, but do
> +	 * not return an error (-EBUSY) to meet the existing expectations.
> +	 */

Why should we mention which error we're _not_ returning?


> +	if (kvm_vm_has_ran_once(vcpu->kvm)) {
> +		mutex_unlock(&kvm->arch.config_lock);
> +		return 0;
> +	}

