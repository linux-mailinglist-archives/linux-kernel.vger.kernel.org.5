Return-Path: <linux-kernel+bounces-82801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7458689D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343C21C21DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661A454BF7;
	Tue, 27 Feb 2024 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crayPIgt"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277E75467A;
	Tue, 27 Feb 2024 07:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018904; cv=none; b=ohkVX78L2Tu1ansXuLcPq7ZhbTEtm4Fk5fkeGj0myKGGhOegoEMZplbEbRBh5LPLgYSXLpytl+FXudz7FVlBM38sPIOJaykFjhsyysP3p51APWh1yvyINqToTexSa6h22tKJEu5yxNE03tsMiGvb52coiPWvPhIvk75bQkSJVwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018904; c=relaxed/simple;
	bh=1/iCSINOM9ktWkzosjfbZRxEXx1qwuEmh0fqu+UCCps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoGnfUxjevIVW/FGeTy8wpuCXKj+WWgGy0zhS5t1/tBIefajzItfow5ZMS0Zpc5AleT2dTAeW/+lZ9i/PuUxj0p35P/TXTrhWYnIy2S2NCLv5ejoad0LhSYMlUrjZjhsLXeCbBdKB/F0Q1S1XLG3WBUO+fhe2e6VQsk2NFO/rsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crayPIgt; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3e85a76fa8so364327066b.1;
        Mon, 26 Feb 2024 23:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709018901; x=1709623701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI30shSOvui+UA44wihEn+kkOQkF830aXh8hZ+sdOqY=;
        b=crayPIgtPu6xX654pJ6a3WoMUrJOxlsmbjVVzCIMHUieRyc246rzFENqHFv58t/PyM
         6DAyL8PJhkn9LDC3wVBDdmQpQKWnyGJkOlQwEV6Yur7zo54PWRuRulX6trMdH7+Znw24
         FnM/m08HAIUSOHmbUJR2W5FBQsb91gLZLRpQM0YHw+utKBIoFC5A4iWSAP4DV35smPib
         Cqn6s6gqR4eP6DojpvARdNNiXVLDuGxYF5bGAEr8b1jON2ySl2LZo70LhT1AtDBk1y3/
         kulMqCizUjMO2n5QD4k0LU7i5mrEtQoXjQ/fOesB/e5Us71dMrm5GvRYj4d9xwgDLEmh
         swug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709018901; x=1709623701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zI30shSOvui+UA44wihEn+kkOQkF830aXh8hZ+sdOqY=;
        b=Ur/U4Sa16M+HBXXrEHHJDmpqh+DkxluTnuREHYu3ug6oVSU1opdNZPwMQ05YP8D4lz
         5AtFjAoyxbiFoPOI/rsfMwVVLJAHgWopR8R+cNVwJA8e2BTZYPVcXFM1cCgG8NVl4vqJ
         Oh6fHuOBIP0O0bXRgFih1qGlLaNUuHZwShz3DZvjUiNhNBT2Bv/OikCOjklrFQie/vlQ
         dbvuC08x+qo3WKAZIMYjw2GrA7sshaGfSLjkesf9t++HF6N5KGrjlvmmAdlPEYZMa8fd
         0STzgAoXjHzmnOz+7+EZ8euu/2azXUastnZtMzahuATAOlHPia87UZEkBqFxhSZNOASx
         2QLA==
X-Forwarded-Encrypted: i=1; AJvYcCXj6DWwopVX94eOOjsreq9lVmnsTVXBIEB7xhFcg64VR6PSodQ8vJE2swtRU7p6wq1olSPYZkc1cyTF1Wg0iTJamGB1RvMcv8cUNKwnioNsVVsKedzafoECwRtDhzeThJjqFOzC4MJ5gutBgTj9gABXCn/X466F46BP13IORy5ToWPUJWvt0GQuV260S1cD7EHC8d5iGHQkH1vKWJz7CkaLFzXm
X-Gm-Message-State: AOJu0Yy97oEH9JBg63EJXOSeLo04uJsLiiT1/8sS7AfNbC8JU3ltEqSw
	1UosZ0lTgukoDTHdYyLqqrchf/UhVr4hpnhw/DXlKEFFdg8SPC8cFH4UWJO+XolwFk0knU7LqY9
	gaWa/BDbFzsF5z9b0At1jWh0l0aX/cMuso7Wb2A==
X-Google-Smtp-Source: AGHT+IEg2zGbhLsEmK2ifI6SjC4f7kPzu91OBzps+VEwu7WS+AfN3IpeWRons2+BVRC69ODcSaX8fDa9Gqy3tZ2gFQk=
X-Received: by 2002:a17:906:2318:b0:a43:ab98:d36a with SMTP id
 l24-20020a170906231800b00a43ab98d36amr644131eja.17.1709018901441; Mon, 26 Feb
 2024 23:28:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226104653.54877-1-lukas.bulwahn@gmail.com> <87o7c3mlwb.fsf@intel.com>
In-Reply-To: <87o7c3mlwb.fsf@intel.com>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Tue, 27 Feb 2024 08:28:10 +0100
Message-ID: <CAKXUXMz-aTN3qrOmacWT_12awUT4wYTH8sr7SEc4B6XiYtz-BA@mail.gmail.com>
Subject: Re: [PATCH] docs: submit-checklist: structure by category
To: Jani Nikula <jani.nikula@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jani,

On Mon, Feb 26, 2024 at 1:48=E2=80=AFPM Jani Nikula <jani.nikula@intel.com>=
 wrote:
>
> On Mon, 26 Feb 2024, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > diff --git a/Documentation/process/submit-checklist.rst b/Documentation=
/process/submit-checklist.rst
> > index b1bc2d37bd0a..7d8dba942fe8 100644
> > --- a/Documentation/process/submit-checklist.rst
> > +++ b/Documentation/process/submit-checklist.rst
> > @@ -11,110 +11,121 @@ These are all above and beyond the documentation =
that is provided in
> >  and elsewhere regarding submitting Linux kernel patches.
> >
> >
> > +*Review your code:*
>
> If you're adding subheadings, maybe consider making them actual
> subheadings instead of just italicizing them.
>
> The top heading should probably be modified to follow the guidelines in
> Documentation/doc-guide/sphinx.rst. This should be a separate change.
>

I have done that. In my humble personal opinion, at the moment, the
subheadings look a bit too large in the HTML view compared to the few
points below.
However, I am planning to add more points to the checklist anyway when
I understand and have summarized the essence of the other documents
for patch submissions (submitting-patches and howto).

So, let us make them subheadings.

> > +
> >  1) If you use a facility then #include the file that defines/declares
> >     that facility.  Don't depend on other header files pulling in ones
> >     that you use.
> >
> > -2) Builds cleanly:
> > +2) Check your patch for general style as detailed in
> > +   :ref:`Documentation/process/coding-style.rst <codingstyle>`.
> >
> > -  a) with applicable or modified ``CONFIG`` options ``=3Dy``, ``=3Dm``=
, and
> > -     ``=3Dn``.  No ``gcc`` warnings/errors, no linker warnings/errors.
> > +3) All memory barriers {e.g., ``barrier()``, ``rmb()``, ``wmb()``} nee=
d a
> > +   comment in the source code that explains the logic of what they are=
 doing
> > +   and why.
>
> I think we should just remove all the manually updated bullet
> numbering. Either make them bulleted lists with "*" or autonumbered
> lists with "#.". See [1]. This should be a separate change.
>

Done that. I used "#." to still have the numbering in place.

The two changes are straightforward, and I will send them out as a v2
series, once Randy has had time to provide his feedback on the content
of the v1 patch and I have included his review remarks.


Lukas

