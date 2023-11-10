Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1057E7E68
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346015AbjKJRoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344461AbjKJRns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:43:48 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC9983DE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 23:22:14 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b2ea7cc821so956257b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 23:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1699600933; x=1700205733; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGF1v/gqhKIfK3lN8tg1lEaaH/f3W7AggG6onMYyyAU=;
        b=J27hK+MC7SB5PysUftF2ZIcAu4TZD3SaITjwHVvHk2D8+kKxH8GfZpw174cul0c6ys
         9EocHJH7Pk4+Xe4g75O+0KxXprFd3sxABQYGYQtCpuBeKUD6kHykYgJI/ZUzBksMjpUm
         vD0DJGI5GnMgVfQ+HHmhGaZCU8KU0h0g5tyOr6DnN8TBJpFmUq+Z5y0DpVnW7g8QVVxr
         Ox0YIK2OK8Q03SmjVrdsstvQFFZeDGXLHkKUTaN8d81QQVCw1UYyBl4BK/SUhBychBqm
         uxONQFGjuduZifVmisnJ6btjRbVeoV96lMzm4ZRXUAE3NqFXbMt85qkqiUn+sSev/Brw
         bQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699600933; x=1700205733;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGF1v/gqhKIfK3lN8tg1lEaaH/f3W7AggG6onMYyyAU=;
        b=kMLKeAez27tnAK/qSx5X+jX+q5klAr+LTARXrXWl36hF4i648k/OlZcORUF+SXJGDE
         ms/7EmeCco/DkCrUSf0RbK1jNwGC9P4qlBmu84VqcNb+tNUGrVIEc5GxyYaJhm3Gl16q
         VAKLHtQfZ58fdEzw1gSNc44MAIYXOoQH44tvFPq6zbTnUCDEHpy9Kaa/6GaNThJW8ssP
         82gVib1zVAlmfkc9vV5pK5TNwjGCv6H6RfuJoLZF28Br5JSdAml+UgFzc9WmY5Zjg17q
         5ZxlVwGaFCypsqJOwpBq/auHShh+VJuDoiUFnmP1Q/PzMpp88taFUp1kIgKEeuz+vTo4
         cMGw==
X-Gm-Message-State: AOJu0YzJA4hw8i7YwCkuYS2F3J+qEgB/4PF9+hMu6XN93OqA2zhnCzQl
        EzJeHgKm12pcSVMtNe0IhDxHpUO7PfH2ULuQ9K4Vgw==
X-Google-Smtp-Source: AGHT+IH9dKkq1F5Ww/wHqKo0Olzi4faKaa+VUqagiGOI3qwKWLaQqIZvl/khSG+4iZp6x2Dc6RGO1Q==
X-Received: by 2002:a67:ef49:0:b0:452:6178:642c with SMTP id k9-20020a67ef49000000b004526178642cmr6819492vsr.1.1699588687911;
        Thu, 09 Nov 2023 19:58:07 -0800 (PST)
Received: from ?IPv6:2402:7500:4ce:aeef:99fc:78aa:eebe:b7e0? ([2402:7500:4ce:aeef:99fc:78aa:eebe:b7e0])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001cc307bcdbdsm4303356plg.211.2023.11.09.19.58.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Nov 2023 19:58:07 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH 06/12] RISC-V: crypto: add accelerated AES-CBC/CTR/ECB/XTS
 implementations
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231109071623.GB1245@sol.localdomain>
Date:   Fri, 10 Nov 2023 11:58:02 +0800
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <659DE1CF-4F42-4935-9DFD-E127269CEC54@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-7-jerry.shih@sifive.com>
 <20231102051639.GF1498@sol.localdomain>
 <39126F19-8FEB-4E18-B61D-4494B59C43A1@sifive.com>
 <20231109071623.GB1245@sol.localdomain>
To:     Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 9, 2023, at 15:16, Eric Biggers <ebiggers@kernel.org> wrote:
> On Tue, Nov 07, 2023 at 04:53:13PM +0800, Jerry Shih wrote:
>> On Nov 2, 2023, at 13:16, Eric Biggers <ebiggers@kernel.org> wrote:
>>> On Thu, Oct 26, 2023 at 02:36:38AM +0800, Jerry Shih wrote:
>>>> +static int ecb_encrypt(struct skcipher_request *req)
>>>> +{
>>>=20
>>> There's no fallback for !crypto_simd_usable() here.  I really like =
it this way.
>>> However, for it to work (for skciphers and aeads), RISC-V needs to =
allow the
>>> vector registers to be used in softirq context.  Is that already the =
case?
>>=20
>> The kernel-mode-vector could be enabled in softirq, but we don't have =
nesting
>> vector contexts. Will we have the case that kernel needs to jump to =
softirq for
>> encryptions during the regular crypto function? If yes, we need to =
have fallbacks
>> for all algorithms.
>=20
> Are you asking what happens if a softirq is taken while the CPU is =
between
> kernel_vector_begin() and kernel_vector_end()?  I think that needs to =
be
> prevented by making kernel_vector_begin() and kernel_vector_end() =
disable and
> re-enable softirqs, like what kernel_neon_begin() and =
kernel_neon_end() do on
> arm64.  Refer to commit 13150149aa6ded which implemented that behavior =
on arm64.
>=20
> - Eric

The current kernel-mode-vector implementation, it only calls =
`preempt_disable()` during
vector context. So, we will hit nesting vector context issue from =
softirq which also use
kernel-vector.
https://lore.kernel.org/all/20230721112855.1006-1-andy.chiu@sifive.com/

Maybe we could use the `simd_register_aeads_compat()` wrapping as x86 =
platform
first in a simpler way first.

-Jerry=
