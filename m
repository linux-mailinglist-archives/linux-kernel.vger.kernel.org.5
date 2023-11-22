Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1D67F4C17
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjKVQP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjKVQP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:15:57 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4B3A2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:15:52 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso88675391fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700669751; x=1701274551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaNA+1kUhGp1TWlPIHpnCP3XDdAFKSdhNs80LYurPRo=;
        b=QRXIUJo8DrPR0TPtZWj4zjpFYHvjJYmVPUc9c7CN1CMy8z5qb+uUVLar0Ssw6Dv5h7
         Cmx9qfHAhhLjPBNHYVhWOHMecRSfcg9nLXIdGF1x1HZFFVcjW7H41GYZx0mEYjf4BaES
         41HZKpD7w1b3jkiKnQFjJz7Q0/sXYaRG78d1v/xeZaNuLMawqzpiUwc6/BIAX2eij9ek
         N8Ke6iPdGFHZHgasMCT1CrAX42lOE9urcf+0bn+jbfTBZahHRgiKY5VZu1RZEthfJ1oK
         eLTdUnmLC057BUR001nDeD9ckKdIrAgFmNxsBwqYcYAPiz2auVPCYaehbve45lexCCGJ
         XAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700669751; x=1701274551;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HaNA+1kUhGp1TWlPIHpnCP3XDdAFKSdhNs80LYurPRo=;
        b=s2VfRAej6IfSXB/Iux97VF4TOsBjxEw6zYmXW7rHn77+7ASRKFGJY3qvIAKYCEtgoc
         2TYE+DunMByeQq0kWa1QSq6Sw4rAnfOVP+V50LNL2gBvgyv5qF0H2aMra50+WR6bdrPq
         ky0xGxqRwoTpacKyPhNWi6Tcz0g3L2+vZdR2AmejJEB3ujl2G0btQVDcX98e7f0+rCeO
         nhF8agmo3fI+hNfKnXkLT4FSKekKPCZDTw0gZIOtDBsD6Jg21zYAQyeP0AmihD5Nf2zf
         UosGjew6zPQDA7ahK4qip0NRr4TPvzZWCJTTuBo/VwzWTisWeXOtsIjAiEKCORxQF4IC
         OE0A==
X-Gm-Message-State: AOJu0YzQKO//a3grKfznXzYUaTb6g7a5Q5X2GzW8x9GTs5eD8fOyHcuX
        /S9pLHzBIG92QbSxy5h9Bc4=
X-Google-Smtp-Source: AGHT+IFN4P3XRSZ/At5FqUEE8wIqo3jMlcrSAt8vmgIza+s/70PuIihltvHjFK4RjasOXMgJPAr91w==
X-Received: by 2002:a2e:3513:0:b0:2c7:b9b6:85ff with SMTP id z19-20020a2e3513000000b002c7b9b685ffmr1935778ljz.36.1700669750755;
        Wed, 22 Nov 2023 08:15:50 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id d1-20020a5d5381000000b0032f7f4d008dsm17543459wrv.20.2023.11.22.08.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 08:15:50 -0800 (PST)
Subject: Re: drivers/net/ethernet/sfc/selftest.c:48:16: warning: field ip
 within 'struct efx_loopback_payload::(anonymous at
 drivers/net/ethernet/sfc/selftest.c:46:2)' is less aligned than 'struct
 iphdr' and is usually due to 'struct efx_loopback_payload::(anonymous a...
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Andy Moreton <andy.moreton@amd.com>,
        Simon Horman <simon.horman@corigine.com>
References: <202311220537.geMTr31W-lkp@intel.com>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <3f42dee6-a6e2-1b35-674f-309aae042ae7@gmail.com>
Date:   Wed, 22 Nov 2023 16:15:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <202311220537.geMTr31W-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2023 21:25, kernel test robot wrote:
> Hi Edward,
> 
> FYI, the error/warning still remains.

As I've argued previously, this is a false positive / compiler bug,
 and there is no way to resolve it without making the code strictly
 worse.

This:
>>> drivers/net/ethernet/sfc/selftest.c:48:16: warning: field ip within 'struct efx_loopback_payload::(anonymous at drivers/net/ethernet/sfc/selftest.c:46:2)' is less aligned than 'struct iphdr' and is usually due to 'struct efx_loopback_payload::(anonymous at drivers/net/ethernet/sfc/selftest.c:46:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
 is complaining about alignment within an anonymous struct, which
 only ever appears embedded within a larger struct in a way which
 maintains the correct alignment.

#ifdef RANT

Indeed, the only way we even *could* create an unaligned access
 out of this code would be via a declaration like
    typeof(*(((struct efx_loopback_payload *)0)->packet)) bad;
 because *the struct is anonymous*.  And if that happened, the
 bad declaration would be the place to warn, both because it's
 incredibly ugly and because it's the place that's actually
 wrong.  The struct definition itself is entirely *fine*.
The compiler should be able to detect that, and if it's not smart
 enough to do so then it shouldn't be trying to warn in the first
 place.  Quoth Linus[1]:

 "And if the compiler isn't good enough to do it, then the compiler
  shouldn't be warning about something that it hasn't got a clue about."

The anonymous struct has to be there so that we can placate the
 memcpy hardening, and it has to contain a struct iphdr at a
 4n+2 offset because that's what shape the on-the-wire packet
 *is*.  To avoid the warning we would need to lose __packed and
 memcpy all of the members in and out of the buffer individually
 to explicitly-calculated offsets, which is worse code.

#endif

Either fix the compiler to not warn, or fix your automation to
 ignore this instance of the warning.

-ed

[1]: https://yarchive.net/comp/linux/gcc.html#13
