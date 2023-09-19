Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AC37A690F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjISQjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjISQjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:39:18 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6712FD6;
        Tue, 19 Sep 2023 09:39:12 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50325ce89e9so2742442e87.0;
        Tue, 19 Sep 2023 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695141550; x=1695746350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U88FyZFLNVhaEQZwWxZFH6P6ol0REDPkpx/UumaXegY=;
        b=mrk6IeWU0sdQyVZsbXhmcnKRx5OBesQ7DTsu264yO8rdMFufP6x5E2t7T0y3PSBCty
         t5zelwPIOuX9oENZQbnJUo8PvU9hgmjyp3ddqDGRxp3yh7UC37JMwwLCeCKxc81xAeIy
         BZn2qWko/ElhDwmjCp6VMh1cSiH5UOr36WJBW+20s0m8ALlpFHsxsm66K3zlAntRg6m9
         SOAMFNTAFAONvlhY2MUGDlrrwG27g/utPo0MWotUkfFk8gpZb5G0j2ldcysG2Na10rRc
         z8/Hanx2Me16Z66uFVzPcN81gm9nwEYP/ZFKJMooKlJSFHvf8BhSe383pbTukRjqkvbo
         z7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695141550; x=1695746350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U88FyZFLNVhaEQZwWxZFH6P6ol0REDPkpx/UumaXegY=;
        b=EzxH8gRYgvYnsQeBipWJ2iuV2HfI3y7lpOkQUZD1yOnHNqFgfUWSL9r73dgAe7k8ZD
         smIywZMtNM866c51AqXH/eAtL4Ir/tL42vEvcxnqP3wp8HdUlhFTHRL6wshtDYQ5zBp0
         5aqVNbWidq/dzl4BUxGeO14203rFDoapZtg6z0oZRHfHaATsFaEJovcPN24FTCIF3Y8g
         NNXOb0PjBhoaFGXZ2g3F2lclqJnK1PFA/pOf5CwR3cChv1N88dDOsc7owDEoMvYqvMJM
         AGJjoajT4MnEks9k9QZk46mz8+s13zOtq/l/yJxpbv2KmkaH5fyOyxUX9TimVq2gYyFD
         6V+w==
X-Gm-Message-State: AOJu0YzcF47MQIpy5DA8PEDetuk92fOvNSVvy4M84sq46DJeyeZZ4uY7
        csD5Bix/yH+S4gNtMRyqbBX0WbwexDg7/r7001U=
X-Google-Smtp-Source: AGHT+IGOmUYI6WtsWykRGPttxRGI9zE7PMKS0i3oL019Yed7aKhd1rDy90f1AztJdb70HqFBb3TuS2MpILI5kKPPMco=
X-Received: by 2002:a19:e01e:0:b0:4e0:a426:6ddc with SMTP id
 x30-20020a19e01e000000b004e0a4266ddcmr260230lfg.0.1695141550164; Tue, 19 Sep
 2023 09:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me> <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
 <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
 <CAH2r5mtUedfLSv81Z-Yb3_=AbD_QpT3tVbU1PRzMTituaw7bgA@mail.gmail.com>
 <CAH2r5mt6YzapEKDo=hQ64yvBn7=jwMmY1c85NOABKcMPKPp3KA@mail.gmail.com> <CAO+kfxQtOKoKdb+LtMeFxgu8VXa73nbmTPSfscbdwjUXM7ME_A@mail.gmail.com>
In-Reply-To: <CAO+kfxQtOKoKdb+LtMeFxgu8VXa73nbmTPSfscbdwjUXM7ME_A@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 19 Sep 2023 11:38:58 -0500
Message-ID: <CAH2r5msNf9WDHrBZSi5FhHDSewSNxMAuXTetMJDnoNh3CF_oMA@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="000000000000f1d6d40605b8e590"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f1d6d40605b8e590
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Minor updates (pointed out by Paulo) to patch. See attached.

On Tue, Sep 19, 2023 at 8:21=E2=80=AFAM Brian Pardy <brian.pardy@gmail.com>=
 wrote:
>
> On Tue, Sep 19, 2023 at 1:36=E2=80=AFAM Steve French <smfrench@gmail.com>=
 wrote:
> >
> > Does the attached patch help in your case?  It avoids starting the
> > laundromat thread for IPC shares (which cuts the number of the threads
> > in half for many cases) and also avoids starting them if the server
> > does not support directory leases (e.g. if Samba server instead of
> > Windows server).
>
> Hello,
>
> I applied the 0001-smb3-do-not-start-laundromat-thread-when-dir-leases-.p=
atch
> you provided against the 6.5.3 kernel.
>
> I can confirm that it resolves this issue - no laundromat threads are
> created, and the reported load average is as expected, not falsely
> high.
>
> This appears to fully fix the issue in my case.  Thank you very much!
>
> > On Mon, Sep 18, 2023 at 10:00=E2=80=AFPM Steve French <smfrench@gmail.c=
om> wrote:
> > >
> > > Paulo and I were discussing the laundromat thread at the SMB3.1.1 tes=
t
> > > event (at SDC this week) which is now going on - will let you know
> > > what we find.
> > >
> > > One obvious thing is that it probably isn't necessary for cases when
> > > the server does not support directory leases, but we noticed another
> > > problem as well.



--=20
Thanks,

Steve

--000000000000f1d6d40605b8e590
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb3-do-not-start-laundromat-thread-when-dir-leases.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-do-not-start-laundromat-thread-when-dir-leases.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lmqjhtwa0>
X-Attachment-Id: f_lmqjhtwa0

RnJvbSBhODJkNDAxNzdhMDI3Mzg1MmZlODlhZTJlZGJhOWZkOTdiNWQxNjFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFR1ZSwgMTkgU2VwIDIwMjMgMTE6MzU6NTMgLTA1MDAKU3ViamVjdDogW1BBVENIXSBz
bWIzOiBkbyBub3Qgc3RhcnQgbGF1bmRyb21hdCB0aHJlYWQgd2hlbiBkaXIgbGVhc2VzIAogZGlz
YWJsZWQKCldoZW4gbm8gZGlyZWN0b3J5IGxlYXNlIHN1cHBvcnQsIG9yIGZvciBJUEMgc2hhcmVz
IHdoZXJlIGRpcmVjdG9yaWVzCmNhbiBub3QgYmUgb3BlbmVkLCBkbyBub3Qgc3RhcnQgYW4gdW5u
ZWVkZWQgbGF1bmRyb21hdCB0aHJlYWQgZm9yCnRoYXQgbW91bnQgKGl0IHdhc3RlcyByZXNvdXJj
ZXMpLgoKRml4ZXM6IGQxNGRlODA2N2UzZiAoImNpZnM6IEFkZCBhIGxhdW5kcm9tYXQgdGhyZWFk
IGZvciBjYWNoZWQgZGlyZWN0b3JpZXMiKQpSZXZpZXdlZC1ieTogUGF1bG8gQWxjYW50YXJhIChT
VVNFKSA8cGNAbWFuZ3VlYml0LmNvbT4KU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZy
ZW5jaEBtaWNyb3NvZnQuY29tPgotLS0KIGZzL3NtYi9jbGllbnQvY2FjaGVkX2Rpci5jIHwgIDYg
KysrKysrCiBmcy9zbWIvY2xpZW50L2NpZnNnbG9iLmggICB8ICAyICstCiBmcy9zbWIvY2xpZW50
L2NpZnNwcm90by5oICB8ICAyICstCiBmcy9zbWIvY2xpZW50L2Nvbm5lY3QuYyAgICB8ICA4ICsr
KysrKy0tCiBmcy9zbWIvY2xpZW50L21pc2MuYyAgICAgICB8IDE0ICsrKysrKysrKy0tLS0tCiBm
cy9zbWIvY2xpZW50L3NtYjJwZHUuYyAgICB8ICAyICstCiA2IGZpbGVzIGNoYW5nZWQsIDI0IGlu
c2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQv
Y2FjaGVkX2Rpci5jIGIvZnMvc21iL2NsaWVudC9jYWNoZWRfZGlyLmMKaW5kZXggYjE3ZjA2N2U0
YWRhLi5lMmJlOGFlZGIyNmUgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvY2FjaGVkX2Rpci5j
CisrKyBiL2ZzL3NtYi9jbGllbnQvY2FjaGVkX2Rpci5jCkBAIC00NTIsNiArNDUyLDkgQEAgdm9p
ZCBpbnZhbGlkYXRlX2FsbF9jYWNoZWRfZGlycyhzdHJ1Y3QgY2lmc190Y29uICp0Y29uKQogCXN0
cnVjdCBjYWNoZWRfZmlkICpjZmlkLCAqcTsKIAlMSVNUX0hFQUQoZW50cnkpOwogCisJaWYgKGNm
aWRzID09IE5VTEwpCisJCXJldHVybjsKKwogCXNwaW5fbG9jaygmY2ZpZHMtPmNmaWRfbGlzdF9s
b2NrKTsKIAlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoY2ZpZCwgcSwgJmNmaWRzLT5lbnRyaWVz
LCBlbnRyeSkgewogCQlsaXN0X21vdmUoJmNmaWQtPmVudHJ5LCAmZW50cnkpOwpAQCAtNjUxLDYg
KzY1NCw5IEBAIHZvaWQgZnJlZV9jYWNoZWRfZGlycyhzdHJ1Y3QgY2FjaGVkX2ZpZHMgKmNmaWRz
KQogCXN0cnVjdCBjYWNoZWRfZmlkICpjZmlkLCAqcTsKIAlMSVNUX0hFQUQoZW50cnkpOwogCisJ
aWYgKGNmaWRzID09IE5VTEwpCisJCXJldHVybjsKKwogCWlmIChjZmlkcy0+bGF1bmRyb21hdCkg
ewogCQlrdGhyZWFkX3N0b3AoY2ZpZHMtPmxhdW5kcm9tYXQpOwogCQljZmlkcy0+bGF1bmRyb21h
dCA9IE5VTEw7CmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L2NpZnNnbG9iLmggYi9mcy9zbWIv
Y2xpZW50L2NpZnNnbG9iLmgKaW5kZXggMDMyZDg3MTZmNjcxLi5mNTk0ZmNjMGU4ODkgMTAwNjQ0
Ci0tLSBhL2ZzL3NtYi9jbGllbnQvY2lmc2dsb2IuaAorKysgYi9mcy9zbWIvY2xpZW50L2NpZnNn
bG9iLmgKQEAgLTE5NDMsNyArMTk0Myw3IEBAIHJlcXVpcmUgdXNlIG9mIHRoZSBzdHJvbmdlciBw
cm90b2NvbCAqLwogICogY2lmc0lub2RlSW5mby0+bG9ja19zZW0JY2lmc0lub2RlSW5mby0+bGxp
c3QJCWNpZnNfaW5pdF9vbmNlCiAgKgkJCQktPmNhbl9jYWNoZV9icmxja3MKICAqIGNpZnNJbm9k
ZUluZm8tPmRlZmVycmVkX2xvY2sJY2lmc0lub2RlSW5mby0+ZGVmZXJyZWRfY2xvc2VzCWNpZnNJ
bm9kZUluZm9fYWxsb2MKLSAqIGNhY2hlZF9maWQtPmZpZF9tdXRleAkJY2lmc190Y29uLT5jcmZp
ZAkJdGNvbkluZm9BbGxvYworICogY2FjaGVkX2ZpZC0+ZmlkX211dGV4CQljaWZzX3Rjb24tPmNy
ZmlkCQl0Y29uX2luZm9fYWxsb2MKICAqIGNpZnNGaWxlSW5mby0+ZmhfbXV0ZXgJCWNpZnNGaWxl
SW5mbwkJCWNpZnNfbmV3X2ZpbGVpbmZvCiAgKiBjaWZzRmlsZUluZm8tPmZpbGVfaW5mb19sb2Nr
CWNpZnNGaWxlSW5mby0+Y291bnQJCWNpZnNfbmV3X2ZpbGVpbmZvCiAgKgkJCQktPmludmFsaWRI
YW5kbGUJCQlpbml0aWF0ZV9jaWZzX3NlYXJjaApkaWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC9j
aWZzcHJvdG8uaCBiL2ZzL3NtYi9jbGllbnQvY2lmc3Byb3RvLmgKaW5kZXggN2Q4MDM1ODQ2Njgw
Li4wYzM3ZWVmYTE4YTUgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvY2lmc3Byb3RvLmgKKysr
IGIvZnMvc21iL2NsaWVudC9jaWZzcHJvdG8uaApAQCAtNTEyLDcgKzUxMiw3IEBAIGV4dGVybiBp
bnQgQ0lGU1NNQkxvZ29mZihjb25zdCB1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1Y3QgY2lmc19zZXMg
KnNlcyk7CiAKIGV4dGVybiBzdHJ1Y3QgY2lmc19zZXMgKnNlc0luZm9BbGxvYyh2b2lkKTsKIGV4
dGVybiB2b2lkIHNlc0luZm9GcmVlKHN0cnVjdCBjaWZzX3NlcyAqKTsKLWV4dGVybiBzdHJ1Y3Qg
Y2lmc190Y29uICp0Y29uSW5mb0FsbG9jKHZvaWQpOworZXh0ZXJuIHN0cnVjdCBjaWZzX3Rjb24g
KnRjb25faW5mb19hbGxvYyhib29sIGRpcl9sZWFzZXNfZW5hYmxlZCk7CiBleHRlcm4gdm9pZCB0
Y29uSW5mb0ZyZWUoc3RydWN0IGNpZnNfdGNvbiAqKTsKIAogZXh0ZXJuIGludCBjaWZzX3NpZ25f
cnFzdChzdHJ1Y3Qgc21iX3Jxc3QgKnJxc3QsIHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNlcnZl
ciwKZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvY29ubmVjdC5jIGIvZnMvc21iL2NsaWVudC9j
b25uZWN0LmMKaW5kZXggNjg3NzU0NzkxYmYwLi4zOTAyZTkwZGNhNmIgMTAwNjQ0Ci0tLSBhL2Zz
L3NtYi9jbGllbnQvY29ubmVjdC5jCisrKyBiL2ZzL3NtYi9jbGllbnQvY29ubmVjdC5jCkBAIC0x
ODgyLDcgKzE4ODIsOCBAQCBjaWZzX3NldHVwX2lwYyhzdHJ1Y3QgY2lmc19zZXMgKnNlcywgc3Ry
dWN0IHNtYjNfZnNfY29udGV4dCAqY3R4KQogCQl9CiAJfQogCi0JdGNvbiA9IHRjb25JbmZvQWxs
b2MoKTsKKwkvKiBubyBuZWVkIHRvIHNldHVwIGRpcmVjdG9yeSBjYWNoaW5nIG9uIElQQyBzaGFy
ZSwgc28gcGFzcyBpbiBmYWxzZSAqLworCXRjb24gPSB0Y29uX2luZm9fYWxsb2MoZmFsc2UpOwog
CWlmICh0Y29uID09IE5VTEwpCiAJCXJldHVybiAtRU5PTUVNOwogCkBAIC0yNDkyLDcgKzI0OTMs
MTAgQEAgY2lmc19nZXRfdGNvbihzdHJ1Y3QgY2lmc19zZXMgKnNlcywgc3RydWN0IHNtYjNfZnNf
Y29udGV4dCAqY3R4KQogCQlnb3RvIG91dF9mYWlsOwogCX0KIAotCXRjb24gPSB0Y29uSW5mb0Fs
bG9jKCk7CisJaWYgKHNlcy0+c2VydmVyLT5jYXBhYmlsaXRpZXMgJiBTTUIyX0dMT0JBTF9DQVBf
RElSRUNUT1JZX0xFQVNJTkcpCisJCXRjb24gPSB0Y29uX2luZm9fYWxsb2ModHJ1ZSk7CisJZWxz
ZQorCQl0Y29uID0gdGNvbl9pbmZvX2FsbG9jKGZhbHNlKTsKIAlpZiAodGNvbiA9PSBOVUxMKSB7
CiAJCXJjID0gLUVOT01FTTsKIAkJZ290byBvdXRfZmFpbDsKZGlmZiAtLWdpdCBhL2ZzL3NtYi9j
bGllbnQvbWlzYy5jIGIvZnMvc21iL2NsaWVudC9taXNjLmMKaW5kZXggMzY2Yjc1NWNhOTEzLi4z
NWIxNzY0NTdiYmUgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvbWlzYy5jCisrKyBiL2ZzL3Nt
Yi9jbGllbnQvbWlzYy5jCkBAIC0xMTMsMTggKzExMywyMiBAQCBzZXNJbmZvRnJlZShzdHJ1Y3Qg
Y2lmc19zZXMgKmJ1Zl90b19mcmVlKQogfQogCiBzdHJ1Y3QgY2lmc190Y29uICoKLXRjb25JbmZv
QWxsb2Modm9pZCkKK3Rjb25faW5mb19hbGxvYyhib29sIGRpcl9sZWFzZXNfZW5hYmxlZCkKIHsK
IAlzdHJ1Y3QgY2lmc190Y29uICpyZXRfYnVmOwogCiAJcmV0X2J1ZiA9IGt6YWxsb2Moc2l6ZW9m
KCpyZXRfYnVmKSwgR0ZQX0tFUk5FTCk7CiAJaWYgKCFyZXRfYnVmKQogCQlyZXR1cm4gTlVMTDsK
LQlyZXRfYnVmLT5jZmlkcyA9IGluaXRfY2FjaGVkX2RpcnMoKTsKLQlpZiAoIXJldF9idWYtPmNm
aWRzKSB7Ci0JCWtmcmVlKHJldF9idWYpOwotCQlyZXR1cm4gTlVMTDsKKworCWlmIChkaXJfbGVh
c2VzX2VuYWJsZWQgPT0gdHJ1ZSkgeworCQlyZXRfYnVmLT5jZmlkcyA9IGluaXRfY2FjaGVkX2Rp
cnMoKTsKKwkJaWYgKCFyZXRfYnVmLT5jZmlkcykgeworCQkJa2ZyZWUocmV0X2J1Zik7CisJCQly
ZXR1cm4gTlVMTDsKKwkJfQogCX0KKwkvKiBlbHNlIHJldF9idWYtPmNmaWRzIGlzIGFscmVhZHkg
c2V0IHRvIE5VTEwgYWJvdmUgKi8KIAogCWF0b21pY19pbmMoJnRjb25JbmZvQWxsb2NDb3VudCk7
CiAJcmV0X2J1Zi0+c3RhdHVzID0gVElEX05FVzsKZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQv
c21iMnBkdS5jIGIvZnMvc21iL2NsaWVudC9zbWIycGR1LmMKaW5kZXggNDRkNDk0M2U5YzU2Li40
MDVlYTMyNGYyOGQgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvc21iMnBkdS5jCisrKyBiL2Zz
L3NtYi9jbGllbnQvc21iMnBkdS5jCkBAIC0zODc4LDcgKzM4NzgsNyBAQCB2b2lkIHNtYjJfcmVj
b25uZWN0X3NlcnZlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJCWdvdG8gZG9uZTsKIAog
CS8qIGFsbG9jYXRlIGEgZHVtbXkgdGNvbiBzdHJ1Y3QgdXNlZCBmb3IgcmVjb25uZWN0ICovCi0J
dGNvbiA9IHRjb25JbmZvQWxsb2MoKTsKKwl0Y29uID0gdGNvbl9pbmZvX2FsbG9jKGZhbHNlKTsK
IAlpZiAoIXRjb24pIHsKIAkJcmVzY2hlZCA9IHRydWU7CiAJCWxpc3RfZm9yX2VhY2hfZW50cnlf
c2FmZShzZXMsIHNlczIsICZ0bXBfc2VzX2xpc3QsIHJsaXN0KSB7Ci0tIAoyLjM5LjIKCg==
--000000000000f1d6d40605b8e590--
