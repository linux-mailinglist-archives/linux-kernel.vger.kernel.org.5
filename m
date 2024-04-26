Return-Path: <linux-kernel+bounces-159659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035508B31AB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363F31C21A33
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062D813C91D;
	Fri, 26 Apr 2024 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="xzW49MLD"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D813C8FB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117689; cv=none; b=dgoIjOt78clX2ShkqzB5BK3JFP+P2hZ/tKjDigmpkmM8Q625dJQgjDVA3RjdHtuibU80UMhgqqo/1vMKhaqYt9Lqg317ziK4iI03HyXYv/A2ovkYTw0M4mU3LOsCX+w0Rv9nfDw7zDVEbsuXVFxqNfN5m/WhXdPYIUu47k8xoo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117689; c=relaxed/simple;
	bh=vmkeqn3rKHnWqckJmlW6f94yaV5GqJVhMoZZp7s4Y3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTBLL3f7x4xTY6Je1luYaOe5rG/rPLZTHOTYNuF6cAMDQpabir2kkOo0QQ+NJh52O79NTRID9a79D1iy8HO6qQT9p4/E/WlWLE/LMp4Nt2ZgVfhDtznECdEaOM505O42JcQ6WhwAzK/MPNco6KoyGDWW8NOh4vN499lEZe6/giU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=xzW49MLD; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36a17999886so8179075ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1714117687; x=1714722487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNEXb7K7k6t0jTc2DZhY7wfuFpObcVhQaJunE5Y0/3Y=;
        b=xzW49MLDr7tYrmR3gIhDVJSGgG2H2EH0xeKaToJjJbaSQhXx8zBb+ZutGlL1Ujg4q9
         01KS0AAjmDE7XTnDhDWvfRGIJthmLmaz/3tPIzIdgbWzqvwsCzdWCLQhtGdxq6BeP1f4
         uvUUqGUPOKOpxXwtypOIubNVjeGk3PB+CznQlA2fbS4iZfgm0q5K96wL61MvIO7kTc0C
         BZ5rZ/Ko1D0EJD70wdlTn3ZpAgkXJIur68MtRTYNfHKiGfE7gA6GLRHlPQZhz3hklBb8
         r52ztxbh5K/WkfJRtscj7Ey9wxqDNOEBbRUefyxIydIDxedEJJD8/LdjAuVsBm3PePX+
         rJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714117687; x=1714722487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNEXb7K7k6t0jTc2DZhY7wfuFpObcVhQaJunE5Y0/3Y=;
        b=YKR2ToTzl4DEddhp/84Y0baPo0GzXUNsLZSOSMU74D52dwxQtskFgRqT92GeMEGjFX
         mbnpW1nhPKZ6126ZIdeewS2ZWe6GVu8zqI/7G5OnRz/HoccsFg40eMb+/vW1GYmrZddo
         OFUqIwiN+fxIDzNTgZWekbOk65m/UL6n6Vy2EWt4AcL1cTi0xqVTl0YgIu+jxotnZ6X3
         tkOP9uGE4pcew35VkQo1Hyz0DxRFE1dylzOQAh29IqxOfGwbFsrM5bykG/dbSrgIEt7v
         rxUU7Dw8NFzRSHtE2onboz63XpeTz52Z+j64DM+CgAqa0pPdyF+1lSVsn91Ij6itdo69
         pORw==
X-Gm-Message-State: AOJu0YxwEtd44VXJSu+tcMwUMv31VPKKXV2/IU4oWAPTFpkvtHymPnyH
	H/P4WHxklkHEhiGKhVYfIbXFnJIOThF8MVUF3nWHAXL1g8wHuwF3GP9gLxFZRI6OBNEU0IVtQBq
	K8YqTzcA5AmzrrNHkOcGmdOOu+9+8MHBLO6PWRA==
X-Google-Smtp-Source: AGHT+IH2kcTnzYfBFJ/vpjEldVVO004BbvrN6JipfMdczlULdyDkCg/N4VNB2dpxRuYiuEQfYrwp5U/HbOfG3wASDPg=
X-Received: by 2002:a05:6e02:1fc9:b0:36b:239f:c0e with SMTP id
 dj9-20020a056e021fc900b0036b239f0c0emr2320106ilb.0.1714117686829; Fri, 26 Apr
 2024 00:48:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426031637.4135544-1-atishp@rivosinc.com>
In-Reply-To: <20240426031637.4135544-1-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 26 Apr 2024 13:17:55 +0530
Message-ID: <CAAhSdy2xECj3AOBNCVJSsNi==7PdT5riqx7-gsVd-v0MdRU2ag@mail.gmail.com>
Subject: Re: [PATCH v2 kvm-riscv/for-next 0/2] Fixes for kvm-riscv
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Patra <atishp@atishpatra.org>, Conor Dooley <conor.dooley@microchip.com>, 
	linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:18=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> Here are two fixes for issues found during review/testing after the
> series[1] has been queued for 6.10.
>
> @Anup: Can you please squash them into the original source commit
> 22f5dac41004 that introduced this ?
>
> [1] https://lore.kernel.org/all/20240420151741.962500-1-atishp@rivosinc.c=
om/
>
> Changes from v1->v2:
> 1. Added RB tags.
> 2. Optimized the logic for overflow mask.
> 3. Update the fixes tag. The cover letter should be enough to indicate th=
e base
>    tag for rebasing.
>
> Atish Patra (2):
> drivers/perf: riscv: Remove the warning from stop function
> drivers/perf: riscv: Fix RV32 snapshot overflow use case

Thanks, I have squashed both fixes into appropriate commit along
with Samuel's Reviewed-by

Regards,
Anup

>
> drivers/perf/riscv_pmu.c       |  2 --
> drivers/perf/riscv_pmu_sbi.c   | 45 +++++++++++++++++++---------------
> include/linux/perf/riscv_pmu.h |  2 ++
> 3 files changed, 27 insertions(+), 22 deletions(-)
>
> --
> 2.34.1
>

