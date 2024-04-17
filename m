Return-Path: <linux-kernel+bounces-148783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE8E8A875E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2571C21B21
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C89146D56;
	Wed, 17 Apr 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="P8hrE+gz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E304146D5E;
	Wed, 17 Apr 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367222; cv=none; b=uBlwVeZ/ObezMxJE2Wu7r4WGSIjWIBsOEKqSD3BkH7j6eWBQlZMCekXPH+BuMv6sOSXkQM2QhujaIhPmVnfZc5LudredX6uKEoV3ORzDl0P59ZpTuSY5RSz6xEPP9fONFlen5mscPXoql9e7mNSHlh7dOqsqi5RJWAfGp62NW4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367222; c=relaxed/simple;
	bh=jEmNRf5WdmSCn9d1nQ8mj13loSgpSuoMo6q+ARRPMU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIViigHBdTUAj8QF89Gw66Cx0fznRPo/rfMeKbgC7P7TCnOWUeWxJh0mvs8vGDJG5Uhmjy6bSDEn+FXnhJN5AsfLo9ZhpNDJU2EbPQQ74JCDjORMzygO02sfeBbxN8oxAUVXbdIXZepnuPd9QUs4SFekDlX9sWEKrsotGSN1MFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=P8hrE+gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AE5C32781;
	Wed, 17 Apr 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="P8hrE+gz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713367218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEmNRf5WdmSCn9d1nQ8mj13loSgpSuoMo6q+ARRPMU0=;
	b=P8hrE+gz+5Vmb7w74R4zmbHRa7j2S7bNUhLVfxfGTjZ/ka+CURx6zdurqSWwWcOUMU/glz
	83AM5lZiRJdc32V9ZaUCsEFnAyAlTx5jYT0Am87WwMAZLPd1vKcsBwGk/dIlAFzGWF4dF7
	2FZcJMKZHS0jzhoT894Ov7vAlWW7u1E=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id da6478ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Apr 2024 15:20:18 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-ddaebc9d6c9so5242182276.0;
        Wed, 17 Apr 2024 08:20:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEIzpBHHrJOVydYnQp99LcZ1BCA6QaQa/qR9cmqzoonbKM1SnJj/MJWJ6ttZmOM0GXMZAKuO/6Kqts7tUIE3lfch80gFSPyc2z7e06/nFrK1E4CnY22bKHPp1SVy8BLKVCcODvxgfYffTlalD+Xum4drphPAaiNsheiS9jv6hYmKVMurgkkQ==
X-Gm-Message-State: AOJu0YwspWW4R9wYvf8CUzP95D884i8dpqesLF1ocls0SNZqAF0fP5Mx
	Qlz8gMPLpmUUv6CvWdmKHm288KHjCR27a5C+sNnHEW+5MpQeBtm7VpTsTbmIYXRjSuAB+ZnP5Bh
	ONIg3C5FAu/gSehsv5opBTKDxQ70=
X-Google-Smtp-Source: AGHT+IGFuPJLnyUfwgW4MBwQgxmKUFwnpUfeu0z/FzaD5kkOiCguNLUhh5Cqx6saafSAJtm00sQKMafyEw3NudTjBq4=
X-Received: by 2002:a25:bdd4:0:b0:dcb:be59:25e1 with SMTP id
 g20-20020a25bdd4000000b00dcbbe5925e1mr16536339ybk.30.1713367217279; Wed, 17
 Apr 2024 08:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417104046.27253-1-bchalios@amazon.es> <20240417104046.27253-5-bchalios@amazon.es>
 <a9f1d643-f171-4b41-88c5-bd9bae0f8200@kernel.org> <433a026a-352c-48c1-84cf-e538bb30aad7@amazon.es>
In-Reply-To: <433a026a-352c-48c1-84cf-e538bb30aad7@amazon.es>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 17 Apr 2024 17:20:06 +0200
X-Gmail-Original-Message-ID: <CAHmME9r647g++mOuG7DGz27pwaVKyc-HrbH2Z2nmHXA4ko6h-Q@mail.gmail.com>
Message-ID: <CAHmME9r647g++mOuG7DGz27pwaVKyc-HrbH2Z2nmHXA4ko6h-Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] dt-bindings: rng: Add vmgenid support
To: Babis Chalios <bchalios@amazon.es>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, tytso@mit.edu, olivia@selenic.com, 
	herbert@gondor.apana.org.au, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sudanl@amazon.com, graf@amazon.de, 
	xmarcalx@amazon.co.uk, dwmw@amazon.co.uk, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 5:19=E2=80=AFPM Babis Chalios <bchalios@amazon.es> =
wrote:
> I will re-create the patches with correct authorship, my SoB and the
> Reviewed-by
> tags I had received in previous versions and send a v7.

Please don't bother.

Jason

