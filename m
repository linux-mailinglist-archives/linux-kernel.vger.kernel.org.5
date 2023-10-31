Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0767DC782
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343667AbjJaHnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbjJaHna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:43:30 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844FCC1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:43:23 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-457bc2de48dso2247240137.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698738202; x=1699343002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D7CFAeZxpqqyg0TPZNDgQgUrC155Qrh9XqLfWlj2DOo=;
        b=wB4qtEkPSKDnZ/cyVcb0rYy2sOplWJLo5+RGhJ4T3R3+ZkvU5peQUPxvm5Zivin2kn
         m6dwOzJxkS8+2uMTwn97E73e39BFpqLPC2RL8jKZSExv6wNlHGjKZ8hNPMwzm9ASGgd+
         dXcl2e78D5aO2dNH2bwDPjE8i8wd683MLr+BpypwFEiQEuXdsg5CGnKISJgaoInF7ldt
         fkc1MUmmdaYnA5sWFX8vv89MXEcormnJljJkZkgl1RREWtRRN4uSXhKtfxcLQbquKoT0
         m5oTrShTUajfENKUOP6Dye1MhgZhlcylJZq/lab4lie9bnOYbqOHb7Fs5PXCufJU/otk
         WlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698738202; x=1699343002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7CFAeZxpqqyg0TPZNDgQgUrC155Qrh9XqLfWlj2DOo=;
        b=O/TfEh7bwGMzktHqg/ognpKF+DhORiaOnJYmqEara54mcPY4yvZ1HbOC+c/kGZ4lgv
         Og27xKG3zZt5C6geTcIyMLzmdmvNJQs1w2dSm6eAPwIVIa3XUNRyVOsbWDRR9Yr9/DuK
         70FF9JhaNKmM0wJ6pTgfFznyaWqLWGImIfHu1Y1qo+BoqIP5OO/NRgfBQi8yJ8/eNFwd
         3XAslSm0uVNS/rWdYWd5qc8xED5/cT+taNbVW8rAbmdbxIzXb3I3YZ5Ld1Ig7lFI73tc
         AsPEOk6pm0WEWxhHrS7K9qdUUuAk87ViNwKctyIihO2TmTH++NtIL3Q4jh+jJm4VrqQx
         y5TQ==
X-Gm-Message-State: AOJu0YzUr4N7oSa5VGDBA+H5xsPK70VNKaL9/b/vThn+YTZPUGXZ21g1
        F7prQS09/HWTS5gN6VSTMq0Nmcy1tYsaJoypsdDanKhaJRPe9oLIgrA=
X-Google-Smtp-Source: AGHT+IEviXasTdJ61T5Z7Jo958RBLuU9DCFLECPI5hHVFGbilE7uM1oG5pcWXvUVLSzYb1F41vEHhOHdQE+ERMZ8mwQ=
X-Received: by 2002:a67:ef12:0:b0:457:6b29:9486 with SMTP id
 j18-20020a67ef12000000b004576b299486mr8205164vsr.33.1698738202417; Tue, 31
 Oct 2023 00:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsCskpn_TNpSwLq9HGUgtT=aZpDzs7SVrqpa9WmyYFaxQ@mail.gmail.com>
 <ZTqGBzOQd4Oi3e9j@FVFF77S0Q05N.cambridge.arm.com> <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
 <CA+G9fYuQxUhsrL_=uYSAdotU1_Wx7iu5PxFuG9EzWgBE2nMjcw@mail.gmail.com>
 <CAMj1kXESknQ40SZRMFv6Vv32x-2mSuMyOxoURQwwO1apQ+m=jA@mail.gmail.com>
 <CA+G9fYv3Ph6UDpW1uhoXD5QBE4tAZKpUkVy-Oo9NNrghChL_+A@mail.gmail.com>
 <CAMj1kXE9c3YVbiuwB6cQnWsmUu_kh=vnipJgitYcUh_HWeS=OA@mail.gmail.com> <CA+G9fYsyDQZmsHpN+4qv8q_DsagKbmDZ5vjo60QDEr+uCVXoNA@mail.gmail.com>
In-Reply-To: <CA+G9fYsyDQZmsHpN+4qv8q_DsagKbmDZ5vjo60QDEr+uCVXoNA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 31 Oct 2023 13:13:10 +0530
Message-ID: <CA+G9fYsuoM9GfrcWXu+M0E21JaBmZ6F0uPpQy1ez4xCptVPj6g@mail.gmail.com>
Subject: Re: qemu-arm64: handle_futex_death - kernel/futex/core.c:661 - Unable
 to handle kernel unknown 43 at virtual address
To:     Ard Biesheuvel <ardb@kernel.org>
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
Content-Type: multipart/mixed; boundary="0000000000001f59930608fe4fa5"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001f59930608fe4fa5
Content-Type: text/plain; charset="UTF-8"

Hi Ard,

Your V2 patch works perfectly.
Thanks for providing a fix patch.

- Naresh

On Mon, 30 Oct 2023 at 17:20, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Mon, 30 Oct 2023 at 13:45, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 30 Oct 2023 at 09:07, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Sat, 28 Oct 2023 at 13:12, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Fri, 27 Oct 2023 at 12:57, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > > >
> > > > > On Thu, 26 Oct 2023 at 21:09, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, 26 Oct 2023 at 17:30, Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 26, 2023 at 08:11:26PM +0530, Naresh Kamboju wrote:
> > > > > > > > Following kernel crash noticed on qemu-arm64 while running LTP syscalls
> > > > > > > > set_robust_list test case running Linux next 6.6.0-rc7-next-20231026 ...
> > > > > > > It looks like this is fallout from the LPA2 enablement.
> > > > > > >
> > > > > > > According to the latest ARM ARM (ARM DDI 0487J.a), page D19-6475, that "unknown
> > > > > > > 43" (0x2b / 0b101011) is the DFSC for a level -1 translation fault:
> > > > > > >
> > > > > > >         0b101011 When FEAT_LPA2 is implemented:
> > > > > > >                  Translation fault, level -1.
> > > > > > >
> > > > > > > It's triggered here by an LDTR in a get_user() on a bogus userspace address.
> > > > > > > The exception is expected, and it's supposed to be handled via the exception
> > > > > > > fixups, but the LPA2 patches didn't update the fault_info table entries for all
> > > > > > > the level -1 faults, and so those all get handled by do_bad() and don't call
> > > > > > > fixup_exception(), causing them to be fatal.
> > > > > > >
> > > > > > > It should be relatively simple to update the fault_info table for the level -1
> > > > > > > faults, but given the other issues we're seeing I think it's probably worth
> > > > > > > dropping the LPA2 patches for the moment.
> > > > > > >
> > > > > >
> > > > > > Thanks for the analysis Mark.
> > > > > >
> > > > > > I agree that this should not be difficult to fix, but given the other
> > > > > > CI problems and identified loose ends, I am not going to object to
> > > > > > dropping this partially or entirely at this point. I'm sure everybody
> > > > > > will be thrilled to go over those 60 patches again after I rebase them
> > > > > > onto v6.7-rc1 :-)
> > > > >
> > > > > I am happy to test any proposed fix patch.
> > > > >
> > > >
> > > > Thanks Naresh. Patch attached.
> > >
> > > This patch did not solve the reported problem.
> > > Test log links,
> > >  - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/naresh/tests/2XTP1lXcUUscT357YaAm2G1AhpS
> > >
> >
> > Oops, sorry about that.
> >
> > Fixed patch attched.
>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> - Naresh

--0000000000001f59930608fe4fa5
Content-Type: application/x-patch; 
	name="v2-0001-Add-missing-ESR-decoding-for-level-1-translation-.patch"
Content-Disposition: attachment; 
	filename="v2-0001-Add-missing-ESR-decoding-for-level-1-translation-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_locmjrdg0>
X-Attachment-Id: f_locmjrdg0

RnJvbSA5N2RlYTQzMmJjZWFkZmNlY2U4NDQ4NDYwOTM3NGMyNzdhZmMyYzgxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPgpEYXRl
OiBTYXQsIDI4IE9jdCAyMDIzIDA5OjQwOjI5ICswMjAwClN1YmplY3Q6IFtQQVRDSCB2Ml0gQWRk
IG1pc3NpbmcgRVNSIGRlY29kaW5nIGZvciBsZXZlbCAtMSB0cmFuc2xhdGlvbiBmYXVsdHMKClNp
Z25lZC1vZmYtYnk6IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+Ci0tLQogYXJjaC9h
cm02NC9tbS9mYXVsdC5jIHwgMTIgKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvbW0vZmF1
bHQuYyBiL2FyY2gvYXJtNjQvbW0vZmF1bHQuYwppbmRleCAyZTVkMWUyMzhhZjkuLjEzZjE5MjY5
MTA2MCAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9tbS9mYXVsdC5jCisrKyBiL2FyY2gvYXJtNjQv
bW0vZmF1bHQuYwpAQCAtNzgwLDE4ICs3ODAsMTggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmYXVs
dF9pbmZvIGZhdWx0X2luZm9bXSA9IHsKIAl7IGRvX3RyYW5zbGF0aW9uX2ZhdWx0LAlTSUdTRUdW
LCBTRUdWX01BUEVSUiwJImxldmVsIDEgdHJhbnNsYXRpb24gZmF1bHQiCX0sCiAJeyBkb190cmFu
c2xhdGlvbl9mYXVsdCwJU0lHU0VHViwgU0VHVl9NQVBFUlIsCSJsZXZlbCAyIHRyYW5zbGF0aW9u
IGZhdWx0Igl9LAogCXsgZG9fdHJhbnNsYXRpb25fZmF1bHQsCVNJR1NFR1YsIFNFR1ZfTUFQRVJS
LAkibGV2ZWwgMyB0cmFuc2xhdGlvbiBmYXVsdCIJfSwKLQl7IGRvX2JhZCwJCVNJR0tJTEwsIFNJ
X0tFUk5FTCwJInVua25vd24gOCIJCQl9LAorCXsgZG9fcGFnZV9mYXVsdCwJU0lHU0VHViwgU0VH
Vl9BQ0NFUlIsCSJsZXZlbCAwIGFjY2VzcyBmbGFnIGZhdWx0Igl9LAogCXsgZG9fcGFnZV9mYXVs
dCwJU0lHU0VHViwgU0VHVl9BQ0NFUlIsCSJsZXZlbCAxIGFjY2VzcyBmbGFnIGZhdWx0Igl9LAog
CXsgZG9fcGFnZV9mYXVsdCwJU0lHU0VHViwgU0VHVl9BQ0NFUlIsCSJsZXZlbCAyIGFjY2VzcyBm
bGFnIGZhdWx0Igl9LAogCXsgZG9fcGFnZV9mYXVsdCwJU0lHU0VHViwgU0VHVl9BQ0NFUlIsCSJs
ZXZlbCAzIGFjY2VzcyBmbGFnIGZhdWx0Igl9LAotCXsgZG9fYmFkLAkJU0lHS0lMTCwgU0lfS0VS
TkVMLAkidW5rbm93biAxMiIJCQl9LAorCXsgZG9fcGFnZV9mYXVsdCwJU0lHU0VHViwgU0VHVl9B
Q0NFUlIsCSJsZXZlbCAwIHBlcm1pc3Npb24gZmF1bHQiCX0sCiAJeyBkb19wYWdlX2ZhdWx0LAlT
SUdTRUdWLCBTRUdWX0FDQ0VSUiwJImxldmVsIDEgcGVybWlzc2lvbiBmYXVsdCIJfSwKIAl7IGRv
X3BhZ2VfZmF1bHQsCVNJR1NFR1YsIFNFR1ZfQUNDRVJSLAkibGV2ZWwgMiBwZXJtaXNzaW9uIGZh
dWx0Igl9LAogCXsgZG9fcGFnZV9mYXVsdCwJU0lHU0VHViwgU0VHVl9BQ0NFUlIsCSJsZXZlbCAz
IHBlcm1pc3Npb24gZmF1bHQiCX0sCiAJeyBkb19zZWEsCQlTSUdCVVMsICBCVVNfT0JKRVJSLAki
c3luY2hyb25vdXMgZXh0ZXJuYWwgYWJvcnQiCX0sCiAJeyBkb190YWdfY2hlY2tfZmF1bHQsCVNJ
R1NFR1YsIFNFR1ZfTVRFU0VSUiwJInN5bmNocm9ub3VzIHRhZyBjaGVjayBmYXVsdCIJfSwKIAl7
IGRvX2JhZCwJCVNJR0tJTEwsIFNJX0tFUk5FTCwJInVua25vd24gMTgiCQkJfSwKLQl7IGRvX2Jh
ZCwJCVNJR0tJTEwsIFNJX0tFUk5FTCwJInVua25vd24gMTkiCQkJfSwKKwl7IGRvX3NlYSwJCVNJ
R0tJTEwsIFNJX0tFUk5FTCwJImxldmVsIC0xICh0cmFuc2xhdGlvbiB0YWJsZSB3YWxrKSIJfSwK
IAl7IGRvX3NlYSwJCVNJR0tJTEwsIFNJX0tFUk5FTCwJImxldmVsIDAgKHRyYW5zbGF0aW9uIHRh
YmxlIHdhbGspIgl9LAogCXsgZG9fc2VhLAkJU0lHS0lMTCwgU0lfS0VSTkVMLAkibGV2ZWwgMSAo
dHJhbnNsYXRpb24gdGFibGUgd2FsaykiCX0sCiAJeyBkb19zZWEsCQlTSUdLSUxMLCBTSV9LRVJO
RUwsCSJsZXZlbCAyICh0cmFuc2xhdGlvbiB0YWJsZSB3YWxrKSIJfSwKQEAgLTc5OSw3ICs3OTks
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZhdWx0X2luZm8gZmF1bHRfaW5mb1tdID0gewogCXsg
ZG9fc2VhLAkJU0lHQlVTLCAgQlVTX09CSkVSUiwJInN5bmNocm9ub3VzIHBhcml0eSBvciBFQ0Mg
ZXJyb3IiIH0sCS8vIFJlc2VydmVkIHdoZW4gUkFTIGlzIGltcGxlbWVudGVkCiAJeyBkb19iYWQs
CQlTSUdLSUxMLCBTSV9LRVJORUwsCSJ1bmtub3duIDI1IgkJCX0sCiAJeyBkb19iYWQsCQlTSUdL
SUxMLCBTSV9LRVJORUwsCSJ1bmtub3duIDI2IgkJCX0sCi0JeyBkb19iYWQsCQlTSUdLSUxMLCBT
SV9LRVJORUwsCSJ1bmtub3duIDI3IgkJCX0sCisJeyBkb19zZWEsCQlTSUdLSUxMLCBTSV9LRVJO
RUwsCSJsZXZlbCAtMSBzeW5jaHJvbm91cyBwYXJpdHkgZXJyb3IgKHRyYW5zbGF0aW9uIHRhYmxl
IHdhbGspIgl9LAkvLyBSZXNlcnZlZCB3aGVuIFJBUyBpcyBpbXBsZW1lbnRlZAogCXsgZG9fc2Vh
LAkJU0lHS0lMTCwgU0lfS0VSTkVMLAkibGV2ZWwgMCBzeW5jaHJvbm91cyBwYXJpdHkgZXJyb3Ig
KHRyYW5zbGF0aW9uIHRhYmxlIHdhbGspIgl9LAkvLyBSZXNlcnZlZCB3aGVuIFJBUyBpcyBpbXBs
ZW1lbnRlZAogCXsgZG9fc2VhLAkJU0lHS0lMTCwgU0lfS0VSTkVMLAkibGV2ZWwgMSBzeW5jaHJv
bm91cyBwYXJpdHkgZXJyb3IgKHRyYW5zbGF0aW9uIHRhYmxlIHdhbGspIgl9LAkvLyBSZXNlcnZl
ZCB3aGVuIFJBUyBpcyBpbXBsZW1lbnRlZAogCXsgZG9fc2VhLAkJU0lHS0lMTCwgU0lfS0VSTkVM
LAkibGV2ZWwgMiBzeW5jaHJvbm91cyBwYXJpdHkgZXJyb3IgKHRyYW5zbGF0aW9uIHRhYmxlIHdh
bGspIgl9LAkvLyBSZXNlcnZlZCB3aGVuIFJBUyBpcyBpbXBsZW1lbnRlZApAQCAtODEzLDkgKzgx
Myw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmF1bHRfaW5mbyBmYXVsdF9pbmZvW10gPSB7CiAJ
eyBkb19iYWQsCQlTSUdLSUxMLCBTSV9LRVJORUwsCSJ1bmtub3duIDM4IgkJCX0sCiAJeyBkb19i
YWQsCQlTSUdLSUxMLCBTSV9LRVJORUwsCSJ1bmtub3duIDM5IgkJCX0sCiAJeyBkb19iYWQsCQlT
SUdLSUxMLCBTSV9LRVJORUwsCSJ1bmtub3duIDQwIgkJCX0sCi0JeyBkb19iYWQsCQlTSUdLSUxM
LCBTSV9LRVJORUwsCSJ1bmtub3duIDQxIgkJCX0sCisJeyBkb19iYWQsCQlTSUdLSUxMLCBTSV9L
RVJORUwsCSJsZXZlbCAtMSBhZGRyZXNzIHNpemUgZmF1bHQiCX0sCiAJeyBkb19iYWQsCQlTSUdL
SUxMLCBTSV9LRVJORUwsCSJ1bmtub3duIDQyIgkJCX0sCi0JeyBkb19iYWQsCQlTSUdLSUxMLCBT
SV9LRVJORUwsCSJ1bmtub3duIDQzIgkJCX0sCisJeyBkb190cmFuc2xhdGlvbl9mYXVsdCwJU0lH
U0VHViwgU0VHVl9NQVBFUlIsCSJsZXZlbCAtMSB0cmFuc2xhdGlvbiBmYXVsdCIJfSwKIAl7IGRv
X2JhZCwJCVNJR0tJTEwsIFNJX0tFUk5FTCwJInVua25vd24gNDQiCQkJfSwKIAl7IGRvX2JhZCwJ
CVNJR0tJTEwsIFNJX0tFUk5FTCwJInVua25vd24gNDUiCQkJfSwKIAl7IGRvX2JhZCwJCVNJR0tJ
TEwsIFNJX0tFUk5FTCwJInVua25vd24gNDYiCQkJfSwKLS0gCjIuNDIuMC44MjAuZzgzYTcyMWEx
MzctZ29vZwoK
--0000000000001f59930608fe4fa5--
