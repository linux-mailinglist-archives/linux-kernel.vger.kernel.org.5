Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F977B72F3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 22:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241101AbjJCU6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 16:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjJCU6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:58:50 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BFCAD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 13:58:47 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-279353904a9so1092149a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 13:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696366727; x=1696971527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofK3yTXudgH3dPOX+NXSBZm32mvv1GbIdTLu5eO4ZUw=;
        b=hsQ+h+zfEPMCI/50kh3uYHFre+0DewKghyeEOScbZURjbzs4Xqgl7eg7ObPDFdJBx6
         GxyYyVlH4Tqqou1ShFGVsxuXenXmxFNcNmwYkG8xVTX5Y9pl8vgcpZ6Abk99wenw/fnK
         S0ELSUpQWfX2bnKeTHUdXbfAWXe/kBSdl8DwlfAn4gAqRp6/01aQkzC6n4gBRdHfRaGp
         7H1bfyIBWWPn61RnqJLCJslnne8tUK4S79LcbdApOR9Zzova18T91gI+i4bG6s9uR4IH
         djNy81a+H1hzWGQ/kDkeQW8fJuaZc8K4WQm66gPzGWwpniShzqn2jIGUM23iyyT3EqIZ
         aTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696366727; x=1696971527;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ofK3yTXudgH3dPOX+NXSBZm32mvv1GbIdTLu5eO4ZUw=;
        b=YMp0CQAE+ZVntoVBq0fnF8DB56zBLBunKS2g5o2t+KCQVpWUnhhXCTQyfkZ9YOnwg/
         hBYLEFJ1E7rZ8vQz6ciorUTUGKsXPjr5bDilU+byHQsvm5OdfooR6s3E8fLUE4qZOorD
         ATnRsKbi4iZEQX8iWsbi2V0N4qhsRCATbgBEdc4IjPs6NUbmlg/R/NiMvvpzw1qic5aA
         JU5/RScU6X0S+zjY0dDq8RFjoa4ilN1+c6s91Lg9i3oDB5njgOZN0BaAei+/2eZHgYt2
         S3luHuu1RSFMYu43HihAdVF4vlV4PpscSwS9KJHVHQ8l075BYpCOMhyfrgGSc4YTUlhy
         Jj5Q==
X-Gm-Message-State: AOJu0YxP0jUx3dqwWuf7syGgSOr95iHFaG1LwTGU9AN9sI3HsO49bNVB
        HKvnXUyxvHgIDdT6vSsBH/6OM68zEkA=
X-Google-Smtp-Source: AGHT+IEpJRqfisemR4Ma6/26idPCJUHwNJZNRJlSNji243dfZdo+DGHvKt5onPD5NiiwHo9l66/HVhcVsls=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:92:b0:26d:ae3:f6a4 with SMTP id
 bb18-20020a17090b009200b0026d0ae3f6a4mr6815pjb.5.1696366727020; Tue, 03 Oct
 2023 13:58:47 -0700 (PDT)
Date:   Tue, 3 Oct 2023 13:58:45 -0700
In-Reply-To: <fe832be36d46a946431567cbc315766fbdc772b1.camel@redhat.com>
Mime-Version: 1.0
References: <20230911021637.1941096-1-stevensd@google.com> <20230911021637.1941096-6-stevensd@google.com>
 <fe832be36d46a946431567cbc315766fbdc772b1.camel@redhat.com>
Message-ID: <ZRyAhdIvAkQhYJVr@google.com>
Subject: Re: [PATCH v9 5/6] KVM: x86: Migrate to __kvm_follow_pfn
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     David Stevens <stevensd@chromium.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023, Maxim Levitsky wrote:
> =D0=A3 =D0=BF=D0=BD, 2023-09-11 =D1=83 11:16 +0900, David Stevens =D0=BF=
=D0=B8=D1=88=D0=B5:
> > From: David Stevens <stevensd@chromium.org>
> > @@ -4283,12 +4290,20 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *v=
cpu, struct kvm_page_fault *fault
> >  			return RET_PF_EMULATE;
> >  	}
> > =20
> > -	async =3D false;
> > -	fault->pfn =3D __gfn_to_pfn_memslot(slot, fault->gfn, false, false, &=
async,
> > -					  fault->write, &fault->map_writable,
> > -					  &fault->hva);
> > -	if (!async)
> > -		return RET_PF_CONTINUE; /* *pfn has correct page already */
> > +	foll.flags |=3D FOLL_NOWAIT;
> > +	fault->pfn =3D __kvm_follow_pfn(&foll);
> > +
> > +	if (!is_error_noslot_pfn(fault->pfn))
> > +		goto success;
> Unrelated but I can't say I like the 'is_error_noslot_pfn()' name,=20
> I wish it was called something like is_valid_pfn().

I don't love the name either, but is_valid_pfn() would be extremely confusi=
ng
because the kernel already provides pfn_valid() to identify pfns/pages that=
 are
managed by the kernel.  Trying to shove "guest" somewhere in the name also =
gets
confusing because it's a host pfn, not a guest pfn.
