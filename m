Return-Path: <linux-kernel+bounces-98103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30F187752F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 03:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722091F217FD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A6810A26;
	Sun, 10 Mar 2024 02:41:44 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6B3F503;
	Sun, 10 Mar 2024 02:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710038504; cv=none; b=uh3l9EFzpdxFWT/nH91dWFFU1FefM/9kHGyZ6jCgmF/k/O0PUkLMHTj1P7r9AdCCdhPUtTasYJVDrXefEYeOLSPoNcjwnsdELPl8a73QJm9vDQG02YEvxgOEmha5Ejucshd8MpMZ+fbOt0C2CQq6vAo2/Njx+1xMWeV2j3Q+2yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710038504; c=relaxed/simple;
	bh=66Y5qag4Fo0ap9z/IV7T/7k7EdEpd6gS16wKWMFuh1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGoglCsvUexynZP4zWLuiDQRUrBTzWtgjrWryNbT/1cCQktf70RmysR0XYj9AUlnz8xVSErMgPufspgrtZVy70/muVK0wuPpkxbSNkwiP+UfB8uRLdkKQV0Q8GmAobImuDtcQ+ybRkItfvD4bUxFU91ZqsCok3azCwmActiDj/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso46799821fa.2;
        Sat, 09 Mar 2024 18:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710038500; x=1710643300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQvaxw+Y3V1NHy0Tzp6P8M9Pv6okqvjXC3TYBcH3uZ8=;
        b=rKWKi31Wxn6r9NLcbx556fENmfJ6v7Ij7OxlrxrBLJ1NPMlBhgyh0l3MYecktU2Lc4
         jm6WXHCJ+7/duojYH3kTIRrIfNiHRIlOWc8OQjjmwI/xkH4GWTwIYGVgEb8RlEvmEnoC
         UZ31KFUpzYyfpZdYlQ5DjQp/t5zUPnkbi/O15wJdLvjn52TugqgiuXnDDASp9D/88ps3
         JQCN8mRsV/luOwZITMxUbh1FOsDV/IA3pO19eQGFMezZf4WAJX3sfoe5KBV/TZl1wAXH
         P20VhTJ1FzxBSS7AJ7E9kcH7U7hRuNFBmRj3uGNI4fGkT/wL8mTNMLNQNcmtSASS06IB
         cFVA==
X-Forwarded-Encrypted: i=1; AJvYcCUsU6oMpacW5ge8DYSjc5RhZgicLGTMuwgK06chPYVRJ/ZuOK3F0M8qCdLT21TzZv3VBwx51OUITiarSAc5dpl2J5SBTTcGD36KuILKgbWPyCzHgWgQJbiL0Ege/v643mOMSJaopXIjzSuInZ/UxRpQ7YWKoJ0C6BJBwlf715z4y9yDi1DnsigkuIFplz8=
X-Gm-Message-State: AOJu0YwuO086LfOPVURFTqzEeXKDG1ZtM7y5JpAUVGlcA4whs5UKeQQ/
	M9tinnlnsbtrUcBkOr/OX9HfDPNe/ANHnPNhGT9D/K3ieqerNWWDsa00URq2ty4=
X-Google-Smtp-Source: AGHT+IFSehV2ROwdDwWGOLVyb8jCNrjb+37FLRhmS8H/lcXohDHqiIJFQh7B0LcIoyi1qe+CkSzJtg==
X-Received: by 2002:ac2:4834:0:b0:513:54e6:e174 with SMTP id 20-20020ac24834000000b0051354e6e174mr1692983lft.37.1710038499640;
        Sat, 09 Mar 2024 18:41:39 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id f23-20020a19ae17000000b005134bfbf9a7sm502654lfc.153.2024.03.09.18.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 18:41:39 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso46799601fa.2;
        Sat, 09 Mar 2024 18:41:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXZglmyiG+x5ml4ynD1YhM/K+8tA311+bEXqrtuO+HX+W3RkG/Gtdyjb2VmItrUqrMEKdsigMO71m9MhB3DYE/gtUOUsD120gbEQGDdN+JJUKIpxsrz/Q4bB90zZRBTsmOE/ccR6b88BG3UQ83Fd1vPfXau3Zgg7DMcHNclkDPAuIaUSL75YHnJh7oO20=
X-Received: by 2002:a2e:9b58:0:b0:2d3:1bd0:6bcf with SMTP id
 o24-20020a2e9b58000000b002d31bd06bcfmr1860058ljj.8.1710038499246; Sat, 09 Mar
 2024 18:41:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308210519.2986-1-W_Armin@gmx.de> <20240308210519.2986-2-W_Armin@gmx.de>
 <42aa0678-4472-4964-b84e-33beb0a23058@linux.intel.com> <232dcca6-d4b0-4c5a-9e17-d9c194a67a71@gmx.de>
In-Reply-To: <232dcca6-d4b0-4c5a-9e17-d9c194a67a71@gmx.de>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Sat, 9 Mar 2024 18:41:28 -0800
X-Gmail-Original-Message-ID: <CAC41dw-rfEN798=t=oWfX6rZFqAv6CxGw8vA7B98X1bWk2AFMw@mail.gmail.com>
Message-ID: <CAC41dw-rfEN798=t=oWfX6rZFqAv6CxGw8vA7B98X1bWk2AFMw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] platform/x86: wmi: Avoid returning AE_OK upon
 unknown error
To: Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, rafael@kernel.org, 
	lenb@kernel.org, mario.limonciello@amd.com, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 11:10=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 09.03.24 um 18:41 schrieb Kuppuswamy Sathyanarayanan:
>
> > On 3/8/24 1:05 PM, Armin Wolf wrote:
> >> If an error code other than EINVAL, ENODEV or ETIME is returned
> >> by ec_read()/ec_write(), then AE_OK is wrongly returned.
> >>
> >> Fix this by only returning AE_OK if the return code is 0, and
> >> return AE_ERROR otherwise.
> >>
> >> Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.
> >>
> >> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> >> ---

Got it.

Reviewed-by: Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com>

> >>   drivers/platform/x86/wmi.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> >> index d9bf6d452b3a..84d1ccf6bc14 100644
> >> --- a/drivers/platform/x86/wmi.c
> >> +++ b/drivers/platform/x86/wmi.c
> >> @@ -1218,8 +1218,10 @@ acpi_wmi_ec_space_handler(u32 function, acpi_ph=
ysical_address address,
> >>              return AE_NOT_FOUND;
> >>      case -ETIME:
> >>              return AE_TIME;
> >> -    default:
> >> +    case 0:
> >>              return AE_OK;
> >> +    default:
> >> +            return AE_ERROR;
> >>      }
> > After checking the callers of acpi_wmi_ec_space_handler() it looks like=
 there is no benefit in returning different ACPI status per error values. I=
t is not being used. why no just return for result < 0 AE_ERROR and return =
for other cases?
>
> Hi,
>
> those handler functions are being called in acpi_ev_address_space_dispatc=
h(), which uses the return value to print error messages.
> So it makes sense to return different ACPI error values here.
>
> Thanks,
> Armin Wolf
>
> >>   }
> >>
> >> --
> >> 2.39.2
> >>
> >>

