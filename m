Return-Path: <linux-kernel+bounces-40389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA99183DF61
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F82628D9D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08AF1EA7D;
	Fri, 26 Jan 2024 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI+bwlJA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33C1F5FD;
	Fri, 26 Jan 2024 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706288442; cv=none; b=cRhrlKAty2ltCnXMLRF4crtJt8oGLKBYA4As8i98G+IxjPeIBAbPvL4DBMqJDz86oxPaFk4Ecd+y02m/L5cmgdzyT0HwrdxnrSU07zAXAw+7JBC2oJNWno6UyWuXn8U6BJm3/7nfM2Y7ChRjCE/4rDOPe/eHvWfxujEsx/yOPMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706288442; c=relaxed/simple;
	bh=kQd8hVxOkDuCAoACPvGiNfrW2jBdHX+iSYu0SuJjptE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WU0waZUCp1zlhHQqaEjwmaHzMvL9JMMGaKMduYBBnGfdS5VM8ZAsTqDPy6/wlxuGe+Q1bnaR6VkvBeOgPE2kdk83tJPrHiKcja3/V1ogGiFeZbF2rZQFZtajhmenYOrGI9a0gST0sl9E99cUeTwMczcD1DTDkLSl9jLDnva7IBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI+bwlJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E842C433F1;
	Fri, 26 Jan 2024 17:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706288441;
	bh=kQd8hVxOkDuCAoACPvGiNfrW2jBdHX+iSYu0SuJjptE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fI+bwlJAJp7YwkYZHtgRAX35aioQsUuQZSuRQMQtZ1vY3nrhn0B0H81xlQWC2A/vI
	 KXP1zBmIJvgC1i6/0zqvZ3JIaZR4n071T5+JId9M/HKucymqNqPPOw/MKGEt5iYEl1
	 Tasb3X2kcRuX7w2fB4vSDWWAZ9hMuV6qv3msq497qk6LJaFIRWc5rxcROmfntGZM5q
	 IvjjbTr+C1bkQtRnaykH99o6x/kbU1RwzV0jFyUotUj49DVJy09tsvgDixPYfk91wX
	 RV4mjpTKrPkieHz6BZCvKNsEv4ifeBdgHKxfLPx6ZeCrCD5popHCOx9W9HFAmRxnzN
	 5ZgEVc6nKV7YA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rTPZW-000000000AO-0JkD;
	Fri, 26 Jan 2024 18:00:54 +0100
Date: Fri, 26 Jan 2024 18:00:54 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sc8280xp: Introduce additional
 tsens instances
Message-ID: <ZbPlRsx3czAHRBew@hovoldconsulting.com>
References: <20240126-sc8280xp-tsens2_3-v2-1-8504d18828de@quicinc.com>
 <ZbPfeq6ElA3vMf_O@hovoldconsulting.com>
 <20240126165113.GS2936378@hu-bjorande-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126165113.GS2936378@hu-bjorande-lv.qualcomm.com>

On Fri, Jan 26, 2024 at 08:51:13AM -0800, Bjorn Andersson wrote:
> On Fri, Jan 26, 2024 at 05:36:10PM +0100, Johan Hovold wrote:

> > Shall you submit a follow-on patch to set the polling delays to zero
> > for the other thermal zones (cpu, cluster, mem) so that we don't poll
> > for those?
> 
> I optimistically interpreted Konrad's response as a promise by him to do
> so ;)
> 
> I do like his patch which remove the poll-properties for non-polling
> mode. Would be nice to not first change the values to 0 and then remove
> the properties...

No, that should not be an issue as it allows us to get rid of the
polling without waiting for a binding update which may or may not
materialise in 6.9-rc1.

But whoever updates those properties need to do some proper testing to
make sure that those interrupts really work.

Johan

