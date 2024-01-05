Return-Path: <linux-kernel+bounces-18105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494468258F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4498E1C23131
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE8B328CA;
	Fri,  5 Jan 2024 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ypf8SLvC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8C328B3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55745901085so346027a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 09:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704475306; x=1705080106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fgUg6yXSGJVGxpWb0GfnpK9ZphsLr10eK/u4ICIM5n8=;
        b=Ypf8SLvCV1/RY4qsfVKEK2z/GgWcaw4sHot2NqpfFIViPswT52QgXTgOeN+jQaScGS
         qnINIAjB/t8fVXH9npuSfT3zBwmeA59igznbxJMm5/BMYjnzycCP82HgnM6OqMtDu5on
         KA9Rdt4UJWFvsjPN2sAlO8uFovmcc1GBMuZXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704475306; x=1705080106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgUg6yXSGJVGxpWb0GfnpK9ZphsLr10eK/u4ICIM5n8=;
        b=tB82pMHKEtaf0TUhtDxhHGkVhTM1oab/HJBOfYTgxwZUCqjuMof0yGpYk1qGjwKVMM
         0TZb58441/0WYRmqk3DQwp+nUv2rUOv8fQV5TWZDi82TD03Z4BfGYEYMiz7y73qu1Mv4
         RWQ0M2Rlx94tHHziKSnFzCx6ZLqQlucFbBLigBvLIQbtU/SJt00ciN4BaYVxMvIA/WOy
         cqI6/UE353R/OpmbmN8Gs94SUCIPGlWSgBuxw7zkjIG4T2sorqLpXRlyEQHp+ZzKvxHC
         Ks1ekWG/syON7vZs8S+ngSQKXxEZwKkfyBS67jlaNjHIpKsXuoPv7qhNem3PDazWWKoO
         +Gxg==
X-Gm-Message-State: AOJu0YziJ3JhoJojl7U7uAho1zJCUnas6t/VaFQw2xFgsLaBA2niptJE
	3XSMY2st711dNyheU03fnM8JrqPopIiI57N0LzNIRT2LqOJQ+a2z
X-Google-Smtp-Source: AGHT+IHyNaY33THRHIPa1MPMFZJCSq8VDBz9A6m7lp3e+2GzPFiUq3RjcM77gRNNBzXye0bzheLBMQ==
X-Received: by 2002:a17:906:6412:b0:a28:b774:5e6f with SMTP id d18-20020a170906641200b00a28b7745e6fmr1110542ejm.77.1704475306417;
        Fri, 05 Jan 2024 09:21:46 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id g16-20020a17090670d000b00a298c766585sm440778ejk.57.2024.01.05.09.21.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 09:21:45 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28aa47bd15so214398266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 09:21:45 -0800 (PST)
X-Received: by 2002:a17:906:fcc1:b0:a28:c9f:858d with SMTP id
 qx1-20020a170906fcc100b00a280c9f858dmr1422177ejb.136.1704475305154; Fri, 05
 Jan 2024 09:21:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104154844.129586-1-pbonzini@redhat.com>
In-Reply-To: <20240104154844.129586-1-pbonzini@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jan 2024 09:21:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi-i=YdeKTXOLGwzL+DkP+JTQ=J-oH9fgi2AOSRwmnLXQ@mail.gmail.com>
Message-ID: <CAHk-=wi-i=YdeKTXOLGwzL+DkP+JTQ=J-oH9fgi2AOSRwmnLXQ@mail.gmail.com>
Subject: Re: [GIT PULL] Final KVM fix for Linux 6.7
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, peterz@infradead.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 07:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> * Fix Boolean logic in intel_guest_get_msrs

I think the intention of the original was to write this as

        .guest = intel_ctrl & ~(cpuc->intel_ctrl_host_mask | pebs_mask),

but your version certainly works too.

Pulled.

           Linus

