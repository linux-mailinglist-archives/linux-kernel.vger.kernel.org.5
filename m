Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C2C78A125
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 21:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjH0TYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 15:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjH0TYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 15:24:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B4411B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 12:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693164217; x=1693769017; i=toralf.foerster@gmx.de;
 bh=9cthyyR5pATU47+hCrkrduWMPV2m6FepyCngzXx8/MA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=e8ra4ndYtG179DNrKV5Qt8DAW5G0aFWVPaXQB0A9Kcum3dAON7+OKzp1TNBfhDwZRtXKRcS
 hMc9CxnLwa8aq8ecvQgDHca+ZILO2wNhdbsvMzzItnvKnQKn06ABHxVMkAAOu0+Ajy3MbT1G+
 YgDXGO2LbqshYcbIX9VB9TxNr+ttfCqr45pJ2LtK6F3RWE9VGdI9znw6S+r7q7Jwo7HFv8wXV
 olWPvqtiY4Go26K2wPqnES+1KfYbGOc0RILT2Rcbi1w0TJkCjWvCt3M/R7xJgob7K3by4bMj+
 nGlM1A906N2wBLbgXm6acxqcXTy3I5E18pn564q6sO2mS8RBmUBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.33] ([95.116.221.218]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQiS-1qS3t10qHu-00AYg0; Sun, 27
 Aug 2023 21:23:37 +0200
Message-ID: <04f1b4fb-5441-6178-7ae3-39479571b339@gmx.de>
Date:   Sun, 27 Aug 2023 21:23:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: 6.1.48 regression at boot : WARNING: CPU: 0 PID: 0 at
 arch/x86/kernel/alternative.c:572 apply_returns+0x1e4/0x210
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Borislav Petkov <bp@alien8.de>
References: <3d6fbd04-2861-91a8-938c-45195f307eed@gmx.de>
 <ZOsv0h6bsYSnfg2b@debian.me>
Content-Language: en-US
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
In-Reply-To: <ZOsv0h6bsYSnfg2b@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:22sK1WDFD5u4DJdms24gXDNSvCWBjaU1QtBAOmCkrBMH8CBx8Ih
 UaLOc4xajepwnHoLwK3QupprK4mDeSCaRvKC101g2V0bIRJfKphC7M5GXjMAvCVh6Nq3/6G
 eI6ThKUK23SQssQmIt57qHNc+TBrk8VjVErKCDD8Ije51kPebrE3M5DtV97sQLQNEWSUCXh
 GLYEgyB/6rhFqpGr4Ub+g==
UI-OutboundReport: notjunk:1;M01:P0:3fB7WKkBEjw=;C3SFUN+Z4sVoeJmbMIN6LnHo0oP
 /cB9DGM00f9ywiltyclbhUgLZX7s9kdBLlQ+jN+he1jyUPTkYLkeLX+3c6fwuqsg7JD+dRayE
 z+m1E5QOr5QNOnP+oRpv+P4YZlCrzEc8FmtxxErkxtEZ/qg02JJLzGp+AkshSaCB8YyHQ4mi/
 ivs8ds/3OG8RxjPSPmTwDfBQagzzIoKxJRlEXm/+NLNvaTnJ0q/R8eSEOQDumcHMWgg2OzrqF
 /vRDlitmabqT497uP+Yc44/xb28tYgrtTUgxF/QQzjTFiP0ZAtVanxJNKHscpnPnhzaJHb2J6
 N208ocn/2hhRd0mzuEa42bA1YwxnGn9XWuPHxQ9J/0pE6efPqDgWHbsGu+z0+55eZjEZsF7af
 r5R1Bw49GfjnXoM+h5BqadNe7Peh4XNEibPO8byKx3vYutNWomD5Sp0hicX0bHIJw+wV3u+mG
 crgbozaRDwojLqzeEKHbD0PfQWJlugDGcZhSes6832lhupFKEkpxYQMgkqsjLN6tfriM7C6FT
 qGThflcSLu/srx8O2sePUfUZcRDX+kNsI9ghlcz1vG334U0FgL6kVoKSwQ+07YA9zyYloBMOb
 P0LogsgCn7Z1BKLhyFHBphnbBr8Lbkcd0ItsFCZg8GumUMFChwwFQXrT69Lxg/+HUK2D5Jj3a
 LA99pjEpxoUcIC9Kq0/XrmYkisnP00xvQY/fUeZdHK3fqAS2WGIIjgL5yAgKDgerJper6dewo
 38GOYMYPgtb+9Nn9ouFt3pjPhnWfY65FhodiWWebBTDjSMXjl/tB/1YMtQhrMXCG6Ei2lRW5h
 64QZByZhda53sXERGHJu31VTm/W/edkquz3bO83n54uu6nMdmioyXB9j1NdEr8O/c5Twf10e+
 qf2SEazh/Bs5xlW0hMWoOe6rZZp9aaG86LSc0FfqWiedJNXvo5ZEUqnwfK3mwjCg8oN3SuRn9
 5/pnZg==
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/23 13:13, Bagas Sanjaya wrote:
> Thanks for the regression report. I'm adding it to regzbot (as stable-sp=
ecific
> regression for now):
>
> #regzbot ^introduced: v6.1.47..v6.1.48

fixed by 6.1.49 - thx

=2D-
Toralf

