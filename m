Return-Path: <linux-kernel+bounces-52919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F36849E58
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE9C28A755
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC91732C89;
	Mon,  5 Feb 2024 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8eReduE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC0344C64;
	Mon,  5 Feb 2024 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147198; cv=none; b=iTTt3kanBHdtUHL4LVqYWOc0R4pBNlyUkwsLH+heP5MXKCn0smujHnCLBya8A3W91d8OXHfzLTQnALHvgWMraS8V4dtUmS//Tu0IfmZcmEHn2d3kJt31uXMgkn1NN1BmzXIDqIJrOpESP7/6W9OGbSGXktOSYn/drDpLwUsM8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147198; c=relaxed/simple;
	bh=gCOn8lMXqIZY6GPLwFd8/YtzqKXfBD7yFS+3U2224/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U22xDIwmaJEx5devJoxis2Gczgdkg/A28hMctsG7UCPrrcE0lDp9I1nSvzbtwgUvozhD6ABum6I6kRYW1520yDS+OCQ54PlftyaY6jqs0fSBCMKF+QDok4V5qGLFaNHDPnG2Qv0iZ/mYrYETA5cmWr9NTGNsrQwzZJCA4t+U56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8eReduE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3C7C43143;
	Mon,  5 Feb 2024 15:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707147197;
	bh=gCOn8lMXqIZY6GPLwFd8/YtzqKXfBD7yFS+3U2224/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r8eReduEZ+f6KXaR/+jcK39d1YjPp5n+Z8VFfRDNq995dvPbGCVE6/6PdS3nJv0M5
	 HJrObsU2g/betHwRD6q78rBNyCyc86XOtPMmo5JQy2be8t7EZF/uH2S0A5A4ESbvF4
	 1Qw0ft7VGLyacKZdwEDLYkGQo6whN61bl7v64Jw6h81R169cgXZwZFfIs8nNc1o1xG
	 H1nugkQvSYf5tkBObyybrEuHf6IuYJMzMhUtOCeezr+FDx0X98dq/sQBRJFebXjRIu
	 rulgkgXaYDMam9qYx457W+IYEkJ9bkcPWjLtZCI1i1S9JqXcAvxIiLX1hUYbaOCrLL
	 XAUT0P/DgeaYg==
Date: Mon, 5 Feb 2024 09:33:14 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Anjelique Melendez <quic_amelende@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, lee@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	agross@kernel.org, konrad.dybcio@linaro.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: Re: [PATCH 1/2] dt-bindings: soc: qcom: Add qcom,pbs bindings
Message-ID: <jnn5hxa5nj26ocmdectpg5dq6cxrcd5d22x3kffhd4jc7i4nh6@fqgxlcwgj5th>
References: <20240201204421.16992-2-quic_amelende@quicinc.com>
 <20240201204421.16992-4-quic_amelende@quicinc.com>
 <1de7cfbc-3507-459f-842e-c9349b2f05ac@linaro.org>
 <4a9b6d7b-70ab-cd18-770c-37993b0ccc63@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a9b6d7b-70ab-cd18-770c-37993b0ccc63@quicinc.com>

On Fri, Feb 02, 2024 at 09:49:21AM -0800, Anjelique Melendez wrote:
> 
> 
> On 2/1/2024 11:29 PM, Krzysztof Kozlowski wrote:
> > On 01/02/2024 21:44, Anjelique Melendez wrote:
> >> Add binding for the Qualcomm Programmable Boot Sequencer device.
> >>
> >> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > How is it possible? This is v1, not a resend, and I never give review
> > tags not in public.
> > 
> > Best regards,
> > Krzysztof
> > 
> Sorry for the confusion, this patch was originally in this series:
> https://lore.kernel.org/all/20231221185838.28440-2-quic_amelende@quicinc.com/,
> where you gave your reviewed by tag in v3:
> https://lore.kernel.org/all/102328fa-5699-4731-d639-079bce8863a5@linaro.org/.
> This was separated into a new series since half of the original
> patches were already applied. I mentioned this in the cover
> letter but in future should I keep version the same as the original
> series?
> 

Marking the patch(es) v9 makes it clear that they have been on the list
already. This would be true either if you rebased v8 (and git dropped
the applied patches from your series), or if you resubmitted some patch
on it's own.

Regards,
Bjorn

