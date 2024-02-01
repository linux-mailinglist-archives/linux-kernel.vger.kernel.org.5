Return-Path: <linux-kernel+bounces-48949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3167846380
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EAA728F713
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C8B4120F;
	Thu,  1 Feb 2024 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nV42FT9k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CDF405DB;
	Thu,  1 Feb 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826978; cv=none; b=Nl+MH0d9VUIhVuhh21vshohOMlipyyvyR6MLlRuDWcQFF5x+CfrtuIBeduhbcazZ+xYHX7R7qoHA9p0Y8Nl8yeRD4JUKL7rYTGbCGAjVNdbXGP4hSOngIazHc6S+reutV1JlPNXOc0YArzKT7DWTZ+tsLyYWLN+AOT4rZamwsQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826978; c=relaxed/simple;
	bh=xeqyaatnEraCZ26CZitiT3fDyTSc0Y5yG9m/ZQcicx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3C311F9yfS5bM7lUN3lFzqTQK69whR/WFob/Whck8OJxliC3nSiBS1A74Ef79Hu8oQSlP5S3V/BSfJkgt3AdmskccKKGJxK7Fcoz19eSvBD3angVkcquBw+V4qsJKxiRIfAZW3NtY0Gj6BtBChVJsU1iAR+3o6bEL7iHxt2dgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nV42FT9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0D4C433F1;
	Thu,  1 Feb 2024 22:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706826978;
	bh=xeqyaatnEraCZ26CZitiT3fDyTSc0Y5yG9m/ZQcicx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nV42FT9kp63iE84kO5nAsodc/Ea+/OFYFrpndQnFOYtYvbyN6iSjeKAAHajDcqUZZ
	 6o80losGRkwIzmvBDbWJhHDWjjBl0SfshCb+jyH0dH6rXUu8ioNT6/Z1DbESF5hcIJ
	 bjdJJjDD06cCpVxqKPF973R9xHEWKGJ3+VHtt5JzK64vvmsYqFoEWzjVJxgidsiFQ3
	 qiNf/g+5dVQd9DL9K+RaYbS26a2d+4TLi/+4VzDgqXF2mBxRdKLEddqP6qsDGAu/sp
	 boPJRveXT09ymMOEv+eFIo/SSzuGrWb/Ei3K5ULAPx1Dw1Btk3y792IUFZ3jDKIl95
	 cGPqf9N5FFxow==
Date: Thu, 1 Feb 2024 16:36:15 -0600
From: Rob Herring <robh@kernel.org>
To: Dharma.B@microchip.com
Cc: sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, lee@kernel.org,
	thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
	linux-pwm@vger.kernel.org, Hari.PrasathGE@microchip.com,
	Manikandan.M@microchip.com
Subject: Re: [linux][PATCH v5 0/3] Convert Microchip's HLCDC Text based DT
 bindings to JSON schema
Message-ID: <20240201223615.GA1726520-robh@kernel.org>
References: <20240131033523.577450-1-dharma.b@microchip.com>
 <478cab42-5f30-4fbe-b42d-02d16b81ca11@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <478cab42-5f30-4fbe-b42d-02d16b81ca11@microchip.com>

On Thu, Feb 01, 2024 at 03:38:37AM +0000, Dharma.B@microchip.com wrote:
> Hi Rob,
> 
> On 31/01/24 9:05 am, Dharma B - I70843 wrote:
> > Converted the text bindings to YAML and validated them individually using following commands
> > 
> > $ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/
> > $ make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/
> > 
> > changelogs are available in respective patches.
> > 
> > As Sam suggested I'm sending the PWM binding as it is in this patch series, clean up patch
> > will be sent as separate patch.
> > 
> 
> I would want to know if I can have the examples in display and pwm 
> bindings separately or if I have to delete them from both and have a 
> single, comprehensive example in mfd binding. I'm a little puzzled about 
> this.

The strong preference is 1 complete example in the MFD binding. That 
avoids 2 copies of the same thing, issues with incomplete examples, 
and temporary warnings bisecting the series.

Rob

