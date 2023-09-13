Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0E779EB07
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbjIMO1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjIMO1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:27:06 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B5590
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:27:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401187f8071so7024365e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1694615221; x=1695220021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WCX7YVCnW5EI+Rj2UEpp34J8eAxFXG/LhkB43sTasks=;
        b=L0XqoetwyVdbLvCwmF9mS6wMSLfc93QbyS7cam10NsIvImG1eCY+zH1H4ycVeT1ghs
         M4pdJya4BDfeepjalX+vRjs+NqdenliSB5z/gajQsXeRFK/rirnQwnMMZwm679Lv369A
         swG8GhZIqw/Tdzi750vjaN2l+EcYDCilXGWEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694615221; x=1695220021;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCX7YVCnW5EI+Rj2UEpp34J8eAxFXG/LhkB43sTasks=;
        b=jAHmzGY1klEGXqpu6wOQ7jA1Y0dL4kgaEMfQyp9c8B8gkGKzVk9w0EV4to9lDUTxe1
         m0hbY/xN0NkRAsYTQ85riub5MLxVWk+w0+R2t8eto9PTLyF6GxABZ5LpQezNGx7BGkQl
         OnX9hR09DJUpF+Z3Bx1pnGBjTprIEG4RUpSGNKoKG1uC3CxRzJaZExkz2y37y7HY06dX
         Ju+D/7hqGN2Hjj4x8bcNPCAVb0l93cGD9u6VlV0eVePNCRZJd5DCBQXlQbDuLzHFviYV
         juCUEqNJeHNFIyKAEB+kc9LZJrvJstoSIuOm31r7JbC4LWnxGPqIRq2d//4rnujBfFXD
         smZw==
X-Gm-Message-State: AOJu0YzYp+csUSlLZ3NJFoB+UpsYMqBsyoE8k0MsMBWW3EVEjbDyo6+L
        Sl/O1iESv64/B+De/4A6rFQNpw==
X-Google-Smtp-Source: AGHT+IG9RKu2awBBImMf7p/qxLYcW+duxQTryQ7w8uUpXXLXfcsvBW70vHIPOhffUlol6KUEABabMA==
X-Received: by 2002:a05:600c:510a:b0:400:140c:6083 with SMTP id o10-20020a05600c510a00b00400140c6083mr4700992wms.2.1694615221029;
        Wed, 13 Sep 2023 07:27:01 -0700 (PDT)
Received: from [10.80.67.28] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id x22-20020a05600c2d1600b003fed78b03b4sm2206335wmf.20.2023.09.13.07.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 07:27:00 -0700 (PDT)
Message-ID: <8331673e-ce7d-8509-4ccc-f5eaaafd2d94@citrix.com>
Date:   Wed, 13 Sep 2023 15:27:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 1/4] x86/srso: Rename srso_alias_*() to srso_fam19_*()
Content-Language: en-GB
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Babu Moger <babu.moger@amd.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
References: <20230821112723.3995187-1-andrew.cooper3@citrix.com>
 <20230821112723.3995187-2-andrew.cooper3@citrix.com>
 <20230913134618.GAZQG9KrdVjjpYpBqe@fat_crate.local>
In-Reply-To: <20230913134618.GAZQG9KrdVjjpYpBqe@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 2:46 pm, Borislav Petkov wrote:
> On Mon, Aug 21, 2023 at 12:27:20PM +0100, Andrew Cooper wrote:
>> The 'alias' name name is an internal detail of how the logic works.  Rename it
>> to state which microarchitecture is is applicable to.
> Sorry, no. Hardcoding the family into some function is a backwards. The
> moment you need to apply this to some other family, it becomes wrong.
>
> And I prefer much more "srso" and "srso_alias".

You literally have one set of functions which is not safe to use on
anything other than fam17, and a different set of functions which is not
safe to use on anything other than fam19.  Neither are safe to use under
virt, which is an outstanding security vulnerability in the SRSO work.

Given the clustermess that is SRSO, it's not as if the fam1a BTB is
going to be reverted back to look like a fam19 one, so "different
families" isn't going to happen.  The most likely thing to happen is
that you'll have to invent a $FOO_different_alias when a 3rd BTB
structure is shown to have related problems.

I know you may like $FOO and $FOO_alias, but an alias infix on one of a
pair implies they're related when in fact they are not.  It takes a the
already-insanely-complicated logic and makes even harder to follow.

Naming is very important for clarity/understanding, and the current
naming here is doing it's damn hardest to make the logic impossible to
follow, edit, and crucially, fix.

~Andrew
