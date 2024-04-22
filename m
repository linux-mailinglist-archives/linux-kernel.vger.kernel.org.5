Return-Path: <linux-kernel+bounces-153743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EDF8AD299
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A398F1C209E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3978155386;
	Mon, 22 Apr 2024 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLZm4gLT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7DF153BDF;
	Mon, 22 Apr 2024 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804219; cv=none; b=E8C9QimWiyEdmL8V2qH9l2Er3zAxpnruouI2Jn2TcrF50cCxZekhmT1S+Ua//qMR63oNIe4p7k/IarHN8oCLrWRFKB5x+nP5q2WBnmrCK0zq9GLt3fW9fgYc3xQbn1xotbjKbTghYujQ5RW2hqomuMzokfsMH+DK23uis6Qofp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804219; c=relaxed/simple;
	bh=wHHpm/MlIMnUD56C0I+68LKr2Emf+Rz6l1nA6FA+p4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxLtjsYB0ZqYa5eLPD/sqFJl6BTvwcczZrzu9BBQgVNWMmveHhdTTFvsFjUN2w7zSt2IKO87zGo+VgFz7SfdNcu00eo3z5qBCpWpkuCmuiwMXTNGJiCtcPAdDNhg5kzetdNxRo+fqQuHHyUPGwspCjq2OG0sbyLzU2yAYz8uGJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLZm4gLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A787DC113CC;
	Mon, 22 Apr 2024 16:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713804218;
	bh=wHHpm/MlIMnUD56C0I+68LKr2Emf+Rz6l1nA6FA+p4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kLZm4gLTCzd79EAv67FYtqqitGs1/djNHusslR7yiiTIaKsydTJYA4EWbufUHqa5H
	 UjHTLgDTbBnp0dTouoXG1tylA9PIeeaiITC8suHtBSQw29/ssD9MNGpaGWNc3Yhujj
	 VsRs57ehcqWBtEajQ9GU88WaNLHV6uN+u/uV3srlUr/gBthuCfV1iU7+4kHDiLAsba
	 /U9AMu8IEd5Yzzs2twbO5+DtdhaUCVnIaI9AEHj7Kv1B23dfAo1sg3lxtEu4M21o9a
	 EYOx5F8k213BirWvLt+T//gk8zuHblnRunMVnTLyjyNfSCXLMM5sNNqT5TIzaN+MdR
	 jy8TvbugD6llQ==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ea0a6856d7so844365a34.1;
        Mon, 22 Apr 2024 09:43:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0SoMdZYciZ1ZMujRNt2+uM8hRTau1bxIt9bfkjD6lKTGdnh8b5nbgmaeLCIOiFWCqO63ydZ1zbSzh4qFz1qYdBQ315XIzOWC95kXOyLYnie5iwb0VYlOnsxhrgPJAjNKAjrgnUDXKJ+fxx6ntpCYcOgGJcxXowUTTwMU4jInaqQ==
X-Gm-Message-State: AOJu0YzvlETSlQe3B9Vx65F2m5ZNU+B5bqadKcRX9otOzJuZcnOOVHil
	k7GmbMsXJhIjvJchF1/THiMaCjdGzL8oMQlnar6ch0U8SzmJaFR1dilYNllRvRMS98I7KMh/cXA
	45UGq3p8X53DWizfczLM1eOhMuAM=
X-Google-Smtp-Source: AGHT+IFxhkTiGWpLI37qbMnnvDoa9HCZq+l7GBMHsvYcSFiRCIGp8GKu5oJltXjmDUMrx1tmpugYn8g6AT+C8moo+Ig=
X-Received: by 2002:a05:6820:e07:b0:5aa:14ff:4128 with SMTP id
 el7-20020a0568200e0700b005aa14ff4128mr10710388oob.1.1713804217994; Mon, 22
 Apr 2024 09:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409052310.3162495-1-jarredwhite@linux.microsoft.com> <soawdod6cpcc73wrc35bvnah5toubf2cv4x7c3e6p53xtvllrs@6dtpn2v5t3di>
In-Reply-To: <soawdod6cpcc73wrc35bvnah5toubf2cv4x7c3e6p53xtvllrs@6dtpn2v5t3di>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 18:43:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0imiRbheOJgEf=Ua-JRhDTh1+SJ-=CjUC7vOQYffV50FA@mail.gmail.com>
Message-ID: <CAJZ5v0imiRbheOJgEf=Ua-JRhDTh1+SJ-=CjUC7vOQYffV50FA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Fix bit_offset shift in MASK_VAL macro
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>, 
	Jarred White <jarredwhite@linux.microsoft.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Easwar Hariharan <eahariha@linux.microsoft.com>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 7:37=E2=80=AFPM Vanshidhar Konda
<vanshikonda@os.amperecomputing.com> wrote:
>
> Looks good to me.
>
> Reviewed-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>
> On Mon, Apr 08, 2024 at 10:23:09PM -0700, Jarred White wrote:
> >Commit 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for
> >system memory accesses") neglected to properly wrap the bit_offset shift
> >when it comes to applying the mask. This may cause incorrect values to b=
e
> >read and may cause the cpufreq module not be loaded.
> >
> >[   11.059751] cpu_capacity: CPU0 missing/invalid highest performance.
> >[   11.066005] cpu_capacity: partial information: fallback to 1024 for a=
ll CPUs
> >
> >Also, corrected the bitmask generation in GENMASK (extra bit being added=
).
> >
> >Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for sy=
stem memory accesses")
> >Signed-off-by: Jarred White <jarredwhite@linux.microsoft.com>
> >CC: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> >CC: stable@vger.kernel.org #5.15+
> >---
> > drivers/acpi/cppc_acpi.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> >index 4bfbe55553f4..00a30ca35e78 100644
> >--- a/drivers/acpi/cppc_acpi.c
> >+++ b/drivers/acpi/cppc_acpi.c
> >@@ -170,8 +170,8 @@ show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs=
, wraparound_time);
> > #define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_=
width - 1)) : (reg)->bit_width)
> >
> > /* Shift and apply the mask for CPC reads/writes */
> >-#define MASK_VAL(reg, val) ((val) >> ((reg)->bit_offset &              =
       \
> >-                                      GENMASK(((reg)->bit_width), 0)))
> >+#define MASK_VAL(reg, val) (((val) >> (reg)->bit_offset) &             =
       \
> >+                                      GENMASK(((reg)->bit_width) - 1, 0=
))
> >
> > static ssize_t show_feedback_ctrs(struct kobject *kobj,
> >               struct kobj_attribute *attr, char *buf)
> >--

Applied as 6.9-rc material, thanks!

