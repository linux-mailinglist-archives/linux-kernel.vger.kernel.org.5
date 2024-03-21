Return-Path: <linux-kernel+bounces-109593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1250881B37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D481C20F59
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04B77F8;
	Thu, 21 Mar 2024 02:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yxgPRfK+"
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8EA32;
	Thu, 21 Mar 2024 02:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710988427; cv=none; b=bz0CwnHCAWb0u4ob6PeOh3/UOb2ytls7eiP2BcuOyTUECxaS5/NfC6Djmmn9uSDpod+qhn3Ne0HpU5JGNoyELDAvw+bfWbC1xukEYKBCKYuiEqVI15Dnsev9noXW+BDZaFNYiQHqZBkPtNX2uiI7XsJ53xijQ3YpPwvOenBiwPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710988427; c=relaxed/simple;
	bh=jvqW5/ObhYNyQR5190tjSZW5PQRwEB05b9l2npYOAY4=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=VGdYsftHc+jjQvyfn24pdqx9aL8Pa3z6s2Bgn7fFOA5DyjsnJyjzJX4RJk7gdDjF1jFXhX8X0bowoSZbPnO/ixy35nSYmBRGAeDU7zi8WfJXGncpd42SCpA6Z8Vw08TH6lVmuNW+xQrpa1DW4hbtKT9Efl1voJQ7hmWHZ/KnW+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=yxgPRfK+; arc=none smtp.client-ip=203.205.251.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710988415; bh=jvqW5/ObhYNyQR5190tjSZW5PQRwEB05b9l2npYOAY4=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=yxgPRfK+FNrq4tCAdAOLeLzlw1xvkl9KFC5apelYqfIBZ3rRPO39O1T5Zj+qvLZOq
	 9hwBsIE/FnS51HpNswjCBK5PHAoa5Jw0s46pJAFKen0+EnWFAnshDeXaKmRtLhrshR
	 AupIxWyqLB1jMuqW/BqqdBdysLd14GHg6EYWMNac=
Received: from smtpclient.apple ([2001:da8:c800:d084:14cd:c7c7:b469:b667])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 85E9F09D; Thu, 21 Mar 2024 10:33:30 +0800
X-QQ-mid: xmsmtpt1710988410twwrif0ae
Message-ID: <tencent_A747085CAC18CD10C3C6623E1FC17B6D6707@qq.com>
X-QQ-XMAILINFO: NsEIGfsQmVV+Dqbc2ivggF/lZ/UdgUzvOqAfF0d2M1xQbC0tNPdq2rkhxuJZtn
	 3I13plBmdrPTwK49vfCIhf5mqneFs4uI8B7bqhZvzCzdRD5NWH2Ba7ZVII/givRhetTYQW7W9Dia
	 zM1nclvBU+ZaZ+g2aL+v/k0QDQWig0WDkRm+C5nV3pdfUF3n42lz2TFPE1xmMNgJ8mfaDZyTu6R9
	 UleRlV5/aggffHXMPM6+wqseV0mfZUlAhJXGhD4S+qkey+r/cgN9v3sDtCFlkWxjZiJXVEcEJd9w
	 NBbz8L1BcWDTK3SSa7QXEC3TQtBEaY2oLqtWehpC9Wps1b8USJ8LLup8QUN8BDbfq8gd77EGUXXq
	 nW74LR4XBuokBl1DLX5FS8NnB2oIndfvPcx9OovuQNc/MzurE3jDYiPFF6HRDhPE6aXibbsHjN6x
	 U3mtE2x3XrzMwE8+LeuVt7cVlRBAAu/gwfObye8R5dvsp1GHTWSoMYYr/Ho3dDvQWbZ/MXAqiikB
	 Mlq0YkjEb0aBYGmLbp6GDfaF5/PlpTRANthrOUZG2C4oqRAL+6StbLZCkfvM2hh7wU8Vj3Yom4HT
	 7znOTWOcSIJj5x74HyfkZj4CW45lOjj552xUxB9EYI9The/PiJWEwv1jjh8spIGn5T13tFBJ3U4j
	 5HoLG2850uCmR4566E8XRCBbZUkwZTpjYaFFYD+hXQ0auBZI9lD+YlMETmjSts/Wq2EgKJ9LB8OA
	 pGRv2JpQ2EHlBOyOnGLKxPEQlfUB6tKy3LqyQgmpnZvZooa9cRZ1msUrvnBqZDHJG0cDLpp6n0WM
	 OVvQ06/No/H3q4DvUUL7sMefxKu/nT+oVPsdULwdI8S07UkRLqzcadt2b5NiYHNBtLHYPvxFO7Sm
	 M6+9n0FV0GsFbKs/ylD7wQGiuL6a7S91htfHT0ymxeIHtgQu6bd/BJMU0Bod/LbAgC0oKeDdx9zS
	 11L+h7mFCD4MvP2FWU//ziTRYH8Du4MFAAahups30dLXwh9WxiqunAxq+PgBI0
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v5 5/7] riscv: Kconfig.socs: Split ARCH_CANAAN and
 SOC_CANAAN_K210
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240320-harmful-carpenter-40a7de0f273e@spud>
Date: Thu, 21 Mar 2024 10:33:20 +0800
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Guo Ren <guoren@kernel.org>,
 linux-riscv@lists.infradead.org,
 Damien Le Moal <dlemoal@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 rabenda.cn@gmail.com
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <5BFB8DE5-8B10-49DA-957A-F78CD64042D8@cyyself.name>
References: <tencent_FC10B3C630BE27412FED2547245CBE18D807@qq.com>
 <tencent_6F35FEF31908DE6AEB385AE30AC658863C0A@qq.com>
 <CAJF2gTS1-VQP=gQBx=SoUWsdap153EGOObKVn+2L7=kbP2CqFg@mail.gmail.com>
 <20240306-scowling-mortify-9b427c80e8ab@wendy>
 <tencent_91E604E3B4D51DA37045625242A81B07F909@qq.com>
 <20240320-ideology-pasty-d3aea07cc519@spud>
 <20240320-harmful-carpenter-40a7de0f273e@spud>
To: Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On Mar 21, 2024, at 02:51, Conor Dooley <conor@kernel.org> wrote:
>=20
> On Wed, Mar 20, 2024 at 05:39:14PM +0000, Conor Dooley wrote:
>=20
>> I got a k230 board (the canmv one) so I should be able to test this
>> myself before picking stuff up.
>=20
> I've taken a bit of a look at the "sdk" and appears to be a complete
> mess to a non-chinese speaker like me.
> I know you linked a copy of opensbi to use with this, but do you also
> have a version of U-Boot to use with this that is not riddled with
> crap and will compile with a normal toolchain?
>=20

I don=E2=80=99t have one. But I know Revy (Han Gao) built a u-boot repo
from vendor SDK which is at submodule on
https://github.com/revyos/mkimg-k230 . However, it just apply a huge
diff from vendor SDK to mainline u-boot and can be built from a
standard gcc toolchain.

> I have chanced upon Courmisch's repo that looks significantly more
> usable than whatever Canaan have so I guess I will use that:
> https://code.videolan.org/Courmisch/k230-boot
>=20

Thanks for this hint.

> :)


