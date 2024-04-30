Return-Path: <linux-kernel+bounces-163411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2398B6A79
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2252823E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8266C1802E;
	Tue, 30 Apr 2024 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYZWplE3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14518021;
	Tue, 30 Apr 2024 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714458294; cv=none; b=LAzBM6SWzo1IdI64YEOWlwFixI0NSr8w4JxnHr7Ff8fPlACA+sv9xuzqqMs6rv2QChR137EDbp8naaz5eWDgdkg9BlRkn/Z7hQffwrLsgM3+cffAZ+K0PfpdJF5EUqHIwbwkp3ZUUMP1KSyRdBKInRAyx6pbMFFm074CeuCxpeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714458294; c=relaxed/simple;
	bh=lYq2YjrgXD19AA/qGCviPvMvBN72Bfk/O8Q/nxN9Cpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrvuLUme6ZLfXXECUJWW2R2ezBuz1akeikQ72CMerMUf+48c2icdVIn93O787BbKlVRD+GufTHlzP+LupckbMC12Q87idAv3HluGtPuKdIWc6erVIjAAd9+/VR6Ryt6mSStdPxY12Par6y4zuaXMJZHvfyhhpi+SbE2w1DfToxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYZWplE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB95C2BBFC;
	Tue, 30 Apr 2024 06:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714458294;
	bh=lYq2YjrgXD19AA/qGCviPvMvBN72Bfk/O8Q/nxN9Cpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sYZWplE3toQd0WjpvaHyvmgWbUuS45ujbVAw6fryoi9c0A2/j5ka/SE7wJhPUlcoU
	 DnaRLFlYwJxY56QKgeTHNCIrZ/GgyyLCYjwb/G/f9Wb0pqQ1YUfH6F15g+0HtgmmLc
	 +0FBbASsFzGsAFcbz/NzoKlw5lK3ybDJbEGvbxxmn2uz4eMCR7GXSVLQeDE+Xu/H38
	 78raWYfnZCyiJzYd3NR8YFLmEktLGKFmEvYCDkH92w3Vfj+JYalZHYeG0y4fwkifG6
	 EDRSuptsqrj/wBYg4uiBz0fnzW/Fga5sT1ylhFdNzHnlclB4YekWVou4wdpSYRFPcP
	 vCuaG+y/uXgDQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s1gv8-000000000tj-1HOy;
	Tue, 30 Apr 2024 08:24:55 +0200
Date: Tue, 30 Apr 2024 08:24:54 +0200
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH v16 2/2] arm64: dts: qcom: sa8295p: Enable tertiary
 controller and its 4 USB ports
Message-ID: <ZjCOtjSnV4NBJVsx@hovoldconsulting.com>
References: <20240429162048.2133512-1-quic_kriskura@quicinc.com>
 <20240429162048.2133512-3-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429162048.2133512-3-quic_kriskura@quicinc.com>

On Mon, Apr 29, 2024 at 09:50:48PM +0530, Krishna Kurapati wrote:
> Multiport USB controller (host-only) of SA8295 ADP has 4 Type-A ports
> exposed for connecting peripherals. The VBUS to these peripherals is
> provided by TPS2559QWDRCTQ1 regulators connected to these ports. Each
> regulator has an enable pin controlled by PMM8540. Since these regulators
> are GPIO controlled regulators, model them as fixed regulators and keep
> them Always-On at boot since we are wakeup capable and we don't need to
> turn them off on suspend.

This does not follow from the fact that the controller is wakeup
capable. What matters is if user space has enabled wakeup from suspend
or not.

Perhaps the driver cannot handle vbus regulators currently and that's
why you do things this way, but the commit message here should at least
be updated to reflect that.

> Also since we don't enter device mode, these
> regulators can be kept on.

Not sure this is needed. You already mentioned that the controller is
host-only above.

Johan

