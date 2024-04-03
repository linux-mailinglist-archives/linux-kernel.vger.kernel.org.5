Return-Path: <linux-kernel+bounces-129193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A95E8966C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5537228BA86
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28406CDD3;
	Wed,  3 Apr 2024 07:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKSs+eoj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE060EEB;
	Wed,  3 Apr 2024 07:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130003; cv=none; b=dLLHcB7+LoCsApc1SqISgEDlt3S/OPMo+uMG0seMh6cOk/QTR1dYN3GnwxmQ2K2rvJeUMQ+IWXB/nlo85yHO4b4Xq0jOdknanBjud7AQWimNd6kKBWc6U3B3SInHcoXaw14KYVarbEK1ykSuajjatBjILeb7SMCatEBfYhMMKkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130003; c=relaxed/simple;
	bh=ZVuJ6DGjv1sZfHRwIyRI/Qoz7UcZnpUAHZwbGFBWWpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxPsPhkB4cdQf7KaZrDCVIQdTr9WdwwSQaaoCwH0y1g496b0804K6j5dVDruTMBcL/kuX1RZkBGZyiECnlL0xUnDLwCKGJ4x5CnMb7wmnUKxibTtUXTck2+UacVqWAnqafU2SL8H9ZDR6UlvQ+piFR0iCQposZxjBOeX7gLtYc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKSs+eoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFA3C433C7;
	Wed,  3 Apr 2024 07:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712130002;
	bh=ZVuJ6DGjv1sZfHRwIyRI/Qoz7UcZnpUAHZwbGFBWWpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZKSs+eojw30+iv8jtyH8H+tBv0GCsmew07o8sznbIlDdt0Lo/4GXs34wVndt7veLt
	 VQS9bIOt1cSBD5l1oPXWySWz5QDQ0XA6vSWhr/IOPo8XidBMCA8iexXuT3jR1PMTZt
	 Y6R2kIbaboTOleIvQLQ4y0AJ03G83QI4pm6r+0NNe2jVANOpiWMHQgAXCxgomAhF+E
	 xB+NWedHk0pGzZ0tdSLR1eR3mvwL5EzltGTndLJfNF00NcyODihzPF+2Mm7dFYxAhI
	 9+YT3O+OCwpZL6Kp6N21eBYtP7H1t6RUujC+eHdJJT60Zp9Wrd/4PY+3l3M0YzhSiD
	 ZDYLouwkCXVlg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rrvE2-000000007dw-1iYO;
	Wed, 03 Apr 2024 09:40:03 +0200
Date: Wed, 3 Apr 2024 09:40:02 +0200
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
	"quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v18 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <Zg0H0kZrk1lVaNZX@hovoldconsulting.com>
References: <20240326113253.3010447-1-quic_kriskura@quicinc.com>
 <20240326113253.3010447-3-quic_kriskura@quicinc.com>
 <20240402233218.5kngtj56qellnrmo@synopsys.com>
 <39010f95-b08f-4a57-b3af-f34eb1069865@quicinc.com>
 <Zgz_3AspRRfYqOwZ@hovoldconsulting.com>
 <c30811e6-2a1e-4b26-8b94-7c67000b8568@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c30811e6-2a1e-4b26-8b94-7c67000b8568@quicinc.com>

On Wed, Apr 03, 2024 at 01:03:21PM +0530, Krishna Kurapati PSSNV wrote:
> On 4/3/2024 12:36 PM, Johan Hovold wrote:

> > The series has not been merged yet so you can address both issues in a
> > v19. Perhaps wait a day or two in case Thinh has further comments.

> Also after making the following two changes:
> 
> 1. Rename dwc3_read_port_info(...) to dwc3_get_num_ports(...)
> 2. Changing "if (IS_ERR(base))" to "if (!base)"
>
> Can I still retain your RB tag ?

Yes, please do.

Johan

