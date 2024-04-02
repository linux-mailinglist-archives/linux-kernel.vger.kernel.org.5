Return-Path: <linux-kernel+bounces-128522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482BA895C00
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4C1DB27F0F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C0E15B547;
	Tue,  2 Apr 2024 18:50:55 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B4385C7D;
	Tue,  2 Apr 2024 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083855; cv=none; b=mfae8P/fO2wtRrTrEFgsIZsImz7E1ejSRNPd71z3SxY78Lx9ZlXgTcBNn5VU5hhJNgRw3nh4tViNNKOEsrCQ5IF1I8fn7oYB+iZ5VUVLPEjWTsUUHlPPpJ87b/9NfPllIQGzZCN5QS9ru+YSUDpNW3j2FjjV48HwIe86bgdfQU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083855; c=relaxed/simple;
	bh=TUyzWxj2ajl/FfM8gNdeHssnPapcfhjQO7iT4o8h1lo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uQAWdGmg3qPN/sTjPcLUzJlmxVetQ5E1OICqkIRAmYV7mxMj/nbF5UmSii3ckdwXYR06dyGNmh+u/1MRXIwmenYBSwUMYguPpRKWVxKDKhiWYDMzf3ZYfBEPrevGRu/E2y1w8CbUjDXuRP6NA70MZnftyccP1/VjpL4Jy/BeSB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b69867.dsl.pool.telekom.hu [::ffff:81.182.152.103])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000066110.00000000660C538A.00253766; Tue, 02 Apr 2024 20:50:49 +0200
Message-ID: <2710283677cf12ca6b826565ec39652f560a43d8.camel@irl.hu>
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
Date: Tue, 02 Apr 2024 20:50:48 +0200
In-Reply-To: <a19688d3-5402-41c0-b10a-131cefed5b91@linaro.org>
References: <cover.1712063200.git.soyer@irl.hu>
	 <8ac95e85a53dc0b8cce1e27fc1cab6d19221543b.1712063200.git.soyer@irl.hu>
	 <6b47886e-09ac-4cb9-ab53-ca64f5320005@linaro.org>
	 <5864594aa47ecfeb23d5d05a3afc02393f84b44e.camel@irl.hu>
	 <a19688d3-5402-41c0-b10a-131cefed5b91@linaro.org>
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

On Tue, 2024-04-02 at 20:08 +0200, Krzysztof Kozlowski wrote:
> On 02/04/2024 16:36, Gergo Koteles wrote:
> > Hi Krzysztof,
> >=20
> > On Tue, 2024-04-02 at 15:55 +0200, Krzysztof Kozlowski wrote:
> > >=20
> > > Do we really need to define all these possible LED functions? Please
> > > link to DTS user for this.
> > >=20
> >=20
> > I think for userspace it's easier to support an LED with a specified
> > name than to use various sysfs attributes. LED devices are easy to find
> > because they available are in the /sys/class/leds/ directory.
> > So I think it's a good thing to define LED names somewhere.
>=20
> You did not add anything for user-space, but DT bindings. We do not keep
> here anything for user-space.
>=20

The LED_FUNCTION_KBD_BACKLIGHT confused me. Ok, this shouldn't be here,
I will remove it from v2.

Thanks,
Gergo


