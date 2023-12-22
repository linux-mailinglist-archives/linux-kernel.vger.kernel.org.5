Return-Path: <linux-kernel+bounces-9201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DA381C242
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F31BAB2487B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B30D38D;
	Fri, 22 Dec 2023 00:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UqPZ2ZQm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6149B630;
	Fri, 22 Dec 2023 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d4006b2566so9857475ad.0;
        Thu, 21 Dec 2023 16:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703204276; x=1703809076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K4eLtecU1AzkZ6v0yoRfkSekFdqon4FA+IB17UNyBZc=;
        b=UqPZ2ZQmNCL7ZS4xZgP5L7goYg9YUKeaTcxo+tCmo7AcIDPR7iFrcMkBHu9Gnf+4JW
         Qi9lQmCQgwMMl1l7m3LSVSuFT2i+wf9oIVgMFtib6JgjE0jcVCFOLd9dxEZOVnUvsRfV
         OdZjC2n77x5AlfGAhi95Vr9nBfwjCBbrV4DxbxbHKfZRK445ZJ5NiYf0LTtQXc7E5z4Z
         APplq4oF0mx762eB4uBQ007BZXJxgVCtZ0UCxmZ0yZr3XOq0MTsOJme3fSTJKEg/xlwE
         1vPUnK3TS5caV1CR5XBd/9euT6R4UQzQCZ7S44clYewLxPIyvNYS9ZUZ7tpgtyXlAVGN
         JGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703204276; x=1703809076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4eLtecU1AzkZ6v0yoRfkSekFdqon4FA+IB17UNyBZc=;
        b=OKHo2cXPKBUGRxd5fLC2d2Flf4oA0VB5aRYABGyX3IQ7rC1sb+KXSETQD1zVa4WrL7
         RVCQrdlK2MUdjTULsvnvbLHmjcczQPmRxyHJSWDonsfa603gLVuraX/0LVPqt44BNr+s
         zIppS4wEJW/cJfzjYF7Nv3zcRVeGfWBkcB9UVZdfnC1DxfjCEPxYB+9Maduti2Yc4v5h
         D/FGAuoz5sG/U3Glu6LY3RRKM1ugi9gcAV2t+TrxL4f/5n4hSYxZ0gXlomKcDOqv+zot
         YkGCBzpBphBNthFC3zMABYlf90hJTHPiT807GCXzoByHSXF1Iaru3Msp9gaSh7O+4/Pe
         /nUA==
X-Gm-Message-State: AOJu0YxZKn2Qy0ubalJJwuZEzuhCzGkjk3/Nfkik5vBZvBBgj3sPej5F
	ZITb1Uv3kkLnT/Lq+/hKuuPrlI8mMoieK5EyuNCnSr2XYlQ=
X-Google-Smtp-Source: AGHT+IHogtZ5maciBE+Gv1/Y3tNb1CAhSD7rJLIduNEIGjOjhD1j6XdGgzYPCtZ3MPpkJXKPikbhw9V3CGgvQTtBDqc=
X-Received: by 2002:a17:902:7c95:b0:1d0:9609:382e with SMTP id
 y21-20020a1709027c9500b001d09609382emr300415pll.21.1703204275514; Thu, 21 Dec
 2023 16:17:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221211222.1380658-1-martin.blumenstingl@googlemail.com> <tek6c6symqgm6x6ujh4m67q32en24pzrkjbchffir7qljo4gor@7qpu4zmgyzpq>
In-Reply-To: <tek6c6symqgm6x6ujh4m67q32en24pzrkjbchffir7qljo4gor@7qpu4zmgyzpq>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 22 Dec 2023 01:17:44 +0100
Message-ID: <CAFBinCAxh0xU2mDRX3t42j6oJ534p9RPUV+dYoRe0oacTw_7iA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] regulator: pwm-regulator: Fix continuous
 get_voltage for disabled PWM
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-pwm@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Thierry Reding <thierry.reding@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Dmitry Rokosov <ddrokosov@sberdevices.ru>
Content-Type: multipart/mixed; boundary="000000000000d28aac060d0e2533"

--000000000000d28aac060d0e2533
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Thu, Dec 21, 2023 at 11:03=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
[...]
> Note this isn't save in general. You're implicitly assuming that a
> disabled PWM runs with the minimal supported duty_cycle. Most disabled
> PWMs yield the inactive level (which corresponds to a 0% relative duty
> cycle). But there are exceptions.
Good catch - thank you!

[...]
> Without claiming to understand all implications, I'd say
> pwm_regulator_get_voltage should signal to the caller when the
> duty_cycle isn't contained in [min(max_uV_duty, min_uV_duty),
> max(max_uV_duty, min_uV_duty)].
It seems like there's -ENOTRECOVERABLE that we can signal to the caller.
This makes the following message appear in my kernel log:
  VDDEE: Setting 1100000-1140000uV
Which means that pwm_regulator_set_voltage() is called which will then
pick the minimum voltage.

To make this work I will need to update meson8b-odroidc1.dts (which
isn't a problem, I just want to point it out as it's mandatory for
that solution. also I will send that in a separate patch).

See my attached patch (which replaces the initial patch I sent, it's
not meant to be applied on top).
One question that I still have is whether we are allowed to just
enable the PWM output within pwm_regulator_set_voltage().
Doing so is actually mandatory, otherwise we end up in an infinite
loop of not being able to read the voltage, then sets the minimum
voltage (but leaves the PWM output disabled) which then means that it
can't read back the voltage which means it tries to set the minimum
voltage ....


Best regards,
Martin

--000000000000d28aac060d0e2533
Content-Type: text/x-patch; charset="US-ASCII"; name="odroidc1-vddee-fix-to-discuss.diff"
Content-Disposition: attachment; 
	filename="odroidc1-vddee-fix-to-discuss.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lqfvouez0>
X-Attachment-Id: f_lqfvouez0

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FtbG9naWMvbWVzb244Yi1vZHJvaWRjMS5k
dHMgYi9hcmNoL2FybS9ib290L2R0cy9hbWxvZ2ljL21lc29uOGItb2Ryb2lkYzEuZHRzCmluZGV4
IGIwMzI3M2Q5MGFkOC4uZGYzNDhlMTE5NjQzIDEwMDY0NAotLS0gYS9hcmNoL2FybS9ib290L2R0
cy9hbWxvZ2ljL21lc29uOGItb2Ryb2lkYzEuZHRzCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2Ft
bG9naWMvbWVzb244Yi1vZHJvaWRjMS5kdHMKQEAgLTIxNywxMyArMjE3LDEzIEBAIHZkZGVlOiBy
ZWd1bGF0b3ItdmRkZWUgewogCQljb21wYXRpYmxlID0gInB3bS1yZWd1bGF0b3IiOwogCiAJCXJl
Z3VsYXRvci1uYW1lID0gIlZEREVFIjsKLQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8ODYw
MDAwPjsKKwkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTEwMDAwMD47CiAJCXJlZ3VsYXRv
ci1tYXgtbWljcm92b2x0ID0gPDExNDAwMDA+OwogCiAJCXB3bS1zdXBwbHkgPSA8JnA1djA+Owog
CiAJCXB3bXMgPSA8JnB3bV9jZCAxIDEyMjE4IDA+OwotCQlwd20tZHV0eWN5Y2xlLXJhbmdlID0g
PDkxIDA+OworCQlwd20tZHV0eWN5Y2xlLXJhbmdlID0gPDE0IDA+OwogCiAJCXJlZ3VsYXRvci1i
b290LW9uOwogCQlyZWd1bGF0b3ItYWx3YXlzLW9uOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZWd1
bGF0b3IvcHdtLXJlZ3VsYXRvci5jIGIvZHJpdmVycy9yZWd1bGF0b3IvcHdtLXJlZ3VsYXRvci5j
CmluZGV4IDMwNDAyZWUxODM5Mi4uY2I0ZTVmYWQ1NzAyIDEwMDY0NAotLS0gYS9kcml2ZXJzL3Jl
Z3VsYXRvci9wd20tcmVndWxhdG9yLmMKKysrIGIvZHJpdmVycy9yZWd1bGF0b3IvcHdtLXJlZ3Vs
YXRvci5jCkBAIC0xNTYsMTMgKzE1NiwxMCBAQCBzdGF0aWMgaW50IHB3bV9yZWd1bGF0b3JfZ2V0
X3ZvbHRhZ2Uoc3RydWN0IHJlZ3VsYXRvcl9kZXYgKnJkZXYpCiAJdW5zaWduZWQgaW50IHZvbHRh
Z2U7CiAKIAlwd21fZ2V0X3N0YXRlKGRydmRhdGEtPnB3bSwgJnBzdGF0ZSk7CisJaWYgKCFwc3Rh
dGUuZW5hYmxlZCkKKwkJcmV0dXJuIC1FTk9UUkVDT1ZFUkFCTEU7CiAKLQlpZiAocHN0YXRlLmVu
YWJsZWQpCi0JCXZvbHRhZ2UgPSBwd21fZ2V0X3JlbGF0aXZlX2R1dHlfY3ljbGUoJnBzdGF0ZSwg
ZHV0eV91bml0KTsKLQllbHNlIGlmIChtYXhfdVZfZHV0eSA8IG1pbl91Vl9kdXR5KQotCQl2b2x0
YWdlID0gbWF4X3VWX2R1dHk7Ci0JZWxzZQotCQl2b2x0YWdlID0gbWluX3VWX2R1dHk7CisJdm9s
dGFnZSA9IHB3bV9nZXRfcmVsYXRpdmVfZHV0eV9jeWNsZSgmcHN0YXRlLCBkdXR5X3VuaXQpOwog
CiAJLyoKIAkgKiBUaGUgZHV0eWN5Y2xlIGZvciBtaW5fdVYgbWlnaHQgYmUgZ3JlYXRlciB0aGFu
IHRoZSBvbmUgZm9yIG1heF91Vi4KQEAgLTIyMSw2ICsyMTgsNyBAQCBzdGF0aWMgaW50IHB3bV9y
ZWd1bGF0b3Jfc2V0X3ZvbHRhZ2Uoc3RydWN0IHJlZ3VsYXRvcl9kZXYgKnJkZXYsCiAKIAlwd21f
c2V0X3JlbGF0aXZlX2R1dHlfY3ljbGUoJnBzdGF0ZSwgZHV0eWN5Y2xlLCBkdXR5X3VuaXQpOwog
CisJcHN0YXRlLmVuYWJsZWQgPSB0cnVlOwogCXJldCA9IHB3bV9hcHBseV9zdGF0ZShkcnZkYXRh
LT5wd20sICZwc3RhdGUpOwogCWlmIChyZXQpIHsKIAkJZGV2X2VycigmcmRldi0+ZGV2LCAiRmFp
bGVkIHRvIGNvbmZpZ3VyZSBQV006ICVkXG4iLCByZXQpOwo=
--000000000000d28aac060d0e2533--

