Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F46D7DE002
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjKALC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjKALC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:02:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AEFFC;
        Wed,  1 Nov 2023 04:02:24 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so2259928f8f.0;
        Wed, 01 Nov 2023 04:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698836543; x=1699441343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lLGQwWjL2Aw3sFfyWPVTh2LkEYh2Jo+b78gHIPc7ugc=;
        b=DBJCW2NsUaqE0lQjq3liJexnkoVaIj4KK0h4KXmguzQSy8anfcloF93TuCrsuT9IPt
         Fhkg950aQykwX6PBRgzXw5hXphmNo2u1xdGuJ7uxYBvnGHFriLYM5IL+gWdIQOeDcUuz
         fqcJTO/ilUd6HvlZQfC6LGJp3xtQZURa2mxQbkcpSRzZ9bZd2A50J2yCwJdXal3EmAbg
         aTk0oh15xTILtIEY3rE4lYLes13o+BOAqyG0oxvXMQ9rYNpmS7Dn5lXZuavuUPrC1QB4
         jHKnMP8QW6ndB3y5qT+uLGtPmf4C5piIgb5kdSc3g/jhD84nApD4lgz9iLPt/K8T8/rO
         VnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698836543; x=1699441343;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLGQwWjL2Aw3sFfyWPVTh2LkEYh2Jo+b78gHIPc7ugc=;
        b=EdJsOsS/59cJ7Yq+tqMyoVrDdDaODkkTouhNSPCWznd5h98xqrxCR5ZAtU2ScXq4uZ
         J18YE9hY1osvZ9PF1EYOfTTnYgDOuFWOWq9/agv0LFdz91jA0v2WGybMkKsjGGTViugm
         NMdVmwI5i3kgC3n5EVkpuv2MHm6pprnUonkJZKx+xY+eNYoFLBsxY86E/fW2roKDeBuc
         eoMRgwiIvotuhlMTwRheo/JqWaYknpuNI64Iw5qBqzU3qbKH0exOxhiBHkaRcQ3bcgDv
         UcQJeFSirK3SKYbgaEp3Eeq61SadTSbPMtM164t+qfWF4Xi6vhn7EpDjqijq9k4lvuwz
         qm4w==
X-Gm-Message-State: AOJu0YxLtZewPrG1I+aFFERCPxPBq21bNYM4wYue7DrxG+NyJ+DBF830
        v+xjf6Jveba8telt/BFQNBdBo38i9HZ3fA==
X-Google-Smtp-Source: AGHT+IGhSCFjWDlSAeyzhKo7ObrQNOoHY2TZnOfL4+qkuskUlpbXSKzRJk8C/Me6qA29voKfgh8GNg==
X-Received: by 2002:adf:eb47:0:b0:32c:837e:ef0 with SMTP id u7-20020adfeb47000000b0032c837e0ef0mr11190912wrn.50.1698836542620;
        Wed, 01 Nov 2023 04:02:22 -0700 (PDT)
Received: from [10.95.173.140] (54-240-197-235.amazon.com. [54.240.197.235])
        by smtp.gmail.com with ESMTPSA id g8-20020a056000118800b0032f933556b8sm3897074wrx.7.2023.11.01.04.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 04:02:22 -0700 (PDT)
From:   Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <f850458d-c1a3-4851-921e-e04404e827b9@xen.org>
Date:   Wed, 1 Nov 2023 11:02:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v2] KVM x86/xen: add an override for
 PVCLOCK_TSC_STABLE_BIT
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231031115748.622578-1-paul@xen.org>
 <ZUGCPQegUeTutsrb@google.com>
 <028f629d16377f9a7e9fd87ef9564846b0ab4ed9.camel@infradead.org>
Organization: Xen Project
In-Reply-To: <028f629d16377f9a7e9fd87ef9564846b0ab4ed9.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 22:48, David Woodhouse wrote:
> On Tue, 2023-10-31 at 15:39 -0700, Sean Christopherson wrote:
>> On Tue, Oct 31, 2023, Paul Durrant wrote:
>>>
>>> +       if (force_tsc_unstable)
>>> +               guest_hv_clock->flags &= ~PVCLOCK_TSC_STABLE_BIT;
>>
>> I don't see how this works.  This clears the bit in the guest copy, then clobbers
>> all of guest_hv_clock with a memcpy().
> 
> Agreed, that seems wrong.
> 

It is indeed. Looks like it got moved the wrong side of the memcpy() 
when I rebased.

   Paul
