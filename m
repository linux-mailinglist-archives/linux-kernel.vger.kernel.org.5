Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982CF781962
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 13:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjHSLwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 07:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjHSLwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 07:52:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A3260BB;
        Sat, 19 Aug 2023 04:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692445796; x=1693050596; i=deller@gmx.de;
 bh=EjMxJHShEwrxNGB+OlRmt22+ZwJAHPlR2zFij4iNzW4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=MtvcLKlfMdJ8A4g1U54MbKpSndQTNEXQIw4Zc/JPXuQ9B3GMTmATO925SIgiX4gX/pnNHam
 Wli1xXdaCoZ2XHWg/QjacgqZMrxDdwHbdGd9P4cBj0xMZsNMZofXYffmgqOSL5H/4tlcbYXup
 mi24j9JwrBMulvD6sNMvndhEW5F3OOrocYqoeYdr+W5ovTzrFcH//etcLOb9NZuebqog3KlA7
 amN2P2XkxUF6xr7XLUejUYOaqjudK8pnufsWFYQGt39qm7ef5JqcO4CezY7gGRqfc6rpPpuFU
 jIsH6ysjKGDvPFBG3WQwiySQlX2UQjpGj+VAR8I91yoEzR2h473g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.154.181]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6v3-1pwb4J09hj-00pdAN; Sat, 19
 Aug 2023 13:49:56 +0200
Message-ID: <ef106f59-f7d6-93bc-6872-d60ded127830@gmx.de>
Date:   Sat, 19 Aug 2023 13:49:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] HWPOISON: add a pr_err message when forcibly send a
 sigbus
Content-Language: en-US
To:     Shuai Xue <xueshuai@linux.alibaba.com>, catalin.marinas@arm.com,
        will@kernel.org, James.Bottomley@HansenPartnership.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org
References: <20230819102212.21103-1-xueshuai@linux.alibaba.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230819102212.21103-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vEqnuzE2C0GjP6pSbpiblTMY7spBjR06BrHcICxDzhUnGR8UiUw
 5yKz/z47iRV2N9m3fCxfG9FtVTcj+9GQvGBTQB3g1YqT3ryKg36XK5O8yxvDqt348QY1Mm8
 lAhmdOcVaVEmpySQQPVk3OK55qyBEgtkFIAecXgwggGvzpx6tN1G5jSxljPX8as/HpI3Qeq
 QHvAsPWQKJkR3WE4HS8ug==
UI-OutboundReport: notjunk:1;M01:P0:ZcoAs9bADe0=;wiVrdSlFiXsPwdrvpvFouPd1gv2
 0raSLM3zmETBRyStCaPLXvtdkCgkA1aAKzTEOq+BeDFEmSBGl1RMcwjzowMCmpcHFxhC3dbGu
 mj0g0bo/4ord/R29Le1ui5FyCET5W9cE6EHpusffuFMR11WdcS7Mgg+6zft3UijidWYum3YIw
 PQmAZ9FStoYkW94JyCNwtJsUHyv/EOFWimwYaCReHq6qrCmNhOYvJSvsO7cbVeU2wO18ocfR2
 710aeenm6qQzkHksEuU8+P/cReu8iLbsoDzsaCj7EDb5ySCDTFssdU1Q+bQPBSIWJekMMzfCg
 +6O5IQ481mgpdGgdE9UVffakiCy+N37ZC1lMf74Z6dIl/me/OVZxRaSK25zR/UxKIdhQpfJYx
 flIjHNJX3sXBohs+25drxWpiEzp+cv3GsIuTc6ycyW80dqVofbxXScnaNWVtoillgZjk46xbi
 WuQykauybAJLUehzP9ydJ9Mq08cE/+WQz7eEaYQAv0DgvlgJbKh9BXL/rvsrq5/261ToE1M44
 m75an4Kz6YaMyWuu7SBjnKfixha83bPj5flXpm/6P/AZigwqHWirXbAOhg2XZwTFsiSeTsTxk
 DE+zAVXANypvj+Y6D5FRxJmrM44NJYpjh+iKCUk5Nkpvrjm/Yh6BplcESG9ZmoCUFMW821yvw
 rIxaFcDr+D8mUJQh97fHEWVUkXnAH60j21qrGGRHPyRvdmKXW/cmCAwdYB6cOeBmjzVLhpD9Y
 j4WTCMhv3t7J1nDBpPjlbBYj9kPHPZOmMlRGBu3n/BWt2znvrxcTDiK2ZU5PKAE5adEc2Yk3t
 KwhnMp0D7Ljw5Az2Af+2HC3W8y9wB4PP7axGoXlftbvfqGd/fCe6WkpYBIzL+Gko0WbsDRv1t
 kqLuEhL42bSLfOksN4YgAKwrS7HTsIyk4Ns47jTZcrUzf8KNshRhZwT5ENxAoHpfRcKEpSeZJ
 3jbjyc+wZINxeykg32F/nHb7eag=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/23 12:22, Shuai Xue wrote:
> When a process tries to access a page that is already offline, the
> kernel will send a sigbus signal with the BUS_MCEERR_AR code. This
> signal is typically handled by a registered sigbus handler in the
> process. However, if the process does not have a registered sigbus
> handler, it is important for end users to be informed about what
> happened.
>
> To address this, add an error message similar to those implemented on
> the x86, powerpc, and parisc platforms.
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>   arch/arm64/mm/fault.c  | 2 ++
>   arch/parisc/mm/fault.c | 5 ++---
>   arch/x86/mm/fault.c    | 3 +--
>   3 files changed, 5 insertions(+), 5 deletions(-)

Acked-by: Helge Deller <deller@gmx.de> # parisc


