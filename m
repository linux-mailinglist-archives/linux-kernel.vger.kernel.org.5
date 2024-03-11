Return-Path: <linux-kernel+bounces-99545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E94F8789CF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DE61F21366
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76AC54FA1;
	Mon, 11 Mar 2024 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X3etMAKk"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91340866
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191166; cv=none; b=ST1gbRVV8CZN3V/7PvNGiaUeE5Kup5OtyTDHVPT+O/4EzLOXhw74Xtodyju0LoeIIypZGhItkO3OQqN4yxEf654EzYdfIDMrOUfix0Leot48E7drDUVp/qQ2Im5XqyEtxf+7ek95dhEak68hga/yz7chqLoVOj7UBDodO6aotKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191166; c=relaxed/simple;
	bh=47V6AQyjZNi9uKbX4SJJcgwnsv+tkmFpXiZ2p+AJWFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjEpqf4C2G4yNBC/kWLStRhcM9nBRP/5jPja58OUsE6DAJU36gPumR0FAnX8mDWPpdp2EwpyQbXCZWcWGgtmi41GqW9gJ1d6D+ShuPOjnGszoPpIbg1FWkznO0PSCNbJ255HLMpHHDKjPkwfP8XPKFqagOXf9YlL4gLF5GS1SrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X3etMAKk; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7db36dbd474so1798706241.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710191164; x=1710795964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyV3mRfciYcH3xjIKTbNJNtUTgmJ0tcs9Hv15kGCtOo=;
        b=X3etMAKkf5UbckK/CWsR9Cw021W6GE/CcZheH6gxZiM9ofZTv1hseXJlm1ODG6R615
         N8tlRJ2bKAUV1FiN2dC/KCCv0gOeaiSDqUFpl30xXcIcUKUcpFfBTLXunq4SYtp6RZKe
         Q4D7mFRak6ifVmWBQ5egH2OwcTHue/m7rsP9603lNwfuZgqC0Wfo8oz27HOFjziE89zO
         aDx/YeE3UISB7QHBvI/+Msu0m7TxN1f9urZKnNYk2ENTrD1PnlUqP2UoKku9QOsbGI+d
         r9oluJGnyJld6p1khiNccbPbDtBeKPbRhnAnZa1d/g4bQpdr3bEEBY3sgCpjcCZlTyYf
         H0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710191164; x=1710795964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyV3mRfciYcH3xjIKTbNJNtUTgmJ0tcs9Hv15kGCtOo=;
        b=dGJ3iS8MuFzajhRuSL3vZ2sLKrzwiFzDWXcGpMAiSJCh5e4IOAtuT58aBkvDZu14XG
         sVHSf3g56SmuTN+W++C1KSGxSH0pdplEDOTZEitukYclliGgPz9Hp6Sv1NK33++wZKP4
         BVeTqljJPbcHckrWmtIld8j+gkweQfDwMt122TyDN2Mggw4ziXnpXcnX+ssCv5US1tWu
         3O+1Kctrug9oMmi7xwtBdL345SLnSWme1zLFCM8s+WZ0Cl7+Bi5ZWjVbXxpmQ0o91w5O
         7YhItP49gvN2SEwhktVCWKFVboFH0kKHVZtxZ+4QYodk76YnlEssegfIsRphA3XQ2rPY
         NL4g==
X-Forwarded-Encrypted: i=1; AJvYcCW+qLCgqhNW//K9i9L14zg8WwB+lTli/gtUB9nxd1pPczzs91HOWUTKYJWcCPk+ZDEJBivqGK0kGlxZOEoBwdnO2lD5leKq4wvRLuIN
X-Gm-Message-State: AOJu0Yz7EUJorfjuCLNYWKrNlejQ189oYf2TTAVt7LlqWdRNr5FqGhWJ
	qqGRajQe0ZSiRdL4uAnTesDqiiOySYbAARcKB8iFSmwOWdqVtVJEjnmECC8YToMYvQ2wM82Qu1h
	rYaO8nZmQWWX7wRG+uItFWPAdrb1ocShgX/nB
X-Google-Smtp-Source: AGHT+IFl0EMeFvw3PwcveMJ4IzlQuup8lihih08RvhhardC5NvO8RVaNKyD/GCeRzjBEdPUPFnyvVX63nuclMMzbNgA=
X-Received: by 2002:a05:6102:2927:b0:473:44aa:d0ed with SMTP id
 cz39-20020a056102292700b0047344aad0edmr2864425vsb.4.1710191163649; Mon, 11
 Mar 2024 14:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
 <20240222202404.36206-1-kevinloughlin@google.com> <4463AFB9-58AC-4E65-BB04-EB2C9F2D9301@broadcom.com>
 <CAGdbjmJ+xiqycaDU9XMUEj2z70Adx-+ZCOiAFGXoNCojt_X=qA@mail.gmail.com>
 <20240308204151.jny3hyo6nyjqk6qt@amd.com> <CAGdbjmK=68Gte2MOvstMa_BoKxX2SEhbXeuRYpO_bdd2FY_xxw@mail.gmail.com>
 <20240308230100.unv2t7r6z6nd4bzl@amd.com>
In-Reply-To: <20240308230100.unv2t7r6z6nd4bzl@amd.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Mon, 11 Mar 2024 14:05:52 -0700
Message-ID: <CAGdbjmJcBn5D=RSvY6PTEFjoSQhfGS7fPQLGPa+4nDjyz=msmw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kernel: skip ROM range scans and validation for
 SEV-SNP guests
To: Michael Roth <michael.roth@amd.com>
Cc: Mike Stunes <mike.stunes@broadcom.com>, acdunlap@google.com, 
	alexander.shishkin@linux.intel.com, andrisaar@google.com, ardb@kernel.org, 
	bhe@redhat.com, Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, 
	dave.hansen@linux.intel.com, Dionna Amalie Glaze <dionnaglaze@google.com>, grobler@google.com, 
	hpa@zytor.com, jacobhxu@google.com, jpoimboe@kernel.org, 
	"Huang, Kai" <kai.huang@intel.com>, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	peterz@infradead.org, Peter Gonda <pgonda@google.com>, ross.lagerwall@citrix.com, 
	sidtelang@google.com, tglx@linutronix.de, 
	Thomas Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, ytcoode@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 3:01=E2=80=AFPM Michael Roth <michael.roth@amd.com> =
wrote:
>
> On Fri, Mar 08, 2024 at 04:30:55PM -0500, Kevin Loughlin wrote:
> > On Fri, Mar 8, 2024 at 3:44=E2=80=AFPM Michael Roth <michael.roth@amd.c=
om> wrote:
> > >
> > > On Fri, Mar 08, 2024 at 11:10:43AM -0500, Kevin Loughlin wrote:
> > > > On Mon, Feb 26, 2024 at 2:16=E2=80=AFPM Mike Stunes <mike.stunes@br=
oadcom.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > > On Feb 22, 2024, at 12:24 PM, Kevin Loughlin <kevinloughlin@goo=
gle.com> wrote:
> > > > > >
> > > > > > SEV-SNP requires encrypted memory to be validated before access=
.
> > > > > > Because the ROM memory range is not part of the e820 table, it =
is not
> > > > > > pre-validated by the BIOS. Therefore, if a SEV-SNP guest kernel=
 wishes
> > > > > > to access this range, the guest must first validate the range.
> > > > > >
> > > > > > The current SEV-SNP code does indeed scan the ROM range during =
early
> > > > > > boot and thus attempts to validate the ROM range in probe_roms(=
).
> > > > > > However, this behavior is neither necessary nor sufficient.
> > > > > >
> > > > > > With regards to sufficiency, if EFI_CONFIG_TABLES are not enabl=
ed and
> > > > > > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel wil=
l
> > > > > > attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (=
which
> > > > > > falls in the ROM range) prior to validation. The specific probl=
ematic
> > > > > > call chain occurs during dmi_setup() -> dmi_scan_machine() and =
results
> > > > > > in a crash during boot if SEV-SNP is enabled under these condit=
ions.
> > > > > >
> > > > > > With regards to necessity, SEV-SNP guests currently read garbag=
e (which
> > > > > > changes across boots) from the ROM range, meaning these scans a=
re
> > > > > > unnecessary. The guest reads garbage because the legacy ROM ran=
ge
> > > > > > is unencrypted data but is accessed via an encrypted PMD during=
 early
> > > > > > boot (where the PMD is marked as encrypted due to potentially m=
apping
> > > > > > actually-encrypted data in other PMD-contained ranges).
> > > > > >
> > > > > > While one solution would be to overhaul the early PMD mapping t=
o treat
> > > > > > the ROM region of the PMD as unencrypted, SEV-SNP guests do not=
 rely on
> > > > > > data from the legacy ROM region during early boot (nor can they
> > > > > > currently, since the data would be garbage that changes across =
boots).
> > > > > > As such, this patch opts for the simpler approach of skipping t=
he ROM
> > > > > > range scans (and the otherwise-necessary range validation) duri=
ng
> > > > > > SEV-SNP guest early boot.
> > > > > >
> > > > > > Ultimatly, the potential SEV-SNP guest crash due to lack of ROM=
 range
> > > > > > validation is avoided by simply not accessing the ROM range.
> > > > > >
> > > > > > Fixes: 9704c07bf9f7 ("x86/kernel: Validate ROM memory before ac=
cessing when SEV-SNP is active")
> > > > > > Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
> > > > > > ---
> > > > > > arch/x86/include/asm/sev.h   |  2 --
> > > > > > arch/x86/kernel/mpparse.c    |  7 +++++++
> > > > > > arch/x86/kernel/probe_roms.c | 11 ++++-------
> > > > > > arch/x86/kernel/sev.c        | 15 ---------------
> > > > > > drivers/firmware/dmi_scan.c  |  7 ++++++-
> > > > > > 5 files changed, 17 insertions(+), 25 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/=
sev.h
> > > > > > index 5b4a1ce3d368..474c24ba0f6f 100644
> > > > > > --- a/arch/x86/include/asm/sev.h
> > > > > > +++ b/arch/x86/include/asm/sev.h
> > > > > > @@ -203,7 +203,6 @@ void __init early_snp_set_memory_private(un=
signed long vaddr, unsigned long padd
> > > > > > unsigned long npages);
> > > > > > void __init early_snp_set_memory_shared(unsigned long vaddr, un=
signed long paddr,
> > > > > > unsigned long npages);
> > > > > > -void __init snp_prep_memory(unsigned long paddr, unsigned int =
sz, enum psc_op op);
> > > > > > void snp_set_memory_shared(unsigned long vaddr, unsigned long n=
pages);
> > > > > > void snp_set_memory_private(unsigned long vaddr, unsigned long =
npages);
> > > > > > void snp_set_wakeup_secondary_cpu(void);
> > > > > > @@ -227,7 +226,6 @@ static inline void __init
> > > > > > early_snp_set_memory_private(unsigned long vaddr, unsigned long=
 paddr, unsigned long npages) { }
> > > > > > static inline void __init
> > > > > > early_snp_set_memory_shared(unsigned long vaddr, unsigned long =
paddr, unsigned long npages) { }
> > > > > > -static inline void __init snp_prep_memory(unsigned long paddr,=
 unsigned int sz, enum psc_op op) { }
> > > > > > static inline void snp_set_memory_shared(unsigned long vaddr, u=
nsigned long npages) { }
> > > > > > static inline void snp_set_memory_private(unsigned long vaddr, =
unsigned long npages) { }
> > > > > > static inline void snp_set_wakeup_secondary_cpu(void) { }
> > > > > > diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mppars=
e.c
> > > > > > index b223922248e9..39ea771e2d4c 100644
> > > > > > --- a/arch/x86/kernel/mpparse.c
> > > > > > +++ b/arch/x86/kernel/mpparse.c
> > > > > > @@ -553,6 +553,13 @@ static int __init smp_scan_config(unsigned=
 long base, unsigned long length)
> > > > > >    base, base + length - 1);
> > > > > > BUILD_BUG_ON(sizeof(*mpf) !=3D 16);
> > > > > >
> > > > > > + /*
> > > > > > + * Skip scan in SEV-SNP guest if it would touch the legacy ROM=
 region,
> > > > > > + * as this memory is not pre-validated and would thus cause a =
crash.
> > > > > > + */
> > > > > > + if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && base < 0x100000=
 && base + length >=3D 0xC0000)
> > > > > > + return 0;
> > > > > > +
> > > > > > while (length > 0) {
> > > > > > bp =3D early_memremap(base, length);
> > > > > > mpf =3D (struct mpf_intel *)bp;
> > > > > > diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/pro=
be_roms.c
> > > > > > index 319fef37d9dc..84ff4b052fc1 100644
> > > > > > --- a/arch/x86/kernel/probe_roms.c
> > > > > > +++ b/arch/x86/kernel/probe_roms.c
> > > > > > @@ -204,14 +204,11 @@ void __init probe_roms(void)
> > > > > > int i;
> > > > > >
> > > > > > /*
> > > > > > - * The ROM memory range is not part of the e820 table and is t=
herefore not
> > > > > > - * pre-validated by BIOS. The kernel page table maps the ROM r=
egion as encrypted
> > > > > > - * memory, and SNP requires encrypted memory to be validated b=
efore access.
> > > > > > - * Do that here.
> > > > > > + * These probes are skipped in SEV-SNP guests because the ROM =
range
> > > > > > + * is not pre-validated, meaning access would cause a crash.
> > > > > > */
> > > > > > - snp_prep_memory(video_rom_resource.start,
> > > > > > - ((system_rom_resource.end + 1) - video_rom_resource.start),
> > > > > > - SNP_PAGE_STATE_PRIVATE);
> > > > > > + if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> > > > > > + return;
> > > > > >
> > > > > > /* video rom */
> > > > > > upper =3D adapter_rom_resources[0].start;
> > > > > > diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> > > > > > index c67285824e82..d2362631da91 100644
> > > > > > --- a/arch/x86/kernel/sev.c
> > > > > > +++ b/arch/x86/kernel/sev.c
> > > > > > @@ -774,21 +774,6 @@ void __init early_snp_set_memory_shared(un=
signed long vaddr, unsigned long paddr
> > > > > > early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHAR=
ED);
> > > > > > }
> > > > > >
> > > > > > -void __init snp_prep_memory(unsigned long paddr, unsigned int =
sz, enum psc_op op)
> > > > > > -{
> > > > > > - unsigned long vaddr, npages;
> > > > > > -
> > > > > > - vaddr =3D (unsigned long)__va(paddr);
> > > > > > - npages =3D PAGE_ALIGN(sz) >> PAGE_SHIFT;
> > > > > > -
> > > > > > - if (op =3D=3D SNP_PAGE_STATE_PRIVATE)
> > > > > > - early_snp_set_memory_private(vaddr, paddr, npages);
> > > > > > - else if (op =3D=3D SNP_PAGE_STATE_SHARED)
> > > > > > - early_snp_set_memory_shared(vaddr, paddr, npages);
> > > > > > - else
> > > > > > - WARN(1, "invalid memory op %d\n", op);
> > > > > > -}
> > > > > > -
> > > > > > static unsigned long __set_pages_state(struct snp_psc_desc *dat=
a, unsigned long vaddr,
> > > > > >       unsigned long vaddr_end, int op)
> > > > > > {
> > > > > > diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi=
_scan.c
> > > > > > index 015c95a825d3..22e27087eb5b 100644
> > > > > > --- a/drivers/firmware/dmi_scan.c
> > > > > > +++ b/drivers/firmware/dmi_scan.c
> > > > > > @@ -703,7 +703,12 @@ static void __init dmi_scan_machine(void)
> > > > > > dmi_available =3D 1;
> > > > > > return;
> > > > > > }
> > > > > > - } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBAC=
K)) {
> > > > > > + } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBAC=
K) &&
> > > > > > + !cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> > > > > > + /*
> > > > > > + * This scan is skipped in SEV-SNP guests because the ROM rang=
e
> > > > > > + * is not pre-validated, meaning access would cause a crash.
> > > > > > + */
> > > > > > p =3D dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10000);
> > > > > > if (p =3D=3D NULL)
> > > > > > goto error;
> > > > > > --
> > > > > > 2.44.0.rc0.258.g7320e95886-goog
> > > > > >
> > > > > >
> > > > >
> > > > > In addition to these changes, I also had to skip pirq_find_routin=
g_table if SEV-SNP is active.
> > > >
> > > > Thanks. I will update this in v3.
> > >
> > > There's also another access a bit later in boot:
> > >
> > >   static __init int eisa_bus_probe(void)
> > >   {
> > >     ...
> > >     ioremap(0x0FFFD9, 4);
> > >   }
> > >
> > > This time it's via ioremap() with the encryption bit *unset*, so it
> > > won't necessarily cause a crash but it's inconsistent with the early
> > > page table having that region set as encrypted.
> > >
> > > We discussed unsetting the encryption bit in early page table with
> > > security folks and the general consensus was that *if* any VMM/firmwa=
re
> > > ever came along that does want to make use of legacy region for any r=
eason
> > > (such as providing DMI/SMBIOS info) it would be safest to require tha=
t they
> > > encrypt the data in the region before handing off to guest kernel, so=
 it
> > > makes sense to patch away unecrypted accesses to the legacy region so=
 the
> > > don't cause problems down the road (like causing implicit page state
> > > change from private->shared and throwing away data in the region late=
r
> > > in boot).
> >
> > Sounds good, thanks. Since this one won't cause crashes, I will place
> > it in a separate patch in the series to separate (current) functional
> > fixes from cleanup, especially since there may be similar legacy
> > probes to cleanup in various types of guests. Please let me know if
> > you feel differently or have additional thoughts.
>
> I think it could still be argued that it's a fix. It's just that the
> main set of fixes avoid reading garbage for VMM/firmwares that *don't*
> encrypt these regions, whereas this additional fix handles the case for
> VMM/firmwares that *do* encrypt these regions. It's possible they exist
> in the case of SEV (though I don't know of any). Might still make sense
> to distinguish the 2 cases since latter is more theoretical, but both
> still address the kernel modifying its behavior based on scanning random
> garbage for strings.

Fair enough. I will include it in the same patch in that case. Thanks.

