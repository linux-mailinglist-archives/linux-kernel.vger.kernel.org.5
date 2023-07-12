Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3ED750E88
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjGLQ2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjGLQ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:28:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F7DE8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:28:27 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-66767d628e2so4978461b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689179306; x=1691771306;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMR0yJDEi84nCI/TrP6aGjhAtZGDlFpByViEAFnqtS4=;
        b=g4y71GV/w9702oToZMObTpkTa+u3aSPHjm81eprOMwI3dwJYuaT7Dh9psOzaUbme9j
         jNSqEhQi4lwGcXir+Pon6+/KBfx7XK/azvv/DTZULucyLTWtr4JWLHznyac+JUhNREsO
         lc7zY4wvNGb4kurRlxpc2CiegCghd8sG9hMh4B6jQ1tZfEq3C9LVs50O+QifU9IG/7DI
         3rRX6WPt0emKmBHe5SfItsUuFW3/Te2HdpgzoS8txP6p4JS46eRv5CSGTIKAo2z63ioc
         oLG8frkob1QWB7RDIPPpaH9VShaG0u5oVnZd6imK9evAy0iXu4p+lSFsG2cZAQ8ycN1d
         LIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689179306; x=1691771306;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMR0yJDEi84nCI/TrP6aGjhAtZGDlFpByViEAFnqtS4=;
        b=GnYZO49OkF/X5GeVAxNsg7bDp8ktrPU4zU61JKalkdZWTzIIUQYuDPjBZ67jasJKVh
         URLMBsBXaZlBGmS9O/gx3tjefzjMYPJCqPHURIppOIeEgT2/VZuyLYX2DqOlNaEEc9An
         L59cbm57cSg9yqESTafL8Esv9GRGuAXuHpuVSF36gkoS1nhqZHtye7yJtdoYqc3v6179
         pyPbm7ERnTrNg0RGOb5hCXAcSwOi6LylloiZByR9uaKy/+lfEht64PT/IM9Q0bKMdi2v
         C9+BOlacKyUPYk/tLuT/7JkOXzny1G66vZxdoK0C89oRlh0bVA6amxgTAcp6/jEYtmg3
         AH0g==
X-Gm-Message-State: ABy/qLbwszpa8vDUvUZackyYdYIgxWhhfXImwOi2Z3OoNKW5rnAuuh5C
        7lhSVyeKlThftMC8ppE0o3+FGWKe+E4TibPXF3M=
X-Google-Smtp-Source: APBJJlFZBFgsQ8+gVT48gyjSGqBTtcpSTxd7btoVW0hsGdrnpDWgka9sHLPNjH6khg5W3o+SikMBFw==
X-Received: by 2002:a17:902:eccb:b0:1b9:e9b2:1288 with SMTP id a11-20020a170902eccb00b001b9e9b21288mr6666980plh.38.1689179306545;
        Wed, 12 Jul 2023 09:28:26 -0700 (PDT)
Received: from localhost ([50.38.6.230])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902cd0d00b001ae5d21f760sm4191786ply.146.2023.07.12.09.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 09:28:25 -0700 (PDT)
Date:   Wed, 12 Jul 2023 09:28:25 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jul 2023 09:27:38 PDT (-0700)
Subject:     Re: [PATCH -next] modpost: move some defines to the file head
In-Reply-To: <CAK7LNARuR5cturyngN31Oy=PwMG_-p5iOek2BuDSKHSyZg44Xg@mail.gmail.com>
CC:     wangkefeng.wang@huawei.com, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     masahiroy@kernel.org
Message-ID: <mhng-7876bf10-0477-4ca6-af22-e3479e8ad123@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 08:55:23 PDT (-0700), masahiroy@kernel.org wrote:
> +To: Luis Chamberlain, the commiter of the breakage
>
>
>
> On Wed, Jul 12, 2023 at 10:44 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>> with "module: Ignore RISC-V mapping symbols too", build error occurs,
>>
>> scripts/mod/modpost.c: In function ‘is_valid_name’:
>> scripts/mod/modpost.c:1055:57: error: ‘EM_RISCV’ undeclared (first use in this function)
>>   return !is_mapping_symbol(name, elf->hdr->e_machine == EM_RISCV);
>>
>> Fix it by moving the EM_RISCV to the file head, also some other
>> defines in case of similar problem in the future.
>
>
>
> BTW, why is the flag 'is_riscv' needed?
>
>
> All symbols starting with '$' look special to me.
>
>
>
> Why not like this?
>
>
>        if (str[0] == '$')
>                  return true;
>
>        return false;

There's a bit of commentary in the v1 
<https://lore.kernel.org/all/20230707054007.32591-1-palmer@rivosinc.com/>, 
but essentially it's not necessary.  I just wanted to play things safe 
and avoid changing the mapping symbol detection elsewhere in order to 
deal with RISC-V.

IIRC we decided $ was special in RISC-V because there were some other 
ports that behaved that way, but it wasn't universal.  If folks are OK 
treating $-prefixed symbols as special everywhere that's fine with me, I 
just wasn't sure what the right answer was.  

There's also some similar arch-specific-ness with the labels and such in 
here.

>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  scripts/mod/modpost.c | 32 ++++++++++++++++----------------
>>  1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>> index 7c71429d6502..885cca272eb8 100644
>> --- a/scripts/mod/modpost.c
>> +++ b/scripts/mod/modpost.c
>> @@ -60,6 +60,22 @@ static unsigned int nr_unresolved;
>>
>>  #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
>>
>> +#ifndef EM_RISCV
>> +#define EM_RISCV               243
>> +#endif
>> +
>> +#ifndef R_RISCV_SUB32
>> +#define R_RISCV_SUB32          39
>> +#endif
>> +
>> +#ifndef EM_LOONGARCH
>> +#define EM_LOONGARCH           258
>> +#endif
>> +
>> +#ifndef R_LARCH_SUB32
>> +#define R_LARCH_SUB32          55
>> +#endif
>> +
>>  void __attribute__((format(printf, 2, 3)))
>>  modpost_log(enum loglevel loglevel, const char *fmt, ...)
>>  {
>> @@ -1428,22 +1444,6 @@ static int addend_mips_rel(uint32_t *location, Elf_Rela *r)
>>         return 0;
>>  }
>>
>> -#ifndef EM_RISCV
>> -#define EM_RISCV               243
>> -#endif
>> -
>> -#ifndef R_RISCV_SUB32
>> -#define R_RISCV_SUB32          39
>> -#endif
>> -
>> -#ifndef EM_LOONGARCH
>> -#define EM_LOONGARCH           258
>> -#endif
>> -
>> -#ifndef R_LARCH_SUB32
>> -#define R_LARCH_SUB32          55
>> -#endif
>> -
>>  static void section_rela(struct module *mod, struct elf_info *elf,
>>                          Elf_Shdr *sechdr)
>>  {
>> --
>> 2.41.0
>>
