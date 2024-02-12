Return-Path: <linux-kernel+bounces-61422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEE1851229
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72EAC284510
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEB538FB2;
	Mon, 12 Feb 2024 11:25:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CEE28DDE;
	Mon, 12 Feb 2024 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737140; cv=none; b=Dmt0c9W4zWx1pVQdRUeYYjTHd6tgKRWMAtvI+TFQboVpZP8+RN1jR8w8/+xN2hhx8K7P/s2UjSG613vdgPnGFIHNickpp9yfWGvPXLBJGoeNcUA96AgVZPy0WKDAWnFTZV2QZzxmbMxWsw/jPEgnjaOaEJ0AjH94eireJ7cdqyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737140; c=relaxed/simple;
	bh=oX9zawn8w42iSe548Q/L408crulfgqh73G2TUKXYY4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSXPfPY4t4usBtSqXS5I0pq8cm7nODV8wNXD25bHBNgHMRZ/YQ/e9cDBJe1PRaF1T/fonESbiRSBYKc+JKG45wsGXjgIC5rkUYvoIuSNRqDTNkbUiG4RyZpu1sqe6MKk8vKonSI8cE/KhuvevazbRiPbqmIPi5pZkadAzHzOo18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DD70DA7;
	Mon, 12 Feb 2024 03:26:19 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A1403F762;
	Mon, 12 Feb 2024 03:25:35 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Konrad Dybcio <konradybcio@gmail.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Tao Zhang <quic_taozha@quicinc.com>,
	Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jinlong Mao <quic_jinlmao@quicinc.com>,
	Yuanfang Zhang <quic_yuanfang@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	Tingwei Zhang <quic_tingweiz@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Song Chai <quic_songchai@quicinc.com>,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	Leo Yan <leo.yan@linaro.org>,
	andersson@kernel.org,
	Trilok Soni <quic_tsoni@quicinc.com>
Subject: Re: [PATCH v7 00/10] Add support to configure TPDM CMB subunit
Date: Mon, 12 Feb 2024 11:25:29 +0000
Message-Id: <170773624998.2157180.11126865505279178953.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1707024641-22460-1-git-send-email-quic_taozha@quicinc.com>
References: <1707024641-22460-1-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 4 Feb 2024 13:30:31 +0800, Tao Zhang wrote:
> Introduction of TPDM CMB(Continuous Multi Bit) subunit
> CMB subunit is responsible for creating a dataset element, and is also
> optionally responsible for packing it to fit multiple elements on a
> single ATB transfer if possible in the configuration. The TPDM Core
> Datapath requests timestamps be stored by the TPDA and then delivering
> ATB sized data (depending on ATB width and element size, this could
> be smaller or larger than a dataset element) to the ATB Mast FSM.
> The CMB makes trace elements in two modes. In �continuous� mode, every
> valid data cycle creates an element. In �trace on change� mode, when
> valid data changes on the bus, a trace element is created. In
> continuous mode, all cycles where this condition is true create trace
> elements. In trace on change mode, a data element is only when the
> previously sampled input is different from the current sampled input.
> 
> [...]

Applied, thanks!

[01/10] coresight-tpdm: Optimize the store function of tpdm simple dataset
        https://git.kernel.org/coresight/c/9f0ea8e8344b
[02/10] coresight-tpdm: Optimize the useage of tpdm_has_dsb_dataset
        https://git.kernel.org/coresight/c/f021801c418e
[03/10] dt-bindings: arm: qcom,coresight-tpdm: Add support for CMB element size
        https://git.kernel.org/coresight/c/4ed57f75898c
[04/10] coresight-tpdm: Add CMB dataset support
        https://git.kernel.org/coresight/c/a1705ffcce52
[05/10] coresight-tpda: Add support to configure CMB element
        https://git.kernel.org/coresight/c/e6d7f5252f73
[06/10] coresight-tpdm: Add support to configure CMB
        https://git.kernel.org/coresight/c/2d9ab11c262e
[07/10] coresight-tpdm: Add pattern registers support for CMB
        https://git.kernel.org/coresight/c/53d4a017a524
[08/10] coresight-tpdm: Add timestamp control register support for the CMB
        https://git.kernel.org/coresight/c/dc6ce57e2aa0
[09/10] dt-bindings: arm: qcom,coresight-tpdm: Add support for TPDM CMB MSR register
        https://git.kernel.org/coresight/c/19bfaff38457
[10/10] coresight-tpdm: Add msr register support for CMB
        https://git.kernel.org/coresight/c/8e8804145a46

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

