Return-Path: <linux-kernel+bounces-129019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9797389633E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2EE1F22BB4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02508405F8;
	Wed,  3 Apr 2024 03:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jb3UK6Ti"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE092F24;
	Wed,  3 Apr 2024 03:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712116361; cv=none; b=A8WRe9DdHgjcCr9SBSmY9fCFpC87+KKoIHi0c4zjcsht2+1woyKvhn/h7pn4V3S8FFS/Q7EWRR6aRgtMxQ/awtD7JK4lncdMnWngWBnHW34BwqPhkY3bcPUhXyb3EvvyVtSNpfA7E8RSj5VP/vjzXlBHLrveegk+a/LnlRRRpQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712116361; c=relaxed/simple;
	bh=PwoE5/2+OJ777y4yZEX+NJc4JO1Z5aLB3HY2CoUjqsI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2/JTONvc/p/LjqkLg1hQNAfMx0bLu6iiaDh/Mu1CxOZqX6hyjPyFYPSWHjMKYPjlsm8qYZXIzR6akKs1PcymM1gDCYc98eNXLZjrCVRsjLQvDmlncawUqj0NVMksPCd+Z7swvrgzEQbfo1opCoweAIa1WxrWvwQpLH6MacTJZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jb3UK6Ti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E40EC433F1;
	Wed,  3 Apr 2024 03:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712116360;
	bh=PwoE5/2+OJ777y4yZEX+NJc4JO1Z5aLB3HY2CoUjqsI=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=jb3UK6Ti12Oxvw+mNf9N/1BGv2zEPYaQ/s9kxrRhmog0AKNzgHcQk909mEia6rXmY
	 X1I5s6vEHE+2NuekMkeHPALtoTwA/zGVGZ640VLbElubcQKa0n8xxF0fP13jZvJ/a+
	 wzl26WYsskavWgoZKc5lKBH7kyog5qWz6DoZdt/UoNax2InwqxeWpgYoZv5iAsAK32
	 rqJbIOlZ5vQXhpeD0nM+k1ADYixUgFpnVU6xH6PoDgKtL5xRZUaII6O21XWEKsKUs5
	 IpGS/Hy0r2G6+wbEIyVDJ5dYAbhL7Pmklb8woFjkhef01lR9aoaKYYCKkvFRctlVSl
	 TN6YbuzXNXmWQ==
Date: Tue, 2 Apr 2024 22:52:38 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Umang Chheda <quic_uchheda@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_kamalw@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: qcm6490-idp: Add change to name the
 regulators
Message-ID: <fvep7awia3eqlavh4ksscig4x2yc2szpy2uoi2p6ueofimv5ch@km4aekplcys5>
References: <20240329122940.3649730-1-quic_uchheda@quicinc.com>
 <20240329140534820-0700.eberman@hu-eberman-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329140534820-0700.eberman@hu-eberman-lv.qualcomm.com>

On Fri, Mar 29, 2024 at 02:09:55PM -0700, Elliot Berman wrote:
> Nit: the subject line should be:
> 
> arm64: dts: qcom: qcm6490: Name the regulators
> 

Much cleaner subject, but no longer matches file prefix.

> I don't know if it merits a resend, though.

Yes, please.

Regards,
Bjorn

