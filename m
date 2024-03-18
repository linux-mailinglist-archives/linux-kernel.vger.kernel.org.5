Return-Path: <linux-kernel+bounces-105835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF28487E534
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C24B216C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30A928E1B;
	Mon, 18 Mar 2024 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezDP/fXp"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A9D28DB3;
	Mon, 18 Mar 2024 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751710; cv=none; b=PsEAGxUhsbo5Sj3Fe64I0uFl8NaaZ9dN7CvPohjcuvllcMPZCmDhGsES0lxqM0fHXdYYokRw8WT1lWuwANIjPFxfwNmwTF+I6PXU9xdNLMQK0OpeUKbNiFse0Y5ObChwu9m7nI1fn+4ZekBEhlyM/ndMCjNWNAEerNLjIM4IaPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751710; c=relaxed/simple;
	bh=JbhalFVOWE8ob0NFwL/Zd1xtzRDw3LbSHyNV56UbvCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvQUSZjfPhxrPyX89l0CpSulrqdAqS5Owjo0x/WaGfqTrkm5vfUCuYZafsk/9df6UqrcbTX1nYSeY6n88dl7dzDcgLBkHxWFPP6VkAyABnQAjmYEj8Q8D2NrFdrPQFRAMN7Ue4zvaddyAtd9N0AK+Wl4JMAMimrTOqgKxZf1p18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezDP/fXp; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2222b96e4d2so2556434fac.3;
        Mon, 18 Mar 2024 01:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710751708; x=1711356508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npuV+MPjFSDr3HzZ1jEevx08H7DusAET6upqkhgWg4o=;
        b=ezDP/fXpfbJIwjrzkzzgPVmVe2nDHsQ9tKP2HWBxXKAEO3hleZgg8pafKKR0Uw2OgY
         VpwIEHJQJn9pprqJLctIs3RDwd+q91F941t//E25METmWA9FNhp2l7rasJJkbaS+xVtl
         LdzNUKGAJcpakpJcgixOC8Hh4IwycX3JQQnIsVuNtyrZcpOaTBQWp88aBISE1tCUozRh
         tZlXKXFf3tmmwsQf9+QMhxTZouaTvaZOfWySmHaZjpb6JKGejs8yS27xnjUsV0SoLu/F
         wn2B10dCg7pT0Lm3WSaan+a9gXnow7iIrDT3d4rivtSH2jRqNLlqd64UKRvl8MLL8H/g
         bTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710751708; x=1711356508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npuV+MPjFSDr3HzZ1jEevx08H7DusAET6upqkhgWg4o=;
        b=gj3KOLCPyzXKXhAZrdFx/xI38Yq2wgXfLtunJ38wJbEysFourA+NittTaQvzeMUcHO
         zJB3UKDk6WKJpKN/5k5WBFvxZjKeuDPLh01p+8VHY/VoRktB+opv07T05rAThs7hotnM
         tEmbIiEwXNFA+JU5LpOV4dDWETMqM2pOvSqT84pFR9+I68bi8JRKbzbC46KT1dQjwmA8
         sHLDGLdEslTRIijq4sXSCKu18w1Sd0ckU3MFYCRDlIzzE6Rh3c+c6/Ji32BG75QT1sSD
         cRF8J3OiQ/4iFYovGqFL4QhpxQPNFRGU9BCp9HelVc5UlIKWLHFzIiJvnawEWX7v1+uK
         yviA==
X-Forwarded-Encrypted: i=1; AJvYcCUdBZp4Mj6lAzESx34aVa/QLyikwW2JOvctV0en3mylsCWqFElwDMUXgCQvxUd+34KNt8GhiV/TKlVki+/uZqs17TYYbV1WujvJX8/5mn4RRYgMkozGFxggJS7l6zo2cE2liI3RKwk2pj362ZSbndGEPSx1DpA09MwvTIlSie6AbsT+HV8=
X-Gm-Message-State: AOJu0Ywym4CyLLW6+qfi7S+q6+BuzBmtqcs22/lD2MzV2fI3i4eo9Mrs
	7xKaTQAV6zdtMDnxCt2roTkF1oQQG+2u35mpx2UGkctsob6FxQlt1SLesFcN68f3WjN/xMNwaFV
	3AEFmj0BBUFMY8PmCl7KDS4occ30=
X-Google-Smtp-Source: AGHT+IETjYlP8OmJEtS9A7tonlde3gO7yveZ3H0MRWYGfVElthO7L1t7r3b9bdSl8NrQTIQOGzxNqDOGbNgVpYGsXAk=
X-Received: by 2002:a05:6870:2192:b0:21e:528f:54e9 with SMTP id
 l18-20020a056870219200b0021e528f54e9mr12511527oae.18.1710751708108; Mon, 18
 Mar 2024 01:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <CAMhs-H9ZO-sitsrASuvsEd+ddwVyHH35gj7yAABTqFNfOCGYYw@mail.gmail.com>
 <60512ae2-dd73-4cb6-9514-145f946300fc@linaro.org> <5d6c36cb9dd9afda1efb69aa34058517@risingedge.co.za>
 <adefc3ff-86a5-4af7-8276-73d0e0108901@linaro.org> <26633d73360e43b2c548f49e544472ea@risingedge.co.za>
In-Reply-To: <26633d73360e43b2c548f49e544472ea@risingedge.co.za>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Mon, 18 Mar 2024 09:48:15 +0100
Message-ID: <CAMhs-H_1bwfKO8yquz-3BHQ0UQYW1FFVJYHE66w8Q9m1+fCCHw@mail.gmail.com>
Subject: Re: [PATCH 00/14] mips: dts: ralink: mt7621: improve DTS style
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mips@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 4:43=E2=80=AFPM Justin Swartz
<justin.swartz@risingedge.co.za> wrote:
>
> On 2024-03-17 17:29, Krzysztof Kozlowski wrote:
> > On 17/03/2024 16:22, Justin Swartz wrote:
> >> On 2024-03-17 17:10, Krzysztof Kozlowski wrote:
> >>> On 16/03/2024 16:49, Sergio Paracuellos wrote:
> >>>> On Sat, Mar 16, 2024 at 5:54=E2=80=AFAM Justin Swartz
> >>>> <justin.swartz@risingedge.co.za> wrote:
> >>>>>
> >>>>> This set of patches was created with the intention of cleaning up
> >>>>> arch/mips/boot/dts/ralink/mt7621.dtsi so that it is aligned with
> >>>>> the Devicetree Sources (DTS) Coding Style [1] [2] guide.
> >>>>>
> >>>>> [1] Documentation/devicetree/bindings/dts-coding-style.rst
> >>>>>
> >>>>> [2]
> >>>>> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
> >>>>>
> >>>>> Justin Swartz (14):
> >>>>>   mips: dts: ralink: mt7621: reorder cpu node attributes
> >>>>>   mips: dts: ralink: mt7621: reorder cpuintc node attributes
> >>>>>   mips: dts: ralink: mt7621: reorder mmc regulator attributes
> >>>>>   mips: dts: ralink: mt7621: reorder sysc node attributes
> >>>>>   mips: dts: ralink: mt7621: reorder gpio node attributes
> >>>>>   mips: dts: ralink: mt7621: reorder i2c node attributes
> >>>>>   mips: dts: ralink: mt7621: reorder spi0 node attributes
> >>>>>   mips: dts: ralink: mt7621: move pinctrl and sort its children
> >>>>>   mips: dts: ralink: mt7621: reorder mmc node attributes
> >>>>>   mips: dts: ralink: mt7621: reorder gic node attributes
> >>>>>   mips: dts: ralink: mt7621: reorder ethernet node attributes and
> >>>>> kids
> >>>>>   mips: dts: ralink: mt7621: reorder pcie node attributes and
> >>>>> children
> >>>>>   mips: dts: ralink: mt7621: reorder pci?_phy attributes
> >>>
> >>> These are all simple cleanups for the same file. It's one patch, not
> >>> 15.
> >>
> >> I agree these are all simple cleanups.
> >>
> >> Even though the cleanup pattern was the same, or very similar,
> >> for each node affected, the intention was to isolate each change
> >> to a single node (or a grouping of nodes of that seemed logical
> >> to me) so that if anyone had any objections, the discussion would
> >> be easier to follow in subthreads identifiable by patch names (and
> >
> > Objections to what? Coding style? Coding style is defined so you either
> > implement it or not... and even if someone disagrees with one line
> > swap,
> > why it cannot be done like for every contribution: inline?
>
> I had been asked to include empty lines when I had left them out when
> I had contributed a patch regarding the serial nodes, which resulted in
> a second version of that patch.
>
>
> > Organize your patches how described in submitting patches: one per
> > logical change. Logical change is to reorder all properties in one
> > file,
> > without functional impact.
>
> If I had accidentally deleted or modified an attribute in the process
> of cleanup, this could have had a functional impact. It's easier to
> notice this sort of omission when the wall of text you're confronted
> with is as small as possible, and not multiple pages long.
>
>
> >> But if there're no objections and it lessens the burden on
> >> maintainers upstream to have less patches to apply, then I have no
> >> problem combining them into a single patch.
> >>
> >
> > Yeah, one review response instead of 14 responses... One commit in the
> > history instead of 14.
>
> I agree that 1 commit vs 14 is better.
>
> But for future reference: is it not enough for the Reviewed-by: trailer
> to be sent in response to the cover letter of a patch set if a reviewer
> has looked at the entire set?

It is enough, AFAICT. I found your patchset very easy to review so I
am ok with the patchset as it is. However, at the end this will be
through the mips tree, so let's do what Thomas prefers: add all
patches as they are or squash all of them in one commit.

Thanks,
    Sergio Paracuellos

