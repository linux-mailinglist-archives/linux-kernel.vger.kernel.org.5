Return-Path: <linux-kernel+bounces-21100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BA08289D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75AF1C2463E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F83A1CD;
	Tue,  9 Jan 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=svenjoac@gmx.de header.b="X0K2KTyP"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B267C3A1BB;
	Tue,  9 Jan 2024 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704817128; x=1705421928; i=svenjoac@gmx.de;
	bh=B/+Ha5JpMzg6agM7IrG0rPrX3mfaoBhM6Vtpb3jWEwY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:In-Reply-To:References:
	 Date;
	b=X0K2KTyPS62ylmGbSD87xnMCyV4Zejoc2jwCY71d15LmUPhbPSpQxc/Q87hSFC5T
	 my8bNkvNLhRIJaFG0SXCJ19k0KT8c3bUZ4A7cTLzMd3PAFpRSW+eZ/lw+ZQx9K+y3
	 KLuXQAun0rHSAkK2Uqo4hQYjAvNEkc6yxIJQdkwko5hDcpBLZt8bGZ6zg5vbO2d8+
	 1pjJC7SAGchplPUpXt600TyGbJX8Am3uo4GTUgSlqZ/1tkp5a4KZHArazkomwdgZw
	 tM7o6AuwgAKOjXgdMSLzvOrdnrW96AS4NFhJgYv2BtBt6qeE8PJUDJQHabhnqWEpy
	 Z0QXOSSEG7aHNHGjaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.203.84.168]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MFsYx-1rOZip0F03-00HPsm; Tue, 09 Jan 2024 17:18:48 +0100
Received: by localhost.localdomain (Postfix, from userid 1000)
	id DE4D08009A; Tue,  9 Jan 2024 17:18:44 +0100 (CET)
From: Sven Joachim <svenjoac@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,  patches@lists.linux.dev,
  linux-kernel@vger.kernel.org,  torvalds@linux-foundation.org,
  akpm@linux-foundation.org,  linux@roeck-us.net,  shuah@kernel.org,
  patches@kernelci.org,  lkft-triage@lists.linaro.org,  pavel@denx.de,
  jonathanh@nvidia.com,  f.fainelli@gmail.com,  sudipm.mukherjee@gmail.com,
  srw@sladewatkins.net,  rwarsow@gmx.de,  conor@kernel.org,
  allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/150] 6.1.72-rc1 review
In-Reply-To: <20240108153511.214254205@linuxfoundation.org> (Greg
	Kroah-Hartman's message of "Mon, 8 Jan 2024 16:34:11 +0100")
References: <20240108153511.214254205@linuxfoundation.org>
Date: Tue, 09 Jan 2024 17:18:44 +0100
Message-ID: <8734v68opn.fsf@turtle.gmx.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:vuuV/hNuzmk/go4Q2AAaiGfuADd+8gijrlWp/dGjXWOyIDFfkw+
 /iIVgzuokg1BT5tQvSW0bvK8CjlXv3ZBXNXLqIPJogklJGOSzAcVEDpxwwZB5f5LOe1IC0e
 M+gndjSeTaIZFqUcl+PoSwh3ylU4DbshefSkACNjfhUqJpWRWCyVyERO2PFFZoxVBucPCow
 nC2f9UtrJxFghfWuR1g9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W+yHFfOa994=;bKCpd+D4k+uaM1cMqBTf7LQTcnd
 0wtxve/VZy5dqDrvZfoSp3I455k+fHN0kGTLZAhE6qcUQOY06Be6CIbfoVf/GgQGW6bEbFDRR
 S1P/MtckF3riEGa2K2A6Q7eYAAqt5IX2oG3x+9f3nA9Fl4mcTp5smQCi6gHowVIIPSDMAsLHR
 FaAbOyesJ206MsaZmyuB4XGmbbJxH89bBBA5WhpGzkd+Cm7c86PWNEcXmKTjehYO/T6BbHf1R
 x0RwIdakO1MMySf5RyYEh+nFSGWnbUWr1TJERwb4Z5KpYev+HMQLfU9b8CypWv77oaPbO61YP
 0P3WTXsrPqZjrCHnOZks+8HSQtbW4M0oRDALxGyfNo+FACdIVTIncJySvO9lJqLbp0AUE5ZD7
 Vymi0/4XLnunCa6qFJC4BrJikH9B4GoVbjJ7UhhOWhet8zggl0J4wJjpJfoUqmpgGznuSI00B
 DPF1yyJzD9gZJKFretjDxawYf2YD8qd2VTmgwEQPpTEub1WbRocMO+6p0+kbAWuBXmcC9RdFZ
 U50khJU8G+/0cubeP6Zhfz3BM7qOngOSeUu5hfkne/F8R8a8Xi0v1i/Afc6TmPcqfx32H/kwt
 REGJoiVbEj4VmAU0xX6lZdFzBxH8whn1vBTW5xy0IXdfMIYO24+dIC0YvZLkF1uiDMxLvPHek
 h7YAPv4A4a7NSF1ewTJwwPJNJJgN6PpC2iagPpttnO+DQlK8ghZCiRP4ummQGYwtXlGq0l/j0
 Yajt+WBMH0RNBTsHFhlLrPgL8C9kBtXKDN3coHYBZ+dMM9cJL5M3qY9SnlbkRIvKGH7/ms+02
 Vo5MBD+8hBrsk+r5sUjcuq6R6Q6LT/eiTMvFONHrDCbvjv0r4QDucMf21MA+4Qg/Lr8NXwAVR
 Ra5B+Esm904TH0iW7WsMNnd+Wr2ey07oAVHxgnLyNwZchqAuXosUGCi9Nn2qPXi0oSqGr7sGD
 Q8gAMLlGBoyKkCpbU2gUw7U7azc=

On 2024-01-08 16:34 +0100, Greg Kroah-Hartman wrote:

> This is the start of the stable review cycle for the 6.1.72 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Works fine for me on x86_64.

Tested-by: Sven Joachim <svenjoac@gmx.de>

Cheers,
       Sven

