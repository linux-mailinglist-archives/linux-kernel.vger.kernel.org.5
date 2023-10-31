Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883A67DD6A4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 20:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjJaTVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 15:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjJaTVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 15:21:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506F3F4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 12:21:29 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507a98517f3so8445985e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 12:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mwa.re; s=google; t=1698780087; x=1699384887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YQGtdtuvuIXq+hDVNEiOx2zG9p14csqbveXC6JidYr4=;
        b=Ahnivri9bfaaWLN/Su+OcL8nfXCKQvFtXryFUQLw0psYlHVBgMXX7adrXkaWQmdQEk
         3NPWMFuuUq6N9jbGCpot+PSz0x3gFCxgt24iN6crjylEG4W+EYY9XJGMIay1eLn6xKL7
         dLvEoaLSUIeiqcTw4NDgM2M02KfV8q9Ub+zzJN6dlh7k9BUOx5IqyTMtc/xwv3IxeMIT
         jeRw3kJxHCCulhcDOE8MHNwE2VCavE9AnyVDpDa0ZblB41NXD/bLxK1chtjQ9/HVotBf
         3Nd66Zfr8u5HmF3uwKJhIuvzCGmLzb3s2MoIFdmuEAP9zKUj06a8J8ytaAyzGEmxgRnY
         u7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698780087; x=1699384887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQGtdtuvuIXq+hDVNEiOx2zG9p14csqbveXC6JidYr4=;
        b=stq8bNFxfaxXKFK3uqyuFzID3T0qvcepFGCDWsLVnBDjAcQflgIjJxTw0Ko1PP0qd0
         e62OMnpoe8m/z4yr8MmKsGg0E1JnghBwT5/Eg6SVZP+7CW8kq1hjmvmwjmNvH2ox3tT7
         Xl9XcrvNsQG9TcF5tNNN1ye+afEMtIL5QN3R90GLNGGDViG8PStki71xVmgROL8v2kVa
         m1Qyy2J4mHHhoQ7u5qUDQzlbsBAW20p+pj+CNLNR2s+Ij0LGI7Nzd0iO6tbuXZ8B3qwY
         C3WO8O6rOwb9nIu5vUoEar93MBysXgTw5J6mQ86kmzHEcYoMzk1z4P55ptgSkGRbt7p9
         CR1Q==
X-Gm-Message-State: AOJu0Ywd1dwLH6m2pQdKqVJaxOUDXqTK+3HjzZfjDoCAiuzNbUI96PNZ
        64DZlQC8htgepVrKfkEUMRg/s0h3JwKoWP2H02s2DA==
X-Google-Smtp-Source: AGHT+IGCH+klPMXc0w7VjcJBbqCwfyUeMTquMRG1n2bPoHM32RvfavLaz27FPzaBQ0GevoywwKxIv6oHiN/kfrx3Xhw=
X-Received: by 2002:ac2:5ec3:0:b0:507:a16d:6699 with SMTP id
 d3-20020ac25ec3000000b00507a16d6699mr8954646lfq.13.1698780087341; Tue, 31 Oct
 2023 12:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <CANi1PHhzk80HvwQbBM46gpJ6_AA_P6+m5Jo0Nuy_MAdA4C2BhQ@mail.gmail.com>
 <87ttql5aq7.wl-maz@kernel.org> <CANi1PHieGooO0DK=6BPwq0UknHzsn9QM3rFQkh3HLMfWxDseUQ@mail.gmail.com>
 <86cyx250w9.wl-maz@kernel.org> <CANi1PHjAwLWAq9EW7r5Yh_xbvPiJMsq8342JwAGafz1d1NUhSA@mail.gmail.com>
 <86msw01e4m.wl-maz@kernel.org>
In-Reply-To: <86msw01e4m.wl-maz@kernel.org>
From:   Jan Henrik Weinstock <jan@mwa.re>
Date:   Tue, 31 Oct 2023 20:21:16 +0100
Message-ID: <CANi1PHiXFKz6VqBys=Xw=rgR_gJKPO661iW-TMrF20j5yS4unQ@mail.gmail.com>
Subject: Re: KVM exit to userspace on WFI
To:     Marc Zyngier <maz@kernel.org>
Cc:     oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Lukas_J=C3=BCnger?= <lukas@mwa.re>
Content-Type: multipart/mixed; boundary="000000000000a885060609080f6e"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a885060609080f6e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mo., 30. Okt. 2023 um 13:36 Uhr schrieb Marc Zyngier <maz@kernel.org>:
>
> [please make an effort not to top-post]
>
> On Fri, 27 Oct 2023 18:41:44 +0100,
> Jan Henrik Weinstock <jan@mwa.re> wrote:
> >
> > Hi Marc,
> >
> > the basic idea behind this is to have a (single-threaded) execution loo=
p,
> > something like this:
> >
> > vcpu-thread:    vcpu-run | process-io-devices | vcpu-run | process-io..=
.
> >                          ^
> >                   WFX or timeout
> >
> > We switch to simulating IO devices whenever the vcpu is idle (wfi) or e=
xceeds
> > a certain budget of instructions (counted via pmu). Our fallback curren=
tly is
> > to kick the vcpu out of its execution using a signal (via a timeout/ala=
rm). But
> > of course, if the cpu is stuck at a wfi, we are wasting a lot of time.
> >
> > I understand that the proposed behavior is not desirable for most use c=
ases,
> > which is why I suggest locking it behind a flag, e.g.
> > KVM_ARCH_FLAG_WFX_EXIT_TO_USER.
>
> But how do you reconcile the fact that exposing this to userspace
> breaks fundamental expectations that the guest has, such as getting
> its timer interrupts and directly injected LPIs? Implementing WFI in
> userspace breaks it. What about the case where we don't trap WFx and
> let the *guest* wait for an interrupt?

Timer interrupts etc. will be injected into the vcpu during the
io-phases. When there are no interrupts present and the guest performs
a WFI, we can just skip forward to the next timer event.

> Honestly, what you are describing seems to be a use model that doesn't
> fit KVM, which is a general purpose hypervisor, but more a simulation
> environment. Yes, the primitives are the same, but the plumbing is
> wildly different.

Agreed.

> *If* that's the stuff you're looking at, then I'm afraid you'll have
> to do it in different way, because what you are suggesting is
> fundamentally incompatible with the guarantees that KVM gives to guest
> and userspace. Because your KVM_ARCH_FLAG_WFX_EXIT_TO_USER is really a
> lie. It should really be named something more along the lines of
> KVM_ARCH_FLAG_WFX_EXIT_TO_USER_SOMETIME_AND_I_DONT_EVEN_KNOW_WHEN
> (probably with additional clauses related to breaking things).

I have attached a reworked version of the patch as a reference (based
on my 5.15 kernel). It puts the modified behavior behind a new
capability so as to not interfere with the current expectations
towards handling WFI/WFE.
I think it should now trap all blocking calls to WFx on the vcpu and
reliably return to the userspace. If I have missed something that
would cause the vcpu to not trap on a WFI kindly let me know.

> Overall, you are still asking for something that is not guaranteed at
> the architecture level, even less in KVM, and I'm not going to add
> support for something that can only work "sometime".

I am not quite sure what you mean with "sometime". Are you referring
to WFIs as NOPs? Or WFIs that do not yield because of pending
interrupts?

The point of my patch is not to accurately count every single WFI. The
point is to prevent the host cpu from sleeping just because my vcpu
executed a WFI somewhere in the guest software. If a WFI is executed
by the guest and that does not result in my vcpu thread to block (in
other words: the vcpu continues executing instructions beyond the WFI)
then it also should not exit to userspace. So instead of
"KVM_ARCH_FLAG_WFX_EXIT_TO_USER_SOMETIME_AND_I_DONT_EVEN_KNOW_WHEN" it
is really "KVM_ARCH_FLAG_WFX_EXIT_TO_USER_WHENEVER_YOU_WOULD_OTHERWISE_YIEL=
D_AND_I_CANNOT_GET_MY_THREAD_BACK".

>         M.
>
> --
> Without deviation from the norm, progress is not possible.



--=20
Dr.-Ing. Jan Henrik Weinstock
Managing Director

MachineWare GmbH | www.machineware.de
H=C3=BChnermarkt 19, 52062 Aachen, Germany
Amtsgericht Aachen HRB25734

Gesch=C3=A4ftsf=C3=BChrung
Lukas J=C3=BCnger
Dr.-Ing. Jan Henrik Weinstock

--000000000000a885060609080f6e
Content-Type: text/x-patch; charset="US-ASCII"; name="kvm.patch"
Content-Disposition: attachment; filename="kvm.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_loeokjga0>
X-Attachment-Id: f_loeokjga0

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCBiL2FyY2gvYXJt
NjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAppbmRleCBmYzZlZTZjNTkuLmMzMTA3NTA2YiAxMDA2
NDQKLS0tIGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCisrKyBiL2FyY2gvYXJt
NjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaApAQCAtMTM2LDYgKzEzNiw5IEBAIHN0cnVjdCBrdm1f
YXJjaCB7CiAKIAkvKiBNZW1vcnkgVGFnZ2luZyBFeHRlbnNpb24gZW5hYmxlZCBmb3IgdGhlIGd1
ZXN0ICovCiAJYm9vbCBtdGVfZW5hYmxlZDsKKworCS8qIEV4aXQgb24gV0ZJL1dGRSAqLworCWJv
b2wgZXhpdF9vbl93Zng7CiB9OwogCiBzdHJ1Y3Qga3ZtX3ZjcHVfZmF1bHRfaW5mbyB7CmRpZmYg
LS1naXQgYS9hcmNoL2FybTY0L2t2bS9hcm0uYyBiL2FyY2gvYXJtNjQva3ZtL2FybS5jCmluZGV4
IGYxODE1MjdmOS4uNmQ1NGRmYmFlIDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2t2bS9hcm0uYwor
KysgYi9hcmNoL2FybTY0L2t2bS9hcm0uYwpAQCAtMTAxLDYgKzEwMSwxMCBAQCBpbnQga3ZtX3Zt
X2lvY3RsX2VuYWJsZV9jYXAoc3RydWN0IGt2bSAqa3ZtLAogCQl9CiAJCW11dGV4X3VubG9jaygm
a3ZtLT5sb2NrKTsKIAkJYnJlYWs7CisJY2FzZSBLVk1fQ0FQX0VYSVRfT05fV0ZYOgorCQlyID0g
MDsKKwkJa3ZtLT5hcmNoLmV4aXRfb25fd2Z4ID0gdHJ1ZTsKKwkJYnJlYWs7CiAJZGVmYXVsdDoK
IAkJciA9IC1FSU5WQUw7CiAJCWJyZWFrOwpAQCAtMjE1LDYgKzIxOSw3IEBAIGludCBrdm1fdm1f
aW9jdGxfY2hlY2tfZXh0ZW5zaW9uKHN0cnVjdCBrdm0gKmt2bSwgbG9uZyBleHQpCiAJY2FzZSBL
Vk1fQ0FQX1NFVF9HVUVTVF9ERUJVRzoKIAljYXNlIEtWTV9DQVBfVkNQVV9BVFRSSUJVVEVTOgog
CWNhc2UgS1ZNX0NBUF9QVFBfS1ZNOgorCWNhc2UgS1ZNX0NBUF9FWElUX09OX1dGWDoKIAkJciA9
IDE7CiAJCWJyZWFrOwogCWNhc2UgS1ZNX0NBUF9TRVRfR1VFU1RfREVCVUcyOgpAQCAtMzk0LDgg
KzM5OSwxMCBAQCB2b2lkIGt2bV9hcmNoX3ZjcHVfbG9hZChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUs
IGludCBjcHUpCiB7CiAJc3RydWN0IGt2bV9zMl9tbXUgKm1tdTsKIAlpbnQgKmxhc3RfcmFuOwor
CWJvb2wgZXhpdF9vbl93Zng7CiAKIAltbXUgPSB2Y3B1LT5hcmNoLmh3X21tdTsKKwlleGl0X29u
X3dmeCA9IHZjcHUtPmt2bS0+YXJjaC5leGl0X29uX3dmeDsKIAlsYXN0X3JhbiA9IHRoaXNfY3B1
X3B0cihtbXUtPmxhc3RfdmNwdV9yYW4pOwogCiAJLyoKQEAgLTQyMyw3ICs0MzAsNyBAQCB2b2lk
IGt2bV9hcmNoX3ZjcHVfbG9hZChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGludCBjcHUpCiAJaWYg
KGt2bV9hcm1faXNfcHZ0aW1lX2VuYWJsZWQoJnZjcHUtPmFyY2gpKQogCQlrdm1fbWFrZV9yZXF1
ZXN0KEtWTV9SRVFfUkVDT1JEX1NURUFMLCB2Y3B1KTsKIAotCWlmIChzaW5nbGVfdGFza19ydW5u
aW5nKCkpCisJaWYgKHNpbmdsZV90YXNrX3J1bm5pbmcoKSAmJiAhZXhpdF9vbl93ZngpCiAJCXZj
cHVfY2xlYXJfd2Z4X3RyYXBzKHZjcHUpOwogCWVsc2UKIAkJdmNwdV9zZXRfd2Z4X3RyYXBzKHZj
cHUpOwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9rdm0vaGFuZGxlX2V4aXQuYyBiL2FyY2gvYXJt
NjQva3ZtL2hhbmRsZV9leGl0LmMKaW5kZXggYTVhYjUyMTUwLi44MGZhNmJkZWYgMTAwNjQ0Ci0t
LSBhL2FyY2gvYXJtNjQva3ZtL2hhbmRsZV9leGl0LmMKKysrIGIvYXJjaC9hcm02NC9rdm0vaGFu
ZGxlX2V4aXQuYwpAQCAtOTEsMTAgKzkxLDIxIEBAIHN0YXRpYyBpbnQga3ZtX2hhbmRsZV93Zngo
c3RydWN0IGt2bV92Y3B1ICp2Y3B1KQogCWlmIChrdm1fdmNwdV9nZXRfZXNyKHZjcHUpICYgRVNS
X0VMeF9XRnhfSVNTX1dGRSkgewogCQl0cmFjZV9rdm1fd2Z4X2FybTY0KCp2Y3B1X3BjKHZjcHUp
LCB0cnVlKTsKIAkJdmNwdS0+c3RhdC53ZmVfZXhpdF9zdGF0Kys7CisJCWlmICh2Y3B1LT5rdm0t
PmFyY2guZXhpdF9vbl93ZngpIHsKKwkJCXZjcHUtPnJ1bi0+ZXhpdF9yZWFzb24gPSBLVk1fRVhJ
VF9XRlg7CisJCQl2Y3B1LT5ydW4tPndmeC5lc3IgPSBrdm1fdmNwdV9nZXRfZXNyKHZjcHUpOwor
CQkJcmV0dXJuIDA7CisJCX0KKwogCQlrdm1fdmNwdV9vbl9zcGluKHZjcHUsIHZjcHVfbW9kZV9w
cml2KHZjcHUpKTsKIAl9IGVsc2UgewogCQl0cmFjZV9rdm1fd2Z4X2FybTY0KCp2Y3B1X3BjKHZj
cHUpLCBmYWxzZSk7CiAJCXZjcHUtPnN0YXQud2ZpX2V4aXRfc3RhdCsrOworCQlpZiAodmNwdS0+
a3ZtLT5hcmNoLmV4aXRfb25fd2Z4KSB7CisJCQl2Y3B1LT5ydW4tPmV4aXRfcmVhc29uID0gS1ZN
X0VYSVRfV0ZYOworCQkJdmNwdS0+cnVuLT53ZnguZXNyID0ga3ZtX3ZjcHVfZ2V0X2Vzcih2Y3B1
KTsKKwkJCXJldHVybiAwOworCQl9CiAJCWt2bV92Y3B1X2Jsb2NrKHZjcHUpOwogCQlrdm1fY2xl
YXJfcmVxdWVzdChLVk1fUkVRX1VOSEFMVCwgdmNwdSk7CiAJfQpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS91YXBpL2xpbnV4L2t2bS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2t2bS5oCmluZGV4IDBkNDdl
MDdmNC4uMTU1ZGM3ZWFiIDEwMDY0NAotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgva3ZtLmgKKysr
IGIvaW5jbHVkZS91YXBpL2xpbnV4L2t2bS5oCkBAIC0yNjksNiArMjY5LDcgQEAgc3RydWN0IGt2
bV94ZW5fZXhpdCB7CiAjZGVmaW5lIEtWTV9FWElUX0FQX1JFU0VUX0hPTEQgICAgMzIKICNkZWZp
bmUgS1ZNX0VYSVRfWDg2X0JVU19MT0NLICAgICAzMwogI2RlZmluZSBLVk1fRVhJVF9YRU4gICAg
ICAgICAgICAgIDM0CisjZGVmaW5lIEtWTV9FWElUX1dGWCAgICAgICAgICAgICAgMzUKIAogLyog
Rm9yIEtWTV9FWElUX0lOVEVSTkFMX0VSUk9SICovCiAvKiBFbXVsYXRlIGluc3RydWN0aW9uIGZh
aWxlZC4gKi8KQEAgLTQ2OSw2ICs0NzAsMTEgQEAgc3RydWN0IGt2bV9ydW4gewogCQl9IG1zcjsK
IAkJLyogS1ZNX0VYSVRfWEVOICovCiAJCXN0cnVjdCBrdm1feGVuX2V4aXQgeGVuOworCQkvKiBL
Vk1fRVhJVF9XRlggKi8KKwkJc3RydWN0IHsKKwkJCV9fdTY0IGVzcjsKKwkJfSB3Zng7CisKIAkJ
LyogRml4IHRoZSBzaXplIG9mIHRoZSB1bmlvbi4gKi8KIAkJY2hhciBwYWRkaW5nWzI1Nl07CiAJ
fTsKQEAgLTExMjMsNiArMTEyOSw3IEBAIHN0cnVjdCBrdm1fcHBjX3Jlc2l6ZV9ocHQgewogI2Rl
ZmluZSBLVk1fQ0FQX1hTQVZFMiAyMDgKICNkZWZpbmUgS1ZNX0NBUF9TWVNfQVRUUklCVVRFUyAy
MDkKICNkZWZpbmUgS1ZNX0NBUF9TMzkwX01FTV9PUF9FWFRFTlNJT04gMjExCisjZGVmaW5lIEtW
TV9DQVBfRVhJVF9PTl9XRlggMjIyCiAKICNpZmRlZiBLVk1fQ0FQX0lSUV9ST1VUSU5HCiAK
--000000000000a885060609080f6e--
