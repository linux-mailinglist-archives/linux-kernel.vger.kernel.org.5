Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37617DA581
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 09:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjJ1Hmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 03:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJ1Hmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 03:42:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9ADE1;
        Sat, 28 Oct 2023 00:42:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCA8C433CC;
        Sat, 28 Oct 2023 07:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698478961;
        bh=htUU5NgNW5XjX1k4bhwOpjiaCPHzbKJXSRlXtBMXaaI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SLt9RpRk04EaksB4alsV5juWqDKrrkoFjxUkbGOZ7QmCkr5DaOIcuWvzpg2KRZFs4
         oyNj7h+Nu2x3s/nz8wlUOhoDuxjmHXZ81/fxdhC/0g5Voz0M9n1SONNKBWxBpMncFw
         lBKCeI9FyvIc3DaiiGzH06wGVU7T0+DOcEqxXG5+SBgGefDMATnj9bRNWCQvHdXZeM
         FyqwXfRoKQYSCd/fmacxctuND9MgMxzBI8ScDwHMoocjekC8Ee6ezXeZ/nIzGkSYtn
         mnayYsRVJbFeSef6Ffe/Rd0T+4ssNkfDQtYf7XwHBc5QWDgU4QDZ0Wt0a762+yDV6w
         L93MhRkYGp9Cg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-507a62d4788so4346139e87.0;
        Sat, 28 Oct 2023 00:42:41 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzk/iHOJ5O2mT+ydEWzcvjd85tgVWvUTSmwTTkDwf9wg6+iPIKu
        cby8vZP+KDCNViIlRKuWA1v7c/ka76ewDvg6yD0=
X-Google-Smtp-Source: AGHT+IFiTcDct53OijnP1Dv//ljwa/j8p7snP2xWb1MXmhUAIVhLZvUBdZmrQEndHPbZWL2iA8aWwpyIs51gK8PaGng=
X-Received: by 2002:ac2:4835:0:b0:507:9ff7:2ed4 with SMTP id
 21-20020ac24835000000b005079ff72ed4mr3299897lft.43.1698478959384; Sat, 28 Oct
 2023 00:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsCskpn_TNpSwLq9HGUgtT=aZpDzs7SVrqpa9WmyYFaxQ@mail.gmail.com>
 <ZTqGBzOQd4Oi3e9j@FVFF77S0Q05N.cambridge.arm.com> <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
 <CA+G9fYuQxUhsrL_=uYSAdotU1_Wx7iu5PxFuG9EzWgBE2nMjcw@mail.gmail.com>
In-Reply-To: <CA+G9fYuQxUhsrL_=uYSAdotU1_Wx7iu5PxFuG9EzWgBE2nMjcw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 28 Oct 2023 09:42:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXESknQ40SZRMFv6Vv32x-2mSuMyOxoURQwwO1apQ+m=jA@mail.gmail.com>
Message-ID: <CAMj1kXESknQ40SZRMFv6Vv32x-2mSuMyOxoURQwwO1apQ+m=jA@mail.gmail.com>
Subject: Re: qemu-arm64: handle_futex_death - kernel/futex/core.c:661 - Unable
 to handle kernel unknown 43 at virtual address
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        LTP List <ltp@lists.linux.it>, Petr Vorel <pvorel@suse.cz>
Content-Type: multipart/mixed; boundary="000000000000087d0c0608c1f337"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000087d0c0608c1f337
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Oct 2023 at 12:57, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Thu, 26 Oct 2023 at 21:09, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 26 Oct 2023 at 17:30, Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Thu, Oct 26, 2023 at 08:11:26PM +0530, Naresh Kamboju wrote:
> > > > Following kernel crash noticed on qemu-arm64 while running LTP syscalls
> > > > set_robust_list test case running Linux next 6.6.0-rc7-next-20231026 ...
> > > It looks like this is fallout from the LPA2 enablement.
> > >
> > > According to the latest ARM ARM (ARM DDI 0487J.a), page D19-6475, that "unknown
> > > 43" (0x2b / 0b101011) is the DFSC for a level -1 translation fault:
> > >
> > >         0b101011 When FEAT_LPA2 is implemented:
> > >                  Translation fault, level -1.
> > >
> > > It's triggered here by an LDTR in a get_user() on a bogus userspace address.
> > > The exception is expected, and it's supposed to be handled via the exception
> > > fixups, but the LPA2 patches didn't update the fault_info table entries for all
> > > the level -1 faults, and so those all get handled by do_bad() and don't call
> > > fixup_exception(), causing them to be fatal.
> > >
> > > It should be relatively simple to update the fault_info table for the level -1
> > > faults, but given the other issues we're seeing I think it's probably worth
> > > dropping the LPA2 patches for the moment.
> > >
> >
> > Thanks for the analysis Mark.
> >
> > I agree that this should not be difficult to fix, but given the other
> > CI problems and identified loose ends, I am not going to object to
> > dropping this partially or entirely at this point. I'm sure everybody
> > will be thrilled to go over those 60 patches again after I rebase them
> > onto v6.7-rc1 :-)
>
> I am happy to test any proposed fix patch.
>

Thanks Naresh. Patch attached.

--000000000000087d0c0608c1f337
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Add-missing-ESR-decoding-for-level-1-translation-fau.patch"
Content-Disposition: attachment; 
	filename="0001-Add-missing-ESR-decoding-for-level-1-translation-fau.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lo9qibwf0>
X-Attachment-Id: f_lo9qibwf0

RnJvbSAwZDNjOWQzOWE0NTQxZjdjNWRlYTUxNzVhZGVhMmFmNjNlYzFiOTJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPgpEYXRl
OiBTYXQsIDI4IE9jdCAyMDIzIDA5OjQwOjI5ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gQWRkIG1p
c3NpbmcgRVNSIGRlY29kaW5nIGZvciBsZXZlbCAtMSB0cmFuc2xhdGlvbiBmYXVsdHMKClNpZ25l
ZC1vZmYtYnk6IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+Ci0tLQogYXJjaC9hcm02
NC9tbS9mYXVsdC5jIHwgOCArKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L21tL2ZhdWx0LmMgYi9h
cmNoL2FybTY0L21tL2ZhdWx0LmMKaW5kZXggNDYwZDc5OWUxMjk2Li4yMjMxOGQ1NjA4N2QgMTAw
NjQ0Ci0tLSBhL2FyY2gvYXJtNjQvbW0vZmF1bHQuYworKysgYi9hcmNoL2FybTY0L21tL2ZhdWx0
LmMKQEAgLTc5MSw3ICs3OTEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZhdWx0X2luZm8gZmF1
bHRfaW5mb1tdID0gewogCXsgZG9fc2VhLAkJU0lHQlVTLCAgQlVTX09CSkVSUiwJInN5bmNocm9u
b3VzIGV4dGVybmFsIGFib3J0Igl9LAogCXsgZG9fdGFnX2NoZWNrX2ZhdWx0LAlTSUdTRUdWLCBT
RUdWX01URVNFUlIsCSJzeW5jaHJvbm91cyB0YWcgY2hlY2sgZmF1bHQiCX0sCiAJeyBkb19iYWQs
CQlTSUdLSUxMLCBTSV9LRVJORUwsCSJ1bmtub3duIDE4IgkJCX0sCi0JeyBkb19iYWQsCQlTSUdL
SUxMLCBTSV9LRVJORUwsCSJ1bmtub3duIDE5IgkJCX0sCisJeyBkb19zZWEsCQlTSUdLSUxMLCBT
SV9LRVJORUwsCSJsZXZlbCAtMSAodHJhbnNsYXRpb24gdGFibGUgd2FsaykiCX0sCiAJeyBkb19z
ZWEsCQlTSUdLSUxMLCBTSV9LRVJORUwsCSJsZXZlbCAwICh0cmFuc2xhdGlvbiB0YWJsZSB3YWxr
KSIJfSwKIAl7IGRvX3NlYSwJCVNJR0tJTEwsIFNJX0tFUk5FTCwJImxldmVsIDEgKHRyYW5zbGF0
aW9uIHRhYmxlIHdhbGspIgl9LAogCXsgZG9fc2VhLAkJU0lHS0lMTCwgU0lfS0VSTkVMLAkibGV2
ZWwgMiAodHJhbnNsYXRpb24gdGFibGUgd2FsaykiCX0sCkBAIC03OTksNyArNzk5LDcgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBmYXVsdF9pbmZvIGZhdWx0X2luZm9bXSA9IHsKIAl7IGRvX3NlYSwJ
CVNJR0JVUywgIEJVU19PQkpFUlIsCSJzeW5jaHJvbm91cyBwYXJpdHkgb3IgRUNDIGVycm9yIiB9
LAkvLyBSZXNlcnZlZCB3aGVuIFJBUyBpcyBpbXBsZW1lbnRlZAogCXsgZG9fYmFkLAkJU0lHS0lM
TCwgU0lfS0VSTkVMLAkidW5rbm93biAyNSIJCQl9LAogCXsgZG9fYmFkLAkJU0lHS0lMTCwgU0lf
S0VSTkVMLAkidW5rbm93biAyNiIJCQl9LAotCXsgZG9fYmFkLAkJU0lHS0lMTCwgU0lfS0VSTkVM
LAkidW5rbm93biAyNyIJCQl9LAorCXsgZG9fc2VhLAkJU0lHS0lMTCwgU0lfS0VSTkVMLAkibGV2
ZWwgLTEgc3luY2hyb25vdXMgcGFyaXR5IGVycm9yICh0cmFuc2xhdGlvbiB0YWJsZSB3YWxrKSIJ
fSwJLy8gUmVzZXJ2ZWQgd2hlbiBSQVMgaXMgaW1wbGVtZW50ZWQKIAl7IGRvX3NlYSwJCVNJR0tJ
TEwsIFNJX0tFUk5FTCwJImxldmVsIDAgc3luY2hyb25vdXMgcGFyaXR5IGVycm9yICh0cmFuc2xh
dGlvbiB0YWJsZSB3YWxrKSIJfSwJLy8gUmVzZXJ2ZWQgd2hlbiBSQVMgaXMgaW1wbGVtZW50ZWQK
IAl7IGRvX3NlYSwJCVNJR0tJTEwsIFNJX0tFUk5FTCwJImxldmVsIDEgc3luY2hyb25vdXMgcGFy
aXR5IGVycm9yICh0cmFuc2xhdGlvbiB0YWJsZSB3YWxrKSIJfSwJLy8gUmVzZXJ2ZWQgd2hlbiBS
QVMgaXMgaW1wbGVtZW50ZWQKIAl7IGRvX3NlYSwJCVNJR0tJTEwsIFNJX0tFUk5FTCwJImxldmVs
IDIgc3luY2hyb25vdXMgcGFyaXR5IGVycm9yICh0cmFuc2xhdGlvbiB0YWJsZSB3YWxrKSIJfSwJ
Ly8gUmVzZXJ2ZWQgd2hlbiBSQVMgaXMgaW1wbGVtZW50ZWQKQEAgLTgxMSw5ICs4MTEsOSBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IGZhdWx0X2luZm8gZmF1bHRfaW5mb1tdID0gewogCXsgZG9fYmFk
LAkJU0lHS0lMTCwgU0lfS0VSTkVMLAkidW5rbm93biAzNiIJCQl9LAogCXsgZG9fYmFkLAkJU0lH
S0lMTCwgU0lfS0VSTkVMLAkidW5rbm93biAzNyIJCQl9LAogCXsgZG9fYmFkLAkJU0lHS0lMTCwg
U0lfS0VSTkVMLAkidW5rbm93biAzOCIJCQl9LAotCXsgZG9fYmFkLAkJU0lHS0lMTCwgU0lfS0VS
TkVMLAkidW5rbm93biAzOSIJCQl9LAorCXsgZG9fYmFkLAkJU0lHS0lMTCwgU0lfS0VSTkVMLAki
bGV2ZWwgLTEgYWRkcmVzcyBzaXplIGZhdWx0Igl9LAogCXsgZG9fYmFkLAkJU0lHS0lMTCwgU0lf
S0VSTkVMLAkidW5rbm93biA0MCIJCQl9LAotCXsgZG9fYmFkLAkJU0lHS0lMTCwgU0lfS0VSTkVM
LAkidW5rbm93biA0MSIJCQl9LAorCXsgZG9fdHJhbnNsYXRpb25fZmF1bHQsCVNJR1NFR1YsIFNF
R1ZfTUFQRVJSLAkibGV2ZWwgLTEgdHJhbnNsYXRpb24gZmF1bHQiCX0sCiAJeyBkb19iYWQsCQlT
SUdLSUxMLCBTSV9LRVJORUwsCSJ1bmtub3duIDQyIgkJCX0sCiAJeyBkb19iYWQsCQlTSUdLSUxM
LCBTSV9LRVJORUwsCSJ1bmtub3duIDQzIgkJCX0sCiAJeyBkb19iYWQsCQlTSUdLSUxMLCBTSV9L
RVJORUwsCSJ1bmtub3duIDQ0IgkJCX0sCi0tIAoyLjM5LjIKCg==
--000000000000087d0c0608c1f337--
