Return-Path: <linux-kernel+bounces-147834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487B28A7A40
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042662829A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D3D4428;
	Wed, 17 Apr 2024 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="rk1GSfDl"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AF41860
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713318595; cv=none; b=AlwiMkhcqhJIkt5FA5MuXCAFFtDdM66Elyf3CB9tyRrPKjt+IWlAwJYP80AcfsYz/YL4dx6Xa0/WysR1Pju0pc3uhAT2cZZzUXDpnxKznafGP+pmg8wiH/2H30OyVLuhKP18aHcQDpGg4LmuYhqdQ08RoB0CsJc7SJf2WeAVnow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713318595; c=relaxed/simple;
	bh=LWjzusM87LwqdtPk88JKoKJ93L0z6wphTPICClkfiUI=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=K+N69AXovfiRVRNtFmvRXDouqKB5AhP+oTsBJ+XJgAWAXu/EOZMh078RuX412zR95QACEnyuBSJYFv5NJfnKpOHnTKO4v+ZLJ/uduh7Ilob50ZikMPbg2QK0uSfR9liZCFMsuzJauNjkrzrePr8Wlm1blvkbGOJzMnsK9HV3F4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=rk1GSfDl; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5e152c757a5so2881600a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1713318592; x=1713923392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qALZDphy9R4qs652P6WCNunAjFthlKkxzdNdTmcrvs=;
        b=rk1GSfDlPZ27fXiYsmPZUFaYRXuIjNp87PpoX2Z9uJIL8CpMTh6wXXua9uKlqvwo7Y
         Spa/N0aKGfQQphfFt5GVQ7/SlVFGM4CtYicV6XYmb7oLILsSgIMcsuYZW7EwecADZAyC
         CyVprsVjpQcQPnkAbcfVkESwkJc2F1I03xX72pff2Ow2FZDdYXwoNPCII5PoSDDsdzwu
         1oEnq8w+LNKsuXm57kd5WotUpcjD9tuuv2FXzyOqwA/nR5I4AUcYOiRNgS6zPVaOGD2g
         JzjxWUVMU5AO4w+DEcjdxkX1t7GvemvurSLJwnGeIdezzFEkMJNvOKK9eAObOqBUDqo+
         GMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713318592; x=1713923392;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qALZDphy9R4qs652P6WCNunAjFthlKkxzdNdTmcrvs=;
        b=P9YkGKmmN/vMK7JmOXVDkX2EJr1Ii19N5LVlh3QWqMHW5VuTxV/ymjJfTvU3Ojuuv6
         ynjls81mX2wa2VZd+CvfZoV5XVY80hOJBGIK72BFEJ0d1VA+d69jajAk4JvjO8bnHAdG
         IEYWDqulIbY/r3Kuo2uW4AO7OMhyNfYOwUVChZjt2N6X35ml8lFS22rXVFM8JLiTS3xa
         yqsPfK7MWvr8Qjs/57gLQ9QpGrm1qF8l6wbVJNa6bHPPjJSoArbUaPkgzullVRznNTFH
         6DRNkA0nZKGlUA9zH8nU9ruQevVjwGSuJCBhfKNr28WzEZe5CJBNYVwXeugOqGmhdZk4
         vYDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcKjYOOjEe5YRg/29pjq5Xy37qsaSYxzOqm89FTOnH7+eeEn5cvDlFtg9M6eMvdc77fGJAV1oHvkvdGZFYfUKl5dxDiTEvvKOpg1Nu
X-Gm-Message-State: AOJu0Yw8hsa7UX1VvRLJGHMt+D1ElntRA3GrAkmF/oYZ8Yq4mf9CoAiK
	wjZl/j4PCKpnMqNZ31wKBeIbXR8HIPJu+0imI6NftQJfPL++3tgJWRTrmg0dsS8=
X-Google-Smtp-Source: AGHT+IHdS+vBg2EX+ZidcrjDuLNyRMWoghVyRqSbIb4Cge8joJNnr3c+J4X31DWTesfrNIWIXrEaxA==
X-Received: by 2002:a05:6a21:3416:b0:1aa:5b06:315d with SMTP id yn22-20020a056a21341600b001aa5b06315dmr2672869pzb.7.1713318592341;
        Tue, 16 Apr 2024 18:49:52 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090aba0100b002a7b1c7db84sm268670pjr.2.2024.04.16.18.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 18:49:51 -0700 (PDT)
Date: Tue, 16 Apr 2024 18:49:51 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Apr 2024 18:49:21 PDT (-0700)
Subject:     Re: [PATCH] clocksource/drivers/timer-riscv: Drop extra CSR write
In-Reply-To: <CAK9=C2Vsq0iN5FW=zC7+2GHe115TPJOEEPcDCLs_40yBGpbVdw@mail.gmail.com>
CC: samuel.holland@sifive.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
  aou@eecs.berkeley.edu, Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org,
  linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: apatel@ventanamicro.com
Message-ID: <mhng-3a5fcdd0-0bf4-45d3-aa7d-fffddd852288@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 13 Mar 2024 09:56:34 PDT (-0700), apatel@ventanamicro.com wrote:
> On Wed, Mar 13, 2024 at 1:03 AM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>>
>> On riscv32, the time comparator value is split across two CSRs. We write
>> both when stopping the timer, but realistically the time is just as
>> unlikely to reach 0xffffffff00000000 as 0xffffffffffffffff, so there is
>> no need to write the low CSR.
>
> Even though unlikely, there is still a theoretical possibility of
> counter reaching value 0xffffffff00000000.

I guess that depends on the timebase frequency, but if my math is right 
then we've got some timers that will overflow a 32-bit counter in 10 
minutes -- take that with a grain of salt as they're all 64-bit systems 
(we don't have any 32-bit DTs upstream?), but it still seems plausible 
for 32-bit overflows to happen here on real systems.

> The good thing about value 0xffffffffffffffff is that the counter will
> immediately wrap around after reaching it.

I'm not sure how that's good?  Luckily we've got ~100,000 years to 
figure out, even on these systems with pretty fast timers ;)

> Regards,
> Anup
>
>
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>>  drivers/clocksource/timer-riscv.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
>> index e66dcbd66566..eaaf01f3c34b 100644
>> --- a/drivers/clocksource/timer-riscv.c
>> +++ b/drivers/clocksource/timer-riscv.c
>> @@ -35,9 +35,10 @@ static bool riscv_timer_cannot_wake_cpu;
>>  static void riscv_clock_event_stop(void)
>>  {
>>         if (static_branch_likely(&riscv_sstc_available)) {
>> -               csr_write(CSR_STIMECMP, ULONG_MAX);
>>                 if (IS_ENABLED(CONFIG_32BIT))
>>                         csr_write(CSR_STIMECMPH, ULONG_MAX);
>> +               else
>> +                       csr_write(CSR_STIMECMP, ULONG_MAX);
>>         } else {
>>                 sbi_set_timer(U64_MAX);
>>         }
>> --
>> 2.43.1
>>
>>

