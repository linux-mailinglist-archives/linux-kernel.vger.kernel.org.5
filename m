Return-Path: <linux-kernel+bounces-25060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8237682C70E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3381C21946
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69BA17730;
	Fri, 12 Jan 2024 22:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6bRLQsI"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575CC1772F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-428405a0205so19981cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705097756; x=1705702556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP5fGZzgpZ9SrgGeq8dIeW2tXFSQwQhUhlpKAu1DbqQ=;
        b=j6bRLQsIMTu7MjvtVYm+17W91DlDKOc09sNbaC9blJe5qhzFrdfpTT1m9UpqhmOLLR
         upRgU+xo+hlvbJLqxazgh/wuHcsPB4QLrlLy4WH416z4rpDQtqSC+ye+Tksw58vq/s03
         Tw1tDb7sGYaXOF9sL6z9KrHe0Zg8xhTJy91486DJrx8SBdT7GwUw1VumiG+SRRX+EsiL
         sByZ5aWvIGXvSw8uaf1gKd5M/AE4LNIh2jlvzQFhglOZYYVM7KP/orZuU2BFqT9K2Kt3
         4ws/pnGNKQ8NKsUNqaxXdEr1BLepE5Jm+D1nmM3xJVBNZE/Nqw8NgUX1vh2BVG6xsqgJ
         ONAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705097756; x=1705702556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oP5fGZzgpZ9SrgGeq8dIeW2tXFSQwQhUhlpKAu1DbqQ=;
        b=T8BwEHXAXxiRq4NkBTvUHZhPxqaG4m/sZnRmexjADcoyP1Uc2CLyy8TXKIKd7fBDoM
         g+g0m18pdvNIvXTIVOLVwGXNQ1UEHhJm4nW74qkJgHQzcnLk+RKyny63NgsQpnCNiyPZ
         ium6GL9a181f2FkBeJhElyn/kgTepLPzFob52T9qQ4Yzs0EhHhhFJCHaiEOygl9LeYsh
         SaNdulfWdePkpQoLv33cUiHGG9g0CVWNUFAnD4VPfocMosnkukzn2VNn/M5cnYKuHj85
         cq6riJQwkMTHR9q9CUnqbxv8SkEweAndyIbxBm8h6aoYFWAVgp2yZiiURq/uTFnFmsgH
         9nRg==
X-Gm-Message-State: AOJu0Yx7g9HHNZ8TBfFzFkxJp4g0+TwpurJcvTTvmfM7UOKHSKxq9ziq
	ab3vPLougjcl20v3UcaCdGyiZq8ATLF2AynOAr9hTxeCHhE7
X-Google-Smtp-Source: AGHT+IFFoU3MTUjYQMJj8EicBpziSzS7VeX+N1XmF+YFP6bUz5fPV3J53vSVX9kFH6naS1msjeDVFB3ysZ6ZaVwLbG8=
X-Received: by 2002:a05:622a:174d:b0:429:cba2:8628 with SMTP id
 l13-20020a05622a174d00b00429cba28628mr312680qtk.24.1705097755996; Fri, 12 Jan
 2024 14:15:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111014933.1934562-1-davidai@google.com> <20231111014933.1934562-2-davidai@google.com>
 <20231208124503.unhka7c6ihzrrwhu@bogus>
In-Reply-To: <20231208124503.unhka7c6ihzrrwhu@bogus>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 12 Jan 2024 14:15:20 -0800
Message-ID: <CAGETcx9p8y7uN08_KyO45KygDU9i4KnU4HLd1XGhK+k0e9sahA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: add virtual cpufreq device
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: David Dai <davidai@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Quentin Perret <qperret@google.com>, Masami Hiramatsu <mhiramat@google.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Pavan Kondeti <quic_pkondeti@quicinc.com>, 
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 4:47=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> On Fri, Nov 10, 2023 at 05:49:29PM -0800, David Dai wrote:
> > Adding bindings to represent a virtual cpufreq device.
> >
> > Virtual machines may expose MMIO regions for a virtual cpufreq device
> > for guests to read frequency information or to request frequency
> > selection. The virtual cpufreq device has an individual controller for
> > each frequency domain.
> >
> > Co-developed-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: David Dai <davidai@google.com>
> > ---
> >  .../cpufreq/qemu,cpufreq-virtual.yaml         | 99 +++++++++++++++++++
> >  1 file changed, 99 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/qemu,cpuf=
req-virtual.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-vir=
tual.yaml b/Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.=
yaml
> > new file mode 100644
> > index 000000000000..16606cf1fd1a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.ya=
ml
> > @@ -0,0 +1,99 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/cpufreq/qemu,cpufreq-virtual.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Virtual CPUFreq
> > +
> > +maintainers:
> > +  - David Dai <davidai@google.com>
> > +  - Saravana Kannan <saravanak@google.com>
> > +
> > +description:
> > +  Virtual CPUFreq is a virtualized driver in guest kernels that sends =
frequency
> > +  selection of its vCPUs as a hint to the host through MMIO regions. E=
ach vCPU
> > +  is associated with a frequency domain which can be shared with other=
 vCPUs.
> > +  Each frequency domain has its own set of registers for frequency con=
trols.
> > +
>
> Are these register controls described somewhere ? The reason I ask is we
> should be able to have single implementation of this virtual cpufreq
> irrespective of the firmware used(DT vs ACPI) IMO.

Agree that we want the same driver to work for DT and ACPI. This doc
was written to be similar to other DT binding docs that don't describe
the registers in the DT binding. The registers are pretty straight
forward (can tell from the code too). One register to "set" the
frequency and another to "get" the current frequency. We don't have
any ACPI expertise/hardware to test this on or care about it right
now. But David looked at some ACPI drivers and we think it should be
trivial to add ACPI support to this. Just a different set of probe
functions to register and populate the CPUfreq table.

>
> > +properties:
> > +  compatible:
> > +    const: qemu,virtual-cpufreq
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description:
> > +      Address and size of region containing frequency controls for eac=
h of the
> > +      frequency domains. Regions for each frequency domain is placed
> > +      contiugously and contain registers for controlling DVFS(Dynamic =
Frequency
> > +      and Voltage) characteristics. The size of the region is proporti=
onal to
> > +      total number of frequency domains.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    // This example shows a two CPU configuration with a frequency dom=
ain
> > +    // for each CPU.
> > +    cpus {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      cpu@0 {
> > +        compatible =3D "arm,armv8";
> > +        device_type =3D "cpu";
> > +        reg =3D <0x0>;
> > +        operating-points-v2 =3D <&opp_table0>;
> > +      };
> > +
> > +      cpu@1 {
> > +        compatible =3D "arm,armv8";
> > +        device_type =3D "cpu";
> > +        reg =3D <0x0>;
> > +        operating-points-v2 =3D <&opp_table1>;
> > +      };
> > +    };
> > +
> > +    opp_table0: opp-table-0 {
> > +      compatible =3D "operating-points-v2";
> > +      opp-shared;
> > +
> > +      opp1098000000 {
> > +        opp-hz =3D /bits/ 64 <1098000000>;
> > +        opp-level =3D <1>;
> > +      };
> > +
> > +      opp1197000000 {
> > +        opp-hz =3D /bits/ 64 <1197000000>;
> > +        opp-level =3D <2>;
> > +      };
> > +    };
> > +
> > +    opp_table1: opp-table-1 {
> > +      compatible =3D "operating-points-v2";
> > +      opp-shared;
> > +
> > +      opp1106000000 {
> > +        opp-hz =3D /bits/ 64 <1106000000>;
> > +        opp-level =3D <1>;
> > +      };
> > +
> > +      opp1277000000 {
> > +        opp-hz =3D /bits/ 64 <1277000000>;
> > +        opp-level =3D <2>;
> > +      };
> > +    };
> >
>
> I think using OPP with absolute frequencies seems not appropriate here.
> Why can't these fetched from the registers and have some abstract values
> instead ?

Whether the frequencies are real or you want to cap it to 1024 and
normalize it, you still need to populate the CPUfreq table. And we
didn't want to reinvent the wheel and want to use existing means of
representing the table in as cross-architecture as possible -- so, DT
and ACPI should cover them all. For example, if we want to say CPU0
and 1 for a single CPUfreq policy, that's all already doable in DT. We
don't want to reinvent new schemes/register interfaces for that.

>
> > +    soc {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <1>;
> > +
> > +      cpufreq@1040000 {
> > +        compatible =3D "qemu,virtual-cpufreq";
> > +        reg =3D <0x1040000 0x10>;
>
> So just 16bytes for 2 CPU system ? How does the register layout look like=
 ?
> I assume just 4 x 32bit registers: 2 for reading and 2 for setting the
> frequencies ?

Yup. 2 registers per CPU frequency domain or policy.

Thanks,
Saravana

