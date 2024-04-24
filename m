Return-Path: <linux-kernel+bounces-156494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9A08B034D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BB928307B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E771581ED;
	Wed, 24 Apr 2024 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjzRsUt5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1E823CB;
	Wed, 24 Apr 2024 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713944337; cv=none; b=hsIeqFPU1tYcjtcPzE0d7iV2XOugB60MXm9XclbyzAPlHQ18kESRm2SFy0FgelfAOAMgE71a6awIgYQS9UEvxlX2n4QhK0b8/P2C9PKBm6sXwaVDO2ExDBATw5qhgQEwExWg1HL6iVyUTRyI8ocSj7sDbym+UZgwWqO3GYKFoH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713944337; c=relaxed/simple;
	bh=/C6i6shFbHn3gbJ9KAhYAslLBTv6twZor1UQWKrXaHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VthgNnG5pn4PvXPh3VgQC7k1JgLiItztW1aJqvf/6cFwN12yz28jkRQDUdvgAPQ2C/cstn9aLxqsz4U4zxXokvQ5KlB8+dO+A6ukEEXhBOIFxgJEKPQ4JOyxqZTk8BhC3bJ2r3j9pwqfcl3fKx5Q9cU8BY4vLEcU7UBJ64DTG6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjzRsUt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16568C113CE;
	Wed, 24 Apr 2024 07:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713944337;
	bh=/C6i6shFbHn3gbJ9KAhYAslLBTv6twZor1UQWKrXaHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZjzRsUt5QL3grxY+enwgylpbxZVN8mbJ676irHDo7IbqqlETE7BIqOw32zLyErDFC
	 FFD9yyGh9SKWDspgQvnAoqZja+f1wuBpHLDSVitJIluVKtmwtrNjPZNkRU52hLPDuk
	 iLO9ZTpwnOAig3yqayTYSDBNy5jJYZjgYJMPJfpF1YbGRV8wtDWpYx7w1rdbyXFNWS
	 1pYciJDqRKJu9nzy7GmVNfYj8/Uf7jBXg375wYZWOkeNjiuoVafYzrZsG0eF/oEp2D
	 o5m3Ze8X4oDKsb1yPwHocg3MrKls6RBGzKl7JXpfwjZrb23RbneTrn8SGQ2q3z2IfG
	 PunK9EIIM9dbQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rzXDM-000000000eE-34EJ;
	Wed, 24 Apr 2024 09:38:48 +0200
Date: Wed, 24 Apr 2024 09:38:48 +0200
From: Johan Hovold <johan@kernel.org>
To: Steev Klimaszewski <steev@kali.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] HID/arm64: dts: qcom: sc8280xp-x13s: fix touchscreen
 power on
Message-ID: <Zii3CKdRzhHoCcPP@hovoldconsulting.com>
References: <20240423134611.31979-1-johan+linaro@kernel.org>
 <CAKXuJqgJXCHSVcj+acnqauXidAFq0oXaaQTF31+-gSCSHK6cVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXuJqgJXCHSVcj+acnqauXidAFq0oXaaQTF31+-gSCSHK6cVA@mail.gmail.com>

On Tue, Apr 23, 2024 at 02:34:20PM -0500, Steev Klimaszewski wrote:
> On Tue, Apr 23, 2024 at 8:47 AM Johan Hovold <johan+linaro@kernel.org> wrote:

> > Note that my X13s does not have a touchscreen, but I have done partial
> > verification of the implementation using that machine and the sc8280xp
> > CRD reference design. Bjorn has promised to help out with final
> > verification on an X13s with a touchscreen.

> I thought that I'd purchased a Thinkpad X13s without touchscreen, but
> it turns out that I do have one, and since I do, I was able to test
> this patchset, and it works on mine.
> 
> Tested-by: Steev Klimaszewski <steev@kali.org>

Thanks for testing, Steev.

Johan

