Return-Path: <linux-kernel+bounces-128159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C9989570F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F132285801
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22241332B2;
	Tue,  2 Apr 2024 14:36:30 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B24B12C52C;
	Tue,  2 Apr 2024 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068590; cv=none; b=jyTcjDXSy5z2AAYaheKBtqNduP6oYei0VTWMPBcXp9HFS349sBMO53m3XqB6Uw34If3/WXrgi/Au7fegLzGdq+2NQZKmZlnKxQbySU63NQYv4V2Dm/nnMKPP6ixEexBPx2DwRz6sxkpc5Ap0rSX+o148BZ9eVlZzhba0wTPl/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068590; c=relaxed/simple;
	bh=VyO/g5EMsSMNooFA+4a16rpT6xImDeimmmSJAcH6rQ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c+pqciUm1WdXAxr45dD9V6Z8EWxf51GCV0gx/uHPycuIAQRnECpag791h1Z4Pr+ObGnDOiCDJLyb8v7ZNE7NMVkl7Faml7w5a5K1D1lsp8NifJyrL4fHAWTLfQQrCJJFTKYyx1KauHvgy4UEbZ0VgKSyhSnw5+TwHoERwVrIsFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b69867.dsl.pool.telekom.hu [::ffff:81.182.152.103])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000064F1F.00000000660C17E8.00252CB9; Tue, 02 Apr 2024 16:36:24 +0200
Message-ID: <5864594aa47ecfeb23d5d05a3afc02393f84b44e.camel@irl.hu>
Subject: Re: [PATCH 1/3] dt-bindings: leds: add LED_FUNCTION_FNLOCK
From: Gergo Koteles <soyer@irl.hu>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
  Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
  Conor Dooley <conor+dt@kernel.org>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
  devicetree@vger.kernel.org
Date: Tue, 02 Apr 2024 16:36:24 +0200
In-Reply-To: <6b47886e-09ac-4cb9-ab53-ca64f5320005@linaro.org>
References: <cover.1712063200.git.soyer@irl.hu>
	 <8ac95e85a53dc0b8cce1e27fc1cab6d19221543b.1712063200.git.soyer@irl.hu>
	 <6b47886e-09ac-4cb9-ab53-ca64f5320005@linaro.org>
Autocrypt: addr=soyer@irl.hu; prefer-encrypt=mutual;
 keydata=mDMEZgeDQBYJKwYBBAHaRw8BAQdAD5oxV6MHkjzSfQL2O8VsPW3rSUeCHfbx/a6Yfj3NUnS0HEdlcmdvIEtvdGVsZXMgPHNveWVyQGlybC5odT6ImQQTFgoAQRYhBLSYvEYEgjzzEMQCqgtEJzXf/1IRBQJmB4NAAhsDBQkFo5qABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEAtEJzXf/1IRmdYA/0bE1BX7zOGKBgCa1DwzH2UHXawSKLpptADvI/ao6OOtAP4+wYgpR0kWR28lhmkRTpzG/+8GiMWsT60SV2bz9B7sCbg4BGYHg0ASCisGAQQBl1UBBQEBB0CPo8ow/E97WYtaek9EsLXvsvwpBsjWLq5mMOgJL/ukCwMBCAeIfgQYFgoAJhYhBLSYvEYEgjzzEMQCqgtEJzXf/1IRBQJmB4NAAhsMBQkFo5qAAAoJEAtEJzXf/1IRklEA/ipTfAI/onzNwZIp9sCdnt0bLhR5Oz8RD/FpbrJV1v7eAP0c/C6NQPDPWbQpobBR0pf1eTjWXjjr1fj2jxSvWbMRCw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,

On Tue, 2024-04-02 at 15:55 +0200, Krzysztof Kozlowski wrote:
>=20
> Do we really need to define all these possible LED functions? Please
> link to DTS user for this.
>=20

I think for userspace it's easier to support an LED with a specified
name than to use various sysfs attributes. LED devices are easy to find
because they available are in the /sys/class/leds/ directory.
So I think it's a good thing to define LED names somewhere.

J Luke missed this LED from /sys/class/leds/, that's where the idea
came from. The scrollock, numlock, capslock and kbd_backlight LEDs are
already exported.

https://github.com/tomsom/yoga-linux/issues/58#issuecomment-2029926094

Best regards,
Gergo


