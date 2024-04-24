Return-Path: <linux-kernel+bounces-156267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE488B008A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3002816F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5CD140363;
	Wed, 24 Apr 2024 04:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="t7FgfskB"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D82885C46
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713932915; cv=none; b=lQGR1V2eboZ3fb9FDu7q6pWDSG/9MxtPMX0PXHmQQQwLBxj643nYkCIuCAPWjg6BEF14gluLRRTg+zO0pvHf0KL0q7O5WH4bTtYsIcJ/dnn50ypu1NixvdSd1xdF2fWkpTbH7O00BhnMlpeErpCVwPljNho3//3gmQzKQNr3Ots=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713932915; c=relaxed/simple;
	bh=SVlBsh+OtGzs8Wz8fbFQpOEK85w5Obn5WGl0/vqVgpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqGgATx6/Jh+HdCKhwe2bcumMhVrWPM1M+CCQVbGSXwBrflI1jmDTTh+wg+xNGi4I71opNugW6xwker1K63PkjL/6r8/KcAFOwoGjQOxik1uiU60mqNAkxM4ITrhPiRg+HAJnD2wblP0ekBG7b3b5019rYkMP2fSkRy06uv1WWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=t7FgfskB; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so400221276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1713932913; x=1714537713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvX5ZYnBGyHu2whyk5II8GGcdhq7ix0Hf+Bdyx6MY/I=;
        b=t7FgfskBYzOs7VRYTqgQgkWKMmCAJ04cv0dCJNem+2vSGrb0UQnJLu1yypQmkJ5rob
         bMNU+UrCzIhzmBb9b5REd1BEVgGnW0u8dwmtHdREZ/uudX7EpT61VS1n96xIwrna7Xg0
         1dEe9vw+pKtf6in0+lNXZ6mx/ga0ZuDYfm6Ae8xpK3COEz4pogeLuHVudumSHKliV8Xv
         n82dDR5SUraRm+1DmnXjK261P3FDCWAl+aarjbMlEUWmz0S79aeokbxX8lHe7oXbuVNy
         1CL5XV1cfBxq+tU8W82v6CyuE1l/jhYXEZXOx39SS7OFZb60ZK2+eJ1JzW50XYcItYTt
         jT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713932913; x=1714537713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvX5ZYnBGyHu2whyk5II8GGcdhq7ix0Hf+Bdyx6MY/I=;
        b=oxuyL9u9hTn6koPFlzZAbMLotJ8c63FJLVXn2s2/diDLVZHqOtjReuOEcTw6nxLXTF
         d5GyZlWVx8jFTjM05IdnXs/sNLnVxmEj9AgQB6jQJJ4ZxA+IMOsL5A4aK+I7VdDXa2CE
         T2gv82lA3ubKbuyeWLTE5OGMgwhFzSvJN5D3VlNLp7FeOkKFFcxnZffsQsPO4ZXxGoV2
         CW9MAcyoEZyX74Ev55SctVQ4ihUHx6+PJcb0iTevE0rH62GZ21V3jc39VZEO6aLmvgID
         6zPGhZnjPZJS7THv2TclzVBtBSDvyvO+zHlGwSxhCYvLt7W51If4LmTfkRxBq3XmryLc
         /zFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWapjganCf3A0gBnl3OD7t9As3SdX9jiEDG02k1hmG3UOFxK38Ew82i4O1NC4Q9ahEhO0/RYS1w09oPSZb0qrrcZRTfn8KkW5DQIF5T
X-Gm-Message-State: AOJu0YwVzUkqQqWxoZKcABrpv4cRVJWsEPgwwNbdJtc/c28JG/TOJeyW
	RpBiX2MeRZKFq1qQ3eqE5NU1BLDZVOciKQnUQ7gU0A5cjibxqHpV5sl6RgCqMEAy/ZDBD44Y2YJ
	2u301Wh+vNDyDL4q4LZaT8iTm0pvXNSg5H9uK9A==
X-Google-Smtp-Source: AGHT+IEgApdXc0FTtI/Xj8zQmgelnm3yr/jZQQiEnnLxc8JkipkVIQosbx1ZbD1ANvA85SasBfj8sm5x8fx4Ig2fyKk=
X-Received: by 2002:a25:fc22:0:b0:dc7:421d:bcc0 with SMTP id
 v34-20020a25fc22000000b00dc7421dbcc0mr968151ybd.32.1713932913048; Tue, 23 Apr
 2024 21:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216062642.247504-3-jhp@endlessos.org> <20240301214117.GA408641@bhelgaas>
In-Reply-To: <20240301214117.GA408641@bhelgaas>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Wed, 24 Apr 2024 12:27:57 +0800
Message-ID: <CAPpJ_eejyughPK4JXfjNdOvZegEy30tEusjPk4ESkvCQJCbPHg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] PCI/ASPM: Fix L1.2 parameters when enable link state
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, David Box <david.e.box@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bjorn Helgaas <helgaas@kernel.org> =E6=96=BC 2024=E5=B9=B43=E6=9C=882=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=885:41=E5=AF=AB=E9=81=93=EF=BC=9A
>
> In subject:
>
>   PCI/ASPM: Fix L1.2 parameters before enabling L1.2
>
> > +     if (state & link->aspm_capable & ASPM_STATE_L1_2_MASK) {
> > +             parent_l1ss_cap =3D aspm_get_l1ss_cap(parent);
> > +             child_l1ss_cap =3D aspm_get_l1ss_cap(child);
> > +             aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap)=
;
>
> Why doesn't this happen already via normal enumeration?  It looks like
> this path should do it even without this patch:
>
>   pcie_aspm_init_link_state
>     pcie_aspm_cap_init
>       aspm_l1ss_init

I watch the VMD remapped PCI devices' power states during this path.
Their power states stay at "unknown" until someone sets their power
state to "D0".
And, because their power states stay at "unknown", the L1.2 of the
link between VMD remapped PCIe Root Port and NVMe gets wrong configs
when system goes through this path.
So, system has to calculate the L1.2 information again after set PCI
devices' power state to D0.

Sorry for the late reply.  Got my laptop back recently.

Jian-Hong Pan

> > +     }
> >       pcie_config_aspm_link(link, policy_to_aspm_state(link));
> >
> >       link->clkpm_default =3D (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> > --
> > 2.43.2
> >

