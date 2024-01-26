Return-Path: <linux-kernel+bounces-40384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7264B83DF53
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC9228C500
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D031EB57;
	Fri, 26 Jan 2024 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6wfEVg+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB271EB24;
	Fri, 26 Jan 2024 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706288181; cv=none; b=io79OOcaTMH4Vs9I1QJR/LWBRrjrS2UPfYZ24MlN7HFscPwzT6MHH997eoxGQowgNs0eBtFYadbU4i73CTlVhmvjr2kxq5O7++k9ZmO9AviQIpoSKp5no2g6OMXe+Jkb0UP92NElPh2NWXG1u0Ftnf7OoOoTSMdYypwbLUgCm3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706288181; c=relaxed/simple;
	bh=QgW0oHQLcFslidWlTpKmmp0JRnttwiUG2ggzqqllD4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdqqXqy7MKnx3eBMrRlY7RTrCn959UAcrpMtTKuTUhl83AGzWeEOBd7P/kZzRNvAQgbO4c6YOw/g1cgE00ggc3OHY53awhW457KT8KuybKS5gl+rV6P7mdsTJ1vCpHLVpVVq9Zz48EGb23VdmdHtbJ7pwGBL0UesuFHwfZ5Sk3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6wfEVg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E6BC433F1;
	Fri, 26 Jan 2024 16:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706288180;
	bh=QgW0oHQLcFslidWlTpKmmp0JRnttwiUG2ggzqqllD4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I6wfEVg+RqhZMarNGzZv9BzRGK154CIxhnolYwjm28YnrnsT72tH73EgWj+ZgfX8i
	 oMF3k2mS1Nn7gQtWpQUSd5W5cq/nsASpEHrUF+OBzuDX/L0mG5sPKku0vxJ/0OPPQh
	 NI6B2LLa8lK/YOVKX8Ff3EEyuFQHd6m8XQyvKr65NMmsl9wbdFWff2wDYmpiqtcOXH
	 1eh8hBEd2QA0UMvMNDW700zAlXeMQGI/Z9ZJDW80MGFo46SPWwraacFonR5oogOqJm
	 wME/SoEgkzBYqCEudcCXBFWrJkVJMC3AurFumhJaaOSKjAopR1GbCBBXz6q6kQr0Qd
	 OerFZ2t/XGYTg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rTPVJ-0000000009d-1j4s;
	Fri, 26 Jan 2024 17:56:33 +0100
Date: Fri, 26 Jan 2024 17:56:33 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sc8280xp-x13s: Fix/enable
 touchscreen
Message-ID: <ZbPkQVrsrYgUpudo@hovoldconsulting.com>
References: <20240126-x13s-touchscreen-v2-0-5374ccc9e10d@quicinc.com>
 <20240126-x13s-touchscreen-v2-2-5374ccc9e10d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-x13s-touchscreen-v2-2-5374ccc9e10d@quicinc.com>

On Fri, Jan 26, 2024 at 08:41:39AM -0800, Bjorn Andersson wrote:
> The failing read-test in __i2c_hid_core_probe() determines that there's
> nothing connected at the documented address of the touchscreen.
> 
> Introduce the 5ms after-power and 200ms after-reset delays found in the
> ACPI tables. Also wire up the reset-gpio, for good measure.

Please amend the commit message so that it reflects the discussion we
just had (e.g. wiring up the reset-gpio is not just for good measure).

Johan

