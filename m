Return-Path: <linux-kernel+bounces-147841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AE48A7A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFE61C21081
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52624C99;
	Wed, 17 Apr 2024 02:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3ToLxNv"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359B833EA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320232; cv=none; b=d9P6YCcQfn4RltxEd0DaJ1K1ym8VWAMTH8wcTSOhj3XeANyYSjvfbcdBQ/au7O30y9wQMRR3J8b5bsFkt7wQNxLOwcPqqMdEyC0gKbCovgMmff1aTpae5QKpFBanoYGMu03wZyhboVX1JaIZh0OoQxMdv3onQoza21FzCxIL22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320232; c=relaxed/simple;
	bh=E+ZB8bofNoZPZyCAfZcTdiMqmlACTZ42W8BUIly+h7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xo36e844qaAqGJ7O3z1eiL0EiP6D8hDZP6Nl5dlFkPD8qmZsg/e+/W1FuM4BCBJehtlljIOyRnUVVfuP+61/RuT4AKFMzh3DkSuy797nBLMmP0uK5ADOyltLisxvz1bESrdQwAC66UGzDogSCilwFMNrnXlCWt7qvdr4sImxNq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3ToLxNv; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7e8a4947785so143106241.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 19:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713320227; x=1713925027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S4UHNYdO9I4Z/dBBxHnLwHf3dXwGgMzjlCTfxjM95CI=;
        b=g3ToLxNvhoqpql7uo4GO4J6rtOFLSnIpHrUbOVX0hk+XuulPdwcs+asis5FXRjg8f6
         HGwjhak3yJsxBR7TYO7GbHs68TdE5+oFhp7xCAiMPUvJTqnGbI9COnhXfZSK44NrJmMn
         3gRHGURSinPKM6poIJmOz1bcCBESwKTqsskjNLRYF1ZZgxRowhRi/NHvumXcfFCYiUEK
         ckbcVsf7E/vkWK9oeXI9R68N8kPPQ+YiXaB8pGMbEj0DzY59uh08YIHjbk0Z83m7BcTd
         7oyunTv5iNlJDWtnBm5fZz+2Np3AX2k0M0OYaZRtGrhzO4X67k5/99y9wJGkG4tlNqwa
         LyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713320227; x=1713925027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4UHNYdO9I4Z/dBBxHnLwHf3dXwGgMzjlCTfxjM95CI=;
        b=HRmM4MCpqDb1oYeXcaGtGNVWJv/UTxGKgRMK13M2gt3LfZ0ylbSa2HjVP/0c+iDzYs
         u4OQHdzwRKvRC0F9ttkzNl3FK80qF9CmV/iCPYfmf7Oy1H8y0vPeuJkKhzC+x031+ttK
         CFbqCLkNJX1jjtOXPE3pVnchicLKr8cPEBrHC33OP1hY8xrm5EZNJL54HqsPqe+rB8xe
         EUf+IFUndgFBqw3/wjv2F8BoqFj2/OFBGEui4biH/OHRLRtL09OUW/BHKNxIFL42d517
         yKwgvIU09wiAm8ry5F6RQlV61LTdg2G78BsoWe5y3D0tg9P+dU2fIn1uKAjdCb0Fj3ZV
         u1NA==
X-Forwarded-Encrypted: i=1; AJvYcCW22PJ5Ip4x9YiwOLcomV7xlXVQ0H5452kKbQCwK8Jux9aL4Pw55WBusdmhQgQC6MTPajV7RNl26ZTmPhuhsl3V1NpIygcjszPbG9pB
X-Gm-Message-State: AOJu0YwbHx8zvhQNPmCg7dPTezE/MryOtT1Gp8qIZk4K4SddWYzzUOH9
	uaW54thiJGmLZrHIZ6k6hTCn4lZ5Fp71ZgWPm3C19Ib/tzqvqWlraznzrwJwxNjkYa6+ujs3ZWR
	p4j5Kvy11NweI/rwBFSoPt42LDLw=
X-Google-Smtp-Source: AGHT+IE0h+BSHqaDqtbv4yjyFpQ49G3kIa/V9ULLnmrQpO8ViOip3HF/wBjoXpZZ6q0VfCKC1g9HNgM3l8mTq1OPsO4=
X-Received: by 2002:a05:6122:17a8:b0:4da:b132:6dc1 with SMTP id
 o40-20020a05612217a800b004dab1326dc1mr4642068vkf.1.1713320226979; Tue, 16 Apr
 2024 19:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
 <20240415163056.GP223006@ziepe.ca> <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
 <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com> <20240416003903.GR223006@ziepe.ca>
 <CAHudX3x-ofB=-K6UwWpf4r7Ge9AQbvLQ2qq2C7N-R5LG2qMz7Q@mail.gmail.com> <a80df9b9-92a5-4430-8802-1f8d159d6162@amd.com>
In-Reply-To: <a80df9b9-92a5-4430-8802-1f8d159d6162@amd.com>
From: Eric Wagner <ewagner12@gmail.com>
Date: Tue, 16 Apr 2024 22:16:55 -0400
Message-ID: <CAHudX3w63VPCjP5mxOePPosa+KkUw7eMRcJF=MJ-ktNO7CwXdg@mail.gmail.com>
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
To: Vasant Hegde <vashegde@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000841d60061641739a"

--000000000000841d60061641739a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 6:53=E2=80=AFAM Vasant Hegde <vashegde@amd.com> wro=
te:
>
> Hi Eric,
>
>
> On 4/16/2024 7:42 AM, Eric Wagner wrote:
> > On Mon, Apr 15, 2024 at 5:44=E2=80=AFPM Robin Murphy <robin.murphy@arm.=
com
> > <mailto:robin.murphy@arm.com>> wrote:
> >
> >     As a first step I'd test the quick hack below, but be prepared for =
things
> >     to still break slightly differently.
> >
> >     Cheers,
> >     Robin.
> >
> >     ----->8-----
> >     diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >     index 996e79dc582d..063e1eb32fbd 100644
> >     --- a/drivers/iommu/iommu.c
> >     +++ b/drivers/iommu/iommu.c
> >     @@ -1774,7 +1774,7 @@ static int iommu_get_default_domain_type(stru=
ct
> >     iommu_group *group,
> >                                      untrusted,
> >                                      "Device is not trusted, but driver=
 is
> >     overriding group %u to %s,
> >     refusing to probe.\n",
> >                                      group->id, iommu_domain_type_str(d=
river_type));
> >     -                       return -1;
> >     +                       //return -1;
> >                      }
> >                      driver_type =3D IOMMU_DOMAIN_DMA;
> >              }
> >
> > This worked and got the system booting for me.
>
> Thanks for testing.
>
> IIUC eGPU is behind Thunderbolt  and hence IOMMU treated it as 'untrusted=
 device'.
>
> AMD driver tries to allocate "IDENTITY" domain for GPU devices.
> iommu_get_default_domain_type() return -1 as it expects IOMMU_DOMAIN_DMA =
for
> untrusted device.
>
> Can you please attach lspci -vvv output? Also /proc/cmdline output.
>
>
> >
> > On Mon, Apr 15, 2024 at 8:39=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca
> > <mailto:jgg@ziepe.ca>> wrote:
> >
> >     On Mon, Apr 15, 2024 at 10:44:34PM +0100, Robin Murphy wrote:
> >      > On 2024-04-15 7:57 pm, Eric Wagner wrote:
> >      > > Apologies if I made a mistake in the first bisect, I'm new to =
kernel
> >      > > debugging.
> >      > >
> >      > > I tested cedc811c76778bdef91d405717acee0de54d8db5 (x86/amd) an=
d
> >      > > 3613047280ec42a4e1350fdc1a6dd161ff4008cc (core) directly and b=
oth were
> >     good.
> >      > > Then I ran git bisect again with e8cca466a84a75f8ff2a7a31173c9=
9ee6d1c59d2
> >      > > as the bad and 6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3 as the=
 good and the
> >      > > bisect log is attached. It ended up at the same commit as befo=
re.
> >      > >
> >      > > I've also attached a picture of the boot screen that occurs wh=
en it hangs.
> >      > > 0000:05:00.0 is the PCIe bus address of the RX 580 eGPU that's=
 causing the
> >      > > problem.
> >      >
> >      > Looks like 59ddce4418da483 probably broke things most - prior to=
 that, the
> >      > fact that it's behind a Thunderbolt port would have always taken=
 precedence
> >      > and forced IOMMU_DOMAIN_DMA regardless of what the driver may ha=
ve wanted to
> >      > saywhereas now we ask the driver first, then complain that it co=
nflicts
> >      > with the untrusted status and ultimately don't configure the IOM=
MU
> >      > at all.
> >
> >     Yes, if the driver wants to force a domain type it should be
> >     forced. Driver knows best. Eg AMD forces IDENTITY when the HW/drive=
r
> >     is incapable of supporting otherwise.
>
>
> @Jason,
>
> Looks like before commit 59ddce4418da483, core IOMMU layer was enforcing
> 'IOMMU_DOMAIN_DMA' for untrusted device. If its trusted device then it wa=
s
> letting HW IOMMU driver to pick best domain type.
>
> Did we change that flow? Are we expecting HW IOMMU driver to handler untr=
usted
> devices as well?
>
> >
> >      > Meanwhile the GPU driver presumably goes on to believe it's usin=
g dma-direct
> >      > with no IOMMU present, resulting in fireworks when its traffic r=
eaches the
> >      > IOMMU. Great :(
> >
> >     I wonder where is the missing error handling.. iommu probe failure
> >     should not go on to allow driver attach, there is no guarentee any =
DMA
> >     works now that many iommus are booting up in BLOCKED.
>
>
> Looking into code path, in failure path we cleanup device, not group. May=
 be
> that's causing issue? Not sure where it failed. If I manage to find some =
system
> I will try to debug further.
>
>
>
> >
> >      > However the other notable thing that also happened between 6.6 a=
nd 6.7 was
> >      > the removal of the AMD iommu_v2 code, so there's some possibilit=
y that the
> >      > GPU driver still may have only been working before due to that a=
lso
> >
> >     Most likely it is the above change interacting with this patch when
> >     they are both combined in the merge:
> >
> >     commit 92e2bd56a5f9fc44313fda802a43a63cc2a9c8f6
> >     Author: Vasant Hegde <vasant.hegde@amd.com <mailto:vasant.hegde@amd=
com>>
> >     Date:   Thu Sep 21 09:21:45 2023 +0000
> >
> >          iommu/amd: Introduce iommu_dev_data.flags to track device capa=
bilities
> >
> >     @@ -2471,7 +2481,7 @@ static int amd_iommu_def_domain_type(struct d=
evice *dev)
> >               *    and require remapping.
> >               *  - SNP is enabled, because it prohibits DTE[Mode]=3D0.
> >               */
> >     -       if (dev_data->iommu_v2 &&
> >     +       if (pdev_pasid_supported(dev_data) &&
> >                  !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
> >                  !amd_iommu_snp_en) {
> >                      return IOMMU_DOMAIN_IDENTITY;
> >
> >     Which, IIRC, was intended to be temporary to work around limitation=
s
> >     in the DTE programming logic within the driver. Previously iommu_v2=
 as
> >     a module option that Eric probably doesn't set, I guess.
> >
> >     The below will probably make it boot, but Vasant should check what
> >     happens if PASID is eventually attached too.
> >
> >     diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> >     index d35c1b8c8e65ce..f3da6a5b6cb1cb 100644
> >     --- a/drivers/iommu/amd/iommu.c
> >     +++ b/drivers/iommu/amd/iommu.c
> >     @@ -2758,11 +2758,16 @@ static int amd_iommu_def_domain_type(struct=
 device *dev)
> >               *    and require remapping.
> >               *  - SNP is enabled, because it prohibits DTE[Mode]=3D0.
> >               */
> >     -       if (pdev_pasid_supported(dev_data) &&
> >     -           !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
> >     -           !amd_iommu_snp_en) {
> >     +       if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT) && !amd_iommu_snp=
_en)
> >     +               return IOMMU_DOMAIN_IDENTITY;
> >     +
> >     +       /*
> >     +        * For now driver limitations prevent enabling PASID as a p=
aging domain
> >     +        * on the RID together.
> >     +        */
> >     +       if (dev_is_pci(dev) && !to_pci_dev(dev)->untrusted &&
> >     +           pdev_pasid_supported(dev_data))
> >                      return IOMMU_DOMAIN_IDENTITY;
> >     -       }
> >
> >              return 0;
> >       }
> >
> >     Jason
> >
> >
> > As it booted ok with Robin's patch above, these changes to
> > drivers/iommu/amd/iommu.c didn't seem to make a difference for me. I wa=
s testing
> > with amd iommu v2 off in the kernel config and I also have TSME enabled=
 in the
> > BIOS if that matters.
>
> TMSE is transparent to OS. So its fine.
>
> -Vasant
>
Output of lspci -vvv and /proc/cmdline attached.

-Eric

--000000000000841d60061641739a
Content-Type: text/x-log; charset="US-ASCII"; name="cmdline.log"
Content-Disposition: attachment; filename="cmdline.log"
Content-Transfer-Encoding: base64
Content-ID: <f_lv36ldsz0>
X-Attachment-Id: f_lv36ldsz0

Qk9PVF9JTUFHRT0vdm1saW51eiByb290PVVVSUQ9ZjY2MGYxYTMtMTAzNC00YTk1LWEzMTAtM2Q3
MTk5ZWE1OGE1IHJvIHF1aWV0IHNwbGFzaAo=
--000000000000841d60061641739a
Content-Type: text/x-log; charset="US-ASCII"; name="lspci.log"
Content-Disposition: attachment; filename="lspci.log"
Content-Transfer-Encoding: base64
Content-ID: <f_lv36ldtr1>
X-Attachment-Id: f_lv36ldtr1

MDA6MDAuMCBIb3N0IGJyaWRnZTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBE
ZXZpY2UgMTRiNSAocmV2IDAxKQoJU3Vic3lzdGVtOiBMZW5vdm8gRGV2aWNlIDUwYjQKCUNvbnRy
b2w6IEkvTy0gTWVtLSBCdXNNYXN0ZXItIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBh
ckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtCglTdGF0dXM6IENhcC0gNjZN
SHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8
TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCgowMDowMC4yIElPTU1VOiBBZHZhbmNlZCBNaWNy
byBEZXZpY2VzLCBJbmMuIFtBTURdIERldmljZSAxNGI2CglTdWJzeXN0ZW06IExlbm92byBEZXZp
Y2UgNTBiNAoJQ29udHJvbDogSS9PLSBNZW0tIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5W
LSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0
YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJv
cnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCUlu
dGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAyNQoJQ2FwYWJpbGl0aWVzOiBbNDBdIFNlY3Vy
ZSBkZXZpY2UgPD8+CglDYXBhYmlsaXRpZXM6IFs2NF0gTVNJOiBFbmFibGUrIENvdW50PTEvNCBN
YXNrYWJsZS0gNjRiaXQrCgkJQWRkcmVzczogMDAwMDAwMDBmZWUwNTAwMCAgRGF0YTogMDAyMAoJ
Q2FwYWJpbGl0aWVzOiBbNzRdIEh5cGVyVHJhbnNwb3J0OiBNU0kgTWFwcGluZyBFbmFibGUrIEZp
eGVkKwoKMDA6MDEuMCBIb3N0IGJyaWRnZTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBb
QU1EXSBEZXZpY2UgMTRiNyAocmV2IDAxKQoJQ29udHJvbDogSS9PLSBNZW0tIEJ1c01hc3Rlci0g
U3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFz
dEIyQi0gRGlzSU5UeC0KCVN0YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnIt
IERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5U
eC0KCUlPTU1VIGdyb3VwOiAwCgowMDowMi4wIEhvc3QgYnJpZGdlOiBBZHZhbmNlZCBNaWNybyBE
ZXZpY2VzLCBJbmMuIFtBTURdIERldmljZSAxNGI3IChyZXYgMDEpCglDb250cm9sOiBJL08tIE1l
bS0gQnVzTWFzdGVyLSBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBw
aW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXAtIDY2TUh6LSBVREYtIEZh
c3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNF
UlItIDxQRVJSLSBJTlR4LQoJSU9NTVUgZ3JvdXA6IDEKCjAwOjAyLjIgUENJIGJyaWRnZTogQWR2
YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBEZXZpY2UgMTRiYSAocHJvZy1pZiAwMCBb
Tm9ybWFsIGRlY29kZV0pCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUt
IE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJ
TlR4KwoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZh
c3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5j
eTogMCwgQ2FjaGUgTGluZSBTaXplOiAzMiBieXRlcwoJSW50ZXJydXB0OiBwaW4gPyByb3V0ZWQg
dG8gSVJRIDM1CglJT01NVSBncm91cDogMgoJQnVzOiBwcmltYXJ5PTAwLCBzZWNvbmRhcnk9MDEs
IHN1Ym9yZGluYXRlPTAxLCBzZWMtbGF0ZW5jeT0wCglJL08gYmVoaW5kIGJyaWRnZTogMDAwMGYw
MDAtMDAwMDBmZmYgW2Rpc2FibGVkXQoJTWVtb3J5IGJlaGluZCBicmlkZ2U6IDk4MDAwMDAwLTk4
MWZmZmZmIFtzaXplPTJNXQoJUHJlZmV0Y2hhYmxlIG1lbW9yeSBiZWhpbmQgYnJpZGdlOiAwMDAw
MDAwMGZmZjAwMDAwLTAwMDAwMDAwMDAwZmZmZmYgW2Rpc2FibGVkXQoJU2Vjb25kYXJ5IHN0YXR1
czogNjZNSHotIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0g
PE1BYm9ydCsgPFNFUlItIDxQRVJSLQoJQnJpZGdlQ3RsOiBQYXJpdHktIFNFUlIrIE5vSVNBLSBW
R0EtIFZHQTE2LSBNQWJvcnQtID5SZXNldC0gRmFzdEIyQi0KCQlQcmlEaXNjVG1yLSBTZWNEaXNj
VG1yLSBEaXNjVG1yU3RhdC0gRGlzY1RtclNFUlJFbi0KCUNhcGFiaWxpdGllczogWzUwXSBQb3dl
ciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhD
dXJyZW50PTBtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBEMCBO
b1NvZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRpZXM6
IFs1OF0gRXhwcmVzcyAodjIpIFJvb3QgUG9ydCAoU2xvdCspLCBNU0kgMDAKCQlEZXZDYXA6CU1h
eFBheWxvYWQgMjU2IGJ5dGVzLCBQaGFudEZ1bmMgMAoJCQlFeHRUYWcrIFJCRSsKCQlEZXZDdGw6
CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXEtCgkJCVJseGRPcmQrIEV4
dFRhZysgUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25vb3ArCgkJCU1heFBheWxvYWQgMTI4IGJ5dGVz
LCBNYXhSZWFkUmVxIDUxMiBieXRlcwoJCURldlN0YToJQ29yckVyci0gTm9uRmF0YWxFcnItIEZh
dGFsRXJyLSBVbnN1cFJlcS0gQXV4UHdyLSBUcmFuc1BlbmQtCgkJTG5rQ2FwOglQb3J0ICM0LCBT
cGVlZCAxNkdUL3MsIFdpZHRoIHgxLCBBU1BNIEwxLCBFeGl0IExhdGVuY3kgTDEgPDY0dXMKCQkJ
Q2xvY2tQTS0gU3VycHJpc2UtIExMQWN0UmVwKyBCd05vdCsgQVNQTU9wdENvbXArCgkJTG5rQ3Rs
OglBU1BNIEwxIEVuYWJsZWQ7IFJDQiA2NCBieXRlcywgRGlzYWJsZWQtIENvbW1DbGsrCgkJCUV4
dFN5bmNoLSBDbG9ja1BNLSBBdXRXaWREaXMtIEJXSW50LSBBdXRCV0ludC0KCQlMbmtTdGE6CVNw
ZWVkIDVHVC9zIChkb3duZ3JhZGVkKSwgV2lkdGggeDEgKG9rKQoJCQlUckVyci0gVHJhaW4tIFNs
b3RDbGsrIERMQWN0aXZlKyBCV01nbXQrIEFCV01nbXQtCgkJU2x0Q2FwOglBdHRuQnRuLSBQd3JD
dHJsLSBNUkwtIEF0dG5JbmQtIFB3ckluZC0gSG90UGx1Zy0gU3VycHJpc2UtCgkJCVNsb3QgIzAs
IFBvd2VyTGltaXQgNzUuMDAwVzsgSW50ZXJsb2NrLSBOb0NvbXBsKwoJCVNsdEN0bDoJRW5hYmxl
OiBBdHRuQnRuLSBQd3JGbHQtIE1STC0gUHJlc0RldC0gQ21kQ3BsdC0gSFBJcnEtIExpbmtDaGct
CgkJCUNvbnRyb2w6IEF0dG5JbmQgVW5rbm93biwgUHdySW5kIFVua25vd24sIFBvd2VyLSBJbnRl
cmxvY2stCgkJU2x0U3RhOglTdGF0dXM6IEF0dG5CdG4tIFBvd2VyRmx0LSBNUkwtIENtZENwbHQt
IFByZXNEZXQrIEludGVybG9jay0KCQkJQ2hhbmdlZDogTVJMLSBQcmVzRGV0LSBMaW5rU3RhdGUr
CgkJUm9vdENhcDogQ1JTVmlzaWJsZSsKCQlSb290Q3RsOiBFcnJDb3JyZWN0YWJsZS0gRXJyTm9u
LUZhdGFsLSBFcnJGYXRhbC0gUE1FSW50RW5hKyBDUlNWaXNpYmxlKwoJCVJvb3RTdGE6IFBNRSBS
ZXFJRCAwMDAwLCBQTUVTdGF0dXMtIFBNRVBlbmRpbmctCgkJRGV2Q2FwMjogQ29tcGxldGlvbiBU
aW1lb3V0OiBSYW5nZSBBQkNELCBUaW1lb3V0RGlzKyBOUk9QclByUC0gTFRSKwoJCQkgMTBCaXRU
YWdDb21wKyAxMEJpdFRhZ1JlcSsgT0JGRiBOb3QgU3VwcG9ydGVkLCBFeHRGbXQrIEVFVExQUHJl
Zml4KywgTWF4RUVUTFBQcmVmaXhlcyAxCgkJCSBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvbiBOb3Qg
U3VwcG9ydGVkLCBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvbkluaXQtCgkJCSBGUlMtIExOIFN5c3Rl
bSBDTFMgTm90IFN1cHBvcnRlZCwgVFBIQ29tcCsgRXh0VFBIQ29tcC0gQVJJRndkKwoJCQkgQXRv
bWljT3BzQ2FwOiBSb3V0aW5nKyAzMmJpdCsgNjRiaXQrIDEyOGJpdENBUy0KCQlEZXZDdGwyOiBD
b21wbGV0aW9uIFRpbWVvdXQ6IDY1bXMgdG8gMjEwbXMsIFRpbWVvdXREaXMtIExUUisgT0JGRiBE
aXNhYmxlZCwgQVJJRndkLQoJCQkgQXRvbWljT3BzQ3RsOiBSZXFFbi0gRWdyZXNzQmxjay0KCQlM
bmtDYXAyOiBTdXBwb3J0ZWQgTGluayBTcGVlZHM6IDIuNS0xNkdUL3MsIENyb3NzbGluay0gUmV0
aW1lcisgMlJldGltZXJzKyBEUlMtCgkJTG5rQ3RsMjogVGFyZ2V0IExpbmsgU3BlZWQ6IDVHVC9z
LCBFbnRlckNvbXBsaWFuY2UtIFNwZWVkRGlzLQoJCQkgVHJhbnNtaXQgTWFyZ2luOiBOb3JtYWwg
T3BlcmF0aW5nIFJhbmdlLCBFbnRlck1vZGlmaWVkQ29tcGxpYW5jZS0gQ29tcGxpYW5jZVNPUy0K
CQkJIENvbXBsaWFuY2UgRGUtZW1waGFzaXM6IC02ZEIKCQlMbmtTdGEyOiBDdXJyZW50IERlLWVt
cGhhc2lzIExldmVsOiAtMy41ZEIsIEVxdWFsaXphdGlvbkNvbXBsZXRlLSBFcXVhbGl6YXRpb25Q
aGFzZTEtCgkJCSBFcXVhbGl6YXRpb25QaGFzZTItIEVxdWFsaXphdGlvblBoYXNlMy0gTGlua0Vx
dWFsaXphdGlvblJlcXVlc3QtCgkJCSBSZXRpbWVyLSAyUmV0aW1lcnMtIENyb3NzbGlua1Jlczog
dW5zdXBwb3J0ZWQKCUNhcGFiaWxpdGllczogW2EwXSBNU0k6IEVuYWJsZSsgQ291bnQ9MS8xIE1h
c2thYmxlLSA2NGJpdCsKCQlBZGRyZXNzOiAwMDAwMDAwMGZlZTAwMDAwICBEYXRhOiAwMDAwCglD
YXBhYmlsaXRpZXM6IFtjMF0gU3Vic3lzdGVtOiBMZW5vdm8gRGV2aWNlIDUwYjQKCUNhcGFiaWxp
dGllczogW2M4XSBIeXBlclRyYW5zcG9ydDogTVNJIE1hcHBpbmcgRW5hYmxlKyBGaXhlZCsKCUNh
cGFiaWxpdGllczogWzEwMCB2MV0gVmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBJRD0wMDAx
IFJldj0xIExlbj0wMTAgPD8+CglDYXBhYmlsaXRpZXM6IFsxNTAgdjJdIEFkdmFuY2VkIEVycm9y
IFJlcG9ydGluZwoJCVVFU3RhOglETFAtIFNERVMtIFRMUC0gRkNQLSBDbXBsdFRPLSBDbXBsdEFi
cnQtIFVueENtcGx0LSBSeE9GLSBNYWxmVExQLSBFQ1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0KCQlV
RU1zazoJRExQLSBTREVTLSBUTFAtIEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0g
UnhPRi0gTWFsZlRMUC0gRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wtCgkJVUVTdnJ0OglETFAtIFNE
RVMrIFRMUC0gRkNQKyBDbXBsdFRPLSBDbXBsdEFicnQtIFVueENtcGx0LSBSeE9GKyBNYWxmVExQ
LSBFQ1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0KCQlDRVN0YToJUnhFcnItIEJhZFRMUC0gQmFkRExM
UC0gUm9sbG92ZXItIFRpbWVvdXQtIEFkdk5vbkZhdGFsRXJyLQoJCUNFTXNrOglSeEVyci0gQmFk
VExQLSBCYWRETExQLSBSb2xsb3Zlci0gVGltZW91dC0gQWR2Tm9uRmF0YWxFcnIrCgkJQUVSQ2Fw
OglGaXJzdCBFcnJvciBQb2ludGVyOiAwMCwgRUNSQ0dlbkNhcCsgRUNSQ0dlbkVuLSBFQ1JDQ2hr
Q2FwKyBFQ1JDQ2hrRW4tCgkJCU11bHRIZHJSZWNDYXAtIE11bHRIZHJSZWNFbi0gVExQUGZ4UHJl
cy0gSGRyTG9nQ2FwLQoJCUhlYWRlckxvZzogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAw
MDAwMDAKCQlSb290Q21kOiBDRVJwdEVuLSBORkVScHRFbi0gRkVScHRFbi0KCQlSb290U3RhOiBD
RVJjdmQtIE11bHRDRVJjdmQtIFVFUmN2ZC0gTXVsdFVFUmN2ZC0KCQkJIEZpcnN0RmF0YWwtIE5v
bkZhdGFsTXNnLSBGYXRhbE1zZy0gSW50TXNnIDAKCQlFcnJvclNyYzogRVJSX0NPUjogMDAwMCBF
UlJfRkFUQUwvTk9ORkFUQUw6IDAwMDAKCUNhcGFiaWxpdGllczogWzI3MCB2MV0gU2Vjb25kYXJ5
IFBDSSBFeHByZXNzCgkJTG5rQ3RsMzogTG5rRXF1SW50cnJ1cHRFbi0gUGVyZm9ybUVxdS0KCQlM
YW5lRXJyU3RhdDogMAoJQ2FwYWJpbGl0aWVzOiBbMmEwIHYxXSBBY2Nlc3MgQ29udHJvbCBTZXJ2
aWNlcwoJCUFDU0NhcDoJU3JjVmFsaWQrIFRyYW5zQmxrKyBSZXFSZWRpcisgQ21wbHRSZWRpcisg
VXBzdHJlYW1Gd2QrIEVncmVzc0N0cmwtIERpcmVjdFRyYW5zKwoJCUFDU0N0bDoJU3JjVmFsaWQr
IFRyYW5zQmxrLSBSZXFSZWRpcisgQ21wbHRSZWRpcisgVXBzdHJlYW1Gd2QrIEVncmVzc0N0cmwt
IERpcmVjdFRyYW5zLQoJQ2FwYWJpbGl0aWVzOiBbMzcwIHYxXSBMMSBQTSBTdWJzdGF0ZXMKCQlM
MVN1YkNhcDogUENJLVBNX0wxLjIrIFBDSS1QTV9MMS4xKyBBU1BNX0wxLjIrIEFTUE1fTDEuMSsg
TDFfUE1fU3Vic3RhdGVzKwoJCQkgIFBvcnRDb21tb25Nb2RlUmVzdG9yZVRpbWU9NzB1cyBQb3J0
VFBvd2VyT25UaW1lPTE1MHVzCgkJTDFTdWJDdGwxOiBQQ0ktUE1fTDEuMisgUENJLVBNX0wxLjEr
IEFTUE1fTDEuMisgQVNQTV9MMS4xKwoJCQkgICBUX0NvbW1vbk1vZGU9NzB1cyBMVFIxLjJfVGhy
ZXNob2xkPTIyNjMwNG5zCgkJTDFTdWJDdGwyOiBUX1B3ck9uPTE1MHVzCglDYXBhYmlsaXRpZXM6
IFs0MDAgdjFdIERhdGEgTGluayBGZWF0dXJlIDw/PgoJQ2FwYWJpbGl0aWVzOiBbNDEwIHYxXSBQ
aHlzaWNhbCBMYXllciAxNi4wIEdUL3MgPD8+CglDYXBhYmlsaXRpZXM6IFs0NDAgdjFdIExhbmUg
TWFyZ2luaW5nIGF0IHRoZSBSZWNlaXZlciA8Pz4KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBwY2ll
cG9ydAoKMDA6MDIuNCBQQ0kgYnJpZGdlOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtB
TURdIERldmljZSAxNGJhIChwcm9nLWlmIDAwIFtOb3JtYWwgZGVjb2RlXSkKCUNvbnRyb2w6IEkv
TysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0g
U3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgrCglTdGF0dXM6IENhcCsgNjZNSHotIFVE
Ri0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0
LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwLCBDYWNoZSBMaW5lIFNpemU6IDMyIGJ5
dGVzCglJbnRlcnJ1cHQ6IHBpbiA/IHJvdXRlZCB0byBJUlEgMzYKCUlPTU1VIGdyb3VwOiAzCglC
dXM6IHByaW1hcnk9MDAsIHNlY29uZGFyeT0wMiwgc3Vib3JkaW5hdGU9MDIsIHNlYy1sYXRlbmN5
PTAKCUkvTyBiZWhpbmQgYnJpZGdlOiAwMDAwZjAwMC0wMDAwMGZmZiBbZGlzYWJsZWRdCglNZW1v
cnkgYmVoaW5kIGJyaWRnZTogOThhMDAwMDAtOThhZmZmZmYgW3NpemU9MU1dCglQcmVmZXRjaGFi
bGUgbWVtb3J5IGJlaGluZCBicmlkZ2U6IDAwMDAwMDAwZmZmMDAwMDAtMDAwMDAwMDAwMDBmZmZm
ZiBbZGlzYWJsZWRdCglTZWNvbmRhcnkgc3RhdHVzOiA2Nk1Iei0gRmFzdEIyQi0gUGFyRXJyLSBE
RVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0KyA8U0VSUi0gPFBFUlItCglCcmlk
Z2VDdGw6IFBhcml0eS0gU0VSUisgTm9JU0EtIFZHQS0gVkdBMTYtIE1BYm9ydC0gPlJlc2V0LSBG
YXN0QjJCLQoJCVByaURpc2NUbXItIFNlY0Rpc2NUbXItIERpc2NUbXJTdGF0LSBEaXNjVG1yU0VS
UkVuLQoJQ2FwYWJpbGl0aWVzOiBbNTBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzCgkJRmxh
Z3M6IFBNRUNsay0gRFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMCssRDEtLEQyLSxE
M2hvdCssRDNjb2xkKykKCQlTdGF0dXM6IEQwIE5vU29mdFJzdC0gUE1FLUVuYWJsZS0gRFNlbD0w
IERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczogWzU4XSBFeHByZXNzICh2MikgUm9vdCBQb3J0
IChTbG90KyksIE1TSSAwMAoJCURldkNhcDoJTWF4UGF5bG9hZCAyNTYgYnl0ZXMsIFBoYW50RnVu
YyAwCgkJCUV4dFRhZysgUkJFKwoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFs
RXJyLSBVbnN1cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFnKyBQaGFudEZ1bmMtIEF1eFB3ci0gTm9T
bm9vcCsKCQkJTWF4UGF5bG9hZCAyNTYgYnl0ZXMsIE1heFJlYWRSZXEgNTEyIGJ5dGVzCgkJRGV2
U3RhOglDb3JyRXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLSBBdXhQd3ItIFRy
YW5zUGVuZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDE2R1QvcywgV2lkdGggeDQsIEFTUE0g
TDEsIEV4aXQgTGF0ZW5jeSBMMSA8NjR1cwoJCQlDbG9ja1BNLSBTdXJwcmlzZS0gTExBY3RSZXAr
IEJ3Tm90KyBBU1BNT3B0Q29tcCsKCQlMbmtDdGw6CUFTUE0gTDEgRW5hYmxlZDsgUkNCIDY0IGJ5
dGVzLCBEaXNhYmxlZC0gQ29tbUNsaysKCQkJRXh0U3luY2grIENsb2NrUE0tIEF1dFdpZERpcy0g
QldJbnQtIEF1dEJXSW50LQoJCUxua1N0YToJU3BlZWQgMTZHVC9zIChvayksIFdpZHRoIHg0IChv
aykKCQkJVHJFcnItIFRyYWluLSBTbG90Q2xrKyBETEFjdGl2ZSsgQldNZ210KyBBQldNZ210LQoJ
CVNsdENhcDoJQXR0bkJ0bi0gUHdyQ3RybC0gTVJMLSBBdHRuSW5kLSBQd3JJbmQtIEhvdFBsdWct
IFN1cnByaXNlLQoJCQlTbG90ICMwLCBQb3dlckxpbWl0IDc1LjAwMFc7IEludGVybG9jay0gTm9D
b21wbCsKCQlTbHRDdGw6CUVuYWJsZTogQXR0bkJ0bi0gUHdyRmx0LSBNUkwtIFByZXNEZXQtIENt
ZENwbHQtIEhQSXJxLSBMaW5rQ2hnLQoJCQlDb250cm9sOiBBdHRuSW5kIFVua25vd24sIFB3cklu
ZCBVbmtub3duLCBQb3dlci0gSW50ZXJsb2NrLQoJCVNsdFN0YToJU3RhdHVzOiBBdHRuQnRuLSBQ
b3dlckZsdC0gTVJMLSBDbWRDcGx0LSBQcmVzRGV0KyBJbnRlcmxvY2stCgkJCUNoYW5nZWQ6IE1S
TC0gUHJlc0RldC0gTGlua1N0YXRlKwoJCVJvb3RDYXA6IENSU1Zpc2libGUrCgkJUm9vdEN0bDog
RXJyQ29ycmVjdGFibGUtIEVyck5vbi1GYXRhbC0gRXJyRmF0YWwtIFBNRUludEVuYSsgQ1JTVmlz
aWJsZSsKCQlSb290U3RhOiBQTUUgUmVxSUQgMDAwMCwgUE1FU3RhdHVzLSBQTUVQZW5kaW5nLQoJ
CURldkNhcDI6IENvbXBsZXRpb24gVGltZW91dDogUmFuZ2UgQUJDRCwgVGltZW91dERpcysgTlJP
UHJQclAtIExUUisKCQkJIDEwQml0VGFnQ29tcCsgMTBCaXRUYWdSZXErIE9CRkYgTm90IFN1cHBv
cnRlZCwgRXh0Rm10KyBFRVRMUFByZWZpeCssIE1heEVFVExQUHJlZml4ZXMgMQoJCQkgRW1lcmdl
bmN5UG93ZXJSZWR1Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25J
bml0LQoJCQkgRlJTLSBMTiBTeXN0ZW0gQ0xTIE5vdCBTdXBwb3J0ZWQsIFRQSENvbXArIEV4dFRQ
SENvbXAtIEFSSUZ3ZCsKCQkJIEF0b21pY09wc0NhcDogUm91dGluZysgMzJiaXQrIDY0Yml0KyAx
MjhiaXRDQVMtCgkJRGV2Q3RsMjogQ29tcGxldGlvbiBUaW1lb3V0OiA2NW1zIHRvIDIxMG1zLCBU
aW1lb3V0RGlzLSBMVFIrIE9CRkYgRGlzYWJsZWQsIEFSSUZ3ZCsKCQkJIEF0b21pY09wc0N0bDog
UmVxRW4tIEVncmVzc0JsY2stCgkJTG5rQ2FwMjogU3VwcG9ydGVkIExpbmsgU3BlZWRzOiAyLjUt
MTZHVC9zLCBDcm9zc2xpbmstIFJldGltZXIrIDJSZXRpbWVycysgRFJTLQoJCUxua0N0bDI6IFRh
cmdldCBMaW5rIFNwZWVkOiAxNkdUL3MsIEVudGVyQ29tcGxpYW5jZS0gU3BlZWREaXMtCgkJCSBU
cmFuc21pdCBNYXJnaW46IE5vcm1hbCBPcGVyYXRpbmcgUmFuZ2UsIEVudGVyTW9kaWZpZWRDb21w
bGlhbmNlLSBDb21wbGlhbmNlU09TLQoJCQkgQ29tcGxpYW5jZSBEZS1lbXBoYXNpczogLTZkQgoJ
CUxua1N0YTI6IEN1cnJlbnQgRGUtZW1waGFzaXMgTGV2ZWw6IC0zLjVkQiwgRXF1YWxpemF0aW9u
Q29tcGxldGUrIEVxdWFsaXphdGlvblBoYXNlMSsKCQkJIEVxdWFsaXphdGlvblBoYXNlMisgRXF1
YWxpemF0aW9uUGhhc2UzKyBMaW5rRXF1YWxpemF0aW9uUmVxdWVzdC0KCQkJIFJldGltZXItIDJS
ZXRpbWVycy0gQ3Jvc3NsaW5rUmVzOiB1bnN1cHBvcnRlZAoJQ2FwYWJpbGl0aWVzOiBbYTBdIE1T
STogRW5hYmxlKyBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0KwoJCUFkZHJlc3M6IDAwMDAwMDAw
ZmVlMDAwMDAgIERhdGE6IDAwMDAKCUNhcGFiaWxpdGllczogW2MwXSBTdWJzeXN0ZW06IExlbm92
byBEZXZpY2UgNTBiNAoJQ2FwYWJpbGl0aWVzOiBbYzhdIEh5cGVyVHJhbnNwb3J0OiBNU0kgTWFw
cGluZyBFbmFibGUrIEZpeGVkKwoJQ2FwYWJpbGl0aWVzOiBbMTAwIHYxXSBWZW5kb3IgU3BlY2lm
aWMgSW5mb3JtYXRpb246IElEPTAwMDEgUmV2PTEgTGVuPTAxMCA8Pz4KCUNhcGFiaWxpdGllczog
WzE1MCB2Ml0gQWR2YW5jZWQgRXJyb3IgUmVwb3J0aW5nCgkJVUVTdGE6CURMUC0gU0RFUy0gVExQ
LSBGQ1AtIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZUTFAtIEVDUkMt
IFVuc3VwUmVxLSBBQ1NWaW9sLQoJCVVFTXNrOglETFAtIFNERVMtIFRMUC0gRkNQLSBDbXBsdFRP
LSBDbXBsdEFicnQtIFVueENtcGx0LSBSeE9GLSBNYWxmVExQLSBFQ1JDLSBVbnN1cFJlcS0gQUNT
VmlvbC0KCQlVRVN2cnQ6CURMUC0gU0RFUysgVExQLSBGQ1ArIENtcGx0VE8tIENtcGx0QWJydC0g
VW54Q21wbHQtIFJ4T0YrIE1hbGZUTFAtIEVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sLQoJCUNFU3Rh
OglSeEVyci0gQmFkVExQLSBCYWRETExQLSBSb2xsb3Zlci0gVGltZW91dC0gQWR2Tm9uRmF0YWxF
cnItCgkJQ0VNc2s6CVJ4RXJyLSBCYWRUTFAtIEJhZERMTFAtIFJvbGxvdmVyLSBUaW1lb3V0LSBB
ZHZOb25GYXRhbEVycisKCQlBRVJDYXA6CUZpcnN0IEVycm9yIFBvaW50ZXI6IDAwLCBFQ1JDR2Vu
Q2FwKyBFQ1JDR2VuRW4tIEVDUkNDaGtDYXArIEVDUkNDaGtFbi0KCQkJTXVsdEhkclJlY0NhcC0g
TXVsdEhkclJlY0VuLSBUTFBQZnhQcmVzLSBIZHJMb2dDYXAtCgkJSGVhZGVyTG9nOiAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMAoJCVJvb3RDbWQ6IENFUnB0RW4tIE5GRVJwdEVu
LSBGRVJwdEVuLQoJCVJvb3RTdGE6IENFUmN2ZC0gTXVsdENFUmN2ZC0gVUVSY3ZkLSBNdWx0VUVS
Y3ZkLQoJCQkgRmlyc3RGYXRhbC0gTm9uRmF0YWxNc2ctIEZhdGFsTXNnLSBJbnRNc2cgMAoJCUVy
cm9yU3JjOiBFUlJfQ09SOiAwMDAwIEVSUl9GQVRBTC9OT05GQVRBTDogMDAwMAoJQ2FwYWJpbGl0
aWVzOiBbMjcwIHYxXSBTZWNvbmRhcnkgUENJIEV4cHJlc3MKCQlMbmtDdGwzOiBMbmtFcXVJbnRy
cnVwdEVuLSBQZXJmb3JtRXF1LQoJCUxhbmVFcnJTdGF0OiAwCglDYXBhYmlsaXRpZXM6IFsyYTAg
djFdIEFjY2VzcyBDb250cm9sIFNlcnZpY2VzCgkJQUNTQ2FwOglTcmNWYWxpZCsgVHJhbnNCbGsr
IFJlcVJlZGlyKyBDbXBsdFJlZGlyKyBVcHN0cmVhbUZ3ZCsgRWdyZXNzQ3RybC0gRGlyZWN0VHJh
bnMrCgkJQUNTQ3RsOglTcmNWYWxpZCsgVHJhbnNCbGstIFJlcVJlZGlyKyBDbXBsdFJlZGlyKyBV
cHN0cmVhbUZ3ZCsgRWdyZXNzQ3RybC0gRGlyZWN0VHJhbnMtCglDYXBhYmlsaXRpZXM6IFszNzAg
djFdIEwxIFBNIFN1YnN0YXRlcwoJCUwxU3ViQ2FwOiBQQ0ktUE1fTDEuMisgUENJLVBNX0wxLjEr
IEFTUE1fTDEuMisgQVNQTV9MMS4xKyBMMV9QTV9TdWJzdGF0ZXMrCgkJCSAgUG9ydENvbW1vbk1v
ZGVSZXN0b3JlVGltZT0xMHVzIFBvcnRUUG93ZXJPblRpbWU9MTUwdXMKCQlMMVN1YkN0bDE6IFBD
SS1QTV9MMS4yKyBQQ0ktUE1fTDEuMSsgQVNQTV9MMS4yKyBBU1BNX0wxLjErCgkJCSAgIFRfQ29t
bW9uTW9kZT0xMHVzIExUUjEuMl9UaHJlc2hvbGQ9MTY2OTEybnMKCQlMMVN1YkN0bDI6IFRfUHdy
T249MTUwdXMKCUNhcGFiaWxpdGllczogWzQwMCB2MV0gRGF0YSBMaW5rIEZlYXR1cmUgPD8+CglD
YXBhYmlsaXRpZXM6IFs0MTAgdjFdIFBoeXNpY2FsIExheWVyIDE2LjAgR1QvcyA8Pz4KCUNhcGFi
aWxpdGllczogWzQ0MCB2MV0gTGFuZSBNYXJnaW5pbmcgYXQgdGhlIFJlY2VpdmVyIDw/PgoJS2Vy
bmVsIGRyaXZlciBpbiB1c2U6IHBjaWVwb3J0CgowMDowMy4wIEhvc3QgYnJpZGdlOiBBZHZhbmNl
ZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIERldmljZSAxNGI3IChyZXYgMDEpCglDb250cm9s
OiBJL08tIE1lbS0gQnVzTWFzdGVyLSBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJF
cnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXAtIDY2TUh6
LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1B
Ym9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJSU9NTVUgZ3JvdXA6IDQKCjAwOjA0LjAgSG9zdCBi
cmlkZ2U6IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0gRGV2aWNlIDE0YjcgKHJl
diAwMSkKCUNvbnRyb2w6IEkvTy0gTWVtLSBCdXNNYXN0ZXItIFNwZWNDeWNsZS0gTWVtV0lOVi0g
VkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtCglTdGF0
dXM6IENhcC0gNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0
LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglJT01NVSBncm91cDogNQoK
MDA6MDQuMSBQQ0kgYnJpZGdlOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIERl
dmljZSAxNGNkIChwcm9nLWlmIDAwIFtOb3JtYWwgZGVjb2RlXSkKCUNvbnRyb2w6IEkvTysgTWVt
KyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBp
bmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgrCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFz
dEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VS
Ui0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwLCBDYWNoZSBMaW5lIFNpemU6IDMyIGJ5dGVzCglJ
bnRlcnJ1cHQ6IHBpbiA/IHJvdXRlZCB0byBJUlEgMzcKCUlPTU1VIGdyb3VwOiA1CglCdXM6IHBy
aW1hcnk9MDAsIHNlY29uZGFyeT0wMywgc3Vib3JkaW5hdGU9MzIsIHNlYy1sYXRlbmN5PTAKCUkv
TyBiZWhpbmQgYnJpZGdlOiAwMDAwMjAwMC0wMDAwM2ZmZiBbc2l6ZT04S10KCU1lbW9yeSBiZWhp
bmQgYnJpZGdlOiA4MDAwMDAwMC05N2ZmZmZmZiBbc2l6ZT0zODRNXQoJUHJlZmV0Y2hhYmxlIG1l
bW9yeSBiZWhpbmQgYnJpZGdlOiAwMDAwMDAwOTAwMDAwMDAwLTAwMDAwMDBhN2ZmZmZmZmYgW3Np
emU9NkddCglTZWNvbmRhcnkgc3RhdHVzOiA2Nk1Iei0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9
ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0KyA8U0VSUi0gPFBFUlItCglCcmlkZ2VDdGw6
IFBhcml0eS0gU0VSUisgTm9JU0EtIFZHQS0gVkdBMTYtIE1BYm9ydC0gPlJlc2V0LSBGYXN0QjJC
LQoJCVByaURpc2NUbXItIFNlY0Rpc2NUbXItIERpc2NUbXJTdGF0LSBEaXNjVG1yU0VSUkVuLQoJ
Q2FwYWJpbGl0aWVzOiBbNTBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzCgkJRmxhZ3M6IFBN
RUNsay0gRFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMCssRDEtLEQyLSxEM2hvdCss
RDNjb2xkKykKCQlTdGF0dXM6IEQwIE5vU29mdFJzdC0gUE1FLUVuYWJsZS0gRFNlbD0wIERTY2Fs
ZT0wIFBNRS0KCUNhcGFiaWxpdGllczogWzU4XSBFeHByZXNzICh2MikgUm9vdCBQb3J0IChTbG90
KyksIE1TSSAwMAoJCURldkNhcDoJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIFBoYW50RnVuYyAwCgkJ
CUV4dFRhZysgUkJFKwoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBV
bnN1cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFnKyBQaGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9vcCsK
CQkJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIE1heFJlYWRSZXEgNTEyIGJ5dGVzCgkJRGV2U3RhOglD
b3JyRXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLSBBdXhQd3ItIFRyYW5zUGVu
ZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDIuNUdUL3MsIFdpZHRoIHgxLCBBU1BNIEwxLCBF
eGl0IExhdGVuY3kgTDEgPDR1cwoJCQlDbG9ja1BNLSBTdXJwcmlzZS0gTExBY3RSZXArIEJ3Tm90
LSBBU1BNT3B0Q29tcCsKCQlMbmtDdGw6CUFTUE0gRGlzYWJsZWQ7IFJDQiA2NCBieXRlcywgRGlz
YWJsZWQtIENvbW1DbGsrCgkJCUV4dFN5bmNoLSBDbG9ja1BNLSBBdXRXaWREaXMtIEJXSW50LSBB
dXRCV0ludC0KCQlMbmtTdGE6CVNwZWVkIDIuNUdUL3MgKG9rKSwgV2lkdGggeDEgKG9rKQoJCQlU
ckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlKyBCV01nbXQtIEFCV01nbXQtCgkJU2x0Q2Fw
OglBdHRuQnRuLSBQd3JDdHJsLSBNUkwtIEF0dG5JbmQtIFB3ckluZC0gSG90UGx1ZysgU3VycHJp
c2UrCgkJCVNsb3QgIzAsIFBvd2VyTGltaXQgMC4wMDBXOyBJbnRlcmxvY2stIE5vQ29tcGwrCgkJ
U2x0Q3RsOglFbmFibGU6IEF0dG5CdG4tIFB3ckZsdC0gTVJMLSBQcmVzRGV0KyBDbWRDcGx0LSBI
UElycSsgTGlua0NoZysKCQkJQ29udHJvbDogQXR0bkluZCBVbmtub3duLCBQd3JJbmQgVW5rbm93
biwgUG93ZXItIEludGVybG9jay0KCQlTbHRTdGE6CVN0YXR1czogQXR0bkJ0bi0gUG93ZXJGbHQt
IE1STC0gQ21kQ3BsdC0gUHJlc0RldCsgSW50ZXJsb2NrLQoJCQlDaGFuZ2VkOiBNUkwtIFByZXNE
ZXQtIExpbmtTdGF0ZS0KCQlSb290Q2FwOiBDUlNWaXNpYmxlKwoJCVJvb3RDdGw6IEVyckNvcnJl
Y3RhYmxlLSBFcnJOb24tRmF0YWwtIEVyckZhdGFsLSBQTUVJbnRFbmErIENSU1Zpc2libGUrCgkJ
Um9vdFN0YTogUE1FIFJlcUlEIDAwMDAsIFBNRVN0YXR1cy0gUE1FUGVuZGluZy0KCQlEZXZDYXAy
OiBDb21wbGV0aW9uIFRpbWVvdXQ6IFJhbmdlIEFCQ0QsIFRpbWVvdXREaXMrIE5ST1ByUHJQLSBM
VFIrCgkJCSAxMEJpdFRhZ0NvbXArIDEwQml0VGFnUmVxKyBPQkZGIE5vdCBTdXBwb3J0ZWQsIEV4
dEZtdCsgRUVUTFBQcmVmaXgrLCBNYXhFRVRMUFByZWZpeGVzIDEKCQkJIEVtZXJnZW5jeVBvd2Vy
UmVkdWN0aW9uIE5vdCBTdXBwb3J0ZWQsIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uSW5pdC0KCQkJ
IEZSUy0gTE4gU3lzdGVtIENMUyBOb3QgU3VwcG9ydGVkLCBUUEhDb21wKyBFeHRUUEhDb21wLSBB
UklGd2QrCgkJCSBBdG9taWNPcHNDYXA6IFJvdXRpbmcrIDMyYml0KyA2NGJpdCsgMTI4Yml0Q0FT
LQoJCURldkN0bDI6IENvbXBsZXRpb24gVGltZW91dDogNTB1cyB0byA1MG1zLCBUaW1lb3V0RGlz
LSBMVFIrIE9CRkYgRGlzYWJsZWQsIEFSSUZ3ZC0KCQkJIEF0b21pY09wc0N0bDogUmVxRW4tIEVn
cmVzc0JsY2stCgkJTG5rQ2FwMjogU3VwcG9ydGVkIExpbmsgU3BlZWRzOiAyLjVHVC9zLCBDcm9z
c2xpbmstIFJldGltZXItIDJSZXRpbWVycy0gRFJTLQoJCUxua0N0bDI6IFRhcmdldCBMaW5rIFNw
ZWVkOiAyLjVHVC9zLCBFbnRlckNvbXBsaWFuY2UtIFNwZWVkRGlzLQoJCQkgVHJhbnNtaXQgTWFy
Z2luOiBOb3JtYWwgT3BlcmF0aW5nIFJhbmdlLCBFbnRlck1vZGlmaWVkQ29tcGxpYW5jZS0gQ29t
cGxpYW5jZVNPUy0KCQkJIENvbXBsaWFuY2UgRGUtZW1waGFzaXM6IC02ZEIKCQlMbmtTdGEyOiBD
dXJyZW50IERlLWVtcGhhc2lzIExldmVsOiAtNmRCLCBFcXVhbGl6YXRpb25Db21wbGV0ZS0gRXF1
YWxpemF0aW9uUGhhc2UxLQoJCQkgRXF1YWxpemF0aW9uUGhhc2UyLSBFcXVhbGl6YXRpb25QaGFz
ZTMtIExpbmtFcXVhbGl6YXRpb25SZXF1ZXN0LQoJCQkgUmV0aW1lci0gMlJldGltZXJzLSBDcm9z
c2xpbmtSZXM6IHVuc3VwcG9ydGVkCglDYXBhYmlsaXRpZXM6IFthMF0gTVNJOiBFbmFibGUrIENv
dW50PTEvMSBNYXNrYWJsZS0gNjRiaXQrCgkJQWRkcmVzczogMDAwMDAwMDBmZWUwMDAwMCAgRGF0
YTogMDAwMAoJQ2FwYWJpbGl0aWVzOiBbYzBdIFN1YnN5c3RlbTogQWR2YW5jZWQgTWljcm8gRGV2
aWNlcywgSW5jLiBbQU1EXSBEZXZpY2UgMTQ1MwoJQ2FwYWJpbGl0aWVzOiBbYzhdIEh5cGVyVHJh
bnNwb3J0OiBNU0kgTWFwcGluZyBFbmFibGUrIEZpeGVkKwoJQ2FwYWJpbGl0aWVzOiBbMTAwIHYx
XSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IElEPTAwMDEgUmV2PTEgTGVuPTAxMCA8Pz4K
CUNhcGFiaWxpdGllczogWzE1MCB2Ml0gQWR2YW5jZWQgRXJyb3IgUmVwb3J0aW5nCgkJVUVTdGE6
CURMUC0gU0RFUy0gVExQLSBGQ1AtIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0Yt
IE1hbGZUTFAtIEVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sLQoJCVVFTXNrOglETFAtIFNERVMtIFRM
UC0gRkNQLSBDbXBsdFRPLSBDbXBsdEFicnQtIFVueENtcGx0LSBSeE9GLSBNYWxmVExQLSBFQ1JD
LSBVbnN1cFJlcS0gQUNTVmlvbC0KCQlVRVN2cnQ6CURMUCsgU0RFUysgVExQLSBGQ1ArIENtcGx0
VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YrIE1hbGZUTFArIEVDUkMtIFVuc3VwUmVxLSBB
Q1NWaW9sLQoJCUNFU3RhOglSeEVyci0gQmFkVExQLSBCYWRETExQLSBSb2xsb3Zlci0gVGltZW91
dC0gQWR2Tm9uRmF0YWxFcnItCgkJQ0VNc2s6CVJ4RXJyLSBCYWRUTFAtIEJhZERMTFArIFJvbGxv
dmVyLSBUaW1lb3V0LSBBZHZOb25GYXRhbEVycisKCQlBRVJDYXA6CUZpcnN0IEVycm9yIFBvaW50
ZXI6IDAwLCBFQ1JDR2VuQ2FwKyBFQ1JDR2VuRW4tIEVDUkNDaGtDYXArIEVDUkNDaGtFbi0KCQkJ
TXVsdEhkclJlY0NhcC0gTXVsdEhkclJlY0VuLSBUTFBQZnhQcmVzLSBIZHJMb2dDYXAtCgkJSGVh
ZGVyTG9nOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMAoJCVJvb3RDbWQ6IENF
UnB0RW4tIE5GRVJwdEVuLSBGRVJwdEVuLQoJCVJvb3RTdGE6IENFUmN2ZC0gTXVsdENFUmN2ZC0g
VUVSY3ZkLSBNdWx0VUVSY3ZkLQoJCQkgRmlyc3RGYXRhbC0gTm9uRmF0YWxNc2ctIEZhdGFsTXNn
LSBJbnRNc2cgMAoJCUVycm9yU3JjOiBFUlJfQ09SOiAwMDAwIEVSUl9GQVRBTC9OT05GQVRBTDog
MDAwMAoJQ2FwYWJpbGl0aWVzOiBbMjcwIHYxXSBTZWNvbmRhcnkgUENJIEV4cHJlc3MKCQlMbmtD
dGwzOiBMbmtFcXVJbnRycnVwdEVuLSBQZXJmb3JtRXF1LQoJCUxhbmVFcnJTdGF0OiAwCglDYXBh
YmlsaXRpZXM6IFs0MDAgdjFdIERhdGEgTGluayBGZWF0dXJlIDw/PgoJS2VybmVsIGRyaXZlciBp
biB1c2U6IHBjaWVwb3J0CgowMDowOC4wIEhvc3QgYnJpZGdlOiBBZHZhbmNlZCBNaWNybyBEZXZp
Y2VzLCBJbmMuIFtBTURdIERldmljZSAxNGI3IChyZXYgMDEpCglDb250cm9sOiBJL08tIE1lbS0g
QnVzTWFzdGVyLSBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5n
LSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXAtIDY2TUh6LSBVREYtIEZhc3RC
MkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlIt
IDxQRVJSLSBJTlR4LQoJSU9NTVUgZ3JvdXA6IDYKCjAwOjA4LjEgUENJIGJyaWRnZTogQWR2YW5j
ZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBEZXZpY2UgMTRiOSAocmV2IDEwKSAocHJvZy1p
ZiAwMCBbTm9ybWFsIGRlY29kZV0pCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVj
Q3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJC
LSBEaXNJTlR4KwoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVW
U0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJ
TGF0ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiAzMiBieXRlcwoJSW50ZXJydXB0OiBwaW4gQSBy
b3V0ZWQgdG8gSVJRIDM4CglJT01NVSBncm91cDogNwoJQnVzOiBwcmltYXJ5PTAwLCBzZWNvbmRh
cnk9MzMsIHN1Ym9yZGluYXRlPTMzLCBzZWMtbGF0ZW5jeT0wCglJL08gYmVoaW5kIGJyaWRnZTog
MDAwMDEwMDAtMDAwMDFmZmYgW3NpemU9NEtdCglNZW1vcnkgYmVoaW5kIGJyaWRnZTogOTg2MDAw
MDAtOTg5ZmZmZmYgW3NpemU9NE1dCglQcmVmZXRjaGFibGUgbWVtb3J5IGJlaGluZCBicmlkZ2U6
IDAwMDAwMDA4ZTAwMDAwMDAtMDAwMDAwMDhmMDFmZmZmZiBbc2l6ZT0yNThNXQoJU2Vjb25kYXJ5
IHN0YXR1czogNjZNSHotIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRB
Ym9ydC0gPE1BYm9ydC0gPFNFUlItIDxQRVJSLQoJQnJpZGdlQ3RsOiBQYXJpdHktIFNFUlIrIE5v
SVNBLSBWR0ErIFZHQTE2LSBNQWJvcnQtID5SZXNldC0gRmFzdEIyQi0KCQlQcmlEaXNjVG1yLSBT
ZWNEaXNjVG1yLSBEaXNjVG1yU3RhdC0gRGlzY1RtclNFUlJFbi0KCUNhcGFiaWxpdGllczogWzUw
XSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQy
LSBBdXhDdXJyZW50PTBtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3RhdHVz
OiBEMCBOb1NvZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmls
aXRpZXM6IFs1OF0gRXhwcmVzcyAodjIpIFJvb3QgUG9ydCAoU2xvdC0pLCBNU0kgMDAKCQlEZXZD
YXA6CU1heFBheWxvYWQgNTEyIGJ5dGVzLCBQaGFudEZ1bmMgMAoJCQlFeHRUYWcrIFJCRSsKCQlE
ZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXEtCgkJCVJseGRP
cmQrIEV4dFRhZysgUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25vb3ArCgkJCU1heFBheWxvYWQgMTI4
IGJ5dGVzLCBNYXhSZWFkUmVxIDUxMiBieXRlcwoJCURldlN0YToJQ29yckVyci0gTm9uRmF0YWxF
cnItIEZhdGFsRXJyLSBVbnN1cFJlcS0gQXV4UHdyLSBUcmFuc1BlbmQtCgkJTG5rQ2FwOglQb3J0
ICMwLCBTcGVlZCAxNkdUL3MsIFdpZHRoIHgxNiwgQVNQTSBMMHMgTDEsIEV4aXQgTGF0ZW5jeSBM
MHMgPDY0bnMsIEwxIDwxdXMKCQkJQ2xvY2tQTS0gU3VycHJpc2UtIExMQWN0UmVwKyBCd05vdCsg
QVNQTU9wdENvbXArCgkJTG5rQ3RsOglBU1BNIERpc2FibGVkOyBSQ0IgNjQgYnl0ZXMsIERpc2Fi
bGVkLSBDb21tQ2xrKwoJCQlFeHRTeW5jaC0gQ2xvY2tQTS0gQXV0V2lkRGlzLSBCV0ludC0gQXV0
QldJbnQtCgkJTG5rU3RhOglTcGVlZCAxNkdUL3MgKG9rKSwgV2lkdGggeDE2IChvaykKCQkJVHJF
cnItIFRyYWluLSBTbG90Q2xrKyBETEFjdGl2ZSsgQldNZ210KyBBQldNZ210LQoJCVJvb3RDYXA6
IENSU1Zpc2libGUrCgkJUm9vdEN0bDogRXJyQ29ycmVjdGFibGUtIEVyck5vbi1GYXRhbC0gRXJy
RmF0YWwtIFBNRUludEVuYSsgQ1JTVmlzaWJsZSsKCQlSb290U3RhOiBQTUUgUmVxSUQgMDAwMCwg
UE1FU3RhdHVzLSBQTUVQZW5kaW5nLQoJCURldkNhcDI6IENvbXBsZXRpb24gVGltZW91dDogTm90
IFN1cHBvcnRlZCwgVGltZW91dERpcy0gTlJPUHJQclAtIExUUi0KCQkJIDEwQml0VGFnQ29tcCsg
MTBCaXRUYWdSZXEtIE9CRkYgTm90IFN1cHBvcnRlZCwgRXh0Rm10KyBFRVRMUFByZWZpeCssIE1h
eEVFVExQUHJlZml4ZXMgNAoJCQkgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb24gTm90IFN1cHBvcnRl
ZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkgRlJTLSBMTiBTeXN0ZW0gQ0xTIE5v
dCBTdXBwb3J0ZWQsIFRQSENvbXAtIEV4dFRQSENvbXAtIEFSSUZ3ZC0KCQkJIEF0b21pY09wc0Nh
cDogUm91dGluZysgMzJiaXQtIDY0Yml0LSAxMjhiaXRDQVMtCgkJRGV2Q3RsMjogQ29tcGxldGlv
biBUaW1lb3V0OiA1MHVzIHRvIDUwbXMsIFRpbWVvdXREaXMtIExUUi0gT0JGRiBEaXNhYmxlZCwg
QVJJRndkLQoJCQkgQXRvbWljT3BzQ3RsOiBSZXFFbi0gRWdyZXNzQmxjay0KCQlMbmtDYXAyOiBT
dXBwb3J0ZWQgTGluayBTcGVlZHM6IDIuNS0xNkdUL3MsIENyb3NzbGluay0gUmV0aW1lcisgMlJl
dGltZXJzKyBEUlMtCgkJTG5rQ3RsMjogVGFyZ2V0IExpbmsgU3BlZWQ6IDE2R1QvcywgRW50ZXJD
b21wbGlhbmNlLSBTcGVlZERpcy0KCQkJIFRyYW5zbWl0IE1hcmdpbjogTm9ybWFsIE9wZXJhdGlu
ZyBSYW5nZSwgRW50ZXJNb2RpZmllZENvbXBsaWFuY2UtIENvbXBsaWFuY2VTT1MtCgkJCSBDb21w
bGlhbmNlIERlLWVtcGhhc2lzOiAtNmRCCgkJTG5rU3RhMjogQ3VycmVudCBEZS1lbXBoYXNpcyBM
ZXZlbDogLTMuNWRCLCBFcXVhbGl6YXRpb25Db21wbGV0ZSsgRXF1YWxpemF0aW9uUGhhc2UxKwoJ
CQkgRXF1YWxpemF0aW9uUGhhc2UyKyBFcXVhbGl6YXRpb25QaGFzZTMrIExpbmtFcXVhbGl6YXRp
b25SZXF1ZXN0LQoJCQkgUmV0aW1lci0gMlJldGltZXJzLSBDcm9zc2xpbmtSZXM6IHVuc3VwcG9y
dGVkCglDYXBhYmlsaXRpZXM6IFthMF0gTVNJOiBFbmFibGUrIENvdW50PTEvMSBNYXNrYWJsZS0g
NjRiaXQrCgkJQWRkcmVzczogMDAwMDAwMDBmZWUwMDAwMCAgRGF0YTogMDAwMAoJQ2FwYWJpbGl0
aWVzOiBbYzBdIFN1YnN5c3RlbTogRGV2aWNlIDUwYjQ6MTdhYQoJQ2FwYWJpbGl0aWVzOiBbMTAw
IHYxXSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IElEPTAwMDEgUmV2PTEgTGVuPTAxMCA8
Pz4KCUNhcGFiaWxpdGllczogWzI3MCB2MV0gU2Vjb25kYXJ5IFBDSSBFeHByZXNzCgkJTG5rQ3Rs
MzogTG5rRXF1SW50cnJ1cHRFbi0gUGVyZm9ybUVxdS0KCQlMYW5lRXJyU3RhdDogMAoJQ2FwYWJp
bGl0aWVzOiBbMmEwIHYxXSBBY2Nlc3MgQ29udHJvbCBTZXJ2aWNlcwoJCUFDU0NhcDoJU3JjVmFs
aWQrIFRyYW5zQmxrKyBSZXFSZWRpcisgQ21wbHRSZWRpcisgVXBzdHJlYW1Gd2QrIEVncmVzc0N0
cmwtIERpcmVjdFRyYW5zKwoJCUFDU0N0bDoJU3JjVmFsaWQrIFRyYW5zQmxrLSBSZXFSZWRpcisg
Q21wbHRSZWRpcisgVXBzdHJlYW1Gd2QrIEVncmVzc0N0cmwtIERpcmVjdFRyYW5zLQoJQ2FwYWJp
bGl0aWVzOiBbNDAwIHYxXSBEYXRhIExpbmsgRmVhdHVyZSA8Pz4KCUNhcGFiaWxpdGllczogWzQx
MCB2MV0gUGh5c2ljYWwgTGF5ZXIgMTYuMCBHVC9zIDw/PgoJQ2FwYWJpbGl0aWVzOiBbNDUwIHYx
XSBMYW5lIE1hcmdpbmluZyBhdCB0aGUgUmVjZWl2ZXIgPD8+CglLZXJuZWwgZHJpdmVyIGluIHVz
ZTogcGNpZXBvcnQKCjAwOjA4LjMgUENJIGJyaWRnZTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywg
SW5jLiBbQU1EXSBEZXZpY2UgMTRiOSAocmV2IDEwKSAocHJvZy1pZiAwMCBbTm9ybWFsIGRlY29k
ZV0pCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZH
QVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVz
OiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0g
PFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMCwgQ2FjaGUg
TGluZSBTaXplOiAzMiBieXRlcwoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDM5CglJ
T01NVSBncm91cDogOAoJQnVzOiBwcmltYXJ5PTAwLCBzZWNvbmRhcnk9MzQsIHN1Ym9yZGluYXRl
PTM0LCBzZWMtbGF0ZW5jeT0wCglJL08gYmVoaW5kIGJyaWRnZTogMDAwMGYwMDAtMDAwMDBmZmYg
W2Rpc2FibGVkXQoJTWVtb3J5IGJlaGluZCBicmlkZ2U6IDk4MjAwMDAwLTk4NWZmZmZmIFtzaXpl
PTRNXQoJUHJlZmV0Y2hhYmxlIG1lbW9yeSBiZWhpbmQgYnJpZGdlOiAwMDAwMDAwMGZmZjAwMDAw
LTAwMDAwMDAwMDAwZmZmZmYgW2Rpc2FibGVkXQoJU2Vjb25kYXJ5IHN0YXR1czogNjZNSHotIEZh
c3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPFNF
UlItIDxQRVJSLQoJQnJpZGdlQ3RsOiBQYXJpdHktIFNFUlIrIE5vSVNBLSBWR0EtIFZHQTE2LSBN
QWJvcnQtID5SZXNldC0gRmFzdEIyQi0KCQlQcmlEaXNjVG1yLSBTZWNEaXNjVG1yLSBEaXNjVG1y
U3RhdC0gRGlzY1RtclNFUlJFbi0KCUNhcGFiaWxpdGllczogWzUwXSBQb3dlciBNYW5hZ2VtZW50
IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQ
TUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QtIFBN
RS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRpZXM6IFs1OF0gRXhwcmVz
cyAodjIpIFJvb3QgUG9ydCAoU2xvdC0pLCBNU0kgMDAKCQlEZXZDYXA6CU1heFBheWxvYWQgNTEy
IGJ5dGVzLCBQaGFudEZ1bmMgMAoJCQlFeHRUYWcrIFJCRSsKCQlEZXZDdGw6CUNvcnJFcnItIE5v
bkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXEtCgkJCVJseGRPcmQrIEV4dFRhZysgUGhhbnRG
dW5jLSBBdXhQd3ItIE5vU25vb3ArCgkJCU1heFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVx
IDUxMiBieXRlcwoJCURldlN0YToJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1
cFJlcS0gQXV4UHdyLSBUcmFuc1BlbmQtCgkJTG5rQ2FwOglQb3J0ICMwLCBTcGVlZCAxNkdUL3Ms
IFdpZHRoIHgxNiwgQVNQTSBMMHMgTDEsIEV4aXQgTGF0ZW5jeSBMMHMgPDY0bnMsIEwxIDwxdXMK
CQkJQ2xvY2tQTS0gU3VycHJpc2UtIExMQWN0UmVwKyBCd05vdCsgQVNQTU9wdENvbXArCgkJTG5r
Q3RsOglBU1BNIERpc2FibGVkOyBSQ0IgNjQgYnl0ZXMsIERpc2FibGVkLSBDb21tQ2xrKwoJCQlF
eHRTeW5jaC0gQ2xvY2tQTS0gQXV0V2lkRGlzLSBCV0ludC0gQXV0QldJbnQtCgkJTG5rU3RhOglT
cGVlZCAxNkdUL3MgKG9rKSwgV2lkdGggeDE2IChvaykKCQkJVHJFcnItIFRyYWluLSBTbG90Q2xr
KyBETEFjdGl2ZSsgQldNZ210KyBBQldNZ210LQoJCVJvb3RDYXA6IENSU1Zpc2libGUrCgkJUm9v
dEN0bDogRXJyQ29ycmVjdGFibGUtIEVyck5vbi1GYXRhbC0gRXJyRmF0YWwtIFBNRUludEVuYSsg
Q1JTVmlzaWJsZSsKCQlSb290U3RhOiBQTUUgUmVxSUQgMDAwMCwgUE1FU3RhdHVzLSBQTUVQZW5k
aW5nLQoJCURldkNhcDI6IENvbXBsZXRpb24gVGltZW91dDogTm90IFN1cHBvcnRlZCwgVGltZW91
dERpcy0gTlJPUHJQclAtIExUUi0KCQkJIDEwQml0VGFnQ29tcCsgMTBCaXRUYWdSZXEtIE9CRkYg
Tm90IFN1cHBvcnRlZCwgRXh0Rm10LSBFRVRMUFByZWZpeC0KCQkJIEVtZXJnZW5jeVBvd2VyUmVk
dWN0aW9uIE5vdCBTdXBwb3J0ZWQsIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uSW5pdC0KCQkJIEZS
Uy0gTE4gU3lzdGVtIENMUyBOb3QgU3VwcG9ydGVkLCBUUEhDb21wLSBFeHRUUEhDb21wLSBBUklG
d2QtCgkJCSBBdG9taWNPcHNDYXA6IFJvdXRpbmctIDMyYml0LSA2NGJpdC0gMTI4Yml0Q0FTLQoJ
CURldkN0bDI6IENvbXBsZXRpb24gVGltZW91dDogNTB1cyB0byA1MG1zLCBUaW1lb3V0RGlzLSBM
VFItIE9CRkYgRGlzYWJsZWQsIEFSSUZ3ZC0KCQkJIEF0b21pY09wc0N0bDogUmVxRW4tIEVncmVz
c0JsY2stCgkJTG5rQ2FwMjogU3VwcG9ydGVkIExpbmsgU3BlZWRzOiAyLjUtMTZHVC9zLCBDcm9z
c2xpbmstIFJldGltZXIrIDJSZXRpbWVycysgRFJTLQoJCUxua0N0bDI6IFRhcmdldCBMaW5rIFNw
ZWVkOiAxNkdUL3MsIEVudGVyQ29tcGxpYW5jZS0gU3BlZWREaXMtCgkJCSBUcmFuc21pdCBNYXJn
aW46IE5vcm1hbCBPcGVyYXRpbmcgUmFuZ2UsIEVudGVyTW9kaWZpZWRDb21wbGlhbmNlLSBDb21w
bGlhbmNlU09TLQoJCQkgQ29tcGxpYW5jZSBEZS1lbXBoYXNpczogLTZkQgoJCUxua1N0YTI6IEN1
cnJlbnQgRGUtZW1waGFzaXMgTGV2ZWw6IC0zLjVkQiwgRXF1YWxpemF0aW9uQ29tcGxldGUrIEVx
dWFsaXphdGlvblBoYXNlMSsKCQkJIEVxdWFsaXphdGlvblBoYXNlMisgRXF1YWxpemF0aW9uUGhh
c2UzKyBMaW5rRXF1YWxpemF0aW9uUmVxdWVzdC0KCQkJIFJldGltZXItIDJSZXRpbWVycy0gQ3Jv
c3NsaW5rUmVzOiB1bnN1cHBvcnRlZAoJQ2FwYWJpbGl0aWVzOiBbYTBdIE1TSTogRW5hYmxlKyBD
b3VudD0xLzEgTWFza2FibGUtIDY0Yml0KwoJCUFkZHJlc3M6IDAwMDAwMDAwZmVlMDAwMDAgIERh
dGE6IDAwMDAKCUNhcGFiaWxpdGllczogW2MwXSBTdWJzeXN0ZW06IERldmljZSA1MGI0OjE3YWEK
CUNhcGFiaWxpdGllczogWzEwMCB2MV0gVmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBJRD0w
MDAxIFJldj0xIExlbj0wMTAgPD8+CglDYXBhYmlsaXRpZXM6IFsxNTAgdjJdIEFkdmFuY2VkIEVy
cm9yIFJlcG9ydGluZwoJCVVFU3RhOglETFAtIFNERVMtIFRMUC0gRkNQLSBDbXBsdFRPLSBDbXBs
dEFicnQtIFVueENtcGx0LSBSeE9GLSBNYWxmVExQLSBFQ1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0K
CQlVRU1zazoJRExQLSBTREVTLSBUTFAtIEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBs
dC0gUnhPRi0gTWFsZlRMUC0gRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wtCgkJVUVTdnJ0OglETFAr
IFNERVMrIFRMUC0gRkNQKyBDbXBsdFRPLSBDbXBsdEFicnQtIFVueENtcGx0LSBSeE9GKyBNYWxm
VExQKyBFQ1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0KCQlDRVN0YToJUnhFcnItIEJhZFRMUC0gQmFk
RExMUC0gUm9sbG92ZXItIFRpbWVvdXQtIEFkdk5vbkZhdGFsRXJyLQoJCUNFTXNrOglSeEVyci0g
QmFkVExQLSBCYWRETExQLSBSb2xsb3Zlci0gVGltZW91dC0gQWR2Tm9uRmF0YWxFcnIrCgkJQUVS
Q2FwOglGaXJzdCBFcnJvciBQb2ludGVyOiAwMCwgRUNSQ0dlbkNhcC0gRUNSQ0dlbkVuLSBFQ1JD
Q2hrQ2FwLSBFQ1JDQ2hrRW4tCgkJCU11bHRIZHJSZWNDYXAtIE11bHRIZHJSZWNFbi0gVExQUGZ4
UHJlcy0gSGRyTG9nQ2FwLQoJCUhlYWRlckxvZzogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAg
MDAwMDAwMDAKCQlSb290Q21kOiBDRVJwdEVuLSBORkVScHRFbi0gRkVScHRFbi0KCQlSb290U3Rh
OiBDRVJjdmQtIE11bHRDRVJjdmQtIFVFUmN2ZC0gTXVsdFVFUmN2ZC0KCQkJIEZpcnN0RmF0YWwt
IE5vbkZhdGFsTXNnLSBGYXRhbE1zZy0gSW50TXNnIDAKCQlFcnJvclNyYzogRVJSX0NPUjogMDAw
MCBFUlJfRkFUQUwvTk9ORkFUQUw6IDAwMDAKCUNhcGFiaWxpdGllczogWzI3MCB2MV0gU2Vjb25k
YXJ5IFBDSSBFeHByZXNzCgkJTG5rQ3RsMzogTG5rRXF1SW50cnJ1cHRFbi0gUGVyZm9ybUVxdS0K
CQlMYW5lRXJyU3RhdDogMAoJQ2FwYWJpbGl0aWVzOiBbMmEwIHYxXSBBY2Nlc3MgQ29udHJvbCBT
ZXJ2aWNlcwoJCUFDU0NhcDoJU3JjVmFsaWQrIFRyYW5zQmxrKyBSZXFSZWRpcisgQ21wbHRSZWRp
cisgVXBzdHJlYW1Gd2QrIEVncmVzc0N0cmwtIERpcmVjdFRyYW5zKwoJCUFDU0N0bDoJU3JjVmFs
aWQrIFRyYW5zQmxrLSBSZXFSZWRpcisgQ21wbHRSZWRpcisgVXBzdHJlYW1Gd2QrIEVncmVzc0N0
cmwtIERpcmVjdFRyYW5zLQoJQ2FwYWJpbGl0aWVzOiBbNDAwIHYxXSBEYXRhIExpbmsgRmVhdHVy
ZSA8Pz4KCUNhcGFiaWxpdGllczogWzQxMCB2MV0gUGh5c2ljYWwgTGF5ZXIgMTYuMCBHVC9zIDw/
PgoJQ2FwYWJpbGl0aWVzOiBbNDUwIHYxXSBMYW5lIE1hcmdpbmluZyBhdCB0aGUgUmVjZWl2ZXIg
PD8+CglLZXJuZWwgZHJpdmVyIGluIHVzZTogcGNpZXBvcnQKCjAwOjE0LjAgU01CdXM6IEFkdmFu
Y2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0gRkNIIFNNQnVzIENvbnRyb2xsZXIgKHJldiA3
MSkKCVN1YnN5c3RlbTogTGVub3ZvIEZDSCBTTUJ1cyBDb250cm9sbGVyCglDb250cm9sOiBJL08t
IE1lbS0gQnVzTWFzdGVyLSBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0
ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVzOiBDYXAtIDY2TUh6KyBVREYt
IEZhc3RCMkItIFBhckVyci0gREVWU0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0
LSA+U0VSUi0gPFBFUlItIElOVHgtCglJT01NVSBncm91cDogOQoJS2VybmVsIGRyaXZlciBpbiB1
c2U6IHBpaXg0X3NtYnVzCglLZXJuZWwgbW9kdWxlczogaTJjX3BpaXg0CgowMDoxNC4zIElTQSBi
cmlkZ2U6IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0gRkNIIExQQyBCcmlkZ2Ug
KHJldiA1MSkKCVN1YnN5c3RlbTogTGVub3ZvIEZDSCBMUEMgQnJpZGdlCglDb250cm9sOiBJL08r
IE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUrIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0
ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXAtIDY2TUh6KyBVREYt
IEZhc3RCMkItIFBhckVyci0gREVWU0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0
LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwCglJT01NVSBncm91cDogOQoKMDA6MTgu
MCBIb3N0IGJyaWRnZTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBEZXZpY2Ug
MTY3OQoJQ29udHJvbDogSS9PLSBNZW0tIEJ1c01hc3Rlci0gU3BlY0N5Y2xlLSBNZW1XSU5WLSBW
R0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1
czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQt
IDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUlPTU1VIGdyb3VwOiAxMAoK
MDA6MTguMSBIb3N0IGJyaWRnZTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBE
ZXZpY2UgMTY3YQoJQ29udHJvbDogSS9PLSBNZW0tIEJ1c01hc3Rlci0gU3BlY0N5Y2xlLSBNZW1X
SU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0K
CVN0YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5U
QWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUlPTU1VIGdyb3Vw
OiAxMAoKMDA6MTguMiBIb3N0IGJyaWRnZTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBb
QU1EXSBEZXZpY2UgMTY3YgoJQ29udHJvbDogSS9PLSBNZW0tIEJ1c01hc3Rlci0gU3BlY0N5Y2xl
LSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlz
SU5UeC0KCVN0YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1m
YXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUlPTU1V
IGdyb3VwOiAxMAoKMDA6MTguMyBIb3N0IGJyaWRnZTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywg
SW5jLiBbQU1EXSBEZXZpY2UgMTY3YwoJQ29udHJvbDogSS9PLSBNZW0tIEJ1c01hc3Rlci0gU3Bl
Y0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIy
Qi0gRGlzSU5UeC0KCVN0YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERF
VlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0K
CUlPTU1VIGdyb3VwOiAxMAoJS2VybmVsIGRyaXZlciBpbiB1c2U6IGsxMHRlbXAKCUtlcm5lbCBt
b2R1bGVzOiBrMTB0ZW1wCgowMDoxOC40IEhvc3QgYnJpZGdlOiBBZHZhbmNlZCBNaWNybyBEZXZp
Y2VzLCBJbmMuIFtBTURdIERldmljZSAxNjdkCglDb250cm9sOiBJL08tIE1lbS0gQnVzTWFzdGVy
LSBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBG
YXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXAtIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVy
ci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJ
TlR4LQoJSU9NTVUgZ3JvdXA6IDEwCgowMDoxOC41IEhvc3QgYnJpZGdlOiBBZHZhbmNlZCBNaWNy
byBEZXZpY2VzLCBJbmMuIFtBTURdIERldmljZSAxNjdlCglDb250cm9sOiBJL08tIE1lbS0gQnVz
TWFzdGVyLSBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBT
RVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXAtIDY2TUh6LSBVREYtIEZhc3RCMkIt
IFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQ
RVJSLSBJTlR4LQoJSU9NTVUgZ3JvdXA6IDEwCgowMDoxOC42IEhvc3QgYnJpZGdlOiBBZHZhbmNl
ZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIERldmljZSAxNjdmCglDb250cm9sOiBJL08tIE1l
bS0gQnVzTWFzdGVyLSBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBw
aW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXAtIDY2TUh6LSBVREYtIEZh
c3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNF
UlItIDxQRVJSLSBJTlR4LQoJSU9NTVUgZ3JvdXA6IDEwCgowMDoxOC43IEhvc3QgYnJpZGdlOiBB
ZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIERldmljZSAxNjgwCglDb250cm9sOiBJ
L08tIE1lbS0gQnVzTWFzdGVyLSBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnIt
IFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXAtIDY2TUh6LSBV
REYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9y
dC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJSU9NTVUgZ3JvdXA6IDEwCgowMTowMC4wIE5ldHdvcmsg
Y29udHJvbGxlcjogUXVhbGNvbW0gQXRoZXJvcyBRQ05GQTc2NSAocmV2IDAxKQoJU3Vic3lzdGVt
OiBMZW5vdm8gRGV2aWNlIDkzMDkKCUNvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWND
eWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkIt
IERpc0lOVHgrCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZT
RUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglM
YXRlbmN5OiAwLCBDYWNoZSBMaW5lIFNpemU6IDMyIGJ5dGVzCglJbnRlcnJ1cHQ6IHBpbiA/IHJv
dXRlZCB0byBJUlEgOTYKCUlPTU1VIGdyb3VwOiAxMQoJUmVnaW9uIDA6IE1lbW9yeSBhdCA5ODAw
MDAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yTV0KCUNhcGFiaWxpdGllczog
WzQwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEt
IEQyLSBBdXhDdXJyZW50PTBtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3Rh
dHVzOiBEMCBOb1NvZnRSc3QrIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBh
YmlsaXRpZXM6IFs1MF0gTVNJOiBFbmFibGUrIENvdW50PTMyLzMyIE1hc2thYmxlKyA2NGJpdC0K
CQlBZGRyZXNzOiBmZWUwMDAwMCAgRGF0YTogMDAwMAoJCU1hc2tpbmc6IGZlMDIzYzAwICBQZW5k
aW5nOiAwMDAwMDAwMAoJQ2FwYWJpbGl0aWVzOiBbNzBdIEV4cHJlc3MgKHYyKSBFbmRwb2ludCwg
TVNJIDAwCgkJRGV2Q2FwOglNYXhQYXlsb2FkIDEyOCBieXRlcywgUGhhbnRGdW5jIDAsIExhdGVu
Y3kgTDBzIHVubGltaXRlZCwgTDEgdW5saW1pdGVkCgkJCUV4dFRhZy0gQXR0bkJ0bi0gQXR0bklu
ZC0gUHdySW5kLSBSQkUrIEZMUmVzZXQtIFNsb3RQb3dlckxpbWl0IDc1LjAwMFcKCQlEZXZDdGw6
CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXEtCgkJCVJseGRPcmQrIEV4
dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25vb3ArCgkJCU1heFBheWxvYWQgMTI4IGJ5dGVz
LCBNYXhSZWFkUmVxIDUxMiBieXRlcwoJCURldlN0YToJQ29yckVycisgTm9uRmF0YWxFcnItIEZh
dGFsRXJyLSBVbnN1cFJlcSsgQXV4UHdyKyBUcmFuc1BlbmQtCgkJTG5rQ2FwOglQb3J0ICMwLCBT
cGVlZCA4R1QvcywgV2lkdGggeDEsIEFTUE0gTDBzIEwxLCBFeGl0IExhdGVuY3kgTDBzIDwxdXMs
IEwxIDw2NHVzCgkJCUNsb2NrUE0tIFN1cnByaXNlLSBMTEFjdFJlcC0gQndOb3QtIEFTUE1PcHRD
b21wKwoJCUxua0N0bDoJQVNQTSBMMSBFbmFibGVkOyBSQ0IgNjQgYnl0ZXMsIERpc2FibGVkLSBD
b21tQ2xrKwoJCQlFeHRTeW5jaC0gQ2xvY2tQTS0gQXV0V2lkRGlzLSBCV0ludC0gQXV0QldJbnQt
CgkJTG5rU3RhOglTcGVlZCA1R1QvcyAoZG93bmdyYWRlZCksIFdpZHRoIHgxIChvaykKCQkJVHJF
cnItIFRyYWluLSBTbG90Q2xrKyBETEFjdGl2ZS0gQldNZ210LSBBQldNZ210LQoJCURldkNhcDI6
IENvbXBsZXRpb24gVGltZW91dDogUmFuZ2UgQUJDRCwgVGltZW91dERpcysgTlJPUHJQclAtIExU
UisKCQkJIDEwQml0VGFnQ29tcC0gMTBCaXRUYWdSZXEtIE9CRkYgTm90IFN1cHBvcnRlZCwgRXh0
Rm10LSBFRVRMUFByZWZpeC0KCQkJIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uIE5vdCBTdXBwb3J0
ZWQsIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uSW5pdC0KCQkJIEZSUy0gVFBIQ29tcCsgRXh0VFBI
Q29tcC0KCQkJIEF0b21pY09wc0NhcDogMzJiaXQtIDY0Yml0LSAxMjhiaXRDQVMtCgkJRGV2Q3Rs
MjogQ29tcGxldGlvbiBUaW1lb3V0OiA1MHVzIHRvIDUwbXMsIFRpbWVvdXREaXMtIExUUisgT0JG
RiBEaXNhYmxlZCwKCQkJIEF0b21pY09wc0N0bDogUmVxRW4tCgkJTG5rQ2FwMjogU3VwcG9ydGVk
IExpbmsgU3BlZWRzOiAyLjUtOEdUL3MsIENyb3NzbGluay0gUmV0aW1lci0gMlJldGltZXJzLSBE
UlMtCgkJTG5rQ3RsMjogVGFyZ2V0IExpbmsgU3BlZWQ6IDhHVC9zLCBFbnRlckNvbXBsaWFuY2Ut
IFNwZWVkRGlzLQoJCQkgVHJhbnNtaXQgTWFyZ2luOiBOb3JtYWwgT3BlcmF0aW5nIFJhbmdlLCBF
bnRlck1vZGlmaWVkQ29tcGxpYW5jZS0gQ29tcGxpYW5jZVNPUy0KCQkJIENvbXBsaWFuY2UgRGUt
ZW1waGFzaXM6IC02ZEIKCQlMbmtTdGEyOiBDdXJyZW50IERlLWVtcGhhc2lzIExldmVsOiAtMy41
ZEIsIEVxdWFsaXphdGlvbkNvbXBsZXRlLSBFcXVhbGl6YXRpb25QaGFzZTEtCgkJCSBFcXVhbGl6
YXRpb25QaGFzZTItIEVxdWFsaXphdGlvblBoYXNlMy0gTGlua0VxdWFsaXphdGlvblJlcXVlc3Qt
CgkJCSBSZXRpbWVyLSAyUmV0aW1lcnMtIENyb3NzbGlua1JlczogdW5zdXBwb3J0ZWQKCUNhcGFi
aWxpdGllczogWzEwMCB2Ml0gQWR2YW5jZWQgRXJyb3IgUmVwb3J0aW5nCgkJVUVTdGE6CURMUC0g
U0RFUy0gVExQLSBGQ1AtIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZU
TFAtIEVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sLQoJCVVFTXNrOglETFAtIFNERVMtIFRMUC0gRkNQ
LSBDbXBsdFRPLSBDbXBsdEFicnQtIFVueENtcGx0LSBSeE9GLSBNYWxmVExQLSBFQ1JDLSBVbnN1
cFJlcS0gQUNTVmlvbC0KCQlVRVN2cnQ6CURMUCsgU0RFUysgVExQLSBGQ1ArIENtcGx0VE8tIENt
cGx0QWJydC0gVW54Q21wbHQtIFJ4T0YrIE1hbGZUTFArIEVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9s
LQoJCUNFU3RhOglSeEVyci0gQmFkVExQLSBCYWRETExQLSBSb2xsb3Zlci0gVGltZW91dC0gQWR2
Tm9uRmF0YWxFcnIrCgkJQ0VNc2s6CVJ4RXJyLSBCYWRUTFAtIEJhZERMTFAtIFJvbGxvdmVyLSBU
aW1lb3V0LSBBZHZOb25GYXRhbEVycisKCQlBRVJDYXA6CUZpcnN0IEVycm9yIFBvaW50ZXI6IDAw
LCBFQ1JDR2VuQ2FwKyBFQ1JDR2VuRW4tIEVDUkNDaGtDYXArIEVDUkNDaGtFbi0KCQkJTXVsdEhk
clJlY0NhcC0gTXVsdEhkclJlY0VuLSBUTFBQZnhQcmVzLSBIZHJMb2dDYXAtCgkJSGVhZGVyTG9n
OiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMAoJQ2FwYWJpbGl0aWVzOiBbMTQ4
IHYxXSBTZWNvbmRhcnkgUENJIEV4cHJlc3MKCQlMbmtDdGwzOiBMbmtFcXVJbnRycnVwdEVuLSBQ
ZXJmb3JtRXF1LQoJCUxhbmVFcnJTdGF0OiAwCglDYXBhYmlsaXRpZXM6IFsxNTggdjFdIFRyYW5z
YWN0aW9uIFByb2Nlc3NpbmcgSGludHMKCQlObyBzdGVlcmluZyB0YWJsZSBhdmFpbGFibGUKCUNh
cGFiaWxpdGllczogWzFlNCB2MV0gTGF0ZW5jeSBUb2xlcmFuY2UgUmVwb3J0aW5nCgkJTWF4IHNu
b29wIGxhdGVuY3k6IDEwNDg1NzZucwoJCU1heCBubyBzbm9vcCBsYXRlbmN5OiAxMDQ4NTc2bnMK
CUNhcGFiaWxpdGllczogWzFlYyB2MV0gTDEgUE0gU3Vic3RhdGVzCgkJTDFTdWJDYXA6IFBDSS1Q
TV9MMS4yKyBQQ0ktUE1fTDEuMSsgQVNQTV9MMS4yKyBBU1BNX0wxLjErIEwxX1BNX1N1YnN0YXRl
cysKCQkJICBQb3J0Q29tbW9uTW9kZVJlc3RvcmVUaW1lPTcwdXMgUG9ydFRQb3dlck9uVGltZT0w
dXMKCQlMMVN1YkN0bDE6IFBDSS1QTV9MMS4yKyBQQ0ktUE1fTDEuMSsgQVNQTV9MMS4yKyBBU1BN
X0wxLjErCgkJCSAgIFRfQ29tbW9uTW9kZT0wdXMgTFRSMS4yX1RocmVzaG9sZD0yMjYzMDRucwoJ
CUwxU3ViQ3RsMjogVF9Qd3JPbj0xNTB1cwoJS2VybmVsIGRyaXZlciBpbiB1c2U6IGF0aDExa19w
Y2kKCUtlcm5lbCBtb2R1bGVzOiBhdGgxMWtfcGNpCgowMjowMC4wIE5vbi1Wb2xhdGlsZSBtZW1v
cnkgY29udHJvbGxlcjogU2Ftc3VuZyBFbGVjdHJvbmljcyBDbyBMdGQgTlZNZSBTU0QgQ29udHJv
bGxlciBQTTlBMS9QTTlBMy85ODBQUk8gKHByb2ctaWYgMDIgW05WTSBFeHByZXNzXSkKCVN1YnN5
c3RlbTogU2Ftc3VuZyBFbGVjdHJvbmljcyBDbyBMdGQgTlZNZSBTU0QgQ29udHJvbGxlciBQTTlB
MS9QTTlBMy85ODBQUk8KCUNvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0g
TWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lO
VHgrCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFz
dCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5
OiAwLCBDYWNoZSBMaW5lIFNpemU6IDMyIGJ5dGVzCglJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0
byBJUlEgNDMKCUlPTU1VIGdyb3VwOiAxMgoJUmVnaW9uIDA6IE1lbW9yeSBhdCA5OGEwMDAwMCAo
NjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xNktdCglDYXBhYmlsaXRpZXM6IFs0MF0g
UG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0g
QXV4Q3VycmVudD0wbUEgUE1FKEQwLSxEMS0sRDItLEQzaG90LSxEM2NvbGQtKQoJCVN0YXR1czog
RDAgTm9Tb2Z0UnN0KyBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJQ2FwYWJpbGl0
aWVzOiBbNTBdIE1TSTogRW5hYmxlLSBDb3VudD0xLzMyIE1hc2thYmxlLSA2NGJpdCsKCQlBZGRy
ZXNzOiAwMDAwMDAwMDAwMDAwMDAwICBEYXRhOiAwMDAwCglDYXBhYmlsaXRpZXM6IFs3MF0gRXhw
cmVzcyAodjIpIEVuZHBvaW50LCBNU0kgMDAKCQlEZXZDYXA6CU1heFBheWxvYWQgMjU2IGJ5dGVz
LCBQaGFudEZ1bmMgMCwgTGF0ZW5jeSBMMHMgdW5saW1pdGVkLCBMMSB1bmxpbWl0ZWQKCQkJRXh0
VGFnKyBBdHRuQnRuLSBBdHRuSW5kLSBQd3JJbmQtIFJCRSsgRkxSZXNldCsgU2xvdFBvd2VyTGlt
aXQgNzUuMDAwVwoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1
cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFnKyBQaGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9vcCsgRkxS
ZXNldC0KCQkJTWF4UGF5bG9hZCAyNTYgYnl0ZXMsIE1heFJlYWRSZXEgNTEyIGJ5dGVzCgkJRGV2
U3RhOglDb3JyRXJyKyBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxKyBBdXhQd3ItIFRy
YW5zUGVuZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDE2R1QvcywgV2lkdGggeDQsIEFTUE0g
TDEsIEV4aXQgTGF0ZW5jeSBMMSA8NjR1cwoJCQlDbG9ja1BNKyBTdXJwcmlzZS0gTExBY3RSZXAt
IEJ3Tm90LSBBU1BNT3B0Q29tcCsKCQlMbmtDdGw6CUFTUE0gTDEgRW5hYmxlZDsgUkNCIDY0IGJ5
dGVzLCBEaXNhYmxlZC0gQ29tbUNsaysKCQkJRXh0U3luY2grIENsb2NrUE0tIEF1dFdpZERpcy0g
QldJbnQtIEF1dEJXSW50LQoJCUxua1N0YToJU3BlZWQgMTZHVC9zIChvayksIFdpZHRoIHg0IChv
aykKCQkJVHJFcnItIFRyYWluLSBTbG90Q2xrKyBETEFjdGl2ZS0gQldNZ210LSBBQldNZ210LQoJ
CURldkNhcDI6IENvbXBsZXRpb24gVGltZW91dDogUmFuZ2UgQUJDRCwgVGltZW91dERpcysgTlJP
UHJQclAtIExUUisKCQkJIDEwQml0VGFnQ29tcCsgMTBCaXRUYWdSZXEtIE9CRkYgTm90IFN1cHBv
cnRlZCwgRXh0Rm10LSBFRVRMUFByZWZpeC0KCQkJIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uIE5v
dCBTdXBwb3J0ZWQsIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uSW5pdC0KCQkJIEZSUy0gVFBIQ29t
cC0gRXh0VFBIQ29tcC0KCQkJIEF0b21pY09wc0NhcDogMzJiaXQtIDY0Yml0LSAxMjhiaXRDQVMt
CgkJRGV2Q3RsMjogQ29tcGxldGlvbiBUaW1lb3V0OiA1MHVzIHRvIDUwbXMsIFRpbWVvdXREaXMt
IExUUisgT0JGRiBEaXNhYmxlZCwKCQkJIEF0b21pY09wc0N0bDogUmVxRW4tCgkJTG5rQ2FwMjog
U3VwcG9ydGVkIExpbmsgU3BlZWRzOiAyLjUtMTZHVC9zLCBDcm9zc2xpbmstIFJldGltZXIrIDJS
ZXRpbWVycysgRFJTLQoJCUxua0N0bDI6IFRhcmdldCBMaW5rIFNwZWVkOiAxNkdUL3MsIEVudGVy
Q29tcGxpYW5jZS0gU3BlZWREaXMtCgkJCSBUcmFuc21pdCBNYXJnaW46IE5vcm1hbCBPcGVyYXRp
bmcgUmFuZ2UsIEVudGVyTW9kaWZpZWRDb21wbGlhbmNlLSBDb21wbGlhbmNlU09TLQoJCQkgQ29t
cGxpYW5jZSBEZS1lbXBoYXNpczogLTZkQgoJCUxua1N0YTI6IEN1cnJlbnQgRGUtZW1waGFzaXMg
TGV2ZWw6IC0zLjVkQiwgRXF1YWxpemF0aW9uQ29tcGxldGUrIEVxdWFsaXphdGlvblBoYXNlMSsK
CQkJIEVxdWFsaXphdGlvblBoYXNlMisgRXF1YWxpemF0aW9uUGhhc2UzKyBMaW5rRXF1YWxpemF0
aW9uUmVxdWVzdC0KCQkJIFJldGltZXItIDJSZXRpbWVycy0gQ3Jvc3NsaW5rUmVzOiBVcHN0cmVh
bSBQb3J0CglDYXBhYmlsaXRpZXM6IFtiMF0gTVNJLVg6IEVuYWJsZSsgQ291bnQ9MTMwIE1hc2tl
ZC0KCQlWZWN0b3IgdGFibGU6IEJBUj0wIG9mZnNldD0wMDAwMzAwMAoJCVBCQTogQkFSPTAgb2Zm
c2V0PTAwMDAyMDAwCglDYXBhYmlsaXRpZXM6IFsxMDAgdjJdIEFkdmFuY2VkIEVycm9yIFJlcG9y
dGluZwoJCVVFU3RhOglETFAtIFNERVMtIFRMUC0gRkNQLSBDbXBsdFRPLSBDbXBsdEFicnQtIFVu
eENtcGx0LSBSeE9GLSBNYWxmVExQLSBFQ1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0KCQlVRU1zazoJ
RExQLSBTREVTLSBUTFAtIEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhPRi0g
TWFsZlRMUC0gRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wtCgkJVUVTdnJ0OglETFArIFNERVMrIFRM
UC0gRkNQKyBDbXBsdFRPLSBDbXBsdEFicnQtIFVueENtcGx0LSBSeE9GKyBNYWxmVExQKyBFQ1JD
LSBVbnN1cFJlcS0gQUNTVmlvbC0KCQlDRVN0YToJUnhFcnItIEJhZFRMUC0gQmFkRExMUC0gUm9s
bG92ZXItIFRpbWVvdXQtIEFkdk5vbkZhdGFsRXJyKwoJCUNFTXNrOglSeEVyci0gQmFkVExQLSBC
YWRETExQLSBSb2xsb3Zlci0gVGltZW91dC0gQWR2Tm9uRmF0YWxFcnIrCgkJQUVSQ2FwOglGaXJz
dCBFcnJvciBQb2ludGVyOiAwMCwgRUNSQ0dlbkNhcCsgRUNSQ0dlbkVuLSBFQ1JDQ2hrQ2FwKyBF
Q1JDQ2hrRW4tCgkJCU11bHRIZHJSZWNDYXArIE11bHRIZHJSZWNFbi0gVExQUGZ4UHJlcy0gSGRy
TG9nQ2FwLQoJCUhlYWRlckxvZzogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAK
CUNhcGFiaWxpdGllczogWzE2OCB2MV0gQWx0ZXJuYXRpdmUgUm91dGluZy1JRCBJbnRlcnByZXRh
dGlvbiAoQVJJKQoJCUFSSUNhcDoJTUZWQy0gQUNTLSwgTmV4dCBGdW5jdGlvbjogMAoJCUFSSUN0
bDoJTUZWQy0gQUNTLSwgRnVuY3Rpb24gR3JvdXA6IDAKCUNhcGFiaWxpdGllczogWzE3OCB2MV0g
U2Vjb25kYXJ5IFBDSSBFeHByZXNzCgkJTG5rQ3RsMzogTG5rRXF1SW50cnJ1cHRFbi0gUGVyZm9y
bUVxdS0KCQlMYW5lRXJyU3RhdDogMAoJQ2FwYWJpbGl0aWVzOiBbMTk4IHYxXSBQaHlzaWNhbCBM
YXllciAxNi4wIEdUL3MgPD8+CglDYXBhYmlsaXRpZXM6IFsxYmMgdjFdIExhbmUgTWFyZ2luaW5n
IGF0IHRoZSBSZWNlaXZlciA8Pz4KCUNhcGFiaWxpdGllczogWzIxNCB2MV0gTGF0ZW5jeSBUb2xl
cmFuY2UgUmVwb3J0aW5nCgkJTWF4IHNub29wIGxhdGVuY3k6IDEwNDg1NzZucwoJCU1heCBubyBz
bm9vcCBsYXRlbmN5OiAxMDQ4NTc2bnMKCUNhcGFiaWxpdGllczogWzIxYyB2MV0gTDEgUE0gU3Vi
c3RhdGVzCgkJTDFTdWJDYXA6IFBDSS1QTV9MMS4yKyBQQ0ktUE1fTDEuMSsgQVNQTV9MMS4yKyBB
U1BNX0wxLjErIEwxX1BNX1N1YnN0YXRlcysKCQkJICBQb3J0Q29tbW9uTW9kZVJlc3RvcmVUaW1l
PTEwdXMgUG9ydFRQb3dlck9uVGltZT0xMHVzCgkJTDFTdWJDdGwxOiBQQ0ktUE1fTDEuMisgUENJ
LVBNX0wxLjErIEFTUE1fTDEuMisgQVNQTV9MMS4xKwoJCQkgICBUX0NvbW1vbk1vZGU9MHVzIExU
UjEuMl9UaHJlc2hvbGQ9MTY2OTEybnMKCQlMMVN1YkN0bDI6IFRfUHdyT249MTUwdXMKCUNhcGFi
aWxpdGllczogWzNhMCB2MV0gRGF0YSBMaW5rIEZlYXR1cmUgPD8+CglLZXJuZWwgZHJpdmVyIGlu
IHVzZTogbnZtZQoJS2VybmVsIG1vZHVsZXM6IG52bWUKCjAzOjAwLjAgUENJIGJyaWRnZTogSW50
ZWwgQ29ycG9yYXRpb24gRFNMNjM0MCBUaHVuZGVyYm9sdCAzIEJyaWRnZSBbQWxwaW5lIFJpZGdl
IDJDIDIwMTVdIChwcm9nLWlmIDAwIFtOb3JtYWwgZGVjb2RlXSkKCVBoeXNpY2FsIFNsb3Q6IDAK
CUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25v
b3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtCglTdGF0dXM6IENh
cCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFi
b3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwLCBDYWNoZSBMaW5l
IFNpemU6IDMyIGJ5dGVzCglJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgNDAKCUlPTU1V
IGdyb3VwOiA1CglCdXM6IHByaW1hcnk9MDMsIHNlY29uZGFyeT0wNCwgc3Vib3JkaW5hdGU9MDUs
IHNlYy1sYXRlbmN5PTAKCUkvTyBiZWhpbmQgYnJpZGdlOiAwMDAwMjAwMC0wMDAwMmZmZiBbc2l6
ZT00S10KCU1lbW9yeSBiZWhpbmQgYnJpZGdlOiA4MDAwMDAwMC04MDBmZmZmZiBbc2l6ZT0xTV0K
CVByZWZldGNoYWJsZSBtZW1vcnkgYmVoaW5kIGJyaWRnZTogMDAwMDAwMDkwMDAwMDAwMC0wMDAw
MDAwYTdmZmZmZmZmIFtzaXplPTZHXQoJU2Vjb25kYXJ5IHN0YXR1czogNjZNSHotIEZhc3RCMkIt
IFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPFNFUlItIDxQ
RVJSLQoJQnJpZGdlQ3RsOiBQYXJpdHktIFNFUlIrIE5vSVNBLSBWR0EtIFZHQTE2LSBNQWJvcnQt
ID5SZXNldC0gRmFzdEIyQi0KCQlQcmlEaXNjVG1yLSBTZWNEaXNjVG1yLSBEaXNjVG1yU3RhdC0g
RGlzY1RtclNFUlJFbi0KCUNhcGFiaWxpdGllczogWzgwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNp
b24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDErIEQyKyBBdXhDdXJyZW50PTM3NW1BIFBNRShE
MCssRDErLEQyKyxEM2hvdCssRDNjb2xkKykKCQlTdGF0dXM6IEQwIE5vU29mdFJzdCsgUE1FLUVu
YWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczogWzg4XSBNU0k6IEVuYWJs
ZS0gQ291bnQ9MS8xIE1hc2thYmxlLSA2NGJpdCsKCQlBZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDAw
ICBEYXRhOiAwMDAwCglDYXBhYmlsaXRpZXM6IFthY10gU3Vic3lzdGVtOiBBa2l0aW8gRFNMNjM0
MCBUaHVuZGVyYm9sdCAzIEJyaWRnZSBbQWxwaW5lIFJpZGdlIDJDIDIwMTVdCglDYXBhYmlsaXRp
ZXM6IFtjMF0gRXhwcmVzcyAodjIpIFVwc3RyZWFtIFBvcnQsIE1TSSAwMAoJCURldkNhcDoJTWF4
UGF5bG9hZCAxMjggYnl0ZXMsIFBoYW50RnVuYyAwCgkJCUV4dFRhZysgQXR0bkJ0bi0gQXR0bklu
ZC0gUHdySW5kLSBSQkUrIFNsb3RQb3dlckxpbWl0IDAuMDAwVwoJCURldkN0bDoJQ29yckVyci0g
Tm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFnKyBQaGFu
dEZ1bmMtIEF1eFB3ci0gTm9Tbm9vcCsKCQkJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIE1heFJlYWRS
ZXEgNTEyIGJ5dGVzCgkJRGV2U3RhOglDb3JyRXJyKyBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVu
c3VwUmVxKyBBdXhQd3IrIFRyYW5zUGVuZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDIuNUdU
L3MsIFdpZHRoIHg0LCBBU1BNIEwwcyBMMSwgRXhpdCBMYXRlbmN5IEwwcyA8MnVzLCBMMSA8NHVz
CgkJCUNsb2NrUE0rIFN1cnByaXNlLSBMTEFjdFJlcC0gQndOb3QtIEFTUE1PcHRDb21wKwoJCUxu
a0N0bDoJQVNQTSBEaXNhYmxlZDsgRGlzYWJsZWQtIENvbW1DbGsrCgkJCUV4dFN5bmNoLSBDbG9j
a1BNLSBBdXRXaWREaXMtIEJXSW50LSBBdXRCV0ludC0KCQlMbmtTdGE6CVNwZWVkIDIuNUdUL3Mg
KG9rKSwgV2lkdGggeDQgKG9rKQoJCQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlLSBC
V01nbXQtIEFCV01nbXQtCgkJRGV2Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBOb3QgU3VwcG9y
dGVkLCBUaW1lb3V0RGlzLSBOUk9QclByUC0gTFRSKwoJCQkgMTBCaXRUYWdDb21wLSAxMEJpdFRh
Z1JlcS0gT0JGRiBOb3QgU3VwcG9ydGVkLCBFeHRGbXQtIEVFVExQUHJlZml4LQoJCQkgRW1lcmdl
bmN5UG93ZXJSZWR1Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25J
bml0LQoJCQkgRlJTLQoJCQkgQXRvbWljT3BzQ2FwOiBSb3V0aW5nLQoJCURldkN0bDI6IENvbXBs
ZXRpb24gVGltZW91dDogNTB1cyB0byA1MG1zLCBUaW1lb3V0RGlzLSBMVFIrIE9CRkYgRGlzYWJs
ZWQsCgkJCSBBdG9taWNPcHNDdGw6IEVncmVzc0JsY2stCgkJTG5rQ2FwMjogU3VwcG9ydGVkIExp
bmsgU3BlZWRzOiAyLjUtOEdUL3MsIENyb3NzbGluay0gUmV0aW1lci0gMlJldGltZXJzLSBEUlMt
CgkJTG5rQ3RsMjogVGFyZ2V0IExpbmsgU3BlZWQ6IDIuNUdUL3MsIEVudGVyQ29tcGxpYW5jZS0g
U3BlZWREaXMtCgkJCSBUcmFuc21pdCBNYXJnaW46IE5vcm1hbCBPcGVyYXRpbmcgUmFuZ2UsIEVu
dGVyTW9kaWZpZWRDb21wbGlhbmNlLSBDb21wbGlhbmNlU09TLQoJCQkgQ29tcGxpYW5jZSBEZS1l
bXBoYXNpczogLTZkQgoJCUxua1N0YTI6IEN1cnJlbnQgRGUtZW1waGFzaXMgTGV2ZWw6IC0zLjVk
QiwgRXF1YWxpemF0aW9uQ29tcGxldGUtIEVxdWFsaXphdGlvblBoYXNlMS0KCQkJIEVxdWFsaXph
dGlvblBoYXNlMi0gRXF1YWxpemF0aW9uUGhhc2UzLSBMaW5rRXF1YWxpemF0aW9uUmVxdWVzdC0K
CQkJIFJldGltZXItIDJSZXRpbWVycy0gQ3Jvc3NsaW5rUmVzOiB1bnN1cHBvcnRlZAoJQ2FwYWJp
bGl0aWVzOiBbMTAwIHYxXSBEZXZpY2UgU2VyaWFsIE51bWJlciA3Yi01Yy0wMC1kMS1iMy1lOS0w
Ny0wMAoJQ2FwYWJpbGl0aWVzOiBbMjAwIHYxXSBBZHZhbmNlZCBFcnJvciBSZXBvcnRpbmcKCQlV
RVN0YToJRExQLSBTREVTLSBUTFAtIEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0g
UnhPRi0gTWFsZlRMUC0gRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wtCgkJVUVNc2s6CURMUC0gU0RF
Uy0gVExQLSBGQ1AtIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZUTFAt
IEVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sLQoJCVVFU3ZydDoJRExQKyBTREVTLSBUTFAtIEZDUCsg
Q21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhPRisgTWFsZlRMUCsgRUNSQy0gVW5zdXBS
ZXEtIEFDU1Zpb2wtCgkJQ0VTdGE6CVJ4RXJyLSBCYWRUTFAtIEJhZERMTFAtIFJvbGxvdmVyLSBU
aW1lb3V0LSBBZHZOb25GYXRhbEVycisKCQlDRU1zazoJUnhFcnItIEJhZFRMUC0gQmFkRExMUC0g
Um9sbG92ZXItIFRpbWVvdXQtIEFkdk5vbkZhdGFsRXJyKwoJCUFFUkNhcDoJRmlyc3QgRXJyb3Ig
UG9pbnRlcjogMDAsIEVDUkNHZW5DYXAtIEVDUkNHZW5Fbi0gRUNSQ0Noa0NhcC0gRUNSQ0Noa0Vu
LQoJCQlNdWx0SGRyUmVjQ2FwLSBNdWx0SGRyUmVjRW4tIFRMUFBmeFByZXMtIEhkckxvZ0NhcC0K
CQlIZWFkZXJMb2c6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwCglDYXBhYmls
aXRpZXM6IFszMDAgdjFdIFZpcnR1YWwgQ2hhbm5lbAoJCUNhcHM6CUxQRVZDPTAgUmVmQ2xrPTEw
MG5zIFBBVEVudHJ5Qml0cz0xCgkJQXJiOglGaXhlZC0gV1JSMzItIFdSUjY0LSBXUlIxMjgtCgkJ
Q3RybDoJQXJiU2VsZWN0PUZpeGVkCgkJU3RhdHVzOglJblByb2dyZXNzLQoJCVZDMDoJQ2FwczoJ
UEFUT2Zmc2V0PTAwIE1heFRpbWVTbG90cz0xIFJlalNub29wVHJhbnMtCgkJCUFyYjoJRml4ZWQr
IFdSUjMyLSBXUlI2NC0gV1JSMTI4LSBUV1JSMTI4LSBXUlIyNTYtCgkJCUN0cmw6CUVuYWJsZSsg
SUQ9MCBBcmJTZWxlY3Q9Rml4ZWQgVEMvVkM9ZmYKCQkJU3RhdHVzOglOZWdvUGVuZGluZy0gSW5Q
cm9ncmVzcy0KCUNhcGFiaWxpdGllczogWzQwMCB2MV0gUG93ZXIgQnVkZ2V0aW5nIDw/PgoJQ2Fw
YWJpbGl0aWVzOiBbNTAwIHYxXSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IElEPTEyMzQg
UmV2PTEgTGVuPTBkOCA8Pz4KCUNhcGFiaWxpdGllczogWzYwMCB2MV0gTGF0ZW5jeSBUb2xlcmFu
Y2UgUmVwb3J0aW5nCgkJTWF4IHNub29wIGxhdGVuY3k6IDBucwoJCU1heCBubyBzbm9vcCBsYXRl
bmN5OiAwbnMKCUNhcGFiaWxpdGllczogWzcwMCB2MV0gU2Vjb25kYXJ5IFBDSSBFeHByZXNzCgkJ
TG5rQ3RsMzogTG5rRXF1SW50cnJ1cHRFbi0gUGVyZm9ybUVxdS0KCQlMYW5lRXJyU3RhdDogMAoJ
S2VybmVsIGRyaXZlciBpbiB1c2U6IHBjaWVwb3J0CgowNDowMS4wIFBDSSBicmlkZ2U6IEludGVs
IENvcnBvcmF0aW9uIERTTDYzNDAgVGh1bmRlcmJvbHQgMyBCcmlkZ2UgW0FscGluZSBSaWRnZSAy
QyAyMDE1XSAocHJvZy1pZiAwMCBbTm9ybWFsIGRlY29kZV0pCglDb250cm9sOiBJL08rIE1lbSsg
QnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5n
LSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RC
MkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlIt
IDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiAzMiBieXRlcwoJSW50
ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDQyCglJT01NVSBncm91cDogNQoJQnVzOiBwcmlt
YXJ5PTA0LCBzZWNvbmRhcnk9MDUsIHN1Ym9yZGluYXRlPTA1LCBzZWMtbGF0ZW5jeT0wCglJL08g
YmVoaW5kIGJyaWRnZTogMDAwMDIwMDAtMDAwMDJmZmYgW3NpemU9NEtdCglNZW1vcnkgYmVoaW5k
IGJyaWRnZTogODAwMDAwMDAtODAwZmZmZmYgW3NpemU9MU1dCglQcmVmZXRjaGFibGUgbWVtb3J5
IGJlaGluZCBicmlkZ2U6IDAwMDAwMDA5MDAwMDAwMDAtMDAwMDAwMGE3ZmZmZmZmZiBbc2l6ZT02
R10KCVNlY29uZGFyeSBzdGF0dXM6IDY2TUh6LSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0
ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtIDxTRVJSLSA8UEVSUi0KCUJyaWRnZUN0bDogUGFy
aXR5LSBTRVJSKyBOb0lTQS0gVkdBLSBWR0ExNi0gTUFib3J0LSA+UmVzZXQtIEZhc3RCMkItCgkJ
UHJpRGlzY1Rtci0gU2VjRGlzY1Rtci0gRGlzY1RtclN0YXQtIERpc2NUbXJTRVJSRW4tCglDYXBh
YmlsaXRpZXM6IFs4MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xr
LSBEU0ktIEQxKyBEMisgQXV4Q3VycmVudD0zNzVtQSBQTUUoRDArLEQxKyxEMissRDNob3QrLEQz
Y29sZCspCgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QrIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9
MCBQTUUtCglDYXBhYmlsaXRpZXM6IFs4OF0gTVNJOiBFbmFibGUrIENvdW50PTEvMSBNYXNrYWJs
ZS0gNjRiaXQrCgkJQWRkcmVzczogMDAwMDAwMDBmZWUwMDAwMCAgRGF0YTogMDAwMAoJQ2FwYWJp
bGl0aWVzOiBbYWNdIFN1YnN5c3RlbTogQWtpdGlvIERTTDYzNDAgVGh1bmRlcmJvbHQgMyBCcmlk
Z2UgW0FscGluZSBSaWRnZSAyQyAyMDE1XQoJQ2FwYWJpbGl0aWVzOiBbYzBdIEV4cHJlc3MgKHYy
KSBEb3duc3RyZWFtIFBvcnQgKFNsb3QrKSwgTVNJIDAwCgkJRGV2Q2FwOglNYXhQYXlsb2FkIDEy
OCBieXRlcywgUGhhbnRGdW5jIDAKCQkJRXh0VGFnKyBSQkUrCgkJRGV2Q3RsOglDb3JyRXJyLSBO
b25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLQoJCQlSbHhkT3JkKyBFeHRUYWcrIFBoYW50
RnVuYy0gQXV4UHdyLSBOb1Nub29wKwoJCQlNYXhQYXlsb2FkIDEyOCBieXRlcywgTWF4UmVhZFJl
cSA1MTIgYnl0ZXMKCQlEZXZTdGE6CUNvcnJFcnIrIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5z
dXBSZXEtIEF1eFB3cisgVHJhbnNQZW5kLQoJCUxua0NhcDoJUG9ydCAjMSwgU3BlZWQgOEdUL3Ms
IFdpZHRoIHg0LCBBU1BNIEwwcyBMMSwgRXhpdCBMYXRlbmN5IEwwcyA8MnVzLCBMMSA8NHVzCgkJ
CUNsb2NrUE0tIFN1cnByaXNlLSBMTEFjdFJlcCsgQndOb3QrIEFTUE1PcHRDb21wKwoJCUxua0N0
bDoJQVNQTSBEaXNhYmxlZDsgRGlzYWJsZWQtIENvbW1DbGsrCgkJCUV4dFN5bmNoLSBDbG9ja1BN
LSBBdXRXaWREaXMtIEJXSW50LSBBdXRCV0ludC0KCQlMbmtTdGE6CVNwZWVkIDIuNUdUL3MgKGRv
d25ncmFkZWQpLCBXaWR0aCB4NCAob2spCgkJCVRyRXJyLSBUcmFpbi0gU2xvdENsaysgRExBY3Rp
dmUrIEJXTWdtdCsgQUJXTWdtdCsKCQlTbHRDYXA6CUF0dG5CdG4tIFB3ckN0cmwtIE1STC0gQXR0
bkluZC0gUHdySW5kLSBIb3RQbHVnLSBTdXJwcmlzZS0KCQkJU2xvdCAjMCwgUG93ZXJMaW1pdCAw
LjAwMFc7IEludGVybG9jay0gTm9Db21wbCsKCQlTbHRDdGw6CUVuYWJsZTogQXR0bkJ0bi0gUHdy
Rmx0LSBNUkwtIFByZXNEZXQtIENtZENwbHQtIEhQSXJxLSBMaW5rQ2hnLQoJCQlDb250cm9sOiBB
dHRuSW5kIFVua25vd24sIFB3ckluZCBVbmtub3duLCBQb3dlci0gSW50ZXJsb2NrLQoJCVNsdFN0
YToJU3RhdHVzOiBBdHRuQnRuLSBQb3dlckZsdC0gTVJMLSBDbWRDcGx0LSBQcmVzRGV0KyBJbnRl
cmxvY2stCgkJCUNoYW5nZWQ6IE1STC0gUHJlc0RldCsgTGlua1N0YXRlKwoJCURldkNhcDI6IENv
bXBsZXRpb24gVGltZW91dDogTm90IFN1cHBvcnRlZCwgVGltZW91dERpcy0gTlJPUHJQclAtIExU
UisKCQkJIDEwQml0VGFnQ29tcC0gMTBCaXRUYWdSZXEtIE9CRkYgTm90IFN1cHBvcnRlZCwgRXh0
Rm10LSBFRVRMUFByZWZpeC0KCQkJIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uIE5vdCBTdXBwb3J0
ZWQsIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uSW5pdC0KCQkJIEZSUy0gQVJJRndkLQoJCQkgQXRv
bWljT3BzQ2FwOiBSb3V0aW5nLQoJCURldkN0bDI6IENvbXBsZXRpb24gVGltZW91dDogNTB1cyB0
byA1MG1zLCBUaW1lb3V0RGlzLSBMVFIrIE9CRkYgRGlzYWJsZWQsIEFSSUZ3ZC0KCQkJIEF0b21p
Y09wc0N0bDogRWdyZXNzQmxjay0KCQlMbmtDYXAyOiBTdXBwb3J0ZWQgTGluayBTcGVlZHM6IDIu
NS04R1QvcywgQ3Jvc3NsaW5rLSBSZXRpbWVyLSAyUmV0aW1lcnMtIERSUy0KCQlMbmtDdGwyOiBU
YXJnZXQgTGluayBTcGVlZDogOEdUL3MsIEVudGVyQ29tcGxpYW5jZS0gU3BlZWREaXMtLCBTZWxl
Y3RhYmxlIERlLWVtcGhhc2lzOiAtMy41ZEIKCQkJIFRyYW5zbWl0IE1hcmdpbjogTm9ybWFsIE9w
ZXJhdGluZyBSYW5nZSwgRW50ZXJNb2RpZmllZENvbXBsaWFuY2UtIENvbXBsaWFuY2VTT1MtCgkJ
CSBDb21wbGlhbmNlIERlLWVtcGhhc2lzOiAtNmRCCgkJTG5rU3RhMjogQ3VycmVudCBEZS1lbXBo
YXNpcyBMZXZlbDogLTMuNWRCLCBFcXVhbGl6YXRpb25Db21wbGV0ZSsgRXF1YWxpemF0aW9uUGhh
c2UxKwoJCQkgRXF1YWxpemF0aW9uUGhhc2UyKyBFcXVhbGl6YXRpb25QaGFzZTMrIExpbmtFcXVh
bGl6YXRpb25SZXF1ZXN0LQoJCQkgUmV0aW1lci0gMlJldGltZXJzLSBDcm9zc2xpbmtSZXM6IHVu
c3VwcG9ydGVkCglDYXBhYmlsaXRpZXM6IFsxMDAgdjFdIERldmljZSBTZXJpYWwgTnVtYmVyIDdi
LTVjLTAwLWQxLWIzLWU5LTA3LTAwCglDYXBhYmlsaXRpZXM6IFsyMDAgdjFdIEFkdmFuY2VkIEVy
cm9yIFJlcG9ydGluZwoJCVVFU3RhOglETFAtIFNERVMtIFRMUC0gRkNQLSBDbXBsdFRPLSBDbXBs
dEFicnQtIFVueENtcGx0LSBSeE9GLSBNYWxmVExQLSBFQ1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0K
CQlVRU1zazoJRExQLSBTREVTLSBUTFAtIEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBs
dC0gUnhPRi0gTWFsZlRMUC0gRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wtCgkJVUVTdnJ0OglETFAr
IFNERVMtIFRMUC0gRkNQKyBDbXBsdFRPLSBDbXBsdEFicnQtIFVueENtcGx0LSBSeE9GKyBNYWxm
VExQKyBFQ1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0KCQlDRVN0YToJUnhFcnItIEJhZFRMUC0gQmFk
RExMUCsgUm9sbG92ZXItIFRpbWVvdXQtIEFkdk5vbkZhdGFsRXJyLQoJCUNFTXNrOglSeEVyci0g
QmFkVExQLSBCYWRETExQLSBSb2xsb3Zlci0gVGltZW91dC0gQWR2Tm9uRmF0YWxFcnIrCgkJQUVS
Q2FwOglGaXJzdCBFcnJvciBQb2ludGVyOiAwMCwgRUNSQ0dlbkNhcC0gRUNSQ0dlbkVuLSBFQ1JD
Q2hrQ2FwLSBFQ1JDQ2hrRW4tCgkJCU11bHRIZHJSZWNDYXAtIE11bHRIZHJSZWNFbi0gVExQUGZ4
UHJlcy0gSGRyTG9nQ2FwLQoJCUhlYWRlckxvZzogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAg
MDAwMDAwMDAKCUNhcGFiaWxpdGllczogWzMwMCB2MV0gVmlydHVhbCBDaGFubmVsCgkJQ2FwczoJ
TFBFVkM9MCBSZWZDbGs9MTAwbnMgUEFURW50cnlCaXRzPTEKCQlBcmI6CUZpeGVkLSBXUlIzMi0g
V1JSNjQtIFdSUjEyOC0KCQlDdHJsOglBcmJTZWxlY3Q9Rml4ZWQKCQlTdGF0dXM6CUluUHJvZ3Jl
c3MtCgkJVkMwOglDYXBzOglQQVRPZmZzZXQ9MDAgTWF4VGltZVNsb3RzPTEgUmVqU25vb3BUcmFu
cy0KCQkJQXJiOglGaXhlZCsgV1JSMzItIFdSUjY0LSBXUlIxMjgtIFRXUlIxMjgtIFdSUjI1Ni0K
CQkJQ3RybDoJRW5hYmxlKyBJRD0wIEFyYlNlbGVjdD1GaXhlZCBUQy9WQz1mZgoJCQlTdGF0dXM6
CU5lZ29QZW5kaW5nLSBJblByb2dyZXNzLQoJQ2FwYWJpbGl0aWVzOiBbNDAwIHYxXSBQb3dlciBC
dWRnZXRpbmcgPD8+CglDYXBhYmlsaXRpZXM6IFs1MDAgdjFdIFZlbmRvciBTcGVjaWZpYyBJbmZv
cm1hdGlvbjogSUQ9MTIzNCBSZXY9MSBMZW49MGQ4IDw/PgoJQ2FwYWJpbGl0aWVzOiBbNzAwIHYx
XSBTZWNvbmRhcnkgUENJIEV4cHJlc3MKCQlMbmtDdGwzOiBMbmtFcXVJbnRycnVwdEVuLSBQZXJm
b3JtRXF1LQoJCUxhbmVFcnJTdGF0OiBMYW5lRXJyIGF0IGxhbmU6IDAgMSAyIDMKCUtlcm5lbCBk
cml2ZXIgaW4gdXNlOiBwY2llcG9ydAoKMDU6MDAuMCBWR0EgY29tcGF0aWJsZSBjb250cm9sbGVy
OiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTUQvQVRJXSBFbGxlc21lcmUgW1JhZGVv
biBSWCA0NzAvNDgwLzU3MC81NzBYLzU4MC81ODBYLzU5MF0gKHJldiBlNykgKHByb2ctaWYgMDAg
W1ZHQSBjb250cm9sbGVyXSkKCVN1YnN5c3RlbTogU2FwcGhpcmUgVGVjaG5vbG9neSBMaW1pdGVk
IE5pdHJvKyBSYWRlb24gUlggNTcwLzU4MC81OTAKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0
ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlIt
IEZhc3RCMkItIERpc0lOVHgrCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFy
RXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlIt
IElOVHgtCglMYXRlbmN5OiAwLCBDYWNoZSBMaW5lIFNpemU6IDMyIGJ5dGVzCglJbnRlcnJ1cHQ6
IHBpbiBBIHJvdXRlZCB0byBJUlEgNzEKCUlPTU1VIGdyb3VwOiA1CglSZWdpb24gMDogTWVtb3J5
IGF0IDkwMDAwMDAwMCAoNjQtYml0LCBwcmVmZXRjaGFibGUpIFtzaXplPTRHXQoJUmVnaW9uIDI6
IE1lbW9yeSBhdCBhMDAwMDAwMDAgKDY0LWJpdCwgcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yTV0KCVJl
Z2lvbiA0OiBJL08gcG9ydHMgYXQgMjAwMCBbc2l6ZT0yNTZdCglSZWdpb24gNTogTWVtb3J5IGF0
IDgwMDAwMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTI1NktdCglFeHBhbnNp
b24gUk9NIGF0IDgwMDYwMDAwIFtkaXNhYmxlZF0gW3NpemU9MTI4S10KCUNhcGFiaWxpdGllczog
WzQ4XSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IExlbj0wOCA8Pz4KCUNhcGFiaWxpdGll
czogWzUwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0g
RDErIEQyKyBBdXhDdXJyZW50PTBtQSBQTUUoRDAtLEQxKyxEMissRDNob3QrLEQzY29sZCspCgkJ
U3RhdHVzOiBEMCBOb1NvZnRSc3QrIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglD
YXBhYmlsaXRpZXM6IFs1OF0gRXhwcmVzcyAodjIpIExlZ2FjeSBFbmRwb2ludCwgTVNJIDAwCgkJ
RGV2Q2FwOglNYXhQYXlsb2FkIDI1NiBieXRlcywgUGhhbnRGdW5jIDAsIExhdGVuY3kgTDBzIDw0
dXMsIEwxIHVubGltaXRlZAoJCQlFeHRUYWcrIEF0dG5CdG4tIEF0dG5JbmQtIFB3ckluZC0gUkJF
KyBGTFJlc2V0LQoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1
cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFnKyBQaGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9vcCsKCQkJ
TWF4UGF5bG9hZCAxMjggYnl0ZXMsIE1heFJlYWRSZXEgNTEyIGJ5dGVzCgkJRGV2U3RhOglDb3Jy
RXJyKyBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxKyBBdXhQd3ItIFRyYW5zUGVuZC0K
CQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDhHVC9zLCBXaWR0aCB4MTYsIEFTUE0gTDEsIEV4aXQg
TGF0ZW5jeSBMMSA8MXVzCgkJCUNsb2NrUE0tIFN1cnByaXNlLSBMTEFjdFJlcC0gQndOb3QtIEFT
UE1PcHRDb21wKwoJCUxua0N0bDoJQVNQTSBEaXNhYmxlZDsgUkNCIDY0IGJ5dGVzLCBEaXNhYmxl
ZC0gQ29tbUNsaysKCQkJRXh0U3luY2gtIENsb2NrUE0tIEF1dFdpZERpcy0gQldJbnQtIEF1dEJX
SW50LQoJCUxua1N0YToJU3BlZWQgMi41R1QvcyAoZG93bmdyYWRlZCksIFdpZHRoIHg0IChkb3du
Z3JhZGVkKQoJCQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlLSBCV01nbXQtIEFCV01n
bXQtCgkJRGV2Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBOb3QgU3VwcG9ydGVkLCBUaW1lb3V0
RGlzLSBOUk9QclByUC0gTFRSKwoJCQkgMTBCaXRUYWdDb21wLSAxMEJpdFRhZ1JlcS0gT0JGRiBO
b3QgU3VwcG9ydGVkLCBFeHRGbXQrIEVFVExQUHJlZml4KywgTWF4RUVUTFBQcmVmaXhlcyAxCgkJ
CSBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvbiBOb3QgU3VwcG9ydGVkLCBFbWVyZ2VuY3lQb3dlclJl
ZHVjdGlvbkluaXQtCgkJCSBGUlMtCgkJCSBBdG9taWNPcHNDYXA6IDMyYml0KyA2NGJpdCsgMTI4
Yml0Q0FTLQoJCURldkN0bDI6IENvbXBsZXRpb24gVGltZW91dDogNTB1cyB0byA1MG1zLCBUaW1l
b3V0RGlzLSBMVFIrIE9CRkYgRGlzYWJsZWQsCgkJCSBBdG9taWNPcHNDdGw6IFJlcUVuLQoJCUxu
a0NhcDI6IFN1cHBvcnRlZCBMaW5rIFNwZWVkczogMi41LThHVC9zLCBDcm9zc2xpbmstIFJldGlt
ZXItIDJSZXRpbWVycy0gRFJTLQoJCUxua0N0bDI6IFRhcmdldCBMaW5rIFNwZWVkOiA4R1Qvcywg
RW50ZXJDb21wbGlhbmNlLSBTcGVlZERpcy0KCQkJIFRyYW5zbWl0IE1hcmdpbjogTm9ybWFsIE9w
ZXJhdGluZyBSYW5nZSwgRW50ZXJNb2RpZmllZENvbXBsaWFuY2UtIENvbXBsaWFuY2VTT1MtCgkJ
CSBDb21wbGlhbmNlIERlLWVtcGhhc2lzOiAtNmRCCgkJTG5rU3RhMjogQ3VycmVudCBEZS1lbXBo
YXNpcyBMZXZlbDogLTMuNWRCLCBFcXVhbGl6YXRpb25Db21wbGV0ZSsgRXF1YWxpemF0aW9uUGhh
c2UxKwoJCQkgRXF1YWxpemF0aW9uUGhhc2UyKyBFcXVhbGl6YXRpb25QaGFzZTMrIExpbmtFcXVh
bGl6YXRpb25SZXF1ZXN0KwoJCQkgUmV0aW1lci0gMlJldGltZXJzLSBDcm9zc2xpbmtSZXM6IHVu
c3VwcG9ydGVkCglDYXBhYmlsaXRpZXM6IFthMF0gTVNJOiBFbmFibGUrIENvdW50PTEvMSBNYXNr
YWJsZS0gNjRiaXQrCgkJQWRkcmVzczogMDAwMDAwMDBmZWUwMDAwMCAgRGF0YTogMDAwMAoJQ2Fw
YWJpbGl0aWVzOiBbMTAwIHYxXSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IElEPTAwMDEg
UmV2PTEgTGVuPTAxMCA8Pz4KCUNhcGFiaWxpdGllczogWzE1MCB2Ml0gQWR2YW5jZWQgRXJyb3Ig
UmVwb3J0aW5nCgkJVUVTdGE6CURMUC0gU0RFUy0gVExQLSBGQ1AtIENtcGx0VE8tIENtcGx0QWJy
dC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZUTFAtIEVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sLQoJCVVF
TXNrOglETFAtIFNERVMtIFRMUC0gRkNQLSBDbXBsdFRPLSBDbXBsdEFicnQtIFVueENtcGx0LSBS
eE9GLSBNYWxmVExQLSBFQ1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0KCQlVRVN2cnQ6CURMUCsgU0RF
UysgVExQLSBGQ1ArIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YrIE1hbGZUTFAr
IEVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sLQoJCUNFU3RhOglSeEVyci0gQmFkVExQLSBCYWRETExQ
LSBSb2xsb3Zlci0gVGltZW91dC0gQWR2Tm9uRmF0YWxFcnIrCgkJQ0VNc2s6CVJ4RXJyLSBCYWRU
TFAtIEJhZERMTFAtIFJvbGxvdmVyLSBUaW1lb3V0LSBBZHZOb25GYXRhbEVycisKCQlBRVJDYXA6
CUZpcnN0IEVycm9yIFBvaW50ZXI6IDAwLCBFQ1JDR2VuQ2FwKyBFQ1JDR2VuRW4tIEVDUkNDaGtD
YXArIEVDUkNDaGtFbi0KCQkJTXVsdEhkclJlY0NhcC0gTXVsdEhkclJlY0VuLSBUTFBQZnhQcmVz
LSBIZHJMb2dDYXAtCgkJSGVhZGVyTG9nOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MDAwMAoJQ2FwYWJpbGl0aWVzOiBbMjAwIHYxXSBQaHlzaWNhbCBSZXNpemFibGUgQkFSCgkJQkFS
IDA6IGN1cnJlbnQgc2l6ZTogNEdCLCBzdXBwb3J0ZWQ6IDI1Nk1CIDUxMk1CIDFHQiAyR0IgNEdC
CglDYXBhYmlsaXRpZXM6IFsyNzAgdjFdIFNlY29uZGFyeSBQQ0kgRXhwcmVzcwoJCUxua0N0bDM6
IExua0VxdUludHJydXB0RW4tIFBlcmZvcm1FcXUtCgkJTGFuZUVyclN0YXQ6IDAKCUNhcGFiaWxp
dGllczogWzJiMCB2MV0gQWRkcmVzcyBUcmFuc2xhdGlvbiBTZXJ2aWNlIChBVFMpCgkJQVRTQ2Fw
OglJbnZhbGlkYXRlIFF1ZXVlIERlcHRoOiAwMAoJCUFUU0N0bDoJRW5hYmxlLSwgU21hbGxlc3Qg
VHJhbnNsYXRpb24gVW5pdDogMDAKCUNhcGFiaWxpdGllczogWzJjMCB2MV0gUGFnZSBSZXF1ZXN0
IEludGVyZmFjZSAoUFJJKQoJCVBSSUN0bDogRW5hYmxlKyBSZXNldC0KCQlQUklTdGE6IFJGLSBV
UFJHSS0gU3RvcHBlZCsKCQlQYWdlIFJlcXVlc3QgQ2FwYWNpdHk6IDAwMDAwMDIwLCBQYWdlIFJl
cXVlc3QgQWxsb2NhdGlvbjogMDAwMDAwMjAKCUNhcGFiaWxpdGllczogWzJkMCB2MV0gUHJvY2Vz
cyBBZGRyZXNzIFNwYWNlIElEIChQQVNJRCkKCQlQQVNJRENhcDogRXhlYysgUHJpdissIE1heCBQ
QVNJRCBXaWR0aDogMTAKCQlQQVNJREN0bDogRW5hYmxlLSBFeGVjLSBQcml2LQoJQ2FwYWJpbGl0
aWVzOiBbMzIwIHYxXSBMYXRlbmN5IFRvbGVyYW5jZSBSZXBvcnRpbmcKCQlNYXggc25vb3AgbGF0
ZW5jeTogMG5zCgkJTWF4IG5vIHNub29wIGxhdGVuY3k6IDBucwoJQ2FwYWJpbGl0aWVzOiBbMzI4
IHYxXSBBbHRlcm5hdGl2ZSBSb3V0aW5nLUlEIEludGVycHJldGF0aW9uIChBUkkpCgkJQVJJQ2Fw
OglNRlZDLSBBQ1MtLCBOZXh0IEZ1bmN0aW9uOiAxCgkJQVJJQ3RsOglNRlZDLSBBQ1MtLCBGdW5j
dGlvbiBHcm91cDogMAoJQ2FwYWJpbGl0aWVzOiBbMzcwIHYxXSBMMSBQTSBTdWJzdGF0ZXMKCQlM
MVN1YkNhcDogUENJLVBNX0wxLjIrIFBDSS1QTV9MMS4xKyBBU1BNX0wxLjIrIEFTUE1fTDEuMSsg
TDFfUE1fU3Vic3RhdGVzKwoJCQkgIFBvcnRDb21tb25Nb2RlUmVzdG9yZVRpbWU9MHVzIFBvcnRU
UG93ZXJPblRpbWU9MTcwdXMKCQlMMVN1YkN0bDE6IFBDSS1QTV9MMS4yLSBQQ0ktUE1fTDEuMS0g
QVNQTV9MMS4yLSBBU1BNX0wxLjEtCgkJCSAgIFRfQ29tbW9uTW9kZT0wdXMgTFRSMS4yX1RocmVz
aG9sZD0wbnMKCQlMMVN1YkN0bDI6IFRfUHdyT249MTB1cwoJS2VybmVsIGRyaXZlciBpbiB1c2U6
IGFtZGdwdQoJS2VybmVsIG1vZHVsZXM6IGFtZGdwdQoKMDU6MDAuMSBBdWRpbyBkZXZpY2U6IEFk
dmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRC9BVEldIEVsbGVzbWVyZSBIRE1JIEF1ZGlv
IFtSYWRlb24gUlggNDcwLzQ4MCAvIDU3MC81ODAvNTkwXQoJU3Vic3lzdGVtOiBTYXBwaGlyZSBU
ZWNobm9sb2d5IExpbWl0ZWQgRWxsZXNtZXJlIEhETUkgQXVkaW8gW1JhZGVvbiBSWCA0NzAvNDgw
IC8gNTcwLzU4MC81OTBdCglDb250cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUt
IE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJ
TlR4KwoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZh
c3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5j
eTogMCwgQ2FjaGUgTGluZSBTaXplOiAzMiBieXRlcwoJSW50ZXJydXB0OiBwaW4gQiByb3V0ZWQg
dG8gSVJRIDkzCglJT01NVSBncm91cDogNQoJUmVnaW9uIDA6IE1lbW9yeSBhdCA4MDA0MDAwMCAo
NjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xNktdCglDYXBhYmlsaXRpZXM6IFs0OF0g
VmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBMZW49MDggPD8+CglDYXBhYmlsaXRpZXM6IFs1
MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxKyBE
MisgQXV4Q3VycmVudD0wbUEgUE1FKEQwLSxEMS0sRDItLEQzaG90LSxEM2NvbGQtKQoJCVN0YXR1
czogRDAgTm9Tb2Z0UnN0KyBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJQ2FwYWJp
bGl0aWVzOiBbNThdIEV4cHJlc3MgKHYyKSBMZWdhY3kgRW5kcG9pbnQsIE1TSSAwMAoJCURldkNh
cDoJTWF4UGF5bG9hZCAyNTYgYnl0ZXMsIFBoYW50RnVuYyAwLCBMYXRlbmN5IEwwcyA8NHVzLCBM
MSB1bmxpbWl0ZWQKCQkJRXh0VGFnKyBBdHRuQnRuLSBBdHRuSW5kLSBQd3JJbmQtIFJCRSsgRkxS
ZXNldC0KCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXEt
CgkJCVJseGRPcmQrIEV4dFRhZysgUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25vb3ArCgkJCU1heFBh
eWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDUxMiBieXRlcwoJCURldlN0YToJQ29yckVycisg
Tm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcSsgQXV4UHdyLSBUcmFuc1BlbmQtCgkJTG5r
Q2FwOglQb3J0ICMwLCBTcGVlZCA4R1QvcywgV2lkdGggeDE2LCBBU1BNIEwxLCBFeGl0IExhdGVu
Y3kgTDEgPDF1cwoJCQlDbG9ja1BNLSBTdXJwcmlzZS0gTExBY3RSZXAtIEJ3Tm90LSBBU1BNT3B0
Q29tcCsKCQlMbmtDdGw6CUFTUE0gRGlzYWJsZWQ7IFJDQiA2NCBieXRlcywgRGlzYWJsZWQtIENv
bW1DbGsrCgkJCUV4dFN5bmNoLSBDbG9ja1BNLSBBdXRXaWREaXMtIEJXSW50LSBBdXRCV0ludC0K
CQlMbmtTdGE6CVNwZWVkIDIuNUdUL3MgKGRvd25ncmFkZWQpLCBXaWR0aCB4NCAoZG93bmdyYWRl
ZCkKCQkJVHJFcnItIFRyYWluLSBTbG90Q2xrKyBETEFjdGl2ZS0gQldNZ210LSBBQldNZ210LQoJ
CURldkNhcDI6IENvbXBsZXRpb24gVGltZW91dDogTm90IFN1cHBvcnRlZCwgVGltZW91dERpcy0g
TlJPUHJQclAtIExUUisKCQkJIDEwQml0VGFnQ29tcC0gMTBCaXRUYWdSZXEtIE9CRkYgTm90IFN1
cHBvcnRlZCwgRXh0Rm10KyBFRVRMUFByZWZpeCssIE1heEVFVExQUHJlZml4ZXMgMQoJCQkgRW1l
cmdlbmN5UG93ZXJSZWR1Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rp
b25Jbml0LQoJCQkgRlJTLQoJCQkgQXRvbWljT3BzQ2FwOiAzMmJpdCsgNjRiaXQrIDEyOGJpdENB
Uy0KCQlEZXZDdGwyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IDUwdXMgdG8gNTBtcywgVGltZW91dERp
cy0gTFRSLSBPQkZGIERpc2FibGVkLAoJCQkgQXRvbWljT3BzQ3RsOiBSZXFFbi0KCQlMbmtTdGEy
OiBDdXJyZW50IERlLWVtcGhhc2lzIExldmVsOiAtMy41ZEIsIEVxdWFsaXphdGlvbkNvbXBsZXRl
LSBFcXVhbGl6YXRpb25QaGFzZTEtCgkJCSBFcXVhbGl6YXRpb25QaGFzZTItIEVxdWFsaXphdGlv
blBoYXNlMy0gTGlua0VxdWFsaXphdGlvblJlcXVlc3QtCgkJCSBSZXRpbWVyLSAyUmV0aW1lcnMt
IENyb3NzbGlua1JlczogdW5zdXBwb3J0ZWQKCUNhcGFiaWxpdGllczogW2EwXSBNU0k6IEVuYWJs
ZSsgQ291bnQ9MS8xIE1hc2thYmxlLSA2NGJpdCsKCQlBZGRyZXNzOiAwMDAwMDAwMGZlZTAwMDAw
ICBEYXRhOiAwMDAwCglDYXBhYmlsaXRpZXM6IFsxMDAgdjFdIFZlbmRvciBTcGVjaWZpYyBJbmZv
cm1hdGlvbjogSUQ9MDAwMSBSZXY9MSBMZW49MDEwIDw/PgoJQ2FwYWJpbGl0aWVzOiBbMTUwIHYy
XSBBZHZhbmNlZCBFcnJvciBSZXBvcnRpbmcKCQlVRVN0YToJRExQLSBTREVTLSBUTFAtIEZDUC0g
Q21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhPRi0gTWFsZlRMUC0gRUNSQy0gVW5zdXBS
ZXEtIEFDU1Zpb2wtCgkJVUVNc2s6CURMUC0gU0RFUy0gVExQLSBGQ1AtIENtcGx0VE8tIENtcGx0
QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZUTFAtIEVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sLQoJ
CVVFU3ZydDoJRExQKyBTREVTKyBUTFAtIEZDUCsgQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBs
dC0gUnhPRisgTWFsZlRMUCsgRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wtCgkJQ0VTdGE6CVJ4RXJy
LSBCYWRUTFAtIEJhZERMTFAtIFJvbGxvdmVyLSBUaW1lb3V0LSBBZHZOb25GYXRhbEVycisKCQlD
RU1zazoJUnhFcnItIEJhZFRMUC0gQmFkRExMUC0gUm9sbG92ZXItIFRpbWVvdXQtIEFkdk5vbkZh
dGFsRXJyKwoJCUFFUkNhcDoJRmlyc3QgRXJyb3IgUG9pbnRlcjogMDAsIEVDUkNHZW5DYXArIEVD
UkNHZW5Fbi0gRUNSQ0Noa0NhcCsgRUNSQ0Noa0VuLQoJCQlNdWx0SGRyUmVjQ2FwLSBNdWx0SGRy
UmVjRW4tIFRMUFBmeFByZXMtIEhkckxvZ0NhcC0KCQlIZWFkZXJMb2c6IDAwMDAwMDAwIDAwMDAw
MDAwIDAwMDAwMDAwIDAwMDAwMDAwCglDYXBhYmlsaXRpZXM6IFszMjggdjFdIEFsdGVybmF0aXZl
IFJvdXRpbmctSUQgSW50ZXJwcmV0YXRpb24gKEFSSSkKCQlBUklDYXA6CU1GVkMtIEFDUy0sIE5l
eHQgRnVuY3Rpb246IDAKCQlBUklDdGw6CU1GVkMtIEFDUy0sIEZ1bmN0aW9uIEdyb3VwOiAwCglL
ZXJuZWwgZHJpdmVyIGluIHVzZTogc25kX2hkYV9pbnRlbAoJS2VybmVsIG1vZHVsZXM6IHNuZF9o
ZGFfaW50ZWwKCjMzOjAwLjAgVkdBIGNvbXBhdGlibGUgY29udHJvbGxlcjogQWR2YW5jZWQgTWlj
cm8gRGV2aWNlcywgSW5jLiBbQU1EL0FUSV0gUmVtYnJhbmR0IChyZXYgZDEpIChwcm9nLWlmIDAw
IFtWR0EgY29udHJvbGxlcl0pCglTdWJzeXN0ZW06IExlbm92byBEZXZpY2UgNTBiNAoJQ29udHJv
bDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFy
RXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2Nk1I
ei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxN
QWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAsIENhY2hlIExpbmUgU2l6ZTog
MzIgYnl0ZXMKCUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSA0NwoJSU9NTVUgZ3JvdXA6
IDEzCglSZWdpb24gMDogTWVtb3J5IGF0IDhlMDAwMDAwMCAoNjQtYml0LCBwcmVmZXRjaGFibGUp
IFtzaXplPTI1Nk1dCglSZWdpb24gMjogTWVtb3J5IGF0IDhmMDAwMDAwMCAoNjQtYml0LCBwcmVm
ZXRjaGFibGUpIFtzaXplPTJNXQoJUmVnaW9uIDQ6IEkvTyBwb3J0cyBhdCAxMDAwIFtzaXplPTI1
Nl0KCVJlZ2lvbiA1OiBNZW1vcnkgYXQgOTg5MDAwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJs
ZSkgW3NpemU9NTEyS10KCUNhcGFiaWxpdGllczogWzQ4XSBWZW5kb3IgU3BlY2lmaWMgSW5mb3Jt
YXRpb246IExlbj0wOCA8Pz4KCUNhcGFiaWxpdGllczogWzUwXSBQb3dlciBNYW5hZ2VtZW50IHZl
cnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUo
RDAtLEQxKyxEMissRDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QtIFBNRS1F
bmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRpZXM6IFs2NF0gRXhwcmVzcyAo
djIpIExlZ2FjeSBFbmRwb2ludCwgTVNJIDAwCgkJRGV2Q2FwOglNYXhQYXlsb2FkIDI1NiBieXRl
cywgUGhhbnRGdW5jIDAsIExhdGVuY3kgTDBzIDw0dXMsIEwxIHVubGltaXRlZAoJCQlFeHRUYWcr
IEF0dG5CdG4tIEF0dG5JbmQtIFB3ckluZC0gUkJFKyBGTFJlc2V0LQoJCURldkN0bDoJQ29yckVy
ci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFnKyBQ
aGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9vcCsKCQkJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIE1heFJl
YWRSZXEgNTEyIGJ5dGVzCgkJRGV2U3RhOglDb3JyRXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnIt
IFVuc3VwUmVxLSBBdXhQd3ItIFRyYW5zUGVuZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDE2
R1QvcywgV2lkdGggeDE2LCBBU1BNIEwwcyBMMSwgRXhpdCBMYXRlbmN5IEwwcyA8NjRucywgTDEg
PDF1cwoJCQlDbG9ja1BNLSBTdXJwcmlzZS0gTExBY3RSZXAtIEJ3Tm90LSBBU1BNT3B0Q29tcCsK
CQlMbmtDdGw6CUFTUE0gRGlzYWJsZWQ7IFJDQiA2NCBieXRlcywgRGlzYWJsZWQtIENvbW1DbGsr
CgkJCUV4dFN5bmNoLSBDbG9ja1BNLSBBdXRXaWREaXMtIEJXSW50LSBBdXRCV0ludC0KCQlMbmtT
dGE6CVNwZWVkIDE2R1QvcyAob2spLCBXaWR0aCB4MTYgKG9rKQoJCQlUckVyci0gVHJhaW4tIFNs
b3RDbGsrIERMQWN0aXZlLSBCV01nbXQtIEFCV01nbXQtCgkJRGV2Q2FwMjogQ29tcGxldGlvbiBU
aW1lb3V0OiBSYW5nZSBBQkNELCBUaW1lb3V0RGlzKyBOUk9QclByUC0gTFRSLQoJCQkgMTBCaXRU
YWdDb21wKyAxMEJpdFRhZ1JlcS0gT0JGRiBOb3QgU3VwcG9ydGVkLCBFeHRGbXQrIEVFVExQUHJl
Zml4KywgTWF4RUVUTFBQcmVmaXhlcyAxCgkJCSBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvbiBOb3Qg
U3VwcG9ydGVkLCBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvbkluaXQtCgkJCSBGUlMtCgkJCSBBdG9t
aWNPcHNDYXA6IDMyYml0KyA2NGJpdCsgMTI4Yml0Q0FTLQoJCURldkN0bDI6IENvbXBsZXRpb24g
VGltZW91dDogNTB1cyB0byA1MG1zLCBUaW1lb3V0RGlzLSBMVFItIE9CRkYgRGlzYWJsZWQsCgkJ
CSBBdG9taWNPcHNDdGw6IFJlcUVuKwoJCUxua0NhcDI6IFN1cHBvcnRlZCBMaW5rIFNwZWVkczog
Mi41LTE2R1QvcywgQ3Jvc3NsaW5rLSBSZXRpbWVyKyAyUmV0aW1lcnMrIERSUy0KCQlMbmtDdGwy
OiBUYXJnZXQgTGluayBTcGVlZDogMTZHVC9zLCBFbnRlckNvbXBsaWFuY2UtIFNwZWVkRGlzLQoJ
CQkgVHJhbnNtaXQgTWFyZ2luOiBOb3JtYWwgT3BlcmF0aW5nIFJhbmdlLCBFbnRlck1vZGlmaWVk
Q29tcGxpYW5jZS0gQ29tcGxpYW5jZVNPUy0KCQkJIENvbXBsaWFuY2UgRGUtZW1waGFzaXM6IC02
ZEIKCQlMbmtTdGEyOiBDdXJyZW50IERlLWVtcGhhc2lzIExldmVsOiAtMy41ZEIsIEVxdWFsaXph
dGlvbkNvbXBsZXRlKyBFcXVhbGl6YXRpb25QaGFzZTErCgkJCSBFcXVhbGl6YXRpb25QaGFzZTIr
IEVxdWFsaXphdGlvblBoYXNlMysgTGlua0VxdWFsaXphdGlvblJlcXVlc3QtCgkJCSBSZXRpbWVy
LSAyUmV0aW1lcnMtIENyb3NzbGlua1JlczogdW5zdXBwb3J0ZWQKCUNhcGFiaWxpdGllczogW2Ew
XSBNU0k6IEVuYWJsZS0gQ291bnQ9MS80IE1hc2thYmxlLSA2NGJpdCsKCQlBZGRyZXNzOiAwMDAw
MDAwMDAwMDAwMDAwICBEYXRhOiAwMDAwCglDYXBhYmlsaXRpZXM6IFtjMF0gTVNJLVg6IEVuYWJs
ZSsgQ291bnQ9NCBNYXNrZWQtCgkJVmVjdG9yIHRhYmxlOiBCQVI9NSBvZmZzZXQ9MDAwNDIwMDAK
CQlQQkE6IEJBUj01IG9mZnNldD0wMDA0MzAwMAoJQ2FwYWJpbGl0aWVzOiBbMTAwIHYxXSBWZW5k
b3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IElEPTAwMDEgUmV2PTEgTGVuPTAxMCA8Pz4KCUNhcGFi
aWxpdGllczogWzI3MCB2MV0gU2Vjb25kYXJ5IFBDSSBFeHByZXNzCgkJTG5rQ3RsMzogTG5rRXF1
SW50cnJ1cHRFbi0gUGVyZm9ybUVxdS0KCQlMYW5lRXJyU3RhdDogMAoJQ2FwYWJpbGl0aWVzOiBb
MmEwIHYxXSBBY2Nlc3MgQ29udHJvbCBTZXJ2aWNlcwoJCUFDU0NhcDoJU3JjVmFsaWQtIFRyYW5z
QmxrLSBSZXFSZWRpci0gQ21wbHRSZWRpci0gVXBzdHJlYW1Gd2QtIEVncmVzc0N0cmwtIERpcmVj
dFRyYW5zLQoJCUFDU0N0bDoJU3JjVmFsaWQtIFRyYW5zQmxrLSBSZXFSZWRpci0gQ21wbHRSZWRp
ci0gVXBzdHJlYW1Gd2QtIEVncmVzc0N0cmwtIERpcmVjdFRyYW5zLQoJQ2FwYWJpbGl0aWVzOiBb
MmIwIHYxXSBBZGRyZXNzIFRyYW5zbGF0aW9uIFNlcnZpY2UgKEFUUykKCQlBVFNDYXA6CUludmFs
aWRhdGUgUXVldWUgRGVwdGg6IDAwCgkJQVRTQ3RsOglFbmFibGUrLCBTbWFsbGVzdCBUcmFuc2xh
dGlvbiBVbml0OiAwMAoJQ2FwYWJpbGl0aWVzOiBbMmMwIHYxXSBQYWdlIFJlcXVlc3QgSW50ZXJm
YWNlIChQUkkpCgkJUFJJQ3RsOiBFbmFibGUrIFJlc2V0LQoJCVBSSVN0YTogUkYtIFVQUkdJLSBT
dG9wcGVkKwoJCVBhZ2UgUmVxdWVzdCBDYXBhY2l0eTogMDAwMDAxMDAsIFBhZ2UgUmVxdWVzdCBB
bGxvY2F0aW9uOiAwMDAwMDAyMAoJQ2FwYWJpbGl0aWVzOiBbMmQwIHYxXSBQcm9jZXNzIEFkZHJl
c3MgU3BhY2UgSUQgKFBBU0lEKQoJCVBBU0lEQ2FwOiBFeGVjKyBQcml2KywgTWF4IFBBU0lEIFdp
ZHRoOiAxMAoJCVBBU0lEQ3RsOiBFbmFibGUrIEV4ZWMtIFByaXYtCglDYXBhYmlsaXRpZXM6IFs0
MTAgdjFdIFBoeXNpY2FsIExheWVyIDE2LjAgR1QvcyA8Pz4KCUNhcGFiaWxpdGllczogWzQ1MCB2
MV0gTGFuZSBNYXJnaW5pbmcgYXQgdGhlIFJlY2VpdmVyIDw/PgoJS2VybmVsIGRyaXZlciBpbiB1
c2U6IGFtZGdwdQoJS2VybmVsIG1vZHVsZXM6IGFtZGdwdQoKMzM6MDAuMSBBdWRpbyBkZXZpY2U6
IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRC9BVEldIERldmljZSAxNjQwCglTdWJz
eXN0ZW06IExlbm92byBEZXZpY2UgNTBiNAoJQ29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3Rlcisg
U3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFz
dEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnIt
IERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5U
eC0KCUxhdGVuY3k6IDAsIENhY2hlIExpbmUgU2l6ZTogMzIgYnl0ZXMKCUludGVycnVwdDogcGlu
IEIgcm91dGVkIHRvIElSUSA5NAoJSU9NTVUgZ3JvdXA6IDE0CglSZWdpb24gMDogTWVtb3J5IGF0
IDk4OWM4MDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTE2S10KCUNhcGFiaWxp
dGllczogWzQ4XSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IExlbj0wOCA8Pz4KCUNhcGFi
aWxpdGllczogWzUwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGst
IERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUoRDAtLEQxKyxEMissRDNob3QrLEQzY29s
ZCspCgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQ
TUUtCglDYXBhYmlsaXRpZXM6IFs2NF0gRXhwcmVzcyAodjIpIExlZ2FjeSBFbmRwb2ludCwgTVNJ
IDAwCgkJRGV2Q2FwOglNYXhQYXlsb2FkIDI1NiBieXRlcywgUGhhbnRGdW5jIDAsIExhdGVuY3kg
TDBzIDw0dXMsIEwxIHVubGltaXRlZAoJCQlFeHRUYWcrIEF0dG5CdG4tIEF0dG5JbmQtIFB3cklu
ZC0gUkJFKyBGTFJlc2V0LQoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJy
LSBVbnN1cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFnKyBQaGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9v
cCsKCQkJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIE1heFJlYWRSZXEgNTEyIGJ5dGVzCgkJRGV2U3Rh
OglDb3JyRXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLSBBdXhQd3ItIFRyYW5z
UGVuZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDE2R1QvcywgV2lkdGggeDE2LCBBU1BNIEww
cyBMMSwgRXhpdCBMYXRlbmN5IEwwcyA8NjRucywgTDEgPDF1cwoJCQlDbG9ja1BNLSBTdXJwcmlz
ZS0gTExBY3RSZXAtIEJ3Tm90LSBBU1BNT3B0Q29tcCsKCQlMbmtDdGw6CUFTUE0gRGlzYWJsZWQ7
IFJDQiA2NCBieXRlcywgRGlzYWJsZWQtIENvbW1DbGsrCgkJCUV4dFN5bmNoLSBDbG9ja1BNLSBB
dXRXaWREaXMtIEJXSW50LSBBdXRCV0ludC0KCQlMbmtTdGE6CVNwZWVkIDE2R1QvcyAob2spLCBX
aWR0aCB4MTYgKG9rKQoJCQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlLSBCV01nbXQt
IEFCV01nbXQtCgkJRGV2Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBSYW5nZSBBQkNELCBUaW1l
b3V0RGlzKyBOUk9QclByUC0gTFRSLQoJCQkgMTBCaXRUYWdDb21wKyAxMEJpdFRhZ1JlcS0gT0JG
RiBOb3QgU3VwcG9ydGVkLCBFeHRGbXQrIEVFVExQUHJlZml4KywgTWF4RUVUTFBQcmVmaXhlcyAx
CgkJCSBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvbiBOb3QgU3VwcG9ydGVkLCBFbWVyZ2VuY3lQb3dl
clJlZHVjdGlvbkluaXQtCgkJCSBGUlMtCgkJCSBBdG9taWNPcHNDYXA6IDMyYml0LSA2NGJpdC0g
MTI4Yml0Q0FTLQoJCURldkN0bDI6IENvbXBsZXRpb24gVGltZW91dDogNTB1cyB0byA1MG1zLCBU
aW1lb3V0RGlzLSBMVFItIE9CRkYgRGlzYWJsZWQsCgkJCSBBdG9taWNPcHNDdGw6IFJlcUVuKwoJ
CUxua1N0YTI6IEN1cnJlbnQgRGUtZW1waGFzaXMgTGV2ZWw6IC0zLjVkQiwgRXF1YWxpemF0aW9u
Q29tcGxldGUtIEVxdWFsaXphdGlvblBoYXNlMS0KCQkJIEVxdWFsaXphdGlvblBoYXNlMi0gRXF1
YWxpemF0aW9uUGhhc2UzLSBMaW5rRXF1YWxpemF0aW9uUmVxdWVzdC0KCQkJIFJldGltZXItIDJS
ZXRpbWVycy0gQ3Jvc3NsaW5rUmVzOiB1bnN1cHBvcnRlZAoJQ2FwYWJpbGl0aWVzOiBbYTBdIE1T
STogRW5hYmxlKyBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0KwoJCUFkZHJlc3M6IDAwMDAwMDAw
ZmVlMDAwMDAgIERhdGE6IDAwMDAKCUNhcGFiaWxpdGllczogWzEwMCB2MV0gVmVuZG9yIFNwZWNp
ZmljIEluZm9ybWF0aW9uOiBJRD0wMDAxIFJldj0xIExlbj0wMTAgPD8+CglDYXBhYmlsaXRpZXM6
IFsyYTAgdjFdIEFjY2VzcyBDb250cm9sIFNlcnZpY2VzCgkJQUNTQ2FwOglTcmNWYWxpZC0gVHJh
bnNCbGstIFJlcVJlZGlyLSBDbXBsdFJlZGlyLSBVcHN0cmVhbUZ3ZC0gRWdyZXNzQ3RybC0gRGly
ZWN0VHJhbnMtCgkJQUNTQ3RsOglTcmNWYWxpZC0gVHJhbnNCbGstIFJlcVJlZGlyLSBDbXBsdFJl
ZGlyLSBVcHN0cmVhbUZ3ZC0gRWdyZXNzQ3RybC0gRGlyZWN0VHJhbnMtCglLZXJuZWwgZHJpdmVy
IGluIHVzZTogc25kX2hkYV9pbnRlbAoJS2VybmVsIG1vZHVsZXM6IHNuZF9oZGFfaW50ZWwKCjMz
OjAwLjIgRW5jcnlwdGlvbiBjb250cm9sbGVyOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMu
IFtBTURdIFZhbkdvZ2ggUFNQL0NDUAoJU3Vic3lzdGVtOiBMZW5vdm8gVmFuR29naCBQU1AvQ0NQ
CglDb250cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNu
b29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVzOiBD
YXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRB
Ym9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMCwgQ2FjaGUgTGlu
ZSBTaXplOiAzMiBieXRlcwoJSW50ZXJydXB0OiBwaW4gQyByb3V0ZWQgdG8gSVJRIDI0CglJT01N
VSBncm91cDogMTUKCVJlZ2lvbiAyOiBNZW1vcnkgYXQgOTg4MDAwMDAgKDMyLWJpdCwgbm9uLXBy
ZWZldGNoYWJsZSkgW3NpemU9MU1dCglSZWdpb24gNTogTWVtb3J5IGF0IDk4OWNjMDAwICgzMi1i
aXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPThLXQoJQ2FwYWJpbGl0aWVzOiBbNDhdIFZlbmRv
ciBTcGVjaWZpYyBJbmZvcm1hdGlvbjogTGVuPTA4IDw/PgoJQ2FwYWJpbGl0aWVzOiBbNTBdIFBv
d2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzCgkJRmxhZ3M6IFBNRUNsay0gRFNJLSBEMS0gRDItIEF1
eEN1cnJlbnQ9MG1BIFBNRShEMC0sRDEtLEQyLSxEM2hvdC0sRDNjb2xkLSkKCQlTdGF0dXM6IEQw
IE5vU29mdFJzdCsgUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGll
czogWzY0XSBFeHByZXNzICh2MikgRW5kcG9pbnQsIE1TSSAwMAoJCURldkNhcDoJTWF4UGF5bG9h
ZCAyNTYgYnl0ZXMsIFBoYW50RnVuYyAwLCBMYXRlbmN5IEwwcyA8NHVzLCBMMSB1bmxpbWl0ZWQK
CQkJRXh0VGFnKyBBdHRuQnRuLSBBdHRuSW5kLSBQd3JJbmQtIFJCRSsgRkxSZXNldC0gU2xvdFBv
d2VyTGltaXQgMC4wMDBXCgkJRGV2Q3RsOglDb3JyRXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnIt
IFVuc3VwUmVxLQoJCQlSbHhkT3JkKyBFeHRUYWcrIFBoYW50RnVuYy0gQXV4UHdyLSBOb1Nub29w
KwoJCQlNYXhQYXlsb2FkIDEyOCBieXRlcywgTWF4UmVhZFJlcSA1MTIgYnl0ZXMKCQlEZXZTdGE6
CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXEtIEF1eFB3ci0gVHJhbnNQ
ZW5kLQoJCUxua0NhcDoJUG9ydCAjMCwgU3BlZWQgMTZHVC9zLCBXaWR0aCB4MTYsIEFTUE0gTDBz
IEwxLCBFeGl0IExhdGVuY3kgTDBzIDw2NG5zLCBMMSA8MXVzCgkJCUNsb2NrUE0tIFN1cnByaXNl
LSBMTEFjdFJlcC0gQndOb3QtIEFTUE1PcHRDb21wKwoJCUxua0N0bDoJQVNQTSBEaXNhYmxlZDsg
UkNCIDY0IGJ5dGVzLCBEaXNhYmxlZC0gQ29tbUNsaysKCQkJRXh0U3luY2gtIENsb2NrUE0tIEF1
dFdpZERpcy0gQldJbnQtIEF1dEJXSW50LQoJCUxua1N0YToJU3BlZWQgMTZHVC9zIChvayksIFdp
ZHRoIHgxNiAob2spCgkJCVRyRXJyLSBUcmFpbi0gU2xvdENsaysgRExBY3RpdmUtIEJXTWdtdC0g
QUJXTWdtdC0KCQlEZXZDYXAyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IFJhbmdlIEFCQ0QsIFRpbWVv
dXREaXMrIE5ST1ByUHJQLSBMVFItCgkJCSAxMEJpdFRhZ0NvbXArIDEwQml0VGFnUmVxLSBPQkZG
IE5vdCBTdXBwb3J0ZWQsIEV4dEZtdCsgRUVUTFBQcmVmaXgrLCBNYXhFRVRMUFByZWZpeGVzIDEK
CQkJIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uIE5vdCBTdXBwb3J0ZWQsIEVtZXJnZW5jeVBvd2Vy
UmVkdWN0aW9uSW5pdC0KCQkJIEZSUy0gVFBIQ29tcC0gRXh0VFBIQ29tcC0KCQkJIEF0b21pY09w
c0NhcDogMzJiaXQtIDY0Yml0LSAxMjhiaXRDQVMtCgkJRGV2Q3RsMjogQ29tcGxldGlvbiBUaW1l
b3V0OiA1MHVzIHRvIDUwbXMsIFRpbWVvdXREaXMtIExUUi0gT0JGRiBEaXNhYmxlZCwKCQkJIEF0
b21pY09wc0N0bDogUmVxRW4tCgkJTG5rU3RhMjogQ3VycmVudCBEZS1lbXBoYXNpcyBMZXZlbDog
LTMuNWRCLCBFcXVhbGl6YXRpb25Db21wbGV0ZS0gRXF1YWxpemF0aW9uUGhhc2UxLQoJCQkgRXF1
YWxpemF0aW9uUGhhc2UyLSBFcXVhbGl6YXRpb25QaGFzZTMtIExpbmtFcXVhbGl6YXRpb25SZXF1
ZXN0LQoJCQkgUmV0aW1lci0gMlJldGltZXJzLSBDcm9zc2xpbmtSZXM6IHVuc3VwcG9ydGVkCglD
YXBhYmlsaXRpZXM6IFthMF0gTVNJOiBFbmFibGUtIENvdW50PTEvMiBNYXNrYWJsZS0gNjRiaXQr
CgkJQWRkcmVzczogMDAwMDAwMDAwMDAwMDAwMCAgRGF0YTogMDAwMAoJQ2FwYWJpbGl0aWVzOiBb
YzBdIE1TSS1YOiBFbmFibGUrIENvdW50PTIgTWFza2VkLQoJCVZlY3RvciB0YWJsZTogQkFSPTUg
b2Zmc2V0PTAwMDAwMDAwCgkJUEJBOiBCQVI9NSBvZmZzZXQ9MDAwMDEwMDAKCUNhcGFiaWxpdGll
czogWzEwMCB2MV0gVmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBJRD0wMDAxIFJldj0xIExl
bj0wMTAgPD8+CglDYXBhYmlsaXRpZXM6IFsyYTAgdjFdIEFjY2VzcyBDb250cm9sIFNlcnZpY2Vz
CgkJQUNTQ2FwOglTcmNWYWxpZC0gVHJhbnNCbGstIFJlcVJlZGlyLSBDbXBsdFJlZGlyLSBVcHN0
cmVhbUZ3ZC0gRWdyZXNzQ3RybC0gRGlyZWN0VHJhbnMtCgkJQUNTQ3RsOglTcmNWYWxpZC0gVHJh
bnNCbGstIFJlcVJlZGlyLSBDbXBsdFJlZGlyLSBVcHN0cmVhbUZ3ZC0gRWdyZXNzQ3RybC0gRGly
ZWN0VHJhbnMtCglLZXJuZWwgZHJpdmVyIGluIHVzZTogY2NwCglLZXJuZWwgbW9kdWxlczogY2Nw
CgozMzowMC4zIFVTQiBjb250cm9sbGVyOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtB
TURdIERldmljZSAxNjFkIChwcm9nLWlmIDMwIFtYSENJXSkKCVN1YnN5c3RlbTogTGVub3ZvIERl
dmljZSA1MGI0CglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJ
TlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSKyBGYXN0QjJCLSBEaXNJTlR4KwoJ
U3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRB
Ym9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMCwg
Q2FjaGUgTGluZSBTaXplOiAzMiBieXRlcwoJSW50ZXJydXB0OiBwaW4gRCByb3V0ZWQgdG8gSVJR
IDQ2CglJT01NVSBncm91cDogMTYKCVJlZ2lvbiAwOiBNZW1vcnkgYXQgOTg2MDAwMDAgKDY0LWJp
dCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MU1dCglDYXBhYmlsaXRpZXM6IFs0OF0gVmVuZG9y
IFNwZWNpZmljIEluZm9ybWF0aW9uOiBMZW49MDggPD8+CglDYXBhYmlsaXRpZXM6IFs1MF0gUG93
ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4
Q3VycmVudD0wbUEgUE1FKEQwKyxEMS0sRDItLEQzaG90KyxEM2NvbGQrKQoJCVN0YXR1czogRDAg
Tm9Tb2Z0UnN0LSBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJQ2FwYWJpbGl0aWVz
OiBbNjRdIEV4cHJlc3MgKHYyKSBFbmRwb2ludCwgTVNJIDAwCgkJRGV2Q2FwOglNYXhQYXlsb2Fk
IDI1NiBieXRlcywgUGhhbnRGdW5jIDAsIExhdGVuY3kgTDBzIDw0dXMsIEwxIHVubGltaXRlZAoJ
CQlFeHRUYWcrIEF0dG5CdG4tIEF0dG5JbmQtIFB3ckluZC0gUkJFKyBGTFJlc2V0LSBTbG90UG93
ZXJMaW1pdCAwLjAwMFcKCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0g
VW5zdXBSZXEtCgkJCVJseGRPcmQrIEV4dFRhZysgUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25vb3Ar
CgkJCU1heFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDUxMiBieXRlcwoJCURldlN0YToJ
Q29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0gQXV4UHdyLSBUcmFuc1Bl
bmQtCgkJTG5rQ2FwOglQb3J0ICMwLCBTcGVlZCAxNkdUL3MsIFdpZHRoIHgxNiwgQVNQTSBMMHMg
TDEsIEV4aXQgTGF0ZW5jeSBMMHMgPDY0bnMsIEwxIDwxdXMKCQkJQ2xvY2tQTS0gU3VycHJpc2Ut
IExMQWN0UmVwLSBCd05vdC0gQVNQTU9wdENvbXArCgkJTG5rQ3RsOglBU1BNIERpc2FibGVkOyBS
Q0IgNjQgYnl0ZXMsIERpc2FibGVkLSBDb21tQ2xrKwoJCQlFeHRTeW5jaC0gQ2xvY2tQTS0gQXV0
V2lkRGlzLSBCV0ludC0gQXV0QldJbnQtCgkJTG5rU3RhOglTcGVlZCAxNkdUL3MgKG9rKSwgV2lk
dGggeDE2IChvaykKCQkJVHJFcnItIFRyYWluLSBTbG90Q2xrKyBETEFjdGl2ZS0gQldNZ210LSBB
QldNZ210LQoJCURldkNhcDI6IENvbXBsZXRpb24gVGltZW91dDogUmFuZ2UgQUJDRCwgVGltZW91
dERpcysgTlJPUHJQclAtIExUUi0KCQkJIDEwQml0VGFnQ29tcCsgMTBCaXRUYWdSZXEtIE9CRkYg
Tm90IFN1cHBvcnRlZCwgRXh0Rm10KyBFRVRMUFByZWZpeCssIE1heEVFVExQUHJlZml4ZXMgMQoJ
CQkgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJS
ZWR1Y3Rpb25Jbml0LQoJCQkgRlJTLSBUUEhDb21wLSBFeHRUUEhDb21wLQoJCQkgQXRvbWljT3Bz
Q2FwOiAzMmJpdC0gNjRiaXQtIDEyOGJpdENBUy0KCQlEZXZDdGwyOiBDb21wbGV0aW9uIFRpbWVv
dXQ6IDUwdXMgdG8gNTBtcywgVGltZW91dERpcy0gTFRSLSBPQkZGIERpc2FibGVkLAoJCQkgQXRv
bWljT3BzQ3RsOiBSZXFFbi0KCQlMbmtTdGEyOiBDdXJyZW50IERlLWVtcGhhc2lzIExldmVsOiAt
My41ZEIsIEVxdWFsaXphdGlvbkNvbXBsZXRlLSBFcXVhbGl6YXRpb25QaGFzZTEtCgkJCSBFcXVh
bGl6YXRpb25QaGFzZTItIEVxdWFsaXphdGlvblBoYXNlMy0gTGlua0VxdWFsaXphdGlvblJlcXVl
c3QtCgkJCSBSZXRpbWVyLSAyUmV0aW1lcnMtIENyb3NzbGlua1JlczogdW5zdXBwb3J0ZWQKCUNh
cGFiaWxpdGllczogW2EwXSBNU0k6IEVuYWJsZSsgQ291bnQ9MS8xIE1hc2thYmxlLSA2NGJpdCsK
CQlBZGRyZXNzOiAwMDAwMDAwMGZlZTAwMDAwICBEYXRhOiAwMDAwCglDYXBhYmlsaXRpZXM6IFtj
MF0gTVNJLVg6IEVuYWJsZS0gQ291bnQ9MSBNYXNrZWQtCgkJVmVjdG9yIHRhYmxlOiBCQVI9MCBv
ZmZzZXQ9MDAwZmUwMDAKCQlQQkE6IEJBUj0wIG9mZnNldD0wMDBmZjAwMAoJQ2FwYWJpbGl0aWVz
OiBbMTAwIHYxXSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IElEPTAwMDEgUmV2PTEgTGVu
PTAxMCA8Pz4KCUNhcGFiaWxpdGllczogWzJhMCB2MV0gQWNjZXNzIENvbnRyb2wgU2VydmljZXMK
CQlBQ1NDYXA6CVNyY1ZhbGlkLSBUcmFuc0Jsay0gUmVxUmVkaXItIENtcGx0UmVkaXItIFVwc3Ry
ZWFtRndkLSBFZ3Jlc3NDdHJsLSBEaXJlY3RUcmFucy0KCQlBQ1NDdGw6CVNyY1ZhbGlkLSBUcmFu
c0Jsay0gUmVxUmVkaXItIENtcGx0UmVkaXItIFVwc3RyZWFtRndkLSBFZ3Jlc3NDdHJsLSBEaXJl
Y3RUcmFucy0KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiB4aGNpX2hjZAoJS2VybmVsIG1vZHVsZXM6
IHhoY2lfcGNpCgozMzowMC40IFVTQiBjb250cm9sbGVyOiBBZHZhbmNlZCBNaWNybyBEZXZpY2Vz
LCBJbmMuIFtBTURdIERldmljZSAxNjFlIChwcm9nLWlmIDMwIFtYSENJXSkKCVN1YnN5c3RlbTog
TGVub3ZvIERldmljZSA1MGI0CglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3lj
bGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSKyBGYXN0QjJCLSBE
aXNJTlR4KwoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VM
PWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0
ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiAzMiBieXRlcwoJSW50ZXJydXB0OiBwaW4gQSByb3V0
ZWQgdG8gSVJRIDQ4CglJT01NVSBncm91cDogMTcKCVJlZ2lvbiAwOiBNZW1vcnkgYXQgOTg3MDAw
MDAgKDY0LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MU1dCglDYXBhYmlsaXRpZXM6IFs0
OF0gVmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBMZW49MDggPD8+CglDYXBhYmlsaXRpZXM6
IFs1MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQx
LSBEMi0gQXV4Q3VycmVudD0wbUEgUE1FKEQwKyxEMS0sRDItLEQzaG90KyxEM2NvbGQrKQoJCVN0
YXR1czogRDAgTm9Tb2Z0UnN0LSBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJQ2Fw
YWJpbGl0aWVzOiBbNjRdIEV4cHJlc3MgKHYyKSBFbmRwb2ludCwgTVNJIDAwCgkJRGV2Q2FwOglN
YXhQYXlsb2FkIDI1NiBieXRlcywgUGhhbnRGdW5jIDAsIExhdGVuY3kgTDBzIDw0dXMsIEwxIHVu
bGltaXRlZAoJCQlFeHRUYWcrIEF0dG5CdG4tIEF0dG5JbmQtIFB3ckluZC0gUkJFKyBGTFJlc2V0
LSBTbG90UG93ZXJMaW1pdCAwLjAwMFcKCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBG
YXRhbEVyci0gVW5zdXBSZXEtCgkJCVJseGRPcmQrIEV4dFRhZysgUGhhbnRGdW5jLSBBdXhQd3It
IE5vU25vb3ArCgkJCU1heFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDUxMiBieXRlcwoJ
CURldlN0YToJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0gQXV4UHdy
LSBUcmFuc1BlbmQtCgkJTG5rQ2FwOglQb3J0ICMwLCBTcGVlZCAxNkdUL3MsIFdpZHRoIHgxNiwg
QVNQTSBMMHMgTDEsIEV4aXQgTGF0ZW5jeSBMMHMgPDY0bnMsIEwxIDwxdXMKCQkJQ2xvY2tQTS0g
U3VycHJpc2UtIExMQWN0UmVwLSBCd05vdC0gQVNQTU9wdENvbXArCgkJTG5rQ3RsOglBU1BNIERp
c2FibGVkOyBSQ0IgNjQgYnl0ZXMsIERpc2FibGVkLSBDb21tQ2xrKwoJCQlFeHRTeW5jaC0gQ2xv
Y2tQTS0gQXV0V2lkRGlzLSBCV0ludC0gQXV0QldJbnQtCgkJTG5rU3RhOglTcGVlZCAxNkdUL3Mg
KG9rKSwgV2lkdGggeDE2IChvaykKCQkJVHJFcnItIFRyYWluLSBTbG90Q2xrKyBETEFjdGl2ZS0g
QldNZ210LSBBQldNZ210LQoJCURldkNhcDI6IENvbXBsZXRpb24gVGltZW91dDogUmFuZ2UgQUJD
RCwgVGltZW91dERpcysgTlJPUHJQclAtIExUUi0KCQkJIDEwQml0VGFnQ29tcCsgMTBCaXRUYWdS
ZXEtIE9CRkYgTm90IFN1cHBvcnRlZCwgRXh0Rm10KyBFRVRMUFByZWZpeCssIE1heEVFVExQUHJl
Zml4ZXMgMQoJCQkgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdl
bmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkgRlJTLSBUUEhDb21wLSBFeHRUUEhDb21wLQoJCQkg
QXRvbWljT3BzQ2FwOiAzMmJpdC0gNjRiaXQtIDEyOGJpdENBUy0KCQlEZXZDdGwyOiBDb21wbGV0
aW9uIFRpbWVvdXQ6IDUwdXMgdG8gNTBtcywgVGltZW91dERpcy0gTFRSLSBPQkZGIERpc2FibGVk
LAoJCQkgQXRvbWljT3BzQ3RsOiBSZXFFbi0KCQlMbmtTdGEyOiBDdXJyZW50IERlLWVtcGhhc2lz
IExldmVsOiAtMy41ZEIsIEVxdWFsaXphdGlvbkNvbXBsZXRlLSBFcXVhbGl6YXRpb25QaGFzZTEt
CgkJCSBFcXVhbGl6YXRpb25QaGFzZTItIEVxdWFsaXphdGlvblBoYXNlMy0gTGlua0VxdWFsaXph
dGlvblJlcXVlc3QtCgkJCSBSZXRpbWVyLSAyUmV0aW1lcnMtIENyb3NzbGlua1JlczogdW5zdXBw
b3J0ZWQKCUNhcGFiaWxpdGllczogW2EwXSBNU0k6IEVuYWJsZSsgQ291bnQ9MS8xIE1hc2thYmxl
LSA2NGJpdCsKCQlBZGRyZXNzOiAwMDAwMDAwMGZlZTAwMDAwICBEYXRhOiAwMDAwCglDYXBhYmls
aXRpZXM6IFtjMF0gTVNJLVg6IEVuYWJsZS0gQ291bnQ9MSBNYXNrZWQtCgkJVmVjdG9yIHRhYmxl
OiBCQVI9MCBvZmZzZXQ9MDAwZmUwMDAKCQlQQkE6IEJBUj0wIG9mZnNldD0wMDBmZjAwMAoJQ2Fw
YWJpbGl0aWVzOiBbMTAwIHYxXSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IElEPTAwMDEg
UmV2PTEgTGVuPTAxMCA8Pz4KCUNhcGFiaWxpdGllczogWzJhMCB2MV0gQWNjZXNzIENvbnRyb2wg
U2VydmljZXMKCQlBQ1NDYXA6CVNyY1ZhbGlkLSBUcmFuc0Jsay0gUmVxUmVkaXItIENtcGx0UmVk
aXItIFVwc3RyZWFtRndkLSBFZ3Jlc3NDdHJsLSBEaXJlY3RUcmFucy0KCQlBQ1NDdGw6CVNyY1Zh
bGlkLSBUcmFuc0Jsay0gUmVxUmVkaXItIENtcGx0UmVkaXItIFVwc3RyZWFtRndkLSBFZ3Jlc3ND
dHJsLSBEaXJlY3RUcmFucy0KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiB4aGNpX2hjZAoJS2VybmVs
IG1vZHVsZXM6IHhoY2lfcGNpCgozMzowMC41IE11bHRpbWVkaWEgY29udHJvbGxlcjogQWR2YW5j
ZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBSYXZlbi9SYXZlbjIvRmlyZUZsaWdodC9SZW5v
aXIgQXVkaW8gUHJvY2Vzc29yIChyZXYgNjApCglTdWJzeXN0ZW06IExlbm92byBSYXZlbi9SYXZl
bjIvRmlyZUZsaWdodC9SZW5vaXIgQXVkaW8gUHJvY2Vzc29yCglDb250cm9sOiBJL08tIE1lbSsg
QnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5n
LSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RC
MkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlIt
IDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiAzMiBieXRlcwoJSW50
ZXJydXB0OiBwaW4gQiByb3V0ZWQgdG8gSVJRIDkyCglJT01NVSBncm91cDogMTgKCVJlZ2lvbiAw
OiBNZW1vcnkgYXQgOTg5ODAwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MjU2
S10KCUNhcGFiaWxpdGllczogWzQ4XSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IExlbj0w
OCA8Pz4KCUNhcGFiaWxpdGllczogWzUwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZs
YWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUoRDArLEQxLSxEMi0s
RDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QrIFBNRS1FbmFibGUtIERTZWw9
MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRpZXM6IFs2NF0gRXhwcmVzcyAodjIpIEVuZHBvaW50
LCBNU0kgMDAKCQlEZXZDYXA6CU1heFBheWxvYWQgMjU2IGJ5dGVzLCBQaGFudEZ1bmMgMCwgTGF0
ZW5jeSBMMHMgPDR1cywgTDEgdW5saW1pdGVkCgkJCUV4dFRhZysgQXR0bkJ0bi0gQXR0bkluZC0g
UHdySW5kLSBSQkUrIEZMUmVzZXQtIFNsb3RQb3dlckxpbWl0IDAuMDAwVwoJCURldkN0bDoJQ29y
ckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFn
KyBQaGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9vcCsKCQkJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIE1h
eFJlYWRSZXEgNTEyIGJ5dGVzCgkJRGV2U3RhOglDb3JyRXJyLSBOb25GYXRhbEVyci0gRmF0YWxF
cnItIFVuc3VwUmVxLSBBdXhQd3ItIFRyYW5zUGVuZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVk
IDE2R1QvcywgV2lkdGggeDE2LCBBU1BNIEwwcyBMMSwgRXhpdCBMYXRlbmN5IEwwcyA8NjRucywg
TDEgPDF1cwoJCQlDbG9ja1BNLSBTdXJwcmlzZS0gTExBY3RSZXAtIEJ3Tm90LSBBU1BNT3B0Q29t
cCsKCQlMbmtDdGw6CUFTUE0gRGlzYWJsZWQ7IFJDQiA2NCBieXRlcywgRGlzYWJsZWQtIENvbW1D
bGsrCgkJCUV4dFN5bmNoLSBDbG9ja1BNLSBBdXRXaWREaXMtIEJXSW50LSBBdXRCV0ludC0KCQlM
bmtTdGE6CVNwZWVkIDE2R1QvcyAob2spLCBXaWR0aCB4MTYgKG9rKQoJCQlUckVyci0gVHJhaW4t
IFNsb3RDbGsrIERMQWN0aXZlLSBCV01nbXQtIEFCV01nbXQtCgkJRGV2Q2FwMjogQ29tcGxldGlv
biBUaW1lb3V0OiBSYW5nZSBBQkNELCBUaW1lb3V0RGlzKyBOUk9QclByUC0gTFRSLQoJCQkgMTBC
aXRUYWdDb21wKyAxMEJpdFRhZ1JlcS0gT0JGRiBOb3QgU3VwcG9ydGVkLCBFeHRGbXQrIEVFVExQ
UHJlZml4KywgTWF4RUVUTFBQcmVmaXhlcyAxCgkJCSBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvbiBO
b3QgU3VwcG9ydGVkLCBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvbkluaXQtCgkJCSBGUlMtIFRQSENv
bXAtIEV4dFRQSENvbXAtCgkJCSBBdG9taWNPcHNDYXA6IDMyYml0LSA2NGJpdC0gMTI4Yml0Q0FT
LQoJCURldkN0bDI6IENvbXBsZXRpb24gVGltZW91dDogNTB1cyB0byA1MG1zLCBUaW1lb3V0RGlz
LSBMVFItIE9CRkYgRGlzYWJsZWQsCgkJCSBBdG9taWNPcHNDdGw6IFJlcUVuLQoJCUxua1N0YTI6
IEN1cnJlbnQgRGUtZW1waGFzaXMgTGV2ZWw6IC0zLjVkQiwgRXF1YWxpemF0aW9uQ29tcGxldGUt
IEVxdWFsaXphdGlvblBoYXNlMS0KCQkJIEVxdWFsaXphdGlvblBoYXNlMi0gRXF1YWxpemF0aW9u
UGhhc2UzLSBMaW5rRXF1YWxpemF0aW9uUmVxdWVzdC0KCQkJIFJldGltZXItIDJSZXRpbWVycy0g
Q3Jvc3NsaW5rUmVzOiB1bnN1cHBvcnRlZAoJQ2FwYWJpbGl0aWVzOiBbYTBdIE1TSTogRW5hYmxl
LSBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0KwoJCUFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwMDAg
IERhdGE6IDAwMDAKCUNhcGFiaWxpdGllczogWzEwMCB2MV0gVmVuZG9yIFNwZWNpZmljIEluZm9y
bWF0aW9uOiBJRD0wMDAxIFJldj0xIExlbj0wMTAgPD8+CglDYXBhYmlsaXRpZXM6IFsyYTAgdjFd
IEFjY2VzcyBDb250cm9sIFNlcnZpY2VzCgkJQUNTQ2FwOglTcmNWYWxpZC0gVHJhbnNCbGstIFJl
cVJlZGlyLSBDbXBsdFJlZGlyLSBVcHN0cmVhbUZ3ZC0gRWdyZXNzQ3RybC0gRGlyZWN0VHJhbnMt
CgkJQUNTQ3RsOglTcmNWYWxpZC0gVHJhbnNCbGstIFJlcVJlZGlyLSBDbXBsdFJlZGlyLSBVcHN0
cmVhbUZ3ZC0gRWdyZXNzQ3RybC0gRGlyZWN0VHJhbnMtCglLZXJuZWwgZHJpdmVyIGluIHVzZTog
c25kX3BjaV9hY3A2eAoJS2VybmVsIG1vZHVsZXM6IHNuZF9wY2lfYWNwM3gsIHNuZF9ybl9wY2lf
YWNwM3gsIHNuZF9wY2lfYWNwNXgsIHNuZF9wY2lfYWNwNngsIHNuZF9hY3BfcGNpLCBzbmRfcnBs
X3BjaV9hY3A2eCwgc25kX3BjaV9wcywgc25kX3NvZl9hbWRfcmVub2lyLCBzbmRfc29mX2FtZF9y
ZW1icmFuZHQKCjMzOjAwLjYgQXVkaW8gZGV2aWNlOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJ
bmMuIFtBTURdIEZhbWlseSAxN2ggKE1vZGVscyAxMGgtMWZoKSBIRCBBdWRpbyBDb250cm9sbGVy
CglTdWJzeXN0ZW06IExlbm92byBGYW1pbHkgMTdoIChNb2RlbHMgMTBoLTFmaCkgSEQgQXVkaW8g
Q29udHJvbGxlcgoJQ29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1X
SU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsK
CVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5U
QWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAs
IENhY2hlIExpbmUgU2l6ZTogMzIgYnl0ZXMKCUludGVycnVwdDogcGluIEMgcm91dGVkIHRvIElS
USA5NQoJSU9NTVUgZ3JvdXA6IDE5CglSZWdpb24gMDogTWVtb3J5IGF0IDk4OWMwMDAwICgzMi1i
aXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTMyS10KCUNhcGFiaWxpdGllczogWzQ4XSBWZW5k
b3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IExlbj0wOCA8Pz4KCUNhcGFiaWxpdGllczogWzUwXSBQ
b3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBB
dXhDdXJyZW50PTBtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBE
MCBOb1NvZnRSc3QrIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRp
ZXM6IFs2NF0gRXhwcmVzcyAodjIpIEVuZHBvaW50LCBNU0kgMDAKCQlEZXZDYXA6CU1heFBheWxv
YWQgMjU2IGJ5dGVzLCBQaGFudEZ1bmMgMCwgTGF0ZW5jeSBMMHMgPDR1cywgTDEgdW5saW1pdGVk
CgkJCUV4dFRhZysgQXR0bkJ0bi0gQXR0bkluZC0gUHdySW5kLSBSQkUrIEZMUmVzZXQtIFNsb3RQ
b3dlckxpbWl0IDAuMDAwVwoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJy
LSBVbnN1cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFnKyBQaGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9v
cCsKCQkJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIE1heFJlYWRSZXEgNTEyIGJ5dGVzCgkJRGV2U3Rh
OglDb3JyRXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLSBBdXhQd3ItIFRyYW5z
UGVuZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDE2R1QvcywgV2lkdGggeDE2LCBBU1BNIEww
cyBMMSwgRXhpdCBMYXRlbmN5IEwwcyA8NjRucywgTDEgPDF1cwoJCQlDbG9ja1BNLSBTdXJwcmlz
ZS0gTExBY3RSZXAtIEJ3Tm90LSBBU1BNT3B0Q29tcCsKCQlMbmtDdGw6CUFTUE0gRGlzYWJsZWQ7
IFJDQiA2NCBieXRlcywgRGlzYWJsZWQtIENvbW1DbGsrCgkJCUV4dFN5bmNoLSBDbG9ja1BNLSBB
dXRXaWREaXMtIEJXSW50LSBBdXRCV0ludC0KCQlMbmtTdGE6CVNwZWVkIDE2R1QvcyAob2spLCBX
aWR0aCB4MTYgKG9rKQoJCQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlLSBCV01nbXQt
IEFCV01nbXQtCgkJRGV2Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBSYW5nZSBBQkNELCBUaW1l
b3V0RGlzKyBOUk9QclByUC0gTFRSLQoJCQkgMTBCaXRUYWdDb21wKyAxMEJpdFRhZ1JlcS0gT0JG
RiBOb3QgU3VwcG9ydGVkLCBFeHRGbXQrIEVFVExQUHJlZml4KywgTWF4RUVUTFBQcmVmaXhlcyAx
CgkJCSBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvbiBOb3QgU3VwcG9ydGVkLCBFbWVyZ2VuY3lQb3dl
clJlZHVjdGlvbkluaXQtCgkJCSBGUlMtIFRQSENvbXAtIEV4dFRQSENvbXAtCgkJCSBBdG9taWNP
cHNDYXA6IDMyYml0LSA2NGJpdC0gMTI4Yml0Q0FTLQoJCURldkN0bDI6IENvbXBsZXRpb24gVGlt
ZW91dDogNTB1cyB0byA1MG1zLCBUaW1lb3V0RGlzLSBMVFItIE9CRkYgRGlzYWJsZWQsCgkJCSBB
dG9taWNPcHNDdGw6IFJlcUVuLQoJCUxua1N0YTI6IEN1cnJlbnQgRGUtZW1waGFzaXMgTGV2ZWw6
IC0zLjVkQiwgRXF1YWxpemF0aW9uQ29tcGxldGUtIEVxdWFsaXphdGlvblBoYXNlMS0KCQkJIEVx
dWFsaXphdGlvblBoYXNlMi0gRXF1YWxpemF0aW9uUGhhc2UzLSBMaW5rRXF1YWxpemF0aW9uUmVx
dWVzdC0KCQkJIFJldGltZXItIDJSZXRpbWVycy0gQ3Jvc3NsaW5rUmVzOiB1bnN1cHBvcnRlZAoJ
Q2FwYWJpbGl0aWVzOiBbYTBdIE1TSTogRW5hYmxlKyBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0
KwoJCUFkZHJlc3M6IDAwMDAwMDAwZmVlMDAwMDAgIERhdGE6IDAwMDAKCUNhcGFiaWxpdGllczog
WzEwMCB2MV0gVmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBJRD0wMDAxIFJldj0xIExlbj0w
MTAgPD8+CglDYXBhYmlsaXRpZXM6IFsyYTAgdjFdIEFjY2VzcyBDb250cm9sIFNlcnZpY2VzCgkJ
QUNTQ2FwOglTcmNWYWxpZC0gVHJhbnNCbGstIFJlcVJlZGlyLSBDbXBsdFJlZGlyLSBVcHN0cmVh
bUZ3ZC0gRWdyZXNzQ3RybC0gRGlyZWN0VHJhbnMtCgkJQUNTQ3RsOglTcmNWYWxpZC0gVHJhbnNC
bGstIFJlcVJlZGlyLSBDbXBsdFJlZGlyLSBVcHN0cmVhbUZ3ZC0gRWdyZXNzQ3RybC0gRGlyZWN0
VHJhbnMtCglLZXJuZWwgZHJpdmVyIGluIHVzZTogc25kX2hkYV9pbnRlbAoJS2VybmVsIG1vZHVs
ZXM6IHNuZF9oZGFfaW50ZWwKCjM0OjAwLjAgVVNCIGNvbnRyb2xsZXI6IEFkdmFuY2VkIE1pY3Jv
IERldmljZXMsIEluYy4gW0FNRF0gRGV2aWNlIDE2MWYgKHByb2ctaWYgMzAgW1hIQ0ldKQoJU3Vi
c3lzdGVtOiBMZW5vdm8gRGV2aWNlIDUwYjQKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIr
IFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlIrIEZh
c3RCMkItIERpc0lOVHgrCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJy
LSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElO
VHgtCglMYXRlbmN5OiAwLCBDYWNoZSBMaW5lIFNpemU6IDMyIGJ5dGVzCglJbnRlcnJ1cHQ6IHBp
biBBIHJvdXRlZCB0byBJUlEgNTAKCUlPTU1VIGdyb3VwOiAyMAoJUmVnaW9uIDA6IE1lbW9yeSBh
dCA5ODIwMDAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xTV0KCUNhcGFiaWxp
dGllczogWzQ4XSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IExlbj0wOCA8Pz4KCUNhcGFi
aWxpdGllczogWzUwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGst
IERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29s
ZCspCgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQ
TUUtCglDYXBhYmlsaXRpZXM6IFs2NF0gRXhwcmVzcyAodjIpIEVuZHBvaW50LCBNU0kgMDAKCQlE
ZXZDYXA6CU1heFBheWxvYWQgMjU2IGJ5dGVzLCBQaGFudEZ1bmMgMCwgTGF0ZW5jeSBMMHMgPDR1
cywgTDEgdW5saW1pdGVkCgkJCUV4dFRhZysgQXR0bkJ0bi0gQXR0bkluZC0gUHdySW5kLSBSQkUr
IEZMUmVzZXQtIFNsb3RQb3dlckxpbWl0IDAuMDAwVwoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0
YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFnKyBQaGFudEZ1bmMt
IEF1eFB3ci0gTm9Tbm9vcCsKCQkJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIE1heFJlYWRSZXEgNTEy
IGJ5dGVzCgkJRGV2U3RhOglDb3JyRXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVx
LSBBdXhQd3ItIFRyYW5zUGVuZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDE2R1QvcywgV2lk
dGggeDE2LCBBU1BNIEwwcyBMMSwgRXhpdCBMYXRlbmN5IEwwcyA8NjRucywgTDEgPDF1cwoJCQlD
bG9ja1BNLSBTdXJwcmlzZS0gTExBY3RSZXAtIEJ3Tm90LSBBU1BNT3B0Q29tcCsKCQlMbmtDdGw6
CUFTUE0gRGlzYWJsZWQ7IFJDQiA2NCBieXRlcywgRGlzYWJsZWQtIENvbW1DbGsrCgkJCUV4dFN5
bmNoLSBDbG9ja1BNLSBBdXRXaWREaXMtIEJXSW50LSBBdXRCV0ludC0KCQlMbmtTdGE6CVNwZWVk
IDE2R1QvcyAob2spLCBXaWR0aCB4MTYgKG9rKQoJCQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERM
QWN0aXZlLSBCV01nbXQtIEFCV01nbXQtCgkJRGV2Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBS
YW5nZSBBQkNELCBUaW1lb3V0RGlzKyBOUk9QclByUC0gTFRSLQoJCQkgMTBCaXRUYWdDb21wKyAx
MEJpdFRhZ1JlcS0gT0JGRiBOb3QgU3VwcG9ydGVkLCBFeHRGbXQtIEVFVExQUHJlZml4LQoJCQkg
RW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1
Y3Rpb25Jbml0LQoJCQkgRlJTLSBUUEhDb21wLSBFeHRUUEhDb21wLQoJCQkgQXRvbWljT3BzQ2Fw
OiAzMmJpdC0gNjRiaXQtIDEyOGJpdENBUy0KCQlEZXZDdGwyOiBDb21wbGV0aW9uIFRpbWVvdXQ6
IDUwdXMgdG8gNTBtcywgVGltZW91dERpcy0gTFRSLSBPQkZGIERpc2FibGVkLAoJCQkgQXRvbWlj
T3BzQ3RsOiBSZXFFbi0KCQlMbmtDYXAyOiBTdXBwb3J0ZWQgTGluayBTcGVlZHM6IDIuNS0xNkdU
L3MsIENyb3NzbGluay0gUmV0aW1lcisgMlJldGltZXJzKyBEUlMtCgkJTG5rQ3RsMjogVGFyZ2V0
IExpbmsgU3BlZWQ6IDE2R1QvcywgRW50ZXJDb21wbGlhbmNlLSBTcGVlZERpcy0KCQkJIFRyYW5z
bWl0IE1hcmdpbjogTm9ybWFsIE9wZXJhdGluZyBSYW5nZSwgRW50ZXJNb2RpZmllZENvbXBsaWFu
Y2UtIENvbXBsaWFuY2VTT1MtCgkJCSBDb21wbGlhbmNlIERlLWVtcGhhc2lzOiAtNmRCCgkJTG5r
U3RhMjogQ3VycmVudCBEZS1lbXBoYXNpcyBMZXZlbDogLTMuNWRCLCBFcXVhbGl6YXRpb25Db21w
bGV0ZSsgRXF1YWxpemF0aW9uUGhhc2UxKwoJCQkgRXF1YWxpemF0aW9uUGhhc2UyKyBFcXVhbGl6
YXRpb25QaGFzZTMrIExpbmtFcXVhbGl6YXRpb25SZXF1ZXN0LQoJCQkgUmV0aW1lci0gMlJldGlt
ZXJzLSBDcm9zc2xpbmtSZXM6IHVuc3VwcG9ydGVkCglDYXBhYmlsaXRpZXM6IFthMF0gTVNJOiBF
bmFibGUrIENvdW50PTEvMSBNYXNrYWJsZS0gNjRiaXQrCgkJQWRkcmVzczogMDAwMDAwMDBmZWUw
MDAwMCAgRGF0YTogMDAwMAoJQ2FwYWJpbGl0aWVzOiBbYzBdIE1TSS1YOiBFbmFibGUtIENvdW50
PTEgTWFza2VkLQoJCVZlY3RvciB0YWJsZTogQkFSPTAgb2Zmc2V0PTAwMGZlMDAwCgkJUEJBOiBC
QVI9MCBvZmZzZXQ9MDAwZmYwMDAKCUNhcGFiaWxpdGllczogWzEwMCB2MV0gVmVuZG9yIFNwZWNp
ZmljIEluZm9ybWF0aW9uOiBJRD0wMDAxIFJldj0xIExlbj0wMTAgPD8+CglDYXBhYmlsaXRpZXM6
IFsyNzAgdjFdIFNlY29uZGFyeSBQQ0kgRXhwcmVzcwoJCUxua0N0bDM6IExua0VxdUludHJydXB0
RW4tIFBlcmZvcm1FcXUtCgkJTGFuZUVyclN0YXQ6IDAKCUNhcGFiaWxpdGllczogWzJhMCB2MV0g
QWNjZXNzIENvbnRyb2wgU2VydmljZXMKCQlBQ1NDYXA6CVNyY1ZhbGlkLSBUcmFuc0Jsay0gUmVx
UmVkaXItIENtcGx0UmVkaXItIFVwc3RyZWFtRndkLSBFZ3Jlc3NDdHJsLSBEaXJlY3RUcmFucy0K
CQlBQ1NDdGw6CVNyY1ZhbGlkLSBUcmFuc0Jsay0gUmVxUmVkaXItIENtcGx0UmVkaXItIFVwc3Ry
ZWFtRndkLSBFZ3Jlc3NDdHJsLSBEaXJlY3RUcmFucy0KCUNhcGFiaWxpdGllczogWzQxMCB2MV0g
UGh5c2ljYWwgTGF5ZXIgMTYuMCBHVC9zIDw/PgoJQ2FwYWJpbGl0aWVzOiBbNDUwIHYxXSBMYW5l
IE1hcmdpbmluZyBhdCB0aGUgUmVjZWl2ZXIgPD8+CglLZXJuZWwgZHJpdmVyIGluIHVzZTogeGhj
aV9oY2QKCUtlcm5lbCBtb2R1bGVzOiB4aGNpX3BjaQoKMzQ6MDAuMyBVU0IgY29udHJvbGxlcjog
QWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBEZXZpY2UgMTVkNiAocHJvZy1pZiAz
MCBbWEhDSV0pCglTdWJzeXN0ZW06IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0g
RGV2aWNlIDE1ZDYKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVt
V0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlIrIEZhc3RCMkItIERpc0lOVHgr
CglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+
VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAw
LCBDYWNoZSBMaW5lIFNpemU6IDMyIGJ5dGVzCglJbnRlcnJ1cHQ6IHBpbiBDIHJvdXRlZCB0byBJ
UlEgNTEKCUlPTU1VIGdyb3VwOiAyMQoJUmVnaW9uIDA6IE1lbW9yeSBhdCA5ODMwMDAwMCAoNjQt
Yml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xTV0KCUNhcGFiaWxpdGllczogWzQ4XSBWZW5k
b3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IExlbj0wOCA8Pz4KCUNhcGFiaWxpdGllczogWzUwXSBQ
b3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBB
dXhDdXJyZW50PTBtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBE
MCBOb1NvZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRp
ZXM6IFs2NF0gRXhwcmVzcyAodjIpIEVuZHBvaW50LCBNU0kgMDAKCQlEZXZDYXA6CU1heFBheWxv
YWQgMjU2IGJ5dGVzLCBQaGFudEZ1bmMgMCwgTGF0ZW5jeSBMMHMgPDR1cywgTDEgdW5saW1pdGVk
CgkJCUV4dFRhZysgQXR0bkJ0bi0gQXR0bkluZC0gUHdySW5kLSBSQkUrIEZMUmVzZXQtIFNsb3RQ
b3dlckxpbWl0IDAuMDAwVwoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJy
LSBVbnN1cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFnKyBQaGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9v
cCsKCQkJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIE1heFJlYWRSZXEgNTEyIGJ5dGVzCgkJRGV2U3Rh
OglDb3JyRXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLSBBdXhQd3ItIFRyYW5z
UGVuZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDE2R1QvcywgV2lkdGggeDE2LCBBU1BNIEww
cyBMMSwgRXhpdCBMYXRlbmN5IEwwcyA8NjRucywgTDEgPDF1cwoJCQlDbG9ja1BNLSBTdXJwcmlz
ZS0gTExBY3RSZXAtIEJ3Tm90LSBBU1BNT3B0Q29tcCsKCQlMbmtDdGw6CUFTUE0gRGlzYWJsZWQ7
IFJDQiA2NCBieXRlcywgRGlzYWJsZWQtIENvbW1DbGsrCgkJCUV4dFN5bmNoLSBDbG9ja1BNLSBB
dXRXaWREaXMtIEJXSW50LSBBdXRCV0ludC0KCQlMbmtTdGE6CVNwZWVkIDE2R1QvcyAob2spLCBX
aWR0aCB4MTYgKG9rKQoJCQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlLSBCV01nbXQt
IEFCV01nbXQtCgkJRGV2Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBSYW5nZSBBQkNELCBUaW1l
b3V0RGlzKyBOUk9QclByUC0gTFRSLQoJCQkgMTBCaXRUYWdDb21wKyAxMEJpdFRhZ1JlcS0gT0JG
RiBOb3QgU3VwcG9ydGVkLCBFeHRGbXQtIEVFVExQUHJlZml4LQoJCQkgRW1lcmdlbmN5UG93ZXJS
ZWR1Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkg
RlJTLSBUUEhDb21wLSBFeHRUUEhDb21wLQoJCQkgQXRvbWljT3BzQ2FwOiAzMmJpdC0gNjRiaXQt
IDEyOGJpdENBUy0KCQlEZXZDdGwyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IDUwdXMgdG8gNTBtcywg
VGltZW91dERpcy0gTFRSLSBPQkZGIERpc2FibGVkLAoJCQkgQXRvbWljT3BzQ3RsOiBSZXFFbi0K
CQlMbmtTdGEyOiBDdXJyZW50IERlLWVtcGhhc2lzIExldmVsOiAtMy41ZEIsIEVxdWFsaXphdGlv
bkNvbXBsZXRlLSBFcXVhbGl6YXRpb25QaGFzZTEtCgkJCSBFcXVhbGl6YXRpb25QaGFzZTItIEVx
dWFsaXphdGlvblBoYXNlMy0gTGlua0VxdWFsaXphdGlvblJlcXVlc3QtCgkJCSBSZXRpbWVyLSAy
UmV0aW1lcnMtIENyb3NzbGlua1JlczogdW5zdXBwb3J0ZWQKCUNhcGFiaWxpdGllczogW2EwXSBN
U0k6IEVuYWJsZSsgQ291bnQ9MS8xIE1hc2thYmxlLSA2NGJpdCsKCQlBZGRyZXNzOiAwMDAwMDAw
MGZlZTAwMDAwICBEYXRhOiAwMDAwCglDYXBhYmlsaXRpZXM6IFtjMF0gTVNJLVg6IEVuYWJsZS0g
Q291bnQ9MSBNYXNrZWQtCgkJVmVjdG9yIHRhYmxlOiBCQVI9MCBvZmZzZXQ9MDAwZmUwMDAKCQlQ
QkE6IEJBUj0wIG9mZnNldD0wMDBmZjAwMAoJQ2FwYWJpbGl0aWVzOiBbMTAwIHYxXSBWZW5kb3Ig
U3BlY2lmaWMgSW5mb3JtYXRpb246IElEPTAwMDEgUmV2PTEgTGVuPTAxMCA8Pz4KCUNhcGFiaWxp
dGllczogWzJhMCB2MV0gQWNjZXNzIENvbnRyb2wgU2VydmljZXMKCQlBQ1NDYXA6CVNyY1ZhbGlk
LSBUcmFuc0Jsay0gUmVxUmVkaXItIENtcGx0UmVkaXItIFVwc3RyZWFtRndkLSBFZ3Jlc3NDdHJs
LSBEaXJlY3RUcmFucy0KCQlBQ1NDdGw6CVNyY1ZhbGlkLSBUcmFuc0Jsay0gUmVxUmVkaXItIENt
cGx0UmVkaXItIFVwc3RyZWFtRndkLSBFZ3Jlc3NDdHJsLSBEaXJlY3RUcmFucy0KCUtlcm5lbCBk
cml2ZXIgaW4gdXNlOiB4aGNpX2hjZAoJS2VybmVsIG1vZHVsZXM6IHhoY2lfcGNpCgozNDowMC40
IFVTQiBjb250cm9sbGVyOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIERldmlj
ZSAxNWQ3IChwcm9nLWlmIDMwIFtYSENJXSkKCVN1YnN5c3RlbTogQWR2YW5jZWQgTWljcm8gRGV2
aWNlcywgSW5jLiBbQU1EXSBEZXZpY2UgMTVkNwoJQ29udHJvbDogSS9PKyBNZW0rIEJ1c01hc3Rl
cisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUisg
RmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJF
cnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0g
SU5UeC0KCUxhdGVuY3k6IDAsIENhY2hlIExpbmUgU2l6ZTogMzIgYnl0ZXMKCUludGVycnVwdDog
cGluIEQgcm91dGVkIHRvIElSUSA1MgoJSU9NTVUgZ3JvdXA6IDIyCglSZWdpb24gMDogTWVtb3J5
IGF0IDk4NDAwMDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTFNXQoJQ2FwYWJp
bGl0aWVzOiBbNDhdIFZlbmRvciBTcGVjaWZpYyBJbmZvcm1hdGlvbjogTGVuPTA4IDw/PgoJQ2Fw
YWJpbGl0aWVzOiBbNTBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzCgkJRmxhZ3M6IFBNRUNs
ay0gRFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMCssRDEtLEQyLSxEM2hvdCssRDNj
b2xkKykKCQlTdGF0dXM6IEQwIE5vU29mdFJzdC0gUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0w
IFBNRS0KCUNhcGFiaWxpdGllczogWzY0XSBFeHByZXNzICh2MikgRW5kcG9pbnQsIE1TSSAwMAoJ
CURldkNhcDoJTWF4UGF5bG9hZCAyNTYgYnl0ZXMsIFBoYW50RnVuYyAwLCBMYXRlbmN5IEwwcyA8
NHVzLCBMMSB1bmxpbWl0ZWQKCQkJRXh0VGFnKyBBdHRuQnRuLSBBdHRuSW5kLSBQd3JJbmQtIFJC
RSsgRkxSZXNldC0gU2xvdFBvd2VyTGltaXQgMC4wMDBXCgkJRGV2Q3RsOglDb3JyRXJyLSBOb25G
YXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLQoJCQlSbHhkT3JkKyBFeHRUYWcrIFBoYW50RnVu
Yy0gQXV4UHdyLSBOb1Nub29wKwoJCQlNYXhQYXlsb2FkIDEyOCBieXRlcywgTWF4UmVhZFJlcSA1
MTIgYnl0ZXMKCQlEZXZTdGE6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBS
ZXEtIEF1eFB3ci0gVHJhbnNQZW5kLQoJCUxua0NhcDoJUG9ydCAjMCwgU3BlZWQgMTZHVC9zLCBX
aWR0aCB4MTYsIEFTUE0gTDBzIEwxLCBFeGl0IExhdGVuY3kgTDBzIDw2NG5zLCBMMSA8MXVzCgkJ
CUNsb2NrUE0tIFN1cnByaXNlLSBMTEFjdFJlcC0gQndOb3QtIEFTUE1PcHRDb21wKwoJCUxua0N0
bDoJQVNQTSBEaXNhYmxlZDsgUkNCIDY0IGJ5dGVzLCBEaXNhYmxlZC0gQ29tbUNsaysKCQkJRXh0
U3luY2gtIENsb2NrUE0tIEF1dFdpZERpcy0gQldJbnQtIEF1dEJXSW50LQoJCUxua1N0YToJU3Bl
ZWQgMTZHVC9zIChvayksIFdpZHRoIHgxNiAob2spCgkJCVRyRXJyLSBUcmFpbi0gU2xvdENsaysg
RExBY3RpdmUtIEJXTWdtdC0gQUJXTWdtdC0KCQlEZXZDYXAyOiBDb21wbGV0aW9uIFRpbWVvdXQ6
IFJhbmdlIEFCQ0QsIFRpbWVvdXREaXMrIE5ST1ByUHJQLSBMVFItCgkJCSAxMEJpdFRhZ0NvbXAr
IDEwQml0VGFnUmVxLSBPQkZGIE5vdCBTdXBwb3J0ZWQsIEV4dEZtdC0gRUVUTFBQcmVmaXgtCgkJ
CSBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvbiBOb3QgU3VwcG9ydGVkLCBFbWVyZ2VuY3lQb3dlclJl
ZHVjdGlvbkluaXQtCgkJCSBGUlMtIFRQSENvbXAtIEV4dFRQSENvbXAtCgkJCSBBdG9taWNPcHND
YXA6IDMyYml0LSA2NGJpdC0gMTI4Yml0Q0FTLQoJCURldkN0bDI6IENvbXBsZXRpb24gVGltZW91
dDogNTB1cyB0byA1MG1zLCBUaW1lb3V0RGlzLSBMVFItIE9CRkYgRGlzYWJsZWQsCgkJCSBBdG9t
aWNPcHNDdGw6IFJlcUVuLQoJCUxua1N0YTI6IEN1cnJlbnQgRGUtZW1waGFzaXMgTGV2ZWw6IC0z
LjVkQiwgRXF1YWxpemF0aW9uQ29tcGxldGUtIEVxdWFsaXphdGlvblBoYXNlMS0KCQkJIEVxdWFs
aXphdGlvblBoYXNlMi0gRXF1YWxpemF0aW9uUGhhc2UzLSBMaW5rRXF1YWxpemF0aW9uUmVxdWVz
dC0KCQkJIFJldGltZXItIDJSZXRpbWVycy0gQ3Jvc3NsaW5rUmVzOiB1bnN1cHBvcnRlZAoJQ2Fw
YWJpbGl0aWVzOiBbYTBdIE1TSTogRW5hYmxlKyBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0KwoJ
CUFkZHJlc3M6IDAwMDAwMDAwZmVlMDAwMDAgIERhdGE6IDAwMDAKCUNhcGFiaWxpdGllczogW2Mw
XSBNU0ktWDogRW5hYmxlLSBDb3VudD0xIE1hc2tlZC0KCQlWZWN0b3IgdGFibGU6IEJBUj0wIG9m
ZnNldD0wMDBmZTAwMAoJCVBCQTogQkFSPTAgb2Zmc2V0PTAwMGZmMDAwCglDYXBhYmlsaXRpZXM6
IFsxMDAgdjFdIFZlbmRvciBTcGVjaWZpYyBJbmZvcm1hdGlvbjogSUQ9MDAwMSBSZXY9MSBMZW49
MDEwIDw/PgoJQ2FwYWJpbGl0aWVzOiBbMmEwIHYxXSBBY2Nlc3MgQ29udHJvbCBTZXJ2aWNlcwoJ
CUFDU0NhcDoJU3JjVmFsaWQtIFRyYW5zQmxrLSBSZXFSZWRpci0gQ21wbHRSZWRpci0gVXBzdHJl
YW1Gd2QtIEVncmVzc0N0cmwtIERpcmVjdFRyYW5zLQoJCUFDU0N0bDoJU3JjVmFsaWQtIFRyYW5z
QmxrLSBSZXFSZWRpci0gQ21wbHRSZWRpci0gVXBzdHJlYW1Gd2QtIEVncmVzc0N0cmwtIERpcmVj
dFRyYW5zLQoJS2VybmVsIGRyaXZlciBpbiB1c2U6IHhoY2lfaGNkCglLZXJuZWwgbW9kdWxlczog
eGhjaV9wY2kKCjM0OjAwLjYgVVNCIGNvbnRyb2xsZXI6IEFkdmFuY2VkIE1pY3JvIERldmljZXMs
IEluYy4gW0FNRF0gRGV2aWNlIDE2MmYgKHByb2ctaWYgNDAgW1VTQjQgSG9zdCBJbnRlcmZhY2Vd
KQoJU3Vic3lzdGVtOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIERldmljZSAx
NjJmCglDb250cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZH
QVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVz
OiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0g
PFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMCwgQ2FjaGUg
TGluZSBTaXplOiAzMiBieXRlcwoJSW50ZXJydXB0OiBwaW4gQiByb3V0ZWQgdG8gSVJRIDc1CglJ
T01NVSBncm91cDogMjMKCVJlZ2lvbiAwOiBNZW1vcnkgYXQgOTg1MDAwMDAgKDY0LWJpdCwgbm9u
LXByZWZldGNoYWJsZSkgW3NpemU9NTEyS10KCUNhcGFiaWxpdGllczogWzQ4XSBWZW5kb3IgU3Bl
Y2lmaWMgSW5mb3JtYXRpb246IExlbj0wOCA8Pz4KCUNhcGFiaWxpdGllczogWzUwXSBQb3dlciBN
YW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJy
ZW50PTBtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBEMCBOb1Nv
ZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRpZXM6IFs2
NF0gRXhwcmVzcyAodjIpIEVuZHBvaW50LCBNU0kgMDAKCQlEZXZDYXA6CU1heFBheWxvYWQgMjU2
IGJ5dGVzLCBQaGFudEZ1bmMgMCwgTGF0ZW5jeSBMMHMgPDR1cywgTDEgdW5saW1pdGVkCgkJCUV4
dFRhZysgQXR0bkJ0bi0gQXR0bkluZC0gUHdySW5kLSBSQkUrIEZMUmVzZXQtIFNsb3RQb3dlckxp
bWl0IDAuMDAwVwoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1
cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFnKyBQaGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9vcCsKCQkJ
TWF4UGF5bG9hZCAxMjggYnl0ZXMsIE1heFJlYWRSZXEgNTEyIGJ5dGVzCgkJRGV2U3RhOglDb3Jy
RXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLSBBdXhQd3ItIFRyYW5zUGVuZC0K
CQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDE2R1QvcywgV2lkdGggeDE2LCBBU1BNIEwwcyBMMSwg
RXhpdCBMYXRlbmN5IEwwcyA8NjRucywgTDEgPDF1cwoJCQlDbG9ja1BNLSBTdXJwcmlzZS0gTExB
Y3RSZXAtIEJ3Tm90LSBBU1BNT3B0Q29tcCsKCQlMbmtDdGw6CUFTUE0gRGlzYWJsZWQ7IFJDQiA2
NCBieXRlcywgRGlzYWJsZWQtIENvbW1DbGsrCgkJCUV4dFN5bmNoLSBDbG9ja1BNLSBBdXRXaWRE
aXMtIEJXSW50LSBBdXRCV0ludC0KCQlMbmtTdGE6CVNwZWVkIDE2R1QvcyAob2spLCBXaWR0aCB4
MTYgKG9rKQoJCQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlLSBCV01nbXQtIEFCV01n
bXQtCgkJRGV2Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBSYW5nZSBBQkNELCBUaW1lb3V0RGlz
KyBOUk9QclByUC0gTFRSLQoJCQkgMTBCaXRUYWdDb21wKyAxMEJpdFRhZ1JlcS0gT0JGRiBOb3Qg
U3VwcG9ydGVkLCBFeHRGbXQtIEVFVExQUHJlZml4LQoJCQkgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rp
b24gTm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkgRlJTLSBU
UEhDb21wLSBFeHRUUEhDb21wLQoJCQkgQXRvbWljT3BzQ2FwOiAzMmJpdC0gNjRiaXQtIDEyOGJp
dENBUy0KCQlEZXZDdGwyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IDUwdXMgdG8gNTBtcywgVGltZW91
dERpcy0gTFRSLSBPQkZGIERpc2FibGVkLAoJCQkgQXRvbWljT3BzQ3RsOiBSZXFFbi0KCQlMbmtT
dGEyOiBDdXJyZW50IERlLWVtcGhhc2lzIExldmVsOiAtMy41ZEIsIEVxdWFsaXphdGlvbkNvbXBs
ZXRlLSBFcXVhbGl6YXRpb25QaGFzZTEtCgkJCSBFcXVhbGl6YXRpb25QaGFzZTItIEVxdWFsaXph
dGlvblBoYXNlMy0gTGlua0VxdWFsaXphdGlvblJlcXVlc3QtCgkJCSBSZXRpbWVyLSAyUmV0aW1l
cnMtIENyb3NzbGlua1JlczogdW5zdXBwb3J0ZWQKCUNhcGFiaWxpdGllczogW2EwXSBNU0k6IEVu
YWJsZS0gQ291bnQ9MS8xNiBNYXNrYWJsZS0gNjRiaXQrCgkJQWRkcmVzczogMDAwMDAwMDAwMDAw
MDAwMCAgRGF0YTogMDAwMAoJQ2FwYWJpbGl0aWVzOiBbYzBdIE1TSS1YOiBFbmFibGUrIENvdW50
PTE2IE1hc2tlZC0KCQlWZWN0b3IgdGFibGU6IEJBUj0wIG9mZnNldD0wMDA3ZTAwMAoJCVBCQTog
QkFSPTAgb2Zmc2V0PTAwMDdmMDAwCglDYXBhYmlsaXRpZXM6IFsxMDAgdjFdIFZlbmRvciBTcGVj
aWZpYyBJbmZvcm1hdGlvbjogSUQ9MDAwMSBSZXY9MSBMZW49MDEwIDw/PgoJQ2FwYWJpbGl0aWVz
OiBbMmEwIHYxXSBBY2Nlc3MgQ29udHJvbCBTZXJ2aWNlcwoJCUFDU0NhcDoJU3JjVmFsaWQtIFRy
YW5zQmxrLSBSZXFSZWRpci0gQ21wbHRSZWRpci0gVXBzdHJlYW1Gd2QtIEVncmVzc0N0cmwtIERp
cmVjdFRyYW5zLQoJCUFDU0N0bDoJU3JjVmFsaWQtIFRyYW5zQmxrLSBSZXFSZWRpci0gQ21wbHRS
ZWRpci0gVXBzdHJlYW1Gd2QtIEVncmVzc0N0cmwtIERpcmVjdFRyYW5zLQoJS2VybmVsIGRyaXZl
ciBpbiB1c2U6IHRodW5kZXJib2x0CglLZXJuZWwgbW9kdWxlczogdGh1bmRlcmJvbHQKCg==
--000000000000841d60061641739a--

