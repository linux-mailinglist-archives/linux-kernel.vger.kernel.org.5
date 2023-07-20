Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D5175A6CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGTGqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGTGqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:46:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9041FD7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:46:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso243441b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689835570; x=1692427570;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qgqhs/1lTyAbPO02GYGHlDlSU1g7wtuCLpVWkMtjYf0=;
        b=gK/yn8maJ3MZp6CQUIAEcUT9MWu/7c9O5zZ+YCJ1pu+jAlq4c43AZWLBdZ9vvrX5QN
         hrPcCHgrFxNZTHxwm4wFMnzfO0GfzI2CHYWc0avb1j9tXydTURfGjLVAJNkuKIY0+wiY
         egm7tQqBxZDN7Ee98Pd5Sqc46N/w4egAWWmmN+oS0iZtFd5ojERsHyVa2TsW/Ib9KfRg
         OoyBmi+Sa06WBmrH/drHEur0pMf7u4a0Kmn8QtaAvQNSXMGqYFnAzLyicqJjOPbmRIk6
         qNus9yTF8ytvNRAaulC0r59A9MaEHpZyw/jv2DgVOHBLziHH2yVQqH/py1zR9y7DNNDO
         9SCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689835570; x=1692427570;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:date:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qgqhs/1lTyAbPO02GYGHlDlSU1g7wtuCLpVWkMtjYf0=;
        b=OUeuZJsJZkByvIqzi8XNgBegNjikinoKZG745ckjdt7RVlpIMhebUwKG5j8aH1X7YH
         ER3AvOAWzLRp62lIv7zvgaAfK/3xYnfmdd5uCLxjtdFzlyzX5Hsa7i7foKUP7X8Rz6aP
         C+yfELTVrh9eJHO/cTSoO2jAfBa2IcRC5TyRKADbIbgJayXT+5F5Et6NzzOzr/WXAm4c
         /tuy3ral6TDYOs3EbeSiEb7aX1N/CbztIwxXs3A3UqOS1W6S7h6vd+OliCqW9IUQS1G8
         t4Sbz1SBnMQJcXGR7OoGfAMMEUdjdTAbXRVqW1KTa4o1k8IgNzQy5RWXT9YSyebuJOd2
         bMQA==
X-Gm-Message-State: ABy/qLagSedwliOaNZI4HJeRbTl/6VpvbNsuRdDKW6rU/1nICA0fgiaT
        lRX/5W66Pqcu4xHyLus2Wak=
X-Google-Smtp-Source: APBJJlHwiV2jMn0EixFhhaqW77Z1RHimnV/10+I0waoX2pIkB3VdJxUPO4dmUTSnX5gjdF3cyZWMwg==
X-Received: by 2002:a05:6a20:6a22:b0:134:d4d3:f0a7 with SMTP id p34-20020a056a206a2200b00134d4d3f0a7mr11293569pzk.9.1689835570008;
        Wed, 19 Jul 2023 23:46:10 -0700 (PDT)
Received: from [127.0.0.1] ([212.107.28.54])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902728700b001b8a3729c23sm450389pll.17.2023.07.19.23.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 23:46:09 -0700 (PDT)
From:   Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Date:   Thu, 20 Jul 2023 14:46:03 +0800
To:     =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Andreas Schwab <schwab@suse.de>
CC:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felix Yan <felixonmars@archlinux.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Subject: Re: [PATCH v3] riscv: entry: set a0 = -ENOSYS only when syscall != -1
User-Agent: K-9 Mail for Android
In-Reply-To: <878rbbkgqo.fsf@all.your.base.are.belong.to.us>
References: <20230718210037.250665-1-CoelacanthusHex@gmail.com> <mvmo7k8cqns.fsf@suse.de> <878rbbkgqo.fsf@all.your.base.are.belong.to.us>
Message-ID: <54D8BFF7-C4D2-417E-B18C-62B5DB17B51B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 20, 2023 12:28:47 AM GMT+08:00, "Bj=C3=B6rn T=C3=B6pel" <bjorn@kern=
el=2Eorg> wrote:
>Andreas Schwab <schwab@suse=2Ede> writes:
>
>> On Jul 19 2023, Celeste Liu wrote:
>>
>>> @@ -308,7 +312,7 @@ asmlinkage __visible __trap_section void do_trap_e=
call_u(struct pt_regs *regs)
>>> =20
>>>  		if (syscall < NR_syscalls)
>>>  			syscall_handler(regs, syscall);
>>> -		else
>>> +		else if ((long)syscall !=3D -1L)
>>
>> You can also use syscall !=3D -1UL or even syscall !=3D -1=2E
>
>The former is indeed better for the eyes! :-) The latter will get a
>-Wsign-compare warning, no?
>
>
>Bj=C3=B6rn

Well, that's true=2E And I just found out that by C standards, converting
ulong to long is implementation-defined behavior, unlike long to ulong
which is well-defined=2E So it is really better than (long)syscall !=3D -1=
L=2E
