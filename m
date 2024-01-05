Return-Path: <linux-kernel+bounces-18120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78418825921
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F3C285517
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8814634546;
	Fri,  5 Jan 2024 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKdSuuyJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73250321B5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704476131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jReSZZ+rApMadcHst1nTHElOHPd5xZ33y59VD2LqoQE=;
	b=cKdSuuyJlM162TUC/Qk9OxGkZTts9idI5rP3C2XNaOuQPmTy41JLY3ypj6grY+/h1ejCZ5
	ciS3vkFF4/hRBjV4GGaGyImY3tptub8oYMxkPk73/AK/oODOE1HZn18CCgYARYRlhmoOjz
	Pxr0XMSyvoHCubSNQQHHFZ+X2ysmqJw=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-5S-1u93oMlO5pqgUSx3isA-1; Fri, 05 Jan 2024 12:35:25 -0500
X-MC-Unique: 5S-1u93oMlO5pqgUSx3isA-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4b73c27cc7dso493084e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 09:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704476124; x=1705080924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jReSZZ+rApMadcHst1nTHElOHPd5xZ33y59VD2LqoQE=;
        b=JPks8IG5eniQ6EA55zdnzJ5zbY2L2FKnnjNyqnyo0QIwttUklt/5mE9Q8gPUd0g16f
         895fMwmTEgz7p9RNtWTIsnd3fRb/khqSg3Tjk9KDNcT0ME46dBnHrU7usoAO8qi0J4Sq
         O7j8ry0u8JG0RfjXFu91Fa8izvlJiNO8SsNVNR92kMtEgN1EkHbA+l/H73pWFjfdoOhB
         6XIJyxvsdM22NuK1/nLlSJkaMDn0i1WLeuqqzsWvgjHoRuJsrYaGE2LR+jjVpoNsRBIQ
         pJrQpPaq+GWjpaFo6oovDzRxlISR0i5s3syEfkp54e9Yau6U4a/z96RSNXxio8i1hlEN
         WeGQ==
X-Gm-Message-State: AOJu0Yx8ivs2rb2DKYPE9UMKmT0BNiz0yDl/wbL2445XmHFrLqS++08I
	C6S089gN06koGZFvj4oAT8XEd/THEJQj+0O7Fa3f0PamC6oAF4eplU0UHVFOU65NLgwzqSVKPea
	Zrx0dkIEUwlXnHBpYQpxNKQQLuVUk2QFqJbKDY8VcQ0jKAyUG
X-Received: by 2002:a05:6122:219f:b0:4b7:209d:4b2e with SMTP id j31-20020a056122219f00b004b7209d4b2emr2490747vkd.22.1704476124570;
        Fri, 05 Jan 2024 09:35:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqXhl3BfPFHh36P0vxrNtGSguFcUhb6zwVMQGFeI9QSXQtceC0uiWFNh2Isq3GOurw5uZe85o2CDuDr+GJtRo=
X-Received: by 2002:a05:6122:219f:b0:4b7:209d:4b2e with SMTP id
 j31-20020a056122219f00b004b7209d4b2emr2490741vkd.22.1704476124294; Fri, 05
 Jan 2024 09:35:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104154844.129586-1-pbonzini@redhat.com> <CAHk-=wi-i=YdeKTXOLGwzL+DkP+JTQ=J-oH9fgi2AOSRwmnLXQ@mail.gmail.com>
 <ZZg8kbb3-riiLbrb@google.com>
In-Reply-To: <ZZg8kbb3-riiLbrb@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 5 Jan 2024 18:35:12 +0100
Message-ID: <CABgObfY5oA8P6y8YEuFfg5pkh7ju6Zu2D=-hdoAD7CKPJPMOrA@mail.gmail.com>
Subject: Re: [GIT PULL] Final KVM fix for Linux 6.7
To: Sean Christopherson <seanjc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, peterz@infradead.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 6:29=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Fri, Jan 05, 2024, Linus Torvalds wrote:
> > On Thu, 4 Jan 2024 at 07:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >
> > > * Fix Boolean logic in intel_guest_get_msrs
> >
> > I think the intention of the original was to write this as
> >
> >         .guest =3D intel_ctrl & ~(cpuc->intel_ctrl_host_mask | pebs_mas=
k),
> >
> > but your version certainly works too.
>
> Ha!  That's what I suggested too, clearly Paolo is the weird one :-)

Not that I don't like your version; but since you hadn't provided
(yet) a Signed-off-by I had not looked at the patch until now.

In the end it's a coin toss between "fix what was clearly intended"
and "restore the logic before the broken commit". I picked the latter
because when trying to reverse engineer Linus's brain processes I tend
to overthink these things. :) That counts as being weird, I guess.

Paolo


