Return-Path: <linux-kernel+bounces-83281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3845086913E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C43B27A57
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1024D13B28D;
	Tue, 27 Feb 2024 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5NXArEV"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB2313A892;
	Tue, 27 Feb 2024 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039007; cv=none; b=nQJ1uzHexx251/IgqilMNh6fU5mM+xCiTLtd3CZzPwBDx0pMhF+JZSBbqVgtMqA6nzFm3N5MO7SQ5n5sOT64h/Ktd+Etn09R4TqPea7jnzCeM38b5nrozyEvbsy1083LRsjxHECI0lwdrIqJl4dut4P4/ha4BRpmKqbS37AMjDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039007; c=relaxed/simple;
	bh=6EyxiHcbJEh3svJuBfcyNS1BNR8m7lp1BcGOod3rF1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0wv3Dj8nDRCECZgBF22RVyTILzdOVWEmYWdDsF/XfXWcRlKAYNZB4BYY1oBa5fQtAANebLT9/CS1HfDUSJpt/RRUEvaX5PKH5SodiBjIyF4V+QId6kl7/M3ba18B0QKtUHnxMWhe/hbssUhwmDU8MhxjvIDdw1wqwy6nQF6Tkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5NXArEV; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a0ad7ad6c0so297002eaf.2;
        Tue, 27 Feb 2024 05:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709039004; x=1709643804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4IP/lc1tu6L75ZltzpJOjRv1Wc7ej1h8ro3tZmKncqs=;
        b=f5NXArEVasG3yxcZg5wyim4A6hP5o+8Q9hoCuK2+pv4bTWb/jfEv1PYh2b9/juFxoV
         AVMZWZvLh9cBkut88+bMNCWnoIIBX4YNGYreDvxCvx/RR7RSRVDBw+umBl2qhfXhKcgw
         thJgaK8icqAYTpxuClUfbSoC2HvQUTItzdGnXoEB8Gm0OrTlxmQvm1uqfLerLEAyBu2Y
         +uHqwcwP3co4mJeKiVkeqi7vqs4hRnZO+eTsGVBesTZRcQzDAHbOjI4Ciu857R3Onfo0
         c0E3oRnb1LaEJoItgqi1yUSdW91H9xaIi7Q5VBFuC1pm0zHDEpNPW6uCaYGQD+CJa6jt
         8ZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039004; x=1709643804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IP/lc1tu6L75ZltzpJOjRv1Wc7ej1h8ro3tZmKncqs=;
        b=nAyrF5BzHXmTiWI9Rt2Y3fx23ZSbVb2QHXiwWziYOvWGaYnkyUusVy/pWDxulzmu2E
         1NTJqofaOypsywEc8l6GTxHk109MSpbgEueMhtkjzb085f8aosvQibYTw4NyPrmO367E
         FsX+ZL+dx2n6T1RJK+nCmVxhyVWK6kl61fHRYcFWh6dJVjI9dTpjp4ErgkvFTWy7qV4y
         OIC6/Eoeo68vb9qZUoQqaFVdgwlPIw1qh0T1g8f4VsTtyWp1fSh+bOPV/ILu2o2tQ+3Y
         rATH6pdAcHSKVyjYkSLpnIt3G9SXMFr9eQGDVTC+J3BiBn6g5x+Mt8MCrhHjdbYc7oCY
         qQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCWg4VMq8U4W/qmqiLKxaGt4ChpRqubw5mrUKdj6INeBvyQC6DuAD549m6CX4R/SV1fOYUMYYw39rqrjq/uuQSJgKJrR4V5WuB4zmG2z
X-Gm-Message-State: AOJu0YxNclgxtT4JPjwh8OLKTATeol4yFe0v0llFwgc8rJjRt6tgyC8q
	L7Qnjvzb4+jnMvvhTsscgqGTSGaKrkWR4e6EAeAS8hgoR+DfLpXd4cIjtmC/BsH45TzuKyEQqoU
	lFjvbhIfcDg+SbYo7AL4YXHe+UGY=
X-Google-Smtp-Source: AGHT+IGAP8utKe86sQghKbQOxWb39Elk4eQMDdlg0E4ZOowf5TBPfCkJPQMtKF7OVN8Y9rNxMQ7LLdcQY/Q9n9gM9LE=
X-Received: by 2002:a4a:c80a:0:b0:5a0:9513:484d with SMTP id
 s10-20020a4ac80a000000b005a09513484dmr4603772ooq.9.1709039004466; Tue, 27 Feb
 2024 05:03:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205171930.968-1-linux.amoon@gmail.com> <20240205171930.968-2-linux.amoon@gmail.com>
In-Reply-To: <20240205171930.968-2-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 27 Feb 2024 18:33:08 +0530
Message-ID: <CANAwSgSzUW97U8MbWPdb_g4hqEpvLrVDGHG9Gjs2xALbDasqmg@mail.gmail.com>
Subject: Re: [PATCHv1 1/5] arm64: dts: amlogic: Add cache information to the
 Amlogic GXBB and GXL SoC
To: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Neil,

On Mon, 5 Feb 2024 at 22:50, Anand Moon <linux.amoon@gmail.com> wrote:
>
> As per S905 and S905X datasheet add missing cache information to
> the Amlogic GXBB and GXL SoC.
>
> - Each Cortex-A53 core has 32KB of L1 instruction cache available and
>         32KB of L1 data cache available.
> - Along with 512KB Unified L2 cache.
>
> To improve system performance.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Datasheet
> [0] https://dn.odroid.com/S905/DataSheet/S905_Public_Datasheet_V1.1.4.pdf
> ---

As per the Arm Cortex A53 TRM documentation
[0] https://developer.arm.com/documentation/ddi0500/j/Introduction/Implementation-options?lang=en

Since this SoC supports arm-pmu we could  read cache info using perf
[1] https://www.baeldung.com/linux/analyze-cache-misses

[alarm@archl-librecm ~]$ sudo perf list

List of pre-defined events (to be used in -e or -M):

  branch-instructions OR branches                    [Hardware event]
  branch-misses                                      [Hardware event]
  bus-cycles                                         [Hardware event]
  cache-misses                                       [Hardware event]
  cache-references                                   [Hardware event]
  cpu-cycles OR cycles                               [Hardware event]
  instructions                                       [Hardware event]
  alignment-faults                                   [Software event]
  bpf-output                                         [Software event]
  cgroup-switches                                    [Software event]
  context-switches OR cs                             [Software event]
  cpu-clock                                          [Software event]
  cpu-migrations OR migrations                       [Software event]
  dummy                                              [Software event]
  emulation-faults                                   [Software event]
  major-faults                                       [Software event]
  minor-faults                                       [Software event]
  page-faults OR faults                              [Software event]
  task-clock                                         [Software event]
  duration_time                                      [Tool event]
  user_time                                          [Tool event]
  system_time                                        [Tool event]

armv8_cortex_a53:
  L1-dcache-loads OR armv8_cortex_a53/L1-dcache-loads/
  L1-dcache-load-misses OR armv8_cortex_a53/L1-dcache-load-misses/
  L1-dcache-prefetch-misses OR armv8_cortex_a53/L1-dcache-prefetch-misses/
  L1-icache-loads OR armv8_cortex_a53/L1-icache-loads/
  L1-icache-load-misses OR armv8_cortex_a53/L1-icache-load-misses/
  dTLB-load-misses OR armv8_cortex_a53/dTLB-load-misses/
  iTLB-load-misses OR armv8_cortex_a53/iTLB-load-misses/
  branch-loads OR armv8_cortex_a53/branch-loads/
  branch-load-misses OR armv8_cortex_a53/branch-load-misses/
  node-loads OR armv8_cortex_a53/node-loads/
  node-stores OR armv8_cortex_a53/node-stores/
  br_immed_retired OR armv8_cortex_a53/br_immed_retired/[Kernel PMU event]
  br_mis_pred OR armv8_cortex_a53/br_mis_pred/       [Kernel PMU event]
  br_pred OR armv8_cortex_a53/br_pred/               [Kernel PMU event]
  bus_access OR armv8_cortex_a53/bus_access/         [Kernel PMU event]
  bus_cycles OR armv8_cortex_a53/bus_cycles/         [Kernel PMU event]
  cid_write_retired OR armv8_cortex_a53/cid_write_retired/[Kernel PMU event]
  cpu_cycles OR armv8_cortex_a53/cpu_cycles/         [Kernel PMU event]
  exc_return OR armv8_cortex_a53/exc_return/         [Kernel PMU event]

[alarm@archl-librecm ~]$ perf stat -B -e
cache-references,cache-misses,cycles,instructions,branches,faults,migrations
sleep 5

 Performance counter stats for 'sleep 5':

             52794      cache-references:u
              2311      cache-misses:u                   #    4.38% of
all cache refs
            480343      cycles:u
            140018      instructions:u                   #    0.29
insn per cycle
             15012      branches:u
                46      faults:u
                 0      migrations:u

       5.008073381 seconds time elapsed

       0.000000000 seconds user
       0.006952000 seconds sys

Thanks



-Anand

