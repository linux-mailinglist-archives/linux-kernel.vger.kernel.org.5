Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C7B7581AB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjGRQGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjGRQGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:06:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18113F1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:06:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991c786369cso764099466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689696405; x=1692288405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ge1gUvFCHAi2h+q4Ml9Q9L5Vd55ScJJX2QCIQPKfrag=;
        b=BqZZOejuiG1Snfz19ZPoCN3/QERwEcYnwkA/+wPTvPGSc6sFNhLbLZGy9G3JTWk8sH
         lElYzVSqR7AFsR7jnWnkBcn9X1Yw144lhXjYTSeqnfPTOpJkIviKBJeq6gIaAWnpDfxo
         vlXWmI8LHcov6VJJmd2nW1adN3rMj6mF4RME0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689696405; x=1692288405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ge1gUvFCHAi2h+q4Ml9Q9L5Vd55ScJJX2QCIQPKfrag=;
        b=C6HtEvvx24ttoj/zAbQWuolzojpnS2DLOZhaMenHy1j/EIyIMLYRo1yzcKnVB13N5g
         pwapnYeGCiJNHrHmMVU5zKDdp9UUvZiR54ZThX67u37dpt+8Vhvsv0jE8w5ggHUkI5Jr
         VBIZkgGWtqNZRL2obnEQ1f6U0rSd3AVcs/vq3sx8fDliNjaiNsxXkd3qT/6K3oCdeage
         VC7vSCgDAbiBijEwdcNN54Rbn1/86WZbnLXVCb95d4n5XhRTIWBc7HXOLHN2SREhhRya
         /ZP0/9OiTB6lAgRKJ3W4dkpqa7HwVRDuCab44RJjUlLbNEN9yb2W7valnnYR6/B68JiE
         XcFQ==
X-Gm-Message-State: ABy/qLZ2kKqzhckc73dgXJUPPcBjmRSOGBdsno8cn87SdloRozZivYyo
        nHp8pt5daAFkXL4im8mYyDudMUez5knJXzShuBi/d4m2
X-Google-Smtp-Source: APBJJlH16F9hJiCftF6996I4z8BT0iMF6pSGocJcxWgONqkmdODSZYC5OrJKRjmUvkxHhMcrTZoKIg==
X-Received: by 2002:a17:906:20de:b0:997:e9a3:9c54 with SMTP id c30-20020a17090620de00b00997e9a39c54mr421747ejc.0.1689696405268;
        Tue, 18 Jul 2023 09:06:45 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id gh5-20020a170906e08500b00992bea2e9d2sm1210788ejb.62.2023.07.18.09.06.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 09:06:44 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-991c786369cso764095866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:06:44 -0700 (PDT)
X-Received: by 2002:a05:6402:1846:b0:521:7181:e8b7 with SMTP id
 v6-20020a056402184600b005217181e8b7mr251331edy.40.1689696404154; Tue, 18 Jul
 2023 09:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230717223049.327865981@linutronix.de> <20230717223225.515238528@linutronix.de>
 <CAHk-=wh9sDpbCPCekRr-fgWYz=9xa0_BOkEa+5vOr9Co-fNhrQ@mail.gmail.com> <87h6q1y82v.ffs@tglx>
In-Reply-To: <87h6q1y82v.ffs@tglx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Jul 2023 09:06:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkmwJB4puU7dn0eTABXGa7WdX=JZFZjqxOEkiA3f+aGQ@mail.gmail.com>
Message-ID: <CAHk-=wjkmwJB4puU7dn0eTABXGa7WdX=JZFZjqxOEkiA3f+aGQ@mail.gmail.com>
Subject: Re: [patch 41/58] x86/apic: Add max_apic_id member
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 at 00:47, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The confusing part here is the physical APIC ID vs. the destination
> mode.

Actually, no, what confused me here ended up being that I didn't see
any other limit checking at all for the flat mode, and then I was
"this cannot possibly work up to that limit".

But it turns out that the limit checking appears to be in the
"physflat" case, not in the simple flat case.

IOW, the physflat probe function says "I'll take it" whenever
num_possible_cpus() > 8", and that seems to be what then limits the
flat mode to a max of 8 cpus. So the limit was just in another place
than I expected.

            Linus
