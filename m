Return-Path: <linux-kernel+bounces-32140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A8783571B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01A6281FE7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5B9381CB;
	Sun, 21 Jan 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ul7UB7ln"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6C37713;
	Sun, 21 Jan 2024 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705858413; cv=none; b=rPAY4MlJxH2MjdLwbIr1Yr1GS+Enh/cO0axQ0s25ytYI0llyj7br0Fpr82gJ6EaAoNCw1O3hGpC6eVDvP8zxkHjsNU8rPRRWGV2lFT2bbo/kjVDssPm03ml3LSbuLPv3rgLzIrMK2Uyc8jRqpGGfwc4sKWiQNPZFdQWvgeZVBbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705858413; c=relaxed/simple;
	bh=mZQ/GwbMFtMouyqpAtblPnun6Um3qefO6e7Kc/oA7z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gt/921qkCELr/gSRgzsvZGloOksGh4L07rIfmMDY0cFBUof3AL3oJGOydq0/ij5gGO/lE+1dwGbH1CbgY+H1zIkqm7w6FyvT+fcdt6Zhf+LshgMfXaCo+GRHwawNc+2Ou4Erz2WBL58IrTZCNsRk5C4hJV/5BNjDybjExrPqvpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ul7UB7ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF0EC43143;
	Sun, 21 Jan 2024 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705858413;
	bh=mZQ/GwbMFtMouyqpAtblPnun6Um3qefO6e7Kc/oA7z4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ul7UB7ln3SQzQl+qTAhc6S+a4tMFfEd3Rg4vVtOtYqsgIWqMGRjL05M857zChN/CR
	 P/mmq6cA9z5iWcnboazfPydaDJF4ZPmSFkezo0Ke/PvN/bHaJoM3aHr0k7daHGM3MA
	 8vX+fhBVEtfcoTCFl0G24asEYIbfEU0Wh+XJyWDITKZyZ13LfvKPqWV9f5AKOCQ8tz
	 XoVsupTqR+YK1wrsdUcMha3sxS0tRJfs+LJQ1HK2IjezNkPYjOQqKBcm7D3NzyEtwY
	 tcSzXhOL2lzB04WCS6H2qIM3EckTYAnVUFFLFVeJM4HmqUcKd8jlQmqqVMkl/COag/
	 nFnwWpdmc3xCw==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bd562d17dcso2134730b6e.3;
        Sun, 21 Jan 2024 09:33:33 -0800 (PST)
X-Gm-Message-State: AOJu0YxLYDjf+sYdhZZA39fBCmNHefHOwDxVnPEkrgwSDkBqmlnZj3Nb
	Eyh0NZJi/tbKlWsm0hyhoWI9XZ1/YJTV/gEfNYIjapDsEbHqPZDfAJf8kKrtee0mHKdjcjvFUfy
	0xwoyYtrReKO1c3CZSR5X/VddDak=
X-Google-Smtp-Source: AGHT+IEB/J6BCfPZ0d5wdoOCYnRlPttXNpGjjxjkAZ6ZUMheaje/4NgAO3MwJjfTpwcgYyE9lmirmb/K+SvqPR1heNM=
X-Received: by 2002:aca:210b:0:b0:3bd:9584:8967 with SMTP id
 11-20020aca210b000000b003bd95848967mr3534466oiz.68.1705858412398; Sun, 21 Jan
 2024 09:33:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNAQ7C+ZN+mxaiw3-10Lmn2f0nAYi+aou=CWraZwV=_iThw@mail.gmail.com>
 <20240118141228.370254-1-jtornosm@redhat.com>
In-Reply-To: <20240118141228.370254-1-jtornosm@redhat.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 22 Jan 2024 02:32:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQCiBtQ3kQznPDKtkD83wpCzodPVDs8eFnfnx5=Y8E5Cw@mail.gmail.com>
Message-ID: <CAK7LNAQCiBtQ3kQznPDKtkD83wpCzodPVDs8eFnfnx5=Y8E5Cw@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] rpm-pkg: simplify installkernel %post
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: dcavalca@meta.com, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nathan@kernel.org, ndesaulniers@google.com, 
	nicolas@fjasle.eu, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b5698b060f781c68"

--000000000000b5698b060f781c68
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:12=E2=80=AFPM Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> >> %post
> >> ...
> >> +if [ -e /boot/vmlinuz-%{KERNELRELEASE} ] && file -bL /boot/vmlinuz-%{=
KERNELRELEASE} | grep -q " #%{release} "; then
> >> ...
> >>
> >>  %preun
> ...
> >> +if [ -e /boot/vmlinuz-%{KERNELRELEASE} ] && file -bL /boot/vmlinuz-%{=
KERNELRELEASE} | grep -q " #%{release} "; then
> > I do not understand why this is needed.
> > Please explain.
> Of course.
> Fisrt of all, I have seen (i.e. openSUSE Tumbleweed) that in the same way
> that vmlinuz, System.map and config was not copied when the rpm was
> installed (because of the reason that you commented with the missing
> script), they were not removed when the rpm was removed, so I have added
> the lines to remove in a similar way as you suggested for install.


Here, you are wrong.

Those installed files should be removed by %ghost markers.
I already have a local patch to do this.
(see the attachment)


I just asked you to fix up the code as I suggested in v4.



> And I have seen as well (i.e. openSUSE Tumbleweed)) that if the a new rpm
> is installed (same release but bigger build version to use default option=
s
> for the tool), vmlinuz, System.map and config are not copied from %post
> because vmlinuz, System.map and config already exist and the situation is
> not good, because /lib/modules/{KERNELRELEASE} is updated but the comment=
ed
> files in /boot are not updated. That is the reason why I have tried to
> identify when vmlinuz, System.map and config are not the good ones, to co=
py
> too.



For me (on Fedora 39 and openSUSE Tumbleweed), rpm fails due to file confli=
ct.

vagrant@opensuse-tumbleweed20231218:~> sudo rpm -i
kernel-6.7.0_12924_g660a5f4a53e7-4.x86_64.rpm
file /lib/modules/6.7.0-12924-g660a5f4a53e7/vmlinuz from install of
kernel-6.7.0_12924_g660a5f4a53e7-4.x86_64 conflicts with file from
package kernel-6.7.0_12924_g660a5f4a53e7-3.x86_64

So, this does not happen.




> Besides, in the commented situation, the older rpm (same release but olde=
r
> build version) is removed and with that, the new vmlinuz, System.map and
> config are removed too. That is the reason that I have tried to identify
> again the files, removing only the suitable vmlinuz, System.map and confi=
g
> with the same release and build number requested.
>
> > And, is the output of 'file' standardized?
> With no more information, file is going to print the strings in the file,
> that is, the information containig release, version, ... and here we can
> find what we are interested in. So in some way depends on vmlinuz binary.
>
> > You need to understand that ARCH is not always x86,
> > and /boot/vmlinuz-%{KERNELRELEASE}
> > is not always arch/x86/boot/bzImage.
> >
> > See arch/arm64/Makefile
> KBUILD_IMAGE    :=3D $(boot)/Image.gz
> >
> > For arm64, /boot/vmlinuz-%{KERNELRELEASE} is Image.gz
> >
> > 'file' says it is gzip data, that's all.
> > You cannot read the build version.
> You are right, again good catch.
> I will try to think something for aarch64. Maybe something more general,
> and  independent of the kernel binary name, is possible and valid for oth=
er
> architectures, maybe with rpm command.
> If nothing comes up, I will do only for x86.


No. Please do not.


>
> > Unreadable.
> > I suggested code with indentation and quotation,
> > but you got rid of them.
> I did not want to modify the style.
> Ok, I will follow your suggestion, it's clearer to me too.
>
> Thanks
>
> Best regards
> Jos=C3=A9 Ignacio
>


--=20
Best Regards
Masahiro Yamada

--000000000000b5698b060f781c68
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-kbuild-rpm-pkg-specify-more-files-as-ghost.patch"
Content-Disposition: attachment; 
	filename="0001-kbuild-rpm-pkg-specify-more-files-as-ghost.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lrnrfkjs0>
X-Attachment-Id: f_lrnrfkjs0

RnJvbSBlZDFmMGYzYmU4ZjRhNjc5YTA3OGRhZDBiOWFjYWYyM2IzMTQ0N2IyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3Jn
PgpEYXRlOiBNb24sIDI1IERlYyAyMDIzIDIyOjU4OjE3ICswOTAwClN1YmplY3Q6IFtQQVRDSF0g
a2J1aWxkOiBycG0tcGtnOiBzcGVjaWZ5IG1vcmUgZmlsZXMgYXMgJWdob3N0CgpJbnN0YWxsaW5n
IHRoZSBrZXJuZWwgcGFja2FnZSBpcyBmaW5lLCBidXQgd2hlbiB1bmluc3RhbGxpbmcgaXQsIHRo
ZQpmb2xsb3dpbmcgd2FybmluZ3MgYXJlIHNob3duOgoKICB3YXJuaW5nOiBmaWxlIG1vZHVsZXMu
c3ltYm9scy5iaW46IHJlbW92ZSBmYWlsZWQ6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKICB3
YXJuaW5nOiBmaWxlIG1vZHVsZXMuc3ltYm9sczogcmVtb3ZlIGZhaWxlZDogTm8gc3VjaCBmaWxl
IG9yIGRpcmVjdG9yeQogIHdhcm5pbmc6IGZpbGUgbW9kdWxlcy5zb2Z0ZGVwOiByZW1vdmUgZmFp
bGVkOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CiAgd2FybmluZzogZmlsZSBtb2R1bGVzLmRl
dm5hbWU6IHJlbW92ZSBmYWlsZWQ6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKICB3YXJuaW5n
OiBmaWxlIG1vZHVsZXMuZGVwLmJpbjogcmVtb3ZlIGZhaWxlZDogTm8gc3VjaCBmaWxlIG9yIGRp
cmVjdG9yeQogIHdhcm5pbmc6IGZpbGUgbW9kdWxlcy5kZXA6IHJlbW92ZSBmYWlsZWQ6IE5vIHN1
Y2ggZmlsZSBvciBkaXJlY3RvcnkKICB3YXJuaW5nOiBmaWxlIG1vZHVsZXMuYnVpbHRpbi5iaW46
IHJlbW92ZSBmYWlsZWQ6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKICB3YXJuaW5nOiBmaWxl
IG1vZHVsZXMuYnVpbHRpbi5hbGlhcy5iaW46IHJlbW92ZSBmYWlsZWQ6IE5vIHN1Y2ggZmlsZSBv
ciBkaXJlY3RvcnkKICB3YXJuaW5nOiBmaWxlIG1vZHVsZXMuYWxpYXMuYmluOiByZW1vdmUgZmFp
bGVkOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CiAgd2FybmluZzogZmlsZSBtb2R1bGVzLmFs
aWFzOiByZW1vdmUgZmFpbGVkOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CgpUaGUgJXByZXVu
IHNjcmlwdGxldCBydW5zICdrZXJuZWwtaW5zdGFsbCByZW1vdmUnLCB3aGljaCBpbiB0dXJuIGlu
dm9rZXMKL3Vzci9saWIva2VybmVsL2luc3RhbGwuZC81MC1kZXBtb2QuaW5zdGFsbCB0byByZW1v
dmUgdGhvc2UgZmlsZXMgYmVmb3JlCnRoZSBhY3R1YWwgcGFja2FnZSByZW1vdmFsLgoKTW9kZXJu
IFJQTS1iYXNlZCBkaXN0cmlidXRpb25zIGRvIG5vdCBzaGlwIGZpbGVzIGdlbmVyYXRlZCBieSBk
ZXBtb2QuCk1hcmsgdGhlbSBhcyAlZ2hvc3QgaW4gb3JkZXIgdG8gZXhjbHVkZSB0aGVtIGZyb20g
dGhlIHBhY2thZ2UsIGJ1dCBzdGlsbApjbGFpbSB0aGUgb3duZXJzaGlwIG9uIHRoZW0uIERvIGxp
a2V3aXNlIGZvciB0aGUgZmlsZXMgY29waWVkIHRvIC9ib290LgoKU2lnbmVkLW9mZi1ieTogTWFz
YWhpcm8gWWFtYWRhIDxtYXNhaGlyb3lAa2VybmVsLm9yZz4KLS0tCiBzY3JpcHRzL3BhY2thZ2Uv
a2VybmVsLnNwZWMgfCAyOSArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc2Ny
aXB0cy9wYWNrYWdlL2tlcm5lbC5zcGVjIGIvc2NyaXB0cy9wYWNrYWdlL2tlcm5lbC5zcGVjCmlu
ZGV4IDZhNzYyNWRhN2VhNS4uYzcyNDY2YTkzODQzIDEwMDY0NAotLS0gYS9zY3JpcHRzL3BhY2th
Z2Uva2VybmVsLnNwZWMKKysrIGIvc2NyaXB0cy9wYWNrYWdlL2tlcm5lbC5zcGVjCkBAIC02Niw2
ICs2NiwyNyBAQCBsbiAtZm5zIC91c3Ivc3JjL2tlcm5lbHMvJXtLRVJORUxSRUxFQVNFfSAle2J1
aWxkcm9vdH0vbGliL21vZHVsZXMvJXtLRVJORUxSRUxFQQogJXttYWtlfSAle21ha2VmbGFnc30g
cnVuLWNvbW1hbmQgS0JVSUxEX1JVTl9DT01NQU5EPScke3NyY3RyZWV9L3NjcmlwdHMvcGFja2Fn
ZS9pbnN0YWxsLWV4dG1vZC1idWlsZCAle2J1aWxkcm9vdH0vdXNyL3NyYy9rZXJuZWxzLyV7S0VS
TkVMUkVMRUFTRX0nCiAlZW5kaWYKIAoreworICAgIGVjaG8gIiVkZWZhdHRyICgtLCByb290LCBy
b290KSIKKworICAgIGZvciBmIGluIFN5c3RlbS5tYXAgY29uZmlnIGtlcm5lbCBtb2R1bGVzLmJ1
aWx0aW4gbW9kdWxlcy5idWlsdGluLm1vZGluZm8gXAorICAgICAgICAgICAgIG1vZHVsZXMub3Jk
ZXIgdm1saW51ejsgZG8KKyAgICAgICAgZWNobyAiL2xpYi9tb2R1bGVzLyV7S0VSTkVMUkVMRUFT
RX0vJHtmfSIKKyAgICBkb25lCisKKyAgICBmb3IgeCBpbiBhbGlhcyBhbGlhcy5iaW4gYnVpbHRp
bi5hbGlhcy5iaW4gYnVpbHRpbi5iaW4gZGVwIGRlcC5iaW4gZGV2bmFtZSBcCisgICAgICAgICAg
ICAgc29mdGRlcCBzeW1ib2xzIHN5bWJvbHMuYmluOyBkbworICAgICAgICBlY2hvICIlZ2hvc3Qg
L2xpYi9tb2R1bGVzLyV7S0VSTkVMUkVMRUFTRX0vbW9kdWxlcy4ke3h9IgorICAgIGRvbmUKKwor
ICAgIGZvciBmIGluIFN5c3RlbS5tYXAgY29uZmlnIGluaXRyYW1mcyB2bWxpbnV6OyBkbworICAg
ICAgICBlY2hvICIlZ2hvc3QgL2Jvb3QvJHtmfS0le0tFUk5FTFJFTEVBU0V9IgorICAgIGRvbmUK
KworICAgIGVjaG8gIiVleGNsdWRlIC9saWIvbW9kdWxlcy8le0tFUk5FTFJFTEVBU0V9L2J1aWxk
IgorICAgIGVjaG8gIiVleGNsdWRlIC9rZXJuZWwtZmlsZXMubGlzdCIKK30gPiAle2J1aWxkcm9v
dH0va2VybmVsLWZpbGVzLmxpc3QKKwogJWNsZWFuCiBybSAtcmYgJXtidWlsZHJvb3R9CiAKQEAg
LTc4LDYgKzk5LDkgQEAgZm9yIGZpbGUgaW4gdm1saW51eiBTeXN0ZW0ubWFwIGNvbmZpZzsgZG8K
ICAgICAgICAgIGNwICIvbGliL21vZHVsZXMvJXtLRVJORUxSRUxFQVNFfS8ke2ZpbGV9IiAiL2Jv
b3QvJHtmaWxlfS0le0tFUk5FTFJFTEVBU0V9IgogICAgIGZpCiBkb25lCitpZiBbICEgLWUgIi9s
aWIvbW9kdWxlcy8le0tFUk5FTFJFTEVBU0V9L21vZHVsZXMuZGVwIiBdOyB0aGVuCisgICAgL3Vz
ci9zYmluL2RlcG1vZCAle0tFUk5FTFJFTEVBU0V9CitmaQogCiAlcHJldW4KIGlmIFsgLXggL3Ni
aW4vbmV3LWtlcm5lbC1wa2cgXTsgdGhlbgpAQCAtOTEsMTAgKzExNSw3IEBAIGlmIFsgLXggL3Ni
aW4vdXBkYXRlLWJvb3Rsb2FkZXIgXTsgdGhlbgogL3NiaW4vdXBkYXRlLWJvb3Rsb2FkZXIgLS1y
ZW1vdmUgJXtLRVJORUxSRUxFQVNFfQogZmkKIAotJWZpbGVzCi0lZGVmYXR0ciAoLSwgcm9vdCwg
cm9vdCkKLS9saWIvbW9kdWxlcy8le0tFUk5FTFJFTEVBU0V9Ci0lZXhjbHVkZSAvbGliL21vZHVs
ZXMvJXtLRVJORUxSRUxFQVNFfS9idWlsZAorJWZpbGVzIC1mICV7YnVpbGRyb290fS9rZXJuZWwt
ZmlsZXMubGlzdAogCiAlZmlsZXMgaGVhZGVycwogJWRlZmF0dHIgKC0sIHJvb3QsIHJvb3QpCi0t
IAoyLjQwLjEKCg==
--000000000000b5698b060f781c68--

