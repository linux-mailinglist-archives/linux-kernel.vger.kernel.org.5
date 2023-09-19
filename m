Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4F77A596F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 07:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjISFgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 01:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjISFg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:36:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1677102;
        Mon, 18 Sep 2023 22:36:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso8510911e87.0;
        Mon, 18 Sep 2023 22:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695101780; x=1695706580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IvSU+3bZOSMZyXebAv4AvhY1QpxDkjAZZYfNw6VtnL8=;
        b=V6f1tgh12iE3QbPfDAZvYtliX2iyKsL5gUj+Y3vPjo2hvDvOmRio8KMMmhCOcTGR7G
         IyiiYgz6FC+VPt8HdYoj1Ily9rKR3NZ6IDv8+cPGqGcQzR/i3Ja+oiZ5q4DTSDzPhz7T
         DdaMx+CwU0ZTi2CYICfByqeEkMUVF69pXuIn8CUiEmzhx+OjjlqpeodVUdmUbbaIHd25
         brVGXboFTUJ0LnrwdAv8NhQmB1tVkiZ0QfK+0r4FkuhQmr8yQ2FqR00L7NZPnQd26GQ4
         ZTwNMJ/RWUibgGSTk4xl1uezzr4qEX7YVa3YytCnvhr7Hb6+D2LNVxqAXyzZXr+Cbx9k
         ifoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695101780; x=1695706580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvSU+3bZOSMZyXebAv4AvhY1QpxDkjAZZYfNw6VtnL8=;
        b=loFab97NuBFpS5EyBBEG7MY5iZ+IaSfRDylfNoEUfneh8mK9Lde03s9fyH57PWazey
         cHo4+GOcH4rL3yRByMWI7imKC0XDgXOyBtQrrV96XZf4b33jOc+AO6MP53FuYw1ASk3H
         zJ2hnViqQsPSNJOH+4rw79cLQiOb0+S8yonFggDGXTC2ggc9ru+lMr8i44H1cnsleO0C
         mF/PWaX1xRNyr1ML9fHIGe6VrSKjkqwIM6qT33TK3fLzM0IVdFIDpBTy1AD1cZRfGT7b
         Y2lXBNBHL1lOEPUl4dLafj00/H4Mbnfal3XN0ELWywUq6ZCUQRPBt5NslNz/bt4ESkU1
         0AIg==
X-Gm-Message-State: AOJu0Yw4/0aKvX3jRQ+FQGonUaa4I9td/sWCLEevXZ2Uj0O/9ndA+Kc2
        Mxd32Ep3FcQC+hUTWi60u/XXTR9YeokcAZZqtVQ=
X-Google-Smtp-Source: AGHT+IGoKrgDNSJYIWdSnYO8hial2x8HiCxpoe6mPVtLQ1kv4gFSua13dWPpYIKUwrYLqVx4CPbHWGBD7QVZeYSS88E=
X-Received: by 2002:ac2:5467:0:b0:503:56f:c665 with SMTP id
 e7-20020ac25467000000b00503056fc665mr5423683lfn.55.1695101779568; Mon, 18 Sep
 2023 22:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me> <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
 <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com> <CAH2r5mtUedfLSv81Z-Yb3_=AbD_QpT3tVbU1PRzMTituaw7bgA@mail.gmail.com>
In-Reply-To: <CAH2r5mtUedfLSv81Z-Yb3_=AbD_QpT3tVbU1PRzMTituaw7bgA@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 19 Sep 2023 00:36:07 -0500
Message-ID: <CAH2r5mt6YzapEKDo=hQ64yvBn7=jwMmY1c85NOABKcMPKPp3KA@mail.gmail.com>
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS share
 is mounted (cifsd-cfid-laundromat in"D" state)
To:     Brian Pardy <brian.pardy@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Paulo Alcantara <pc@manguebit.com>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Bharath S M <bharathsm@microsoft.com>
Content-Type: multipart/mixed; boundary="0000000000006e23870605afa38a"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006e23870605afa38a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Does the attached patch help in your case?  It avoids starting the
laundromat thread for IPC shares (which cuts the number of the threads
in half for many cases) and also avoids starting them if the server
does not support directory leases (e.g. if Samba server instead of
Windows server).


On Mon, Sep 18, 2023 at 10:00=E2=80=AFPM Steve French <smfrench@gmail.com> =
wrote:
>
> Paulo and I were discussing the laundromat thread at the SMB3.1.1 test
> event (at SDC this week) which is now going on - will let you know
> what we find.
>
> One obvious thing is that it probably isn't necessary for cases when
> the server does not support directory leases, but we noticed another
> problem as well.
>
>
> On Mon, Sep 18, 2023 at 9:20=E2=80=AFPM Brian Pardy <brian.pardy@gmail.co=
m> wrote:
> >
> > [RS removed from CC due to bounce message]
> >
> > On Wed, Sep 6, 2023 at 5:03=E2=80=AFPM Brian Pardy <brian.pardy@gmail.c=
om> wrote:
> > > On Tue, Sep 5, 2023 at 9:01=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmai=
l.com> wrote:
> > > > Thanks for the regression report. But if you want to get it fixed,
> > > > you have to do your part: perform bisection. See Documentation/admi=
n-guide/bug-bisect.rst in the kernel sources for how to do that.
> > > >
> > > > Anyway, I'm adding it to regzbot:
> > > >
> > > > #regzbot ^introduced: v6.4..v6.5
> > > > #regzbot title: incorrect CPU utilization report (multiplied) when =
mounting CIFS
> > >
> > > Thank you for directing me to the bug-bisect documentation. Results b=
elow:
> > >
> > > # git bisect bad
> > > d14de8067e3f9653cdef5a094176d00f3260ab20 is the first bad commit
> > > commit d14de8067e3f9653cdef5a094176d00f3260ab20
> > > Author: Ronnie Sahlberg <lsahlber@redhat.com>
> > > Date:   Thu Jul 6 12:32:24 2023 +1000
> > >
> > >     cifs: Add a laundromat thread for cached directories
> > >
> > >     and drop cached directories after 30 seconds
> > >
> > >     Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> > >     Signed-off-by: Steve French <stfrench@microsoft.com>
> > >
> > >  fs/smb/client/cached_dir.c | 67 ++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  fs/smb/client/cached_dir.h |  1 +
> > >  2 files changed, 68 insertions(+)
> >
> > Is there any further information I can provide to aid in debugging
> > this issue? Should I just expect incorrect load average reporting when
> > a CIFS share is mounted on any kernel >6.5.0?
> >
> > I'm not clear on the value or necessity of this "laundromat thread" -
> > everything worked as expected before it was added - shall I just patch
> > it out of my kernel builds going forward if there is no interest in
> > fixing it? Is a .config option to disable it possible?
>
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve

--0000000000006e23870605afa38a
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb3-do-not-start-laundromat-thread-when-dir-leases-.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-do-not-start-laundromat-thread-when-dir-leases-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lmpvrl4h0>
X-Attachment-Id: f_lmpvrl4h0

RnJvbSBhNjM1ODZiNGIwYjEyMjY1MDk3ZTg3NGI0MmM3YTJjZGJiZjQxMzhiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFR1ZSwgMTkgU2VwIDIwMjMgMDA6Mjg6MDIgLTA1MDAKU3ViamVjdDogW1BBVENIXSBz
bWIzOiBkbyBub3Qgc3RhcnQgbGF1bmRyb21hdCB0aHJlYWQgd2hlbiBkaXIgbGVhc2VzIGRpc2Fi
bGVkCgpXaGVuIG5vIGRpcmVjdG9yeSBsZWFzZSBzdXBwb3J0LCBvciBmb3IgSVBDIHNoYXJlcyB3
aGVyZSBkaXJlY3RvcmllcwpjYW4gbm90IGJlIG9wZW5lZCwgZG8gbm90IHN0YXJ0IGFuIHVubmVl
ZGVkIGxhdW5kcm9tYXQgdGhyZWFkIGZvcgp0aGF0IG1vdW50IChpdCB3YXN0ZXMgcmVzb3VyY2Vz
KS4KCkZpeGVzOiBkMTRkZTgwNjdlM2YgKCJjaWZzOiBBZGQgYSBsYXVuZHJvbWF0IHRocmVhZCBm
b3IgY2FjaGVkIGRpcmVjdG9yaWVzIikKU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZy
ZW5jaEBtaWNyb3NvZnQuY29tPgotLS0KIGZzL3NtYi9jbGllbnQvY2FjaGVkX2Rpci5jIHwgIDYg
KysrKysrCiBmcy9zbWIvY2xpZW50L2NpZnNnbG9iLmggICB8ICAyICstCiBmcy9zbWIvY2xpZW50
L2NpZnNwcm90by5oICB8ICAyICstCiBmcy9zbWIvY2xpZW50L2Nvbm5lY3QuYyAgICB8ICA5ICsr
KysrKystLQogZnMvc21iL2NsaWVudC9taXNjLmMgICAgICAgfCAxNiArKysrKysrKysrLS0tLS0t
CiBmcy9zbWIvY2xpZW50L3NtYjJwZHUuYyAgICB8ICA1ICsrKystCiA2IGZpbGVzIGNoYW5nZWQs
IDI5IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3NtYi9j
bGllbnQvY2FjaGVkX2Rpci5jIGIvZnMvc21iL2NsaWVudC9jYWNoZWRfZGlyLmMKaW5kZXggYjE3
ZjA2N2U0YWRhLi5hN2NiYWEzMjAwNWMgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvY2FjaGVk
X2Rpci5jCisrKyBiL2ZzL3NtYi9jbGllbnQvY2FjaGVkX2Rpci5jCkBAIC00NTAsNiArNDUwLDkg
QEAgdm9pZCBpbnZhbGlkYXRlX2FsbF9jYWNoZWRfZGlycyhzdHJ1Y3QgY2lmc190Y29uICp0Y29u
KQogewogCXN0cnVjdCBjYWNoZWRfZmlkcyAqY2ZpZHMgPSB0Y29uLT5jZmlkczsKIAlzdHJ1Y3Qg
Y2FjaGVkX2ZpZCAqY2ZpZCwgKnE7CisKKwlpZiAoY2ZpZHMgPT0gTlVMTCkKKwkJcmV0dXJuOwog
CUxJU1RfSEVBRChlbnRyeSk7CiAKIAlzcGluX2xvY2soJmNmaWRzLT5jZmlkX2xpc3RfbG9jayk7
CkBAIC02NTEsNiArNjU0LDkgQEAgdm9pZCBmcmVlX2NhY2hlZF9kaXJzKHN0cnVjdCBjYWNoZWRf
ZmlkcyAqY2ZpZHMpCiAJc3RydWN0IGNhY2hlZF9maWQgKmNmaWQsICpxOwogCUxJU1RfSEVBRChl
bnRyeSk7CiAKKwlpZiAoY2ZpZHMgPT0gTlVMTCkKKwkJcmV0dXJuOworCiAJaWYgKGNmaWRzLT5s
YXVuZHJvbWF0KSB7CiAJCWt0aHJlYWRfc3RvcChjZmlkcy0+bGF1bmRyb21hdCk7CiAJCWNmaWRz
LT5sYXVuZHJvbWF0ID0gTlVMTDsKZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvY2lmc2dsb2Iu
aCBiL2ZzL3NtYi9jbGllbnQvY2lmc2dsb2IuaAppbmRleCAwMzJkODcxNmY2NzEuLmY1OTRmY2Mw
ZTg4OSAxMDA2NDQKLS0tIGEvZnMvc21iL2NsaWVudC9jaWZzZ2xvYi5oCisrKyBiL2ZzL3NtYi9j
bGllbnQvY2lmc2dsb2IuaApAQCAtMTk0Myw3ICsxOTQzLDcgQEAgcmVxdWlyZSB1c2Ugb2YgdGhl
IHN0cm9uZ2VyIHByb3RvY29sICovCiAgKiBjaWZzSW5vZGVJbmZvLT5sb2NrX3NlbQljaWZzSW5v
ZGVJbmZvLT5sbGlzdAkJY2lmc19pbml0X29uY2UKICAqCQkJCS0+Y2FuX2NhY2hlX2JybGNrcwog
ICogY2lmc0lub2RlSW5mby0+ZGVmZXJyZWRfbG9jawljaWZzSW5vZGVJbmZvLT5kZWZlcnJlZF9j
bG9zZXMJY2lmc0lub2RlSW5mb19hbGxvYwotICogY2FjaGVkX2ZpZC0+ZmlkX211dGV4CQljaWZz
X3Rjb24tPmNyZmlkCQl0Y29uSW5mb0FsbG9jCisgKiBjYWNoZWRfZmlkLT5maWRfbXV0ZXgJCWNp
ZnNfdGNvbi0+Y3JmaWQJCXRjb25faW5mb19hbGxvYwogICogY2lmc0ZpbGVJbmZvLT5maF9tdXRl
eAkJY2lmc0ZpbGVJbmZvCQkJY2lmc19uZXdfZmlsZWluZm8KICAqIGNpZnNGaWxlSW5mby0+Zmls
ZV9pbmZvX2xvY2sJY2lmc0ZpbGVJbmZvLT5jb3VudAkJY2lmc19uZXdfZmlsZWluZm8KICAqCQkJ
CS0+aW52YWxpZEhhbmRsZQkJCWluaXRpYXRlX2NpZnNfc2VhcmNoCmRpZmYgLS1naXQgYS9mcy9z
bWIvY2xpZW50L2NpZnNwcm90by5oIGIvZnMvc21iL2NsaWVudC9jaWZzcHJvdG8uaAppbmRleCA3
ZDgwMzU4NDY2ODAuLjc0YzQyOGQzYzkxNiAxMDA2NDQKLS0tIGEvZnMvc21iL2NsaWVudC9jaWZz
cHJvdG8uaAorKysgYi9mcy9zbWIvY2xpZW50L2NpZnNwcm90by5oCkBAIC01MTIsNyArNTEyLDcg
QEAgZXh0ZXJuIGludCBDSUZTU01CTG9nb2ZmKGNvbnN0IHVuc2lnbmVkIGludCB4aWQsIHN0cnVj
dCBjaWZzX3NlcyAqc2VzKTsKIAogZXh0ZXJuIHN0cnVjdCBjaWZzX3NlcyAqc2VzSW5mb0FsbG9j
KHZvaWQpOwogZXh0ZXJuIHZvaWQgc2VzSW5mb0ZyZWUoc3RydWN0IGNpZnNfc2VzICopOwotZXh0
ZXJuIHN0cnVjdCBjaWZzX3Rjb24gKnRjb25JbmZvQWxsb2Modm9pZCk7CitleHRlcm4gc3RydWN0
IGNpZnNfdGNvbiAqdGNvbl9pbmZvX2FsbG9jKGJvb2wgaW5pdF9jYWNoZWRfZGlycyk7CiBleHRl
cm4gdm9pZCB0Y29uSW5mb0ZyZWUoc3RydWN0IGNpZnNfdGNvbiAqKTsKIAogZXh0ZXJuIGludCBj
aWZzX3NpZ25fcnFzdChzdHJ1Y3Qgc21iX3Jxc3QgKnJxc3QsIHN0cnVjdCBUQ1BfU2VydmVyX0lu
Zm8gKnNlcnZlciwKZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvY29ubmVjdC5jIGIvZnMvc21i
L2NsaWVudC9jb25uZWN0LmMKaW5kZXggNjg3NzU0NzkxYmYwLi40NWU2MGMwZDI2MmMgMTAwNjQ0
Ci0tLSBhL2ZzL3NtYi9jbGllbnQvY29ubmVjdC5jCisrKyBiL2ZzL3NtYi9jbGllbnQvY29ubmVj
dC5jCkBAIC0xODgyLDcgKzE4ODIsOSBAQCBjaWZzX3NldHVwX2lwYyhzdHJ1Y3QgY2lmc19zZXMg
KnNlcywgc3RydWN0IHNtYjNfZnNfY29udGV4dCAqY3R4KQogCQl9CiAJfQogCi0JdGNvbiA9IHRj
b25JbmZvQWxsb2MoKTsKKwkvKiBubyBuZWVkIHRvIHNldHVwIGRpcmVjdG9yeSBjYWNoaW5nIG9u
IElQQyBzaGFyZSwgc28gcGFzcyBpbiBmYWxzZSAqLworCXRjb24gPSB0Y29uX2luZm9fYWxsb2Mo
ZmFsc2UpOworCiAJaWYgKHRjb24gPT0gTlVMTCkKIAkJcmV0dXJuIC1FTk9NRU07CiAKQEAgLTI0
OTIsNyArMjQ5NCwxMCBAQCBjaWZzX2dldF90Y29uKHN0cnVjdCBjaWZzX3NlcyAqc2VzLCBzdHJ1
Y3Qgc21iM19mc19jb250ZXh0ICpjdHgpCiAJCWdvdG8gb3V0X2ZhaWw7CiAJfQogCi0JdGNvbiA9
IHRjb25JbmZvQWxsb2MoKTsKKwlpZiAoc2VzLT5zZXJ2ZXItPmNhcGFiaWxpdGllcyAmIFNNQjJf
R0xPQkFMX0NBUF9ESVJFQ1RPUllfTEVBU0lORykKKwkJdGNvbiA9IHRjb25faW5mb19hbGxvYyh0
cnVlKTsKKwllbHNlCisJCXRjb24gPSB0Y29uX2luZm9fYWxsb2MoZmFsc2UpOwogCWlmICh0Y29u
ID09IE5VTEwpIHsKIAkJcmMgPSAtRU5PTUVNOwogCQlnb3RvIG91dF9mYWlsOwpkaWZmIC0tZ2l0
IGEvZnMvc21iL2NsaWVudC9taXNjLmMgYi9mcy9zbWIvY2xpZW50L21pc2MuYwppbmRleCAzNjZi
NzU1Y2E5MTMuLmVjMjNiOTk4OWI2MyAxMDA2NDQKLS0tIGEvZnMvc21iL2NsaWVudC9taXNjLmMK
KysrIGIvZnMvc21iL2NsaWVudC9taXNjLmMKQEAgLTExMywxOCArMTEzLDIyIEBAIHNlc0luZm9G
cmVlKHN0cnVjdCBjaWZzX3NlcyAqYnVmX3RvX2ZyZWUpCiB9CiAKIHN0cnVjdCBjaWZzX3Rjb24g
KgotdGNvbkluZm9BbGxvYyh2b2lkKQordGNvbl9pbmZvX2FsbG9jKGJvb2wgZGlyX2xlYXNlc19l
bmFibGVkKQogewogCXN0cnVjdCBjaWZzX3Rjb24gKnJldF9idWY7CiAKIAlyZXRfYnVmID0ga3ph
bGxvYyhzaXplb2YoKnJldF9idWYpLCBHRlBfS0VSTkVMKTsKIAlpZiAoIXJldF9idWYpCiAJCXJl
dHVybiBOVUxMOwotCXJldF9idWYtPmNmaWRzID0gaW5pdF9jYWNoZWRfZGlycygpOwotCWlmICgh
cmV0X2J1Zi0+Y2ZpZHMpIHsKLQkJa2ZyZWUocmV0X2J1Zik7Ci0JCXJldHVybiBOVUxMOwotCX0K
KworCWlmIChkaXJfbGVhc2VzX2VuYWJsZWQgPT0gdHJ1ZSkgeworCQlyZXRfYnVmLT5jZmlkcyA9
IGluaXRfY2FjaGVkX2RpcnMoKTsKKwkJaWYgKCFyZXRfYnVmLT5jZmlkcykgeworCQkJa2ZyZWUo
cmV0X2J1Zik7CisJCQlyZXR1cm4gTlVMTDsKKwkJfQorCX0gZWxzZQorCQlyZXRfYnVmLT5jZmlk
cyA9IE5VTEw7CiAKIAlhdG9taWNfaW5jKCZ0Y29uSW5mb0FsbG9jQ291bnQpOwogCXJldF9idWYt
PnN0YXR1cyA9IFRJRF9ORVc7CmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L3NtYjJwZHUuYyBi
L2ZzL3NtYi9jbGllbnQvc21iMnBkdS5jCmluZGV4IDQ0ZDQ5NDNlOWM1Ni4uYzYzYjcyZWQ3ZmU5
IDEwMDY0NAotLS0gYS9mcy9zbWIvY2xpZW50L3NtYjJwZHUuYworKysgYi9mcy9zbWIvY2xpZW50
L3NtYjJwZHUuYwpAQCAtMzg3OCw3ICszODc4LDEwIEBAIHZvaWQgc21iMl9yZWNvbm5lY3Rfc2Vy
dmVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIAkJZ290byBkb25lOwogCiAJLyogYWxsb2Nh
dGUgYSBkdW1teSB0Y29uIHN0cnVjdCB1c2VkIGZvciByZWNvbm5lY3QgKi8KLQl0Y29uID0gdGNv
bkluZm9BbGxvYygpOworCWlmIChwc2VydmVyLT5jYXBhYmlsaXRpZXMgJiBTTUIyX0dMT0JBTF9D
QVBfTEVBU0lORykKKwkJdGNvbiA9IHRjb25faW5mb19hbGxvYyh0cnVlKTsKKwllbHNlCisJCXRj
b24gPSB0Y29uX2luZm9fYWxsb2MoZmFsc2UpOwogCWlmICghdGNvbikgewogCQlyZXNjaGVkID0g
dHJ1ZTsKIAkJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHNlcywgc2VzMiwgJnRtcF9zZXNfbGlz
dCwgcmxpc3QpIHsKLS0gCjIuMzkuMgoK
--0000000000006e23870605afa38a--
