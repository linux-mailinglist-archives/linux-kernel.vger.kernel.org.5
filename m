Return-Path: <linux-kernel+bounces-17137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B01C8248CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3071F25810
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DBA2C193;
	Thu,  4 Jan 2024 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GlyzLG4/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210828E3B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3600b2c43a8so15345ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704395627; x=1705000427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHGAPn/+NHpE1B6gjxmM7YpR92I2FPZpzdnyVIrUAnU=;
        b=GlyzLG4/ptBrGTuyqL29cTJjIwhpuzWd+b6omFGUImKd1SmkfhGA7P+k9xKORAfDoD
         KyHlNV98vn529UfkTHkREb883saRQN5mhLwL3SCum52tv3FLS8NMuZMnDjnCnh/IZIN1
         INAMZFsOItb+DPJKcdxFLs8XBEqE1Ifxglk6n3aHia9GJTnxiKxG1s78zrtaQ4FrAcHY
         xJEUxv0XjA71s/9GJOZwDk7U/AeFv7BQM47bU86ru6HZt5INczLDsbyEbDWV6EEZHlIY
         GKyxTHY2HKzbsgn8N2c2T1Anb2J7znJ8+caoU+WhsYCp9yNPNXhUjIEXAXFLCzsPkEEX
         K5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704395627; x=1705000427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHGAPn/+NHpE1B6gjxmM7YpR92I2FPZpzdnyVIrUAnU=;
        b=X4PQzI+itSy7Nm/aehnKfd1Jedsrupljm9GFsdlin/YFy8qHwszXdTGOhtRyUAPmoL
         ktYz8BKbjsXzlOsxonUN/ACNmeu07rXqRnrVMJ5U58ZDQrmI0ybU9oe8ZFMU2c5Tj+yR
         JLfINzybj8P77rBrrpD92fVxIbCW21V6LeU93DBcdtKdk3IrNYCuVDLySx6ef9uQiGPb
         1MAUbFMtoTWedQ8ZQeQKcH4wSTJkSo7iNmHK2IeGv/LLDkvnvtsAa+sKIUkrTz9Gj2uz
         sqpBbNO/X5+QeCk27snK4nCiEnUcTKmVqb9IjZwmNUCiGBMaNOmqaKyuFaQOdp0cl7wk
         TKeA==
X-Gm-Message-State: AOJu0YyoXC25loKAe/Ieio6DD/xcpwEuiCLChEkj1aUyhdHCfrTFW+qQ
	fjQgc8UMFr9zV5mGECkPKomzhTxCyTDdYcexwIzWjuvA2mwq
X-Google-Smtp-Source: AGHT+IEJvAyf6rKOjKP+nzHo94PPzvFw8OxRKSmDIh3P0BnS39O/hRpFW62N7If7eGcp6wkNCaxWmG0wgC9rrlovBCg=
X-Received: by 2002:a05:6e02:1a08:b0:360:2776:e4cc with SMTP id
 s8-20020a056e021a0800b003602776e4ccmr35716ild.2.1704395626984; Thu, 04 Jan
 2024 11:13:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215174343.13872-1-james.morse@arm.com> <20231215174343.13872-9-james.morse@arm.com>
In-Reply-To: <20231215174343.13872-9-james.morse@arm.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 4 Jan 2024 11:13:35 -0800
Message-ID: <CALPaoCi_3aPQ1cebtJLtnNEGjiAX8WjJcHP008wAOh0h+O=trQ@mail.gmail.com>
Subject: Re: [PATCH v8 08/24] x86/resctrl: Track the number of dirty RMID a
 CLOSID has
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com, 
	D Scott Phillips OS <scott@os.amperecomputing.com>, carl@os.amperecomputing.com, 
	lcherian@marvell.com, bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com, 
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>, 
	Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com, amitsinght@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

On Fri, Dec 15, 2023 at 9:44=E2=80=AFAM James Morse <james.morse@arm.com> w=
rote:
>  void free_rmid(u32 closid, u32 rmid)
> @@ -792,13 +813,33 @@ void mbm_setup_overflow_handler(struct rdt_domain *=
dom, unsigned long delay_ms)
>  static int dom_data_init(struct rdt_resource *r)
>  {
>         u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
> +       u32 num_closid =3D resctrl_arch_get_num_closid(r);

Which resource is this again? Surely the one with the smallest number
of CLOSIDs?

It's not much harm if the array is bigger than it needs to be, but
I've become curious about how The Monitoring Resource is used in the
code when there are later changes[1] which would cause this function
to be called on RDT_RESOURCE_L3, RDT_RESOURCE_MBA, or both.

Given that we have hardware with event counters residing at different
levels of the topology and possibly being associated with different
rdt_resources, more attention needs to be paid to how these parameters
are used in code related to monitoring.

-Peter

[1] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/=
drivers/platform/mpam/mpam_resctrl.c?h=3Dmpam/snapshot/v6.7-rc2&id=3Da0ab3a=
6c26002

