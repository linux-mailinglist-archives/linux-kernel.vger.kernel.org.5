Return-Path: <linux-kernel+bounces-45392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA1E842F98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB972283EB5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2182F7BAF5;
	Tue, 30 Jan 2024 22:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkLqlFp+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575407BAF4;
	Tue, 30 Jan 2024 22:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653348; cv=none; b=B8SNICiMk1A2jox8DAzsLK5QpypdBciieBVv8JamrCvclL4jx9dX3qTYvA7a1BhF7oDB0RCuNenF+Azkx7E8pbpMyzqGMSBtg+sIKc5y/FkIngrgbipdScQFIf2IMNk7SwGy7FAryUoU4uZDPlYaoKNLBMMlqYJV68lT7KH9WT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653348; c=relaxed/simple;
	bh=CkFoaSeaycRC/DdmqGseEXgolv8sOgi4brXXvJsnits=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhL/HoG0jkxO5/OKiIxg1J8uZUQpnvE3EIiGnUVPCc6W4z02fJn9wPJTdMFEu/DHy8S4LraW1yZRU7iTUjGQSgv9OyBm2W1+WcczHAajTcbnv5WEC5MMWbMg88WfZMjlDuX4akwydkXapuXAQu7WOt0fhFSJe6E2Ct2XKN0BC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkLqlFp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C7CC433F1;
	Tue, 30 Jan 2024 22:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706653347;
	bh=CkFoaSeaycRC/DdmqGseEXgolv8sOgi4brXXvJsnits=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NkLqlFp+p02rJhYrNCRAMkgDSzYY1khObhOkevhg8VHgOnkRR1dp4964AVQtOALIA
	 /8ywsB3PYTq6nkTy4ZufaRlj9IrgV46bGtsmJ+I4zz+Zozzz5BwM3LpC0kit1f/2cq
	 Y3bKEdlF3gwTSBhSX+fPtjBrnhrjXC24CVD0KM4v+Uirfec98sb4vJghQcKrb3DZOb
	 WulpVYvV1bkG+q+kFwbSjfjkv04pQQ+6+Yw3DhIsTvqd+VWoEkRoc8Be8G1ZiZ7Wq+
	 1AVrayqAoA3UrfFhFglkL2Vmvxt8GaPsQvL1OoCZT8MUKeQI4nkakdOBCFs8LrS7jI
	 gQ14+uHVy/0PA==
Date: Tue, 30 Jan 2024 16:22:23 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Tingwei Zhang <quic_tingweiz@quicinc.com>, Yuanfang Zhang <quic_yuanfang@quicinc.com>, 
	Tao Zhang <quic_taozha@quicinc.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add coresight nodes for sm8450
Message-ID: <i6frhaxuhadqzf6tnci4pkvza2ajz6djn3pqdm3f7tvhvpixzg@mkntoeo2d2if>
References: <20240119092500.7154-1-quic_jinlmao@quicinc.com>
 <20240119092500.7154-3-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119092500.7154-3-quic_jinlmao@quicinc.com>

On Fri, Jan 19, 2024 at 01:24:58AM -0800, Mao Jinlong wrote:

In line with other changes to sm8450.dtsi, the subject should be:
arm64: dts: qcom: sm8450: Add coresight nodes

Regards,
Bjorn

