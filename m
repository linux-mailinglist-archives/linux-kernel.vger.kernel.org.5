Return-Path: <linux-kernel+bounces-10405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D97581D3FA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 13:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048A61F22450
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 12:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14516D28B;
	Sat, 23 Dec 2023 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=ceggers@gmx.de header.b="mDR2ZasV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B7D262;
	Sat, 23 Dec 2023 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1703333931; x=1703938731; i=ceggers@gmx.de;
	bh=VEzCJnVH1074VdVJy7kEb47npS8xcIImbieIfqQLWMU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=mDR2ZasVlIU7gzWyWlIe1F7zTpV318wcf1yOcz6oXh0GkPLsquBpDySGcxanpfRN
	 apPOIRbiUrKfRR6pq2fuOH213fjC1J+XvMHUUlDEzZiCFBF3vn/JEqm+H0k8EE8PP
	 X4rOjjjcbVmcL+IyPVGpdvYu+1XnDRgu/tV0Coy3QOn2qT62lvkZt3ACVQbaHAlUV
	 ww114CFv9ohmHfdbfmgR6in0lMML1OveYNi0JD0xUAeZ/iI9vG6ovP7T5iZyaKcdb
	 jAF+u5DgJIcprDvjaO2WWvjSRKJ5poql5/OQ6F5iGkqq7dyI4XkAGiZBcjhXrQ30u
	 l6mvAg7Ypc+YNB6fWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from zbook-studio-g3.localnet ([46.183.103.8]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mwwdf-1r5WtO34n5-00yS8X; Sat, 23 Dec 2023 13:18:51 +0100
From: Christian Eggers <ceggers@gmx.de>
To: Christian Eggers <ceggers@arri.de>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH 0/2] iio: light: add support for AMS AS7331
Date: Sat, 23 Dec 2023 13:18:42 +0100
Message-ID: <5750063.DvuYhMxLoT@zbook-studio-g3>
In-Reply-To: <20231220-as7331-v1-0-745b73c27703@gmail.com>
References: <20231220-as7331-v1-0-745b73c27703@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K1:auqFnmGoYgT6FHaZta38ZgyDweJqwORJaO/xbdXdtQ8vcN3suPd
 JomYrsxCaQHMPuRcwyprvh2fLAWv4K4tKViFtwwajO1Iojp6PkX5yRXJxF44XJNQZCRgm3K
 1tx9NfKA46YbmmQZfugxaf+OsCxu7C74S2xVTZQD4bLZUv31XoPjjMjWWLqg6YXd+SoXgJy
 6BmffpE+LK1GIQvMtJxmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u5q51As/go0=;d1nnuU8UUHrrFfstO5AiCkcpDqP
 u5h9cRAVJ8Sk0V2aO7C6Puz8r3NYP72ah/oIRXCSBQwic0dNktkcpMGJwo4fzfYKXHWwfwxRV
 e/Y24/C2PfgJEEEjmgqkgZ0O3XgMjgwzKkVhhW1H6tpVg57VjtMfNCHd/bEKE/utYylPWzYvK
 bjXqNJZtOLqS0EPjt75d4nvTnJCN+vBpJxcV6H4JOwGuef4SQj6uJSxFwEWBB/Lo2TWo+82GG
 8K+fBz4guTC/olc8SJMGdw2FNsgFaNWbWBWhsLlAWtRUN7dRX3U9qiRJ3dY0ro+7x+PVVTFD4
 xivxcEXSbdYZednBIg44aOwddPYPmzcKUL7bVVsRm4QJWQgVgHIzWGszZlBb5pNh6WUA4Ud76
 2OhvaamgBtJ0WaMPLoMiKf1DMkHdrbKyRxcv6VeoUPqn95H+gkq4moVnJM9wDqR6GKVMp8tT6
 hlIv1WbYrjgftYoPABma49zI2zGl/fArOGzAc44hUYPzool1J+PPv95R52FauPWVjpfReifiB
 tX0O4yTZul8XsVIKo1n2G4lC6UgfeBL5g6olIY7BLEIgVtJmxKrSCY2nZmR8hT6WSNpwtjy49
 vF6NtY73GtOMD2dtwISJ4pP9NN7KSob0MF3crAs44q3eTWyTu2z9iFVgrutqaPFG9iNi1uZlf
 TqoeRSQQmJ2W3DXn4wOckMumhELxmt9LhvNObofP7tdINU2/llAXgEsoaUVR7k0gS4wVK7EVy
 8L8fb/4OR6YxG//TvYlWS4KtfRA5esZStDlEgRUWwMej+9i2pHm3ejF+Yt8txL7CaLY3dGzNk
 i/s5cEC1iCM5E+gTYYfdpxNKNOcc592I4z/MTLARG25Mkl9k2A5zf3XdCVsNUWFSFEFFvL4/D
 A0OBERLPW46AQ6x9RjjHz8cnD2rWvCIMC/t43rfnVGRKms6cl/i6TCTlwoojsEuzRzLZ5oABB
 EGhWdtemdxCak8/Pc77vZtPJ6m8RN5WxETC+cSqAXqoGc18b

Am Samstag, 23. Dezember 2023, 11:46:12 CET schrieb Javier Carrasco:
> The AMS AS7331 UV light sensor measures three ultraviolet bands (UVA,
> UVB and UVC, also known as deep UV or DUV) as well as temperature.
>
> This device is practically identical to the AMS AS73211 XYZ True Color
> sensor that is already supported by the iio subsystem, except for the
> photodiodes used to aquire the desired light wavelengths.
>
> In order to reuse code and reduce maintenance load, this series extends
> the AS73211 driver to support the AS7331 as well.
>
> Note that the UVA and UVB light modifiers have not been merged into the
> mainline kernel yet, but they are already available in Greg's char-misc
> git tree which can be found at
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> in the char-misc-next branch.
>
> The original device AS73211 supported by the driver could only be tested
> briefly due to the lack of hardware. Instead, the i2c-stub module has
> been used to make sure that the driver registers the iio device properly
> and the attributes exported to sysfs are correct. Some basic register
> assignments reported the expected intensity scales and in principle
> nothing else should have been affected by the modifications in the code.

I still use the original AS73211, so I can offer testing with it. I am
currently away, I'll do the tests on 2023-12-30 and report the result
then.

>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Javier Carrasco (2):
>       dt-bindings: iio: light: as73211: add support for as7331
>       io: light: as73211: add support for as7331
>
>  .../devicetree/bindings/iio/light/ams,as73211.yaml |   7 +-
>  drivers/iio/light/Kconfig                          |   5 +-
>  drivers/iio/light/as73211.c                        | 146
> +++++++++++++++++---- 3 files changed, 127 insertions(+), 31 deletions(-=
)
> ---
> base-commit: e9215fcca2561b208c78359110ee4009b454f761
> change-id: 20231220-as7331-88a25ceeb66d
>
> Best regards,






