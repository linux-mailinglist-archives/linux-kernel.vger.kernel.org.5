Return-Path: <linux-kernel+bounces-123461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D98B8908F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1408B2171E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3527B137C22;
	Thu, 28 Mar 2024 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa+m6+Zi"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0FD13790B;
	Thu, 28 Mar 2024 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653370; cv=none; b=Ck8NfRy25yJNlBOFK4HpJJrsHW9p2hrLC4HEMwMFLmqdd4cs0VOqSv+or8sGU4rDnroeEjhHxWXdjsOXVCokWiFMTBf7XiWmB9zlunZFKP4UCXMdhqysr8YTBCpe6LPENukJhD68Z29YwlLIetNNRtBTKaU52PF2phiaGAy4GuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653370; c=relaxed/simple;
	bh=9Lgv0V7X4JpFVS6gpkChpJio0Trbpgps85IWj8gCbhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfPs51unCTMvjEvkIrvkSV06XFkrDo6Vwruemew/54nRkYXMt69KZEaFAThMPbsAJJEm+xjazGur/dobWRVzJS31U3CMGo/c9g1oI2RLN86qVRLScuykKiaKL79VvCJz+ThJsqBkkFBPaNGvUIQyxvBmA8lkfjQPXhDoATSSAI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wa+m6+Zi; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-690be110d0dso7394056d6.3;
        Thu, 28 Mar 2024 12:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711653368; x=1712258168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Lgv0V7X4JpFVS6gpkChpJio0Trbpgps85IWj8gCbhM=;
        b=Wa+m6+Zit5RrC7da8xkMnqvc2/Xrsij64z+RdqAVBWxLeej+Ti9G6/oDPIn4s4KoqW
         Y4OujmENKNe9IWZ6oAbcWdT3fLvBkgc7JjqARf8n+y6lh2h6SZQp9CWD66HEx1rrt2XN
         iKtTs3OetJxJK4ovYijGFRDXNZj1fDSnL03xT5abbYrVSm4xaI2tK2dzSFvQy1lNwErs
         jLRIuOf5FOmdn7vw9ym+bcVAo9+VkkWfOCpVBXUR3D4MxhXBFoONwxxHH8OZvn1LsbW4
         2flIb5PSVDaol+3UcEPjnNDiB8O1y3cOGa5EI9DqGiBh+6JF38mlYNr4nle9PEUV85P4
         sMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711653368; x=1712258168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Lgv0V7X4JpFVS6gpkChpJio0Trbpgps85IWj8gCbhM=;
        b=CuZyAarqxeu/TOO8gUTkeMh3blM6r6cw0l1ue3Z8BnXrcUMOPlq0R7kiIPTf28pzIp
         q29WVYuONOzGqCGfNhlYRrlBzxzERDpDhI9Yqaj3+Cxt4q6ZwrFOtMju0imzYsNqSvOP
         ldO8IrQeOiXUqcqk76iXfNH8+0ixctU04LeGRI8cQI6s7KhhN0c4f89XZ0o+Vdty6ulb
         WJfWLQJraCVauYZeLzBTv/bqDk9HzHTNde97DCuw31/8YVUCJnbAhalkoGucjTo11QiY
         +CRCwBRBGp+VCLgzcqPzi67hYxfhTLW9r6OmkLRVUa6pUY7HbbJuH/A1SXodWL2hLFEd
         aVDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjkHmrQ7/8kLYCisod/vsV6MqWhbir8C1Bw3KZgd6CWcmtYYekNYDhbaPwcusa3kvXhSOv1oUQT9hCvA4oefR90Kon+9OIam+o/OL2h86OF/sXgynEPd3FOM9eyQoc+e0xJOLr0KY/ew==
X-Gm-Message-State: AOJu0YzOT4vX0c5Z/WC1mGTn1yOiVFdv/EGwOsKejDkCX0gotuxpFm2U
	fgkMOsm3F8gNkseZMMnbn8JH/FUJaMt4KXUVNQxAhRtxv9/lo8RwAlKQKa/yKStiw+zPeBQXRXE
	uIiImX7WVZCsa3UEhjQ7qhnQpkF1vTJ+NCFU=
X-Google-Smtp-Source: AGHT+IGoq/C70EcDddBRk46x0pF+WHP98cR4N2Udzd6XL+evhCo+RhymPI2X1noY93YiN54R+wumOFnJfECgqCxnbZ0=
X-Received: by 2002:a05:6214:2b47:b0:696:5363:7787 with SMTP id
 jy7-20020a0562142b4700b0069653637787mr135402qvb.62.1711653368006; Thu, 28 Mar
 2024 12:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328191205.82295-1-robertcnelson@gmail.com> <20240328191205.82295-2-robertcnelson@gmail.com>
In-Reply-To: <20240328191205.82295-2-robertcnelson@gmail.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Thu, 28 Mar 2024 14:15:41 -0500
Message-ID: <CAOCHtYiSYat771sfx-Pdv59GDUBH_TzqkxUM+BMf0Q7Z0KEC9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: ti: Add k3-j722s-beagley-ai
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Jared McArthur <j-mcarthur@ti.com>, 
	Jason Kridner <jkridner@beagleboard.org>, Deepak Khatri <lorforlinux@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 2:12=E2=80=AFPM Robert Nelson <robertcnelson@gmail.=
com> wrote:
>
> BeagleBoard.org BeagleY-AI is an easy to use, affordable open source
> hardware single board computer based on the Texas Instruments AM67A,
> which features a quad-core 64-bit Arm CPU subsystem, 2 general-purpose
> digital-signal-processors (DSP) and matrix-multiply-accelerators (MMA),
> GPU, vision and deep learning accelerators, and multiple Arm Cortex-R5
> cores for low-power, low-latency GPIO control.
>
> https://beagley-ai.org/
> https://openbeagle.org/beagley-ai/beagley-ai

@Jason Kridner we need this to become public when you are ready ^ ;)

Boot log:

https://gist.github.com/RobertCNelson/9db8ea04848e7ce2ca52c038fab0e1b7

--=20
Robert Nelson
https://rcn-ee.com/

