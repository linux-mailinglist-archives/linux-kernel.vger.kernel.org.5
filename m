Return-Path: <linux-kernel+bounces-64463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C11853EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285851C243A7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA90D626B2;
	Tue, 13 Feb 2024 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj9Ww9VM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDE1433AB;
	Tue, 13 Feb 2024 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863493; cv=none; b=MIuZZ56VZ/IyOCwlzLi9Fa7SU/383R8Hhot46u8bTLuZhR1Frlx4vEyqSmiFs4UzYVN83BmJ9kdcvkgZOB6GjtppeLy/gBITTUhVWlRHVE8c7jtc1EhA7uVfapDOVO0a601i77UfY7A/Y5hsi7MbpZ1sviiHyGL/kjac+90JIPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863493; c=relaxed/simple;
	bh=tUMsXY/XfFkqr7u0iiEPY04YFBGnHpoUhaqNlD4VLF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs0fNf3Hx5aO3O6560I7DJceLfJ6jq6eOZCWS8o3z/hZ5sxzxKpRwoHQ7rrW4Ea97NdAebLGN30NDBS7q3ZarBkCT754jAz6pSPtg36MdPMGf/ZnKJrkVHmbiRcdfFme3aQ4sCFJTwcshKogwWd5iTQV/xzCgGhi/oc0YeGr7wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj9Ww9VM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7F7C433F1;
	Tue, 13 Feb 2024 22:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707863492;
	bh=tUMsXY/XfFkqr7u0iiEPY04YFBGnHpoUhaqNlD4VLF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kj9Ww9VMf2s40wjwtHIk/4onEZen6N4x8brxw8zIQYpWt9ckJpLD0s1PsT1D7Ia4b
	 rr2biX+69XirmVQ1ZHWV7XJ9mxseJb1hE58+/+s8cwIBW5dBHX+PexEUR3sGzke4rZ
	 5m5gzjxGgFtIZ5SssmS9sjsAjZDSIz77/F0zzHUbpK5uHdFlzlge/QvRan4fgWux6N
	 gLyH70dAC1VOq5bTjKC60y4/PcpqjtK8rKpSz9hy3y67IEX7NhDqNy/GzlnJ3sXT2y
	 J/1vuXMajieuCWoMVIgh7QSHrLpk+Kgbqc1Rpd0Z5dxLiCzoeCkFOgO3j0g76rHU5U
	 9W+cutZzWdbBw==
Date: Tue, 13 Feb 2024 16:31:30 -0600
From: Rob Herring <robh@kernel.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-remoteproc@vger.kernel.org,
	michal.simek@amd.com,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	ben.levinsky@amd.com, linux-kernel@vger.kernel.org,
	mathieu.poirier@linaro.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 2/4] dt-bindings: remoteproc: add Tightly Coupled
 Memory (TCM) bindings
Message-ID: <20240213223130.GA2504650-robh@kernel.org>
References: <20240213175450.3097308-1-tanmay.shah@amd.com>
 <20240213175450.3097308-3-tanmay.shah@amd.com>
 <170785205177.2155555.1311787541370066483.robh@kernel.org>
 <b931a24c-f676-4ddb-bb7c-e7a509d5dd4b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b931a24c-f676-4ddb-bb7c-e7a509d5dd4b@amd.com>

On Tue, Feb 13, 2024 at 02:37:49PM -0600, Tanmay Shah wrote:
> Hello,
> 
> Thanks for reviews please find my comments below.
> 
> On 2/13/24 1:20 PM, Rob Herring wrote:
> > On Tue, 13 Feb 2024 09:54:48 -0800, Tanmay Shah wrote:
> > > From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > > 
> > > Introduce bindings for TCM memory address space on AMD-xilinx Zynq
> > > UltraScale+ platform. It will help in defining TCM in device-tree
> > > and make it's access platform agnostic and data-driven.
> > > 
> > > Tightly-coupled memories(TCMs) are low-latency memory that provides
> > > predictable instruction execution and predictable data load/store
> > > timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB memory
> > > banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
> > > 
> > > The TCM resources(reg, reg-names and power-domain) are documented for
> > > each TCM in the R5 node. The reg and reg-names are made as required
> > > properties as we don't want to hardcode TCM addresses for future
> > > platforms and for zu+ legacy implementation will ensure that the
> > > old dts w/o reg/reg-names works and stable ABI is maintained.
> > > 
> > > It also extends the examples for TCM split and lockstep modes.
> > > 
> > > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > ---
> > > 
> > > Changes in v10:
> > >   - modify number of "reg", "reg-names" and "power-domains" entries
> > >     based on cluster mode
> > >   - Add extra optional atcm and btcm in "reg" property for lockstep mode
> > >   - Add "reg-names" for extra optional atcm and btcm for lockstep mode
> > >   - Drop previous Ack as bindings has new change
> > > 
> > > Changes in v9:
> > >   - None
> > > Changes in v8:
> > >   - None
> > > Changes in v7:
> > >   - None
> > > Changes in v6:
> > >   - None
> > > Changes in v5:
> > >   - None
> > > 
> > > Changes in v4:
> > >   - Use address-cells and size-cells value 2
> > >   - Modify ranges property as per new value of address-cells
> > >     and size-cells
> > >   - Modify child node "reg" property accordingly
> > >   - Remove previous ack for further review
> > > 
> > > v4 link: https://lore.kernel.org/all/20230829181900.2561194-2-tanmay.shah@amd.com/
> > > 
> > >  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 192 ++++++++++++++++--
> > >  1 file changed, 170 insertions(+), 22 deletions(-)
> > > 
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> > ./Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml:118:13: [warning] wrong indentation: expected 10 but found 12 (indentation)
> Ack. I will fix this.
> 
> However, can I still get reviews on patch itself so if something else needs to be fixed I can fix in next revision as well.
> 
> Also, I tried to run yamllint with following command:
> 
> make DT_CHECKER_FLAGS=-m dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml O=../build/zynqmp/linux-next/
> 
> 
> However, I see following logs without any error on bindings:
> 
>   LINT    Documentation/devicetree/bindings
> invalid config: unknown option "required" for rule "quoted-strings"
> *xargs: /usr/bin/yamllint: exited with status 255; aborting*
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTEX    Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.example.dts
>   DTC_CHK Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.example.dtb
> 
> I am not sure if my system is missing something but, yamllint tool is failing.

"unknown option" means old version of yamllint.

Rob

