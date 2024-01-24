Return-Path: <linux-kernel+bounces-36977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F11F083A9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A927D282215
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2253F6312A;
	Wed, 24 Jan 2024 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h42o9JiL"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2836310F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099371; cv=none; b=h/bPecYNXUbyxGpFQrNsQQ96s5TH183y2sPTSo8K5T9B7BPbuEOUQ9jV1BVrLSszKnKCxSriJ/gLnwjOCxrGB4F+IGqM4laQRFgHJedDhVsVnPEgK5SwXEYYjz7BLjN/YBIDTeudQH7qpMpkljSstTaHjzRx1v7XItcsQBMev4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099371; c=relaxed/simple;
	bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZJl0WNjocDjQufCRbYiM80i6xuVb4KFTaqe+uSdrLVs/3f2x4UUGFTU2oBanhoBwPOW4Nv8a0L0pt4G30EC7Hm8r95sLyPDim/kWzhkcpBpkN6VQJeHAY0/npYj2H9suTJQeW2TeN7CLZXDwOX5sRZBhpafLzlHQQybQma1Ghuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h42o9JiL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6dda0e3600aso312884b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706099369; x=1706704169; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=h42o9JiLhHuFEQ5xbQyAMuK41x2WnLTYrf9MPtyN6SRPz4mgFjYFJjqythRK/i0qQu
         nOD0eAN8sO7eL/ckYIeCyVcMS/thNsQ+FQZuBiAf1njcXLP6fD4IYaj+HzCUzvM+D0LC
         j0gPhT/TM0jAAl/Lz8SnEKNb8uCtIlHIprs9SHadU1ie4cs8PV0D90msUeO5gm/2OKHZ
         KFn5Wk9lGZ8psxz93VoiwmDn/kV0rkH14OHBhwh8+CwA0D2forfOw1aDzOvDbfKnIdrX
         3e31S+fpV0MyCTossg0GRzWEE4rYZLky6wUFP9/hMl3+dh0UIeqlTQaMYpZwJEwg+9dF
         EgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706099369; x=1706704169;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=SUAjVqY2JdQnmbGvn9I7wC0LrfSO9OHWlxgi2Yqjo4KrIuOa25YxUT8gu1x8GFkhWT
         EEH5B6LOxOtMxXMP5bOZEFUZBE2gR1m0Ss8oiW3TYgU3uLtMGSdUEbqJ3Bjev+c4djR2
         qW1h6Z1kYriRU+uLWntrY3NGf14kp1fm8N7fYQ54n2yOqoNsKySLEuA8CxxzRuF7aBP0
         21+SFo1l6/qVYnTna3mXRyM8uU3F5X6Kb+V4Ne/yYUC/1aYaUQota1p9t0hmd3lPmAoq
         QfULwVaGL9OMB3p2PVGDNt/jdhRUOzwZIJslQg9aehFzvIPD5v9sl9s74fL3HbmmI6T7
         7FCg==
X-Gm-Message-State: AOJu0YyXP2WHUEi61BU20v15qXdAtdVK+CQ6YY6VIgWifoSjJzAkmgB/
	SGMKydtC90FIUYCO7lfJAx10/UN0DLhPLgsrUxk4Zbe46Q9LowW/hMz/DXzpPArCdncDNFtTlbI
	guQ/rW0sP9LuZCh5pBH4kMrmGGdvcQ9qkpaY=
X-Google-Smtp-Source: AGHT+IHmzDmnCXRj1AfyGmm3SQ3NC/vzEZGKlKxvHJXfvcCed+ngNmUW8FpVuvatpr1reyK4GDC6sYy7OZ1izrgNsPc=
X-Received: by 2002:aa7:88d3:0:b0:6db:d223:1167 with SMTP id
 k19-20020aa788d3000000b006dbd2231167mr8543284pff.2.1706099369457; Wed, 24 Jan
 2024 04:29:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5p2o5pil5Yip?= <z0node@gmail.com>
Date: Wed, 24 Jan 2024 20:29:18 +0800
Message-ID: <CAGDYfxAwr3g0HMvRi=SJk-VV8Hy6jF+83NhyAZzse-J1Su63kA@mail.gmail.com>
Subject: unsubscribe linux-kernel
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

unsubscribe linux-kernel

