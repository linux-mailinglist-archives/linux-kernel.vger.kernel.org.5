Return-Path: <linux-kernel+bounces-164628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406408B8058
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700A71C227CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C36194C95;
	Tue, 30 Apr 2024 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smEyfi/E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761AF172BD7;
	Tue, 30 Apr 2024 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714504421; cv=none; b=CLuS82ab0NSvG2BjFw7EHkAq1tq0t4OjxMKPBTqlg9drKRE+rFIA+h491uPRK8jiWRsTo0GsAWVHm2kqan3lkx3t03kTciVi0KgFI/q2hMGMA34Q/vNSgMB+1cUSMnAAKbYYnCbVxblGrUkqg3jAIpWS7gPXhQ5TscUqKy49ceY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714504421; c=relaxed/simple;
	bh=Urq3LK4nbrE0DFxUYkRFrryw4CWIaUGFevJJUvp2tSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsBP5ca/bist5zdNCuVrAq+V3sTIxLiIsZlS6ZbIi6/cC6V6ta2jRe4GvISeNTqog557v7TWK6YHqVPfK1dxevcYJauYRg45L+snQpFBldB1TPafVuDZrU1kHCpqrsPbhSyQBnY+B4Ha2HzSk84Xdl8azazD4H7JnnQsgMPmybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smEyfi/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00771C4AF17;
	Tue, 30 Apr 2024 19:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714504421;
	bh=Urq3LK4nbrE0DFxUYkRFrryw4CWIaUGFevJJUvp2tSs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=smEyfi/EUdc2ONslX1BfnnSGon+y2tAJqOixYdh2BKIdMHU8GqPMSMt54qi7mt518
	 tG8cXBMyWww9n4tHUmlFdRcgGiT6xScvQUiiyTDj6QbOUVhhla4HNK2th/kZSco3s7
	 Ghdx2hJFs8XGxF3JCwABJbpMJuyEEkU4GcyPAVB+vz3R8ePKNFRMLuPZNwXSNK6ijM
	 Hk+/gFljoGx3wQDO3r8EX6311JFgC6WC3khD6PoflnNG2qVuH02R5oCuFtXq2MA0or
	 4KqotpOnPKN+WU99E3Y4lZYn76BGwLkeqztvdG3ryTfOv5pj5SzdxQgwbWgZBxIaE/
	 VuhZFM4/UhFaw==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c70418ef53so551543b6e.1;
        Tue, 30 Apr 2024 12:13:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUF4Ar4Azds4MoVMiNZMDt5C2J7kvlXRtPlvO2laaM2LPSpY2vLtpkOLiR4zI/2+nTAxJm/0bx+3lK8fH5dHKAc1iQYPylG7g5GoaP8GxQDDRXxJRa4A8kfyTcZgjY+4oPN6+8segE=
X-Gm-Message-State: AOJu0YyGJeLuGTnDMoBmdI5v1y1sQn6hp0tl7ojZrI/0MjL97kiiJBbK
	wgQjMlhenll9lp4v5HZV1BN5V5NeyrQFnP+0/S4miICdkHLmEMNl4eCaUgIhhM9QZwTZvy+6+J1
	zkQE9L4K53QOP7XQ46TKHqSX2s80=
X-Google-Smtp-Source: AGHT+IH0h4lwe5rqFLExPMT7hda/xtCDre2rP5lWnQsUtV8HttfVWhWH541nxDNFMTos9bH+Ag6qjjQX65qAL+sQC7w=
X-Received: by 2002:a4a:654d:0:b0:5aa:241a:7f4b with SMTP id
 z13-20020a4a654d000000b005aa241a7f4bmr378497oog.1.1714504419959; Tue, 30 Apr
 2024 12:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428092427.24959-1-rui.zhang@intel.com>
In-Reply-To: <20240428092427.24959-1-rui.zhang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 21:13:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jpaa2tp_NF9N=ViSiz3xmY_abREPZQxK1Hk57Wv7ggHg@mail.gmail.com>
Message-ID: <CAJZ5v0jpaa2tp_NF9N=ViSiz3xmY_abREPZQxK1Hk57Wv7ggHg@mail.gmail.com>
Subject: Re: [PATCH V4 0/2] powercap: Introduce TPMI RAPL PMU support
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2024 at 11:24=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> wr=
ote:
>
> RAPL energy counter MSRs are exposed via perf PMU. But this is done by
> separate code which is not part of RAPL framework, and it cannot be
> reused by other RAPL Interface drivers like TPMI RAPL.
>
> Introduce two new APIs for PMU support in RAPL framework. This allows
> TPMI RAPL PMU support and also makes it possible for future cleanups of
> MSR RAPL PMU code.
>
> Changes since V3:
> - Fix is_rp_pmu_cpu() return value. (Rafael)
> - Following the conversion in other PMU drivers to use
>   local64_try_cmpxchg() instead of local64_cmpxchg(). E.g. bcc6ec3d954b
>   ("perf/x86/rapl: Use local64_try_cmpxchg in rapl_event_update()"), and
>   update with a comment.
>
> Changes since V2:
> - drop patch 1/3 and rebase on PM tree bleeding-edge branch.
> - fix a regression introduced in patch V2 that RAPL PMU is not
>   successfully unregisted when unbinding the device. This causes kernel
>   calltrace about duplicate PMU name in sysfs when reloading the module.
>   Our unit test cases reproduced this but the test framework failed to
>   catch it, and now that problem is also fixed.
> - add comment for RAPL PMU implementation details.
> - add comment/document for struct rapl_pmu and rapl_package_pmu_data.
> - remove unneeded global RAPL PMU cpumask.
> - use an array to map RAPL PMU events to RAPL Domains.
> - Other minor improvements.
>
> Changes since V1:
> - remove the MSR RAPL PMU conversion because it is a separate work that
>   can be done later.
> - instead of using a flag to indicate the need of PMU support, introduce
>   two APIs for the RAPL Interface driver to invoke explicitly.
> - minor code/comments/changelog improvements.
>
> thanks,
> rui
>
> ----------------------------------------------------------------
> Zhang Rui (2):
>       powercap: intel_rapl: Introduce APIs for PMU support
>       powercap: intel_rapl_tpmi: Enable PMU support
>
>  drivers/powercap/intel_rapl_common.c | 582 +++++++++++++++++++++++++++++=
++++++
>  drivers/powercap/intel_rapl_tpmi.c   |   3 +
>  include/linux/intel_rapl.h           |  32 ++
>  3 files changed, 617 insertions(+)

Both patches applied as 6.10 material, thanks!

