Return-Path: <linux-kernel+bounces-49083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141998465B1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364F71C21F09
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E747B8BED;
	Fri,  2 Feb 2024 02:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbgK28Ze"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E985E748E;
	Fri,  2 Feb 2024 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840148; cv=none; b=UBA0u4qzQZZcfIDHWwL8nGNWGYb2dJxqeLyLw/e6Jj6S7PS3KAyRkHxsvwvUFjcAHTobL+W77VoRT9E2wO+yy9xVxGkDE9G//Hb7LiKRYmKmR2beXD3LY3+15mtMwweneFUJdlaKbalWpKsxmFzcDZU66EWBbOiUUNZYDcAtdcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840148; c=relaxed/simple;
	bh=7I7hVrGRkvgnLSLECbl2VlduGjFDHJeFlRq16tZDUM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IF9yA5L9LgyjdtjHDnl2SQ9wrw/igjVzbukse2PcMLmt8rmXUD/e4nRsUAfOaKHwpOrxYJOmB+GgIozw8YcsbJNXRRXoSw9k51eeUTaFWBmU9VLXPCjaFISk4m6Z4N1d/97rze2krygZPDT1dKIm40dE+7rGuMaJcu2QMhcX3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbgK28Ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA90C433F1;
	Fri,  2 Feb 2024 02:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706840147;
	bh=7I7hVrGRkvgnLSLECbl2VlduGjFDHJeFlRq16tZDUM4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tbgK28Ze4b8+6tZA6xzSYWMs7ZRoZ6PN8pophfQiNHzziJeQlo6ANrj/2CVj2ZXa4
	 cvdythDPwaosHMKvtKb112MtCGzAYGrWg+Au4EKU2BqM0P50iuWus+t3SNX0PIoO82
	 0rI3S360O7+6HcR0F4LrC/nXcwbBJuJ+3uiNOwvO3bl/NP9Ldv2w1dZ81ayiHet/Fq
	 HL4DIqqeP1upWgXzaEayK4C4XNDu17YtXbZYG750OxBGhaWog2WuZ1qLv6XTrFEtii
	 /6dHTvgz2DM4W+8Osi4R1hzTWEvAgC06D4kiwWAUZvsPsG7ysedK2WWO+wZ+5p9FS0
	 xJ7s4IxK1wZZw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-511363611ceso192722e87.2;
        Thu, 01 Feb 2024 18:15:47 -0800 (PST)
X-Gm-Message-State: AOJu0YwJ5Iw1Ryylj54XD8+aRFU4bAgG5hBPeCF7vP2RB2SIlj7AaMeB
	12OuL9l72tOzgPsYtv9iyDCGTXt+LaHl60fskg3JOY7Lix4pQ3tAC5v6xFhuazZW80MvgLei0ug
	YK+/nh8GzZfhY4TnmHER67a5akBM=
X-Google-Smtp-Source: AGHT+IEyHGeHTEZ014QSR50fqQSCB+dU0YR/v1x6Bi4SJq061sJkonf65np8QkdAleiww5T+zfR77a1jLfFRDxOHezU=
X-Received: by 2002:a05:6512:3c8c:b0:511:3725:ba55 with SMTP id
 h12-20020a0565123c8c00b005113725ba55mr179698lfv.57.1706840145766; Thu, 01 Feb
 2024 18:15:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNASGqfMkTuzP28qydpYCC0ct3cAgMpbPpmgHuQHZbtLhbA@mail.gmail.com>
 <CAHk-=whJKZNZWsa-VNDKafS_VfY4a5dAjG-r8BZgWk_a-xSepw@mail.gmail.com>
 <CAK7LNARzZ07TX2obHSpCgsC=FPTbLx5J+kPBFUECT+N7V42i5g@mail.gmail.com> <CAHk-=wg+3J8L4C7dcsZZNPEr3CJ49wKtJC0taVDBwGo9ZGot+Q@mail.gmail.com>
In-Reply-To: <CAHk-=wg+3J8L4C7dcsZZNPEr3CJ49wKtJC0taVDBwGo9ZGot+Q@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 2 Feb 2024 11:15:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQwcm9XfYAgcxOmGp9tvzj8kNbq8VUX09ZKscG1KEgE0g@mail.gmail.com>
Message-ID: <CAK7LNAQwcm9XfYAgcxOmGp9tvzj8kNbq8VUX09ZKscG1KEgE0g@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild fixes for v6.8-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000093c98706105cb0d6"

--00000000000093c98706105cb0d6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Linus,


On Fri, Feb 2, 2024 at 9:43=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 1 Feb 2024 at 15:57, Masahiro Yamada <masahiroy@kernel.org> wrote=
:
> >
> > Is this your expectation?
>
> Commit 82175d1f9430 touched *only* the nested 'if' indentations.
>
> Your attached changed other indentations too, which I am not sure
> makes any sense.
>
> But honestly, that whole make rule wrt whitespace makes no sense to
> begin with, and I don't know why the conditional statement is so
> special to begin with, and why GNU make would then suddenly start
> messing with an insane rule with bad historical reasons.


In my understanding, the GNU Make parser is confused with
shell's 'else' keyword.

So, GNU Make determined that 'else' indented with a tab
is not the Make's conditional directive.


>
> End result: all of this just reinforces how bad the Make rules for
> whitespace is, but I would suggest doing the *minimal* changes to make
> it work.
>
> Which commit 82175d1f9430 did, but your attached patch then does not.
>
> IOW, if the whole crazy makefile whitespace change was only about
> conditionals, let's keep all the stupid whitespace fixups as purely
> about conditionals too.
>
>              Linus
>


I attached a new patch.
I only changed the lines touch by 82175d1f9430







--=20
Best Regards
Masahiro Yamada

--00000000000093c98706105cb0d6
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-kbuild-use-4-space-indentation-when-followed-by-cond.patch"
Content-Disposition: attachment; 
	filename="0001-kbuild-use-4-space-indentation-when-followed-by-cond.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ls40fvcd0>
X-Attachment-Id: f_ls40fvcd0

RnJvbSA0ZGU5NDkwNDcyYjNjZDZmYjVjNzgzZWE1ZmQxMzBlMzI2OTVkYTJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3Jn
PgpEYXRlOiBGcmksIDIgRmViIDIwMjQgMTA6MzE6NDIgKzA5MDAKU3ViamVjdDogW1BBVENIXSBr
YnVpbGQ6IHVzZSA0LXNwYWNlIGluZGVudGF0aW9uIHdoZW4gZm9sbG93ZWQgYnkgY29uZGl0aW9u
YWxzCgpHTlUgTWFrZSBtYW51YWwgWzFdIGNsZWFybHkgZm9yYmlkcyBhIHRhYiBhdCB0aGUgYmVn
aW5uaW5nIG9mIHRoZQpjb25kaXRpb25hbCBkaXJlY3RpdmUgbGluZToKICJFeHRyYSBzcGFjZXMg
YXJlIGFsbG93ZWQgYW5kIGlnbm9yZWQgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUKICBjb25kaXRp
b25hbCBkaXJlY3RpdmUgbGluZSwgYnV0IGEgdGFiIGlzIG5vdCBhbGxvd2VkLiIKClRoaXMgd2ls
bCBub3Qgd29yayBmb3IgdGhlIG5leHQgcmVsZWFzZSBvZiBHTlUgTWFrZSwgaGVuY2UgY29tbWl0
CjgyMTc1ZDFmOTQzMCAoImtidWlsZDogUmVwbGFjZSB0YWJzIHdpdGggc3BhY2VzIHdoZW4gZm9s
bG93ZWQgYnkKY29uZGl0aW9uYWxzIikgcmVwbGFjZWQgdGhlIGluYXBwcm9wcmlhdGUgdGFicyB3
aXRoIDggc3BhY2VzLgoKSG93ZXZlciwgdGhlIDgtc3BhY2UgaW5kZW50YXRpb24gY2Fubm90IGJl
IHZpc3VhbGx5IGRpc3Rpbmd1aXNoZWQuCkxpbnVzIHN1Z2dlc3RlZCAyLTQgc3BhY2VzIGZvciB0
aG9zZSBuZXN0ZWQgaWYtc3RhdGVtZW50cy4gWzJdCgpUaGlzIGNvbW1pdCByZWRvZXMgdGhlIHJl
cGxhY2VtZW50IHdpdGggNCBzcGFjZXMuCgpbMV06IGh0dHBzOi8vd3d3LmdudS5vcmcvc29mdHdh
cmUvbWFrZS9tYW51YWwvbWFrZS5odG1sI0NvbmRpdGlvbmFsLVN5bnRheApbMl06IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC9DQUhrLT13aEpLWk5aV3NhLVZOREthZlNfVmZZNGE1ZEFqRy1y
OEJaZ1drX2EteFNlcHdAbWFpbC5nbWFpbC5jb20vCgpTdWdnZXN0ZWQtYnk6IExpbnVzIFRvcnZh
bGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KU2lnbmVkLW9mZi1ieTogTWFzYWhp
cm8gWWFtYWRhIDxtYXNhaGlyb3lAa2VybmVsLm9yZz4KLS0tCiBNYWtlZmlsZSAgICAgICAgICAg
ICB8IDEyICsrKysrKy0tLS0tLQogYXJjaC9tNjhrL01ha2VmaWxlICAgfCAgNCArKy0tCiBhcmNo
L3BhcmlzYy9NYWtlZmlsZSB8ICA0ICsrLS0KIGFyY2gveDg2L01ha2VmaWxlICAgIHwgIDggKysr
Ky0tLS0KIDQgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtlZmlsZQppbmRleCAxMTNmN2M3NjJmMGEuLjE3
YzJmMDJhYWFlOSAxMDA2NDQKLS0tIGEvTWFrZWZpbGUKKysrIGIvTWFrZWZpbGUKQEAgLTI5NCwx
NSArMjk0LDE1IEBAIG1heS1zeW5jLWNvbmZpZwk6PSAxCiBzaW5nbGUtYnVpbGQJOj0KIAogaWZu
ZXEgKCQoZmlsdGVyICQobm8tZG90LWNvbmZpZy10YXJnZXRzKSwgJChNQUtFQ01ER09BTFMpKSwp
Ci0gICAgICAgIGlmZXEgKCQoZmlsdGVyLW91dCAkKG5vLWRvdC1jb25maWctdGFyZ2V0cyksICQo
TUFLRUNNREdPQUxTKSksKQorICAgIGlmZXEgKCQoZmlsdGVyLW91dCAkKG5vLWRvdC1jb25maWct
dGFyZ2V0cyksICQoTUFLRUNNREdPQUxTKSksKQogCQluZWVkLWNvbmZpZyA6PQotICAgICAgICBl
bmRpZgorICAgIGVuZGlmCiBlbmRpZgogCiBpZm5lcSAoJChmaWx0ZXIgJChuby1zeW5jLWNvbmZp
Zy10YXJnZXRzKSwgJChNQUtFQ01ER09BTFMpKSwpCi0gICAgICAgIGlmZXEgKCQoZmlsdGVyLW91
dCAkKG5vLXN5bmMtY29uZmlnLXRhcmdldHMpLCAkKE1BS0VDTURHT0FMUykpLCkKKyAgICBpZmVx
ICgkKGZpbHRlci1vdXQgJChuby1zeW5jLWNvbmZpZy10YXJnZXRzKSwgJChNQUtFQ01ER09BTFMp
KSwpCiAJCW1heS1zeW5jLWNvbmZpZyA6PQotICAgICAgICBlbmRpZgorICAgIGVuZGlmCiBlbmRp
ZgogCiBuZWVkLWNvbXBpbGVyIDo9ICQobWF5LXN5bmMtY29uZmlnKQpAQCAtMzIzLDkgKzMyMyw5
IEBAIGVuZGlmCiAjIFdlIGNhbm5vdCBidWlsZCBzaW5nbGUgdGFyZ2V0cyBhbmQgdGhlIG90aGVy
cyBhdCB0aGUgc2FtZSB0aW1lCiBpZm5lcSAoJChmaWx0ZXIgJChzaW5nbGUtdGFyZ2V0cyksICQo
TUFLRUNNREdPQUxTKSksKQogCXNpbmdsZS1idWlsZCA6PSAxCi0gICAgICAgIGlmbmVxICgkKGZp
bHRlci1vdXQgJChzaW5nbGUtdGFyZ2V0cyksICQoTUFLRUNNREdPQUxTKSksKQorICAgIGlmbmVx
ICgkKGZpbHRlci1vdXQgJChzaW5nbGUtdGFyZ2V0cyksICQoTUFLRUNNREdPQUxTKSksKQogCQlt
aXhlZC1idWlsZCA6PSAxCi0gICAgICAgIGVuZGlmCisgICAgZW5kaWYKIGVuZGlmCiAKICMgRm9y
ICJtYWtlIC1qIGNsZWFuIGFsbCIsICJtYWtlIC1qIG1ycHJvcGVyIGRlZmNvbmZpZyBhbGwiLCBl
dGMuCmRpZmYgLS1naXQgYS9hcmNoL202OGsvTWFrZWZpbGUgYi9hcmNoL202OGsvTWFrZWZpbGUK
aW5kZXggNzZlZjFhNjdjMzYxLi4wYWJjZjk5NGNlNTUgMTAwNjQ0Ci0tLSBhL2FyY2gvbTY4ay9N
YWtlZmlsZQorKysgYi9hcmNoL202OGsvTWFrZWZpbGUKQEAgLTE1LDEwICsxNSwxMCBAQAogS0JV
SUxEX0RFRkNPTkZJRyA6PSBtdWx0aV9kZWZjb25maWcKIAogaWZkZWYgY3Jvc3NfY29tcGlsaW5n
Ci0gICAgICAgIGlmZXEgKCQoQ1JPU1NfQ09NUElMRSksKQorICAgIGlmZXEgKCQoQ1JPU1NfQ09N
UElMRSksKQogCQlDUk9TU19DT01QSUxFIDo9ICQoY2FsbCBjYy1jcm9zcy1wcmVmaXgsIFwKIAkJ
CW02OGstbGludXgtZ251LSBtNjhrLWxpbnV4LSBtNjhrLXVua25vd24tbGludXgtZ251LSkKLSAg
ICAgICAgZW5kaWYKKyAgICBlbmRpZgogZW5kaWYKIAogIwpkaWZmIC0tZ2l0IGEvYXJjaC9wYXJp
c2MvTWFrZWZpbGUgYi9hcmNoL3BhcmlzYy9NYWtlZmlsZQppbmRleCA3NDg2YjNiMzA1OTQuLjMx
NmY4NGYxZDE1YyAxMDA2NDQKLS0tIGEvYXJjaC9wYXJpc2MvTWFrZWZpbGUKKysrIGIvYXJjaC9w
YXJpc2MvTWFrZWZpbGUKQEAgLTUwLDEyICs1MCwxMiBAQCBleHBvcnQgQ1JPU1MzMkNDCiAKICMg
U2V0IGRlZmF1bHQgY3Jvc3MgY29tcGlsZXIgZm9yIGtlcm5lbCBidWlsZAogaWZkZWYgY3Jvc3Nf
Y29tcGlsaW5nCi0gICAgICAgIGlmZXEgKCQoQ1JPU1NfQ09NUElMRSksKQorICAgIGlmZXEgKCQo
Q1JPU1NfQ09NUElMRSksKQogCQlDQ19TVUZGSVhFUyA9IGxpbnV4IGxpbnV4LWdudSB1bmtub3du
LWxpbnV4LWdudSBzdXNlLWxpbnV4CiAJCUNST1NTX0NPTVBJTEUgOj0gJChjYWxsIGNjLWNyb3Nz
LXByZWZpeCwgXAogCQkJJChmb3JlYWNoIGEsJChDQ19BUkNIRVMpLCBcCiAJCQkkKGZvcmVhY2gg
cywkKENDX1NVRkZJWEVTKSwkKGEpLSQocyktKSkpCi0gICAgICAgIGVuZGlmCisgICAgZW5kaWYK
IGVuZGlmCiAKIGlmZGVmIENPTkZJR19EWU5BTUlDX0ZUUkFDRQpkaWZmIC0tZ2l0IGEvYXJjaC94
ODYvTWFrZWZpbGUgYi9hcmNoL3g4Ni9NYWtlZmlsZQppbmRleCAyMjY0ZGIxNGEyNWQuLmRhOGYz
Y2FmMjc4MSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvTWFrZWZpbGUKKysrIGIvYXJjaC94ODYvTWFr
ZWZpbGUKQEAgLTExMiwxMyArMTEyLDEzIEBAIGlmZXEgKCQoQ09ORklHX1g4Nl8zMikseSkKICAg
ICAgICAgIyB0ZW1wb3JhcnkgdW50aWwgc3RyaW5nLmggaXMgZml4ZWQKICAgICAgICAgS0JVSUxE
X0NGTEFHUyArPSAtZmZyZWVzdGFuZGluZwogCi0gICAgICAgIGlmZXEgKCQoQ09ORklHX1NUQUNL
UFJPVEVDVE9SKSx5KQotICAgICAgICAgICAgICAgIGlmZXEgKCQoQ09ORklHX1NNUCkseSkKKyAg
ICBpZmVxICgkKENPTkZJR19TVEFDS1BST1RFQ1RPUikseSkKKyAgICAgICAgaWZlcSAoJChDT05G
SUdfU01QKSx5KQogCQkJS0JVSUxEX0NGTEFHUyArPSAtbXN0YWNrLXByb3RlY3Rvci1ndWFyZC1y
ZWc9ZnMgLW1zdGFjay1wcm90ZWN0b3ItZ3VhcmQtc3ltYm9sPV9fc3RhY2tfY2hrX2d1YXJkCi0g
ICAgICAgICAgICAgICAgZWxzZQorICAgICAgICBlbHNlCiAJCQlLQlVJTERfQ0ZMQUdTICs9IC1t
c3RhY2stcHJvdGVjdG9yLWd1YXJkPWdsb2JhbAotICAgICAgICAgICAgICAgIGVuZGlmCiAgICAg
ICAgIGVuZGlmCisgICAgZW5kaWYKIGVsc2UKICAgICAgICAgQklUUyA6PSA2NAogICAgICAgICBV
VFNfTUFDSElORSA6PSB4ODZfNjQKLS0gCjIuNDAuMQoK
--00000000000093c98706105cb0d6--

