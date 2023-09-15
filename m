Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9037A1306
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 03:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjIOBqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 21:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjIOBqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 21:46:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0957270A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 18:46:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-991c786369cso219788766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 18:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1694742387; x=1695347187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/We05QBGf54xap/mvQHQ6SHgmclfDs/rkBUva3BMHN4=;
        b=uwiN4geiNwYFzwfBh/SQaiP9jQoMj6hwSG4Nb6X9JGaItOa095qOmkUUDJYGY4mna0
         lw8R8JLk/INbF58uIhSOVzL6T4IspWs2YyZpZ4t1XsOFI8cQhYLNXiXupFvQtqEkJqNS
         ZDEp7zBNbaOagr+uWoPTkiWCVoNquq9AIAJJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694742387; x=1695347187;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/We05QBGf54xap/mvQHQ6SHgmclfDs/rkBUva3BMHN4=;
        b=nBCzL8TQkW6kkErVWs1F+VfaQWUY8oL61lIlBfGhK/Ke+VMfqP6uj2J0/wXzk/Xi38
         J3XIOFbc5nHSyTAmIAq9xZEEADnN1OdiICc+xZmTzWMkub/Cwdsnm0G5TFpRK3hBkqO3
         gvzgGm8clmFsXOtcYKkLicumCC9ElfU09GJI8Z+dxwHrSVWuqEH/sZoYNgfbCYHe03cX
         88IcXmFGuHBdvWgIkNRPaaLqNnDU7liIXpUl50agPBdCgiusSM11lEbXRnZwEqBfDh6f
         9H8WyShexj65Jp+AyuE/430ddfobdEz6ihAHhoyfQ1u8N6DWVq2h9YOGv9sdvzIgQuW3
         e0Kg==
X-Gm-Message-State: AOJu0YzgUDf4UlJP8IzmCj5bZfHc2C9QbJs1VIqTkZDZwvkwg5mVOXTq
        v+sSGrRzTv53nS6AiN34YfWU0w==
X-Google-Smtp-Source: AGHT+IHPu+cpAJWccx/7qe6vKXqWPcxLrO1CLKCzaitC2xOztw0rjEqS/irWK79hYFHgOnKDG9NiHw==
X-Received: by 2002:a17:906:9c9:b0:9a4:88af:b82 with SMTP id r9-20020a17090609c900b009a488af0b82mr78302eje.77.1694742387253;
        Thu, 14 Sep 2023 18:46:27 -0700 (PDT)
Received: from [192.168.1.10] (host-92-12-44-130.as13285.net. [92.12.44.130])
        by smtp.gmail.com with ESMTPSA id lg13-20020a170906f88d00b009828e26e519sm1717612ejb.122.2023.09.14.18.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 18:46:26 -0700 (PDT)
Message-ID: <af5990d5-58d5-9109-b37b-1f696a43fe86@citrix.com>
Date:   Fri, 15 Sep 2023 02:46:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   andrew.cooper3@citrix.com
Subject: Re: [PATCH v10 03/38] x86/msr: Add the WRMSRNS instruction support
Content-Language: en-GB
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Xin Li <xin3.li@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, luto@kernel.org, pbonzini@redhat.com,
        seanjc@google.com, peterz@infradead.org, jgross@suse.com,
        ravi.v.shankar@intel.com, mhiramat@kernel.org,
        jiangshanlai@gmail.com
References: <20230914044805.301390-1-xin3.li@intel.com>
 <20230914044805.301390-4-xin3.li@intel.com>
 <6f5678ff-f8b1-9ada-c8c7-f32cfb77263a@citrix.com> <87y1h81ht4.ffs@tglx>
 <7ba4ae3e-f75d-66a8-7669-b6eb17c1aa1c@citrix.com> <87v8cc1ehe.ffs@tglx>
 <50e96f85-66f8-2a4f-45c9-a685c757bb28@citrix.com>
 <5cf50d76-8e18-2863-4889-70e9c18298a1@zytor.com>
In-Reply-To: <5cf50d76-8e18-2863-4889-70e9c18298a1@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 1:38 am, H. Peter Anvin wrote:
> On 9/14/23 17:33, andrew.cooper3@citrix.com wrote:
>>
>> It's an assumption about what "definitely won't" be paravirt in the
>> future.
>>
>> XenPV stack handling is almost-FRED-like and has been for the better
>> part of two decades.
>>
>> You frequently complain that there's too much black magic holding XenPV
>> together.  A paravirt-FRED will reduce the differences vs native
>> substantially.
>>
>
> Call it "paravirtualized exception handling." In that sense, the
> refactoring of the exception handling to benefit FRED is definitely
> useful for reducing paravirtualization. The FRED-specific code is
> largely trivial, and presumably what you would do is to replace the
> FRED wrapper with a Xen wrapper and call the common handler routines.

Why do only half the job?

There's no need for any Xen wrappers at all when XenPV can use the
native FRED paths, as long as ERETU, ERETS and the relevant MSRs can be
paravirt (sure - with an interface that sucks less than right now) so
they're not taking the #GP/emulate in Xen path.

And this can work on all hardware with a slightly-future version of Xen
and Linux, because it's just a minor adjustment to how Xen writes the
exception frame on the guests stack as part of event delivery.

~Andrew
