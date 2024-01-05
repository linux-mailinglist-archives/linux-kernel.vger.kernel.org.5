Return-Path: <linux-kernel+bounces-18172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C418259AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE91285C8D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2CC347A1;
	Fri,  5 Jan 2024 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gTlT24Gz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F73347B0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-555e07761acso2260568a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 10:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704477963; x=1705082763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lv2gFcMM0g7/cQv/mEBtAWY9twqnLjT2W2Q4bRR+UAE=;
        b=gTlT24GzjoP2ervgCqSxOlkCiaBUQtykE9x+LE2CvGWEmmR+fTNACgrYdEXeJ46cNb
         FelGyLvJC3tm8iIqXSRyN8wuBYC5w89cc7jbJ9/S9rNesADP+D+la1hU+0N4oa081Bw8
         5Fa/8M9wjZNqxMBWP5nzpMhEpO1XXlLQXIkEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704477963; x=1705082763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lv2gFcMM0g7/cQv/mEBtAWY9twqnLjT2W2Q4bRR+UAE=;
        b=MBfvPYHSdAskk7g/UqrtroflrMDJYgYs0YRqG6y4jzLOyL0Guj0r0ks/oE5f/oNMBD
         /bjSNmkIOhx12Bv3suyrLwF94AzNP9nhWJp8JWAVlelH6G5SIMm0u7hCMgbZpPoFISVO
         FC/0TohJIccCQtVpAcjHl4HDtKMH44ZaL6eLYXCfiMVbHj51qhsaHDmBRi6+6R//3suo
         u4sIShGfWrYoFOHLQ6Hb9R6UBTqKnGTlAo2CsAgH70D6rW1HC4jLgWjFDjwOnfMG9URM
         NiWhSNp5H11aBR0QcBjLFoPkaeSgkUVid0G+t1QHPI8WEtCeT+RSNKTUthLsRnRpnmIl
         gtCQ==
X-Gm-Message-State: AOJu0Yzizf95mAvSuUE86yELtiKKTgnigHsjS/RIohaF8uP4WrbH7C9g
	TfdxaMYe3UEpEr1T7y42xbPUxTDg58rpVTFbQPcjlDR5iLvUeu6m
X-Google-Smtp-Source: AGHT+IHrc82BxQ15zAoTKHP/uZ22gAdEGHdrzidurlZRfvx1SrLAH3MIrvvHb/9er8yWhhxi3hJApg==
X-Received: by 2002:a17:906:364b:b0:a27:eb03:bd44 with SMTP id r11-20020a170906364b00b00a27eb03bd44mr954524ejb.203.1704477963322;
        Fri, 05 Jan 2024 10:06:03 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id vz9-20020a17090704c900b00a2944ed5f4asm917764ejb.28.2024.01.05.10.06.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 10:06:02 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e3712d259so11783215e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 10:06:02 -0800 (PST)
X-Received: by 2002:a05:600c:19c7:b0:40c:2671:1553 with SMTP id
 u7-20020a05600c19c700b0040c26711553mr893500wmq.36.1704477961705; Fri, 05 Jan
 2024 10:06:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920192300.3772199-1-goldstein.w.n@gmail.com>
 <202309231130.ZI5MdlDc-lkp@intel.com> <CAFUsyfKDRiX9kKOhHcA4PLqqT6Q5faHF0eRGiKN+9NSbvrUfDw@mail.gmail.com>
 <d02bd4f823534a00ae4915ead3d92773@AcuMS.aculab.com> <CAFUsyfL0M5P4+4s_b1kvJ_fE-ax8YBK0ammbKfoy7yKs1obzrA@mail.gmail.com>
 <CAFUsyfJduB29c6=BNmTtgoWcHAWA1AZ-sdbhyp02JVhvA6Gp0w@mail.gmail.com>
 <CAFUsyfLuo0_Sm91mqbM8Sbo-ncwnM4RaRq=GxQXDmkAN-nQ3uw@mail.gmail.com>
 <CAHk-=wgv6h4ru=z8UR5XyutoRKveOetNpwovHburvRgG9NSa3g@mail.gmail.com>
 <CAHk-=wiNUucmvTKGmveWzXXe99SpOwU65nFtH-A2_aUpPsAPJQ@mail.gmail.com> <5354eeec562345f6a1de84f0b2081b75@AcuMS.aculab.com>
In-Reply-To: <5354eeec562345f6a1de84f0b2081b75@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jan 2024 10:05:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg8vssPVO68_qH_BHBCj6_DDawKQHBOgZh4gw5YFmpCKA@mail.gmail.com>
Message-ID: <CAHk-=wg8vssPVO68_qH_BHBCj6_DDawKQHBOgZh4gw5YFmpCKA@mail.gmail.com>
Subject: Re: x86/csum: Remove unnecessary odd handling
To: David Laight <David.Laight@aculab.com>
Cc: Noah Goldstein <goldstein.w.n@gmail.com>, kernel test robot <lkp@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, 
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>
Content-Type: multipart/mixed; boundary="0000000000006fb109060e36b317"

--0000000000006fb109060e36b317
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 02:41, David Laight <David.Laight@aculab.com> wrote:
>
> Interesting, I'm pretty sure trying to get two blocks of
>  'adc' scheduled in parallel like that doesn't work.

You should check out the benchmark at

       https://github.com/fenrus75/csum_partial

and see if you can improve on it. I'm including the patch (on top of
that code by Arjan) to implement the actual current kernel version as
"New version".

         Linus

--0000000000006fb109060e36b317
Content-Type: application/octet-stream; name=p
Content-Disposition: attachment; filename=p
Content-Transfer-Encoding: base64
Content-ID: <f_lr0y5drz0>
X-Attachment-Id: f_lr0y5drz0

RnJvbSA2ZmY3ZjdhNzJhNDg1NTk3MGIxNjIxYWM5NzI0YzQ0YzM5M2E2ZDQ0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IEZyaSwgNSBKYW4gMjAyNCAwOTo0NjozMiAtMDgwMApTdWJqZWN0OiBb
UEFUQ0hdIEFkZCB0aGUgY3VycmVudCBrZXJuZWwgdmVyc2lvbiBhcyAiTmV3IHZlcnNpb24iCgot
LS0KIE1ha2VmaWxlICAgICAgIHwgICAzIC0tCiBjc3VtX3BhcnRpYWwuYyB8IDExNyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KIDIgZmls
ZXMgY2hhbmdlZCwgMTE1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvTWFrZWZpbGUgYi9NYWtlZmlsZQppbmRleCBlNGIxYmIzLi40ZTI5ZjhhIDEwMDY0NAotLS0g
YS9NYWtlZmlsZQorKysgYi9NYWtlZmlsZQpAQCAtMTcsNiArMTcsMyBAQCBjaGFpbjIuc3ZnOiBn
cmFwaHMvY2hhaW4yLmRvdAogY2hhaW4yYS5zdmc6IGdyYXBocy9jaGFpbjJhLmRvdAogCWRvdCAt
VHN2ZyAtTyBncmFwaHMvY2hhaW4yYS5kb3QgIAogCW12IGdyYXBocy9jaGFpbjJhLmRvdC5zdmcg
Y2hhaW4yYS5zdmcKLQkKLQkKLQkKXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlCmRpZmYgLS1n
aXQgYS9jc3VtX3BhcnRpYWwuYyBiL2NzdW1fcGFydGlhbC5jCmluZGV4IDRkYjBkOTcuLmRkZjZh
Y2QgMTAwNjQ0Ci0tLSBhL2NzdW1fcGFydGlhbC5jCisrKyBiL2NzdW1fcGFydGlhbC5jCkBAIC0x
NCwxMyArMTQsMjggQEAKICNpbmNsdWRlIDx0aW1lLmg+CiAKIHR5cGVkZWYgdWludDMyX3QgX193
c3VtOwordHlwZWRlZiB1aW50MzJfdCBfX3UzMjsKK3R5cGVkZWYgdWludDY0X3QgX191NjQ7CiB0
eXBlZGVmIHVpbnQ2NF90IHU2NDsKIHR5cGVkZWYgdWludDMyX3QgdTMyOworIyBkZWZpbmUgbGlr
ZWx5KHgpIF9fYnVpbHRpbl9leHBlY3QoISEoeCksIDEpCiAjIGRlZmluZSB1bmxpa2VseSh4KSBf
X2J1aWx0aW5fZXhwZWN0KCEhKHgpLCAwKQogCisjZGVmaW5lIF9fZm9yY2UKKwogI2RlZmluZSBM
T09QQ09VTlQgMTAyNDAwCiAjZGVmaW5lIFBBQ0tFVFNJWkUgNDAKIAorLyoqCisgKiByb3I2NCAt
IHJvdGF0ZSBhIDY0LWJpdCB2YWx1ZSByaWdodAorICogQHdvcmQ6IHZhbHVlIHRvIHJvdGF0ZQor
ICogQHNoaWZ0OiBiaXRzIHRvIHJvbGwKKyAqLworc3RhdGljIGlubGluZSBfX3U2NCByb3I2NChf
X3U2NCB3b3JkLCB1bnNpZ25lZCBpbnQgc2hpZnQpCit7CisJcmV0dXJuICh3b3JkID4+IChzaGlm
dCAmIDYzKSkgfCAod29yZCA8PCAoKC1zaGlmdCkgJiA2MykpOworfQorCiBzdGF0aWMgaW5saW5l
IHVuc2lnbmVkIGxvbmcgbG9hZF91bmFsaWduZWRfemVyb3BhZChjb25zdCB2b2lkICphZGRyKQog
ewogCXVuc2lnbmVkIGxvbmcgcmV0LCBkdW1teTsKQEAgLTQ4NCw3ICs0OTksMTA1IEBAIHN0YXRp
YyBpbmxpbmUgX193c3VtIG51bGx0ZXN0KGNvbnN0IHZvaWQgKmJ1ZmYsIGludCBsZW4sIF9fd3N1
bSBzdW0pCiB7CiAJcmV0dXJuIDI7CiB9CitzdGF0aWMgaW5saW5lIF9fd3N1bSBjc3VtX2ZpbmFs
aXplX3N1bSh1NjQgdGVtcDY0KQoreworCXJldHVybiAoX19mb3JjZSBfX3dzdW0pKCh0ZW1wNjQg
KyByb3I2NCh0ZW1wNjQsIDMyKSkgPj4gMzIpOworfQogCitzdGF0aWMgaW5saW5lIHVuc2lnbmVk
IGxvbmcgdXBkYXRlX2NzdW1fNDBiKHVuc2lnbmVkIGxvbmcgc3VtLCBjb25zdCB1bnNpZ25lZCBs
b25nIG1bNV0pCit7CisJYXNtKCJhZGRxICUxLCUwXG5cdCIKKwkgICAgICJhZGNxICUyLCUwXG5c
dCIKKwkgICAgICJhZGNxICUzLCUwXG5cdCIKKwkgICAgICJhZGNxICU0LCUwXG5cdCIKKwkgICAg
ICJhZGNxICU1LCUwXG5cdCIKKwkgICAgICJhZGNxICQwLCUwIgorCQk6IityIiAoc3VtKQorCQk6
Im0iIChtWzBdKSwgIm0iIChtWzFdKSwgIm0iIChtWzJdKSwKKwkJICJtIiAobVszXSksICJtIiAo
bVs0XSkpOworCXJldHVybiBzdW07Cit9CisKKy8qCisgKiBEbyBhIGNoZWNrc3VtIG9uIGFuIGFy
Yml0cmFyeSBtZW1vcnkgYXJlYS4KKyAqIFJldHVybnMgYSAzMmJpdCBjaGVja3N1bS4KKyAqCisg
KiBUaGlzIGlzbid0IGFzIHRpbWUgY3JpdGljYWwgYXMgaXQgdXNlZCB0byBiZSBiZWNhdXNlIG1h
bnkgTklDcworICogZG8gaGFyZHdhcmUgY2hlY2tzdW1taW5nIHRoZXNlIGRheXMuCisgKgorICog
U3RpbGwsIHdpdGggQ0hFQ0tTVU1fQ09NUExFVEUgdGhpcyBpcyBjYWxsZWQgdG8gY29tcHV0ZQor
ICogY2hlY2tzdW1zIG9uIElQdjYgaGVhZGVycyAoNDAgYnl0ZXMpIGFuZCBvdGhlciBzbWFsbCBw
YXJ0cy4KKyAqIGl0J3MgYmVzdCB0byBoYXZlIGJ1ZmYgYWxpZ25lZCBvbiBhIDY0LWJpdCBib3Vu
ZGFyeQorICovCitfX3dzdW0gY3N1bV9wYXJ0aWFsX25ldyhjb25zdCB2b2lkICpidWZmLCBpbnQg
bGVuLCBfX3dzdW0gc3VtKQoreworCXU2NCB0ZW1wNjQgPSAoX19mb3JjZSB1NjQpc3VtOworCisJ
LyogRG8gdHdvIDQwLWJ5dGUgY2h1bmtzIGluIHBhcmFsbGVsIHRvIGdldCBiZXR0ZXIgSUxQICov
CisJaWYgKGxpa2VseShsZW4gPj0gODApKSB7CisJCXU2NCB0ZW1wNjRfMiA9IDA7CisJCWRvIHsK
KwkJCXRlbXA2NCA9IHVwZGF0ZV9jc3VtXzQwYih0ZW1wNjQsIGJ1ZmYpOworCQkJdGVtcDY0XzIg
PSB1cGRhdGVfY3N1bV80MGIodGVtcDY0XzIsIGJ1ZmYgKyA0MCk7CisJCQlidWZmICs9IDgwOwor
CQkJbGVuIC09IDgwOworCQl9IHdoaWxlIChsZW4gPj0gODApOworCisJCWFzbSgiYWRkcSAlMSwl
MFxuXHQiCisJCSAgICAiYWRjcSAkMCwlMCIKKwkJICAgIDoiK3IiICh0ZW1wNjQpOiAiciIgKHRl
bXA2NF8yKSk7CisJfQorCisJLyoKKwkgKiBsZW4gPT0gNDAgaXMgdGhlIGhvdCBjYXNlIGR1ZSB0
byBJUHY2IGhlYWRlcnMsIHNvIHJldHVybgorCSAqIGVhcmx5IGZvciB0aGF0IGV4YWN0IGNhc2Ug
d2l0aG91dCBjaGVja2luZyB0aGUgdGFpbCBieXRlcy4KKwkgKi8KKwlpZiAobGVuID49IDQwKSB7
CisJCXRlbXA2NCA9IHVwZGF0ZV9jc3VtXzQwYih0ZW1wNjQsIGJ1ZmYpOworCQlsZW4gLT0gNDA7
CisJCWlmICghbGVuKQorCQkJcmV0dXJuIGNzdW1fZmluYWxpemVfc3VtKHRlbXA2NCk7CisJCWJ1
ZmYgKz0gNDA7CisJfQorCisJaWYgKGxlbiAmIDMyKSB7CisJCWFzbSgiYWRkcSAwKjgoJVtzcmNd
KSwlW3Jlc11cblx0IgorCQkgICAgImFkY3EgMSo4KCVbc3JjXSksJVtyZXNdXG5cdCIKKwkJICAg
ICJhZGNxIDIqOCglW3NyY10pLCVbcmVzXVxuXHQiCisJCSAgICAiYWRjcSAzKjgoJVtzcmNdKSwl
W3Jlc11cblx0IgorCQkgICAgImFkY3EgJDAsJVtyZXNdIgorCQkgICAgOiBbcmVzXSAiK3IiKHRl
bXA2NCkKKwkJICAgIDogW3NyY10gInIiKGJ1ZmYpLCAibSIoKihjb25zdCBjaGFyKCopWzMyXSli
dWZmKSk7CisJCWJ1ZmYgKz0gMzI7CisJfQorCWlmIChsZW4gJiAxNikgeworCQlhc20oImFkZHEg
MCo4KCVbc3JjXSksJVtyZXNdXG5cdCIKKwkJICAgICJhZGNxIDEqOCglW3NyY10pLCVbcmVzXVxu
XHQiCisJCSAgICAiYWRjcSAkMCwlW3Jlc10iCisJCSAgICA6IFtyZXNdICIrciIodGVtcDY0KQor
CQkgICAgOiBbc3JjXSAiciIoYnVmZiksICJtIigqKGNvbnN0IGNoYXIoKilbMTZdKWJ1ZmYpKTsK
KwkJYnVmZiArPSAxNjsKKwl9CisJaWYgKGxlbiAmIDgpIHsKKwkJYXNtKCJhZGRxIDAqOCglW3Ny
Y10pLCVbcmVzXVxuXHQiCisJCSAgICAiYWRjcSAkMCwlW3Jlc10iCisJCSAgICA6IFtyZXNdICIr
ciIodGVtcDY0KQorCQkgICAgOiBbc3JjXSAiciIoYnVmZiksICJtIigqKGNvbnN0IGNoYXIoKilb
OF0pYnVmZikpOworCQlidWZmICs9IDg7CisJfQorCWlmIChsZW4gJiA3KSB7CisJCXVuc2lnbmVk
IGludCBzaGlmdCA9ICgtbGVuIDw8IDMpICYgNjM7CisJCXVuc2lnbmVkIGxvbmcgdHJhaWw7CisK
KwkJdHJhaWwgPSAobG9hZF91bmFsaWduZWRfemVyb3BhZChidWZmKSA8PCBzaGlmdCkgPj4gc2hp
ZnQ7CisKKwkJYXNtKCJhZGRxICVbdHJhaWxdLCVbcmVzXVxuXHQiCisJCSAgICAiYWRjcSAkMCwl
W3Jlc10iCisJCSAgICA6IFtyZXNdICIrciIodGVtcDY0KQorCQkgICAgOiBbdHJhaWxdICJyIih0
cmFpbCkpOworCX0KKwlyZXR1cm4gY3N1bV9maW5hbGl6ZV9zdW0odGVtcDY0KTsKK30KIAogZG91
YmxlIGN5Y2xlc1s2NF07CiBpbnQgY3ljbGVjb3VudFs2NF07CkBAIC02MTIsNiArNzI1LDcgQEAg
aW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogCiAJTUVBU1VSRSgyLCAgY3N1bV9wYXJ0
aWFsLCAiVXBjb21pbmcgbGludXgga2VybmVsIHZlcnNpb24iKTsKIAlNRUFTVVJFKDQsICBjc3Vt
X3NwZWNpYWxpemVkLCAiU3BlY2lhbGl6ZWQgdG8gc2l6ZSA0MCIpOworCU1FQVNVUkUoNiwgIGNz
dW1fcGFydGlhbF9uZXcsICJOZXcgdmVyc2lvbiIpOwogCU1FQVNVUkUoMjIsIGNzdW1fcGFydGlh
bF9ub19vZGQsICJPZGQtYWxpZ25tZW50IGhhbmRsaW5nIHJlbW92ZWQiKTsKIAlNRUFTVVJFKDI0
LCBjc3VtX3BhcnRpYWxfZGVhZF9jb2RlLCAiRGVhZCBjb2RlIGVsaW1pbmF0aW9uICAgICAgICAg
ICAiKTsKIAlNRUFTVVJFKDI4LCBjc3VtX3BhcnRpYWxfQUNYLCAiQURYIGludGVybGVhdmVkICIp
OwpAQCAtNjE5LDcgKzczMyw2IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAlN
RUFTVVJFKDM0LCBjc3VtX3BhcnRpYWxfMzJiaXQsICIzMiBiaXQgdHJhaW4gIik7CiAJTUVBU1VS
RSgzNiwgY3N1bV9wYXJ0aWFsX3plcm9fc3VtLCAiQXNzdW1lIHplcm8gaW5wdXQgc3VtIik7CiAK
LQogCXJlcG9ydCgpOwogCX0KLX0KXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlCit9Cg==
--0000000000006fb109060e36b317--

