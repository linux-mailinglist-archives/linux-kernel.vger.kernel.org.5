Return-Path: <linux-kernel+bounces-27677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC7882F3FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E218288E4A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E0F1CD37;
	Tue, 16 Jan 2024 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="J41U4+BM"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1101D1CD2B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429116; cv=none; b=n+PugVjZUuNxSnnwNB+SOlaHZiQRfXpw72AsXq3Mh0IpQOFmrqRGBZhvBfuToZcP+TEzb/imZNok4DqDWb8qimNFq/9ucMy/EBPlcgjhIsKSZYdA9ew/xpmqNavP3kbCj2RgeauW30S3WQvaFp34/lPhS1ep1OrBbF7giyAZHX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429116; c=relaxed/simple;
	bh=PrPV+IPne0K1/ui0ipzGQFRKiSKSX1kc+OfaOcUmtO0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=QZgtQpNA+yYRdvXQeYyky1VZLdxZ8YxlBCAqTnGq3PVTFJtDVuAWXm3RfxAJDhXVJ27RfCACYB2PVDrO+KcdRIwSJwyfFvGzPmJidGm0XxAlixKhPPz9iguH4VGy2tJOt5uVFeELUiw8vx9j2eMri8eZdVURsJOR84kXkrcbXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=J41U4+BM; arc=none smtp.client-ip=209.85.208.44
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5592d72edecso3112674a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1705429113; x=1706033913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JQvuYVH+1K16FEdRksTVFQVLm5F7cTOcGjXShSf6Fo8=;
        b=J41U4+BM02C1v72liUVrEk3IVFWk3v4k/09hqLHAtm7ofxncvBlWAnxMYLNvGNddoX
         YPEBD6w2VelMv9oMcqfP6MZ/5U4bgQxPmoq306gzuvSknC0o4DRTy/FpUNGZD6vUvg5i
         XeW3W8Y4pEV5HaVnx+PIJrMcqCovQbytBrheWV8FU9ax3H+SEaH5laKRmG71uvIgjG2k
         jXhbqOvYzSdGB/Lig6yYN2f1PpuD8Gd0LbuUpiRnlvkTcqcYIOIkDR/TvuO7G5xEHqSm
         uWI/23G2OC/JqvJxigj6X25MvmVLbrmwCZiYD88LpI+tFIX0PcCQ+cnRfVWENJ1CNlKL
         cJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429113; x=1706033913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQvuYVH+1K16FEdRksTVFQVLm5F7cTOcGjXShSf6Fo8=;
        b=fK4Pot6LtxShC2jSF7IfCieAXPsq9h7mYIHaTDxFu3X0/mo9WKRmHEld2EaZvov9gl
         9ySwj70DG5IVofHZjuvvdwuz1AXsnjDFF4iCv+Kxf/P0AT6mHRgpsE3A7UNhJ9GZJzhP
         vkfOkk3inNbCtJVu2RQ970MISOs4tw9jLhW4jKk1qiMJZvi3WXGtyZ0DJogDG/VG18Dq
         gx1Jj5oRsBGJI4Ka9rMZjOBQjXhM+6sfVhEOsIq4gU7x3IiQGrQpLb7gPP64EMJ/N7qs
         JSsrRpe+2MagDGuDXmL1DiWMwgmuWGMd2Yqgx1mCI6t1DREv4Zz1hrCufpxRwb8F+rA0
         rMdw==
X-Gm-Message-State: AOJu0YwtHvYUkBvDoi0POcJoX+5UIyk1OwPDketP7S4BkVZSbZdiGhIL
	akW8TsHPjiqQ+qoUcgbJUMWdBWOCa3dRDv/jqgrj1LO+qYsF+A==
X-Google-Smtp-Source: AGHT+IGVDGMb6nRHnwkOZipudGexG004cHyDIg6pmFyZVLZUJcJhRb8bBQknt2LAUeCGxUmywSgiyOcE5mWOVnG65lk=
X-Received: by 2002:aa7:c403:0:b0:558:cd07:3d3c with SMTP id
 j3-20020aa7c403000000b00558cd073d3cmr3824295edq.72.1705429112721; Tue, 16 Jan
 2024 10:18:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116115921.804185-1-daniel.lezcano@linaro.org>
 <CYG4WTCOBTG2.11PA7Q4A3H93H@fairphone.com> <5db88d48-4868-49f0-b702-6eea14400e5b@linaro.org>
 <CYG6QOFYOX79.2ROURJ8FK446C@fairphone.com> <70b359c6-f094-4874-b903-1dca07d0db7c@linaro.org>
In-Reply-To: <70b359c6-f094-4874-b903-1dca07d0db7c@linaro.org>
From: Steev Klimaszewski <steev@kali.org>
Date: Tue, 16 Jan 2024 12:18:21 -0600
Message-ID: <CAKXuJqjgXp1ns4fy11XdxRov0Lp5_=8WqmfCQ0qmZj4hCXKaRQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Fix wild reboot during Antutu test
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, andersson@kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Amit Pundir <amit.pundir@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi

Shouldn't the patch subject line be changed?  Reading the git log,
"fix wild reboot during antutu test" doesn't tell me that much;  I
would think something like "Enable thermal mitigation for sdm845 gpu"
might be better for someone reading through the logs later

--steev

