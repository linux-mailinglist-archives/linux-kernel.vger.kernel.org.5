Return-Path: <linux-kernel+bounces-152807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A311E8AC487
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F65E28284C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA55482FF;
	Mon, 22 Apr 2024 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBFvV+1y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28593BBCC;
	Mon, 22 Apr 2024 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713768855; cv=none; b=ZB8q2B7GvHRvnvLz8HisaiD23cb3kH0ziswf968XiIKRI5Y0lQP3aObbKQXsYeyfVMz86VxBIYKxMhlmqjv4BzbxeKy923ji3k0yAPV/UBx66CUzgm+0CgrJdd5mMxOvEkzgH0Ue9iEphuxeCu6X47uYHrtnkP9ujCRSqrb8c3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713768855; c=relaxed/simple;
	bh=om/RR4Mv4KFVIf8LALOHYcGYguNPcr07JI674dheUTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0fEA2I7hpJHkGOHHB93yIaP1+TPGGHdBNW/3I53sXKJxqZi+UHOLjz+7lya3HrJ9wsKtuofGx+RrIILrCrGZpQBp7GQIk9jR1yqePVp1GcbT52xw9UYJ1dHvFKRCxMlGGc6cB0+Lg5IsT1amBHmUcAXu57/wN+QoZfUkh4Vw5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBFvV+1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B89C113CC;
	Mon, 22 Apr 2024 06:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713768855;
	bh=om/RR4Mv4KFVIf8LALOHYcGYguNPcr07JI674dheUTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vBFvV+1yQh00Vx/LHsR4reOehBHTiTDJcg9qynascIzl1CNxaWmpcgtJH+6wN9yku
	 HseWj341tKzq+w0oyrwF9Bk7EXiKTKIeK/DmtpQgICS8BcxdunU+UlLR05d7NeABEr
	 taYHPhT2UPKq21mkjWHGym4IXPBNjpCB8FwWdhlOdpPnQBDY/0eOKSkJpzeRXQDBrH
	 r9oFcbq4VJpVfrPt3QKwgmbf0S0+5Z5MMpLPaTQu8E/EKqflbfWPPrKfhS9b2Qxehx
	 dc02yKsxE0PD2Vzso6XY6p8EBYs9h9gh7ClOXi2NRL7k0si4VgmMfu1MXp/WIjGRkf
	 H1rZgTd2WGHyA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rynZ2-000000002MZ-1DRU;
	Mon, 22 Apr 2024 08:54:09 +0200
Date: Mon, 22 Apr 2024 08:54:08 +0200
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com, Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v21 1/9] dt-bindings: usb: Add bindings for multiport
 properties on DWC3 controller
Message-ID: <ZiYJkJsYEdzz_WPO@hovoldconsulting.com>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
 <20240420044901.884098-2-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420044901.884098-2-quic_kriskura@quicinc.com>

On Sat, Apr 20, 2024 at 10:18:53AM +0530, Krishna Kurapati wrote:
> Add bindings to indicate properties required to support multiport
> on Synopsys DWC3 controller.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

