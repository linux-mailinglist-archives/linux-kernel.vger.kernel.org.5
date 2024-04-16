Return-Path: <linux-kernel+bounces-147270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA95B8A71C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1F61C21D09
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF30E132C23;
	Tue, 16 Apr 2024 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjabBRnw"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF38A132C15
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286741; cv=none; b=GnABdk4W8xUmcZkmzVb/3oPPDHK03DoCiWQpkltdLXZtRu8No2M/7RNEcOezCbKUyeEIg5WFVl01kox9SlKcfnCEQFzUvTTz3FPGEmbxwsz1yy7Szf2HxLg38Y72DUzSgZKR3avLPulurlnoCL84JDkBDzUXUErsroj0+MQgXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286741; c=relaxed/simple;
	bh=tWfbnoK1Qaj31Z0XQ+nOrUn3n/AiI7P9NYHI0EI/IIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrMf12qE2iCKoxQyKBJR4qz+7fiRQ4aTEWzgqs2Y+ddeJtDmYhcj5zOr4TOjz3jcIY0X1gjN8fmZv4D8WE/Jt/hkV/i642KKjN6ZLVLEUsfA7iB0Rx3FGiMIvRmc/1/xHAPiGsi8eqTAf8d+HDvXA8gblmmotPuZXhKi0PATeLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gjabBRnw; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso4273055b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713286739; x=1713891539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWfaKH5keS4brSMvsRe/D018x90YicD6A19pBYw0+W8=;
        b=gjabBRnwUH2PnhpG34XpL/9XllrCwvZ8bvvq1QpjuDGyyPHz0Lkh77w2ZCgO74gRhT
         hNnJdsulyWo1vsNRIYO9rgZlqL6/ueu+5KOM3Q0ggvZUxiY4ccvmVUovaPA01QMbeLrB
         8Iz2JTVRAS4AO3SXr0mE/65OVR5yLy+fMlj1fcDOoESM5ZiCaTm2xV7l4zdtLm4BuPCC
         P9AC8rwmfSp+zdvpTOE1JhaVXrtGRt1LwXj1hae4urEtkxPW82/+aGXq0lNWaXDq4eak
         8obpXMUCggJOBgkNASu1py9QNxQOsSfTutvq+Zi+ibOZwE+jZMDqSVtVQM/r1jKK/53Y
         3ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713286739; x=1713891539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWfaKH5keS4brSMvsRe/D018x90YicD6A19pBYw0+W8=;
        b=LS7MtaEuSN3LCDEV11NC99D7vWyrb6oeKJVFF6yv2W43hNBkKFEhdb9exdT91FLTyU
         liy327/l1dzAaGcCPfo7cs26RpuTMpu6h30T4pk9u/UA3SjqYmaxVpCllMEgFPw364Rx
         q6YlOyH6TJmBJkfG+uvYfecJfw8WAorvnKDeMMgVPfMpnoVH/iTTvXn3/fZTWzdpCMNa
         uQFNslshYXWsFNT3cXMSa2VcMzTIIVgAp8TzSCVjKQgw2m0AAWerauzgUG+dG53niE8r
         wOUD0oTnQAp4IqMNGI5avp7eky/tm0db68FjIKxPeUfVz1MzXR76olXU2byN7N5RwNVC
         pAEw==
X-Forwarded-Encrypted: i=1; AJvYcCUtlUHsx1dezWPLZ4uAzQ8lVnDROTPU9NChsMUO3Rt75GJjH4yEezvWsh43FrRppd/X3QvZ4NK28kTY14H0UJ8uONebzgR6e4K9sp6H
X-Gm-Message-State: AOJu0YxIddhZeJqENmg5YnN5Yn4luLV1dziAtwmWlzYXKE9WQRqIBGQf
	UqtHYZEAJcij2MpEYu/nM8dMlKHglGjJ6abtpy0FhQUkw1sZO8HRgS7VZFVPdgMQvtec6y48Mef
	Q
X-Google-Smtp-Source: AGHT+IF5bchOM5Ajqn1ld2S/Wn8rEC3XoO6+HL/hiPq0GTjHE721escY4Q1kI6+RN+TccwK9SjISXg==
X-Received: by 2002:a05:6a00:22d6:b0:6ed:d8d2:5040 with SMTP id f22-20020a056a0022d600b006edd8d25040mr17657763pfj.21.1713286739096;
        Tue, 16 Apr 2024 09:58:59 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:6e4e:6aac:cff6:726e])
        by smtp.gmail.com with ESMTPSA id d20-20020a63d654000000b005dc3fc53f19sm9190074pgj.7.2024.04.16.09.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:58:57 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:58:54 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	michal.simek@amd.com, ben.levinsky@amd.com,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 0/4] add zynqmp TCM bindings
Message-ID: <Zh6uTkK/ZoI5+l/F@p14s>
References: <20240412183708.4036007-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412183708.4036007-1-tanmay.shah@amd.com>

On Fri, Apr 12, 2024 at 11:37:04AM -0700, Tanmay Shah wrote:
> Tightly-Coupled Memories(TCMs) are low-latency memory that provides
> predictable instruction execution and predictable data load/store
> timing. Each Cortex-R5F processor contains exclusive two 64 KB memory
> banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
> In lockstep mode, both 128KB memory is accessible to the cluster.
> 
> As per ZynqMP Ultrascale+ Technical Reference Manual UG1085, following
> is address space of TCM memory. The bindings in this patch series
> introduces properties to accommodate following address space with
> address translation between Linux and Cortex-R5 views.
> 
> |     |     |     |
> | --- | --- | --- |
> |      *Mode*        |   *R5 View* | *Linux view* |  Notes               |
> | *Split Mode*       | *start addr*| *start addr* |                      |
> | R5_0 ATCM (64 KB)  | 0x0000_0000 | 0xFFE0_0000  |                      |
> | R5_0 BTCM (64 KB)  | 0x0002_0000 | 0xFFE2_0000  |                      |
> | R5_1 ATCM (64 KB)  | 0x0000_0000 | 0xFFE9_0000  | alias of 0xFFE1_0000 |
> | R5_1 BTCM (64 KB)  | 0x0002_0000 | 0xFFEB_0000  | alias of 0xFFE3_0000 |
> |  ___               |     ___     |    ___       |                      |
> | *Lockstep Mode*    |             |              |                      |
> | R5_0 ATCM (128 KB) | 0x0000_0000 | 0xFFE0_0000  |                      |
> | R5_0 BTCM (128 KB) | 0x0002_0000 | 0xFFE2_0000  |                      |
> 
> References:
> UG1085 TCM address space:
> https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm/Tightly-Coupled-Memory-Address-Map
>

I have applied patches 1, 2 and 4 of this set.  Patch 3 should to through
Michal's tree.

Thanks,
Mathieu

> ---
> 
> prerequisite-patch-link: https://lore.kernel.org/all/d4556268-8274-4089-949f-3b97d67793c7@gmail.com/
> Base Branch: 6.9.rc2
> 
> Changes in v15:
>   - Use hardcode TCM addresses as fallback method if "reg" unavailable
>   - Use new bindings for r5fss subsystem
> 
> Changes in v14:
>   - Add xlnx,tcm-mode property and use it for TCM configuration
>   - Add Versal and Versal-NET platform support
>   - Maintain backward compatibility for ZynqMP platform and use hardcode
>     TCM addresses
> 
> Changes in v13:
>   - Have power-domains property for lockstep case instead of
>     keeping it flexible.
>   - Add "items:" list in power-domains property
> 
> 
> Radhey Shyam Pandey (1):
>   dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings
> 
> Tanmay Shah (3):
>   remoteproc: zynqmp: fix lockstep mode memory region
>   dts: zynqmp: add properties for TCM in remoteproc
>   remoteproc: zynqmp: parse TCM from device tree
> 
>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 279 ++++++++++++++++--
>  .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |   8 +
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  67 ++++-
>  drivers/remoteproc/xlnx_r5_remoteproc.c       | 273 +++++++++--------
>  4 files changed, 459 insertions(+), 168 deletions(-)
> 
> 
> base-commit: 4d5aabb6843939fad36912be8bf109adf9af0848
> -- 
> 2.25.1
> 

