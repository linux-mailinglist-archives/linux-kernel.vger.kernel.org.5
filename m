Return-Path: <linux-kernel+bounces-2396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A718815C94
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 00:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF3E1F22631
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 23:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1190374D8;
	Sat, 16 Dec 2023 23:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="HMyKsoeU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B21374CA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2c9f413d6b2so19281791fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 15:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1702769644; x=1703374444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFpkZDM6cIT9ckSQvE0/t48hRBP6YwHFDtIgAeFhGig=;
        b=HMyKsoeUE1rilkR6kNH3Fbmd/hQNpprIomguASpuhLjqyZchNfyVxZiiNbtjgM8Zb0
         RcQOebKe9qZX0KtvNvjN4EJwF0XBt2gzWvwyfCtLJpkHWUyFP11Pbp0xXFIeamGZooO1
         MCGyckG4NwMVOo0gFLFv6PdCVSY4TzbV7Zkbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702769644; x=1703374444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFpkZDM6cIT9ckSQvE0/t48hRBP6YwHFDtIgAeFhGig=;
        b=hx7uWNLiuhzzYs9ABBdBTKFLytWDqTaKKABeiTe4zlxKfTV01KweU3g/aH6uuIlSMt
         5urh75zLE04myRI9CWdy4xV2wf0g7dqQKajVq4NRq21ofpUQavNubiIMouu+4wzOWQmL
         4bZ5t+R2IKHxT3AlBwr2Kf3oXTu3mSH6wmqv7CK98rvdsxLhHFnS8vY+vN2jUkFaAScO
         8M7vex9NNHGgklnBj5DCfphodPBeiSSoN92BtLKljhQ0s4dwEN8OgWV4tvw36XiZCmXA
         ZX1j3bCnbewUBKSsshS0laYIBhhof+KmEu6Cv6TeBUdEK0KVNk0GiRvyVbLVbA0gYfBH
         T0Kw==
X-Gm-Message-State: AOJu0YwNgXbuUBlIP3jrjE+FdtEMSgn0Tgg8N/uMGBjlzqTRnvkFlEaz
	0iapwiDp4oX9g3FWkrkyFasw3bX3A6yym5nN/Ck+sWr8Su7Wapg=
X-Google-Smtp-Source: AGHT+IELyzmmAtyocYVQqJtaMsa3ZKuI8oS362iMMH8aLLh6+kHdK7lVDNZvJliyMwnuxRNTMXAsFt16df/PM1RqBE4=
X-Received: by 2002:a05:651c:c7:b0:2cc:5e72:17ef with SMTP id
 7-20020a05651c00c700b002cc5e7217efmr399673ljr.49.1702769643745; Sat, 16 Dec
 2023 15:34:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205024310.1593100-1-atishp@rivosinc.com> <20231205024310.1593100-6-atishp@rivosinc.com>
 <20231207-unpleased-landlord-8383b4c50aca@wendy>
In-Reply-To: <20231207-unpleased-landlord-8383b4c50aca@wendy>
From: Atish Patra <atishp@atishpatra.org>
Date: Sat, 16 Dec 2023 15:33:52 -0800
Message-ID: <CAOnJCU+x43E4LdNsRspCuS0WRdfejo-B_L+k1zugDftKMJ3yNg@mail.gmail.com>
Subject: Re: [RFC 5/9] RISC-V: Add SBI PMU snapshot definitions
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 4:34=E2=80=AFAM Conor Dooley <conor.dooley@microchip=
.com> wrote:
>
> On Mon, Dec 04, 2023 at 06:43:06PM -0800, Atish Patra wrote:
> > SBI PMU Snapshot function optimizes the number of traps to
> > higher privilege mode by leveraging a shared memory between the S/VS-mo=
de
> > and the M/HS mode. Add the definitions for that extension
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/sbi.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.=
h
> > index f3eeca79a02d..29821addb9b7 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -122,6 +122,7 @@ enum sbi_ext_pmu_fid {
> >       SBI_EXT_PMU_COUNTER_STOP,
> >       SBI_EXT_PMU_COUNTER_FW_READ,
> >       SBI_EXT_PMU_COUNTER_FW_READ_HI,
> > +     SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
> >  };
> >
> >  union sbi_pmu_ctr_info {
> > @@ -138,6 +139,13 @@ union sbi_pmu_ctr_info {
> >       };
> >  };
> >
> > +/* Data structure to contain the pmu snapshot data */
> > +struct riscv_pmu_snapshot_data {
> > +     uint64_t ctr_overflow_mask;
> > +     uint64_t ctr_values[64];
> > +     uint64_t reserved[447];
> > +};
> > +
> >  #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
> >  #define RISCV_PMU_RAW_EVENT_IDX 0x20000
> >
> > @@ -234,9 +242,11 @@ enum sbi_pmu_ctr_type {
> >
> >  /* Flags defined for counter start function */
> >  #define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
> > +#define SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT (1 << 1)
> >
> >  /* Flags defined for counter stop function */
> >  #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
> > +#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT (1 << 1)
>
> If we can use GENMASK in this file, why can we not use BIT()?
>

Sure. Done. I will change the other ones in a separate patch as well.

> >
> >  enum sbi_ext_dbcn_fid {
> >       SBI_EXT_DBCN_CONSOLE_WRITE =3D 0,
> > --
> > 2.34.1
> >



--=20
Regards,
Atish

