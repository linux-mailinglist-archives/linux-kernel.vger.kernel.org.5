Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9F67E5E61
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjKHTLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKHTLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:11:35 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735482113
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 11:11:33 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so1738a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 11:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699470692; x=1700075492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYVVEM5BaLTPikbfmS5FtqNhSFPaOYY2B62Q14yU+zo=;
        b=aCbLCl9ITxuprqPs8aKg4u7PijhE3sf3iBSYt8SIBB6SnZMRrCAoTQ8vyn0wtpT0Qn
         0Gte5R3ADrN4uqoXxMZyhAGA1ircbLhCwtOJbQWL01U1hungH4bEItIG0u7JY944utGC
         ZWd7XtuMbi9nbmpBc4X8ssRzXadAjWNRjC1EnDtYkXSo0Hwhe3OXDGrmFFK/cxWlvZQ7
         1bUdjvPJBEkF8uTQQ6Dg4zcGVF3NwPWiHFvZqgrRpLYa/YPHYG10QKipRv8bhuBZDLlQ
         GZBbGio6WaNLkrTu+biX4gAeUfIrbbCBqGluhYhyDKcJ3o8/edjgWyJXQEui0z2wEVsh
         K03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470692; x=1700075492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYVVEM5BaLTPikbfmS5FtqNhSFPaOYY2B62Q14yU+zo=;
        b=uemxzUWgUqDczx5xEAgv57aNng3o7+hC0VTfUM4gmmOXTnzZtSjGvxX122Wprjepa5
         AZWPI7Em/oBk7CGVOPDFBJFEoGXNoS2SOcXNVPBdFyqXtXcf+uqX+lUrP2SUZF8DiFPf
         2FWAOqWhu6h0+3isx0ghak+ik3sxmlLDINW0TAcl+8lfo0Scfnd6GdjabfwMWhevwDef
         QtxypGSuuaYJ+LLDQm/MDxUKblxO0Y8YDhuZ1i8AevvvFhv/WZdn58aJS1au6Q2gzT22
         VdRBhqnsEobkwCVA9+u2zsLPwgywpILFUzWHGL6N9KrY3cUtnM64uSWNDL5PWSTKWju6
         V8+Q==
X-Gm-Message-State: AOJu0Yzawkx6TvyF+0iF2/3II1UQ58iPW0iQOTDmSuUVLfWhRwzu5A74
        ig/wo9o3QOSk5RuHrYLMnDKAvpMa/T1O3nyCgV1FJw==
X-Google-Smtp-Source: AGHT+IF2nRIkMOOTvlH5caJpGlI6ZYnAbP33whKypeay5+v/AlbMl6E48A4pnbXb1m1FO0Bx72dMrAwzMDVSDF3YfqA=
X-Received: by 2002:a05:6402:1518:b0:544:f741:62f4 with SMTP id
 f24-20020a056402151800b00544f74162f4mr12905edw.0.1699470691832; Wed, 08 Nov
 2023 11:11:31 -0800 (PST)
MIME-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com> <20231108003135.546002-6-seanjc@google.com>
In-Reply-To: <20231108003135.546002-6-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 8 Nov 2023 11:11:20 -0800
Message-ID: <CALMp9eRh7uzx3=_UdNaudHCBw4C3UWt983qJvKft=RmaomVT0w@mail.gmail.com>
Subject: Re: [PATCH v7 05/19] KVM: selftests: Add vcpu_set_cpuid_property() to
 set properties
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 4:31=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> From: Jinrong Liang <cloudliang@tencent.com>
>
> Add vcpu_set_cpuid_property() helper function for setting properties, and
> use it instead of open coding an equivalent for MAX_PHY_ADDR.  Future vPM=
U
> testcases will also need to stuff various CPUID properties.
>
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
